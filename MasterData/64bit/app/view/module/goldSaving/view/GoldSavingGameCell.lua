local var_0_0 = g.core.config.gold_saving_game_info
local GoldSavingGameCell = class("GoldSavingGameCell", require("app.fairyGUI.goldSaving.UI_GoldSavingGameCell"))

function GoldSavingGameCell:ctor()
	self._gameCfg = nil

	self:addClickListener(handler(self, self._onGameClick))
end

function GoldSavingGameCell:setEmpty()
	self._gameCfg = nil

	self.m_gameTypeController:setSelectedIndex(0)
	self.m_eff:removeAllEffect()
end

function GoldSavingGameCell:updateGoldSavingGame(arg_3_1)
	local var_3_0 = var_0_0.get(arg_3_1)

	self._gameCfg = var_3_0

	self.m_gameTypeController:setSelectedIndex(var_3_0.type)
	self.m_eff:addEffectSpine({
		isLoop = true,
		name = "eff_ui_goldSaving_entrance",
		anim = "play"
	})
end

function GoldSavingGameCell:_onGameClick()
	if self._gameCfg then
		g.core.network.GameNetProxy:send_C2S_GoldSaving_GameStart({
			game_id = self._gameCfg.id
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(407919))
	end
end

return GoldSavingGameCell
