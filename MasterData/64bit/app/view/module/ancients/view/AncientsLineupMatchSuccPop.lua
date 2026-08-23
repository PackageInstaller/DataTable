local AncientsLineupMatchSuccPop = class("AncientsLineupMatchSuccPop", require("app.fairyGUI.ancients.UI_AncientsLineupMatchSuccPop"), function()
	return fgui.GComponent:create({
		resName = "AncientsLineupMatchSuccPop",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.AncientsConst

function AncientsLineupMatchSuccPop:ctor()
	self:getView():center(true)
	self.m_battleHeadList:setVirtual(self)
	self.m_battleHeadList:setItemRenderer(handler(self, self._onRenderBattleHeadCell))
	self.m_enterBattleBtn:addClickListener(handler(self, self._onClickBtnFight))

	self._enterTime = 0

	self.m_enterTransition:setHook("enter", function()
		self.m_matchingDiskComp:playEnterAni()
	end)
	self.m_enterTransition:setHook("loop", function()
		self.m_matchingDiskComp:playTurnAroundAni()
	end)
	self.m_enterTransition:play()
	self.m_effDi:addEffectSpine({
		remove = false,
		anim = "play",
		isLoop = true,
		name = "eff_ui_peakArena_di"
	})

	if not g.core.model.User.ancientsData:getTeam(var_0_1.GET_TEAM_TYPE.ENEMY_TEAM) then
		-- block empty
	end

	if g.core.utils.Tools.ancientsFunc.sendSimpleUserSnapshot((g.core.model.User.ancientsData:getTeamUserIds(var_0_1.GET_TEAM_TYPE.ENEMY_TEAM))) then
		self:_updateUsersInfo()
	end

	if self._enterTime == 0 then
		self._enterTime = g.core.common.ServerTime:getTime()

		self:cancelScheduleFight()

		self._scheduleFight = self:newSchedule(handler(self, self._updateFightCd), 1)

		self:_updateFightCd()
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_JuXiang_MatchSuccess)
end

function AncientsLineupMatchSuccPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetCommonSimpleUserSnapshot), self)
end

function AncientsLineupMatchSuccPop:_updateUsersInfo()
	self._enemyTeamUsers = g.core.model.User.ancientsData:getTeamUsers(var_0_1.GET_TEAM_TYPE.ENEMY_TEAM)

	self.m_battleHeadList:setNumItems(#self._enemyTeamUsers)
end

function AncientsLineupMatchSuccPop:cancelScheduleFight()
	if self._scheduleFight ~= nil then
		self:cancelSchedule(self._scheduleFight)

		self._scheduleFight = nil
	end
end

function AncientsLineupMatchSuccPop:_updateFightCd()
	local var_8_0 = math.max(0, g.core.model.User.ancientsData:getLineupFightCd() - (g.core.common.ServerTime:getTime() - self._enterTime))

	self.m_timeTxt:setText(string.format("%02d:%02d", math.floor(var_8_0 / 60), math.floor(var_8_0 % 60)))

	if var_8_0 <= 0 then
		self:dispatchCompEvent("ANCIENTS_LINEUP_CLICK_FIGHT")
		self:removeSelf()
	end
end

function AncientsLineupMatchSuccPop:_onClickBtnFight()
	self:dispatchCompEvent("ANCIENTS_LINEUP_CLICK_FIGHT")
	self:removeSelf()
end

function AncientsLineupMatchSuccPop:_onGetCommonSimpleUserSnapshot(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self:_updateUsersInfo()
end

function AncientsLineupMatchSuccPop:_onRenderBattleHeadCell(arg_11_1, arg_11_2)
	arg_11_2:updateCell({
		teamUser = self._enemyTeamUsers[arg_11_1 + 1]
	})
end

function AncientsLineupMatchSuccPop:onCancelCallback()
	return
end

return AncientsLineupMatchSuccPop
