local BossRushSardiniaFleetSelectView = class("BossRushSardiniaFleetSelectView", import("view.activity.BossRush.BossRushFleetSelectView"))

function BossRushSardiniaFleetSelectView:GetTextColor()
	local var_1_0 = Color.NewHex("FFFFFF")
	local var_1_1 = Color.NewHex("939494")
end

function BossRushSardiniaFleetSelectView:getUIName()
	return "BossRushSardiniaFleetSelectUI"
end

function BossRushSardiniaFleetSelectView:tempCache()
	return true
end

function BossRushSardiniaFleetSelectView:didEnter()
	BossRushSardiniaFleetSelectView.super.didEnter(self)
	removeOnButton(self._tf:Find("BG"))
	setText(self.btnGo:Find("Text"), i18n("zengke_series_confirm"))
	onButton(self, self._tf:Find("BG/close"), function()
		self:onCancelHard()

		return
	end, SFX_CANCEL)

	return
end

return BossRushSardiniaFleetSelectView
