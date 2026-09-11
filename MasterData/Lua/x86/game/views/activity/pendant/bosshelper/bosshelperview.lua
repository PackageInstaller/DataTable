local BossHelperView = class("BossHelperView", (import("game.views.prompt.GameHelpProView")))

function BossHelperView:UIName()
	return "UI/VolumeIIIUI/VolumeGameHelpPro"
end

function BossHelperView:UIParent()
	return manager.ui.uiMain.transform
end

function BossHelperView:AddUIListeners()
	BossHelperView.super.AddUIListeners(self)
	self:AddBtnListener(self.goBtn_, nil, function()
		BattleBossChallengeAction.EnterBossChallenge()
	end)
end

return BossHelperView
