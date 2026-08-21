local var_0_0 = class("WorldMediaCollectionSubLayer", import("view.base.BaseSubView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	arg_1_0.viewParent = arg_1_1
	arg_1_0.buffer = setmetatable({}, {
		__index = function(arg_2_0, arg_2_1)
			return function(arg_3_0, ...)
				arg_1_0:ActionInvoke(arg_2_1, ...)

				return
			end
		end,
		__newindex = function()
			errorMsg("Cant write Data in ActionInvoke buffer")

			return
		end
	})

	return
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0:Show()
	else
		arg_5_0:Hide()
	end

	return
end

function var_0_0.OnDestroy(arg_6_0)
	if arg_6_0.loader then
		arg_6_0.loader:Clear()

		arg_6_0.loader = nil
	end

	return
end

return var_0_0
