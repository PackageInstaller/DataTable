local var_0_0 = class("EquipBreakThroughMaterialTeamInfoView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.itemList_ = {}
end

function var_0_0.OnEnter(arg_2_0)
	for iter_2_0 = 1, 3 do
		if arg_2_0.itemList_[iter_2_0] == nil then
			arg_2_0.itemList_[iter_2_0] = EquipBreakThroughMaterialTeamInfoItem.New(arg_2_0.itemGo_, arg_2_0.itemParent_, iter_2_0)
		end

		arg_2_0.itemList_[iter_2_0]:OnEnter()
	end
end

function var_0_0.OnEixt(arg_3_0)
	for iter_3_0, iter_3_1 in ipiars(itemList_) do
		iter_3_1:OnExit()
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.itemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.itemList_ = nil
end

return var_0_0
