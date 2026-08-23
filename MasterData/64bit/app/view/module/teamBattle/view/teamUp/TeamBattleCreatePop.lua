local TeamBattleCreatePop = class("TeamBattleCreatePop", require("app.fairyGUI.teamBattle.UI_TeamBattleCreatePop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleCreatePop",
		pkgPath = "ui/teamBattle/teamBattle",
		pkgName = "teamBattle"
	})
end)
local var_0_1 = g.core.utils.String

function TeamBattleCreatePop:ctor(arg_2_1)
	self:showAtCenter()

	local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")

	self._maxStrLen = g.core.config.team_battle_parameter_info.get(TeamBattleConst.PARAMETER_ID.TEAM_NAME_MAX_ID).parameter
	self._minStrLen = g.core.config.team_battle_parameter_info.get(TeamBattleConst.PARAMETER_ID.TEAM_NAME_MIN_ID).parameter

	self:_initView()
end

function TeamBattleCreatePop:_initView()
	self.m_tipText:setText(g.core.lang:get(427159, {
		min = self._minStrLen,
		max = self._maxStrLen
	}))
	self.m_chooseNumComp:initMinMaxNum({
		min = 1,
		max = 200
	})
	self.m_inputText:setPrompt(g.core.lang:get(427005))
	self.m_inputText:addEventListener(fgui.UIEventType.Changed, handler(self, self._onInputTextChanged))
	self.m_changeSettingBtn:addClickListener(handler(self, self._onClickSettingBtn))
	self.m_closeBtn:addClickListener(handler(self, self._onCloseBtnClick))
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		name = "eff_ui_teamBattle_popBg",
		anim = "play_fjlist",
		remove = true,
		isLoop = false
	})
end

function TeamBattleCreatePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_CREATETEAM, handler(self, self.onS2CTeamBattleCreateTeam), self)
end

function TeamBattleCreatePop:_onClickSettingBtn()
	local var_5_0 = self.m_inputText:getText()
	local var_5_1 = var_0_1.getCharactersNum(var_5_0, 2)

	if var_5_1 < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(427005))

		return
	end

	if var_5_1 > self._maxStrLen then
		g.core.module.ModuleManager:tip(g.core.lang:get(427153))

		return
	end

	if tonumber(var_5_0) then
		g.core.module.ModuleManager:tip(g.core.lang:get(427154))

		return
	end

	g.core.network.GameNetProxy:send_C2S_TeamBattle_CreateTeam({
		team_name = var_5_0,
		level_limit = self.m_chooseNumComp:getCurNum()
	})
end

function TeamBattleCreatePop:onS2CTeamBattleCreateTeam(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	g.core.module.ModuleManager:popByDisplay(self)
	g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_TEAM_UP_LAYER)
end

function TeamBattleCreatePop:_onCloseBtnClick()
	g.core.module.ModuleManager:popByDisplay(self)
end

function TeamBattleCreatePop:_onInputTextChanged()
	local var_8_0 = self.m_inputText:getText()

	if var_0_1.getCharactersNum(var_8_0, 2) > self._maxStrLen then
		g.core.module.ModuleManager:tip(g.core.lang:get(427153))
		self.m_inputText:setText(self._lastStr)

		return
	end

	self._lastStr = var_8_0
end

return TeamBattleCreatePop
