local var_0_0 = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceBodyTipsView")
local var_0_1 = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceOptionTipsView")
local var_0_2 = class("SummerRaceModifyView", ReduxView)
local var_0_3 = {
	MODIFY = "modify",
	CHALLENGE = "challenge",
	STAGE_DETAIL = "stageDetail"
}
local var_0_4 = "UI_Activity_SummerRace_CarModifyUI_cx"
local var_0_5 = "UI_Activity_SummerRace_CarModifyUI_xs"
local var_0_6 = "UI_Activity_SummerRace_BattleInfoUI_xs"
local var_0_7 = 0.033
local var_0_8 = 1
local var_0_9 = "UI_car_2"
local var_0_10 = 1.8
local var_0_11 = "display"
local var_0_12 = "disappear"
local var_0_13 = 0.65
local var_0_14 = 0.18
local var_0_15 = 1.2
local var_0_16 = "minigame_activity_3_5"
local var_0_17 = "minigame_activity_3_5_key_up"
local var_0_18 = "minigame_activity_2_1"
local var_0_19 = "minigame_activity_2_1_connect_cancel"
local var_0_20 = "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/item/Activity_SummerRace_EquipSlotItem"
local var_0_21 = "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/item/carModifyItem"
local var_0_22 = "Widget/System/Activity_SummerRace/com/propertiesItem"
local var_0_23 = 12
local var_0_24 = 8
local var_0_25 = 12
local var_0_26 = "Assets/ABResources/SummerRaceActivity/Spine/Weapon/SummerRaceWeapon_Boomerang/SummerRaceWeapon_Boomerang_SkeletonData.asset"
local var_0_27 = "Assets/ABResources/SummerRaceActivity/Spine/Weapon/SummerRaceWeapon_Boomerang_Out/SummerRaceWeapon_Boomerang_SkeletonData.asset"
local var_0_28 = {
	MOVE_IN = "moveIn",
	NORMAL = "normal",
	NONE = "none"
}

local function var_0_29(arg_1_0)
	return arg_1_0 == "equip" and "parts" or arg_1_0 or "all"
end

local function var_0_30(arg_2_0, arg_2_1)
	if arg_2_0 == nil then
		return
	end

	local var_2_0 = arg_2_0:GetController("select")

	if var_2_0 == nil then
		return
	end

	var_2_0:SetSelectedState(arg_2_1 and "show" or "hide")
end

local function var_0_31()
	manager.audio:PlayEffect(var_0_16, var_0_17, "")
end

local function var_0_32()
	manager.audio:PlayEffect(var_0_18, var_0_19, "")
end

local function var_0_33()
	local var_5_0 = manager and manager.ui and manager.ui.canvas

	if var_5_0 == nil then
		return nil
	end

	return var_5_0:GetComponent("Canvas").worldCamera
end

local function var_0_34(arg_6_0)
	if type(arg_6_0) ~= "string" or arg_6_0 == "" then
		return ""
	end

	local var_6_0 = string.gsub(arg_6_0, "\\", "/")
	local var_6_1 = "Assets/ABResources/"

	if string.sub(var_6_0, 1, #var_6_1) == var_6_1 then
		var_6_0 = string.sub(var_6_0, #var_6_1 + 1)
	end

	return var_6_0
end

local function var_0_35(arg_7_0)
	return var_0_34(arg_7_0) == var_0_34(var_0_26)
end

local function var_0_36(arg_8_0, arg_8_1)
	if arg_8_0 == nil or arg_8_1 == nil then
		return nil
	end

	local var_8_0, var_8_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_8_0, arg_8_1, var_0_33(), nil)

	return var_8_1
end

local function var_0_37(arg_9_0, arg_9_1)
	if arg_9_0 == nil or arg_9_1 == nil then
		return false
	end

	return UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(arg_9_0, arg_9_1, var_0_33())
end

local function var_0_38(arg_10_0, arg_10_1)
	if not var_0_37(arg_10_0, arg_10_1) then
		return nil
	end

	local var_10_0 = var_0_36(arg_10_0, arg_10_1)

	if var_10_0 == nil then
		return nil
	end

	local var_10_1 = arg_10_0.rect
	local var_10_2 = (var_10_1.xMin + var_10_1.xMax) * 0.5
	local var_10_3 = (var_10_1.yMin + var_10_1.yMax) * 0.5
	local var_10_4 = var_10_0.x - var_10_2
	local var_10_5 = var_10_0.y - var_10_3

	return var_10_4 * var_10_4 + var_10_5 * var_10_5
end

local function var_0_39(arg_11_0)
	if arg_11_0 == nil then
		return nil
	end

	if arg_11_0.dragAreaObj_ ~= nil then
		return arg_11_0.dragAreaObj_.transform
	end

	return arg_11_0.transform_
end

local function var_0_40(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1 and arg_12_1.moduleSize or nil
	local var_12_1 = tonumber(arg_12_1 and arg_12_1.moduleScale) or 1

	if var_12_1 <= 0 then
		var_12_1 = 1
	end

	local var_12_2 = 1
	local var_12_3 = arg_12_0 and arg_12_0.sizeDelta or nil
	local var_12_4 = var_12_3 and tonumber(var_12_3.x) or 0
	local var_12_5 = var_12_3 and tonumber(var_12_3.y) or 0
	local var_12_6 = (var_12_0 and tonumber(var_12_0.x) or 0) * SummerRaceConst.DISPLAY.CANVAS_SCALE
	local var_12_7 = (var_12_0 and tonumber(var_12_0.y) or 0) * SummerRaceConst.DISPLAY.CANVAS_SCALE

	if var_12_4 > 0 and var_12_5 > 0 and var_12_6 > 0 and var_12_7 > 0 then
		var_12_2 = math.min(var_12_6 / var_12_4, var_12_7 / var_12_5)
	end

	return var_12_2 * var_12_1
end

local function var_0_41(arg_13_0, arg_13_1)
	local var_13_0 = var_0_34(arg_13_1)

	if var_13_0 == "" then
		error("[SummerRaceModifyView] invalid drag preview spine asset path: " .. tostring(arg_13_1))
	end

	local var_13_1 = Asset.Load(var_13_0)

	if var_13_1 == nil then
		error("[SummerRaceModifyView] missing drag preview spine asset: " .. tostring(var_13_0))
	end

	arg_13_0.skeletonDataAsset = var_13_1
	arg_13_0.initialSkinName = ""
	arg_13_0.startingAnimation = ""
	arg_13_0.startingLoop = true

	arg_13_0:Initialize(true)
	arg_13_0:UpdateMesh()

	arg_13_0.color = Color.New(1, 1, 1, 1)
end

local function var_0_42(arg_14_0, arg_14_1)
	local var_14_0 = var_0_36(arg_14_0, arg_14_1)

	if var_14_0 == nil then
		return false
	end

	return var_14_0.y > arg_14_0.rect.yMax
end

local function var_0_43(arg_15_0, arg_15_1)
	local var_15_0 = var_0_34(arg_15_0 and arg_15_0.skeletonDataPath or "")

	if var_15_0 == "" then
		return nil
	end

	local var_15_1 = Asset.Load(var_15_0)

	if var_15_1 == nil then
		error("[SummerRaceModifyView] missing drag preview spine asset: " .. tostring(var_15_0))
	end

	local var_15_2 = GameObject("OptionDragSpinePreview")
	local var_15_3 = var_15_2:AddComponent(typeof(RectTransform))
	local var_15_4 = var_15_2:AddComponent(typeof(Spine.Unity.SkeletonGraphic))

	var_15_2.transform:SetParent(arg_15_1, false)

	var_15_3.anchorMin = Vector2.New(0.5, 0.5)
	var_15_3.anchorMax = Vector2.New(0.5, 0.5)
	var_15_3.pivot = Vector2.New(0.5, 0.5)
	var_15_3.anchoredPosition = Vector2.zero
	var_15_3.localScale = Vector3.one
	var_15_3.localEulerAngles = Vector3.zero
	var_15_3.sizeDelta = Vector2.zero
	var_15_4.raycastTarget = false
	var_15_4.skeletonDataAsset = var_15_1
	var_15_4.initialSkinName = ""
	var_15_4.startingAnimation = ""
	var_15_4.startingLoop = true

	var_15_4:Initialize(true)
	var_15_4:MatchRectTransformWithBounds()

	local var_15_5 = SummerRaceConst.DISPLAY.CANVAS_SCALE / 100

	var_15_3.sizeDelta = Vector2.New(var_15_3.sizeDelta.x * var_15_5, var_15_3.sizeDelta.y * var_15_5)

	var_15_4:UpdateMesh()

	var_15_4.color = Color.New(1, 1, 1, 1)

	local var_15_6 = var_0_40(var_15_3, arg_15_0)

	var_15_3.localScale = Vector3.New(var_15_6, var_15_6, var_15_6)

	if var_0_35(arg_15_0 and arg_15_0.skeletonDataPath or "") then
		var_0_41(var_15_4, var_0_27)
	end

	return var_15_2
end

local function var_0_44(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_0 = arg_16_0:GetOrAddComponent(arg_16_1, typeof(EventTriggerListener))

	var_16_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_17_0, arg_17_1)
		arg_16_2(arg_17_1)
	end))
	var_16_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_18_0, arg_18_1)
		arg_16_3(arg_18_1)
	end))
	var_16_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_19_0, arg_19_1)
		arg_16_4(arg_19_1)
	end))
	var_16_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_20_0, arg_20_1)
		arg_16_5(arg_20_1)
	end))
	arg_16_0:SetListener(var_16_0)

	return var_16_0
end

local function var_0_45(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	local var_21_0 = arg_21_0:GetOrAddComponent(arg_21_1, typeof(EventTriggerListener))

	var_21_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_22_0, arg_22_1)
		arg_21_2(arg_22_1)
	end))
	var_21_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_23_0, arg_23_1)
		arg_21_3(arg_23_1)
	end))
	var_21_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_24_0, arg_24_1)
		arg_21_4(arg_24_1)
	end))
	var_21_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_25_0, arg_25_1)
		arg_21_5(arg_25_1)
	end))
	arg_21_0:SetListener(var_21_0)

	return var_21_0
end

