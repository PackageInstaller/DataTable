local var_0_0 = class("GoldMinerSectionInfoThreeStarBar", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.sectionTargets_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.sectionTargets_[iter_1_0] = GoldMinerSectionTargetItem.New(arg_1_0[string.format("targetItem%s_", iter_1_0)], iter_1_0)
	end

	SetActive(arg_1_0.targetPanel_, true)
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.sectionTargets_) do
		iter_2_1:Dispose()
	end

	arg_2_0.sectionTargets_ = {}

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		arg_3_0.sectionTargets_[iter_3_0]:Refresh(iter_3_1[1], iter_3_1[2], iter_3_1[3])
	end
end

return var_0_0
