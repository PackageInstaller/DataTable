local BattleResultBioTeamCard = class("BattleResultBioTeamCard", require("app.fairyGUI.battleResult.UI_BattleResultBioTeamCard"))

function BattleResultBioTeamCard:ctor()
	self._effectIndex = 0

	self.m_bg:setURL(g.core.common.Path:getBattleCardBgByRegionId(config.PUBLISH_REGION))
end

function BattleResultBioTeamCard:updateCard(arg_2_1, arg_2_2, arg_2_3)
	self.m_rewardComp:updateCard(arg_2_1)

	local var_2_0 = g.core.common.Goods:convert(arg_2_1.award)
	local var_2_1 = var_2_0.quality

	self._effectIndex = var_2_0.quality

	if arg_2_2 then
		var_2_1 = 0
	end

	local var_2_2 = self["m_play" .. var_2_1 .. "Transition"]

	self._animIndex = var_2_1

	local var_2_3 = handler(self, function()
		if type(arg_2_3) == "function" then
			arg_2_3()
		end
	end)

	if var_2_2 then
		var_2_2:setHook("play", handler(self, self._onPlaySpineAnim))
		var_2_2:play(var_2_3)
	else
		self.m_play0Transition:setHook("play", handler(self, self._onPlaySpineAnim))
		self.m_play0Transition:play(var_2_3)
		print("ERR:------------------->do not have trans indexed " .. var_2_0.quality)
	end
end

function BattleResultBioTeamCard:_onPlaySpineAnim()
	self.m_effectComp:addEffectSpine({
		name = "eff_ui_bioTeam_card_open",
		isLoop = false,
		anim = "play" .. math.min(self._effectIndex, 3)
	})
end

return BattleResultBioTeamCard
