local var_0_0 = 0.8
local var_0_1 = g.core.const.ConstMgr.InfoConst
local ShowFactory = require("app.view.module.show.ShowFactory")
local CommonKnight = require("app.view.common.CommonKnight")
local BlitzDungeonResultPop = class("BlitzDungeonResultPop", require("app.fairyGUI.infoPop.UI_BlitzDungeonResultPop"), function()
	return fgui.GComponent:create({
		pkgName = "infoPop",
		isFullScreen = true,
		resName = "BlitzDungeonResultPop"
	})
end)

function BlitzDungeonResultPop:ctor(arg_2_1)
	if arg_2_1 then
		self._num = arg_2_1.num or 1
	end

	if arg_2_1 then
		self._stageId = arg_2_1.stageId or 1
	end

	if arg_2_1 then
		self._acqData = arg_2_1.acqData or {}
	end

	self._needNum = self._acqData.needNum or 0

	if arg_2_1 then
		self._isAdvModule = arg_2_1.isAdvModule or false
	end

	if arg_2_1 then
		self._advPos = arg_2_1.advPos or 0
	end

	if arg_2_1 then
		self._knightSid = arg_2_1.knightSid or 0
	end

	self._blitzType = arg_2_1.type or var_0_1.BlitzType.DUNGEON
	self._autoUse = arg_2_1.autoUse == 1
	self._dropAcqNum = 0
	self._knightExp = 0
	self._roleExp = 0
	self._silver = 0
	self._result = {}
	self._curTime = 0
	self._totalTimes = 0
	self._acqCount = 0
	self._blitzCount = 0
	self._fightCount = 0
	self._isEnough = false
	self._showIdx = 0
	self._showAcq = checkbool(next(self._acqData))
	self._waitState = true

	self:_initAcquireCount()
	self:getView():setSize(display.width, display.height)
	self.m_touchComp:addClickListener(handler(self, self._onClickSpeedUp))
	self.m_backBtn:addClickListener(handler(self, self._onClickBack))
	self:sendBlitzMsg()
	self:_updateAcquireProgComp()

	if self._num > 1 then
		self.m_backBtn:setTitle(g.core.lang:get(300032))
	end

	self:_initBattleUI()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
end

function BlitzDungeonResultPop:onLoad()
	self.m_touchComp:setVisible(false)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_ADVANCEEQUIP, self._onRcvAdvanceEquip, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DUNGEON_FASTCHALLENGESTAGE, self._onRcvBlitz, self)
	self:_initList()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_WAIT)
end

function BlitzDungeonResultPop:_onRcvAdvanceEquip()
	g.core.module.ModuleManager:popComponent()
end

function BlitzDungeonResultPop:_initAcquireCount()
	self._acqCount = next(self._acqData) and g.core.model.User.bagData:getCountById(self._acqData.type, self._acqData.value) or 0
end

function BlitzDungeonResultPop:_updateAcquireProgComp(arg_6_1)
	if self._showAcq then
		arg_6_1 = arg_6_1 or g.core.model.User.bagData:getCountById(self._acqData.type, self._acqData.value)
		self._isEnough = arg_6_1 >= self._needNum
	end

	local var_6_0 = not self._isAdvModule and self._showAcq

	self:setCtrlState("times", {
		index = self._num == 1 and 0 or 1
	})
	self:setCtrlState("type", {
		index = var_6_0 and 1 or 0
	})

	if self._isEnough and self._advPos > 0 and self._knightSid > 0 then
		self:setCtrlState("type", {
			index = 2
		})
	end
end

function BlitzDungeonResultPop:sendBlitzMsg()
	self._diffStamina = g.core.model.User.resourceData:getVit()

	local var_7_0 = {}

	if checkbool(next(self._acqData)) and self._needNum > 0 then
		if self._needNum >= 0 then
			var_7_0 = {
				type = self._acqData.type,
				value = self._acqData.value,
				size = self._needNum
			}
		end
	end

	g.core.network.GameNetProxy:send_C2S_Dungeon_FastChallengeStage({
		id = self._stageId,
		num = self._num,
		award = var_7_0,
		use_items = self._autoUse
	})
end

function BlitzDungeonResultPop:_initList()
	self:_updateItemRenderer()
end

function BlitzDungeonResultPop:_updateItemRenderer()
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
end

function BlitzDungeonResultPop:_onAwardItemRender(arg_10_1, arg_10_2)
	local var_10_0 = {
		isUpIcon = true,
		index = arg_10_1 + 1,
		data = self._result[arg_10_1 + 1],
		blitzCount = arg_10_1 + 1,
		isAnim = self._showIdx < self._totalTimes - 1
	}

	if self._showAcq then
		local var_10_1 = var_10_0.data.drops or {}

		if var_10_1 then
			for iter_10_0, iter_10_1 in ipairs(var_10_1) do
				iter_10_1.effect = iter_10_1.type == self._acqData.type and iter_10_1.value == self._acqData.value
			end
		end
	end

	arg_10_2:update(var_10_0)
end

