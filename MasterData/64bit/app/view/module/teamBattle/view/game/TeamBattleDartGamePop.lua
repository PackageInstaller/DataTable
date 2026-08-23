local var_0_0 = 130
local var_0_1 = 10
local var_0_2 = require("app.view.module.teamBattle.const.TeamBattleConst").GAME
local var_0_3 = g.core.config.team_battle_game_info
local var_0_4 = g.core.module.ModuleManager
local TeamBattleDartGamePop = class("TeamBattleDartGamePop", require("app.fairyGUI.teamBattle.UI_TeamBattleDartGamePop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/teamBattle/teamBattle",
		resName = "TeamBattleDartGamePop",
		pkgName = "teamBattle"
	}, ...)
end)

function TeamBattleDartGamePop:ctor(arg_2_1)
	self:addBg("bg/teamBattle/bg_hjtj_game_shengyu.jpg")

	self._eventId = arg_2_1.unique_id
	self._gameCfg = var_0_3.get(arg_2_1.value)

	self.m_topBarComp:setTitle(self._gameCfg.event_name)

	self._curShotDart = nil
	self._successNum = 0

	self.m_targetComp:initArrow({
		R = var_0_0,
		rotateGap = var_0_1,
		initDartNum = self._gameCfg.special_value2
	})

	self._dartNum = self._gameCfg.special_value1

	self.m_biuComp:addClickListener(handler(self, self._onClickBiu))
	self:createInitDart()
end

function TeamBattleDartGamePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_PLAYGAME, handler(self, self._onTeamBattleGameFinish), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_TEAM_BATTLE_PLAY_GAME_FAILED, handler(self, self.onGameStageFinish), self)

	if not self._isStart then
		self:onStartGame()
	elseif not self._gameScheduler then
		self:start()
	end
end

function TeamBattleDartGamePop:onGameStageFinish()
	var_0_4:tip(g.core.lang:get(426006))
	var_0_4:switchModuleIntelligent(g.view.entrance.HOME)
end

function TeamBattleDartGamePop:onStartGame()
	self._isStart = true

	var_0_4:pushPopup(require("app.view.module.teamBattle.view.game.TeamBattleDartCountDownPop").new({
		callBack = handler(self, self.start)
	}), {
		blackOpacity = 1,
		ignoreTouch = true,
		touchDisappear = false
	})
end

function TeamBattleDartGamePop:start()
	self._gameScheduler = self:newSchedule(handler(self, self._onTickUpdate), 0)

	self.m_lastNumTxt:setText(g.core.lang:get(427103, {
		num = self._dartNum
	}))
end

function TeamBattleDartGamePop:createInitDart()
	local var_7_0 = fgui.UIPackage:createObject("teamBattle", "TeamBattleDartComp")

	var_7_0:setState(var_0_2.DART_STATE.UNUSED)
	self.m_startPosComp:addChild(var_7_0)
	var_7_0:setPosition(-262, 0)

	self._curShotDart = var_7_0
end

function TeamBattleDartGamePop:_onClickBiu()
	if self._isInShotAnim then
		return
	end

	self:playShotDart()

	self._dartNum = self._dartNum - 1

	self.m_lastNumTxt:setText(g.core.lang:get(427103, {
		num = self._dartNum
	}))
end

function TeamBattleDartGamePop:playShotDart()
	if self._curShotDart then
		self._isInShotAnim = true

		local var_9_0 = self.m_startPosComp:globalToLocal((cc.pAdd(self.m_targetComp:localToGlobal(cc.p(0, 0)), cc.p(var_0_0, 0))))

		if self.m_targetComp:checkIsShotSuccess(nil, 0.2) then
			self._curShotDart:runFGAction(fgui.FSequence:create({
				fgui.FSpawn:create(fgui.FEaseBackOut:create(fgui.FMoveTo:create(0.2, var_9_0)), fgui.FSequence:create(fgui.FDelayTime:create(0.14), fgui.FCallFunc:create(handler(self, self.onPlayHitAnim)))),
				(fgui.FCallFunc:create(handler(self, self.onShotAnimPlayFinish)))
			}))
		else
			local var_9_1 = {}

			var_9_1[1] = fgui.FEaseQuinticActionOut:create(fgui.FMoveTo:create(0.08, var_9_0))
			var_9_1[2] = fgui.FCallFunc:create(handler(self, self.onShotAnimPlayFaild))

			self._curShotDart:runFGAction(fgui.FSequence:create(var_9_1))
		end
	end
end

function TeamBattleDartGamePop:onPlayHitAnim()
	self.m_targetComp:playHitAnim()
end

function TeamBattleDartGamePop:onShotAnimPlayFinish()
	self.m_targetComp:addShotDart(self._curShotDart)

	self._successNum = self._successNum + 1

	if self._dartNum <= 0 then
		self:gameDartFinish()
	else
		self._curShotDart = nil
		self._isInShotAnim = false

		self:createInitDart()
	end
end

function TeamBattleDartGamePop:onShotAnimPlayFaild()
	self.m_targetComp:playFailAnim()
	self._curShotDart:removeSelf()

	if self._dartNum <= 0 then
		self:gameDartFinish()
	else
		self._curShotDart = nil
		self._isInShotAnim = false

		self:createInitDart()
	end
end

function TeamBattleDartGamePop:_onTickUpdate(arg_13_1, arg_13_2)
	self.m_targetComp:tickRotate(arg_13_2)
end

function TeamBattleDartGamePop:gameDartFinish()
	g.core.network.GameNetProxy:send_C2S_TeamBattle_PlayGame({
		event_id = self._eventId,
		params = {
			self._successNum
		}
	})
end

function TeamBattleDartGamePop:_onTeamBattleGameFinish(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	g.core.module.ModuleManager:awardSummary(arg_15_4.awards, true, nil, g.core.lang:get(300001), handler(self, function(arg_16_0)
		arg_16_0:newScheduleOnce(handler(arg_16_0, arg_16_0.closeGamePop), 0.5)
	end))
end

function TeamBattleDartGamePop:closeGamePop()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TeamBattleDartGamePop:onUnload()
	self._gameScheduler = nil
end

return TeamBattleDartGamePop
