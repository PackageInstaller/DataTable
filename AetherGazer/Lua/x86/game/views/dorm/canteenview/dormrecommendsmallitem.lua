local var_0_0 = class("DormRecommendSmallItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1.type

	arg_4_0.recIcon_.sprite = CanteenTools.GetFilterIcon(var_4_0, arg_4_1.tag)

	local var_4_1 = CanteenEntrustData:GetCurDispatchTask().pos
	local var_4_2 = CanteenEntrustData:GetEntrustByPos(var_4_1).tags

	for iter_4_0, iter_4_1 in ipairs(var_4_2) do
		if iter_4_1.type == var_4_0 and iter_4_1.tag == arg_4_1.tag then
			arg_4_0.statusController_:SetSelectedState("lightup")

			return
		end
	end

	arg_4_0.statusController_:SetSelectedState("normal")
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
