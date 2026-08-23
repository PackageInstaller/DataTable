local ShowFactory = require("app.view.module.show.ShowFactory")
local var_0_1 = 100
local var_0_2 = g.core.common.ServerTime
local var_0_3 = g.core.model.User.bagData
local var_0_4 = g.core.network.GameNetProxy
local CommonKnight = require("app.view.common.CommonKnight")
local var_0_6 = g.core.const.ConstMgr.KNIGHT_CONST.ADVANCE_COMMON_CONVERT_ITEM_ID
local var_0_7 = g.core.common.Goods
local KnightOneKeyAllBlitzPop = class("KnightOneKeyAllBlitzPop", require("app.fairyGUI.knight.UI_KnightOneKeyAllBlitzPop"), function()
	return fgui.GComponent:create({
		pkgName = "knight",
		resName = "KnightOneKeyAllBlitzPop",
		pkgPath = "ui/knight/knight"
	})
end)

function KnightOneKeyAllBlitzPop:ctor(arg_2_1)
	self:showAtCenter()

	self._finishTime = var_0_2:getTime() + g.core.config.parameter_info.get(24033).parameter
	self._isNetFinish = false
	self._isAllFinish = false
	self._needMatList = arg_2_1.needMatData
	self._needItem = arg_2_1.costItemCount > 0 or arg_2_1.needBuyCount > 0
	self._needMatDict = {}
	self._needTick = false

	for iter_2_0, iter_2_1 in ipairs(self._needMatList) do
		self._needMatDict[iter_2_1.matId] = iter_2_1

		if iter_2_1.needMatSize > 100 then
			self._needTick = true
		end
	end

	self._allAwardDict = {}

	self:_initUI(arg_2_1.showStageId)

	self._tick = self:newSchedule(handler(self, self._updateTick), 1)

	self:_updateTick()

	if (arg_2_1.needBuyCount or 0) > 0 then
		var_0_4:send_C2S_Shop_Shopping({
			shop_id = 0,
			cost_idx = 0,
			info = {
				id = g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.STAMINA_PILL,
				num = arg_2_1.needBuyCount
			}
		})
	else
		self:checkNeedSendMat()
	end
end

function KnightOneKeyAllBlitzPop:_updateTick()
	local var_3_0 = self._finishTime - var_0_2:getTime()

	if var_3_0 <= 0 or not self._needTick then
		if self._isNetFinish or var_3_0 <= -5 then
			self:cancelSchedule(self._tick)

			self._tick = nil

			self:updateList()

			self._isAllFinish = true
		else
			self.m_timeTip:setText("")
		end
	else
		self.m_timeTip:setText(g.core.lang:get(405802, {
			time = var_3_0
		}))
	end
end

function KnightOneKeyAllBlitzPop:_initUI(arg_4_1)
	self.m_backBtn:addClickListener(handler(self, self._onClickClose))
	self.m_popPanel:setCloseBtnShow(false)
	self.m_showListController:setSelectedIndex(0)

	local var_4_0 = CommonKnight.new((g.core.model.User.roleSkinData:getWearSpineParams()))

	var_4_0:setScale(1)
	self.m_attackerNode:addChild(var_4_0)

	self._attackerKnight = var_4_0

	local var_4_1 = g.core.config.dungeon_stage_info.get(arg_4_1)
	local var_4_2 = CommonKnight.new({
		resId = var_4_1.res
	})

	var_4_2:setScaleX(-1)
	var_4_0:setScaleY(1)
	self.m_defenderNode:addChild(var_4_2)

	self._defenderKnight = var_4_2

	self.m_bgLoader:setURL((self:getGroupBgURL(g.core.config.dungeon_chapter_info.get(var_4_1.chapter_id).group)))
	self:newScheduleOnce(handler(self, self._playAttack), 0.5)
end

function KnightOneKeyAllBlitzPop:getGroupBgURL(arg_5_1)
	local var_5_0 = g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE

	return arg_5_1 == g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO and "pic/base_new/bg_sd_jiaoguo.png" or arg_5_1 == var_5_0.LIN_DONG and "pic/base_new/bg_sd_lindong.png" or arg_5_1 == var_5_0.DONG_XI and "pic/base_new/bg_sd_dongxi.png" or "pic/base_new/bg_sd_lijin.png"
end

function KnightOneKeyAllBlitzPop:_onClickClose()
	if self._isAllFinish then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function KnightOneKeyAllBlitzPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DUNGEON_FASTCHALLENGESTAGE, self._onFastChallenge, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MATERIAL_EXCHANGE, self._onMaterialExChange, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, self._onShopping, self)
end

function KnightOneKeyAllBlitzPop:_playAttack()
	self._attackerKnight:playAction("run")
	self.m_moveFrontTransition:play(handler(self, self._doAttack))
end

function KnightOneKeyAllBlitzPop:_doAttack()
	self._attackerKnight:playAction("attack", handler(self, self._moveBack))
end

function KnightOneKeyAllBlitzPop:_moveBack()
	self._attackerKnight:playAction("show")
	self:_onDefendHited()
end

function KnightOneKeyAllBlitzPop:_onDefendHited()
	self._defenderKnight:playAction("hit", handler(self, self._playDefendDead))
end

