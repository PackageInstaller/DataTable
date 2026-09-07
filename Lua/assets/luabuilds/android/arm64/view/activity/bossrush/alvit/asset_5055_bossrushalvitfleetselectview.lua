local BossRushAlvitFleetSelectView = class("BossRushAlvitFleetSelectView", import("view.activity.BossRush.BossRushFleetSelectView"))

function BossRushAlvitFleetSelectView:GetTextColor()
	local var_1_0 = Color.NewHex("1C231F")
	local var_1_1 = Color.NewHex("979A98")
end

function BossRushAlvitFleetSelectView:getUIName()
	return "BossRushAlvitFleetSelectUI"
end

function BossRushAlvitFleetSelectView:tempCache()
	return true
end

function BossRushAlvitFleetSelectView:didEnter()
	BossRushAlvitFleetSelectView.super.didEnter(self)
	removeOnButton(self._tf:Find("BG"))
	onButton(self, self._tf:Find("BG/close"), function()
		self:onCancelHard()

		return
	end, SFX_CANCEL)

	self.anim = self._tf:GetComponent(typeof(Animation))
	self.animEvent = self.anim:GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		BossRushAlvitFleetSelectView.super.onCancelHard(self)

		return
	end)

	return
end

function BossRushAlvitFleetSelectView:onCancelHard()
	self.anim:Play("anim_kinder_fleetselect_out")

	return
end

return BossRushAlvitFleetSelectView
