local BossRushVerZenkerFleetSelectView = class("BossRushVerZenkerFleetSelectView", import("view.activity.BossRush.BossRushFleetSelectView"))

function BossRushVerZenkerFleetSelectView:GetTextColor()
	local var_1_0 = Color.NewHex("1C231F")
	local var_1_1 = Color.NewHex("979A98")
end

function BossRushVerZenkerFleetSelectView:getUIName()
	return "BossRushVerZenkerFleetSelectUI"
end

function BossRushVerZenkerFleetSelectView:tempCache()
	return true
end

function BossRushVerZenkerFleetSelectView:didEnter()
	BossRushVerZenkerFleetSelectView.super.didEnter(self)
	removeOnButton(self._tf:Find("BG"))
	setText(self.btnGo:Find("Text"), i18n("zengke_series_confirm"))
	onButton(self, self._tf:Find("BG/close"), function()
		self:onCancelHard()

		return
	end, SFX_CANCEL)

	return
end

return BossRushVerZenkerFleetSelectView
