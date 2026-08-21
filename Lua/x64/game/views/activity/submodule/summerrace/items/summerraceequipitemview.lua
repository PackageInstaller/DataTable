local var_0_0 = class("SummerRaceEquipItemView", ReduxView)
local var_0_1 = Vector2.New(488, 268)
local var_0_2 = Vector3.New(0.2, 0.2, 0.2)

local function var_0_3(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0:GetOrAddComponent(arg_1_1, typeof(EventTriggerListener))

	var_1_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function()
		arg_1_2()
	end))
	arg_1_0:SetListener(var_1_0)
end

local function var_0_4(arg_3_0)
	local var_3_0 = (arg_3_0.slotVisualType or arg_3_0.slotType) == SummerRaceConst.FILTER.EQUIP and "weapon_" or "parts_"
	local var_3_1 = arg_3_0.slotState or "normal"

	if var_3_1 ~= "dragging" and var_3_1 ~= "hover" and var_3_1 ~= "blocked" then
		var_3_1 = "normal"
	end

	return var_3_0 .. var_3_1
end

local function var_0_5(arg_4_0)
	local var_4_0 = arg_4_0.slotVisualType or arg_4_0.slotType

	if var_4_0 == SummerRaceConst.FILTER.BODY then
		return "disable"
	end

	return var_4_0 == SummerRaceConst.FILTER.EQUIP and "using" or "enable"
end

function var_0_0.OnCtor(arg_5_0, arg_5_1)
	arg_5_0.gameObject_ = arg_5_1
	arg_5_0.transform_ = arg_5_1.transform

	arg_5_0:Init()
end

function var_0_0.Init(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.stateController_ = arg_6_0.controllerEx_ and arg_6_0.controllerEx_:GetController("state") or nil
	arg_6_0.lockController_ = arg_6_0.controllerEx_ and arg_6_0.controllerEx_:GetController("mask") or nil
	arg_6_0.selectController_ = arg_6_0.controllerEx_ and arg_6_0.controllerEx_:GetController("select") or nil
	arg_6_0.appearanceController_ = arg_6_0.controllerEx_ and arg_6_0.controllerEx_:GetController("type") or nil
	arg_6_0.emptyController_ = arg_6_0.controllerEx_ and arg_6_0.controllerEx_:GetController("empty") or nil
	arg_6_0.iconRectTransform_ = arg_6_0.icon_ ~= nil and arg_6_0.icon_.transform:GetComponent("RectTransform") or nil
	arg_6_0.defaultIconSizeDelta_ = arg_6_0.iconRectTransform_ ~= nil and arg_6_0.iconRectTransform_.sizeDelta or nil
	arg_6_0.defaultIconLocalScale_ = arg_6_0.iconRectTransform_ ~= nil and arg_6_0.iconRectTransform_.localScale or nil

	var_0_3(arg_6_0, arg_6_0.icon_.gameObject, function()
		if arg_6_0.clickHandler_ ~= nil and arg_6_0.slotData_ ~= nil and arg_6_0.slotData_.itemClickEnabled == true then
			arg_6_0.clickHandler_(arg_6_0.index_, arg_6_0.slotData_, "select", arg_6_0)
		end
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.slotData_ = arg_8_1
	arg_8_0.index_ = arg_8_2
	arg_8_0.clickHandler_ = arg_8_3

	arg_8_0:RefreshView()
end

function var_0_0.RefreshIconTransform(arg_9_0, arg_9_1)
	if arg_9_0.iconRectTransform_ == nil then
		return
	end

	if (arg_9_1.slotVisualType or arg_9_1.slotType) == SummerRaceConst.FILTER.BODY then
		arg_9_0.iconRectTransform_.sizeDelta = var_0_1
		arg_9_0.iconRectTransform_.localScale = var_0_2

		return
	end

	if arg_9_0.defaultIconSizeDelta_ ~= nil then
		arg_9_0.iconRectTransform_.sizeDelta = arg_9_0.defaultIconSizeDelta_
	end

	if arg_9_0.defaultIconLocalScale_ ~= nil then
		arg_9_0.iconRectTransform_.localScale = arg_9_0.defaultIconLocalScale_
	end
end

function var_0_0.RefreshView(arg_10_0)
	local var_10_0 = arg_10_0.slotData_.isLocked == true
	local var_10_1 = arg_10_0.slotData_.isEmpty == true
	local var_10_2 = arg_10_0.slotData_.isSelected == true
	local var_10_3 = not var_10_0 and not var_10_1
	local var_10_4 = var_0_5(arg_10_0.slotData_)
	local var_10_5 = var_10_1 or arg_10_0.slotData_.slotState ~= "normal"
	local var_10_6 = tostring(arg_10_0.slotData_.iconPath or "")

	if arg_10_0.stateController_ ~= nil then
		arg_10_0.stateController_:SetSelectedState(var_10_3 and "filled" or "empty")
	end

	if arg_10_0.lockController_ ~= nil then
		arg_10_0.lockController_:SetSelectedState(var_10_0 and "lock" or "unlock")
	end

	if arg_10_0.selectController_ ~= nil then
		arg_10_0.selectController_:SetSelectedState(var_10_2 and "true" or "false")
	end

	if arg_10_0.emptyController_ ~= nil then
		arg_10_0.emptyController_:SetSelectedState(var_10_1 and "true" or "NotCostShow")
	end

	if arg_10_0.icon_ ~= nil then
		arg_10_0:RefreshIconTransform(arg_10_0.slotData_)

		local var_10_7 = not var_10_3 or var_10_5
		local var_10_8 = var_10_3 and not var_10_5
		local var_10_9 = var_10_8 and (arg_10_0.slotData_.showEquippedIcon == true or arg_10_0.slotData_.interactionMode == "inspect")

		if var_10_7 then
			arg_10_0.icon_.color = Color.New(1, 1, 1, 1)
			arg_10_0.icon_.raycastTarget = true
			arg_10_0.icon_.spriteSync = nil

			if arg_10_0.appearanceController_ ~= nil then
				arg_10_0.appearanceController_:SetSelectedState(var_10_4)
			end
		elseif var_10_8 then
			if arg_10_0.appearanceController_ ~= nil then
				arg_10_0.appearanceController_:SetSelectedState(var_10_4)
			end

			SetActive(arg_10_0.icon_.gameObject, true)

			arg_10_0.icon_.spriteSync = var_10_6 ~= "" and var_10_6 or nil
			arg_10_0.icon_.color = var_10_9 and Color.New(1, 1, 1, 1) or Color.New(1, 1, 1, 0)
			arg_10_0.icon_.raycastTarget = true
		else
			arg_10_0.icon_.color = Color.New(1, 1, 1, 1)
			arg_10_0.icon_.raycastTarget = true
		end
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.slotData_ = nil
	arg_11_0.clickHandler_ = nil
	arg_11_0.iconRectTransform_ = nil
	arg_11_0.defaultIconSizeDelta_ = nil
	arg_11_0.defaultIconLocalScale_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
