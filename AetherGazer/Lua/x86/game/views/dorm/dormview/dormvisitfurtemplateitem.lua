local var_0_0 = class("DormVisitFurTemplateItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.stateController = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.chooseBtn, nil, function()
		if arg_3_0.clickCallBack then
			arg_3_0.clickCallBack(arg_3_0.templateID, arg_3_0.pos)
		end
	end)
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.templateID = arg_5_1

	local var_5_0 = 0

	if arg_5_0.templateID >= 0 then
		local var_5_1 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_5_1)
		local var_5_2 = var_5_1.name

		arg_5_0.name.text = var_5_2
		var_5_0 = var_5_1:GetDormTemplateFurNumInfo()
	else
		arg_5_0.name.text = string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), arg_5_3)
	end

	arg_5_0.num.text = string.format(GetTips("DORM_MOULD_FURNITURE_NUM"), var_5_0)
	arg_5_0.pos = arg_5_3

	if arg_5_0.pos == arg_5_2 then
		if var_5_0 <= 0 then
			arg_5_0.stateController:SetSelectedState("select1_0")
		else
			arg_5_0.stateController:SetSelectedState("select_1")
		end
	elseif var_5_0 <= 0 then
		arg_5_0.stateController:SetSelectedState("normal_0")
	else
		arg_5_0.stateController:SetSelectedState("normal_1")
	end
end

function var_0_0.ClickCallBack(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.clickCallBack = arg_6_1
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
