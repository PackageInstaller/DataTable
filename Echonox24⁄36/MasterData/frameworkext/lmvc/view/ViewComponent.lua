module("frameworkext.lmvc.view.ViewComponent", package.seeall)

local var_0_0 = class("ViewComponent")

function var_0_0.ctor(arg_1_0)
	arg_1_0.mainGO = nil
	arg_1_0._viewPresentor = nil
	arg_1_0._specifiedRegistryLevel = ""
end

function var_0_0.setViewPresentor(arg_2_0, arg_2_1)
	arg_2_0._viewPresentor = arg_2_1
end

function var_0_0.bindEvents(arg_3_0)
	return
end

function var_0_0.unbindEvents(arg_4_0)
	return
end

function var_0_0.buildUI(arg_5_0)
	return
end

function var_0_0.destroyUI(arg_6_0)
	return
end

function var_0_0.onEnter(arg_7_0, arg_7_1)
	return
end

function var_0_0.onEnterFinished(arg_8_0)
	return
end

function var_0_0.onExit(arg_9_0, arg_9_1)
	return
end

function var_0_0.onExitFinished(arg_10_0)
	return
end

function var_0_0.setSpecifiedRegistryLevel(arg_11_0, arg_11_1)
	arg_11_0._specifiedRegistryLevel = arg_11_1
end

function var_0_0.specifiedLevelKey(arg_12_0, arg_12_1)
	return arg_12_0._specifiedRegistryLevel .. arg_12_1
end

function var_0_0.getUIComponent(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0._viewPresentor:findUIElement(arg_13_1, arg_13_2)
end

function var_0_0.getImage(arg_14_0, arg_14_1)
	return arg_14_0._viewPresentor:getViewElementsRegistry():getImage(arg_14_1)
end

function var_0_0.getText(arg_15_0, arg_15_1)
	return arg_15_0._viewPresentor:getViewElementsRegistry():getText(arg_15_1)
end

function var_0_0.getGo(arg_16_0, arg_16_1)
	return arg_16_0._viewPresentor:findUIElement(arg_16_1)
end

function var_0_0.getRectTransform(arg_17_0, arg_17_1)
	return arg_17_0._viewPresentor:getViewElementsRegistry():getRectTransform(arg_17_1)
end

function var_0_0.getBtn(arg_18_0, arg_18_1)
	return arg_18_0._viewPresentor:getViewElementsRegistry():getBtn(arg_18_1)
end

function var_0_0.getSourceBtn(arg_19_0, arg_19_1)
	return arg_19_0._viewPresentor:getViewElementsRegistry():getSourceBtn(arg_19_1)
end

function var_0_0.getInput(arg_20_0, arg_20_1)
	return arg_20_0._viewPresentor:getViewElementsRegistry():getInput(arg_20_1)
end

function var_0_0.getSlider(arg_21_0, arg_21_1)
	return arg_21_0._viewPresentor:getViewElementsRegistry():getSlider(arg_21_1)
end

function var_0_0.getBigBg(arg_22_0, arg_22_1)
	return arg_22_0._viewPresentor:getViewElementsRegistry():getBigBg(arg_22_1)
end

function var_0_0.getScrollRect(arg_23_0, arg_23_1)
	return arg_23_0._viewPresentor:getViewElementsRegistry():getScrollRect(arg_23_1)
end

function var_0_0.getTransform(arg_24_0, arg_24_1)
	return arg_24_0._viewPresentor:getViewElementsRegistry():getTransform(arg_24_1)
end

function var_0_0.getRectTransform(arg_25_0, arg_25_1)
	return arg_25_0._viewPresentor:getViewElementsRegistry():getRectTransform(arg_25_1)
end

function var_0_0.getCanvasGroup(arg_26_0, arg_26_1)
	return arg_26_0._viewPresentor:getViewElementsRegistry():getCanvasGroup(arg_26_1)
end

function var_0_0.getUIComponentByPath(arg_27_0, arg_27_1, arg_27_2)
	return arg_27_0._viewPresentor:getViewElementsRegistry():getUIComponentByPath(arg_27_1, arg_27_2)
end

function var_0_0.getImageByPath(arg_28_0, arg_28_1)
	return arg_28_0._viewPresentor:getViewElementsRegistry():getImageByPath(arg_28_1)
end

function var_0_0.getTextByPath(arg_29_0, arg_29_1)
	return arg_29_0._viewPresentor:getViewElementsRegistry():getTextByPath(arg_29_1)
end

function var_0_0.getGoByPath(arg_30_0, arg_30_1)
	return arg_30_0._viewPresentor:getViewElementsRegistry():getGoByPath(arg_30_1)
end

function var_0_0.getBtnByPath(arg_31_0, arg_31_1)
	return arg_31_0._viewPresentor:getViewElementsRegistry():getBtnByPath(arg_31_1)
end

function var_0_0.getInputByPath(arg_32_0, arg_32_1)
	return arg_32_0._viewPresentor:getViewElementsRegistry():getInputByPath(arg_32_1)
end

function var_0_0.registerLocalNotify(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	arg_33_0._viewPresentor:registerLocalNotify(arg_33_1, arg_33_2, arg_33_3)
end

function var_0_0.unregisterLocalNotify(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_0._viewPresentor:unregisterLocalNotify(arg_34_1, arg_34_2, arg_34_3)
end

function var_0_0.localNotify(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0._viewPresentor:localNotify(arg_35_1, arg_35_2)
end

function var_0_0.getRes(arg_36_0, arg_36_1)
	return arg_36_0._viewPresentor:getRes(arg_36_1)
end

function var_0_0.getPrefab(arg_37_0, arg_37_1)
	return arg_37_0._viewPresentor:getPrefab(arg_37_1)
end

function var_0_0.getResInstance(arg_38_0, arg_38_1)
	return arg_38_0._viewPresentor:getResInstance(arg_38_1)
end

function var_0_0.getOpenParam(arg_39_0)
	return arg_39_0._viewPresentor:getOpenParam()
end

function var_0_0.getFirstParam(arg_40_0)
	return arg_40_0._viewPresentor:getFirstParam()
end

function var_0_0.close(arg_41_0)
	ViewMgr.instance:close(arg_41_0._viewPresentor:getViewName())
end

function var_0_0.back(arg_42_0)
	ViewMgr.instance:close(arg_42_0._viewPresentor:getViewName(), true)
end

function var_0_0.viewIsClosing(arg_43_0)
	if arg_43_0._viewPresentor._status == ViewPresentor.kViewStatusClosing then
		return true
	end
end

return var_0_0
