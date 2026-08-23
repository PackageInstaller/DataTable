local var_0_0 = g.core.config.dungeon_stage_info
local var_0_1 = g.core.config.knight_base_info
local var_0_2 = g.core.common.GlobalFunc
local var_0_3 = g.core.const.ConstMgr.SpineConst
local var_0_4 = g.core.const.ConstMgr
local var_0_5 = g.core.event.EventManager
local var_0_6 = g.core.event.enum
local var_0_7 = g.core.common.Goods
local var_0_8 = g.core.common.Drops
local var_0_9 = g.core.common.ModuleUnlock
local var_0_10 = g.core.model.User.dungeonData
local var_0_11 = g.core.common.Path
local var_0_12 = g.core.common.Color
local DungeonBattleInfoRightComp = class("DungeonBattleInfoRightComp", require("app.fairyGUI.dungeon.UI_DungeonBattleInfoRightComp"))

function DungeonBattleInfoRightComp:ctor()
	var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_WAIT)

	self._wait = true

	self:_initListener()

	local var_1_0 = self.m_effUiAudio:getSize()

	self.m_effUiAudio:addEffectSpine({
		scale = 1,
		isLoop = true,
		name = "eff_ui_dungeon_audio",
		x = var_1_0.width / 2,
		y = var_1_0.height / 2
	})
end

function DungeonBattleInfoRightComp:_initListener()
	self.m_awardList:setVirtual()
	self.m_awardList:setScrollLimit(true)
	self.m_awardList:setItemRenderer(handler(self, self._awardListItemRender))
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattle))
	self.m_battleTenBtn:addClickListener(handler(self, self._onClickBlitzTen))
	self.m_lineupBtn:addClickListener(handler(self, self._onClickLineUp))
end

function DungeonBattleInfoRightComp:_awardListItemRender(arg_3_1, arg_3_2)
	self._goodsArr[arg_3_1 + 1].showInfo = true

	if self._goodsArr[arg_3_1 + 1].holiday_extra_type and self._goodsArr[arg_3_1 + 1].holiday_extra_type ~= 0 then
		self._goodsArr[arg_3_1 + 1].rightTxt = self._goodsArr[arg_3_1 + 1].mark
	end

	arg_3_2:updateIcon(self._goodsArr[arg_3_1 + 1])
end

function DungeonBattleInfoRightComp:_onClickBattle()
	if self:_checkBattleRes() then
		var_0_2.checkBagBeforeBattle(handler(self, self._onRequestBattle))
	end
end

function DungeonBattleInfoRightComp:_checkBattleRes()
	if g.core.model.User.resourceData:getVit() < var_0_0.get(self._stageId).cost then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
			type = var_0_7.TYPE_ITEM,
			value = var_0_7.ITEM.TYPE_STAMINA_PILL,
			shopId = g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.STAMINA_PILL
		}), {
			touchDisappear = true
		})

		return false
	end

	return true
end

function DungeonBattleInfoRightComp:_onRequestBattle()
	g.core.network.GameNetProxy:send_C2S_Dungeon_ChallengeStageBegin({
		id = self._stageId
	})
end

function DungeonBattleInfoRightComp:onRecvBattleMsgAndPlayAction(arg_7_1)
	if self._isWaitState then
		self._isWaitState = false

		var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_READY)
	end

	var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_WAIT)

	self._isWaitState = true

	self:setOpaque(true)
	self:setTouchable(false)
	self:getParent():setTouchable(false)
	self.m_backTransition:stop()
	self.m_backTransition:play(handler(self, function()
		g.core.battle.BattleProxy:addDungeonBattleTimeStamp()

		if self._isWaitState then
			var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_READY)

			self._isWaitState = false
		end

		self:dispatchCompEvent("ENTER_BATTLE_CLOSE_BATTLEINFOPOP")
		var_0_5:dispatchEvent(var_0_6.EVENT_DUNGEON_STAGE_TO_BATTLE, false, arg_7_1)
	end))
end

function DungeonBattleInfoRightComp:_onClickBlitzTen()
	if not self:_checkBattleRes() then
		return
	end

	if var_0_9:checkModuleUnlockStatus(var_0_4.FUNCTION_TYPE.DUNGEON_SWEEPING_10) then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BeginSweepPop").new({
			data = clone(self._goodsArr),
			stageId = self._stageId
		}))
	end
end

function DungeonBattleInfoRightComp:_onClickLineUp()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function DungeonBattleInfoRightComp:_checkStagePassed(arg_11_1)
	var_0_2.checkBagBeforeBattle(handler(self, function()
		self:dispatchCompEvent("DungeonBattleInfoPop_blitz", {
			stageId = self._stageId,
			num = arg_11_1
		})
	end))
end

