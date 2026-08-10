local var_0_0 = class("DormFurTemplateItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.canUseController = ControllerUtil.GetController(arg_2_0.transform_, "btnuse")
	arg_2_0.preViewController = ControllerUtil.GetController(arg_2_0.transform_, "ues")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListenerScale(arg_3_0.previewBtn_, nil, function()
		if arg_3_0.previewCallBack then
			arg_3_0.previewCallBack(arg_3_0.templateID, arg_3_0.pos)
		end
	end)
	arg_3_0:AddBtnListenerScale(arg_3_0.useBtn_, nil, function()
		if arg_3_0.useTemplateCallBack then
			arg_3_0.useTemplateCallBack(arg_3_0.templateID, arg_3_0.pos)
		end
	end)
	arg_3_0:AddBtnListenerScale(arg_3_0.btn_editnameBtn_, nil, function()
		if arg_3_0.ReviseCallBack then
			arg_3_0.ReviseCallBack(arg_3_0.templateID, arg_3_0.pos)
		end
	end)
	arg_3_0:AddBtnListenerScale(arg_3_0.saveBtn_, nil, function()
		if arg_3_0.SaveTemplate then
			arg_3_0.SaveTemplate(arg_3_0.templateID, arg_3_0.pos)
		end
	end)
	arg_3_0:AddBtnListenerScale(arg_3_0.deleteBtn_, nil, function()
		if arg_3_0.DelTemplate then
			arg_3_0.DelTemplate(arg_3_0.templateID, arg_3_0.pos)
		end
	end)
end

function var_0_0.RefreshUI(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.templateID = arg_9_1
	arg_9_0.pos = arg_9_2
	arg_9_0.canPreView = arg_9_3
	arg_9_0.indexText_.text = arg_9_2

	if arg_9_1 < 0 then
		arg_9_0.nameText_.text = string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), tostring(arg_9_2))
		arg_9_0.furNumText_.text = 0

		arg_9_0.preViewController:SetSelectedState("unedited")

		return
	end

	arg_9_0.canUseController:SetSelectedState("on")
	arg_9_0.preViewController:SetSelectedState("normal")

	local var_9_0 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_9_1)

	arg_9_0.nameText_.text = GetI18NText(var_9_0.name)
	arg_9_0.furNumText_.text = var_9_0:GetDormTemplateFurNumInfo()

	if not arg_9_3 then
		arg_9_0.canUseController:SetSelectedState("off")
	end
end

function var_0_0.RegisterUseTemplateCallBack(arg_10_0, arg_10_1)
	if arg_10_1 and arg_10_0.canPreView ~= false then
		arg_10_0.useTemplateCallBack = arg_10_1
	end
end

function var_0_0.RegisterPreviewCallBack(arg_11_0, arg_11_1)
	if arg_11_1 and arg_11_0.canPreView ~= false then
		arg_11_0.previewCallBack = arg_11_1
	end
end

function var_0_0.DelTemplateCallBack(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_0.DelTemplate = arg_12_1
	end
end

function var_0_0.SaveTemplateCallBack(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0.SaveTemplate = arg_13_1
	end
end

function var_0_0.ReviseNameCallBack(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0.ReviseCallBack = arg_14_1
	end
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
