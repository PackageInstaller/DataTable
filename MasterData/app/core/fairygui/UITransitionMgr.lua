function fgui.Transition:changeParams(arg_1_1)
	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		self:setValue(iter_1_0, iter_1_1)
	end

	return self
end

local var_0_0 = "animation"
local var_0_1 = "ui/animation/animation"
local var_0_2 = "BaseAnimation"
local var_0_3 = {}

local function var_0_4(arg_2_0)
	if var_0_3[arg_2_0] then
		var_0_3[arg_2_0]:release()

		var_0_3[arg_2_0] = nil
	end
end

local function var_0_5(arg_3_0, arg_3_1)
	if arg_3_1 then
		var_0_4(arg_3_0)
		arg_3_1:retain()

		var_0_3[arg_3_0] = arg_3_1
	end
end

return {
	clearSharedComp = function(arg_4_0)
		for iter_4_0, iter_4_1 in pairs(var_0_3) do
			var_0_4(iter_4_0)
		end
	end,
	getShareTransition = function(self, arg_5_1, arg_5_2)
		if arg_5_2 == nil then
			arg_5_2 = var_0_2
		end

		local var_5_0 = self:_getShareComp(arg_5_2)

		if var_5_0 == nil then
			return
		end

		return (var_5_0:getTransition(arg_5_1))
	end,
	_getShareComp = function(self, arg_6_1)
		return (var_0_3[arg_6_1] == nil or nil) and self:_loadShareComp(arg_6_1)
	end,
	_loadShareComp = function(arg_7_0, arg_7_1)
		fgui.UIPackage:addPackage(var_0_1)

		local var_7_0 = fgui.UIPackage:createObject(var_0_0, arg_7_1)

		var_0_5(arg_7_1, var_7_0)

		return var_7_0
	end
}