function KnightOneKeyAllBlitzPop:_playDefendDead()
	self._defenderKnight:playAction("dead", handler(self, self._endPlaying))
end

function KnightOneKeyAllBlitzPop:_endPlaying()
	self._defenderKnight:setVisible(false)
	self._attackerKnight:playAction("idle")
end

function KnightOneKeyAllBlitzPop:_onFastChallenge(arg_14_1, arg_14_2, arg_14_3)
	for iter_14_0, iter_14_1 in ipairs(arg_14_3.results or {}) do
		for iter_14_2, iter_14_3 in ipairs(iter_14_1.drops or {}) do
			if iter_14_3.type == var_0_7.TYPE_KNIGHT_ADVANCE and self._needMatDict[iter_14_3.value] then
				self._needMatDict[iter_14_3.value].needMatSize = self._needMatDict[iter_14_3.value].needMatSize - iter_14_3.size
			end

			self:_addAward(iter_14_3)
		end
	end

	self:newScheduleOnce(handler(self, self.checkNeedSendMat), 0.1)
end

function KnightOneKeyAllBlitzPop:_onMaterialExChange(arg_15_1, arg_15_2, arg_15_3)
	if self._needMatDict[arg_15_3.id] then
		self._needMatDict[arg_15_3.id].needMatSize = self._needMatDict[arg_15_3.id].needMatSize - arg_15_3.num
	end

	self:_addAward({
		type = var_0_7.TYPE_KNIGHT_ADVANCE,
		value = arg_15_3.id,
		size = arg_15_3.num
	})
	self:newScheduleOnce(handler(self, self.checkNeedSendMat), 0.1)
end

function KnightOneKeyAllBlitzPop:_onShopping(arg_16_1, arg_16_2, arg_16_3)
	self:newScheduleOnce(handler(self, self.checkNeedSendMat), 0.1)
end

function KnightOneKeyAllBlitzPop:checkNeedSendMat()
	local var_17_0 = var_0_3:getCountById(var_0_7.TYPE_RESOURCE, var_0_7.RESOURCE.TYPE_STAMINA)
	local var_17_1 = var_0_3:getCountById(var_0_7.TYPE_ITEM, var_0_6)

	for iter_17_0, iter_17_1 in ipairs(self._needMatList) do
		if iter_17_1.needMatSize > 0 then
			if math.floor(var_17_0 / iter_17_1.oneMatCostStrength) > 0 then
				g.core.network.GameNetProxy:send_C2S_Dungeon_FastChallengeStage({
					use_items = false,
					id = iter_17_1.stageId,
					num = math.min(var_0_1, iter_17_1.needMatSize),
					award = {
						type = var_0_7.TYPE_KNIGHT_ADVANCE,
						value = iter_17_1.matId,
						size = iter_17_1.needMatSize
					}
				})

				return
			elseif var_17_1 > 0 then
				local var_17_2 = {
					id = iter_17_1.matId
				}

				if var_17_1 > iter_17_1.needMatSize then
					var_17_2.num = iter_17_1.needMatSize or var_17_1
				end

				g.core.network.GameNetProxy:send_C2S_Material_Exchange(var_17_2)

				return
			elseif self._needItem and var_0_3:getOwnNum(var_0_7.TYPE_ITEM, var_0_7.ITEM.TYPE_STAMINA_PILL) > 0 then
				g.core.network.GameNetProxy:send_C2S_Dungeon_FastChallengeStage({
					id = iter_17_1.stageId,
					num = math.min(var_0_1, iter_17_1.needMatSize),
					award = {
						type = var_0_7.TYPE_KNIGHT_ADVANCE,
						value = iter_17_1.matId,
						size = iter_17_1.needMatSize
					},
					use_items = self._needItem
				})

				return
			end
		end
	end

	self._isNetFinish = true
end

function KnightOneKeyAllBlitzPop:updateList()
	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in pairs(self._allAwardDict) do
		for iter_18_2, iter_18_3 in pairs(iter_18_1) do
			local var_18_2 = {
				type = iter_18_0,
				value = iter_18_2,
				size = iter_18_3
			}

			if iter_18_0 == var_0_7.TYPE_KNIGHT_ADVANCE and self._needMatDict[iter_18_2] then
				table.insert(var_18_1, var_18_2)
			else
				table.insert(var_18_0, var_18_2)
			end
		end
	end

	self.m_allAwardComp:showAwards(var_18_0)
	self.m_targetAwardComp:showAwards(var_18_1)
	self.m_showListController:setSelectedIndex(1)
	self.m_popPanel:setCloseBtnShow(true)

	if g.core.model.User:isLevelUp() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "levelUp",
					func = function()
						return ShowFactory:showLevelUp()
					end
				}
			}
		})
	end
end

function KnightOneKeyAllBlitzPop:_addAward(arg_20_1)
	self._allAwardDict[arg_20_1.type] = self._allAwardDict[arg_20_1.type] or {}
	self._allAwardDict[arg_20_1.type][arg_20_1.value] = self._allAwardDict[arg_20_1.type][arg_20_1.value] or 0
	self._allAwardDict[arg_20_1.type][arg_20_1.value] = self._allAwardDict[arg_20_1.type][arg_20_1.value] + arg_20_1.size
end

return KnightOneKeyAllBlitzPop
