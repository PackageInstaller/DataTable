local var_0_0 = class("SummerRaceWeaponOptionItemView", ReduxView)

local function var_0_1(arg_1_0)
	if arg_1_0 == nil then
		return
	end

	local var_1_0 = arg_1_0:GetComponent(typeof(Button))

	if var_1_0 ~= nil then
		var_1_0.interactable = false
		var_1_0.enabled = false
	end

	local var_1_1 = arg_1_0:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true)

	if var_1_1 ~= nil then
		for iter_1_0 = 0, var_1_1.Length - 1 do
			local var_1_2 = var_1_1[iter_1_0]

			if var_1_2 ~= nil then
				var_1_2.raycastTarget = false
			end
		end
	end
end

local function var_0_2(arg_2_0, arg_2_1)
	if arg_2_1 == nil then
		return tostring(arg_2_0 and arg_2_0.costState or "white")
	end

	return (tonumber(arg_2_1) or 0) >= (tonumber(arg_2_0 and arg_2_0.cost) or 0) and "white" or "red"
end

local function var_0_3(arg_3_0)
	local var_3_0 = arg_3_0.clickGo_ or arg_3_0.gameObject_

	return var_3_0 and var_3_0.transform or arg_3_0.transform_
end

function var_0_0.OnCtor(arg_4_0, arg_4_1)
	arg_4_0.gameObject_ = arg_4_1
	arg_4_0.transform_ = arg_4_1.transform

	arg_4_0:Init()
end

function var_0_0.Init(arg_5_0)
	arg_5_0:BindCfgUI()
	var_0_1(arg_5_0.clickGo_ or arg_5_0.gameObject_)

	arg_5_0.typeController_ = arg_5_0.controllerEx_:GetController("type")
	arg_5_0.costController_ = arg_5_0.controllerEx_:GetController("cost")
	arg_5_0.selectController_ = arg_5_0.controllerEx_:GetController("select")
	arg_5_0.lockController_ = arg_5_0.controllerEx_:GetController("lock")
end

function var_0_0.BindRedPoint(arg_6_0)
	if arg_6_0.optionData_ ~= nil and arg_6_0.optionData_.redPointKey ~= nil then
		manager.redPoint:bindUIandKey(var_0_3(arg_6_0), arg_6_0.optionData_.redPointKey)
	end
end

function var_0_0.UnbindRedPoint(arg_7_0)
	if arg_7_0.optionData_ ~= nil and arg_7_0.optionData_.redPointKey ~= nil then
		manager.redPoint:unbindUIandKey(var_0_3(arg_7_0), arg_7_0.optionData_.redPointKey)
	end
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0:UnbindRedPoint()

	arg_8_0.optionData_ = arg_8_1
	arg_8_0.index_ = arg_8_2
	arg_8_0.clickHandler_ = arg_8_3

	arg_8_0:BindRedPoint()
	arg_8_0:RefreshView()
end

function var_0_0.RefreshView(arg_9_0)
	if arg_9_0.optionData_ == nil then
		SetActive(arg_9_0.gameObject_, false)

		return
	end

	SetActive(arg_9_0.gameObject_, true)

	local var_9_0 = tostring(arg_9_0.optionData_.iconPath or "")

	arg_9_0.icon_.spriteSync = var_9_0 ~= "" and var_9_0 or nil

	if arg_9_0.nameText_ ~= nil then
		arg_9_0.nameText_.text = tostring(arg_9_0.optionData_.itemName or "")
	end

	arg_9_0.costText_.text = tostring(arg_9_0.optionData_.cost or "")

	arg_9_0.typeController_:SetSelectedState(arg_9_0.optionData_.typeText == "equip" and "parts" or "weapon")
	arg_9_0.costController_:SetSelectedState(var_0_2(arg_9_0.optionData_, arg_9_0.availableCost_))
	arg_9_0.selectController_:SetSelectedState(arg_9_0.optionData_.isSelected and "show" or "hide")
	arg_9_0.lockController_:SetSelectedState(arg_9_0.optionData_.isUnlocked and "false" or "true")
end

function var_0_0.RefreshCostStateByAvailableCost(arg_10_0, arg_10_1)
	if arg_10_0.optionData_ == nil or arg_10_0.costController_ == nil then
		return
	end

	arg_10_0.availableCost_ = arg_10_1

	local var_10_0 = var_0_2(arg_10_0.optionData_, arg_10_0.availableCost_)

	arg_10_0.optionData_.costState = var_10_0

	arg_10_0.costController_:SetSelectedState(var_10_0)
end

function var_0_0.ClearAvailableCostState(arg_11_0)
	arg_11_0.availableCost_ = nil
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:UnbindRedPoint()

	arg_12_0.optionData_ = nil
	arg_12_0.clickHandler_ = nil
	arg_12_0.availableCost_ = nil

	arg_12_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