local function var_0_46(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0 and tonumber(arg_26_0.x) or 0
	local var_26_1 = arg_26_0 and tonumber(arg_26_0.y) or 0
	local var_26_2 = arg_26_1 and tonumber(arg_26_1.x) or 0
	local var_26_3 = arg_26_1 and tonumber(arg_26_1.y) or 0

	return math.abs(var_26_2 - var_26_0), math.abs(var_26_3 - var_26_1)
end

local function var_0_47(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0, var_27_1 = var_0_46(arg_27_0, arg_27_1)

	return var_27_0 <= arg_27_2 and var_27_1 <= arg_27_2
end

local function var_0_48(arg_28_0, arg_28_1)
	if arg_28_0 == nil or arg_28_0 == "" then
		return tostring(arg_28_1 or "-")
	end

	return tostring(arg_28_0)
end

local function var_0_49(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = tonumber(arg_29_1) or 0
	local var_29_1 = tonumber(arg_29_2) or 0

	if var_29_1 <= 0 then
		error("[SummerRaceModifyView] invalid property max value for `" .. tostring(arg_29_0) .. "`")
	end

	return {
		type = arg_29_0,
		value = tostring(arg_29_3 ~= nil and arg_29_3 or var_29_0),
		currentValue = var_29_0,
		maxValue = var_29_1
	}
end

local function var_0_50(arg_30_0)
	if arg_30_0 == nil then
		return nil
	end

	if arg_30_0.typeText == SummerRaceConst.FILTER.EQUIP then
		return {
			panelType = "equip",
			title = arg_30_0.itemName,
			cost = arg_30_0.cost,
			desc = arg_30_0.desc,
			properties = {
				var_0_49("Skill", arg_30_0.energyCost, SummerRaceData:GetPropertyMax("Skill", arg_30_0.typeText), var_0_48(arg_30_0.energyCost, 0))
			}
		}
	end

	return {
		panelType = "weapon",
		title = arg_30_0.itemName,
		cost = arg_30_0.cost,
		desc = arg_30_0.desc,
		properties = {
			var_0_49("ATK", arg_30_0.damage, SummerRaceData:GetPropertyMax("ATK", arg_30_0.typeText), var_0_48(arg_30_0.damage, 0)),
			var_0_49("ROF", arg_30_0.rof, SummerRaceData:GetPropertyMax("ROF", arg_30_0.typeText), var_0_48(arg_30_0.rof, 0)),
			var_0_49("Skill", arg_30_0.energyCost, SummerRaceData:GetPropertyMax("Skill", arg_30_0.typeText), var_0_48(arg_30_0.energyCost, 0))
		}
	}
end

local function var_0_51(arg_31_0)
	if arg_31_0 == nil then
		return nil
	end

	return {
		title = tostring(arg_31_0.bodyName or ""),
		desc = tostring(arg_31_0.desc or arg_31_0.bodyDesc or ""),
		hpText = var_0_48(arg_31_0.hp, 0),
		costText = var_0_48(arg_31_0.cost, 0)
	}
end

local function var_0_52(arg_32_0)
	if arg_32_0 == nil then
		return ""
	end

	return tostring(arg_32_0.slotType or "") .. "|" .. tostring(arg_32_0.slotIndex or 0)
end

local function var_0_53(arg_33_0, arg_33_1)
	return tostring(arg_33_0 or "") .. "|" .. tostring(arg_33_1 or 0)
end

local function var_0_54(arg_34_0)
	for iter_34_0 = 1, #(arg_34_0 or {}) do
		local var_34_0 = arg_34_0[iter_34_0]

		if var_34_0 ~= nil and var_34_0.isLocked ~= true and var_34_0.itemId ~= nil and tostring(var_34_0.itemId) ~= "" then
			return var_34_0
		end
	end

	return nil
end

local function var_0_55(arg_35_0, arg_35_1)
	if arg_35_1 == nil or arg_35_1 == "" then
		return nil
	end

	for iter_35_0 = 1, #(arg_35_0 or {}) do
		local var_35_0 = arg_35_0[iter_35_0]

		if var_0_52(var_35_0) == arg_35_1 then
			return var_35_0
		end
	end

	return nil
end

local function var_0_56(arg_36_0)
	local var_36_0 = {}

	for iter_36_0 = 1, #(arg_36_0 or {}) do
		local var_36_1 = arg_36_0[iter_36_0]
		local var_36_2 = var_36_1.localPosition or {}
		local var_36_3 = var_36_1.displayLocalPosition or {}

		var_36_0[#var_36_0 + 1] = string.format("%s|%s|%s|%s|%s|%s|%s|%s", tostring(var_36_1.slotType or ""), tostring(var_36_1.slotIndex or 0), tostring(var_36_1.mountName or ""), tostring(var_36_2.x or 0), tostring(var_36_2.y or 0), tostring(var_36_3.x or 0), tostring(var_36_3.y or 0), tostring(var_36_1.localAngle or 0))
	end

	return table.concat(var_36_0, ";")
end

local function var_0_57(arg_37_0)
	arg_37_0 = arg_37_0 or {}

	return string.format("%s|%s|%s", tostring(arg_37_0.panelType or ""), tostring(arg_37_0.filterType or ""), tostring(arg_37_0.stageId or ""))
end

local function var_0_58(arg_38_0, arg_38_1)
	return tostring(arg_38_0 or "none") .. "|" .. tostring(arg_38_1 or "")
end

local function var_0_59(arg_39_0)
	local var_39_0 = SummerRaceConst.DISPLAY.CANVAS_SCALE
	local var_39_1 = arg_39_0 and tonumber(arg_39_0.x) or 0
	local var_39_2 = arg_39_0 and tonumber(arg_39_0.y) or 0

	return Vector2.New(var_39_1 * var_39_0, -var_39_2 * var_39_0)
end

local function var_0_60(arg_40_0)
	local var_40_0 = arg_40_0 and tonumber(arg_40_0.x) or 0
	local var_40_1 = arg_40_0 and tonumber(arg_40_0.y) or 0

	return string.format("(%.4f,%.4f)", var_40_0, var_40_1)
end

local function var_0_61(arg_41_0, arg_41_1)
	if arg_41_0 ~= nil and type(arg_41_0.ConvertBodyLocalPointToUiPosition) == "function" then
		local var_41_0 = arg_41_0:ConvertBodyLocalPointToUiPosition(arg_41_1)

		if var_41_0 ~= nil then
			return Vector2.New(var_41_0.x, var_41_0.y)
		end
	end

	error("[SummerRaceModifyView] missing vehicleDisplayView body-local to UI conversion when building slot positions")
end

local function var_0_62(arg_42_0, arg_42_1)
	if arg_42_1 == nil then
		return nil
	end

	if arg_42_0 ~= nil and type(arg_42_0.ConvertDisplayLocalPointToUiPosition) == "function" then
		local var_42_0 = arg_42_0:ConvertDisplayLocalPointToUiPosition(arg_42_1)

		if var_42_0 ~= nil then
			return Vector2.New(var_42_0.x, var_42_0.y)
		end
	end

	local var_42_1 = SummerRaceConst.DISPLAY.CANVAS_SCALE
	local var_42_2 = arg_42_1 and tonumber(arg_42_1.x) or 0
	local var_42_3 = arg_42_1 and tonumber(arg_42_1.y) or 0

	return Vector2.New(var_42_2 * var_42_1, -var_42_3 * var_42_1)
end

local function var_0_63(arg_43_0)
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in pairs(arg_43_0 or {}) do
		if type(iter_43_1) == "table" then
			local var_43_1 = {}

			for iter_43_2, iter_43_3 in pairs(iter_43_1) do
				var_43_1[iter_43_2] = iter_43_3
			end

			var_43_0[iter_43_0] = var_43_1
		else
			var_43_0[iter_43_0] = iter_43_1
		end
	end

	return var_43_0
end

local function var_0_64(arg_44_0)
	local var_44_0 = {}

	for iter_44_0 = 1, #(arg_44_0 or {}) do
		var_44_0[iter_44_0] = var_0_63(arg_44_0[iter_44_0])
	end

	return var_44_0
end

local function var_0_65(arg_45_0)
	return arg_45_0 ~= nil and arg_45_0.itemId ~= nil and tostring(arg_45_0.itemId) ~= ""
end

local function var_0_66(arg_46_0)
	if arg_46_0 == nil or arg_46_0.itemId == nil or tostring(arg_46_0.itemId) == "" then
		return nil
	end

	return tostring(arg_46_0.itemId)
end

local function var_0_67(arg_47_0)
	if arg_47_0 == nil then
		return nil
	end

	local var_47_0 = {}

	for iter_47_0 = 1, #(arg_47_0.bodySkinNames or {}) do
		var_47_0[iter_47_0] = arg_47_0.bodySkinNames[iter_47_0]
	end

	return {
		bodyId = arg_47_0.bodyId,
		bodyName = arg_47_0.bodyName,
		bodyAssetName = arg_47_0.bodyAssetName,
		bodyVisualType = arg_47_0.bodyVisualType,
		bodySkeletonDataPath = arg_47_0.bodySkeletonDataPath,
		bodyBoundsSize = var_0_63(arg_47_0.bodyBoundsSize),
		bodyBoundsCenter = var_0_63(arg_47_0.bodyBoundsCenter),
		hasBodyVisual = arg_47_0.hasBodyVisual,
		chassisPrefabPath = arg_47_0.chassisPrefabPath,
		wheels = var_0_64(arg_47_0.wheels),
		modules = var_0_64(arg_47_0.modules),
		bodySkinNames = var_47_0
	}
end

local function var_0_68(arg_48_0, arg_48_1)
	if arg_48_0 == nil or arg_48_1 == nil then
		return false
	end

	local var_48_0 = tostring(arg_48_0.slotType or "") ~= "" and tostring(arg_48_0.slotIndex or "") ~= ""

	if var_0_52(arg_48_0) == var_0_52(arg_48_1) then
		return true
	end

	if var_48_0 then
		return false
	end

	local var_48_1 = tostring(arg_48_1.itemId or "")
	local var_48_2 = tostring(arg_48_0.slotType or "")

	return var_48_1 ~= "" and tostring(arg_48_0.itemId or "") == var_48_1 and (var_48_2 == "" or arg_48_0.slotType == arg_48_1.slotType)
end

local function var_0_69(arg_49_0, arg_49_1)
	if arg_49_1 == nil or arg_49_0.listeners_ == nil then
		return
	end

	for iter_49_0 = #arg_49_0.listeners_, 1, -1 do
		if arg_49_0.listeners_[iter_49_0] == arg_49_1 then
			table.remove(arg_49_0.listeners_, iter_49_0)

			break
		end
	end

	if #arg_49_0.listeners_ == 0 then
		arg_49_0.listeners_ = nil
	end
end

local function var_0_70(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	local var_50_0 = var_0_63(arg_50_0)
	local var_50_1 = arg_50_2 ~= nil and arg_50_2.slotType == arg_50_0.slotType and tonumber(arg_50_2.slotIndex) == tonumber(arg_50_0.slotIndex)
	local var_50_2 = arg_50_1 ~= nil and arg_50_0.slotType == arg_50_1.typeText

	if var_0_65(arg_50_0) then
		if var_50_1 and var_50_2 and arg_50_3 then
			var_50_0.slotState = "replace"
		end

		return var_50_0
	end

	if arg_50_0.isLocked == true then
		var_50_0.slotState = var_50_1 and "blocked" or "normal"

		return var_50_0
	end

	if not var_50_2 then
		var_50_0.slotState = var_50_1 and "blocked" or "normal"

		return var_50_0
	end

	if var_50_1 then
		var_50_0.slotState = arg_50_3 and "hover" or "dragging"

		return var_50_0
	end

	var_50_0.slotState = "dragging"

	return var_50_0
end

local function var_0_71(arg_51_0, arg_51_1, arg_51_2)
	if #arg_51_0 ~= #arg_51_1 then
		return true
	end

	for iter_51_0 = 1, #arg_51_1 do
		if tostring(arg_51_0[iter_51_0] and arg_51_0[iter_51_0][arg_51_2] or "") ~= tostring(arg_51_1[iter_51_0] and arg_51_1[iter_51_0][arg_51_2] or "") then
			return true
		end
	end

	return false
end

local function var_0_72(arg_52_0, arg_52_1)
	if arg_52_0 == nil or arg_52_1 == nil then
		return true
	end

	return tostring(arg_52_0.bodyName or "") ~= tostring(arg_52_1.bodyName or "") or tostring(arg_52_0.iconPath or "") ~= tostring(arg_52_1.iconPath or "") or arg_52_0.isUnlocked ~= arg_52_1.isUnlocked or arg_52_0.isSelected ~= arg_52_1.isSelected
end

local function var_0_73(arg_53_0, arg_53_1)
	if arg_53_0 == nil or arg_53_1 == nil then
		return true
	end

	return tostring(arg_53_0.itemName or "") ~= tostring(arg_53_1.itemName or "") or tostring(arg_53_0.iconPath or "") ~= tostring(arg_53_1.iconPath or "") or tostring(arg_53_0.cost or "") ~= tostring(arg_53_1.cost or "") or tostring(arg_53_0.typeText or "") ~= tostring(arg_53_1.typeText or "") or tostring(arg_53_0.costState or "") ~= tostring(arg_53_1.costState or "") or arg_53_0.isUnlocked ~= arg_53_1.isUnlocked or arg_53_0.isSelected ~= arg_53_1.isSelected or arg_53_0.isEquipped ~= arg_53_1.isEquipped
end

local function var_0_74(arg_54_0)
	if arg_54_0.vehicleSlotLayerFadeTween_ == nil then
		return
	end

	arg_54_0.vehicleSlotLayerFadeTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
	LeanTween.cancel(arg_54_0.vehicleSlotLayerFadeTween_.id)

	arg_54_0.vehicleSlotLayerFadeTween_ = nil
end

local function var_0_75(arg_55_0)
	if arg_55_0 ~= nil and type(arg_55_0.StartScroll) == "function" then
		arg_55_0:StartScroll(0)
	end
end

local function var_0_76(arg_56_0)
	arg_56_0.bodySwitchTransitioning_ = false
	arg_56_0.vehicleSlotLayerHoldHidden_ = false

	var_0_74(arg_56_0)
	var_0_75(arg_56_0.bodyItemList_)
	var_0_75(arg_56_0.weaponOptionItemList_)

	if arg_56_0.battleInfoView_ ~= nil and type(arg_56_0.battleInfoView_.SetOpenAnimEnabled) == "function" then
		arg_56_0.battleInfoView_:SetOpenAnimEnabled(true)
	end

	if arg_56_0.vehicleDisplayView_ ~= nil and type(arg_56_0.vehicleDisplayView_.ClearBodyAnimationCompleteHandler) == "function" then
		arg_56_0.vehicleDisplayView_:ClearBodyAnimationCompleteHandler()
	end

	if arg_56_0.outGameUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventOutGameUpdated(), arg_56_0.outGameUpdateHandler_)

		arg_56_0.outGameUpdateHandler_ = nil
	end
end

local function var_0_77(arg_57_0)
	if arg_57_0.windowBarBackHandler_ ~= nil and manager.windowBar:GetLastBackFunc() == arg_57_0.windowBarBackHandler_ then
		manager.windowBar:HideBar()
	end
end

local function var_0_78(arg_58_0)
	if arg_58_0 == nil then
		return nil
	end

	return arg_58_0:GetComponent(typeof(CanvasGroup))
end

local function var_0_79(arg_59_0, arg_59_1)
	if arg_59_0 == nil then
		return
	end

	arg_59_0.alpha = arg_59_1 and 1 or 0
	arg_59_0.interactable = arg_59_1
	arg_59_0.blocksRaycasts = arg_59_1
end

local function var_0_80(arg_60_0)
	if arg_60_0 == nil then
		return nil
	end

	local var_60_0 = arg_60_0:GetComponent(typeof(CanvasGroup))

	if var_60_0 == nil then
		var_60_0 = arg_60_0:AddComponent(typeof(CanvasGroup))
	end

	return var_60_0
end

local function var_0_81(arg_61_0, arg_61_1)
	if arg_61_0 == nil or arg_61_1 == nil or arg_61_1 == "" then
		return false
	end

	local var_61_0 = arg_61_0:GetCurrentAnimatorStateInfo(0)

	return var_61_0 ~= nil and var_61_0:IsName(arg_61_1)
end

local function var_0_82(arg_62_0, arg_62_1, arg_62_2)
	if arg_62_0 == nil or arg_62_0.runtimeAnimatorController == nil then
		return nil
	end

	local var_62_0 = arg_62_0.runtimeAnimatorController.animationClips

	if var_62_0 == nil then
		return nil
	end

	local var_62_1 = tostring(arg_62_1 or "")
	local var_62_2 = tostring(arg_62_2 or "")
	local var_62_3 = false

	for iter_62_0 = 0, var_62_0.Length - 1 do
		local var_62_4 = var_62_0[iter_62_0]

		if var_62_4 ~= nil then
			local var_62_5 = tostring(var_62_4.name or "")

			if var_62_1 ~= "" and var_62_5 == var_62_1 then
				return var_62_1
			end

			if var_62_2 ~= "" and var_62_5 == var_62_2 then
				var_62_3 = true
			end
		end
	end

	if var_62_3 then
		return var_62_2
	end

	return nil
end

local function var_0_83(arg_63_0)
	if arg_63_0.vehicleDisplayView_ ~= nil then
		arg_63_0.vehicleDisplayView_:Dispose()

		arg_63_0.vehicleDisplayView_ = nil
	end

	arg_63_0.vehicleDisplayView_ = SummerRaceVehicleDisplayView.New(arg_63_0.carRootGo_)
end

local function var_0_84(arg_64_0)
	if arg_64_0.activePanelType_ == var_0_3.MODIFY then
		return arg_64_0.carRootGo_
	end

	if arg_64_0.battleInfoView_ ~= nil and type(arg_64_0.battleInfoView_.GetVehicleRootGo) == "function" then
		local var_64_0 = arg_64_0.battleInfoView_:GetVehicleRootGo()

		if var_64_0 ~= nil then
			return var_64_0
		end
	end

	return arg_64_0.carRootGo_
end

local function var_0_85(arg_65_0, arg_65_1)
	if arg_65_0.vehicleDisplayView_ == nil then
		return
	end

	local var_65_0 = arg_65_0.carRootGo_

	if arg_65_1 ~= var_0_3.MODIFY and arg_65_0.battleInfoView_ ~= nil and type(arg_65_0.battleInfoView_.GetVehicleRootGo) == "function" then
		local var_65_1 = arg_65_0.battleInfoView_:GetVehicleRootGo()

		if var_65_1 ~= nil then
			var_65_0 = var_65_1
		end
	end

	arg_65_0.vehicleDisplayView_:AttachHost(var_65_0)
end

function var_0_2.UIName(arg_66_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_CarModifyUI"
end

function var_0_2.UIParent(arg_67_0)
	return manager.ui.uiMain.transform
end

function var_0_2.Init(arg_68_0)
	arg_68_0:BindCfgUI()
	arg_68_0:BindViewRuntime()
	arg_68_0:AddUIListener()
end

function var_0_2.BindViewRuntime(arg_69_0)
	arg_69_0.bodyItemList_ = LuaList.New(handler(arg_69_0, arg_69_0.IndexBodyItem), arg_69_0.bodyListGo_, SummerRaceBodyItemView)
	arg_69_0.weaponOptionItemList_ = LuaList.New(handler(arg_69_0, arg_69_0.IndexOptionItem), arg_69_0.weaponListGo_, SummerRaceWeaponOptionItemView)
	arg_69_0.battleInfoView_ = SummerRaceBattleInfoView.New(arg_69_0.battleInfoGo_)
	arg_69_0.battleInfoCanvasGroup_ = var_0_78(arg_69_0.battleInfoGo_)

	var_0_83(arg_69_0)
	arg_69_0.battleInfoView_:SetHandlers({
		modify = handler(arg_69_0, arg_69_0.OpenModifyPanelFromInfo),
		rank = handler(arg_69_0, arg_69_0.OpenRankView),
		stageStart = handler(arg_69_0, arg_69_0.HandleStageBattleStart),
		challengeStart = handler(arg_69_0, arg_69_0.HandleChallengeBattleStart),
		enemyWave = handler(arg_69_0, arg_69_0.OnEnemyWaveAction),
		detailSlot = handler(arg_69_0, arg_69_0.OnDetailSlotAction),
		rewardClick = handler(arg_69_0, arg_69_0.OnRewardClick)
	})

	arg_69_0.bottomTabController_ = arg_69_0.controllerEx_:GetController("bottomTab")
	arg_69_0.tipsController_ = arg_69_0.controllerEx_:GetController("tips")
	arg_69_0.areaHintController_ = arg_69_0.controllerEx_:GetController("areaHint")
	arg_69_0.optionMaskController_ = arg_69_0.controllerEx_:GetController("optionMask")
	arg_69_0.filterAllSelectControllerEx_ = arg_69_0.filterAllControllerEx_
	arg_69_0.filterWeaponSelectControllerEx_ = arg_69_0.filterWeaponControllerEx_
	arg_69_0.filterEquipSelectControllerEx_ = arg_69_0.filterEquipControllerEx_

	if arg_69_0.filterTabBgImage_ ~= nil then
		arg_69_0.filterTabBgImage_.raycastTarget = false
	end

	if arg_69_0.dropHintText_ ~= nil then
		arg_69_0.dropHintText_.text = GetTips("ACTIVITY_TANK_MODIFY_CANCEL")

		SetActive(arg_69_0.dropHintText_.gameObject, false)
	end

	if arg_69_0.modifyAnimator_ == nil then
		Debug.LogError("[SummerRaceModifyView] missing ComponentCfger binding: modifyAnimator_")
	end

	arg_69_0.weaponListRectTransform_ = arg_69_0.weaponListGo_.transform:GetComponent(typeof(RectTransform))
	arg_69_0.weaponScrollRect_ = arg_69_0.weaponListGo_.transform:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	arg_69_0.propertiesItemPrefab_ = Asset.Load(var_0_22)
	arg_69_0.optionDragPreviewPrefab_ = Asset.Load(var_0_21)

	if arg_69_0.weaponScrollRect_ == nil then
		arg_69_0.weaponScrollRect_ = arg_69_0.weaponListGo_.transform:GetComponentInChildren(typeof(UnityEngine.UI.ScrollRect))
	end

	arg_69_0.bodyTipsView_ = var_0_0.New(arg_69_0.bodyTipsGo_)
	arg_69_0.weaponTipsView_ = var_0_1.New(arg_69_0.weaponTipsGo_, arg_69_0.propertiesItemPrefab_)
	arg_69_0.equipTipsView_ = var_0_1.New(arg_69_0.equipTipsGo_, arg_69_0.propertiesItemPrefab_)
	arg_69_0.bodyList_ = {}
	arg_69_0.optionList_ = {}
	arg_69_0.modifySlotList_ = {}
	arg_69_0.vehicleLayout_ = nil
	arg_69_0.vehicleDisplayModel_ = nil
	arg_69_0.selectedModifySlot_ = nil
	arg_69_0.activeModifyTipsItemId_ = nil
	arg_69_0.vehicleSlotItemViews_ = {}
	arg_69_0.vehicleSlotLayerGo_ = nil
	arg_69_0.vehicleSlotLayerCanvasGroup_ = nil
	arg_69_0.vehicleModuleLayerCanvasGroup_ = nil
	arg_69_0.vehicleSlotLayerFadeTween_ = nil
	arg_69_0.vehicleSlotLayerHoldHidden_ = false
	arg_69_0.vehicleSlotItemPrefab_ = Asset.Load(var_0_20)
	arg_69_0.vehicleSlotSignature_ = ""
	arg_69_0.dragOptionData_ = nil
	arg_69_0.dragPreviewGo_ = nil
	arg_69_0.dragPreviewRect_ = nil
	arg_69_0.dragPreviewItemView_ = nil
	arg_69_0.dragHoveredSlot_ = nil
	arg_69_0.dragSlotSourceData_ = nil
	arg_69_0.optionCostAvailableCost_ = nil
	arg_69_0.optionGesturePressContext_ = nil
	arg_69_0.optionGestureDragging_ = false
	arg_69_0.weaponScrollEnabledBeforeDrag_ = nil
	arg_69_0.weaponScrollPositionBeforeDrag_ = nil
	arg_69_0.slotGesturePressContext_ = nil
	arg_69_0.slotGestureDragging_ = false
	arg_69_0.pendingEquipAnimSlotKey_ = nil
	arg_69_0.equipAnimTimer_ = nil
	arg_69_0.activePanelType_ = var_0_3.MODIFY
	arg_69_0.returnPanelType_ = nil
	arg_69_0.stageId_ = nil
	arg_69_0.modifyAnimTimer_ = nil
	arg_69_0.bodySwitchTransitioning_ = false
	arg_69_0.pendingUnlockPopTimer_ = nil
end

function var_0_2.OnEnter(arg_70_0)
	var_0_76(arg_70_0)
	arg_70_0:ResetRouteRuntimeState()
	arg_70_0:UpdateBar()

	arg_70_0.outGameUpdateHandler_ = handler(arg_70_0, arg_70_0.RefreshView)

	manager.notify:RegistListener(SummerRaceData.GetEventOutGameUpdated(), arg_70_0.outGameUpdateHandler_)
	arg_70_0:ApplyEntryParams(arg_70_0.params_)

	arg_70_0.routeParamsSignature_ = var_0_57(arg_70_0.params_)

	arg_70_0:RefreshView()
	arg_70_0:ApplyPanelState(true)
	arg_70_0:PlayModifyBodyEnterAnim()
	arg_70_0:SchedulePendingUnlockPop()
end

function var_0_2.OnExit(arg_71_0)
	arg_71_0:HideAllTips()
	arg_71_0:StopModifyAnimTimer(true)
	arg_71_0:StopPendingUnlockPopTimer()
	arg_71_0:StopEquipAnimTimer()
	arg_71_0:ClearOptionListGestureState()
	arg_71_0:ClearOptionDragState(false)
	arg_71_0:ClearSlotGestureState()
	var_0_76(arg_71_0)
	var_0_77(arg_71_0)

	arg_71_0.bodySwitchTransitioning_ = false
end

function var_0_2.OnTop(arg_72_0)
	arg_72_0:UpdateBar()
end

function var_0_2.UpdateBar(arg_73_0)
	arg_73_0.windowBarBackHandler_ = arg_73_0.windowBarBackHandler_ or function()
		arg_73_0:HandleBack()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_TANK_DESC")
	manager.windowBar:RegistBackCallBack(arg_73_0.windowBarBackHandler_)
	manager.windowBar:RegistHomeCallBack(function()
		SummerRaceAction.ConfirmModify()
		arg_73_0:Go("/home")
	end)
end

function var_0_2.OnBehind(arg_76_0)
	return
end

function var_0_2.SchedulePendingUnlockPop(arg_77_0)
	arg_77_0:StopPendingUnlockPopTimer()

	arg_77_0.pendingUnlockPopTimer_ = Timer.New(function()
		arg_77_0:StopPendingUnlockPopTimer()

		if manager.guide ~= nil and manager.guide:IsPlaying() then
			arg_77_0:SchedulePendingUnlockPop()

			return
		end

		SummerRaceAction.TryOpenPendingUnlockPop()
	end, 0.1, 1)

	arg_77_0.pendingUnlockPopTimer_:Start()
end

function var_0_2.StopPendingUnlockPopTimer(arg_79_0)
	if arg_79_0.pendingUnlockPopTimer_ ~= nil then
		arg_79_0.pendingUnlockPopTimer_:Stop()

		arg_79_0.pendingUnlockPopTimer_ = nil
	end
end

function var_0_2.PlayModifyBodyEnterAnim(arg_80_0)
	if arg_80_0.activePanelType_ ~= var_0_3.MODIFY or arg_80_0.vehicleDisplayView_ == nil then
		return
	end

	arg_80_0.vehicleDisplayView_:PlayBodyAnimation(var_0_9, false, nil, var_0_10)
end

function var_0_2.OnUpdate(arg_81_0)
	if not arg_81_0:IsTop() then
		return
	end

	arg_81_0:UpdateBar()

	local var_81_0 = var_0_57(arg_81_0.params_)

	if arg_81_0.routeParamsSignature_ ~= var_81_0 then
		arg_81_0:StopModifyAnimTimer(true)
		arg_81_0:ApplyEntryParams(arg_81_0.params_)

		arg_81_0.routeParamsSignature_ = var_81_0

		arg_81_0:ApplyPanelState(false)
	end

	arg_81_0:RefreshView()
end

function var_0_2.GetForcedEntryPanelType(arg_82_0)
	return nil
end

function var_0_2.ResolveEntryPanelType(arg_83_0, arg_83_1)
	local var_83_0 = arg_83_0:GetForcedEntryPanelType()

	if var_83_0 ~= nil then
		return var_83_0
	end

	if arg_83_1.panelType == var_0_3.STAGE_DETAIL then
		return var_0_3.STAGE_DETAIL
	end

	if arg_83_1.panelType == var_0_3.CHALLENGE then
		return var_0_3.CHALLENGE
	end

	return var_0_3.MODIFY
end

function var_0_2.ApplyEntryParams(arg_84_0, arg_84_1)
	arg_84_1 = arg_84_1 or {}

	local var_84_0 = arg_84_1.filterType or SummerRaceConst.FILTER.ALL

	arg_84_0.infoSelectedSlotKey_ = nil
	arg_84_0.infoVehicleSnapshot_ = nil
	arg_84_0.infoVehicleDisplayModel_ = nil

	if arg_84_1.stageId ~= nil then
		SummerRaceData:SetCurrentStageId(arg_84_1.stageId, true)

		arg_84_0.stageId_ = arg_84_1.stageId
	else
		arg_84_0.stageId_ = nil
	end

	arg_84_0.activePanelType_ = arg_84_0:ResolveEntryPanelType(arg_84_1)

	if arg_84_0.activePanelType_ == var_0_3.MODIFY then
		arg_84_0.returnPanelType_ = nil

		SummerRaceData:ResetModifyOperateState(true)
		SummerRaceData:SetModifyFilter(var_84_0, true)
	else
		arg_84_0.returnPanelType_ = nil

		if arg_84_1.filterType ~= nil then
			SummerRaceData:SetModifyFilter(arg_84_1.filterType, true)
		end
	end
end

function var_0_2.ResetRouteRuntimeState(arg_85_0)
	arg_85_0:StopModifyAnimTimer(true)

	arg_85_0.activePanelType_ = var_0_3.MODIFY
	arg_85_0.returnPanelType_ = nil
	arg_85_0.stageId_ = nil
	arg_85_0.modifyPageModel_ = nil
	arg_85_0.bodyList_ = {}
	arg_85_0.optionList_ = {}
	arg_85_0.modifySlotList_ = {}
	arg_85_0.vehicleLayout_ = nil
	arg_85_0.vehicleDisplayModel_ = nil
	arg_85_0.selectedModifySlot_ = nil
	arg_85_0.optionCostAvailableCost_ = nil
	arg_85_0.infoSelectedSlotKey_ = nil
	arg_85_0.infoVehicleSnapshot_ = nil
	arg_85_0.infoVehicleDisplayModel_ = nil
	arg_85_0.routeParamsSignature_ = nil
	arg_85_0.bodySwitchTransitioning_ = false

	arg_85_0:ClearOptionListGestureState()
	arg_85_0:ClearOptionDragState(false)
	arg_85_0:ClearSlotGestureState()
	arg_85_0:ClearModifyVehicleDisplay()
	var_0_83(arg_85_0)
end

function var_0_2.ApplyPanelState(arg_86_0, arg_86_1)
	if arg_86_0.activePanelType_ == var_0_3.MODIFY then
		arg_86_0:ShowModifyPanel(arg_86_1 == true)
	else
		arg_86_0:ShowBattleInfoPanel()
	end
end

function var_0_2.AddUIListener(arg_87_0)
	arg_87_0:AddBtnListener(arg_87_0.filterAllTgl_, nil, function()
		SummerRaceAction.SelectModifyFilter("all")
		arg_87_0:RefreshModifyPanel()
	end)
	arg_87_0:AddBtnListener(arg_87_0.filterWeaponTgl_, nil, function()
		SummerRaceAction.SelectModifyFilter("weapon")
		arg_87_0:RefreshModifyPanel()
	end)
	arg_87_0:AddBtnListener(arg_87_0.filterEquipTgl_, nil, function()
		SummerRaceAction.SelectModifyFilter("equip")
		arg_87_0:RefreshModifyPanel()
	end)
	arg_87_0:AddBtnListener(arg_87_0.confirmBtn_, nil, function()
		arg_87_0:HideModifyTips()

		if SummerRaceAction.ConfirmModify(function(arg_92_0)
			if arg_92_0 == true then
				arg_87_0:HandleBack(true)
			end
		end) then
			arg_87_0:RefreshModifyPanel()
		end
	end)
	var_0_44(arg_87_0, arg_87_0.weaponListGo_.gameObject, handler(arg_87_0, arg_87_0.OnOptionListPointerDown), handler(arg_87_0, arg_87_0.OnOptionListDrag), handler(arg_87_0, arg_87_0.OnOptionListPointerUp), handler(arg_87_0, arg_87_0.OnOptionListEndDrag))
end

function var_0_2.OpenRankView(arg_93_0)
	SummerRaceAction.OpenRankView()
end

function var_0_2.HandleBack(arg_94_0, arg_94_1)
	if arg_94_0.modifyAnimTimer_ ~= nil then
		return
	end

	if arg_94_0.activePanelType_ == var_0_3.MODIFY and arg_94_1 ~= true then
		arg_94_0:HideModifyTips()

		if SummerRaceAction.ConfirmModify(function(arg_95_0)
			if arg_95_0 == true then
				arg_94_0:HandleBack(true)
			end
		end) then
			arg_94_0:RefreshModifyPanel()
		end

		return
	end

	if arg_94_0.activePanelType_ == var_0_3.MODIFY and arg_94_0.returnPanelType_ ~= nil then
		arg_94_0:PlayModifyExit(arg_94_0.returnPanelType_)

		return
	end

	JumpTools.Back(nil, {
		returnFromModify = true,
		replayStageUIAnim = arg_94_0.activePanelType_ == var_0_3.STAGE_DETAIL
	})
end

function var_0_2.OpenModifyPanelFromInfo(arg_96_0)
	if arg_96_0.activePanelType_ == var_0_3.MODIFY or arg_96_0.modifyAnimTimer_ ~= nil then
		return
	end

	arg_96_0.returnPanelType_ = arg_96_0.activePanelType_

	SummerRaceData:ResetModifyOperateState(true)

	arg_96_0.activePanelType_ = var_0_3.MODIFY

	arg_96_0:RefreshModifyPanel()
	arg_96_0:ShowModifyPanel(false)
	arg_96_0:PlayModifyAnim(var_0_4, nil, function()
		arg_96_0:RefreshModifyPanel()
	end, true)
end

function var_0_2.IndexBodyItem(arg_98_0, arg_98_1, arg_98_2)
	arg_98_2:SetData(arg_98_0.bodyList_[arg_98_1], arg_98_1, handler(arg_98_0, arg_98_0.OnBodyAction))
end

function var_0_2.IndexOptionItem(arg_99_0, arg_99_1, arg_99_2)
	arg_99_2:SetData(arg_99_0.optionList_[arg_99_1], arg_99_1, handler(arg_99_0, arg_99_0.OnOptionAction))

	if arg_99_0.optionCostAvailableCost_ ~= nil and arg_99_2.RefreshCostStateByAvailableCost ~= nil then
		arg_99_2:RefreshCostStateByAvailableCost(arg_99_0.optionCostAvailableCost_)
	end
end

function var_0_2.OnBodyAction(arg_100_0, arg_100_1, arg_100_2, arg_100_3)
	if arg_100_3 == "select" then
		local var_100_0 = arg_100_0.modifyPageModel_ and arg_100_0.modifyPageModel_.selectedBody and arg_100_0.modifyPageModel_.selectedBody.bodyId or nil

		if tostring(var_100_0 or "") ~= tostring(arg_100_2.bodyId or "") then
			arg_100_0:HideModifyTips()
		end

		arg_100_0:PlayBodySwitchTransition(arg_100_2.bodyId)
	end
end

function var_0_2.OnOptionAction(arg_101_0, arg_101_1, arg_101_2, arg_101_3, arg_101_4, arg_101_5)
	return
end

function var_0_2.SetWeaponScrollEnabled(arg_102_0, arg_102_1)
	if arg_102_0.weaponScrollRect_ == nil then
		return
	end

	arg_102_0.weaponScrollRect_.enabled = arg_102_1

	if arg_102_1 == false and arg_102_0.weaponScrollRect_.velocity ~= nil then
		arg_102_0.weaponScrollRect_.velocity = Vector2.zero
	end
end

function var_0_2.CacheWeaponScrollPositionBeforeDrag(arg_103_0)
	if arg_103_0.weaponOptionItemList_ == nil or type(arg_103_0.weaponOptionItemList_.GetScrolledPosition) ~= "function" then
		arg_103_0.weaponScrollPositionBeforeDrag_ = nil

		return
	end

	arg_103_0.weaponScrollPositionBeforeDrag_ = arg_103_0.weaponOptionItemList_:GetScrolledPosition()
end

function var_0_2.RestoreWeaponScrollPositionAfterDrag(arg_104_0)
	if arg_104_0.weaponScrollPositionBeforeDrag_ == nil then
		return
	end

	if arg_104_0.weaponOptionItemList_ ~= nil and type(arg_104_0.weaponOptionItemList_.SetScrolledPosition) == "function" then
		arg_104_0.weaponOptionItemList_:SetScrolledPosition(arg_104_0.weaponScrollPositionBeforeDrag_)
	end

	arg_104_0.weaponScrollPositionBeforeDrag_ = nil
end

function var_0_2.ClearOptionListGestureState(arg_105_0)
	if arg_105_0.weaponScrollEnabledBeforeDrag_ ~= nil then
		arg_105_0:SetWeaponScrollEnabled(arg_105_0.weaponScrollEnabledBeforeDrag_)
		arg_105_0:RestoreWeaponScrollPositionAfterDrag()
	end

	arg_105_0.optionGesturePressContext_ = nil
	arg_105_0.optionGestureDragging_ = false
	arg_105_0.weaponScrollEnabledBeforeDrag_ = nil
	arg_105_0.weaponScrollPositionBeforeDrag_ = nil
end

function var_0_2.ClearSlotGestureState(arg_106_0)
	arg_106_0.slotGesturePressContext_ = nil
	arg_106_0.slotGestureDragging_ = false
end

function var_0_2.StopEquipAnimTimer(arg_107_0)
	if arg_107_0.equipAnimTimer_ ~= nil then
		arg_107_0.equipAnimTimer_:Stop()

		arg_107_0.equipAnimTimer_ = nil
	end
end

function var_0_2.MarkEquipAnimSlot(arg_108_0, arg_108_1, arg_108_2)
	arg_108_0:StopEquipAnimTimer()

	arg_108_0.pendingEquipAnimSlotKey_ = var_0_53(arg_108_1, arg_108_2)
	arg_108_0.equipAnimTimer_ = Timer.New(function()
		arg_108_0:StopEquipAnimTimer()

		arg_108_0.pendingEquipAnimSlotKey_ = nil

		arg_108_0:RefreshModifyVehicleSlots()
	end, var_0_15, 1)

	arg_108_0.equipAnimTimer_:Start()
end

function var_0_2.ShouldPlayEquipAnim(arg_110_0, arg_110_1)
	if arg_110_0.pendingEquipAnimSlotKey_ == nil then
		return false
	end

	return var_0_52(arg_110_1) == arg_110_0.pendingEquipAnimSlotKey_
end

function var_0_2.RefreshVisibleOptionItemCostStates(arg_111_0)
	if arg_111_0.weaponOptionItemList_ == nil then
		return
	end

	local var_111_0 = SummerRaceData:GetCurrentBuildCostSummary()
	local var_111_1 = var_111_0 and var_111_0.remainingCost or 0
	local var_111_2, var_111_3 = arg_111_0.weaponOptionItemList_:GetHeadAndTail()

	arg_111_0.optionCostAvailableCost_ = var_111_1

	if var_111_2 == 0 then
		return
	end

	for iter_111_0 = var_111_2, var_111_3 do
		local var_111_4 = arg_111_0.weaponOptionItemList_:GetItemByIndex(iter_111_0)

		if var_111_4 ~= nil and var_111_4.RefreshCostStateByAvailableCost ~= nil then
			var_111_4:RefreshCostStateByAvailableCost(var_111_1)
		end
	end
end

function var_0_2.ResolvePressedOptionContext(arg_112_0, arg_112_1)
	local var_112_0, var_112_1 = arg_112_0.weaponOptionItemList_:GetHeadAndTail()

	if var_112_0 == 0 then
		return nil
	end

	for iter_112_0 = var_112_0, var_112_1 do
		local var_112_2 = arg_112_0.weaponOptionItemList_:GetItemByIndex(iter_112_0)

		if var_112_2 ~= nil and var_112_2.optionData_ ~= nil and var_0_37(var_112_2.transform_, arg_112_1) then
			return {
				optionIndex = iter_112_0,
				optionData = var_112_2.optionData_,
				sourceGo = var_112_2.gameObject_,
				pressScreenPos = arg_112_1
			}
		end
	end

	return nil
end

function var_0_2.ShouldStartListOptionDrag(arg_113_0, arg_113_1)
	local var_113_0 = arg_113_0.optionGesturePressContext_

	if var_113_0 == nil or arg_113_0.optionGestureDragging_ == true or arg_113_0.weaponListRectTransform_ == nil or arg_113_1 == nil then
		return false
	end

	local var_113_1 = var_113_0.pressScreenPos

	if math.abs((arg_113_1.y or 0) - (var_113_1.y or 0)) < var_0_23 then
		return false
	end

	return var_0_42(arg_113_0.weaponListRectTransform_, arg_113_1)
end

function var_0_2.HandleOptionListTap(arg_114_0, arg_114_1)
	if arg_114_1 == nil or arg_114_1.optionData == nil then
		return
	end

	local var_114_0 = var_0_66(arg_114_1.optionData)

	if var_114_0 ~= nil and var_114_0 == arg_114_0.activeModifyTipsItemId_ then
		return
	end

	if arg_114_1.optionData.isUnlocked == true then
		SummerRaceData:MarkOptionNewRedPointRead(arg_114_1.optionData.itemId, true)
	end

	if SummerRaceAction.PreviewOption(arg_114_1.optionData.itemId, true) then
		arg_114_0.activeModifyTipsItemId_ = var_114_0
	end
end

function var_0_2.OnOptionListPointerDown(arg_115_0, arg_115_1)
	if arg_115_0.activePanelType_ ~= var_0_3.MODIFY or arg_115_1 == nil then
		arg_115_0:ClearOptionListGestureState()

		return
	end

	arg_115_0:ClearOptionListGestureState()

	arg_115_0.optionGesturePressContext_ = arg_115_0:ResolvePressedOptionContext(arg_115_1.position)

	if arg_115_0.optionGesturePressContext_ ~= nil then
		local var_115_0 = var_0_66(arg_115_0.optionGesturePressContext_.optionData)

		if var_115_0 == nil or var_115_0 ~= arg_115_0.activeModifyTipsItemId_ then
			arg_115_0:HideModifyTips()
		end
	end
end

function var_0_2.OnOptionListDrag(arg_116_0, arg_116_1)
	local var_116_0 = arg_116_0.optionGesturePressContext_

	if var_116_0 == nil or arg_116_1 == nil then
		return
	end

	if arg_116_0.optionGestureDragging_ ~= true then
		if not arg_116_0:ShouldStartListOptionDrag(arg_116_1.position) then
			return
		end

		arg_116_0.optionGestureDragging_ = true

		if arg_116_0.weaponScrollRect_ == nil then
			-- block empty
		end

		arg_116_0.weaponScrollEnabledBeforeDrag_ = arg_116_0.weaponScrollRect_.enabled

		arg_116_0:CacheWeaponScrollPositionBeforeDrag()
		arg_116_0:SetWeaponScrollEnabled(false)
		arg_116_0:BeginOptionDrag(var_116_0.optionData, {
			position = arg_116_1.position
		}, var_116_0.sourceGo)

		if arg_116_0.dragOptionData_ == nil then
			arg_116_0:ClearOptionListGestureState()

			return
		end

		return
	end

	arg_116_0:UpdateOptionDrag(var_116_0.optionData, {
		position = arg_116_1.position
	})
end

function var_0_2.OnOptionListEndDrag(arg_117_0, arg_117_1)
	local var_117_0 = arg_117_0.optionGesturePressContext_
	local var_117_1 = arg_117_0.optionGestureDragging_ == true

	if var_117_0 == nil then
		arg_117_0:ClearOptionListGestureState()

		return
	end

	if not var_117_1 then
		return
	end

	arg_117_0:EndOptionDrag(var_117_0.optionData, {
		position = arg_117_1 and arg_117_1.position or var_117_0.pressScreenPos
	})
	arg_117_0:ClearOptionListGestureState()
end

function var_0_2.OnOptionListPointerUp(arg_118_0, arg_118_1)
	local var_118_0 = arg_118_0.optionGesturePressContext_

	if var_118_0 == nil then
		arg_118_0:ClearOptionListGestureState()

		return
	end

	if arg_118_0.optionGestureDragging_ == true then
		return
	end

	local var_118_1 = arg_118_1 and arg_118_1.position or var_118_0.pressScreenPos
	local var_118_2 = var_0_47(var_118_0.pressScreenPos, var_118_1, var_0_24)
	local var_118_3 = var_0_37(arg_118_0.weaponListRectTransform_, var_118_1)

	if var_118_2 and var_118_3 then
		arg_118_0:HandleOptionListTap(var_118_0)
	end

	arg_118_0:ClearOptionListGestureState()
end

function var_0_2.ResolveHoveredSlotByScreenPosition(arg_119_0, arg_119_1)
	local var_119_0
	local var_119_1
	local var_119_2

	for iter_119_0 = 1, #arg_119_0.modifySlotList_ do
		local var_119_3 = arg_119_0.vehicleSlotItemViews_[iter_119_0]
		local var_119_4 = arg_119_0.modifySlotList_[iter_119_0]

		if var_119_3 ~= nil then
			local var_119_5 = var_0_38(var_0_39(var_119_3), arg_119_1)

			if var_119_5 ~= nil and (var_119_1 == nil or var_119_5 < var_119_1) then
				var_119_0 = var_119_4
				var_119_1 = var_119_5
				var_119_2 = iter_119_0
			end
		end
	end

	return var_119_0, var_119_2
end

function var_0_2.CanDropOptionOnSlot(arg_120_0, arg_120_1, arg_120_2)
	if arg_120_1 == nil or arg_120_2 == nil then
		return false
	end

	if arg_120_2.isLocked == true then
		return false
	end

	if arg_120_2.slotType ~= arg_120_1.typeText then
		return false
	end

	local var_120_0 = SummerRaceData:GetProjectedAssignCostSummary(arg_120_1.itemId, arg_120_2.slotType, arg_120_2.slotIndex)

	return var_120_0 ~= nil and var_120_0.isOverflow ~= true
end

function var_0_2.CanTryDropOptionOnSlot(arg_121_0, arg_121_1, arg_121_2)
	if arg_121_1 == nil or arg_121_2 == nil then
		return false
	end

	if arg_121_2.isLocked == true then
		return false
	end

	return arg_121_2.slotType == arg_121_1.typeText
end

function var_0_2.CanDropEquippedSlotOnSlot(arg_122_0, arg_122_1, arg_122_2)
	if arg_122_1 == nil or arg_122_2 == nil then
		return false
	end

	if arg_122_1.isLocked == true or arg_122_2.isLocked == true then
		return false
	end

	if arg_122_1.slotType ~= arg_122_2.slotType then
		return false
	end

	if tonumber(arg_122_1.slotIndex) == tonumber(arg_122_2.slotIndex) then
		return false
	end

	if var_0_65(arg_122_2) then
		return false
	end

	return arg_122_1.itemId ~= nil and tostring(arg_122_1.itemId) ~= ""
end

function var_0_2.RefreshDragSlotStates(arg_123_0, arg_123_1)
	if arg_123_0.dragOptionData_ == nil then
		arg_123_0:SetModuleReplaceSlotData(nil)
		arg_123_0:RefreshModifyVehicleSlots()

		return
	end

	local var_123_0 = arg_123_0:ResolveHoveredSlotByScreenPosition(arg_123_1)
	local var_123_1 = arg_123_0:CanDropOptionOnSlot(arg_123_0.dragOptionData_, var_123_0)
	local var_123_2

	arg_123_0.dragHoveredSlot_ = var_123_0

	if var_123_1 == true and var_0_65(var_123_0) then
		var_123_2 = var_123_0
	end

	arg_123_0:SetModuleReplaceSlotData(var_123_2)

	for iter_123_0 = 1, #arg_123_0.modifySlotList_ do
		local var_123_3 = arg_123_0.vehicleSlotItemViews_[iter_123_0]
		local var_123_4 = arg_123_0.modifySlotList_[iter_123_0]

		if var_123_3 ~= nil then
			SetActive(var_123_3.gameObject_, true)
			var_123_3:SetData(var_0_70(var_123_4, arg_123_0.dragOptionData_, var_123_0, var_123_1), iter_123_0, handler(arg_123_0, arg_123_0.OnDetailSlotAction))
		end
	end
end

function var_0_2.SetVehicleSlotDragOptionData(arg_124_0, arg_124_1)
	for iter_124_0 = 1, #(arg_124_0.vehicleSlotItemViews_ or {}) do
		local var_124_0 = arg_124_0.vehicleSlotItemViews_[iter_124_0]

		if var_124_0 ~= nil and type(var_124_0.SetDragOptionData) == "function" then
			var_124_0:SetDragOptionData(arg_124_1)
		end
	end
end

function var_0_2.SetModuleReplaceSlotData(arg_125_0, arg_125_1)
	if arg_125_0.vehicleDisplayView_ ~= nil and type(arg_125_0.vehicleDisplayView_.SetModuleReplaceSlotData) == "function" then
		arg_125_0.vehicleDisplayView_:SetModuleReplaceSlotData(arg_125_1)
	end
end

function var_0_2.ClearDragPreview(arg_126_0)
	if arg_126_0.dragPreviewItemView_ ~= nil then
		arg_126_0.dragPreviewItemView_:Dispose()

		arg_126_0.dragPreviewItemView_ = nil
	end

	if arg_126_0.dragPreviewGo_ ~= nil then
		Object.Destroy(arg_126_0.dragPreviewGo_)

		arg_126_0.dragPreviewGo_ = nil
		arg_126_0.dragPreviewRect_ = nil
	end
end

function var_0_2.UpdateDragPreview(arg_127_0, arg_127_1)
	if arg_127_0.dragPreviewRect_ == nil then
		return
	end

	local var_127_0 = var_0_36(arg_127_0.transform_, arg_127_1)

	if var_127_0 ~= nil then
		arg_127_0.dragPreviewRect_.anchoredPosition = var_127_0
	end
end

function var_0_2.CreateDragPreview(arg_128_0, arg_128_1, arg_128_2, arg_128_3)
	arg_128_0:ClearDragPreview()

	local var_128_0 = false

	if arg_128_1 ~= nil and tostring(arg_128_1.skeletonDataPath or "") ~= "" then
		arg_128_0.dragPreviewGo_ = var_0_43(arg_128_1, arg_128_0.transform_)
		var_128_0 = true
	elseif arg_128_1 ~= nil and arg_128_0.optionDragPreviewPrefab_ ~= nil then
		arg_128_0.dragPreviewGo_ = Object.Instantiate(arg_128_0.optionDragPreviewPrefab_, arg_128_0.transform_)
		arg_128_0.dragPreviewItemView_ = SummerRaceWeaponOptionItemView.New(arg_128_0.dragPreviewGo_)

		arg_128_0.dragPreviewItemView_:SetData(arg_128_1, -1, nil)
	elseif arg_128_3 ~= nil then
		arg_128_0.dragPreviewGo_ = Object.Instantiate(arg_128_3, arg_128_0.transform_)
	else
		return
	end

	arg_128_0.dragPreviewRect_ = arg_128_0.dragPreviewGo_:GetComponent(typeof(RectTransform))

	local var_128_1 = arg_128_0.dragPreviewGo_:GetComponent(typeof(CanvasGroup))

	if var_128_1 == nil then
		var_128_1 = arg_128_0.dragPreviewGo_:AddComponent(typeof(CanvasGroup))
	end

	var_128_1.blocksRaycasts = false
	var_128_1.interactable = false

	if arg_128_0.dragPreviewRect_ ~= nil then
		arg_128_0.dragPreviewRect_:SetParent(arg_128_0.transform_, false)

		arg_128_0.dragPreviewRect_.anchorMin = Vector2.New(0.5, 0.5)
		arg_128_0.dragPreviewRect_.anchorMax = Vector2.New(0.5, 0.5)
		arg_128_0.dragPreviewRect_.pivot = Vector2.New(0.5, 0.5)

		if var_128_0 ~= true then
			arg_128_0.dragPreviewRect_.localScale = Vector3.one
		end
	end

	arg_128_0.dragPreviewGo_.transform:SetAsLastSibling()
	arg_128_0:UpdateDragPreview(arg_128_2)
end

function var_0_2.ClearOptionDragState(arg_129_0, arg_129_1)
	arg_129_0:SetVehicleSlotDragOptionData(nil)
	arg_129_0:SetModuleReplaceSlotData(nil)

	arg_129_0.dragOptionData_ = nil
	arg_129_0.dragHoveredSlot_ = nil
	arg_129_0.dragSlotSourceData_ = nil

	if arg_129_0.vehicleDisplayView_ ~= nil and type(arg_129_0.vehicleDisplayView_.SetModuleDragSourceSlotData) == "function" then
		arg_129_0.vehicleDisplayView_:SetModuleDragSourceSlotData(nil)
	end

	arg_129_0:ClearDragPreview()
	arg_129_0:SetDropAreaHintState(var_0_28.NONE)

	if arg_129_1 == true and arg_129_0.activePanelType_ == var_0_3.MODIFY then
		arg_129_0:RefreshModifyVehicleSlots()
	end
end

function var_0_2.SetDropAreaHintState(arg_130_0, arg_130_1)
	local var_130_0 = var_0_28.NONE

	if arg_130_0.activePanelType_ == var_0_3.MODIFY then
		if arg_130_1 == var_0_28.MOVE_IN then
			var_130_0 = var_0_28.MOVE_IN
		elseif arg_130_1 == var_0_28.NORMAL or arg_130_1 == true then
			var_130_0 = var_0_28.NORMAL
		end
	end

	if arg_130_0.areaHintController_ ~= nil then
		arg_130_0.areaHintController_:SetSelectedState(var_130_0)
	end

	if arg_130_0.dropHintText_ ~= nil then
		SetActive(arg_130_0.dropHintText_.gameObject, var_130_0 ~= var_0_28.NONE)
	end
end

function var_0_2.RefreshEquippedSlotDropAreaState(arg_131_0, arg_131_1)
	local var_131_0 = var_0_37(arg_131_0.weaponListRectTransform_, arg_131_1) and var_0_28.NORMAL or var_0_28.MOVE_IN

	arg_131_0:SetDropAreaHintState(var_131_0)
end

function var_0_2.BeginOptionDrag(arg_132_0, arg_132_1, arg_132_2, arg_132_3)
	if arg_132_0.activePanelType_ ~= var_0_3.MODIFY or arg_132_1 == nil then
		return
	end

	if arg_132_1.isUnlocked ~= true then
		ShowTips("ACTIVITY_TANK_WEAPON_LOCK")

		return
	end

	SummerRaceData:MarkOptionNewRedPointRead(arg_132_1.itemId, true)

	arg_132_0.dragOptionData_ = arg_132_1
	arg_132_0.dragHoveredSlot_ = nil

	arg_132_0:SetDropAreaHintState(var_0_28.NONE)
	arg_132_0:CreateDragPreview(arg_132_1, arg_132_2 and arg_132_2.position or nil, arg_132_3)
	arg_132_0:SetVehicleSlotDragOptionData(arg_132_1)
	arg_132_0:RefreshDragSlotStates(arg_132_2 and arg_132_2.position or nil)
end

function var_0_2.UpdateOptionDrag(arg_133_0, arg_133_1, arg_133_2)
	if arg_133_0.dragOptionData_ == nil or arg_133_1 == nil or arg_133_0.dragOptionData_.itemId ~= arg_133_1.itemId then
		return
	end

	local var_133_0 = arg_133_2 and arg_133_2.position or nil

	arg_133_0:UpdateDragPreview(var_133_0)
	arg_133_0:RefreshDragSlotStates(var_133_0)
end

function var_0_2.EndOptionDrag(arg_134_0, arg_134_1, arg_134_2)
	if arg_134_0.dragOptionData_ == nil or arg_134_1 == nil or arg_134_0.dragOptionData_.itemId ~= arg_134_1.itemId then
		return
	end

	local var_134_0 = arg_134_2 and arg_134_2.position or nil
	local var_134_1 = arg_134_0:ResolveHoveredSlotByScreenPosition(var_134_0)
	local var_134_2 = arg_134_0:CanTryDropOptionOnSlot(arg_134_1, var_134_1)

	arg_134_0:ClearOptionDragState(false)

	if not var_134_2 then
		arg_134_0:RefreshModifyVehicleSlots()

		return
	end

	if SummerRaceAction.AssignDraggedOptionToSlot(arg_134_1.itemId, var_134_1.slotType, var_134_1.slotIndex) then
		var_0_31()
		arg_134_0:MarkEquipAnimSlot(var_134_1.slotType, var_134_1.slotIndex)
		arg_134_0:RefreshModifyPanel()
	else
		arg_134_0:RefreshModifyVehicleSlots()
	end
end

function var_0_2.ResolveSlotDragOptionData(arg_135_0, arg_135_1)
	if arg_135_1 == nil or arg_135_1.itemId == nil or tostring(arg_135_1.itemId) == "" then
		return nil
	end

	return SummerRaceData:GetOptionDefById(arg_135_1.itemId)
end

function var_0_2.ShouldStartSlotDrag(arg_136_0, arg_136_1)
	local var_136_0 = arg_136_0.slotGesturePressContext_

	if var_136_0 == nil or arg_136_0.slotGestureDragging_ == true then
		return false
	end

	local var_136_1, var_136_2 = var_0_46(var_136_0.pressScreenPos, arg_136_1)

	return var_136_1 > var_0_25 or var_136_2 > var_0_25
end

function var_0_2.RefreshEquippedSlotDragStates(arg_137_0, arg_137_1)
	local var_137_0 = arg_137_0.dragSlotSourceData_

	for iter_137_0 = 1, #arg_137_0.modifySlotList_ do
		local var_137_1 = arg_137_0.vehicleSlotItemViews_[iter_137_0]

		if var_137_1 ~= nil then
			local var_137_2 = var_0_63(arg_137_0.modifySlotList_[iter_137_0])
			local var_137_3 = arg_137_0.dragSlotSourceData_ ~= nil and arg_137_0.dragSlotSourceData_.slotType == var_137_2.slotType and tonumber(arg_137_0.dragSlotSourceData_.slotIndex) == tonumber(var_137_2.slotIndex)
			local var_137_4 = arg_137_0:CanDropEquippedSlotOnSlot(var_137_0, var_137_2)

			SetActive(var_137_1.gameObject_, true)

			if var_137_3 then
				var_137_2.slotState = "dragging"
				var_137_2.isSelected = true
			elseif var_137_4 then
				var_137_2.slotState = "dragging"
			end

			var_137_1:SetData(var_137_2, iter_137_0, handler(arg_137_0, arg_137_0.OnDetailSlotAction))
		end
	end
end

function var_0_2.BeginEquippedSlotDrag(arg_138_0, arg_138_1, arg_138_2, arg_138_3)
	local var_138_0 = arg_138_0:ResolveSlotDragOptionData(arg_138_1)

	if arg_138_0.activePanelType_ ~= var_0_3.MODIFY or var_138_0 == nil then
		return
	end

	arg_138_0.dragSlotSourceData_ = var_0_63(arg_138_1)

	arg_138_0:CreateDragPreview(var_138_0, arg_138_2 and arg_138_2.position or nil, arg_138_3)
	arg_138_0:UpdateDragPreview(arg_138_2 and arg_138_2.position or nil)
	arg_138_0:SetVehicleSlotDragOptionData(var_138_0)
	arg_138_0:RefreshEquippedSlotDropAreaState(arg_138_2 and arg_138_2.position or nil)
	arg_138_0:RefreshEquippedSlotDragStates(arg_138_2 and arg_138_2.position or nil)
	arg_138_0:RefreshModifyVehicleDisplay()
end

function var_0_2.UpdateEquippedSlotDrag(arg_139_0, arg_139_1, arg_139_2)
	if arg_139_0.dragSlotSourceData_ == nil or arg_139_1 == nil then
		return
	end

	arg_139_0:UpdateDragPreview(arg_139_2 and arg_139_2.position or nil)
	arg_139_0:RefreshEquippedSlotDropAreaState(arg_139_2 and arg_139_2.position or nil)
	arg_139_0:RefreshEquippedSlotDragStates(arg_139_2 and arg_139_2.position or nil)
end

function var_0_2.EndEquippedSlotDrag(arg_140_0, arg_140_1, arg_140_2)
	if arg_140_0.dragSlotSourceData_ == nil or arg_140_1 == nil then
		return
	end

	local var_140_0 = arg_140_2 and arg_140_2.position or arg_140_0.slotGesturePressContext_ and arg_140_0.slotGesturePressContext_.pressScreenPos or nil
	local var_140_1 = arg_140_0:ResolveHoveredSlotByScreenPosition(var_140_0)
	local var_140_2 = arg_140_0:CanDropEquippedSlotOnSlot(arg_140_1, var_140_1)
	local var_140_3 = var_0_37(arg_140_0.weaponListRectTransform_, var_140_0)
	local var_140_4 = arg_140_1.itemId

	arg_140_0:ClearOptionDragState(false)
	arg_140_0:RefreshModifyVehicleSlots()
	arg_140_0:RefreshModifyVehicleDisplay()

	if var_140_2 and var_140_1 ~= nil then
		if SummerRaceAction.MoveEquippedSlotToSlot(arg_140_1.slotType, arg_140_1.slotIndex, var_140_1.slotType, var_140_1.slotIndex, var_140_4) then
			var_0_31()
			arg_140_0:MarkEquipAnimSlot(var_140_1.slotType, var_140_1.slotIndex)
			arg_140_0:RefreshModifyPanel()
		end

		return
	end

	if not var_140_3 then
		return
	end

	if SummerRaceAction.MoveEquippedSlotBackToList(arg_140_1.slotType, arg_140_1.slotIndex, var_140_4) then
		var_0_32()
		arg_140_0:RefreshModifyPanel()
	end
end

function var_0_2.OnModifySlotPointerDown(arg_141_0, arg_141_1, arg_141_2, arg_141_3)
	arg_141_0:ClearSlotGestureState()

	local var_141_0 = arg_141_0.modifySlotList_[arg_141_1]
	local var_141_1 = arg_141_2 and arg_141_2.position or nil

	if var_141_0 ~= nil then
		arg_141_0:HideModifyTips()
	end

	if arg_141_0.activePanelType_ ~= var_0_3.MODIFY then
		if var_141_0 ~= nil then
			arg_141_0.slotGesturePressContext_ = {
				slotIndex = arg_141_1,
				slotData = var_0_63(var_141_0),
				pressScreenPos = var_141_1,
				sourceGo = arg_141_3
			}
		end

		return
	end

	local var_141_2, var_141_3 = arg_141_0:ResolveHoveredSlotByScreenPosition(var_141_1)

	if var_141_2 ~= nil and var_141_3 ~= nil then
		arg_141_1 = var_141_3
		var_141_0 = var_141_2

		local var_141_4 = arg_141_0.vehicleSlotItemViews_[var_141_3]

		if var_141_4 ~= nil and var_141_4.gameObject_ ~= nil then
			arg_141_3 = var_141_4.gameObject_
		end
	end

	if var_141_0 == nil or var_141_0.isLocked == true or var_141_0.itemId == nil or tostring(var_141_0.itemId) == "" then
		return
	end

	arg_141_0.slotGesturePressContext_ = {
		slotIndex = arg_141_1,
		slotData = var_0_63(var_141_0),
		pressScreenPos = var_141_1,
		sourceGo = arg_141_3
	}
end

function var_0_2.OnModifySlotDrag(arg_142_0, arg_142_1, arg_142_2)
	if arg_142_0.activePanelType_ ~= var_0_3.MODIFY then
		return
	end

	local var_142_0 = arg_142_0.slotGesturePressContext_

	if var_142_0 == nil then
		return
	end

	if arg_142_0.slotGestureDragging_ ~= true then
		if not arg_142_0:ShouldStartSlotDrag(arg_142_2 and arg_142_2.position or nil) then
			return
		end

		arg_142_0.slotGestureDragging_ = true

		arg_142_0:BeginEquippedSlotDrag(var_142_0.slotData, arg_142_2, var_142_0.sourceGo)

		return
	end

	arg_142_0:UpdateEquippedSlotDrag(var_142_0.slotData, arg_142_2)
end

function var_0_2.OnModifySlotPointerUp(arg_143_0, arg_143_1, arg_143_2)
	local var_143_0 = arg_143_0.slotGesturePressContext_

	if var_143_0 == nil then
		arg_143_0:ClearSlotGestureState()

		return
	end

	if arg_143_0.slotGestureDragging_ == true then
		arg_143_0:EndEquippedSlotDrag(var_143_0.slotData, arg_143_2)
		arg_143_0:ClearSlotGestureState()

		return
	end

	local var_143_1 = arg_143_2 and arg_143_2.position or var_143_0.pressScreenPos

	if var_0_47(var_143_0.pressScreenPos, var_143_1, var_0_24) then
		arg_143_0:HandleModifySlotAction(var_143_0.slotData)
	end

	arg_143_0:ClearSlotGestureState()
end

function var_0_2.OnModifySlotEndDrag(arg_144_0, arg_144_1, arg_144_2)
	local var_144_0 = arg_144_0.slotGesturePressContext_

	if var_144_0 == nil then
		arg_144_0:ClearSlotGestureState()

		return
	end

	if not arg_144_0.slotGestureDragging_ then
		return
	end

	arg_144_0:EndEquippedSlotDrag(var_144_0.slotData, arg_144_2)
	arg_144_0:ClearSlotGestureState()
end

function var_0_2.RefreshBodyInfoPanel(arg_145_0)
	local var_145_0 = arg_145_0.modifyPageModel_ and arg_145_0.modifyPageModel_.selectedBody or nil
	local var_145_1 = var_0_51(var_145_0)

	if var_145_1 == nil or arg_145_0.bodyTipsView_ == nil then
		return
	end

	arg_145_0.bodyTipsView_:SetData(var_145_1)
end

function var_0_2.RefreshOptionInfoPanel(arg_146_0, arg_146_1, arg_146_2)
	if arg_146_1 == nil or arg_146_2 == nil then
		return
	end

	arg_146_1:SetData(arg_146_2)
end

function var_0_2.RefreshModifyInfoPanel(arg_147_0)
	local var_147_0 = arg_147_0.modifyPageModel_ and arg_147_0.modifyPageModel_.infoTargetType or "body"
	local var_147_1 = arg_147_0.modifyPageModel_ and arg_147_0.modifyPageModel_.selectedOption or nil
	local var_147_2 = var_0_50(var_147_1)
	local var_147_3 = var_147_0 == "option" and var_147_2 ~= nil
	local var_147_4 = not var_147_3 and arg_147_0.modifyPageModel_.selectedBody ~= nil

	if var_147_3 then
		local var_147_5 = var_0_66(var_147_1)

		arg_147_0.activeModifyTipsItemId_ = var_147_5

		if var_147_2.panelType == "equip" then
			arg_147_0:SetModifyTipsState("tips_m", var_147_5)
			arg_147_0:RefreshOptionInfoPanel(arg_147_0.equipTipsView_, var_147_2)
		else
			arg_147_0:SetModifyTipsState("tips_l", var_147_5)
			arg_147_0:RefreshOptionInfoPanel(arg_147_0.weaponTipsView_, var_147_2)
		end

		return
	end

	arg_147_0.activeModifyTipsItemId_ = nil

	if var_147_4 then
		arg_147_0:SetModifyTipsState("tips_s", arg_147_0.modifyPageModel_.selectedBody.bodyId)
		arg_147_0:RefreshBodyInfoPanel()

		return
	end

	arg_147_0:SetModifyTipsState("tips_s")
end

function var_0_2.ResolveInfoSelectedSlot(arg_148_0)
	local var_148_0 = var_0_55(arg_148_0.modifySlotList_, arg_148_0.infoSelectedSlotKey_)

	if var_148_0 ~= nil then
		return var_148_0
	end

	local var_148_1 = var_0_54(arg_148_0.modifySlotList_)

	arg_148_0.infoSelectedSlotKey_ = var_0_52(var_148_1)

	return var_148_1
end

function var_0_2.RefreshInfoVehicleTips(arg_149_0)
	local var_149_0 = arg_149_0:ResolveInfoSelectedSlot()
	local var_149_1

	if var_149_0 ~= nil and var_149_0.itemId ~= nil and tostring(var_149_0.itemId) ~= "" then
		var_149_1 = var_0_50(SummerRaceData:GetOptionDefById(var_149_0.itemId))
	end

	if var_149_1 ~= nil then
		if var_149_1.panelType == "equip" then
			arg_149_0.tipsController_:SetSelectedState("tips_m")
			arg_149_0:RefreshOptionInfoPanel(arg_149_0.equipTipsView_, var_149_1)
		else
			arg_149_0.tipsController_:SetSelectedState("tips_l")
			arg_149_0:RefreshOptionInfoPanel(arg_149_0.weaponTipsView_, var_149_1)
		end

		return
	end

	arg_149_0.tipsController_:SetSelectedState("tips_s")
	arg_149_0.bodyTipsView_:SetData(var_0_51(arg_149_0.infoVehicleSnapshot_))
end

function var_0_2.ApplyInfoVehiclePanel(arg_150_0, arg_150_1, arg_150_2)
	arg_150_0.infoVehicleSnapshot_ = arg_150_1 or {}
	arg_150_0.infoVehicleDisplayModel_ = arg_150_2
	arg_150_0.vehicleDisplayModel_ = arg_150_2
	arg_150_0.modifySlotList_ = var_0_64(arg_150_0.infoVehicleSnapshot_.slotSummary or {})

	local var_150_0 = arg_150_0:ResolveInfoSelectedSlot()
	local var_150_1 = var_0_52(var_150_0)

	for iter_150_0 = 1, #arg_150_0.modifySlotList_ do
		local var_150_2 = arg_150_0.modifySlotList_[iter_150_0]

		var_150_2.interactionMode = "inspect"
		var_150_2.itemClickEnabled = true
		var_150_2.showEquippedIcon = true
		var_150_2.isSelected = var_150_1 ~= "" and var_0_52(var_150_2) == var_150_1
	end

	local var_150_3 = arg_150_0.infoVehicleSnapshot_.costSummary or {}
	local var_150_4 = tonumber(arg_150_0.infoVehicleSnapshot_.totalCost) or tonumber(var_150_3.totalCost) or 0
	local var_150_5 = tonumber(var_150_3.budgetCost) or tonumber(arg_150_0.infoVehicleSnapshot_.cost) or 0

	arg_150_0.bodyHpText_.text = tostring(arg_150_0.infoVehicleSnapshot_.hp or "")
	arg_150_0.costText_.text = string.format("%s/%s", tostring(var_150_4), tostring(var_150_5))

	arg_150_0:RefreshInfoVehicleTips()
	arg_150_0:RefreshModifyVehicleDisplay()
end

function var_0_2.RefreshChangedBodyItems(arg_151_0, arg_151_1)
	for iter_151_0 = 1, #arg_151_0.bodyList_ do
		if var_0_72(arg_151_1[iter_151_0], arg_151_0.bodyList_[iter_151_0]) then
			local var_151_0 = arg_151_0.bodyItemList_:GetItemByIndex(iter_151_0)

			if var_151_0 ~= nil then
				var_151_0:SetData(arg_151_0.bodyList_[iter_151_0], iter_151_0, handler(arg_151_0, arg_151_0.OnBodyAction))
			end
		end
	end
end

function var_0_2.RefreshChangedOptionItems(arg_152_0, arg_152_1)
	for iter_152_0 = 1, #arg_152_0.optionList_ do
		if var_0_73(arg_152_1[iter_152_0], arg_152_0.optionList_[iter_152_0]) then
			local var_152_0 = arg_152_0.weaponOptionItemList_:GetItemByIndex(iter_152_0)

			if var_152_0 ~= nil then
				var_152_0:SetData(arg_152_0.optionList_[iter_152_0], iter_152_0, handler(arg_152_0, arg_152_0.OnOptionAction))
			end
		end
	end
end

function var_0_2.OnEnemyWaveAction(arg_153_0, arg_153_1, arg_153_2, arg_153_3)
	if arg_153_3 == "battleInfo" then
		local var_153_0 = tonumber(arg_153_2 and arg_153_2.waveIndex) or arg_153_1

		SummerRaceAction.OpenInfoPop({
			source = "stageDetail",
			stageId = arg_153_0.stageId_,
			waveIndex = var_153_0,
			enemyId = arg_153_2 and arg_153_2.enemyId or nil
		})
	end
end

function var_0_2.OnDetailSlotAction(arg_154_0, arg_154_1, arg_154_2, arg_154_3)
	if arg_154_3 ~= "select" then
		return
	end

	if arg_154_0.activePanelType_ ~= var_0_3.MODIFY then
		arg_154_0:HandleInfoSlotAction(arg_154_2)

		return
	end

	arg_154_0:HandleModifySlotAction(arg_154_2)
end

function var_0_2.OnRewardClick(arg_155_0, arg_155_1)
	local var_155_0 = arg_155_1
	local var_155_1

	if type(arg_155_1) == "table" then
		var_155_0 = arg_155_1.itemId
		var_155_1 = tonumber(arg_155_1.rewardType) or 0
	end

	if var_155_1 == 3 then
		return
	end

	local var_155_2 = SummerRaceData:GetOptionDefById(var_155_0)

	if var_155_2 == nil then
		return
	end

	SummerRaceAction.OpenEquipInfoPop(var_155_2.itemId)
end

function var_0_2.HandleInfoSlotAction(arg_156_0, arg_156_1)
	if arg_156_1 == nil then
		return
	end

	if arg_156_1.itemId == nil or tostring(arg_156_1.itemId) == "" then
		arg_156_0.infoSelectedSlotKey_ = nil
	else
		arg_156_0.infoSelectedSlotKey_ = var_0_52(arg_156_1)
	end

	arg_156_0:ApplyInfoVehiclePanel(arg_156_0.infoVehicleSnapshot_, arg_156_0.infoVehicleDisplayModel_)
end

function var_0_2.HandleModifySlotAction(arg_157_0, arg_157_1)
	if arg_157_0.activePanelType_ ~= var_0_3.MODIFY then
		arg_157_0:HandleInfoSlotAction(arg_157_1)

		return
	end

	if arg_157_1 == nil then
		return
	end

	if arg_157_1.isLocked == true then
		return
	end

	if arg_157_1.itemId ~= nil and tostring(arg_157_1.itemId) ~= "" then
		SummerRaceAction.SelectModifySlot(arg_157_1.slotType, arg_157_1.slotIndex)
		SummerRaceAction.PreviewOption(arg_157_1.itemId, false)

		return
	end

	if arg_157_0.selectedModifySlot_ ~= nil and arg_157_0.selectedModifySlot_.slotType == arg_157_1.slotType and tonumber(arg_157_0.selectedModifySlot_.slotIndex) == tonumber(arg_157_1.slotIndex) then
		SummerRaceAction.ClearModifySlotSelection()

		return
	end

	SummerRaceAction.SelectModifySlot(arg_157_1.slotType, arg_157_1.slotIndex)
end

function var_0_2.HideModifyTips(arg_158_0)
	if arg_158_0.tipsController_ ~= nil then
		arg_158_0.tipsController_:SetSelectedState("none")
	end

	arg_158_0.activeModifyTipsItemId_ = nil
	arg_158_0.activeModifyTipsSignature_ = nil
end

function var_0_2.SetModifyTipsState(arg_159_0, arg_159_1, arg_159_2)
	local var_159_0 = var_0_58(arg_159_1, arg_159_2)

	if arg_159_0.activeModifyTipsSignature_ == var_159_0 then
		return
	end

	if arg_159_0.tipsController_ ~= nil then
		arg_159_0.tipsController_:SetSelectedState(arg_159_1)
	end

	arg_159_0.activeModifyTipsSignature_ = var_159_0
end

function var_0_2.HideAllTips(arg_160_0)
	arg_160_0:HideModifyTips()

	if arg_160_0.battleInfoView_ ~= nil and type(arg_160_0.battleInfoView_.HideTips) == "function" then
		arg_160_0.battleInfoView_:HideTips(true)
	end
end

function var_0_2.RefreshModifyPanel(arg_161_0)
	if arg_161_0.bodySwitchTransitioning_ == true then
		return
	end

	local var_161_0 = arg_161_0.bodyList_ or {}
	local var_161_1 = arg_161_0.optionList_ or {}

	arg_161_0.modifyPageModel_ = SummerRaceData:GetModifyPageModel()
	arg_161_0.bodyList_ = arg_161_0.modifyPageModel_.bodyList or {}
	arg_161_0.optionList_ = arg_161_0.modifyPageModel_.weaponOptionList or {}
	arg_161_0.modifySlotList_ = arg_161_0.modifyPageModel_.slotList or {}
	arg_161_0.vehicleLayout_ = arg_161_0.modifyPageModel_.vehicleLayout
	arg_161_0.vehicleDisplayModel_ = arg_161_0.modifyPageModel_.vehicleDisplay
	arg_161_0.selectedModifySlot_ = arg_161_0.modifyPageModel_.selectedSlot
	arg_161_0.optionCostAvailableCost_ = arg_161_0.modifyPageModel_.costSummary and arg_161_0.modifyPageModel_.costSummary.remainingCost or 0
	arg_161_0.bodyHpText_.text = tostring(arg_161_0.modifyPageModel_.selectedBody.hp or "")

	arg_161_0:RefreshModifyInfoPanel()

	arg_161_0.costText_.text = string.format("%s/%s", arg_161_0.modifyPageModel_.costSummary.totalCost, arg_161_0.modifyPageModel_.costSummary.budgetCost)
	arg_161_0.confirmBtn_.interactable = arg_161_0.modifyPageModel_.costSummary.isOverflow ~= true

	local var_161_2 = var_0_29(arg_161_0.modifyPageModel_.filterType)

	arg_161_0.bottomTabController_:SetSelectedState(var_161_2)
	var_0_30(arg_161_0.filterAllSelectControllerEx_, var_161_2 == "all")
	var_0_30(arg_161_0.filterWeaponSelectControllerEx_, var_161_2 == "weapon")
	var_0_30(arg_161_0.filterEquipSelectControllerEx_, var_161_2 == "parts")
	arg_161_0.optionMaskController_:SetSelectedState(arg_161_0.modifyPageModel_.optionListLocked and "show" or "hide")

	if var_0_71(var_161_0, arg_161_0.bodyList_, "bodyId") then
		arg_161_0.bodyItemList_:StartScroll(#arg_161_0.bodyList_)
	else
		arg_161_0:RefreshChangedBodyItems(var_161_0)
	end

	if var_0_71(var_161_1, arg_161_0.optionList_, "itemId") then
		arg_161_0.weaponOptionItemList_:StartScroll(#arg_161_0.optionList_)
	else
		arg_161_0:RefreshChangedOptionItems(var_161_1)
	end

	arg_161_0:RefreshVisibleOptionItemCostStates()
	arg_161_0:RefreshModifyVehicleDisplay()
end

function var_0_2.FinishBodySwitchTransition(arg_162_0)
	arg_162_0.bodySwitchTransitioning_ = false

	arg_162_0:RefreshModifyPanel()

	local function var_162_0()
		arg_162_0:FadeInModifyVehicleSlotLayer()
	end

	if arg_162_0.vehicleDisplayView_ ~= nil and arg_162_0.vehicleDisplayView_:PlayBodyAnimation(var_0_11, false) == true then
		var_162_0()

		return
	end

	var_162_0()
end

function var_0_2.PlayBodySwitchTransition(arg_164_0, arg_164_1)
	if arg_164_0.bodySwitchTransitioning_ == true then
		return
	end

	local var_164_0 = tostring(arg_164_1 or "")
	local var_164_1 = arg_164_0.modifyPageModel_ and arg_164_0.modifyPageModel_.selectedBody and arg_164_0.modifyPageModel_.selectedBody.bodyId or nil

	if var_164_0 ~= "" and tostring(var_164_1 or "") == var_164_0 then
		SummerRaceData:MarkBodyNewRedPointRead(arg_164_1, true)

		return
	end

	if SummerRaceData:CanSelectBody(arg_164_1) ~= true then
		SummerRaceAction.SelectBody(arg_164_1)

		return
	end

	arg_164_0.bodySwitchTransitioning_ = true

	arg_164_0:HideModifyVehicleSlotLayerForBodySwitch()

	local function var_164_2()
		if SummerRaceAction.SelectBody(arg_164_1) then
			SummerRaceData:MarkBodyNewRedPointRead(arg_164_1, true)
			arg_164_0:FinishBodySwitchTransition()
		else
			arg_164_0.bodySwitchTransitioning_ = false

			arg_164_0:ShowModifyVehicleSlotLayerImmediate()
		end
	end

	if arg_164_0.vehicleDisplayView_ == nil then
		var_164_2()

		return
	end

	if arg_164_0.vehicleDisplayView_:PlayBodyAnimation(var_0_12, false, var_164_2) ~= true then
		var_164_2()
	end
end

function var_0_2.BuildStageDetailPanelModel(arg_166_0)
	return SummerRaceData:GetStageDetailModel(arg_166_0.stageId_)
end

function var_0_2.BuildInfoPanelModel(arg_167_0)
	if arg_167_0.activePanelType_ == var_0_3.CHALLENGE then
		return arg_167_0:BuildChallengePanelModel()
	end

	return arg_167_0:BuildStageDetailPanelModel()
end

function var_0_2.BuildChallengePanelModel(arg_168_0)
	return SummerRaceData:GetChallengePageModel()
end

function var_0_2.ApplyStageDetailPanelModel(arg_169_0, arg_169_1)
	arg_169_0.stageId_ = arg_169_1.stageInfo.stageId

	arg_169_0.battleInfoView_:ApplyStageDetailModel(arg_169_1)
	arg_169_0:ApplyInfoVehiclePanel(arg_169_1.vehicleSnapshot, arg_169_1.vehicleDisplay)
end

function var_0_2.ApplyInfoPanelModel(arg_170_0, arg_170_1)
	if arg_170_0.activePanelType_ == var_0_3.CHALLENGE then
		arg_170_0:ApplyChallengePanelModel(arg_170_1)

		return
	end

	arg_170_0:ApplyStageDetailPanelModel(arg_170_1)
end

function var_0_2.ApplyChallengePanelModel(arg_171_0, arg_171_1)
	if arg_171_1.stageInfo ~= nil then
		arg_171_0.stageId_ = arg_171_1.stageInfo.stageId
	end

	arg_171_0.battleInfoView_:ApplyChallengeModel(arg_171_1)
	arg_171_0:ApplyInfoVehiclePanel(arg_171_1.currentBuild, arg_171_1.vehicleDisplay)
end

function var_0_2.RefreshChallengePanel(arg_172_0)
	arg_172_0:ApplyChallengePanelModel(arg_172_0:BuildChallengePanelModel())
end

function var_0_2.HandleStageBattleStart(arg_173_0)
	local var_173_0 = arg_173_0:BuildStageDetailPanelModel()

	if var_173_0 ~= nil and var_173_0.stageInfo ~= nil then
		arg_173_0.stageId_ = var_173_0.stageInfo.stageId
	end

	SummerRaceAction.EnterStageBattle(arg_173_0.stageId_, var_0_3.STAGE_DETAIL)
end

function var_0_2.HandleChallengeBattleStart(arg_174_0)
	SummerRaceAction.EnterChallengeBattle(var_0_3.CHALLENGE)
end

function var_0_2.RefreshInfoPanel(arg_175_0)
	arg_175_0:ApplyInfoPanelModel(arg_175_0:BuildInfoPanelModel())
end

function var_0_2.BuildInfoPanelModelByPanelType(arg_176_0, arg_176_1)
	if arg_176_1 == var_0_3.CHALLENGE then
		return arg_176_0:BuildChallengePanelModel()
	end

	return arg_176_0:BuildStageDetailPanelModel()
end

function var_0_2.RefreshBattleInfoAdminPos(arg_177_0, arg_177_1)
	if arg_177_0.battleInfoView_ == nil or type(arg_177_0.battleInfoView_.SyncAdminPos) ~= "function" then
		return
	end

	local var_177_0 = arg_177_0:BuildInfoPanelModelByPanelType(arg_177_1)

	arg_177_0.battleInfoView_:SyncAdminPos(var_177_0 and var_177_0.vehicleDisplay)
end

function var_0_2.ShowModifyPanel(arg_178_0, arg_178_1)
	arg_178_0:HideModifyTips()

	if arg_178_0.battleInfoView_ ~= nil and type(arg_178_0.battleInfoView_.SetOpenAnimEnabled) == "function" then
		arg_178_0.battleInfoView_:SetOpenAnimEnabled(true)
	end

	if arg_178_0.bodyTipsView_ ~= nil then
		arg_178_0.bodyTipsView_:SetData(nil)
	end

	if arg_178_0.weaponTipsView_ ~= nil then
		arg_178_0.weaponTipsView_:SetData(nil)
	end

	if arg_178_0.equipTipsView_ ~= nil then
		arg_178_0.equipTipsView_:SetData(nil)
	end

	SetActive(arg_178_0.bgGo_, true)
	var_0_85(arg_178_0, var_0_3.MODIFY)
	SetActive(arg_178_0.modifyPanelGo_, true)
	var_0_79(arg_178_0.battleInfoCanvasGroup_, false)
	SetActive(arg_178_0.battleInfoGo_, false)
	arg_178_0:SetDropAreaHintState(var_0_28.NONE)

	if arg_178_0.modifyPageModel_ ~= nil then
		arg_178_0:RefreshModifyInfoPanel()
	end

	if arg_178_1 then
		arg_178_0:PlayModifyAnim(var_0_4)
	end
end

function var_0_2.ShowBattleInfoPanel(arg_179_0)
	var_0_85(arg_179_0, arg_179_0.activePanelType_)
	SetActive(arg_179_0.bgGo_, false)
	SetActive(arg_179_0.modifyPanelGo_, false)
	SetActive(arg_179_0.battleInfoGo_, true)
	var_0_79(arg_179_0.battleInfoCanvasGroup_, true)

	if arg_179_0.battleInfoView_ ~= nil and type(arg_179_0.battleInfoView_.PlayOpenAnim) == "function" then
		arg_179_0.battleInfoView_:PlayOpenAnim()
	end

	arg_179_0:SetDropAreaHintState(var_0_28.NONE)
end

function var_0_2.ClearModifyVehicleSlots(arg_180_0)
	for iter_180_0 = 1, #(arg_180_0.vehicleSlotItemViews_ or {}) do
		local var_180_0 = arg_180_0.vehicleSlotItemViews_[iter_180_0]
		local var_180_1 = var_180_0.gameObject_
		local var_180_2 = var_180_0.slotGestureListener_

		if var_180_2 == nil and var_180_1 ~= nil then
			var_180_2 = var_180_1:GetComponent(typeof(EventTriggerListener))
		end

		if var_180_2 ~= nil then
			var_180_2:RemoveAllListeners()
			var_0_69(arg_180_0, var_180_2)

			var_180_0.slotGestureListener_ = nil
		end

		var_180_0:Dispose()

		if var_180_1 ~= nil then
			Object.Destroy(var_180_1)
		end
	end

	arg_180_0.vehicleSlotItemViews_ = {}
	arg_180_0.vehicleSlotSignature_ = ""
end

function var_0_2.EnsureModifyVehicleSlotLayer(arg_181_0)
	local var_181_0 = arg_181_0.carRootGo_.transform

	if arg_181_0.vehicleSlotLayerGo_ == nil then
		arg_181_0.vehicleSlotLayerGo_ = GameObject("SlotLayer")

		local var_181_1 = arg_181_0.vehicleSlotLayerGo_:AddComponent(typeof(RectTransform))

		var_181_1:SetParent(var_181_0, false)

		var_181_1.anchorMin = Vector2.New(0.5, 0.5)
		var_181_1.anchorMax = Vector2.New(0.5, 0.5)
		var_181_1.pivot = Vector2.New(0.5, 0.5)
		var_181_1.anchoredPosition = Vector2.zero
		var_181_1.sizeDelta = Vector2.zero
		arg_181_0.vehicleSlotLayerCanvasGroup_ = var_0_80(arg_181_0.vehicleSlotLayerGo_)
	elseif arg_181_0.vehicleSlotLayerGo_.transform.parent ~= var_181_0 then
		arg_181_0.vehicleSlotLayerGo_.transform:SetParent(var_181_0, false)
	end

	if arg_181_0.vehicleSlotLayerCanvasGroup_ == nil then
		arg_181_0.vehicleSlotLayerCanvasGroup_ = var_0_80(arg_181_0.vehicleSlotLayerGo_)
	end

	arg_181_0.vehicleSlotLayerGo_.transform:SetAsLastSibling()

	return arg_181_0.vehicleSlotLayerGo_.transform
end

function var_0_2.ClearModifyVehicleDisplay(arg_182_0)
	var_0_74(arg_182_0)

	arg_182_0.vehicleSlotLayerHoldHidden_ = false

	arg_182_0:ClearModifyVehicleSlots()

	if arg_182_0.vehicleSlotLayerGo_ ~= nil then
		Object.Destroy(arg_182_0.vehicleSlotLayerGo_)

		arg_182_0.vehicleSlotLayerGo_ = nil
		arg_182_0.vehicleSlotLayerCanvasGroup_ = nil
	end

	arg_182_0.vehicleModuleLayerCanvasGroup_ = nil
end

function var_0_2.GetModifyVehicleModuleLayerCanvasGroup(arg_183_0)
	if arg_183_0.vehicleDisplayView_ == nil or type(arg_183_0.vehicleDisplayView_.GetModuleLayerGo) ~= "function" then
		return nil
	end

	local var_183_0 = arg_183_0.vehicleDisplayView_:GetModuleLayerGo()

	if var_183_0 == nil then
		arg_183_0.vehicleModuleLayerCanvasGroup_ = nil

		return nil
	end

	if arg_183_0.vehicleModuleLayerCanvasGroup_ == nil then
		arg_183_0.vehicleModuleLayerCanvasGroup_ = var_0_80(var_183_0)
	end

	return arg_183_0.vehicleModuleLayerCanvasGroup_
end

function var_0_2.SetModifyVehicleSlotLayerVisible(arg_184_0, arg_184_1, arg_184_2)
	if arg_184_0.vehicleSlotLayerGo_ == nil then
		return
	end

	arg_184_0.vehicleSlotLayerCanvasGroup_ = arg_184_0.vehicleSlotLayerCanvasGroup_ or var_0_80(arg_184_0.vehicleSlotLayerGo_)

	if arg_184_0.vehicleSlotLayerCanvasGroup_ == nil then
		return
	end

	local var_184_0 = arg_184_2 == true

	arg_184_0.vehicleSlotLayerCanvasGroup_.alpha = arg_184_1
	arg_184_0.vehicleSlotLayerCanvasGroup_.interactable = var_184_0
	arg_184_0.vehicleSlotLayerCanvasGroup_.blocksRaycasts = var_184_0

	local var_184_1 = arg_184_0:GetModifyVehicleModuleLayerCanvasGroup()

	if var_184_1 ~= nil then
		var_184_1.alpha = arg_184_1
		var_184_1.interactable = var_184_0
		var_184_1.blocksRaycasts = var_184_0
	end
end

function var_0_2.HideModifyVehicleSlotLayerForBodySwitch(arg_185_0)
	var_0_74(arg_185_0)

	arg_185_0.vehicleSlotLayerHoldHidden_ = true

	arg_185_0:SetModifyVehicleSlotLayerVisible(0, false)
end

function var_0_2.ShowModifyVehicleSlotLayerImmediate(arg_186_0)
	var_0_74(arg_186_0)

	arg_186_0.vehicleSlotLayerHoldHidden_ = false

	arg_186_0:SetModifyVehicleSlotLayerVisible(1, true)
end

function var_0_2.FadeInModifyVehicleSlotLayer(arg_187_0)
	var_0_74(arg_187_0)

	arg_187_0.vehicleSlotLayerHoldHidden_ = false

	if arg_187_0.activePanelType_ ~= var_0_3.MODIFY or arg_187_0.vehicleSlotLayerGo_ == nil then
		return
	end

	arg_187_0.vehicleSlotLayerCanvasGroup_ = arg_187_0.vehicleSlotLayerCanvasGroup_ or var_0_80(arg_187_0.vehicleSlotLayerGo_)

	if arg_187_0.vehicleSlotLayerCanvasGroup_ == nil then
		return
	end

	arg_187_0:SetModifyVehicleSlotLayerVisible(0, false)

	arg_187_0.vehicleSlotLayerFadeTween_ = LeanTween.value(arg_187_0.vehicleSlotLayerGo_, 0, 1, var_0_14):setDelay(var_0_13):setEase(LeanTweenType.easeOutQuad):setOnUpdate(LuaHelper.FloatAction(function(arg_188_0)
		arg_187_0:SetModifyVehicleSlotLayerVisible(arg_188_0, false)
	end)):setOnComplete(System.Action(function()
		arg_187_0.vehicleSlotLayerFadeTween_ = nil

		arg_187_0:SetModifyVehicleSlotLayerVisible(1, true)
	end))
end

function var_0_2.ApplyModifySlotTransform(arg_190_0, arg_190_1, arg_190_2)
	if arg_190_1 == nil or arg_190_1.transform_ == nil or arg_190_2 == nil then
		return
	end

	local var_190_0 = arg_190_1.transform_:GetComponent(typeof(RectTransform))

	if var_190_0 == nil then
		return
	end

	var_190_0.anchoredPosition = var_0_62(arg_190_0.vehicleDisplayView_, arg_190_2.displayLocalPosition) or var_0_61(arg_190_0.vehicleDisplayView_, arg_190_2.localPosition)
	var_190_0.localEulerAngles = Vector3.New(0, 0, tonumber(arg_190_2.localAngle) or 0)
	var_190_0.localScale = Vector3.New(1, 1, 1)
end

function var_0_2.BuildModifyVehicleSlots(arg_191_0)
	if arg_191_0.vehicleSlotItemPrefab_ == nil then
		error("[SummerRaceModifyView] missing slot item prefab: " .. var_0_20)
	end

	local var_191_0 = arg_191_0:EnsureModifyVehicleSlotLayer()

	for iter_191_0 = 1, #arg_191_0.modifySlotList_ do
		local var_191_1 = Object.Instantiate(arg_191_0.vehicleSlotItemPrefab_, var_191_0)
		local var_191_2 = var_0_63(arg_191_0.modifySlotList_[iter_191_0])
		local var_191_3 = SummerRaceEquipSlotItemView.New(var_191_1)

		var_191_2.playEquipAnim = arg_191_0:ShouldPlayEquipAnim(var_191_2)

		arg_191_0:ApplyModifySlotTransform(var_191_3, var_191_2)
		var_191_3:SetData(var_191_2, iter_191_0, handler(arg_191_0, arg_191_0.OnDetailSlotAction))

		local var_191_4 = var_191_1

		if var_191_3.dragAreaObj_ ~= nil then
			var_191_4 = var_191_3.dragAreaObj_
		elseif var_191_3.icon_ ~= nil and var_191_3.icon_.gameObject ~= nil then
			var_191_4 = var_191_3.icon_.gameObject
		end

		var_191_3.slotGestureListener_ = var_0_45(arg_191_0, var_191_4, function(arg_192_0)
			arg_191_0:OnModifySlotPointerDown(iter_191_0, arg_192_0, var_191_1)
		end, function(arg_193_0)
			arg_191_0:OnModifySlotDrag(iter_191_0, arg_193_0)
		end, function(arg_194_0)
			arg_191_0:OnModifySlotPointerUp(iter_191_0, arg_194_0)
		end, function(arg_195_0)
			arg_191_0:OnModifySlotEndDrag(iter_191_0, arg_195_0)
		end)
		arg_191_0.vehicleSlotItemViews_[#arg_191_0.vehicleSlotItemViews_ + 1] = var_191_3
	end

	arg_191_0.vehicleSlotSignature_ = var_0_56(arg_191_0.modifySlotList_)
end

function var_0_2.RefreshModifyVehicleSlots(arg_196_0)
	for iter_196_0 = 1, #arg_196_0.modifySlotList_ do
		local var_196_0 = arg_196_0.vehicleSlotItemViews_[iter_196_0]
		local var_196_1 = var_0_63(arg_196_0.modifySlotList_[iter_196_0])

		var_196_1.playEquipAnim = arg_196_0:ShouldPlayEquipAnim(var_196_1)

		SetActive(var_196_0.gameObject_, true)
		arg_196_0:ApplyModifySlotTransform(var_196_0, var_196_1)
		var_196_0:SetData(var_196_1, iter_196_0, handler(arg_196_0, arg_196_0.OnDetailSlotAction))
	end
end

function var_0_2.RefreshModifyVehicleDisplay(arg_197_0)
	local var_197_0 = var_0_56(arg_197_0.modifySlotList_)
	local var_197_1 = arg_197_0.vehicleDisplayModel_
	local var_197_2 = var_0_84(arg_197_0)
	local var_197_3 = arg_197_0.activePanelType_ == var_0_3.MODIFY

	if arg_197_0.dragSlotSourceData_ ~= nil and var_197_1 ~= nil then
		var_197_1 = var_0_67(var_197_1)
		var_197_1.modules = {}

		for iter_197_0 = 1, #(arg_197_0.vehicleDisplayModel_.modules or {}) do
			local var_197_4 = arg_197_0.vehicleDisplayModel_.modules[iter_197_0]

			if not var_0_68(var_197_4, arg_197_0.dragSlotSourceData_) then
				var_197_1.modules[#var_197_1.modules + 1] = var_0_63(var_197_4)
			end
		end
	end

	arg_197_0.vehicleDisplayView_:AttachHost(var_197_2)
	arg_197_0.vehicleDisplayView_:SetData(var_197_1)

	if type(arg_197_0.vehicleDisplayView_.SetModuleDragSourceSlotData) == "function" then
		arg_197_0.vehicleDisplayView_:SetModuleDragSourceSlotData(arg_197_0.dragSlotSourceData_)
	end

	local var_197_5 = #arg_197_0.vehicleSlotItemViews_ ~= #arg_197_0.modifySlotList_ or arg_197_0.vehicleSlotSignature_ ~= var_197_0
	local var_197_6 = var_197_1 and tostring(var_197_1.bodySkeletonDataPath or "") or ""

	if var_197_1 == nil or var_197_6 == "" then
		arg_197_0:ClearModifyVehicleDisplay()

		return
	end

	if not var_197_3 then
		arg_197_0:ClearModifyVehicleSlots()

		return
	end

	arg_197_0:EnsureModifyVehicleSlotLayer()

	if arg_197_0.vehicleSlotLayerHoldHidden_ == true then
		arg_197_0:SetModifyVehicleSlotLayerVisible(0, false)
	elseif arg_197_0.vehicleSlotLayerFadeTween_ == nil then
		arg_197_0:SetModifyVehicleSlotLayerVisible(1, true)
	end

	if var_197_5 then
		arg_197_0:ClearModifyVehicleSlots()
		arg_197_0:BuildModifyVehicleSlots()
	else
		arg_197_0:RefreshModifyVehicleSlots()
	end
end

function var_0_2.StopModifyAnimTimer(arg_198_0, arg_198_1)
	if arg_198_0.modifyAnimTimer_ ~= nil then
		arg_198_0.modifyAnimTimer_:Stop()

		arg_198_0.modifyAnimTimer_ = nil
	end

	if arg_198_1 == true then
		manager.ui:UIEventEnabledByUI(true, false)
	end
end

function var_0_2.PlayModifyAnim(arg_199_0, arg_199_1, arg_199_2, arg_199_3, arg_199_4)
	arg_199_0:StopModifyAnimTimer(false)

	if arg_199_4 == true then
		manager.ui:UIEventEnabledByUI(false, true)
	end

	local var_199_0 = var_0_82(arg_199_0.modifyAnimator_, arg_199_1, arg_199_2)

	if var_199_0 == nil then
		arg_199_0:StopModifyAnimTimer(arg_199_4)

		if arg_199_3 ~= nil then
			arg_199_3()
		end

		return
	end

	local var_199_1 = 0
	local var_199_2 = var_0_8 + 0.2

	arg_199_0.modifyAnimator_:Play(var_199_0, -1, 0)
	arg_199_0.modifyAnimator_:Update(0)

	arg_199_0.modifyAnimTimer_ = Timer.New(function()
		var_199_1 = var_199_1 + var_0_7

		local var_200_0 = arg_199_0.modifyAnimator_:GetCurrentAnimatorStateInfo(0)
		local var_200_1 = var_0_81(arg_199_0.modifyAnimator_, var_199_0) and var_200_0.normalizedTime >= 1

		if not var_200_1 and var_199_1 >= var_199_2 then
			var_200_1 = true
		end

		if var_200_1 then
			arg_199_0:StopModifyAnimTimer(arg_199_4)

			if arg_199_3 ~= nil then
				arg_199_3()
			end
		end
	end, var_0_7, -1)

	arg_199_0.modifyAnimTimer_:Start()
end

function var_0_2.PlayModifyExit(arg_201_0, arg_201_1)
	if arg_201_1 ~= var_0_3.MODIFY and arg_201_0.battleInfoView_ ~= nil and type(arg_201_0.battleInfoView_.SetOpenAnimEnabled) == "function" then
		arg_201_0.battleInfoView_:SetOpenAnimEnabled(false)
	end

	SetActive(arg_201_0.modifyPanelGo_, true)
	SetActive(arg_201_0.battleInfoGo_, true)
	var_0_79(arg_201_0.battleInfoCanvasGroup_, false)
	var_0_85(arg_201_0, arg_201_1)
	arg_201_0:RefreshBattleInfoAdminPos(arg_201_1)
	arg_201_0:PlayModifyAnim(var_0_5, var_0_6, function()
		arg_201_0.activePanelType_ = arg_201_1
		arg_201_0.returnPanelType_ = nil

		arg_201_0:RefreshInfoPanel()
		arg_201_0:ShowBattleInfoPanel()
	end, true)
end

function var_0_2.RefreshView(arg_203_0)
	if arg_203_0.modifyAnimTimer_ ~= nil or arg_203_0.bodySwitchTransitioning_ == true then
		return
	end

	if arg_203_0.activePanelType_ == var_0_3.MODIFY then
		arg_203_0:RefreshModifyPanel()

		return
	end

	arg_203_0:RefreshInfoPanel()
end

function var_0_2.Dispose(arg_204_0)
	arg_204_0:HideAllTips()
	arg_204_0:ClearOptionListGestureState()
	arg_204_0:ClearOptionDragState(false)
	arg_204_0:ClearSlotGestureState()
	arg_204_0:StopEquipAnimTimer()
	var_0_76(arg_204_0)
	var_0_77(arg_204_0)

	arg_204_0.bodySwitchTransitioning_ = false

	var_0_2.super.Dispose(arg_204_0)

	if arg_204_0.bodyItemList_ then
		arg_204_0.bodyItemList_:Dispose()

		arg_204_0.bodyItemList_ = nil
	end

	if arg_204_0.weaponOptionItemList_ then
		arg_204_0.weaponOptionItemList_:Dispose()

		arg_204_0.weaponOptionItemList_ = nil
	end

	if arg_204_0.battleInfoView_ then
		arg_204_0.battleInfoView_:Dispose()

		arg_204_0.battleInfoView_ = nil
	end

	if arg_204_0.vehicleDisplayView_ then
		arg_204_0.vehicleDisplayView_:Dispose()

		arg_204_0.vehicleDisplayView_ = nil
	end

	arg_204_0:ClearModifyVehicleDisplay()
	arg_204_0:StopModifyAnimTimer(true)

	if arg_204_0.vehicleSlotItemPrefab_ ~= nil then
		Asset.Unload(var_0_20)

		arg_204_0.vehicleSlotItemPrefab_ = nil
	end

	if arg_204_0.propertiesItemPrefab_ ~= nil then
		Asset.Unload(var_0_22)

		arg_204_0.propertiesItemPrefab_ = nil
	end

	if arg_204_0.optionDragPreviewPrefab_ ~= nil then
		Asset.Unload(var_0_21)

		arg_204_0.optionDragPreviewPrefab_ = nil
	end

	if arg_204_0.bodyTipsView_ then
		arg_204_0.bodyTipsView_:Dispose()

		arg_204_0.bodyTipsView_ = nil
	end

	if arg_204_0.weaponTipsView_ then
		arg_204_0.weaponTipsView_:Dispose()

		arg_204_0.weaponTipsView_ = nil
	end

	if arg_204_0.equipTipsView_ then
		arg_204_0.equipTipsView_:Dispose()

		arg_204_0.equipTipsView_ = nil
	end

	arg_204_0.tipsController_ = nil
	arg_204_0.windowBarBackHandler_ = nil
end

return var_0_2
