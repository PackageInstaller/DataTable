local BossSingleTotalRewardPanel = class("BossSingleTotalRewardPanel", import("view.activity.worldboss.ActivityBossTotalRewardPanel"))

function BossSingleTotalRewardPanel:getUIName()
	return "BossSingleTotalRewardPanel"
end

function BossSingleTotalRewardPanel:init()
	BossSingleTotalRewardPanel.super.init(self)
	setText(self.window:Find("Fixed/ButtonGO/pic"), i18n("autofight_onceagain"))

	return
end

function BossSingleTotalRewardPanel:UpdateView()
	BossSingleTotalRewardPanel.super.UpdateView(self)

	local var_3_0 = self.contextData

	onButton(self, self.window:Find("Fixed/ButtonGO"), function()
		existCall(var_3_0.onConfirm)
		self:closeView()

		return
	end, SFX_CONFIRM)
	onButton(self, self.window:Find("Fixed/ButtonExit"), function()
		triggerButton(self._tf:Find("BG"))

		return
	end)

	return
end

return BossSingleTotalRewardPanel
