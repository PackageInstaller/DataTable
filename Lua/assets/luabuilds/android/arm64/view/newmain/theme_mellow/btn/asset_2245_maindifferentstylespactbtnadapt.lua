local MainDifferentStyleSpActBtnAdapt = class("MainDifferentStyleSpActBtnAdapt", import(".MainCommonSpActBtnAdapt"))

function MainDifferentStyleSpActBtnAdapt:GetUIName()
	return self.spActBtn:GetUIName() .. "4Mellow"
end

return MainDifferentStyleSpActBtnAdapt
