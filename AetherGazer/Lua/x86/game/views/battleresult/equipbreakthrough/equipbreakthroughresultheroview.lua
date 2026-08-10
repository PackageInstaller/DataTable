local var_0_0 = class("EquipBreakThroughResultHeroView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.heroItemList_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.heroItemList_[iter_1_0] = EquipBreakThroughResultHeroItem.New(arg_1_0[string.format("heroGo%s_", iter_1_0)], iter_1_0)
	end
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.heroItemList_) do
		iter_2_1:SetData(arg_2_1)
	end
end

function var_0_0.OnExit(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.heroItemList_) do
		iter_3_1:OnExit()
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.heroItemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.heroItemList_ = nil
end

return var_0_0