function DungeonBattleInfoRightComp:updateComp(arg_13_1)
	self._stageId = arg_13_1

	local var_13_0 = var_0_0.get(self._stageId)
	local var_13_1 = var_0_10:getDisplayVersion()

	self.m_nameTxt:setText((var_13_1 == 1 or nil) and (var_13_0.name or var_13_0["name_" .. var_13_1]))
	self.m_showLineController:setSelectedIndex(var_13_0.talk ~= "" and 1 or 0)
	self.m_monsterTaklTxt:setText(var_13_0.talk)
	self.m_starController:setSelectedIndex((var_0_10:getStageStar(var_13_0.id)))

	self._goodsArr = var_0_8:getGoodsArray(var_13_0.stage_drop)

	table.insertto(self._goodsArr, (self:_getPassAwardGoodsArray({
		var_0_7.RESOURCE.TYPE_EXP,
		var_0_7.RESOURCE.TYPE_COIN,
		var_0_7.RESOURCE.TYPE_KNIGHT_EXP
	})))

	local var_13_2 = g.core.model.User.themeData:getThemeDropByModule(var_0_4.ActivityConst.HOLIDAY_MODULE_TYPE.DUNGEON)

	if var_13_2 then
		local var_13_3 = {}

		table.insertto(var_13_3, var_13_2)
		table.insertto(var_13_3, self._goodsArr)

		self._goodsArr = var_13_3
	end

	self.m_awardList:setNumItems(#self._goodsArr)
	self:_initKnightDrawSpine()
	self:updateChallengeState()
end

function DungeonBattleInfoRightComp:_initKnightDrawSpine()
	local var_14_0 = var_0_0.get(self._stageId)
	local var_14_1 = var_0_10:getDisplayVersion()
	local var_14_2, var_14_3

	if var_14_1 == 1 then
		var_14_2 = var_14_0.res

		if not var_14_0.res then
			var_14_2 = var_14_0["res_" .. var_14_1]
			var_14_3 = {}
		end
	end

	var_14_3.resId = var_0_1.get(var_14_2).id

	self.m_knightPicComp:updateKnight(var_14_3)
	self.m_knightPicComp:setAlphaRect(var_0_3.MASK_TYPE.HORIZON, cc.rect(-250, 0, 500, 0), 250)

	if var_14_0.image_zoom > 0 then
		self.m_knightPicComp:setScale(var_14_0.image_zoom / 1000)
	end

	local var_14_4 = self.m_knightPicComp:getPosition()

	self.m_knightPicComp:setPosition(var_14_4.x + var_14_0.image_X_location, var_14_4.y + var_14_0.image_Y_location)
	self:_updateTrans(var_14_4.x + var_14_0.image_X_location, var_14_4.y + var_14_0.image_Y_location)
	self.m_enterTransition:play(handler(self, self.onAnimEnd))
end

function DungeonBattleInfoRightComp:_updateTrans(arg_15_1, arg_15_2)
	self.m_enterTransition:changeParams({
		pos01 = {
			arg_15_1,
			arg_15_2
		}
	})
	self.m_backTransition:changeParams({
		pos01 = {
			arg_15_1,
			arg_15_2
		}
	})
end

function DungeonBattleInfoRightComp:onAnimEnd()
	if self._wait then
		self._wait = false

		var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_READY)
	end
end

function DungeonBattleInfoRightComp:updateChallengeState()
	local var_17_0 = var_0_0.get(self._stageId)

	self.m_btnController:setSelectedIndex(var_0_10:isStagePassed(self._stageId) and 1 or 0)
	self:_updateBattleBtnInfo({
		value = var_0_7.RESOURCE.TYPE_STAMINA,
		cost = var_17_0.cost
	})
end

function DungeonBattleInfoRightComp:_updateBattleBtnInfo(arg_18_1)
	if arg_18_1 then
		self._type = arg_18_1.type or 1
	end

	if arg_18_1 then
		self._value = arg_18_1.value or 1
	end

	if arg_18_1 then
		self._cost = arg_18_1.cost or 0
	end

	self.m_costLoader:setURL((var_0_11:getIconByTypeValue(self._type, self._value, true)))

	local var_18_0 = var_0_0.get(self._stageId)

	self.m_costTxt:setText(var_18_0.cost)

	if g.core.model.User.bagData:getCountById(self._type, self._value) < var_18_0.cost then
		self.m_costTxt:setColor(var_0_12.top.RED)
	else
		self.m_costTxt:setColor(var_0_12.top.GREEN)
	end
end

function DungeonBattleInfoRightComp:_getPassAwardGoodsArray(arg_19_1)
	local var_19_0 = var_0_0.get(self._stageId)
	local var_19_1 = g.core.config.role_info.get((g.core.model.User:getLevel())).role_get_exp * var_19_0.cost
	local var_19_2 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1 or {}) do
		local var_19_3

		if iter_19_1 == var_0_7.RESOURCE.TYPE_EXP then
			var_19_3 = var_19_1
		elseif iter_19_1 == var_0_7.RESOURCE.TYPE_COIN then
			var_19_3 = var_19_0.reward_tael
		elseif iter_19_1 == var_0_7.RESOURCE.TYPE_KNIGHT_EXP then
			var_19_3 = var_19_0.knight_exp
		end

		if var_19_3 then
			table.insert(var_19_2, {
				type = var_0_7.TYPE_RESOURCE,
				value = iter_19_1,
				size = var_19_3
			})
		end
	end

	return var_19_2
end

function DungeonBattleInfoRightComp:hideAction(arg_20_1)
	var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_WAIT)
	self:setOpaque(true)
	self.m_backTransition:stop()
	self.m_backTransition:play(handler(self, function()
		if arg_20_1 then
			arg_20_1()
		end

		var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_READY)
	end))
end

function DungeonBattleInfoRightComp:onUnload()
	if self._wait then
		self._wait = false

		var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_READY)
	end

	if self._isWaitState then
		var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_READY)

		self._isWaitState = false
	end
end

return DungeonBattleInfoRightComp
