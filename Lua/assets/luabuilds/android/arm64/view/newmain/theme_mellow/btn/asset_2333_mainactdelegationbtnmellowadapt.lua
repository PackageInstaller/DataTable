local MainActDelegationBtnMellowAdapt = class("MainActDelegationBtnMellowAdapt", import(".MainCommonSpActBtnAdapt"))

function MainActDelegationBtnMellowAdapt:GetContainer()
	return self.root:Find("right")
end

function MainActDelegationBtnMellowAdapt:OnInit()
	setAnchoredPosition(self._tf, {
		x = 168,
		y = 198
	})

	return
end

return MainActDelegationBtnMellowAdapt
