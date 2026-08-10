local var_0_0 = class("AssetPendData")

function var_0_0.Init(arg_1_0)
	arg_1_0.expandContentList_ = {}
	arg_1_0.deleteFlag_ = false
	arg_1_0.deletePackageList_ = {}
	arg_1_0.deleteLanguageList_ = {}
	arg_1_0.deletePackageSize_ = "0.00KB"
	arg_1_0.needCalcDeletePackageFlag_ = true
end

function var_0_0.SetExpandContent(arg_2_0, arg_2_1)
	if arg_2_0.expandContentList_[arg_2_1] ~= nil then
		arg_2_0.expandContentList_[arg_2_1] = not arg_2_0.expandContentList_[arg_2_1]
	else
		arg_2_0.expandContentList_[arg_2_1] = true
	end
end

function var_0_0.GetExpandContent(arg_3_0, arg_3_1)
	if arg_3_0.expandContentList_[arg_3_1] == nil then
		return false
	else
		return arg_3_0.expandContentList_[arg_3_1]
	end
end

function var_0_0.ClearExpandContent(arg_4_0)
	arg_4_0.expandContentList_ = {}
end

function var_0_0.SetDeleteFlag(arg_5_0, arg_5_1)
	arg_5_0.deleteFlag_ = arg_5_1
end

function var_0_0.GetDeleteFlag(arg_6_0)
	return arg_6_0.deleteFlag_
end

function var_0_0.AddDeletePackage(arg_7_0, arg_7_1)
	if table.keyof(arg_7_0.deletePackageList_, arg_7_1) then
		return
	end

	table.insert(arg_7_0.deletePackageList_, arg_7_1)

	arg_7_0.needCalcDeletePackageFlag_ = true
end

function var_0_0.RemoveDeletePackage(arg_8_0, arg_8_1)
	table.removebyvalue(arg_8_0.deletePackageList_, arg_8_1)

	arg_8_0.needCalcDeletePackageFlag_ = true
end

function var_0_0.GetDeletePackageList(arg_9_0)
	return arg_9_0.deletePackageList_
end

function var_0_0.GetRemoveAssetPendListSize(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.needCalcDeletePackageFlag_ ~= false then
		arg_10_0.needCalcDeletePackageFlag_ = false
		arg_10_0.deletePackageSize_ = manager.assetPend:GetRemoveAssetPendListSize(arg_10_1, arg_10_2)
	end

	return arg_10_0.deletePackageSize_
end

function var_0_0.ClearDeletePackageList(arg_11_0)
	arg_11_0.deletePackageList_ = {}
	arg_11_0.deleteLanguageList_ = {}
	arg_11_0.needCalcDeletePackageFlag_ = true
end

function var_0_0.SetNeedRecalc(arg_12_0)
	arg_12_0.needCalcDeletePackageFlag_ = true
end

function var_0_0.GetDeleteLanguageList(arg_13_0)
	return arg_13_0.deleteLanguageList_
end

function var_0_0.AddDeleteLanguage(arg_14_0, arg_14_1)
	if table.keyof(arg_14_0.deleteLanguageList_, arg_14_1) then
		return
	end

	table.insert(arg_14_0.deleteLanguageList_, arg_14_1)

	arg_14_0.needCalcDeletePackageFlag_ = true
end

function var_0_0.RemoveDeleteLanguage(arg_15_0, arg_15_1)
	table.removebyvalue(arg_15_0.deleteLanguageList_, arg_15_1)

	arg_15_0.needCalcDeletePackageFlag_ = true
end

return var_0_0
