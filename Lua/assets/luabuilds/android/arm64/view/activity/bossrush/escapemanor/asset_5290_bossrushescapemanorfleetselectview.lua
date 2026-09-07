local BossRushEscapeManorFleetSelectView = class("BossRushEscapeManorFleetSelectView", import("view.activity.BossRush.BossRushFleetSelectView"))

function BossRushEscapeManorFleetSelectView:GetTextColor()
	local var_1_0 = Color.NewHex("272727")
	local var_1_1 = Color.NewHex("FFFFFF")
end

function BossRushEscapeManorFleetSelectView:getUIName()
	return "BossRushEscapeManorFleetSelectUI"
end

function BossRushEscapeManorFleetSelectView:tempCache()
	return true
end

function BossRushEscapeManorFleetSelectView:didEnter()
	BossRushEscapeManorFleetSelectView.super.didEnter(self)
	removeOnButton(self._tf:Find("BG"))
	setText(self.btnGo:Find("Text"), i18n("zengke_series_confirm"))
	onButton(self, self._tf:Find("BG/close"), function()
		self:onCancelHard()

		return
	end, SFX_CANCEL)

	return
end

return BossRushEscapeManorFleetSelectView
