local var_0_0 = class("OathOptionsBubbleItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.finishController_ = arg_1_0.controller_:GetController("finish")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if arg_2_0.data and arg_2_0.data.clickCallback then
			LuaExchangeHelper.ActionInvoke(arg_2_0.data.clickCallback)
		end
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.data = arg_4_1

	arg_4_0:RefreshUI()
	arg_4_0:ChangeOrder()
	arg_4_0:RefreshFinishUI()
end

function var_0_0.Remove(arg_5_0)
	if arg_5_0.data then
		arg_5_0.data.clickCallback = nil
	end

	arg_5_0.data = nil
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.bubbleText_.text = GetTips(arg_6_0.data.tipsKey)
end

function var_0_0.ChangeOrder(arg_7_0)
	arg_7_0.transform_:SetSiblingIndex(arg_7_0.data.order + 1)
end

function var_0_0.RefreshFinishUI(arg_8_0)
	if arg_8_0.data and arg_8_0.data.isFinish then
		arg_8_0.finishController_:SetSelectedState("finish")
	else
		arg_8_0.finishController_:SetSelectedState("normal")
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:Remove()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
