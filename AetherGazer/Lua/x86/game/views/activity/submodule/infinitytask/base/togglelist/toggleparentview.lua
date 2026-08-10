local var_0_0 = class("ToggleParentView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_2
	arg_1_0.childrenCnt_ = arg_1_3

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.childrenItemList_ = {}

	for iter_1_0 = 1, arg_1_3 do
		arg_1_0.childrenItemList_[iter_1_0] = ToggleChildrenView.New(arg_1_0[string.format("toggleChildren%s_", iter_1_0)], arg_1_2, iter_1_0)
	end

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.toggle_.transform, "toggle")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.toggle_, nil, function()
		manager.notify:Invoke(TOGGLE_LIST_CHILDREN_UPDATE, arg_2_0.index_, arg_2_0.childrenIndex_)
	end)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.childrenItemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.childrenItemList_ = nil
end

function var_0_0.SetSelectOn(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.childrenItemList_) do
		iter_5_1:SetSelectOn(arg_5_2)
	end

	local var_5_0 = arg_5_0.index_ == arg_5_1

	if var_5_0 then
		arg_5_0.controller_:SetSelectedState("on")

		arg_5_0.childrenIndex_ = arg_5_2
	else
		arg_5_0.controller_:SetSelectedState("off")
	end

	SetActive(arg_5_0.goChildren_, var_5_0)
end

return var_0_0
