local var_0_0 = g.core.config.team_battle_game_info
local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleTickGamePop = class("TeamBattleTickGamePop", require("app.fairyGUI.teamBattle.UI_TeamBattleTickGamePop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleTickGamePop",
		pkgPath = "ui/teamBattle/teamBattle",
		pkgName = "teamBattle"
	}, ...)
end)

function TeamBattleTickGamePop:ctor(arg_2_1)
	self:showAtCenter()

	self._eventData = arg_2_1
	self._cfg = var_0_0.get(self._eventData.value)

	self:updateEventView()
	self.m_startBtn:addClickListener(handler(self, self._onStartGameClick))
	self.m_closeBtn:setClickCallBack(handler(self, self._onClosePop))

	if self._cfg.type == TeamBattleConst.EVENT_TYPE.GAME_METEOR_SHOWER then
		self.m_selectTagController:setSelectedIndex(0)
	elseif self._cfg.type == TeamBattleConst.EVENT_TYPE.GAME_TURN_CARD then
		self.m_selectTagController:setSelectedIndex(1)
	elseif self._cfg.type == TeamBattleConst.EVENT_TYPE.GAME_DART then
		self.m_selectTagController:setSelectedIndex(2)
	end
end

function TeamBattleTickGamePop:onLoad()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_GameMachine)
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		anim = "play_boss",
		name = "eff_ui_teamBattle_popBg",
		remove = true,
		isLoop = false
	})
end

function TeamBattleTickGamePop:updateEventView()
	self.m_eventNameTxt:setText(self._cfg.event_name)
end

function TeamBattleTickGamePop:_onStartGameClick()
	if not self:_checkGameEvent() then
		return
	end

	local var_5_0 = self._cfg

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._eventData then
		if var_5_0.type == TeamBattleConst.EVENT_TYPE.GAME_METEOR_SHOWER then
			g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_METEOR_SHOWER, self._eventData)
		elseif var_5_0.type == TeamBattleConst.EVENT_TYPE.GAME_TURN_CARD then
			g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_TURN_CARD, self._eventData)
		elseif var_5_0.type == TeamBattleConst.EVENT_TYPE.GAME_DART then
			g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_DART, self._eventData)
		end
	end
end

function TeamBattleTickGamePop:_checkGameEvent()
	if not g.core.model.User.teamBattleData:getMapData():isInEventMap(self._cfg.type, self._eventData.unique_id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(427161))

		return false
	end

	return true
end

function TeamBattleTickGamePop:_onClosePop()
	self.m_backTransition:play(handler(self, self._onRemoveSelf))
end

function TeamBattleTickGamePop:_onRemoveSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return TeamBattleTickGamePop
