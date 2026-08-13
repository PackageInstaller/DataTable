class = var_0_10000

local var_0_0 = "WorldMediaCollectionSubLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	arg_1_0.viewParent = arg_1_1
	setmetatable = var_2
	arg_1_0.buffer = var_2({}, {
		__index = function(arg_2_0, arg_2_1)
			return function(arg_3_0, ...)
				local var_3_0 = arg_1_0

				var_1.ActionInvoke(var_3_0, arg_2_1, ...)

				return
			end
		end,
		__newindex = function()
			errorMsg = var_2_10000

			var_2_10000("Cant write Data in ActionInvoke buffer")

			return
		end
	})

	return
end

function var_0_1.SetActive(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0:Show()
	else
		arg_5_0:Hide()
	end

	return
end

function var_0_1.OnDestroy(arg_6_0)
	if arg_6_0.loader then
		local var_6_0 = arg_6_0.loader

		var_1.Clear(var_6_0)

		arg_6_0.loader = nil
	end

	return
end

return var_0_1
