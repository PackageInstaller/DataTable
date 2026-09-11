local HeroClueEnterView_4_7 = class("HeroClueEnterView_4_7", (import("game.views.heroClue.HeroClueEnterView")))

function HeroClueEnterView_4_7:InitController()
	self.allReceiveController_ = self.taskPanelControllerEx_:GetController("clear")
end

return HeroClueEnterView_4_7
