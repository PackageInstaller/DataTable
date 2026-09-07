local CatteryStyle = class("CatteryStyle", import("...BaseVO"))

function CatteryStyle:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.own = arg_1_1.own

	return
end

function CatteryStyle:bindConfigTable()
	return pg.commander_home_style
end

function CatteryStyle:IsOwn()
	return self.own
end

function CatteryStyle:GetName(arg_4_1)
	local var_4_0 = self:getConfig("name")

	return (arg_4_1 or nil) and (var_4_0 .. "_d" or var_4_0)
end

return CatteryStyle
