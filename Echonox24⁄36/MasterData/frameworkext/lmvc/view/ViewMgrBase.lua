module("frameworkext.lmvc.view.ViewMgrBase", package.seeall)

local var_0_0 = WindowType.WindowOpenReasonType
local var_0_1 = WindowType.WindowCloseReasonType
local var_0_2 = class("ViewMgrBase")

function var_0_2.ctor(arg_1_0)
	arg_1_0._views = nil
	arg_1_0._backStack = nil
end

function var_0_2.init(arg_2_0, ...)
	arg_2_0._views = {}
	arg_2_0._backStack = ViewStack.New()
	arg_2_0._curFullscreenNeedDestoryViewMap = {}
end

function var_0_2.open(arg_3_0, arg_3_1, ...)
	if not arg_3_0:_openCheck(arg_3_1, ...) then
		return
	end

	if arg_3_0:isOpen(arg_3_1) then
		arg_3_0:reOpenView(arg_3_1, ...)
	else
		local var_3_0 = {
			...
		}
		local var_3_1 = arg_3_0:_createViewObj(arg_3_1)

		if var_3_1 then
			local var_3_2 = var_0_0.NormalOpenType

			arg_3_0._backStack:push(arg_3_0:_createViewInfo(arg_3_1, var_3_0))
			arg_3_0:_beforeOpen(arg_3_1, var_3_2, false)
			var_3_1:open(var_3_0, var_3_2, false)
			arg_3_0:_afterOpen(arg_3_1, var_3_2, false)

			if arg_3_0:isFullScreen(arg_3_1) then
				arg_3_0:_destoryFullscreenNeedViews()
			end
		end
	end
end

function var_0_2.backOpen(arg_4_0, arg_4_1, ...)
	if arg_4_0:isOpen(arg_4_1) then
		arg_4_0:reOpenView(arg_4_1, ...)
	else
		local var_4_0 = {
			...
		}
		local var_4_1 = arg_4_0:_createViewObj(arg_4_1)

		if var_4_1 then
			local var_4_2 = var_0_0.QuickOpenType

			arg_4_0:_beforeOpen(arg_4_1, var_4_2, true)
			var_4_1:open(var_4_0, var_4_2, true)
			arg_4_0:_afterOpen(arg_4_1, var_4_2, true)
		end
	end
end

function var_0_2.openSpecialView(arg_5_0, arg_5_1, ...)
	if not arg_5_0:isOpen(arg_5_1) then
		local var_5_0 = {
			...
		}
		local var_5_1 = arg_5_0:_createViewObj(arg_5_1)

		if var_5_1 then
			local var_5_2 = var_0_0.NormalOpenType

			arg_5_0:_beforeOpen(arg_5_1, var_5_2, false)
			var_5_1:open(var_5_0)
			arg_5_0:_afterOpen(arg_5_1, var_5_2, false)
		end
	end
end

function var_0_2.jumpToMainView(arg_6_0, arg_6_1, ...)
	if not arg_6_0:isOpen(arg_6_1) then
		local var_6_0 = arg_6_0._backStack:getSize()
		local var_6_1 = false

		for iter_6_0 = var_6_0, 1, -1 do
			local var_6_2 = arg_6_0._backStack:getDataByIndex(iter_6_0)

			if var_6_2 then
				if arg_6_0:_isResidentResourceType(var_6_2.viewName) then
					arg_6_0:close(var_6_2.viewName, false, var_0_1.QuickCloseType, true)
				else
					arg_6_0:destroy(var_6_2.viewName)
				end
			end
		end

		arg_6_0._backStack:clear()
		arg_6_0:open(arg_6_1, ...)
	end
end

function var_0_2.close(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if not arg_7_0:isOpen(arg_7_1) then
		return
	end

	local var_7_0 = arg_7_0._views[arg_7_1]

	if var_7_0 then
		arg_7_0:_beforeClose(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
		var_7_0:close(arg_7_3)

		if arg_7_0:_isImmediateDestoryResourceType(arg_7_1) then
			arg_7_0:destroy(arg_7_1)
		end

		arg_7_0:_afterClose(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	end
end

function var_0_2.closeAllViews(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._backStack:getSize()
	local var_8_1 = false

	for iter_8_0 = var_8_0, 1, -1 do
		local var_8_2 = arg_8_0._backStack:getDataByIndex(iter_8_0)

		arg_8_0:close(var_8_2.viewName, false, arg_8_1)
	end
end

function var_0_2.preCreate(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._views[arg_9_1] then
		return
	end

	local var_9_0 = arg_9_0:_createViewObj(arg_9_1, arg_9_2)

	if var_9_0 then
		var_9_0:loadViewResources()
	end
end

function var_0_2.isOpen(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._views[arg_10_1]

	return var_10_0 and var_10_0:isOpen()
end

function var_0_2.isClosed(arg_11_0, arg_11_1)
	return not arg_11_0:isOpen(arg_11_1)
end

function var_0_2.reOpenView(arg_12_0, arg_12_1, ...)
	local var_12_0 = arg_12_0._backStack:peek()

	if not var_12_0 or var_12_0.viewName ~= arg_12_1 then
		arg_12_0:close(arg_12_1, false, var_0_1.QuickCloseType, false)
		arg_12_0:open(arg_12_1, ...)
	end
end

function var_0_2.isFullScreen(arg_13_0, arg_13_1)
	return false
end

function var_0_2.getBackStackIsEmpty(arg_14_0)
	return arg_14_0._backStack:isEmpty()
end

function var_0_2.isCacheView(arg_15_0, arg_15_1)
	return arg_15_0._views[arg_15_1]
end

function var_0_2.getBackStackTopView(arg_16_0)
	if not arg_16_0._backStack:isEmpty() then
		return arg_16_0._views[arg_16_0._backStack:peek()[1]]
	end
end

function var_0_2.destroy(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0._views[arg_17_1]

	if var_17_0 then
		arg_17_0:close(arg_17_1, arg_17_2)

		if arg_17_0._views[arg_17_1] then
			var_17_0:destroy(arg_17_3)
		end
	end

	arg_17_0._views[arg_17_1] = nil
end

function var_0_2.printDebugInfo(arg_18_0)
	arg_18_0._backStack:printStack()
end

function var_0_2.clear(arg_19_0)
	return
end

function var_0_2._createViewInfo(arg_20_0, arg_20_1, arg_20_2)
	return {
		viewName = arg_20_1,
		openParam = arg_20_2
	}
end

function var_0_2._openCheck(arg_21_0, arg_21_1, ...)
	return true
end

function var_0_2._createViewObj(arg_22_0, arg_22_1, arg_22_2)
	return
end

function var_0_2._beforeOpen(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	return
end

function var_0_2._afterOpen(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	return
end

function var_0_2._preOpenDispatchEvent(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	return
end

function var_0_2._beforeClose(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	return
end

function var_0_2._afterClose(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	return
end

function var_0_2._isImmediateDestoryResourceType(arg_28_0, arg_28_1)
	return false
end

function var_0_2._isResidentResourceType(arg_29_0, arg_29_1)
	return false
end

return var_0_2
