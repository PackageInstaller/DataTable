module("frameworkext.lmvc.view.ViewElementsRegistry", package.seeall)

local var_0_0 = class("ViewElementsRegistry")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._myUGUIViewElementsRegistry = nil
	arg_1_0._myCacheUIElements = nil
	arg_1_0._falseUIElements = nil
	arg_1_0.mainGO = arg_1_1
end

function var_0_0.setMainGO(arg_2_0, arg_2_1)
	arg_2_0.mainGO = arg_2_1
end

function var_0_0.getMainGO(arg_3_0)
	return arg_3_0.mainGO
end

local var_0_1 = "GameObject"
local var_0_2 = "@"
local var_0_3 = "function"

function var_0_0.findUIElement(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_0:_cacheUIElement(arg_4_1, arg_4_2 or var_0_1)
end

function var_0_0._cacheUIElement(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._myCacheUIElements == nil then
		arg_5_0._myCacheUIElements = {}
	end

	local var_5_0 = arg_5_0:_getUIElementGo(arg_5_1, arg_5_0:getMainGO())

	if var_5_0 ~= "" and not goutil.isNil(var_5_0) then
		local var_5_1

		if type(arg_5_2) == var_0_3 then
			var_5_1 = arg_5_2(var_5_0)
		elseif arg_5_2 == var_0_1 then
			var_5_1 = var_5_0
		else
			var_5_1 = var_5_0:GetComponent(arg_5_2)
		end

		if goutil.isNil(var_5_1) then
			local var_5_2 = arg_5_0:_falseUIElementForMiss(arg_5_1, arg_5_2, arg_5_0:getMainGO().transform)

			printError("这个key的节点没有此类型的组件，提供一个作假组件内存防止卡死：", tostring(var_5_2))

			return var_5_2
		end

		return var_5_1
	else
		local var_5_3 = arg_5_0:_falseUIElementForMiss(arg_5_1, arg_5_2, arg_5_0:getMainGO().transform)

		printError("这个key没找到元素的节点，提供一个作假元素节点，增加一个组件内存防止卡死：", tostring(var_5_3))

		return var_5_3
	end
end

function var_0_0._getUIElementGo(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = 1

	if arg_6_0._myCacheUIElements[arg_6_1] == nil then
		arg_6_0._myCacheUIElements[arg_6_1] = {}
		arg_6_0._myCacheUIElements[arg_6_1][1] = var_6_0

		local var_6_1 = arg_6_0:_getUGUIViewElementsRegistry(arg_6_2)

		if var_6_1 then
			local var_6_2 = var_6_1:GetGameObjectByName(arg_6_1)

			if var_6_2 ~= nil then
				for iter_6_0 = 0, var_6_2.Length - 1 do
					arg_6_0._myCacheUIElements[arg_6_1][iter_6_0 + 2] = var_6_2[iter_6_0]
				end
			else
				arg_6_0._myCacheUIElements[arg_6_1][2] = ""
			end
		else
			arg_6_0._myCacheUIElements[arg_6_1][2] = ""

			printError("预置物未找到登记处无法获取元素", arg_6_2.name)
		end
	end

	local var_6_3 = arg_6_0._myCacheUIElements[arg_6_1][1]

	var_6_3 = var_6_3 + 1 > #arg_6_0._myCacheUIElements[arg_6_1] and 2 or var_6_3 + 1

	local var_6_4 = arg_6_0._myCacheUIElements[arg_6_1][var_6_3]

	arg_6_0._myCacheUIElements[arg_6_1][1] = var_6_3

	return var_6_4
end

function var_0_0._falseUIElementForMiss(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_0._falseUIElements == nil then
		arg_7_0._falseUIElements = {}
	end

	if arg_7_0._falseUIElements[arg_7_1] == nil or arg_7_0._falseUIElements[arg_7_1][arg_7_2] == nil or goutil.isNil(arg_7_0._falseUIElements[arg_7_1][arg_7_2]) then
		if arg_7_0._falseUIElements[arg_7_1] == nil then
			arg_7_0._falseUIElements[arg_7_1] = {}
		end

		local var_7_0 = goutil.create("", true)

		if type(arg_7_2) == var_0_3 then
			local var_7_1 = arg_7_2(var_7_0)

			var_7_0.name = arg_7_1 .. var_0_2 .. tostring(var_7_1)
			arg_7_0._falseUIElements[arg_7_1][arg_7_2] = var_7_1
		elseif arg_7_2 == var_0_1 then
			var_7_0.name = arg_7_1 .. var_0_2 .. var_0_1
			arg_7_0._falseUIElements[arg_7_1][arg_7_2] = var_7_0
		else
			var_7_0.name = arg_7_1 .. var_0_2 .. tostring(arg_7_2)
			arg_7_0._falseUIElements[arg_7_1][arg_7_2] = var_7_0:GetComponent(arg_7_2) or var_7_0:AddComponent(arg_7_2)
		end

		var_7_0.transform:SetParent(arg_7_3)
		Astral.TransformUtil.SetAnchoredPos(var_7_0.transform, 10000, 0)
		Astral.TransformUtil.SetLocalScale(var_7_0.transform, 1, 1, 1)
	end

	return arg_7_0._falseUIElements[arg_7_1][arg_7_2]
end

function var_0_0._getUGUIViewElementsRegistry(arg_8_0, arg_8_1)
	if not goutil.isNil(arg_8_1) then
		if arg_8_0._myUGUIViewElementsRegistry == nil then
			arg_8_0._myUGUIViewElementsRegistry = arg_8_1:GetComponent(typeof(Astral.UGUIViewElementsRegistry))
		end
	else
		printError("预置物还未实例化无法获取元素")
	end

	return arg_8_0._myUGUIViewElementsRegistry
end

function var_0_0.getUIComponent(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0:findUIElement(arg_9_1, arg_9_2)
end

function var_0_0.getImage(arg_10_0, arg_10_1)
	return arg_10_0:findUIElement(arg_10_1, UIComponentType.Image)
end

function var_0_0.getText(arg_11_0, arg_11_1)
	return arg_11_0:findUIElement(arg_11_1, UIComponentType.Text)
end

function var_0_0.getGo(arg_12_0, arg_12_1)
	return arg_12_0:findUIElement(arg_12_1)
end

function var_0_0.getBtn(arg_13_0, arg_13_1)
	return arg_13_0:findUIElement(arg_13_1, UIComponentType.ButtonAdapter)
end

function var_0_0.getSourceBtn(arg_14_0, arg_14_1)
	return arg_14_0:findUIElement(arg_14_1, UIComponentType.Button)
end

function var_0_0.getInput(arg_15_0, arg_15_1)
	return arg_15_0:findUIElement(arg_15_1, UIComponentType.InputFieldAdapter)
end

function var_0_0.getSlider(arg_16_0, arg_16_1)
	return arg_16_0:findUIElement(arg_16_1, UIComponentType.SliderAdapter)
end

function var_0_0.getBigBg(arg_17_0, arg_17_1)
	return arg_17_0:findUIElement(arg_17_1, UIComponentType.ImageBigBG)
end

function var_0_0.getScrollRect(arg_18_0, arg_18_1)
	return arg_18_0:findUIElement(arg_18_1, UIComponentType.ScrollRectAdapter)
end

function var_0_0.getTransform(arg_19_0, arg_19_1)
	return arg_19_0:findUIElement(arg_19_1).transform
end

function var_0_0.getRectTransform(arg_20_0, arg_20_1)
	return arg_20_0:findUIElement(arg_20_1, UIComponentType.RectTransform)
end

function var_0_0.getCanvasGroup(arg_21_0, arg_21_1)
	return arg_21_0:findUIElement(arg_21_1, ComponentType.CanvasGroup)
end

function var_0_0.getUIComponentByPath(arg_22_0, arg_22_1, arg_22_2)
	return goutil.findChildComponent(arg_22_0.mainGO, arg_22_1, arg_22_2)
end

function var_0_0.getImageByPath(arg_23_0, arg_23_1)
	return goutil.findChildImageComponent(arg_23_0.mainGO, arg_23_1)
end

function var_0_0.getTextByPath(arg_24_0, arg_24_1)
	return goutil.findChildTextComponent(arg_24_0.mainGO, arg_24_1)
end

function var_0_0.getGoByPath(arg_25_0, arg_25_1)
	return goutil.findChild(arg_25_0.mainGO, arg_25_1)
end

function var_0_0.getBtnByPath(arg_26_0, arg_26_1)
	return Astral.ButtonAdapter.GetFrom(arg_26_0.mainGO, arg_26_1)
end

function var_0_0.getInputByPath(arg_27_0, arg_27_1)
	return Astral.InputFieldAdapter.GetFrom(arg_27_0.mainGO, arg_27_1)
end

function var_0_0.cleanRegistry(arg_28_0)
	arg_28_0._myUGUIViewElementsRegistry = nil

	if arg_28_0._myCacheUIElements then
		table.clear(arg_28_0._myCacheUIElements)

		arg_28_0._myCacheUIElements = nil
	end

	if arg_28_0._falseUIElements then
		table.clear(arg_28_0._falseUIElements)

		arg_28_0._falseUIElements = nil
	end

	arg_28_0.mainGO = nil
end

return var_0_0
