local var_0_0 = singletonClass("ComponentBinder")

function var_0_0.InjectImage(arg_1_0, arg_1_1, arg_1_2)
	return ImageWrap.New(arg_1_1, arg_1_2):GetWrapper()
end

function var_0_0.InjectText(arg_2_0, arg_2_1)
	if arg_2_1.gameObject:GetComponent("I18NTextKeyToValue") then
		return I18NExtendText.Extend(arg_2_1)
	else
		return arg_2_1
	end
end

function var_0_0.BindCfgUI(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2:GetComponent("ComponentCfger")

	if var_3_0 then
		local var_3_1 = var_3_0.componentList
		local var_3_2 = var_3_0:GetLuaNames()
		local var_3_3 = var_3_0:GetComponentValues()
		local var_3_4 = var_3_0.componentList

		for iter_3_0 = 0, var_3_2.Length - 1 do
			local var_3_5 = var_3_2[iter_3_0]
			local var_3_6 = var_3_3[iter_3_0]

			arg_3_1[var_3_5] = arg_3_0:Extend(var_3_6, var_3_4[iter_3_0], arg_3_1)
		end

		arg_3_1.guideComponents = {}

		local var_3_7 = var_3_0:GetGuideLuaNames()
		local var_3_8 = var_3_0:GetGuideComponentValues()

		for iter_3_1 = 0, var_3_7.Length - 1 do
			local var_3_9 = var_3_7[iter_3_1]
			local var_3_10 = var_3_8[iter_3_1]

			arg_3_1.guideComponents[var_3_9] = var_3_10
		end
	end
end

function var_0_0.Extend(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_2.type

	if var_4_0 == ComponentCfger.UIComponentType.Text then
		if arg_4_2.go:GetComponent("I18NTextKeyToValue") then
			return I18NExtendText.Extend(arg_4_1)
		else
			return arg_4_1
		end
	elseif var_4_0 == ComponentCfger.UIComponentType.Image or var_4_0 == ComponentCfger.UIComponentType.RawImage or var_4_0 == ComponentCfger.UIComponentType.SelfAdaptImage then
		return arg_4_0:InjectImage(arg_4_1, arg_4_3)
	end

	return arg_4_1
end

return var_0_0
