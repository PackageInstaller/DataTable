local var_0_0 = g.core.model.User.teamPvpData
local var_0_1 = g.core.const.ConstMgr.TeamPvpConst
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum
local var_0_5 = g.core.module.ModuleManager
local TeamPVPMatchPop = class("TeamPVPMatchPop", require("app.fairyGUI.teamPVP.UI_TeamPVPMatchPop"), function()
	return fgui.GComponent:create({
		resName = "TeamPVPMatchPop",
		pkgPath = "ui/teamPVP/teamPVP",
		pkgName = "teamPVP"
	}, ...)
end)

function TeamPVPMatchPop:ctor(arg_2_1)
	self:showAtCenter()

	self._matchType = arg_2_1.matchType

	self.m_typeController:setSelectedIndex(self._matchType - 1)

	self._cdTime = 0
	self._cdHandler = nil
	self._estimateTime = var_0_0:getMatchEstimateTimeByType(self._matchType)

	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancelBtn))
	self.m_cancelBtn:setVisible(self._matchType == var_0_1.MATCH_TYPE.TEAM or var_0_0:isMyselfCaptain())

	if self._matchType == var_0_1.MATCH_TYPE.TEAM then
		self.m_estimateTime:setText(g.core.lang:get(420446, {
			time = self._estimateTime
		}))
	else
		self.m_estimateTime:setText(g.core.lang:get(420446, {
			time = self._estimateTime
		}))
	end
end

function TeamPVPMatchPop:_updateView()
	if self._matchType == var_0_1.MATCH_TYPE.BATTLE then
		for iter_3_0, iter_3_1 in ipairs((var_0_0:getTeamPlayers())) do
			local var_3_0

			if iter_3_1.battleUser.npc_type == 0 then
				self["m_player" .. 1]:updateMatchHeadComp(iter_3_1)

				var_3_0 = 1 + 1
			end
		end
	end
end

function TeamPVPMatchPop:_onClickCancelBtn()
	if self._matchType == var_0_1.MATCH_TYPE.TEAM then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	else
		var_0_2:send_C2S_GroupBattle_Match({
			tp = 2
		})
	end
end

function TeamPVPMatchPop:_updateCountDown()
	self._cdTime = self._cdTime + 1

	self.m_timeTxt:setText(self._cdTime)

	if self._cdTime == self._estimateTime and self._matchType == var_0_1.MATCH_TYPE.TEAM then
		var_0_5:tip(g.core.lang:get(420406))
		var_0_5:onlyPopSelfByDisplay(self)
	end
end

function TeamPVPMatchPop:_onS2CQuickJoin()
	if var_0_0:getTeamInfo() then
		self:dispatchCompEvent("quick_join_succeed", {
			time = self._cdTime
		})
	end
end

function TeamPVPMatchPop:_onS2CMatch(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3.tp == 1 then
		-- block empty
	else
		self:dispatchCompEvent("restart_auto_kick")
		var_0_5:onlyPopSelfByDisplay(self)
	end
end

function TeamPVPMatchPop:_onS2CMatchFinish(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3.is_success then
		-- block empty
	else
		self:dispatchCompEvent("restart_auto_kick")
		var_0_5:tip(g.core.lang:get(420430))
	end

	var_0_5:onlyPopSelfByDisplay(self)
end

function TeamPVPMatchPop:_onS2CNotifyMatch(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3.tp == 2 then
		self:dispatchCompEvent("restart_auto_kick")
		var_0_5:onlyPopSelfByDisplay(self)
	end
end

function TeamPVPMatchPop:_playEnterAni()
	self.m_enterTransition:setHook("enter", function()
		self.m_matchingDiskComp:playEnterAni()
	end)
	self.m_enterTransition:setHook("loop", function()
		self.m_matchingDiskComp:playTurnAroundAni()
	end)
	self.m_enterTransition:play()
	self.m_effDi:addEffectSpine({
		remove = false,
		name = "eff_ui_peakArena_di",
		isLoop = true
	})
end

function TeamPVPMatchPop:onLoad()
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GROUP_BATTLE_QUICKJOIN, self._onS2CQuickJoin, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GROUP_BATTLE_MATCH, self._onS2CMatch, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYMATCHFINISH, self._onS2CMatchFinish, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYMATCH, self._onS2CNotifyMatch, self)
	self:_updateView()

	if self._matchType == var_0_1.MATCH_TYPE.TEAM then
		var_0_2:send_C2S_GroupBattle_QuickJoin({})
	elseif var_0_0:isMyselfCaptain() then
		var_0_2:send_C2S_GroupBattle_Match({
			tp = 1
		})
	end

	if not self._cdHandler then
		self._cdHandler = self:newSchedule(handler(self, self._updateCountDown), 1)

		self.m_timeTxt:setText(self._cdTime)
	end

	self:_playEnterAni()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_MATCHING_PLAYING)
end

return TeamPVPMatchPop
