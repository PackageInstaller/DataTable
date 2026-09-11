local HeroClueEnterView_4_3 = class("HeroClueEnterView_4_3", (import("game.views.heroClue.HeroClueEnterView")))

function HeroClueEnterView_4_3:InitController()
	self.allReceiveController_ = self.taskPanelControllerEx_:GetController("clear")
end

return HeroClueEnterView_4_3
