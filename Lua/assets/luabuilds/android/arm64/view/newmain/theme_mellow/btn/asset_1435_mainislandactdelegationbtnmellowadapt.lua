local MainIslandActDelegationBtnMellowAdapt = class("MainIslandActDelegationBtnMellowAdapt", import(".MainCommonSpActBtnAdapt"))

function MainIslandActDelegationBtnMellowAdapt:GetContainer()
	return self.root:Find("right")
end

function MainIslandActDelegationBtnMellowAdapt:OnInit()
	setAnchoredPosition(self._tf, {
		x = 178,
		y = 185
	})

	return
end

return MainIslandActDelegationBtnMellowAdapt
