local HeroClueEnterView_3_6 = class("HeroClueEnterView_3_6", (import("game.views.heroClue.HeroClueEnterView")))

function HeroClueEnterView_3_6:InitController()
	self.allReceiveController_ = self.taskPanelControllerEx_:GetController("clear")
end

return HeroClueEnterView_3_6
