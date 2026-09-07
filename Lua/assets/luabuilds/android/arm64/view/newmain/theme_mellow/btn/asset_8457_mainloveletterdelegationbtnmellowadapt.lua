local MainLoveLetterDelegationBtnMellowAdapt = class("MainLoveLetterDelegationBtnMellowAdapt", import(".MainCommonSpActBtnAdapt"))

function MainLoveLetterDelegationBtnMellowAdapt:GetContainer()
	return self.root:Find("right")
end

function MainLoveLetterDelegationBtnMellowAdapt:OnInit()
	setAnchoredPosition(self._tf, {
		x = 168,
		y = 198
	})

	return
end

function MainLoveLetterDelegationBtnMellowAdapt:InShowTime()
	return false
end

return MainLoveLetterDelegationBtnMellowAdapt
