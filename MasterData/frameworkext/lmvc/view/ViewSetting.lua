module("frameworkext.lmvc.view.ViewSetting", package.seeall)

local var_0_0 = WindowType.WindowShowType
local var_0_1 = WindowType.WindowResourceType
local var_0_2 = class("ViewSetting")

function var_0_2.init(arg_1_0, arg_1_1)
	arg_1_0._setting = arg_1_1
end

function var_0_2.isSupportBack(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._setting[arg_2_1]

	return var_2_0 and var_2_0.isSupportBack ~= false
end

function var_0_2.getSyncOpenList(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._setting[arg_3_1]

	if var_3_0 then
		return var_3_0.syncOpenList
	end

	return nil
end

function var_0_2.getSyncCloseList(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._setting[arg_4_1]

	if var_4_0 then
		return var_4_0.syncCloseList
	end

	return nil
end

function var_0_2.getAutoDestroyTime(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._setting[arg_5_1]

	if var_5_0 then
		return var_5_0.autoDestroyTime or 0
	end

	return 0
end

function var_0_2._getViewResourceType(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._setting[arg_6_1]
	local var_6_1 = var_0_1.NoneResourceType

	if var_6_0 then
		var_6_1 = var_6_0.resourceType or var_0_0.AutoResourceType
	end

	return var_6_1
end

function var_0_2.isResourceType(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_2 == arg_7_0:_getViewResourceType(arg_7_1)
end

function var_0_2.isResidentResourceType(arg_8_0, arg_8_1)
	return var_0_1.ResidentResourceType == arg_8_0:_getViewResourceType(arg_8_1)
end

function var_0_2.isImmediateDestoryResourceType(arg_9_0, arg_9_1)
	return var_0_1.ImmediateDestoryResourceType == arg_9_0:_getViewResourceType(arg_9_1)
end

function var_0_2.getViewWindowType(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._setting[arg_10_1]
	local var_10_1 = var_0_0.NormalShowType

	if var_10_0 then
		var_10_1 = var_10_0.showType or var_0_0.ModalShowType
	end

	return var_10_1
end

function var_0_2.isWindowType(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_2 == arg_11_0:getViewWindowType(arg_11_1)
end

function var_0_2.isNormalView(arg_12_0, arg_12_1)
	return var_0_0.NormalShowType == arg_12_0:getViewWindowType(arg_12_1)
end

function var_0_2.isFullScreen(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getViewWindowType(arg_13_1)

	return var_0_0.FullScreenShowType == var_13_0 or var_0_0.FullScreenHudShowType == var_13_0
end

function var_0_2.isOnlyFullScreen(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getViewWindowType(arg_14_1)

	return var_0_0.FullScreenShowType == var_14_0
end

function var_0_2.isPreClose(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._setting[arg_15_1]

	return var_15_0 and var_15_0.isPreClose
end

function var_0_2.isModal(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getViewWindowType(arg_16_1)

	return var_0_0.ModalShowType == var_16_0
end

function var_0_2.getPresentorName(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._setting[arg_17_1]

	return var_17_0 and var_17_0.presentor
end

function var_0_2.getExtId(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._setting[arg_18_1]

	if var_18_0 then
		return var_18_0.extId
	end

	return nil
end

function var_0_2.getMaskColor(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._setting[arg_19_1]

	return var_19_0 and var_19_0.maskColor
end

function var_0_2.isBlock(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._setting[arg_20_1]

	return var_20_0 and var_20_0.isBlock
end

function var_0_2.isRepel(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._setting[arg_21_1]

	return var_21_0 and var_21_0.isRepel
end

var_0_2.instance = var_0_2.New()

return var_0_2
