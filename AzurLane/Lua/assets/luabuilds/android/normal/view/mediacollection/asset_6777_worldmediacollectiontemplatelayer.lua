class = var_0_10000

local var_0_0 = "WorldMediaCollectionTemplateLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	assert = var_1_10001

	var_1_10001(false, "Need Assign UIName " .. arg_1_0.__cname)

	return
end

function var_0_1.Ctor(arg_2_0, arg_2_1, ...)
	var_0_1.super.Ctor(arg_2_0, ...)

	arg_2_0.viewParent = arg_2_1
	setmetatable = var_2
	arg_2_0.buffer = var_2({}, {
		__index = function(arg_3_0, arg_3_1)
			return function(arg_4_0, ...)
				local var_4_0 = arg_2_0

				var_1.ActionInvoke(var_4_0, arg_3_1, ...)

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

function var_0_1.Show(arg_6_0)
	var_0_1.super.Show(arg_6_0)

	if arg_6_0._top then
		arg_6_0:OverlayPanel(arg_6_0._top)
	end

	return
end

function var_0_1.Hide(arg_7_0)
	if arg_7_0._top then
		arg_7_0:UnOverlayPanel(arg_7_0._top, arg_7_0._tf)
	end

	var_0_1.super.Hide(arg_7_0)

	return
end

function var_0_1.OnSelected(arg_8_0)
	arg_8_0:Show()

	return
end

function var_0_1.OnReselected(arg_9_0)
	return
end

function var_0_1.OnDeselected(arg_10_0)
	arg_10_0:Hide()

	return
end

function var_0_1.OnBackward(arg_11_0)
	return
end

function var_0_1.SetActive(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_0:Show()
	else
		arg_12_0:Hide()
	end

	return
end

function var_0_1.UpdateView(arg_13_0)
	return
end

return var_0_1
