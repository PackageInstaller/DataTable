local var_0_0 = class("BloodCardBuildCardTabItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.stateController_ = arg_2_0.controller_:GetController("tab")
	arg_2_0.useController_ = arg_2_0.controller_:GetController("used")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickCallBack_ then
			arg_3_0.clickCallBack_(arg_3_0.index_)
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.editBtn_, nil, function()
		if arg_3_0.renameClickCallBack_ then
			arg_3_0.renameClickCallBack_(arg_3_0.index_)
		end
	end)
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = BloodCardData:GetCardGroup(arg_6_0.index_)

	if #var_6_0 > 0 and arg_6_0.selected_ then
		arg_6_0.stateController_:SetSelectedState("select")
	elseif #var_6_0 > 0 and not arg_6_0.selected_ then
		arg_6_0.stateController_:SetSelectedState("normal")
	elseif #var_6_0 == 0 and arg_6_0.selected_ then
		arg_6_0.stateController_:SetSelectedState("edit")
	elseif #var_6_0 == 0 and not arg_6_0.selected_ then
		arg_6_0.stateController_:SetSelectedState("add")
	end

	arg_6_0.useController_:SetSelectedState(tostring(arg_6_0.index_ == BloodCardData:GetUsingCardIndex()))

	arg_6_0.text_.text = BloodCardData:GetCardGroupName(arg_6_0.index_)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.index_ = arg_7_1

	arg_7_0:RefreshUI()
end

function var_0_0.SetClickCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickCallBack_ = arg_8_1
end

function var_0_0.SetRenameCallBack(arg_9_0, arg_9_1)
	arg_9_0.renameClickCallBack_ = arg_9_1
end

function var_0_0.SelectTab(arg_10_0, arg_10_1)
	arg_10_0.selected_ = arg_10_1 == arg_10_0.index_

	arg_10_0:RefreshUI()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
