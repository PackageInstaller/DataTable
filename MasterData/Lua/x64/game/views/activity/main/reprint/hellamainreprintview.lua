HellaMainView = import("game.views.activity.Main.HellaMainView")

local HellaMainReprintView = class("HellaMainReprintView", HellaMainView)

function HellaMainReprintView:Init()
	HellaMainReprintView.super.Init(self)
	SetActive(self.skinTrialGo_, false)
	SetActive(self.tryGo_, false)
end

return HellaMainReprintView
