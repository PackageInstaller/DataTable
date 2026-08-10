local var_0_0 = class("SummerRaceEquipSlotItemView", ReduxView)
local var_0_1 = "UI_icon_cx"

local function var_0_2(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0:GetOrAddComponent(arg_1_1, typeof(EventTriggerListener))

	var_1_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function()
		arg_1_2()
	end))
	arg_1_0:SetListener(var_1_0)
end

local function var_0_3(arg_3_0)
	local var_3_0 = (arg_3_0.slotVisualType or arg_3_0.slotType) == SummerRaceConst.FILTER.EQUIP and "weapon_" or "parts_"
	local var_3_1 = arg_3_0.slotState or "normal"

	if var_3_1 ~= "dragging" and var_3_1 ~= "hover" and var_3_1 ~= "blocked" and var_3_1 ~= "replace" then
		var_3_1 = arg_3_0.isEmpty ~= true and arg_3_0.isLocked ~= true and "equipped" or "normal"
	end

	return var_3_0 .. var_3_1
end

local function var_0_4(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0 == nil or arg_4_1 == nil then
		return
	end

	arg_4_0.enabled = true

	arg_4_0:Play(arg_4_1, -1, arg_4_2 or 0)
	arg_4_0:Update(0)
end

local function var_0_5(arg_5_0, arg_5_1)
	if arg_5_1 ~= true then
		var_0_4(arg_5_0.partAni_, var_0_1, 1)
		var_0_4(arg_5_0.weaponAni_, var_0_1, 1)
		SetActive(arg_5_0.partsEquipBloomGo_, false)
		SetActive(arg_5_0.weaponEquipBloomGo_, false)

		return
	end

	SetActive(arg_5_0.partsEquipBloomGo_, true)
	SetActive(arg_5_0.weaponEquipBloomGo_, true)
	var_0_4(arg_5_0.partAni_, var_0_1, 0)
	var_0_4(arg_5_0.weaponAni_, var_0_1, 0)
end

local function var_0_6(arg_6_0, arg_6_1)
	if arg_6_1 ~= true then
		var_0_5(arg_6_0, false)

		arg_6_0.equipAnimActive_ = false

		return
	end

	if arg_6_0.equipAnimActive_ ~= true then
		var_0_5(arg_6_0, true)
	end

	arg_6_0.equipAnimActive_ = true
end

local function var_0_7(arg_7_0, arg_7_1)
	if arg_7_0 == nil or arg_7_1 == nil or arg_7_0.slotType == arg_7_1.typeText or arg_7_0.isEmpty ~= true then
		return nil
	end

	return arg_7_0.slotType == SummerRaceConst.FILTER.EQUIP and "weapon_grey" or "parts_grey"
end

function var_0_0.OnCtor(arg_8_0, arg_8_1)
	arg_8_0.gameObject_ = arg_8_1
	arg_8_0.transform_ = arg_8_1.transform

	arg_8_0:Init()
end

function var_0_0.Init(arg_9_0)
	arg_9_0:BindCfgUI()

	arg_9_0.appearanceController_ = arg_9_0.controllerEx_ and arg_9_0.controllerEx_:GetController("appearance") or nil

	var_0_2(arg_9_0, arg_9_0.icon_.gameObject, function()
		if arg_9_0.clickHandler_ ~= nil and arg_9_0.slotData_ ~= nil and arg_9_0.slotData_.itemClickEnabled == true then
			arg_9_0.clickHandler_(arg_9_0.index_, arg_9_0.slotData_, "select")
		end
	end)
	var_0_2(arg_9_0, arg_9_0.dragAreaObj_, function()
		if arg_9_0.clickHandler_ ~= nil and arg_9_0.slotData_ ~= nil and arg_9_0.slotData_.itemClickEnabled == true then
			arg_9_0.clickHandler_(arg_9_0.index_, arg_9_0.slotData_, "select")
		end
	end)
end

function var_0_0.SetData(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0.slotData_ = arg_12_1
	arg_12_0.index_ = arg_12_2
	arg_12_0.clickHandler_ = arg_12_3

	arg_12_0:RefreshView()
end

function var_0_0.SetDragOptionData(arg_13_0, arg_13_1)
	arg_13_0.dragOptionData_ = arg_13_1

	arg_13_0:RefreshView()
end

function var_0_0.SetAppearanceState(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.appearanceController_ == nil or arg_14_1 == nil then
		return
	end

	if arg_14_2 ~= true and arg_14_0.currentAppearanceState_ == arg_14_1 then
		return
	end

	arg_14_0.currentAppearanceState_ = arg_14_1

	arg_14_0.appearanceController_:SetSelectedState(arg_14_1)
end

function var_0_0.RefreshView(arg_15_0)
	local var_15_0 = arg_15_0.slotData_.isLocked == true
	local var_15_1 = arg_15_0.slotData_.isEmpty == true
	local var_15_2 = not var_15_0 and not var_15_1
	local var_15_3 = var_0_7(arg_15_0.slotData_, arg_15_0.dragOptionData_) or var_0_3(arg_15_0.slotData_)
	local var_15_4 = var_15_1 or arg_15_0.slotData_.slotState ~= "normal"
	local var_15_5 = var_15_2 and arg_15_0.slotData_.playEquipAnim == true

	if arg_15_0.icon_ ~= nil then
		local var_15_6 = not var_15_2 or var_15_4
		local var_15_7 = var_15_2 and not var_15_4

		if var_15_6 then
			arg_15_0:SetAppearanceState(var_15_3)
			var_0_6(arg_15_0, var_15_5)
		elseif var_15_7 then
			arg_15_0:SetAppearanceState(var_15_3, var_15_5)
			var_0_6(arg_15_0, var_15_5)
		else
			var_0_6(arg_15_0, false)

			arg_15_0.icon_.color = Color.New(1, 1, 1, 1)
		end
	end
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.slotData_ = nil
	arg_16_0.clickHandler_ = nil
	arg_16_0.dragOptionData_ = nil
	arg_16_0.currentAppearanceState_ = nil
	arg_16_0.equipAnimActive_ = nil

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
