local MainCommonActDelegationBtnMellowAdapt = class("MainCommonActDelegationBtnMellowAdapt", import(".MainCommonSpActBtnAdapt"))

function MainCommonActDelegationBtnMellowAdapt:GetContainer()
	return self.root:Find("right")
end

function MainCommonActDelegationBtnMellowAdapt:OnInit()
	return
end

function MainCommonActDelegationBtnMellowAdapt:InShowTime()
	return false
end

return MainCommonActDelegationBtnMellowAdapt
