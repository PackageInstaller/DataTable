local ExplorationWishTreeRewardComp = class("ExplorationWishTreeRewardComp", require("app.fairyGUI.exploration.UI_ExplorationWishTreeRewardComp"))

function ExplorationWishTreeRewardComp:ctor()
	self._eventCF = nil
end

function ExplorationWishTreeRewardComp:updateRewardItem(arg_2_1)
	local var_2_0 = g.core.common.Goods:convert(arg_2_1)

	self.m_rewardIcon:setURL(var_2_0.icon)
	self.m_rewardNumTxt:setText(var_2_0.size)
end

function ExplorationWishTreeRewardComp:playAward(arg_3_1)
	self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_explorationGame_wishTreeOpen",
		isLoop = false,
		remove = true,
		eventHandler = handler(self, self._onShowFinal)
	})

	self._eventCF = arg_3_1
end

function ExplorationWishTreeRewardComp:_onShowFinal(arg_4_1, arg_4_2)
	if arg_4_1.type == "complete" and self._eventCF then
		self._eventCF()
	end
end

function ExplorationWishTreeRewardComp:playRun()
	self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_explorationGame_wishTreeIdle",
		isLoop = false,
		remove = true
	})
end

return ExplorationWishTreeRewardComp
