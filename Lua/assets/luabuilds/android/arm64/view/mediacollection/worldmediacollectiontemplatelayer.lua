local var_0_0 = class("WorldMediaCollectionTemplateLayer", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	assert(false, "Need Assign UIName " .. arg_1_0.__cname)

	return
end

function var_0_0.Ctor(arg_2_0, arg_2_1, ...)
	var_0_0.super.Ctor(arg_2_0, ...)

	arg_2_0.viewParent = arg_2_1
	arg_2_0.buffer = setmetatable({}, {
		__index = function(arg_3_0, arg_3_1)
			return function(arg_4_0, ...)
				arg_2_0:ActionInvoke(arg_3_1, ...)

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

function var_0_0.Show(arg_6_0)
	var_0_0.super.Show(arg_6_0)

	if arg_6_0._top then
		arg_6_0:OverlayPanel(arg_6_0._top)
	end

	return
end

function var_0_0.Hide(arg_7_0)
	if arg_7_0._top then
		arg_7_0:UnOverlayPanel(arg_7_0._top, arg_7_0._tf)
	end

	var_0_0.super.Hide(arg_7_0)

	return
end

function var_0_0.OnSelected(arg_8_0)
	arg_8_0:Show()

	return
end

function var_0_0.OnReselected(arg_9_0)
	return
end

function var_0_0.OnDeselected(arg_10_0)
	arg_10_0:Hide()

	return
end

function var_0_0.OnBackward(arg_11_0)
	return
end

function var_0_0.SetActive(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_0:Show()
	else
		arg_12_0:Hide()
	end

	return
end

function var_0_0.UpdateView(arg_13_0)
	return
end

return var_0_0
