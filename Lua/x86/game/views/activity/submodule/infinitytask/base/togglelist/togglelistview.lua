local var_0_0 = class("ToggleListView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.parentItemList_ = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		arg_1_0.parentItemList_[iter_1_0] = ToggleParentView.New(arg_1_0[string.format("toggleParent%s_", iter_1_0)], iter_1_0, iter_1_1)
	end

	arg_1_0.childrenHandler_ = handler(arg_1_0, arg_1_0.ChildrenUpdate)
end

function var_0_0.OnEnter(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.parentItemList_) do
		iter_2_1:OnEnter()
	end

	manager.notify:RegistListener(TOGGLE_LIST_CHILDREN_UPDATE, arg_2_0.childrenHandler_)
end

function var_0_0.OnExit(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.parentItemList_) do
		iter_3_1:OnExit()
	end

	manager.notify:RemoveListener(TOGGLE_LIST_CHILDREN_UPDATE, arg_3_0.childrenHandler_)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.parentItemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.parentItemList_ = nil
	arg_4_0.childrenHandler_ = nil
end

function var_0_0.SetSelectOn(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.parentItemList_) do
		iter_5_1:SetSelectOn(arg_5_1, arg_5_2)
	end

	manager.notify:Invoke(TOGGLE_LIST_UPDATE, arg_5_1, arg_5_2)
end

function var_0_0.ChildrenUpdate(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:SetSelectOn(arg_6_1, arg_6_2)
end

return var_0_0
