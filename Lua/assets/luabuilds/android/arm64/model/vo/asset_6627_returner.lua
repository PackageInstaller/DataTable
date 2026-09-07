local Returner = class("Returner", import(".PlayerAttire"))

function Returner:Ctor(arg_1_1)
	local var_1_0 = arg_1_1.user or {}

	Returner.super.Ctor(self, var_1_0)

	self.pt = arg_1_1.pt or 0
	self.id = var_1_0.id or 0
	self.name = var_1_0.name

	return
end

function Returner:getName()
	return self.name
end

function Returner:getIcon()
	return self.icon
end

function Returner:getPt()
	return self.pt
end

return Returner
