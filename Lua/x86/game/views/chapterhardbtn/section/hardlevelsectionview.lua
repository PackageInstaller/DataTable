local var_0_0 = class("HardLevelSectionView", import("..HardLevelBaseView"))

function var_0_0.GetHardLevelItem(arg_1_0)
	return HardLevelSectionItem
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.SetData(arg_2_0, arg_2_1)

	arg_2_0.collectPercentage_ = arg_2_2

	arg_2_0:RefreshCollectPercentage()
end

function var_0_0.RefreshCollectPercentage(arg_3_0)
	arg_3_0.percentageText_.text = string.format("%s%%", math.floor(arg_3_0.collectPercentage_ * 100))
end

return var_0_0
