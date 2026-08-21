local var_0_0 = class("XimuLoginPage", import(".TemplatePage.LoginTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.items2 = arg_1_0.bg:Find("items2")

	return
end

function var_0_0.OnUpdateFlush(arg_2_0)
	var_0_0.super.OnUpdateFlush(arg_2_0)
	removeAllChildren(arg_2_0.items2)
	eachChild(arg_2_0.items, function(arg_3_0)
		local var_3_0 = arg_3_0:Find("day/Text")
		local var_3_2 = var_3_0
		local var_3_4 = getText(var_3_0)

		if arg_3_0:GetSiblingIndex() < arg_2_0.nday then
			var_3_1(var_3_2, var_3_3(var_3_4, var_3_5))

			return
		end
	end)

	for iter_2_0 = arg_2_0.Day, 4, -1 do
		local var_2_0 = arg_2_0.items:GetChild(iter_2_0 - 1)

		setParent(var_2_0, arg_2_0.items2, false)
		var_2_0:SetAsFirstSibling()
	end

	return
end

return var_0_0
