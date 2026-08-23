local var_0_0 = g.core.config.team_battle_mining_info
local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local TeamBattleMinePop = class("TeamBattleMinePop", require("app.fairyGUI.teamBattle.UI_TeamBattleMinePop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleMinePop",
		pkgPath = "ui/teamBattle/teamBattle",
		pkgName = "teamBattle"
	})
end)

function TeamBattleMinePop:ctor(arg_2_1)
	self._event = arg_2_1

	local var_2_0 = self._event:getEventInfo()

	self._gridId = var_2_0.grid
	self._id = var_2_0.value

	self:showAtCenter()

	self._miniInfo = var_0_0.get(self._id)

	self:_initRegisterUI()
end

function TeamBattleMinePop:_initRegisterUI()
	self.m_mineBtn:addClickListener(handler(self, self._onClickMineBtn))
	self.m_todayNoTip:addClickListener(handler(self, self._onClickTodayNoTip))
	self.m_closePnl:addClickListener(handler(self, self._onClosePnl))
	self.m_mineLoader:setURL(self._event:getUIInfo().url)
end

function TeamBattleMinePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_MINE, self._onS2CTeamBattleMine, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYMINE, self._onS2CTeamBattleMine, self)
	self:_updateMineInfo()
	self.m_enterTransition:play()
	self:_playShowEffect()
end

function TeamBattleMinePop:_updateMineInfo()
	self.m_descTxt:setText(g.core.lang:get(427150, {
		min = self._miniInfo.num_min
	}))
	self.m_costLoader:setURL((g.core.common.Path:getTeamBattleIcon(93)))
	self.m_costNumTxt:setText(self._miniInfo.buy_cost)

	self._isEnough = g.core.model.User.teamBattleData:getMapData():getLeftPoint() >= self._miniInfo.buy_cost

	self.m_enoughController:setSelectedIndex(self._isEnough and 1 or 0)
	self.m_todayNoTip:setSelected((g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_TEAM_BATTLE_MINE_POP_TIP)))
end

function TeamBattleMinePop:_onS2CTeamBattleMine(arg_6_1, arg_6_2, arg_6_3)
	if self._event:getEventInfo().mineTimes >= self._miniInfo.buy_num then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	else
		self:_updateMineInfo()
	end
end

function TeamBattleMinePop:_onClickMineBtn()
	if self._isEnough then
		if not g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_TEAM_BATTLE_MINE_POP_TIP) then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(111026),
				desc = g.core.lang:get(427136),
				onConfirm = handler(self, self._sendDoMsg)
			}), {
				touchDisappear = true
			})
		else
			self:_sendDoMsg()
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(427151))
	end
end

function TeamBattleMinePop:_sendDoMsg()
	g.core.network.GameNetProxy:send_C2S_TeamBattle_Mine({
		grid_id = self._gridId
	})
end

function TeamBattleMinePop:_onClickTodayNoTip()
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_TEAM_BATTLE_MINE_POP_TIP, (self.m_todayNoTip:isSelected()))
end

function TeamBattleMinePop:_onClosePnl()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TeamBattleMinePop:_playShowEffect()
	if not self._playEff then
		self.m_eff:addEffectSpine({
			name = "eff_ui_teamBattle_popBg",
			remove = true,
			anim = "play_shop",
			isLoop = false
		})
	end
end

return TeamBattleMinePop
