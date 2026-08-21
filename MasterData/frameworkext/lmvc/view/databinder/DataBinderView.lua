module("frameworkext.lmvc.view.databinder.DataBinderView", package.seeall)

local var_0_0 = class("DataBinderView", ViewComponent)

var_0_0.OnScrBlankViewUpdate = "OnScrBlankViewUpdate"

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._dataProvider = arg_1_1
	arg_1_0._isShow = false
	arg_1_0._isDirty = true
	arg_1_0._blankPrefabUrl = arg_1_2
	arg_1_0._blankRootPath = arg_1_3
	arg_1_0._params = arg_1_4
	arg_1_0._resBlankInstance = nil
end

function var_0_0.buildUI(arg_2_0)
	if arg_2_0._dataProvider then
		arg_2_0._dataProvider:addDataBinder(arg_2_0)
	end

	if arg_2_0._blankPrefabUrl then
		arg_2_0._resBlankInstance = arg_2_0:getResInstance(arg_2_0._blankPrefabUrl)

		if arg_2_0._resBlankInstance and not goutil.isNil(arg_2_0._resBlankInstance) then
			local var_2_0 = arg_2_0:getGo(arg_2_0._blankRootPath)

			goutil.addChildToParent(arg_2_0._resBlankInstance, var_2_0)
		end
	end
end

function var_0_0.onUpdateData(arg_3_0)
	if arg_3_0._isShow then
		arg_3_0:refreshView()
	else
		arg_3_0._isDirty = true
	end
end

function var_0_0.destroyUI(arg_4_0)
	arg_4_0:onExit()
	arg_4_0._dataProvider:removeDataBinder(arg_4_0)

	arg_4_0._dataProvider = nil

	if arg_4_0._resBlankInstance and not goutil.isNil(arg_4_0._resBlankInstance) then
		goutil.destroy(arg_4_0._resBlankInstance)
	end

	arg_4_0._resBlankInstance = nil
end

function var_0_0.onEnter(arg_5_0)
	arg_5_0._isShow = true

	if arg_5_0._isDirty then
		arg_5_0:refreshView()
	end
end

function var_0_0.onExit(arg_6_0)
	arg_6_0:onExitFinished()
end

function var_0_0.onExitFinished(arg_7_0)
	arg_7_0._isShow = false
end

function var_0_0.refreshView(arg_8_0)
	arg_8_0._isDirty = false
end

function var_0_0.updateScrBlankView(arg_9_0, arg_9_1)
	if arg_9_0._resBlankInstance and not goutil.isNil(arg_9_0._resBlankInstance) then
		local var_9_0 = arg_9_1 <= 0

		if var_9_0 then
			arg_9_0:localNotify(var_0_0.OnScrBlankViewUpdate, arg_9_0._resBlankInstance, arg_9_0._params)
		end

		goutil.setActive(arg_9_0._resBlankInstance, var_9_0)
	end
end

function var_0_0.setSelectItems(arg_10_0, arg_10_1)
	return
end

function var_0_0.selectCells(arg_11_0, arg_11_1, arg_11_2)
	return
end

function var_0_0.selectCell(arg_12_0, arg_12_1, arg_12_2)
	return
end

function var_0_0.selectCell(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	return
end

return var_0_0
