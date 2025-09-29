module("frameworkext.lmvc.view.ViewMgr", package.seeall)

local var_0_0 = class("ViewMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._viewMgrImpl = nil
end

function var_0_0.init(arg_2_0, arg_2_1, ...)
	if not arg_2_0._viewMgrImpl then
		arg_2_0._viewMgrImpl = arg_2_1.New()

		arg_2_0._viewMgrImpl:init(...)
	end
end

function var_0_0.getUIRoot(arg_3_0)
	return arg_3_0._viewMgrImpl:getUIRoot()
end

function var_0_0.getRoot(arg_4_0, arg_4_1)
	return arg_4_0._viewMgrImpl:getRoot(arg_4_1)
end

function var_0_0.getUIWidth(arg_5_0)
	return arg_5_0._viewMgrImpl:getUIWidth()
end

function var_0_0.getUIHeight(arg_6_0)
	return arg_6_0._viewMgrImpl:getUIHeight()
end

function var_0_0.getUICanvas(arg_7_0)
	return arg_7_0._viewMgrImpl:getUICanvas()
end

function var_0_0.open(arg_8_0, arg_8_1, ...)
	arg_8_0._viewMgrImpl:open(arg_8_1, ...)
end

function var_0_0.openSpecialView(arg_9_0, arg_9_1, ...)
	arg_9_0._viewMgrImpl:openSpecialView(arg_9_1, ...)
end

function var_0_0.preCreate(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._viewMgrImpl:preCreate(arg_10_1, arg_10_2)
end

function var_0_0.isOpen(arg_11_0, arg_11_1)
	return arg_11_0._viewMgrImpl:isOpen(arg_11_1)
end

function var_0_0.isClosed(arg_12_0, arg_12_1)
	return not arg_12_0:isOpen(arg_12_1)
end

function var_0_0.jumpToMainView(arg_13_0, arg_13_1, ...)
	arg_13_0._viewMgrImpl:jumpToMainView(arg_13_1, ...)
end

function var_0_0.close(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_0._viewMgrImpl:close(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
end

function var_0_0.closeAllViews(arg_15_0, arg_15_1)
	arg_15_0._viewMgrImpl:closeAllViews()
end

function var_0_0.destroy(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0._viewMgrImpl:destroy(arg_16_1, arg_16_2, arg_16_3)
end

function var_0_0.clearSomeViewFromBackStack(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._viewMgrImpl:clearSomeViewFromBackStack(arg_17_1, arg_17_2)
end

function var_0_0._openPreFullUpView(arg_18_0)
	arg_18_0._viewMgrImpl:_openPreFullUpView()
end

function var_0_0.printDebugInfo(arg_19_0)
	arg_19_0._viewMgrImpl:printDebugInfo()
end

function var_0_0.clear(arg_20_0)
	if arg_20_0._viewMgrImpl then
		arg_20_0._viewMgrImpl:clear()

		arg_20_0._viewMgrImpl = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