function BlitzDungeonResultPop:_onRcvBlitz(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3.num <= 0 then
		return
	end

	self.m_awardList:setNumItems(0)

	self._scheduleCount = 0
	self._blitzCount = 0
	self._curTime = 0
	self._knightExp = arg_11_3.knight_add_exp or 0

	local var_11_0 = arg_11_3.num
	local var_11_1 = {}

	if self._blitzType == var_0_1.BlitzType.DUNGEON then
		var_11_1 = clone(arg_11_3.results)
	elseif self._blitzType == var_0_1.BlitzType.BIOGRAPHY then
		var_11_1 = clone(arg_11_3.awards)

		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			self._knightExp = self._knightExp + iter_11_1.knight_exp
			iter_11_1.drops = iter_11_1.finish_drops
		end
	end

	self._blitzCount = self._blitzCount + 1
	self._fightCount = arg_11_3.num
	self._dropAcqNum = 0

	if self._diffStamina then
		self._diffStamina = self._diffStamina - g.core.model.User.resourceData:getVit()
	end

	self._roleExp = 0
	self._silver = 0

	self:_updateBtnState(false)

	self._result = {}

	if var_11_0 == 1 then
		self._result[1] = var_11_1[1]
		self._roleExp = var_11_1[1].role_exp or 0
		self._silver = var_11_1[1].silver or 0
	else
		self.m_touchComp:setVisible(true)
		self.m_backBtn:setTitle(g.core.lang:get(300032))

		for iter_11_2 = 1, var_11_0 do
			if var_11_1[iter_11_2] then
				self._result[var_11_1[iter_11_2].index] = var_11_1[iter_11_2]
				self._roleExp = self._roleExp + (var_11_1[iter_11_2].role_exp or 0)
				self._silver = self._silver + (var_11_1[iter_11_2].silver or 0)
			else
				break
			end
		end
	end

	for iter_11_3 = 1, #self._result do
		local var_11_2 = self._result[iter_11_3].drops or {}

		for iter_11_4 = 1, #var_11_2 do
			if self._acqData.type and var_11_2[iter_11_4].type == self._acqData.type then
				self._dropAcqNum = self._dropAcqNum + var_11_2[iter_11_4].size

				break
			end
		end
	end

	self._totalTimes = table.nums(self._result)

	self:cancelAllSchedule()
	self:_updateItemRenderer()
	self:newScheduleOnce(handler(self, self._startFight), 0.5)
	self:_updateList()
end

function BlitzDungeonResultPop:_updateBtnState(arg_12_1)
	self.m_backBtn:setTouchable(arg_12_1)
	self.m_popPanel:getChild("closeBtn"):setVisible(arg_12_1)
end

function BlitzDungeonResultPop:_checkRebelState()
	local var_13_0 = g.core.model.User.rebelData:getNewestRebelElem()
	local var_13_1

	if var_13_0 and g.core.model.User.rebelData:isTodayNotify() then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.function.DungeonFindHostPop").new(var_13_0)))

		var_13_1 = g.core.model.User.goldSavingData:getHasNewGameId()
	end

	if not g.core.model.User.goldSavingData:isIgnoreTodayTip() and var_13_1 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.function.GoldSavingTickPop").new({
			id = var_13_1
		}), {
			blackOpacity = 0
		})
	end
end

function BlitzDungeonResultPop:_onClickBack()
	if self._attackerKnight then
		self._attackerKnight:setVisible(false)
	end

	if self._defenderKnight then
		self._defenderKnight:setVisible(false)
	end

	if self._isEnough and self._advPos > 0 and self._knightSid > 0 then
		if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_ADVANCE) then
			return
		end
	elseif self._showAcq and not self._isAdvModule then
		g.core.module.ModuleManager:popAllPopup()
	else
		g.core.module.ModuleManager:popComponent({
			popScene = false
		})
	end
end

function BlitzDungeonResultPop:_onClickSpeedUp()
	self:_onScrollViewEnd()
end

function BlitzDungeonResultPop:receiveCompEvent(arg_16_1, arg_16_2)
	if arg_16_1 == "txt_pop_ok" then
		if arg_16_2 and arg_16_2.flag == "dungeonReset" then
			g.core.network.GameNetProxy:send_C2S_Dungeon_ResetChallengeCount({
				id = self._stageId
			})
		end
	elseif arg_16_1 == "rebel_appear_pop_cancel" then
		return false
	end
end

function BlitzDungeonResultPop:onUnload()
	if self._attackerKnight then
		self._attackerKnight:dispose()

		self._attackerKnight = nil
	end

	if self._defenderKnight then
		self._defenderKnight:dispose()

		self._defenderKnight = nil
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MOP_UP_POP_CLOSE)

	if self._waitState then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitState = false
	end
end

function BlitzDungeonResultPop:_updateList()
	self._showIdx = 1

	self.m_awardList:setNumItems(self._totalTimes)
	self.m_awardList:transitionShowCells("enter_left", var_0_0, 1)
	self:newScheduleOnce(handler(self, self._onScrollView), var_0_0 * 2)
end

