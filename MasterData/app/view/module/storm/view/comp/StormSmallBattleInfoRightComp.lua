local var_0_0 = g.core.config.storm_event_info
local StormSmallBattleInfoRightComp = class("StormSmallBattleInfoRightComp", require("app.fairyGUI.storm.UI_StormSmallBattleInfoRightComp"))
local var_0_2 = g.core.common.GlobalFunc
local var_0_3 = {
	[2] = g.core.const.ConstMgr.LineUpConst.MulTeamType.STORM_2,
	[3] = g.core.const.ConstMgr.LineUpConst.MulTeamType.STORM_3,
	[4] = g.core.const.ConstMgr.LineUpConst.MulTeamType.STORM_4
}

function StormSmallBattleInfoRightComp:ctor()
	self._stormId = 0
	self._cellEventId = 0
	self._eventInfo = nil
	self._mulTeamCount = 0

	self:_initListener()
	self.m_enterTransition:play()

	local var_1_0 = self.m_effUiAudio:getSize()

	self.m_effUiAudio:addEffectSpine({
		name = "eff_ui_dungeon_audio",
		isLoop = true,
		scale = 1,
		x = var_1_0.width / 2,
		y = var_1_0.height / 2
	})
end

function StormSmallBattleInfoRightComp:_initListener()
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattle))
	self.m_lineupBtn:addClickListener(handler(self, self._onClickLineUp))
end

function StormSmallBattleInfoRightComp:_onClickBattle()
	if not self:_checkBattleRes() then
		return
	end

	var_0_2.checkBagBeforeBattle(handler(self, self._startBattle))
end

function StormSmallBattleInfoRightComp:_checkBattleRes()
	if g.core.model.User.bagData:getCountById(self._type, self._value) < self._cost then
		g.core.module.ModuleManager:tip(g.core.lang:get(304509))

		return false
	end

	return true
end

function StormSmallBattleInfoRightComp:_startBattle()
	if not self._isMul then
		g.core.network.GameNetProxy:send_C2S_Storm_ChallengeBegin({
			storm_id = self._stormId,
			cell_id = self._cellEventId
		})
		self:hideAction()
	else
		self:hideAction()
		g.core.module.ModuleManager:pushModule(g.view.entrance.MULTI_TEAM_LAYER, {
			mulTeamType = var_0_3[self._mulTeamCount],
			tabNum = self._mulTeamCount,
			customData = {
				eventInfo = self._eventInfo,
				stormId = self._stormId,
				cellId = self._cellEventId
			}
		})
	end
end

function StormSmallBattleInfoRightComp:_onClickLineUp()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function StormSmallBattleInfoRightComp:onLoad()
	self:updateCompView()
end

function StormSmallBattleInfoRightComp:updateCompView()
	if not self._eventInfo then
		return
	end

	if self._isMul then
		self.m_lineupBtn:setVisible(false)
	else
		self.m_lineupBtn:setVisible(true)
	end
end

function StormSmallBattleInfoRightComp:_onRcvResetCount()
	self:_updateChallengeState()
end

function StormSmallBattleInfoRightComp:updateComp()
	self:updateView()
end

function StormSmallBattleInfoRightComp:setData(arg_11_1)
	self._stormId = arg_11_1.stormId
	self._cellEventId = arg_11_1.cellEventId
	self._eventInfo = arg_11_1.eventInfo
	self._isMul = arg_11_1.isMul

	if self._isMul then
		while var_0_0.hasKey("event_value" .. 1) do
			if self._eventInfo["event_value" .. 1] > 0 then
				self._mulTeamCount = self._mulTeamCount + 1
			end
		end
	end
end

function StormSmallBattleInfoRightComp:updateView()
	local var_12_0 = g.core.config.knight_info.fetch(tonumber(self._eventInfo.res))

	if not var_12_0 then
		return
	end

	self.m_nameTxt:setText(var_12_0.name)
	self:_initKnightDrawSpine(var_12_0)
	self.m_forceTxt:setText(self._eventInfo.fight_power)
	self.m_descTxt:setText(self._eventInfo.des)
	self:_updateBattleBtnInfo({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_TIRED,
		cost = math.max(self._eventInfo.cost_success, self._eventInfo.cost_fail)
	})
end

function StormSmallBattleInfoRightComp:_initKnightDrawSpine(arg_13_1)
	self.m_knightPicComp:updateKnight({
		scale = 0.9,
		resId = arg_13_1.res_id
	})
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 500, 0), 250)
end

function StormSmallBattleInfoRightComp:_updateBattleBtnInfo(arg_14_1)
	if arg_14_1 then
		self._type = arg_14_1.type or 1
	end

	if arg_14_1 then
		self._value = arg_14_1.value or 1
	end

	if arg_14_1 then
		self._cost = arg_14_1.cost or 1
	end

	self.m_costLoader:setURL((g.core.common.Path:getIconByTypeValue(self._type, self._value, true)))
	self.m_costTxt:setText(self._cost)

	if g.core.model.User.bagData:getCountById(self._type, self._value) < self._cost then
		self.m_costTxt:setColor(g.core.common.Color.top.RED)
	end
end

function StormSmallBattleInfoRightComp:hideAction()
	if self._closed then
		return
	end

	self._closed = true

	self:stopAllFGActions()
	g.core.module.ModuleManager:popModule()
end

return StormSmallBattleInfoRightComp
