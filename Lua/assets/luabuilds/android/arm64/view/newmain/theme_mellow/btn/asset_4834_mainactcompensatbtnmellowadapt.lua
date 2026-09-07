local MainActCompensatBtnMellowAdapt = class("MainActCompensatBtnMellowAdapt", import(".MainDifferentStyleSpActBtnAdapt"))

function MainActCompensatBtnMellowAdapt:GetContainer()
	return self.root:Find("top")
end

function MainActCompensatBtnMellowAdapt:OnRegister()
	return
end

return MainActCompensatBtnMellowAdapt
