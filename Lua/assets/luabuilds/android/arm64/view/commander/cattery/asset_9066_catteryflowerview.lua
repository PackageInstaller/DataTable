local CatteryFlowerView = class("CatteryFlowerView")

function CatteryFlowerView:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.default = self._tf:Find("1")
	self.levels = {
		self._tf:Find("2"),
		self._tf:Find("3"),
		self._tf:Find("4"),
		self._tf:Find("5")
	}

	return
end

function CatteryFlowerView:Update(arg_2_1)
	local var_2_0 = arg_2_1:GetCleanLevel()
	local var_2_1 = true

	for iter_2_0, iter_2_1 in pairs(self.levels) do
		local var_2_2 = var_2_0 == iter_2_0

		setActive(iter_2_1, var_2_0 == iter_2_0)

		if var_2_1 and var_2_2 then
			var_2_1 = false
		end
	end

	setActive(self.default, var_2_1)

	return
end

function CatteryFlowerView:Dispose()
	self.levels = nil

	return
end

return CatteryFlowerView
