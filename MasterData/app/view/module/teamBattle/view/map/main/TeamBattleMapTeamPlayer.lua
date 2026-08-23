local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local var_0_1 = g.core.model.User.teamBattleData
local TeamBattleMapTeamPlayer = class("TeamBattleMapTeamPlayer", require("app.fairyGUI.teamBattle.UI_TeamBattleMapTeamPlayer"))

function TeamBattleMapTeamPlayer:ctor()
	self.m_helpIcon:addClickListener(handler(self, self._onClickHelpIcon))
	self.m_pointAwardBtn:addClickListener(handler(self, self._onClickPointAward))
	self.m_shareAwardBtn:addClickListener(handler(self, self._onClickShareAward))

	self._lastWork = -1
	self._startPosX = self.m_helpIcon:getPosition().x - self.m_helpIcon:getSize().width / 2
	self._playEff = nil
end

function TeamBattleMapTeamPlayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GET, handler(self, self._updateFight), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self._updateFight), self)
	self:_updateFight()
end

function TeamBattleMapTeamPlayer:updateComp(arg_3_1)
	local var_3_0 = {}

	if not arg_3_1 then
		self.m_isEmptyController:setSelectedIndex(1)

		return
	end

	if arg_3_1:isSelf() and self._lastWork > 0 and arg_3_1:getWork() ~= self._lastWork then
		self.m_workComp:playSelectEff()
	end

	self._player = arg_3_1
	self._lastWork = self._player:getWork()

	local var_3_1 = self._player:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER)

	if var_3_1 then
		self.m_icon:updateAsUser(var_3_1)
		self.m_nameText:setText(var_3_1.name)
	end

	self.m_fightText:setText(g.core.lang:get(420655, {
		fight = self._player:getFightValue()
	}))
	self.m_isOnLineController:setSelectedIndex(arg_3_1:getOnLineState())
	self.m_workComp:updateIcon(self._lastWork)

	local var_3_2 = self._player:isSelf()

	if var_3_2 then
		if var_0_1:getFormationData():getMaxFormationFightValue() > arg_3_1:getFightValue() then
			local var_3_3 = {}

			var_3_3.fight = var_0_1:getFormationData():getMaxFormationFightValue()

			self.m_fightText:setText(g.core.lang:get(420655, var_3_3))
		end

		local var_3_4 = self._player:getActionPointAwards()
		local var_3_5 = arg_3_1:getExtData()
		local var_3_6 = var_3_5.awards

		if (not var_3_5.award_action_time or var_3_5.award_action_time == 0) and var_3_4 then
			self.m_pointAwardStateController:setSelectedIndex(1)
		else
			self.m_pointAwardStateController:setSelectedIndex(0)
		end

		if var_3_6 then
			self.m_shareAwardStateController:setSelectedIndex(1)

			var_3_0[#var_3_0 + 1] = self.m_shareAwardBtn
		else
			self.m_shareAwardStateController:setSelectedIndex(0)
		end
	end

	if arg_3_1:getDeBuffId() > 0 then
		if var_3_2 then
			self.m_helpStateController:setSelectedIndex(2)
			self:_onRemoveHelpEffect()
		else
			self.m_helpStateController:setSelectedIndex(1)
			self:_playHelpEffect()
		end

		var_3_0[#var_3_0 + 1] = self.m_helpIcon
	else
		self.m_helpStateController:setSelectedIndex(0)
		self:_onRemoveHelpEffect()
	end

	self.m_isEmptyController:setSelectedIndex(0)
	self:_onLayoutBtn(var_3_0)
end

function TeamBattleMapTeamPlayer:_updateFight()
	if self._player and self._player:isSelf() then
		local var_4_0 = {}

		var_4_0.fight = var_0_1:getFormationData():getMaxFormationFightValue()

		self.m_fightText:setText(g.core.lang:get(420655, var_4_0))
	end
end

function TeamBattleMapTeamPlayer:_onClickHelpIcon()
	local var_5_0 = self.m_helpStateController:getSelectedIndex()
	local var_5_1 = var_0_1:getMapData():getPlayerStruct()

	if var_5_0 == 1 then
		g.core.network.GameNetProxy:send_C2S_TeamBattle_Help({
			target_id = self._player:getPlayerId()
		})
	elseif var_5_0 == 2 then
		self:_showTrapPop()
	end
end

function TeamBattleMapTeamPlayer:_onClickPointAward()
	g.core.network.GameNetProxy:send_C2S_TeamBattle_GetActionAwards({})
end

function TeamBattleMapTeamPlayer:_onClickShareAward()
	g.core.network.GameNetProxy:send_C2S_TeamBattle_GetShareAwards({})
end

function TeamBattleMapTeamPlayer:_showTrapPop()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.teamBattle.view.pop.TeamBattleTrapPop").new({
		buffId = self._player:getDeBuffId()
	}), {
		touchDisappear = true
	})
end

function TeamBattleMapTeamPlayer:_playHelpEffect()
	self._playEff = self._playEff or self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_teamBattle_help",
		isLoop = true
	})
end

function TeamBattleMapTeamPlayer:_onRemoveHelpEffect()
	self.m_eff:removeAllEffect()

	self._playEff = nil
end

function TeamBattleMapTeamPlayer:_onLayoutBtn(arg_11_1)
	local var_11_0 = self._startPosX

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		var_11_0 = var_11_0 + iter_11_1:getSize().width / 2

		local var_11_1 = iter_11_1:getPosition()

		var_11_1.x = var_11_0

		iter_11_1:setPosition(var_11_1)

		var_11_0 = var_11_0 + iter_11_1:getSize().width / 2 + 2
	end
end

return TeamBattleMapTeamPlayer
