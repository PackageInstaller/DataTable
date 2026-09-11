local var_0_0 = {}

function var_0_0:Extend()
	local var_1_0 = self.gameObject:GetComponent("I18NTextKeyToValue")

	if isNil(var_1_0) then
		return self
	end

	local var_1_1 = {}

	tolua.setpeer(self, var_1_1)

	var_1_1.__index = var_1_1

	local var_1_2 = var_0_0.GetTransformPath(var_1_0.transform)

	tolua.initset(var_1_1).text = function(arg_2_0, arg_2_1)
		if isNil(var_1_0) then
			Debug.LogError(string.format("访问已被销毁的i18NTextKeyToValue组件, path: %s", var_1_2))

			return
		end

		var_1_0:RefreshText(arg_2_1, true)
	end

	return self
end

function var_0_0:GetTransformPath()
	if isNil(self) then
		return ""
	end

	local var_3_0 = self.name

	self = self.parent

	while not isNil(self) do
		var_3_0 = string.format("%s/%s", self.name, var_3_0)
		self = self.parent
	end

	return var_3_0
end

return var_0_0