function BlitzDungeonResultPop:_onScrollView()
	print("DungeonResultPop:_onScrollView")
	print(self._showIdx)

	if self._showIdx >= self._totalTimes - 1 then
		self:_onScrollViewEnd()

		return
	end

	self._showIdx = self._showIdx + 1

	self.m_awardList:scrollToView(self._showIdx, false)
	self:newScheduleOnce(handler(self, self._onScrollView), var_0_0)
end

function BlitzDungeonResultPop:_onScrollViewEnd()
	self.m_touchComp:setVisible(false)
	self:cancelAllSchedule()

	self._showIdx = self._totalTimes

	self.m_backBtn:setTitle(g.core.lang:get(300033))
	self.m_isShowEndController:setSelectedIndex(1)
	self:_updateEndComp()
	self:runFGAction((fgui.FSequence:create({
		fgui.FDelayTime:create(0.4),
		fgui.FCallFunc:create(handler(self, function()
			self:_updateBtnState(true)
			self:_checkRebelState()
			self.m_awardList:scrollToView(self._totalTimes - 1, false)
		end))
	})))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_DUNGEON_BLITZ_FINISH, false)

	if g.core.model.User:isLevelUp() then
		if self._diffStamina then
			local var_20_1 = {
				dungeonBlitz = {
					popScene = false,
					diff = g.core.model.User.resourceData:getVit() - (g.core.config.dungeon_stage_info.get(self._stageId).cost * self._totalTimes - self._diffStamina)
				}
			}

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
				showNow = true,
				frontShow = {
					{
						flag = "levelUp",
						func = function()
							return ShowFactory:showLevelUp(false, var_20_1.diff)
						end
					}
				}
			})
		else
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
end

function BlitzDungeonResultPop:_updateEndComp()
	if self._showAcq then
		local var_24_0 = self._acqData.needNum
		local var_24_1

		if self._acqData.needNum == 0 then
			var_24_0 = self._dropAcqNum
			var_24_1 = {}
		end

		var_24_1.acqData = {
			type = self._acqData.type,
			value = self._acqData.value,
			size = self._dropAcqNum,
			numCost = var_24_0
		}

		self.m_endComp:update(var_24_1)
	else
		self.m_endComp:update({
			roleExp = self._roleExp,
			silver = self._silver,
			result = self._result
		})
	end

	self.m_endComp:setCtrlState("isEnough", {
		index = self._totalTimes < self._num and 0 or 1
	})
end

function BlitzDungeonResultPop:_initBattleUI()
	local var_25_0 = g.core.model.User.knightsData:getMainRoleKnight()[1]:getResInfo()
	local var_25_1 = CommonKnight.new((g.core.model.User.roleSkinData:getWearSpineParams()))

	var_25_1:setScale(1)
	self.m_attackerNode:addChild(var_25_1)

	self._attackerKnight = var_25_1
	self._attackPos = self.m_attackerNode:getPosition()

	local var_25_2 = g.core.config.dungeon_stage_info.get(self._stageId)
	local var_25_3 = CommonKnight.new({
		resId = var_25_2.res
	})

	var_25_3:setScaleX(-1)
	var_25_1:setScaleY(1)
	self.m_defenderNode:addChild(var_25_3)

	self._defenderKnight = var_25_3

	self.m_bgLoader:setURL((self:getGroupBgURL(g.core.config.dungeon_chapter_info.get(var_25_2.chapter_id).group)))

	self._defenderPos = self.m_defenderNode:getPosition()
end

function BlitzDungeonResultPop:_resetBattleUI()
	self.m_attackerNode:setPosition(self._attackPos)
	self.m_defenderNode:setPosition(self._defenderPos)
	self._defenderKnight:setVisible(true)
end

function BlitzDungeonResultPop:getGroupBgURL(arg_27_1)
	local var_27_0 = g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE

	return arg_27_1 == g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO and "pic/base_new/bg_sd_jiaoguo.png" or arg_27_1 == var_27_0.LIN_DONG and "pic/base_new/bg_sd_lindong.png" or arg_27_1 == var_27_0.DONG_XI and "pic/base_new/bg_sd_dongxi.png" or "pic/base_new/bg_sd_lijin.png"
end

function BlitzDungeonResultPop:_startFight()
	self:_resetBattleUI()
	self:_playAttack()
end

function BlitzDungeonResultPop:_playAttack()
	self._attackerKnight:playAction("run")
	self.m_moveFrontTransition:play(handler(self, self._doAttack))
end

function BlitzDungeonResultPop:_doAttack()
	self._attackerKnight:playAction("attack", handler(self, self._moveBack))
end

function BlitzDungeonResultPop:_onDefendHited()
	self._defenderKnight:playAction("hit", handler(self, self._playDefendDead))
end

function BlitzDungeonResultPop:_playDefendDead()
	self._defenderKnight:playAction("dead", handler(self, self._onDefendDeath))
end

function BlitzDungeonResultPop:_onDefendDeath()
	self._defenderKnight:setVisible(false)
end

function BlitzDungeonResultPop:_moveBack()
	self._attackerKnight:playAction("show")
	self:_onDefendHited()
end

function BlitzDungeonResultPop:_fightEnd()
	self._attackerKnight:setFlip(true)
	self._attackerKnight:playAction("idle")
end

return BlitzDungeonResultPop
