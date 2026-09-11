local SummerRaceBodyTipsView = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceBodyTipsView")
local SummerRaceOptionTipsView = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceOptionTipsView")
local SummerRaceModifyView = class("SummerRaceModifyView", ReduxView)
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

	if string.sub(var_6_0, 1, #"Assets/ABResources/") == "Assets/ABResources/" then
		var_6_0 = string.sub(var_6_0, #"Assets/ABResources/" + 1)
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

	local var_10_1 = var_10_0.y - (arg_10_0.rect.yMin + arg_10_0.rect.yMax) * 0.5

	return (var_10_0.x - (arg_10_0.rect.xMin + arg_10_0.rect.xMax) * 0.5) * (var_10_0.x - (arg_10_0.rect.xMin + arg_10_0.rect.xMax) * 0.5) + var_10_1 * var_10_1
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
	local var_12_0

	if arg_12_1 then
		var_12_0 = arg_12_1.moduleSize or nil
	end

	local var_12_1 = tonumber(arg_12_1 and arg_12_1.moduleScale) or 1

	if var_12_1 <= 0 then
		var_12_1 = 1
	end

	local var_12_3

	if arg_12_0 then
		var_12_3 = arg_12_0.sizeDelta or nil
	end

	local var_12_4 = var_12_3 and tonumber(var_12_3.x) or 0
	local var_12_5 = var_12_3 and tonumber(var_12_3.y) or 0
	local var_12_6 = (var_12_0 and tonumber(var_12_0.x) or 0) * SummerRaceConst.DISPLAY.CANVAS_SCALE
	local var_12_7 = (var_12_0 and tonumber(var_12_0.y) or 0) * SummerRaceConst.DISPLAY.CANVAS_SCALE

	return ((var_12_4 > 0 and var_12_5 > 0 and var_12_6 > 0 and var_12_7 > 0 or nil) and math.min(var_12_6 / var_12_4, var_12_7 / var_12_5)) * var_12_1
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
	local var_15_0 = var_0_34((arg_15_0 or nil) and (arg_15_0.skeletonDataPath or ""))

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

	var_15_3.sizeDelta = Vector2.New(var_15_3.sizeDelta.x * (SummerRaceConst.DISPLAY.CANVAS_SCALE / 100), var_15_3.sizeDelta.y * (SummerRaceConst.DISPLAY.CANVAS_SCALE / 100))

	var_15_4:UpdateMesh()

	var_15_4.color = Color.New(1, 1, 1, 1)

	local var_15_5 = var_0_40(var_15_3, arg_15_0)

	var_15_3.localScale = Vector3.New(var_15_5, var_15_5, var_15_5)

	if arg_15_0 then
		if var_0_35(arg_15_0.skeletonDataPath or "") then
			var_0_41(var_15_4, var_0_27)
		end
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

	return math.abs((arg_26_1 and tonumber(arg_26_1.x) or 0) - var_26_0), math.abs((arg_26_1 and tonumber(arg_26_1.y) or 0) - (arg_26_0 and tonumber(arg_26_0.y) or 0))
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

	local var_31_0 = {}

	var_31_0.title = tostring(arg_31_0.bodyName or "")
	var_31_0.desc = tostring(arg_31_0.desc or arg_31_0.bodyDesc or "")
	var_31_0.hpText = var_0_48(arg_31_0.hp, 0)
	var_31_0.costText = var_0_48(arg_31_0.cost, 0)

	return var_31_0
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
		if arg_34_0[iter_34_0] ~= nil and arg_34_0[iter_34_0].isLocked ~= true and arg_34_0[iter_34_0].itemId ~= nil and tostring(arg_34_0[iter_34_0].itemId) ~= "" then
			return arg_34_0[iter_34_0]
		end
	end

	return nil
end

local function var_0_55(arg_35_0, arg_35_1)
	if arg_35_1 == nil or arg_35_1 == "" then
		return nil
	end

	for iter_35_0 = 1, #(arg_35_0 or {}) do
		if var_0_52(arg_35_0[iter_35_0]) == arg_35_1 then
			return arg_35_0[iter_35_0]
		end
	end

	return nil
end

local function var_0_56(arg_36_0)
	local var_36_0 = {}

	for iter_36_0 = 1, #(arg_36_0 or {}) do
		local var_36_1 = arg_36_0[iter_36_0].localPosition or {}
		local var_36_2 = arg_36_0[iter_36_0].displayLocalPosition or {}
		local var_36_3 = #var_36_0 + 1
		local var_36_4 = tostring(arg_36_0[iter_36_0].slotType or "")
		local var_36_5 = tostring(arg_36_0[iter_36_0].slotIndex or 0)
		local var_36_6 = tostring(arg_36_0[iter_36_0].mountName or "")
		local var_36_7 = tostring(var_36_1.x or 0)

		var_36_0[var_36_3] = string.format("%s|%s|%s|%s|%s|%s|%s|%s", var_36_4, var_36_5, var_36_6, var_36_7, tostring(var_36_1.y or 0), tostring(var_36_2.x or 0), tostring(var_36_2.y or 0), tostring(arg_36_0[iter_36_0].localAngle or 0))
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
		local var_42_2
		local var_42_1

		if var_42_0 ~= nil then
			do return Vector2.New(var_42_0.x, var_42_0.y) end

			var_42_1 = arg_42_1 and tonumber(arg_42_1.x) or 0
			var_42_2 = arg_42_1 and tonumber(arg_42_1.y) or 0
		end
	end

	return Vector2.New(var_42_1 * SummerRaceConst.DISPLAY.CANVAS_SCALE, -var_42_2 * SummerRaceConst.DISPLAY.CANVAS_SCALE)
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

	if tostring(arg_48_0.slotType or "") ~= "" then
		local var_48_1

		if tostring(arg_48_0.slotIndex or "") == "" then
			var_48_1 = false

			goto label_48_0
		end
	end

	var_48_1 = true

	::label_48_0::

	if var_0_52(arg_48_0) == var_0_52(arg_48_1) then
		return true
	end

	if var_48_1 then
		return false
	end

	local var_48_2 = tostring(arg_48_1.itemId or "")
	local var_48_4

	if var_48_2 ~= "" then
		if tostring(arg_48_0.itemId or "") ~= var_48_2 or tostring(arg_48_0.slotType or "") ~= "" and arg_48_0.slotType ~= arg_48_1.slotType then
			var_48_4 = false

			goto label_48_1
		end
	end

	::label_48_1::

	return true
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
		if arg_51_1[iter_51_0] then
			if tostring((arg_51_0[iter_51_0] or nil) and (arg_51_0[iter_51_0][arg_51_2] or "")) ~= tostring(arg_51_1[iter_51_0][arg_51_2] or "") then
				return true
			end
		end
	end

	return false
end

local function var_0_72(arg_52_0, arg_52_1)
	if arg_52_0 == nil or arg_52_1 == nil then
		return true
	end

	local var_52_1

	if tostring(arg_52_0.bodyName or "") == tostring(arg_52_1.bodyName or "") then
		if tostring(arg_52_0.iconPath or "") == tostring(arg_52_1.iconPath or "") and arg_52_0.isUnlocked == arg_52_1.isUnlocked and arg_52_0.isSelected == arg_52_1.isSelected then
			var_52_1 = false

			goto label_52_0
		end
	end

	::label_52_0::

	return true
end

local function var_0_73(arg_53_0, arg_53_1)
	if arg_53_0 == nil or arg_53_1 == nil then
		return true
	end

	local var_53_4

	if tostring(arg_53_0.itemName or "") == tostring(arg_53_1.itemName or "") then
		if tostring(arg_53_0.iconPath or "") == tostring(arg_53_1.iconPath or "") then
			if tostring(arg_53_0.cost or "") == tostring(arg_53_1.cost or "") then
				if tostring(arg_53_0.typeText or "") == tostring(arg_53_1.typeText or "") then
					if tostring(arg_53_0.costState or "") == tostring(arg_53_1.costState or "") and arg_53_0.isUnlocked == arg_53_1.isUnlocked and arg_53_0.isSelected == arg_53_1.isSelected and arg_53_0.isEquipped == arg_53_1.isEquipped then
						var_53_4 = false

						goto label_53_0
					end
				end
			end
		end
	end

	::label_53_0::

	return true
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

	if arg_62_0.runtimeAnimatorController.animationClips == nil then
		return nil
	end

	local var_62_1 = tostring(arg_62_1 or "")
	local var_62_2 = tostring(arg_62_2 or "")
	local var_62_3 = false

	for iter_62_0 = 0, var_62_0.Length - 1 do
		if var_62_0[iter_62_0] ~= nil then
			local var_62_5 = tostring(var_62_0[iter_62_0].name or "")

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

function SummerRaceModifyView:UIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_CarModifyUI"
end

function SummerRaceModifyView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerRaceModifyView:Init()
	self:BindCfgUI()
	self:BindViewRuntime()
	self:AddUIListener()
end

function SummerRaceModifyView:BindViewRuntime()
	self.bodyItemList_ = LuaList.New(handler(self, self.IndexBodyItem), self.bodyListGo_, SummerRaceBodyItemView)
	self.weaponOptionItemList_ = LuaList.New(handler(self, self.IndexOptionItem), self.weaponListGo_, SummerRaceWeaponOptionItemView)
	self.battleInfoView_ = SummerRaceBattleInfoView.New(self.battleInfoGo_)
	self.battleInfoCanvasGroup_ = var_0_78(self.battleInfoGo_)

	var_0_83(self)
	self.battleInfoView_:SetHandlers({
		modify = handler(self, self.OpenModifyPanelFromInfo),
		rank = handler(self, self.OpenRankView),
		stageStart = handler(self, self.HandleStageBattleStart),
		challengeStart = handler(self, self.HandleChallengeBattleStart),
		enemyWave = handler(self, self.OnEnemyWaveAction),
		detailSlot = handler(self, self.OnDetailSlotAction),
		rewardClick = handler(self, self.OnRewardClick)
	})

	self.bottomTabController_ = self.controllerEx_:GetController("bottomTab")
	self.tipsController_ = self.controllerEx_:GetController("tips")
	self.areaHintController_ = self.controllerEx_:GetController("areaHint")
	self.optionMaskController_ = self.controllerEx_:GetController("optionMask")
	self.filterAllSelectControllerEx_ = self.filterAllControllerEx_
	self.filterWeaponSelectControllerEx_ = self.filterWeaponControllerEx_
	self.filterEquipSelectControllerEx_ = self.filterEquipControllerEx_

	if self.filterTabBgImage_ ~= nil then
		self.filterTabBgImage_.raycastTarget = false
	end

	if self.dropHintText_ ~= nil then
		self.dropHintText_.text = GetTips("ACTIVITY_TANK_MODIFY_CANCEL")

		SetActive(self.dropHintText_.gameObject, false)
	end

	if self.modifyAnimator_ == nil then
		Debug.LogError("[SummerRaceModifyView] missing ComponentCfger binding: modifyAnimator_")
	end

	self.weaponListRectTransform_ = self.weaponListGo_.transform:GetComponent(typeof(RectTransform))
	self.weaponScrollRect_ = self.weaponListGo_.transform:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self.propertiesItemPrefab_ = Asset.Load(var_0_22)
	self.optionDragPreviewPrefab_ = Asset.Load(var_0_21)

	if self.weaponScrollRect_ == nil then
		self.weaponScrollRect_ = self.weaponListGo_.transform:GetComponentInChildren(typeof(UnityEngine.UI.ScrollRect))
	end

	self.bodyTipsView_ = SummerRaceBodyTipsView.New(self.bodyTipsGo_)
	self.weaponTipsView_ = SummerRaceOptionTipsView.New(self.weaponTipsGo_, self.propertiesItemPrefab_)
	self.equipTipsView_ = SummerRaceOptionTipsView.New(self.equipTipsGo_, self.propertiesItemPrefab_)
	self.bodyList_ = {}
	self.optionList_ = {}
	self.modifySlotList_ = {}
	self.vehicleLayout_ = nil
	self.vehicleDisplayModel_ = nil
	self.selectedModifySlot_ = nil
	self.activeModifyTipsItemId_ = nil
	self.vehicleSlotItemViews_ = {}
	self.vehicleSlotLayerGo_ = nil
	self.vehicleSlotLayerCanvasGroup_ = nil
	self.vehicleModuleLayerCanvasGroup_ = nil
	self.vehicleSlotLayerFadeTween_ = nil
	self.vehicleSlotLayerHoldHidden_ = false
	self.vehicleSlotItemPrefab_ = Asset.Load(var_0_20)
	self.vehicleSlotSignature_ = ""
	self.dragOptionData_ = nil
	self.dragPreviewGo_ = nil
	self.dragPreviewRect_ = nil
	self.dragPreviewItemView_ = nil
	self.dragHoveredSlot_ = nil
	self.dragSlotSourceData_ = nil
	self.optionCostAvailableCost_ = nil
	self.optionGesturePressContext_ = nil
	self.optionGestureDragging_ = false
	self.weaponScrollEnabledBeforeDrag_ = nil
	self.weaponScrollPositionBeforeDrag_ = nil
	self.slotGesturePressContext_ = nil
	self.slotGestureDragging_ = false
	self.pendingEquipAnimSlotKey_ = nil
	self.equipAnimTimer_ = nil
	self.activePanelType_ = var_0_3.MODIFY
	self.returnPanelType_ = nil
	self.stageId_ = nil
	self.modifyAnimTimer_ = nil
	self.bodySwitchTransitioning_ = false
	self.pendingUnlockPopTimer_ = nil
end

function SummerRaceModifyView:OnEnter()
	var_0_76(self)
	self:ResetRouteRuntimeState()
	self:UpdateBar()

	self.outGameUpdateHandler_ = handler(self, self.RefreshView)

	manager.notify:RegistListener(SummerRaceData.GetEventOutGameUpdated(), self.outGameUpdateHandler_)
	self:ApplyEntryParams(self.params_)

	self.routeParamsSignature_ = var_0_57(self.params_)

	self:RefreshView()
	self:ApplyPanelState(true)
	self:PlayModifyBodyEnterAnim()
	self:SchedulePendingUnlockPop()
end

function SummerRaceModifyView:OnExit()
	self:HideAllTips()
	self:StopModifyAnimTimer(true)
	self:StopPendingUnlockPopTimer()
	self:StopEquipAnimTimer()
	self:ClearOptionListGestureState()
	self:ClearOptionDragState(false)
	self:ClearSlotGestureState()
	var_0_76(self)
	var_0_77(self)

	self.bodySwitchTransitioning_ = false
end

function SummerRaceModifyView:OnTop()
	self:UpdateBar()
end

function SummerRaceModifyView:UpdateBar()
	self.windowBarBackHandler_ = self.windowBarBackHandler_ or function()
		self:HandleBack()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_TANK_DESC")
	manager.windowBar:RegistBackCallBack(self.windowBarBackHandler_)
	manager.windowBar:RegistHomeCallBack(function()
		SummerRaceAction.ConfirmModify()
		self:Go("/home")
	end)
end

function SummerRaceModifyView:OnBehind()
	return
end

function SummerRaceModifyView:SchedulePendingUnlockPop()
	self:StopPendingUnlockPopTimer()

	self.pendingUnlockPopTimer_ = Timer.New(function()
		self:StopPendingUnlockPopTimer()

		if manager.guide ~= nil and manager.guide:IsPlaying() then
			self:SchedulePendingUnlockPop()

			return
		end

		SummerRaceAction.TryOpenPendingUnlockPop()
	end, 0.1, 1)

	self.pendingUnlockPopTimer_:Start()
end

function SummerRaceModifyView:StopPendingUnlockPopTimer()
	if self.pendingUnlockPopTimer_ ~= nil then
		self.pendingUnlockPopTimer_:Stop()

		self.pendingUnlockPopTimer_ = nil
	end
end

function SummerRaceModifyView:PlayModifyBodyEnterAnim()
	if self.activePanelType_ ~= var_0_3.MODIFY or self.vehicleDisplayView_ == nil then
		return
	end

	self.vehicleDisplayView_:PlayBodyAnimation(var_0_9, false, nil, var_0_10)
end

function SummerRaceModifyView:OnUpdate()
	if not self:IsTop() then
		return
	end

	self:UpdateBar()

	local var_81_0 = var_0_57(self.params_)

	if self.routeParamsSignature_ ~= var_81_0 then
		self:StopModifyAnimTimer(true)
		self:ApplyEntryParams(self.params_)

		self.routeParamsSignature_ = var_81_0

		self:ApplyPanelState(false)
	end

	self:RefreshView()
end

function SummerRaceModifyView:GetForcedEntryPanelType()
	return nil
end

function SummerRaceModifyView:ResolveEntryPanelType(arg_83_1)
	local var_83_0 = self:GetForcedEntryPanelType()

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

function SummerRaceModifyView:ApplyEntryParams(arg_84_1)
	arg_84_1 = arg_84_1 or {}

	local var_84_0 = arg_84_1.filterType or SummerRaceConst.FILTER.ALL

	self.infoSelectedSlotKey_ = nil
	self.infoVehicleSnapshot_ = nil
	self.infoVehicleDisplayModel_ = nil

	if arg_84_1.stageId ~= nil then
		SummerRaceData:SetCurrentStageId(arg_84_1.stageId, true)

		self.stageId_ = arg_84_1.stageId
	else
		self.stageId_ = nil
	end

	self.activePanelType_ = self:ResolveEntryPanelType(arg_84_1)

	if self.activePanelType_ == var_0_3.MODIFY then
		self.returnPanelType_ = nil

		SummerRaceData:ResetModifyOperateState(true)
		SummerRaceData:SetModifyFilter(var_84_0, true)
	else
		self.returnPanelType_ = nil

		if arg_84_1.filterType ~= nil then
			SummerRaceData:SetModifyFilter(arg_84_1.filterType, true)
		end
	end
end

function SummerRaceModifyView:ResetRouteRuntimeState()
	self:StopModifyAnimTimer(true)

	self.activePanelType_ = var_0_3.MODIFY
	self.returnPanelType_ = nil
	self.stageId_ = nil
	self.modifyPageModel_ = nil
	self.bodyList_ = {}
	self.optionList_ = {}
	self.modifySlotList_ = {}
	self.vehicleLayout_ = nil
	self.vehicleDisplayModel_ = nil
	self.selectedModifySlot_ = nil
	self.optionCostAvailableCost_ = nil
	self.infoSelectedSlotKey_ = nil
	self.infoVehicleSnapshot_ = nil
	self.infoVehicleDisplayModel_ = nil
	self.routeParamsSignature_ = nil
	self.bodySwitchTransitioning_ = false

	self:ClearOptionListGestureState()
	self:ClearOptionDragState(false)
	self:ClearSlotGestureState()
	self:ClearModifyVehicleDisplay()
	var_0_83(self)
end

function SummerRaceModifyView:ApplyPanelState(arg_86_1)
	if self.activePanelType_ == var_0_3.MODIFY then
		self:ShowModifyPanel(arg_86_1 == true)
	else
		self:ShowBattleInfoPanel()
	end
end

function SummerRaceModifyView:AddUIListener()
	self:AddBtnListener(self.filterAllTgl_, nil, function()
		SummerRaceAction.SelectModifyFilter("all")
		self:RefreshModifyPanel()
	end)
	self:AddBtnListener(self.filterWeaponTgl_, nil, function()
		SummerRaceAction.SelectModifyFilter("weapon")
		self:RefreshModifyPanel()
	end)
	self:AddBtnListener(self.filterEquipTgl_, nil, function()
		SummerRaceAction.SelectModifyFilter("equip")
		self:RefreshModifyPanel()
	end)
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:HideModifyTips()

		if SummerRaceAction.ConfirmModify(function(arg_92_0)
			if arg_92_0 == true then
				self:HandleBack(true)
			end
		end) then
			self:RefreshModifyPanel()
		end
	end)
	var_0_44(self, self.weaponListGo_.gameObject, handler(self, self.OnOptionListPointerDown), handler(self, self.OnOptionListDrag), handler(self, self.OnOptionListPointerUp), handler(self, self.OnOptionListEndDrag))
end

function SummerRaceModifyView:OpenRankView()
	SummerRaceAction.OpenRankView()
end

function SummerRaceModifyView:HandleBack(arg_94_1)
	if self.modifyAnimTimer_ ~= nil then
		return
	end

	if self.activePanelType_ == var_0_3.MODIFY and arg_94_1 ~= true then
		self:HideModifyTips()

		if SummerRaceAction.ConfirmModify(function(arg_95_0)
			if arg_95_0 == true then
				self:HandleBack(true)
			end
		end) then
			self:RefreshModifyPanel()
		end

		return
	end

	if self.activePanelType_ == var_0_3.MODIFY and self.returnPanelType_ ~= nil then
		self:PlayModifyExit(self.returnPanelType_)

		return
	end

	JumpTools.Back(nil, {
		returnFromModify = true,
		replayStageUIAnim = self.activePanelType_ == var_0_3.STAGE_DETAIL
	})
end

function SummerRaceModifyView:OpenModifyPanelFromInfo()
	if self.activePanelType_ == var_0_3.MODIFY or self.modifyAnimTimer_ ~= nil then
		return
	end

	self.returnPanelType_ = self.activePanelType_

	SummerRaceData:ResetModifyOperateState(true)

	self.activePanelType_ = var_0_3.MODIFY

	self:RefreshModifyPanel()
	self:ShowModifyPanel(false)
	self:PlayModifyAnim(var_0_4, nil, function()
		self:RefreshModifyPanel()
	end, true)
end

function SummerRaceModifyView:IndexBodyItem(arg_98_1, arg_98_2)
	arg_98_2:SetData(self.bodyList_[arg_98_1], arg_98_1, handler(self, self.OnBodyAction))
end

function SummerRaceModifyView:IndexOptionItem(arg_99_1, arg_99_2)
	arg_99_2:SetData(self.optionList_[arg_99_1], arg_99_1, handler(self, self.OnOptionAction))

	if self.optionCostAvailableCost_ ~= nil and arg_99_2.RefreshCostStateByAvailableCost ~= nil then
		arg_99_2:RefreshCostStateByAvailableCost(self.optionCostAvailableCost_)
	end
end

function SummerRaceModifyView:OnBodyAction(arg_100_1, arg_100_2, arg_100_3)
	if arg_100_3 == "select" then
		if tostring((self.modifyPageModel_ and self.modifyPageModel_.selectedBody or nil) and (self.modifyPageModel_.selectedBody.bodyId or nil) or "") ~= tostring(arg_100_2.bodyId or "") then
			self:HideModifyTips()
		end

		self:PlayBodySwitchTransition(arg_100_2.bodyId)
	end
end

function SummerRaceModifyView:OnOptionAction(arg_101_1, arg_101_2, arg_101_3, arg_101_4, arg_101_5)
	return
end

function SummerRaceModifyView:SetWeaponScrollEnabled(arg_102_1)
	if self.weaponScrollRect_ == nil then
		return
	end

	self.weaponScrollRect_.enabled = arg_102_1

	if arg_102_1 == false and self.weaponScrollRect_.velocity ~= nil then
		self.weaponScrollRect_.velocity = Vector2.zero
	end
end

function SummerRaceModifyView:CacheWeaponScrollPositionBeforeDrag()
	if self.weaponOptionItemList_ == nil or type(self.weaponOptionItemList_.GetScrolledPosition) ~= "function" then
		self.weaponScrollPositionBeforeDrag_ = nil

		return
	end

	self.weaponScrollPositionBeforeDrag_ = self.weaponOptionItemList_:GetScrolledPosition()
end

function SummerRaceModifyView:RestoreWeaponScrollPositionAfterDrag()
	if self.weaponScrollPositionBeforeDrag_ == nil then
		return
	end

	if self.weaponOptionItemList_ ~= nil and type(self.weaponOptionItemList_.SetScrolledPosition) == "function" then
		self.weaponOptionItemList_:SetScrolledPosition(self.weaponScrollPositionBeforeDrag_)
	end

	self.weaponScrollPositionBeforeDrag_ = nil
end

function SummerRaceModifyView:ClearOptionListGestureState()
	if self.weaponScrollEnabledBeforeDrag_ ~= nil then
		self:SetWeaponScrollEnabled(self.weaponScrollEnabledBeforeDrag_)
		self:RestoreWeaponScrollPositionAfterDrag()
	end

	self.optionGesturePressContext_ = nil
	self.optionGestureDragging_ = false
	self.weaponScrollEnabledBeforeDrag_ = nil
	self.weaponScrollPositionBeforeDrag_ = nil
end

function SummerRaceModifyView:ClearSlotGestureState()
	self.slotGesturePressContext_ = nil
	self.slotGestureDragging_ = false
end

function SummerRaceModifyView:StopEquipAnimTimer()
	if self.equipAnimTimer_ ~= nil then
		self.equipAnimTimer_:Stop()

		self.equipAnimTimer_ = nil
	end
end

function SummerRaceModifyView:MarkEquipAnimSlot(arg_108_1, arg_108_2)
	self:StopEquipAnimTimer()

	self.pendingEquipAnimSlotKey_ = var_0_53(arg_108_1, arg_108_2)
	self.equipAnimTimer_ = Timer.New(function()
		self:StopEquipAnimTimer()

		self.pendingEquipAnimSlotKey_ = nil

		self:RefreshModifyVehicleSlots()
	end, var_0_15, 1)

	self.equipAnimTimer_:Start()
end

function SummerRaceModifyView:ShouldPlayEquipAnim(arg_110_1)
	if self.pendingEquipAnimSlotKey_ == nil then
		return false
	end

	return var_0_52(arg_110_1) == self.pendingEquipAnimSlotKey_
end

function SummerRaceModifyView:RefreshVisibleOptionItemCostStates()
	if self.weaponOptionItemList_ == nil then
		return
	end

	local var_111_0 = SummerRaceData:GetCurrentBuildCostSummary()
	local var_111_1

	if var_111_0 then
		var_111_1 = var_111_0.remainingCost or 0
	end

	local var_111_2, var_111_3 = self.weaponOptionItemList_:GetHeadAndTail()

	self.optionCostAvailableCost_ = var_111_1

	if var_111_2 == 0 then
		return
	end

	for iter_111_0 = var_111_2, var_111_3 do
		local var_111_4 = self.weaponOptionItemList_:GetItemByIndex(iter_111_0)

		if var_111_4 ~= nil and var_111_4.RefreshCostStateByAvailableCost ~= nil then
			var_111_4:RefreshCostStateByAvailableCost(var_111_1)
		end
	end
end

function SummerRaceModifyView:ResolvePressedOptionContext(arg_112_1)
	local var_112_0, var_112_1 = self.weaponOptionItemList_:GetHeadAndTail()

	if var_112_0 == 0 then
		return nil
	end

	for iter_112_0 = var_112_0, var_112_1 do
		local var_112_2 = self.weaponOptionItemList_:GetItemByIndex(iter_112_0)

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

function SummerRaceModifyView:ShouldStartListOptionDrag(arg_113_1)
	if self.optionGesturePressContext_ == nil or self.optionGestureDragging_ == true or self.weaponListRectTransform_ == nil or arg_113_1 == nil then
		return false
	end

	if math.abs((arg_113_1.y or 0) - (self.optionGesturePressContext_.pressScreenPos.y or 0)) < var_0_23 then
		return false
	end

	return var_0_42(self.weaponListRectTransform_, arg_113_1)
end

function SummerRaceModifyView:HandleOptionListTap(arg_114_1)
	if arg_114_1 == nil or arg_114_1.optionData == nil then
		return
	end

	local var_114_0 = var_0_66(arg_114_1.optionData)

	if var_114_0 ~= nil and var_114_0 == self.activeModifyTipsItemId_ then
		return
	end

	if arg_114_1.optionData.isUnlocked == true then
		SummerRaceData:MarkOptionNewRedPointRead(arg_114_1.optionData.itemId, true)
	end

	if SummerRaceAction.PreviewOption(arg_114_1.optionData.itemId, true) then
		self.activeModifyTipsItemId_ = var_114_0
	end
end

function SummerRaceModifyView:OnOptionListPointerDown(arg_115_1)
	if self.activePanelType_ ~= var_0_3.MODIFY or arg_115_1 == nil then
		self:ClearOptionListGestureState()

		return
	end

	self:ClearOptionListGestureState()

	self.optionGesturePressContext_ = self:ResolvePressedOptionContext(arg_115_1.position)

	if self.optionGesturePressContext_ ~= nil then
		local var_115_0 = var_0_66(self.optionGesturePressContext_.optionData)

		if var_115_0 == nil or var_115_0 ~= self.activeModifyTipsItemId_ then
			self:HideModifyTips()
		end
	end
end

function SummerRaceModifyView:OnOptionListDrag(arg_116_1)
	if self.optionGesturePressContext_ == nil or arg_116_1 == nil then
		return
	end

	if self.optionGestureDragging_ ~= true then
		if not self:ShouldStartListOptionDrag(arg_116_1.position) then
			return
		end

		self.optionGestureDragging_ = true

		if self.weaponScrollRect_ == nil then
			-- block empty
		end

		self.weaponScrollEnabledBeforeDrag_ = self.weaponScrollRect_.enabled

		self:CacheWeaponScrollPositionBeforeDrag()
		self:SetWeaponScrollEnabled(false)
		self:BeginOptionDrag(self.optionGesturePressContext_.optionData, {
			position = arg_116_1.position
		}, self.optionGesturePressContext_.sourceGo)

		if self.dragOptionData_ == nil then
			self:ClearOptionListGestureState()

			return
		end

		return
	end

	self:UpdateOptionDrag(self.optionGesturePressContext_.optionData, {
		position = arg_116_1.position
	})
end

function SummerRaceModifyView:OnOptionListEndDrag(arg_117_1)
	local var_117_0 = self.optionGestureDragging_ == true

	if self.optionGesturePressContext_ == nil then
		self:ClearOptionListGestureState()

		return
	end

	if not var_117_0 then
		return
	end

	local var_117_1 = {}

	if arg_117_1 then
		var_117_1.position = arg_117_1.position or self.optionGesturePressContext_.pressScreenPos
	end

	self:EndOptionDrag(self.optionGesturePressContext_.optionData, var_117_1)
	self:ClearOptionListGestureState()
end

function SummerRaceModifyView:OnOptionListPointerUp(arg_118_1)
	if self.optionGesturePressContext_ == nil then
		self:ClearOptionListGestureState()

		return
	end

	if self.optionGestureDragging_ == true then
		return
	end

	if arg_118_1 then
		local var_118_0 = arg_118_1.position or self.optionGesturePressContext_.pressScreenPos

		if var_0_47(self.optionGesturePressContext_.pressScreenPos, var_118_0, var_0_24) and var_0_37(self.weaponListRectTransform_, var_118_0) then
			self:HandleOptionListTap(self.optionGesturePressContext_)
		end
	end

	self:ClearOptionListGestureState()
end

function SummerRaceModifyView:ResolveHoveredSlotByScreenPosition(arg_119_1)
	local var_119_0
	local var_119_1

	for iter_119_0 = 1, #self.modifySlotList_ do
		if self.vehicleSlotItemViews_[iter_119_0] ~= nil then
			local var_119_2 = var_0_38(var_0_39(self.vehicleSlotItemViews_[iter_119_0]), arg_119_1)

			if var_119_2 ~= nil and (var_119_1 == nil or var_119_2 < var_119_1) then
				var_119_0 = self.modifySlotList_[iter_119_0]
				var_119_1 = var_119_2
			end
		end
	end

	return var_119_0, nil
end

function SummerRaceModifyView:CanDropOptionOnSlot(arg_120_1, arg_120_2)
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

function SummerRaceModifyView:CanTryDropOptionOnSlot(arg_121_1, arg_121_2)
	if arg_121_1 == nil or arg_121_2 == nil then
		return false
	end

	if arg_121_2.isLocked == true then
		return false
	end

	return arg_121_2.slotType == arg_121_1.typeText
end

function SummerRaceModifyView:CanDropEquippedSlotOnSlot(arg_122_1, arg_122_2)
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

function SummerRaceModifyView:RefreshDragSlotStates(arg_123_1)
	if self.dragOptionData_ == nil then
		self:SetModuleReplaceSlotData(nil)
		self:RefreshModifyVehicleSlots()

		return
	end

	local var_123_0 = self:ResolveHoveredSlotByScreenPosition(arg_123_1)
	local var_123_1 = self:CanDropOptionOnSlot(self.dragOptionData_, var_123_0)

	self.dragHoveredSlot_ = var_123_0

	self:SetModuleReplaceSlotData((var_123_1 == true and var_0_65(var_123_0) or nil) and var_123_0)

	for iter_123_0 = 1, #self.modifySlotList_ do
		if self.vehicleSlotItemViews_[iter_123_0] ~= nil then
			SetActive(self.vehicleSlotItemViews_[iter_123_0].gameObject_, true)
			self.vehicleSlotItemViews_[iter_123_0]:SetData(var_0_70(self.modifySlotList_[iter_123_0], self.dragOptionData_, var_123_0, var_123_1), iter_123_0, handler(self, self.OnDetailSlotAction))
		end
	end
end

function SummerRaceModifyView:SetVehicleSlotDragOptionData(arg_124_1)
	for iter_124_0 = 1, #(self.vehicleSlotItemViews_ or {}) do
		if self.vehicleSlotItemViews_[iter_124_0] ~= nil and type(self.vehicleSlotItemViews_[iter_124_0].SetDragOptionData) == "function" then
			self.vehicleSlotItemViews_[iter_124_0]:SetDragOptionData(arg_124_1)
		end
	end
end

function SummerRaceModifyView:SetModuleReplaceSlotData(arg_125_1)
	if self.vehicleDisplayView_ ~= nil and type(self.vehicleDisplayView_.SetModuleReplaceSlotData) == "function" then
		self.vehicleDisplayView_:SetModuleReplaceSlotData(arg_125_1)
	end
end

function SummerRaceModifyView:ClearDragPreview()
	if self.dragPreviewItemView_ ~= nil then
		self.dragPreviewItemView_:Dispose()

		self.dragPreviewItemView_ = nil
	end

	if self.dragPreviewGo_ ~= nil then
		Object.Destroy(self.dragPreviewGo_)

		self.dragPreviewGo_ = nil
		self.dragPreviewRect_ = nil
	end
end

function SummerRaceModifyView:UpdateDragPreview(arg_127_1)
	if self.dragPreviewRect_ == nil then
		return
	end

	local var_127_0 = var_0_36(self.transform_, arg_127_1)

	if var_127_0 ~= nil then
		self.dragPreviewRect_.anchoredPosition = var_127_0
	end
end

function SummerRaceModifyView:CreateDragPreview(arg_128_1, arg_128_2, arg_128_3)
	self:ClearDragPreview()

	local var_128_0 = false

	if arg_128_1 ~= nil then
		if tostring(arg_128_1.skeletonDataPath or "") ~= "" then
			self.dragPreviewGo_ = var_0_43(arg_128_1, self.transform_)
			var_128_0 = true

			goto label_128_0
		end
	end

	if arg_128_1 ~= nil and self.optionDragPreviewPrefab_ ~= nil then
		self.dragPreviewGo_ = Object.Instantiate(self.optionDragPreviewPrefab_, self.transform_)
		self.dragPreviewItemView_ = SummerRaceWeaponOptionItemView.New(self.dragPreviewGo_)

		self.dragPreviewItemView_:SetData(arg_128_1, -1, nil)
	elseif arg_128_3 ~= nil then
		self.dragPreviewGo_ = Object.Instantiate(arg_128_3, self.transform_)
	else
		return
	end

	::label_128_0::

	self.dragPreviewRect_ = self.dragPreviewGo_:GetComponent(typeof(RectTransform))

	local var_128_2 = self.dragPreviewGo_:GetComponent(typeof(CanvasGroup))

	if var_128_2 == nil then
		var_128_2 = self.dragPreviewGo_:AddComponent(typeof(CanvasGroup))
	end

	var_128_2.blocksRaycasts = false
	var_128_2.interactable = false

	if self.dragPreviewRect_ ~= nil then
		self.dragPreviewRect_:SetParent(self.transform_, false)

		self.dragPreviewRect_.anchorMin = Vector2.New(0.5, 0.5)
		self.dragPreviewRect_.anchorMax = Vector2.New(0.5, 0.5)
		self.dragPreviewRect_.pivot = Vector2.New(0.5, 0.5)

		if var_128_0 ~= true then
			self.dragPreviewRect_.localScale = Vector3.one
		end
	end

	self.dragPreviewGo_.transform:SetAsLastSibling()
	self:UpdateDragPreview(arg_128_2)
end

function SummerRaceModifyView:ClearOptionDragState(arg_129_1)
	self:SetVehicleSlotDragOptionData(nil)
	self:SetModuleReplaceSlotData(nil)

	self.dragOptionData_ = nil
	self.dragHoveredSlot_ = nil
	self.dragSlotSourceData_ = nil

	if self.vehicleDisplayView_ ~= nil and type(self.vehicleDisplayView_.SetModuleDragSourceSlotData) == "function" then
		self.vehicleDisplayView_:SetModuleDragSourceSlotData(nil)
	end

	self:ClearDragPreview()
	self:SetDropAreaHintState(var_0_28.NONE)

	if arg_129_1 == true and self.activePanelType_ == var_0_3.MODIFY then
		self:RefreshModifyVehicleSlots()
	end
end

function SummerRaceModifyView:SetDropAreaHintState(arg_130_1)
	local var_130_0 = var_0_28.NONE

	if self.activePanelType_ == var_0_3.MODIFY then
		if arg_130_1 == var_0_28.MOVE_IN then
			var_130_0 = var_0_28.MOVE_IN
		elseif arg_130_1 == var_0_28.NORMAL or arg_130_1 == true then
			var_130_0 = var_0_28.NORMAL
		end
	end

	if self.areaHintController_ ~= nil then
		self.areaHintController_:SetSelectedState(var_130_0)
	end

	if self.dropHintText_ ~= nil then
		SetActive(self.dropHintText_.gameObject, var_130_0 ~= var_0_28.NONE)
	end
end

function SummerRaceModifyView:RefreshEquippedSlotDropAreaState(arg_131_1)
	self:SetDropAreaHintState((var_0_37(self.weaponListRectTransform_, arg_131_1) or nil) and (var_0_28.NORMAL or var_0_28.MOVE_IN))
end

function SummerRaceModifyView:BeginOptionDrag(arg_132_1, arg_132_2, arg_132_3)
	if self.activePanelType_ ~= var_0_3.MODIFY or arg_132_1 == nil then
		return
	end

	if arg_132_1.isUnlocked ~= true then
		ShowTips("ACTIVITY_TANK_WEAPON_LOCK")

		return
	end

	SummerRaceData:MarkOptionNewRedPointRead(arg_132_1.itemId, true)

	self.dragOptionData_ = arg_132_1
	self.dragHoveredSlot_ = nil

	self:SetDropAreaHintState(var_0_28.NONE)
	self:CreateDragPreview(arg_132_1, (arg_132_2 or nil) and (arg_132_2.position or nil), arg_132_3)
	self:SetVehicleSlotDragOptionData(arg_132_1)
	self:RefreshDragSlotStates((arg_132_2 or nil) and (arg_132_2.position or nil))
end

function SummerRaceModifyView:UpdateOptionDrag(arg_133_1, arg_133_2)
	if self.dragOptionData_ == nil or arg_133_1 == nil or self.dragOptionData_.itemId ~= arg_133_1.itemId then
		return
	end

	local var_133_0

	if arg_133_2 then
		var_133_0 = arg_133_2.position or nil
	end

	self:UpdateDragPreview(var_133_0)
	self:RefreshDragSlotStates(var_133_0)
end

function SummerRaceModifyView:EndOptionDrag(arg_134_1, arg_134_2)
	if self.dragOptionData_ == nil or arg_134_1 == nil or self.dragOptionData_.itemId ~= arg_134_1.itemId then
		return
	end

	local var_134_0 = self:ResolveHoveredSlotByScreenPosition((arg_134_2 or nil) and (arg_134_2.position or nil))

	self:ClearOptionDragState(false)

	if not self:CanTryDropOptionOnSlot(arg_134_1, var_134_0) then
		self:RefreshModifyVehicleSlots()

		return
	end

	if SummerRaceAction.AssignDraggedOptionToSlot(arg_134_1.itemId, var_134_0.slotType, var_134_0.slotIndex) then
		var_0_31()
		self:MarkEquipAnimSlot(var_134_0.slotType, var_134_0.slotIndex)
		self:RefreshModifyPanel()
	else
		self:RefreshModifyVehicleSlots()
	end
end

function SummerRaceModifyView:ResolveSlotDragOptionData(arg_135_1)
	if arg_135_1 == nil or arg_135_1.itemId == nil or tostring(arg_135_1.itemId) == "" then
		return nil
	end

	return SummerRaceData:GetOptionDefById(arg_135_1.itemId)
end

function SummerRaceModifyView:ShouldStartSlotDrag(arg_136_1)
	if self.slotGesturePressContext_ == nil or self.slotGestureDragging_ == true then
		return false
	end

	local var_136_0, var_136_1 = var_0_46(self.slotGesturePressContext_.pressScreenPos, arg_136_1)

	return var_136_0 > var_0_25 or var_136_1 > var_0_25
end

function SummerRaceModifyView:RefreshEquippedSlotDragStates(arg_137_1)
	for iter_137_0 = 1, #self.modifySlotList_ do
		local var_137_0 = self.vehicleSlotItemViews_[iter_137_0]

		if self.vehicleSlotItemViews_[iter_137_0] ~= nil then
			local var_137_1 = var_0_63(self.modifySlotList_[iter_137_0])
			local var_137_2 = self.dragSlotSourceData_ ~= nil and self.dragSlotSourceData_.slotType == var_137_1.slotType and tonumber(self.dragSlotSourceData_.slotIndex) == tonumber(var_137_1.slotIndex)
			local var_137_3 = self:CanDropEquippedSlotOnSlot(self.dragSlotSourceData_, var_137_1)

			SetActive(var_137_0.gameObject_, true)

			if var_137_2 then
				var_137_1.slotState = "dragging"
				var_137_1.isSelected = true
			elseif var_137_3 then
				var_137_1.slotState = "dragging"
			end

			var_137_0:SetData(var_137_1, iter_137_0, handler(self, self.OnDetailSlotAction))
		end
	end
end

function SummerRaceModifyView:BeginEquippedSlotDrag(arg_138_1, arg_138_2, arg_138_3)
	local var_138_0 = self:ResolveSlotDragOptionData(arg_138_1)

	if self.activePanelType_ ~= var_0_3.MODIFY or var_138_0 == nil then
		return
	end

	self.dragSlotSourceData_ = var_0_63(arg_138_1)

	self:CreateDragPreview(var_138_0, (arg_138_2 or nil) and (arg_138_2.position or nil), arg_138_3)
	self:UpdateDragPreview((arg_138_2 or nil) and (arg_138_2.position or nil))
	self:SetVehicleSlotDragOptionData(var_138_0)
	self:RefreshEquippedSlotDropAreaState((arg_138_2 or nil) and (arg_138_2.position or nil))
	self:RefreshEquippedSlotDragStates((arg_138_2 or nil) and (arg_138_2.position or nil))
	self:RefreshModifyVehicleDisplay()
end

function SummerRaceModifyView:UpdateEquippedSlotDrag(arg_139_1, arg_139_2)
	if self.dragSlotSourceData_ == nil or arg_139_1 == nil then
		do return end

		local var_139_0

		if arg_139_2 then
			var_139_0 = arg_139_2.position or nil
		end
	end

	self:UpdateDragPreview(var_139_0)
	self:RefreshEquippedSlotDropAreaState((arg_139_2 or nil) and (arg_139_2.position or nil))
	self:RefreshEquippedSlotDragStates((arg_139_2 or nil) and (arg_139_2.position or nil))
end

function SummerRaceModifyView:EndEquippedSlotDrag(arg_140_1, arg_140_2)
	if self.dragSlotSourceData_ == nil or arg_140_1 == nil then
		return
	end

	local var_140_0

	if arg_140_2 then
		var_140_0 = arg_140_2.position

		if not arg_140_2.position then
			if self.slotGesturePressContext_ then
				var_140_0 = self.slotGesturePressContext_.pressScreenPos or nil
			end
		end
	end

	local var_140_1 = self:ResolveHoveredSlotByScreenPosition(var_140_0)

	self:ClearOptionDragState(false)
	self:RefreshModifyVehicleSlots()
	self:RefreshModifyVehicleDisplay()

	if self:CanDropEquippedSlotOnSlot(arg_140_1, var_140_1) and var_140_1 ~= nil then
		if SummerRaceAction.MoveEquippedSlotToSlot(arg_140_1.slotType, arg_140_1.slotIndex, var_140_1.slotType, var_140_1.slotIndex, arg_140_1.itemId) then
			var_0_31()
			self:MarkEquipAnimSlot(var_140_1.slotType, var_140_1.slotIndex)
			self:RefreshModifyPanel()
		end

		return
	end

	if not var_0_37(self.weaponListRectTransform_, var_140_0) then
		return
	end

	if SummerRaceAction.MoveEquippedSlotBackToList(arg_140_1.slotType, arg_140_1.slotIndex, arg_140_1.itemId) then
		var_0_32()
		self:RefreshModifyPanel()
	end
end

function SummerRaceModifyView:OnModifySlotPointerDown(arg_141_1, arg_141_2, arg_141_3)
	self:ClearSlotGestureState()

	local var_141_0 = self.modifySlotList_[arg_141_1]
	local var_141_1

	if arg_141_2 then
		var_141_1 = arg_141_2.position or nil

		if var_141_0 ~= nil then
			self:HideModifyTips()
		end

		if self.activePanelType_ ~= var_0_3.MODIFY then
			if var_141_0 ~= nil then
				self.slotGesturePressContext_ = {
					slotIndex = arg_141_1,
					slotData = var_0_63(var_141_0),
					pressScreenPos = var_141_1,
					sourceGo = arg_141_3
				}
			end

			return
		end
	end

	local var_141_2, var_141_3 = self:ResolveHoveredSlotByScreenPosition(var_141_1)

	if var_141_2 ~= nil and var_141_3 ~= nil then
		arg_141_1 = var_141_3
		var_141_0 = var_141_2

		if self.vehicleSlotItemViews_[var_141_3] ~= nil and self.vehicleSlotItemViews_[var_141_3].gameObject_ ~= nil then
			arg_141_3 = self.vehicleSlotItemViews_[var_141_3].gameObject_
		end
	end

	if var_141_0 == nil or var_141_0.isLocked == true or var_141_0.itemId == nil or tostring(var_141_0.itemId) == "" then
		return
	end

	self.slotGesturePressContext_ = {
		slotIndex = arg_141_1,
		slotData = var_0_63(var_141_0),
		pressScreenPos = var_141_1,
		sourceGo = arg_141_3
	}
end

function SummerRaceModifyView:OnModifySlotDrag(arg_142_1, arg_142_2)
	if self.activePanelType_ ~= var_0_3.MODIFY then
		return
	end

	local var_142_0 = self.slotGesturePressContext_

	if self.slotGesturePressContext_ == nil then
		return
	end

	if self.slotGestureDragging_ ~= true then
		if arg_142_2 then
			if not self:ShouldStartSlotDrag(arg_142_2.position or nil) then
				return
			end
		end

		self.slotGestureDragging_ = true

		self:BeginEquippedSlotDrag(var_142_0.slotData, arg_142_2, var_142_0.sourceGo)

		return
	end

	self:UpdateEquippedSlotDrag(var_142_0.slotData, arg_142_2)
end

function SummerRaceModifyView:OnModifySlotPointerUp(arg_143_1, arg_143_2)
	if self.slotGesturePressContext_ == nil then
		self:ClearSlotGestureState()

		return
	end

	if self.slotGestureDragging_ == true then
		self:EndEquippedSlotDrag(self.slotGesturePressContext_.slotData, arg_143_2)
		self:ClearSlotGestureState()

		return
	end

	if arg_143_2 then
		if var_0_47(self.slotGesturePressContext_.pressScreenPos, arg_143_2.position or self.slotGesturePressContext_.pressScreenPos, var_0_24) then
			self:HandleModifySlotAction(self.slotGesturePressContext_.slotData)
		end
	end

	self:ClearSlotGestureState()
end

function SummerRaceModifyView:OnModifySlotEndDrag(arg_144_1, arg_144_2)
	if self.slotGesturePressContext_ == nil then
		self:ClearSlotGestureState()

		return
	end

	if not self.slotGestureDragging_ then
		return
	end

	self:EndEquippedSlotDrag(self.slotGesturePressContext_.slotData, arg_144_2)
	self:ClearSlotGestureState()
end

function SummerRaceModifyView:RefreshBodyInfoPanel()
	local var_145_0 = var_0_51((self.modifyPageModel_ or nil) and (self.modifyPageModel_.selectedBody or nil))

	if var_145_0 == nil or self.bodyTipsView_ == nil then
		return
	end

	self.bodyTipsView_:SetData(var_145_0)
end

function SummerRaceModifyView:RefreshOptionInfoPanel(arg_146_1, arg_146_2)
	if arg_146_1 == nil or arg_146_2 == nil then
		return
	end

	arg_146_1:SetData(arg_146_2)
end

function SummerRaceModifyView:RefreshModifyInfoPanel()
	local var_147_0

	if self.modifyPageModel_ then
		var_147_0 = self.modifyPageModel_.infoTargetType or "body"

		local var_147_1

		if self.modifyPageModel_ then
			var_147_1 = self.modifyPageModel_.selectedOption or nil
		end
	end

	local var_147_2 = var_0_50(var_147_1)
	local var_147_3 = not (var_147_0 == "option" and var_147_2 ~= nil) and self.modifyPageModel_.selectedBody ~= nil

	if var_147_0 == "option" and var_147_2 ~= nil then
		local var_147_4 = var_0_66(var_147_1)

		self.activeModifyTipsItemId_ = var_147_4

		if var_147_2.panelType == "equip" then
			self:SetModifyTipsState("tips_m", var_147_4)
			self:RefreshOptionInfoPanel(self.equipTipsView_, var_147_2)
		else
			self:SetModifyTipsState("tips_l", var_147_4)
			self:RefreshOptionInfoPanel(self.weaponTipsView_, var_147_2)
		end

		return
	end

	self.activeModifyTipsItemId_ = nil

	if var_147_3 then
		self:SetModifyTipsState("tips_s", self.modifyPageModel_.selectedBody.bodyId)
		self:RefreshBodyInfoPanel()

		return
	end

	self:SetModifyTipsState("tips_s")
end

function SummerRaceModifyView:ResolveInfoSelectedSlot()
	local var_148_0 = var_0_55(self.modifySlotList_, self.infoSelectedSlotKey_)

	if var_148_0 ~= nil then
		return var_148_0
	end

	local var_148_1 = var_0_54(self.modifySlotList_)

	self.infoSelectedSlotKey_ = var_0_52(var_148_1)

	return var_148_1
end

function SummerRaceModifyView:RefreshInfoVehicleTips()
	local var_149_0 = self:ResolveInfoSelectedSlot()
	local var_149_1

	if var_149_0 ~= nil and var_149_0.itemId ~= nil and tostring(var_149_0.itemId) ~= "" then
		var_149_1 = var_0_50(SummerRaceData:GetOptionDefById(var_149_0.itemId))
	end

	if var_149_1 ~= nil then
		if var_149_1.panelType == "equip" then
			self.tipsController_:SetSelectedState("tips_m")
			self:RefreshOptionInfoPanel(self.equipTipsView_, var_149_1)
		else
			self.tipsController_:SetSelectedState("tips_l")
			self:RefreshOptionInfoPanel(self.weaponTipsView_, var_149_1)
		end

		return
	end

	self.tipsController_:SetSelectedState("tips_s")
	self.bodyTipsView_:SetData(var_0_51(self.infoVehicleSnapshot_))
end

function SummerRaceModifyView:ApplyInfoVehiclePanel(arg_150_1, arg_150_2)
	self.infoVehicleSnapshot_ = arg_150_1 or {}
	self.infoVehicleDisplayModel_ = arg_150_2
	self.vehicleDisplayModel_ = arg_150_2
	self.modifySlotList_ = var_0_64(self.infoVehicleSnapshot_.slotSummary or {})

	local var_150_0 = var_0_52((self:ResolveInfoSelectedSlot()))

	for iter_150_0 = 1, #self.modifySlotList_ do
		local var_150_1 = self.modifySlotList_[iter_150_0]

		var_150_1.interactionMode = "inspect"
		var_150_1.itemClickEnabled = true
		var_150_1.showEquippedIcon = true
		var_150_1.isSelected = var_150_0 ~= "" and var_0_52(var_150_1) == var_150_0
	end

	local var_150_2 = self.infoVehicleSnapshot_.costSummary or {}
	local var_150_3 = tonumber(self.infoVehicleSnapshot_.totalCost) or tonumber(var_150_2.totalCost) or 0
	local var_150_4 = tonumber(var_150_2.budgetCost) or tonumber(self.infoVehicleSnapshot_.cost) or 0

	self.bodyHpText_.text = tostring(self.infoVehicleSnapshot_.hp or "")
	self.costText_.text = string.format("%s/%s", tostring(var_150_3), tostring(var_150_4))

	self:RefreshInfoVehicleTips()
	self:RefreshModifyVehicleDisplay()
end

function SummerRaceModifyView:RefreshChangedBodyItems(arg_151_1)
	for iter_151_0 = 1, #self.bodyList_ do
		if var_0_72(arg_151_1[iter_151_0], self.bodyList_[iter_151_0]) then
			local var_151_0 = self.bodyItemList_:GetItemByIndex(iter_151_0)

			if var_151_0 ~= nil then
				var_151_0:SetData(self.bodyList_[iter_151_0], iter_151_0, handler(self, self.OnBodyAction))
			end
		end
	end
end

function SummerRaceModifyView:RefreshChangedOptionItems(arg_152_1)
	for iter_152_0 = 1, #self.optionList_ do
		if var_0_73(arg_152_1[iter_152_0], self.optionList_[iter_152_0]) then
			local var_152_0 = self.weaponOptionItemList_:GetItemByIndex(iter_152_0)

			if var_152_0 ~= nil then
				var_152_0:SetData(self.optionList_[iter_152_0], iter_152_0, handler(self, self.OnOptionAction))
			end
		end
	end
end

function SummerRaceModifyView:OnEnemyWaveAction(arg_153_1, arg_153_2, arg_153_3)
	if arg_153_3 == "battleInfo" then
		local var_153_0 = tonumber(arg_153_2 and arg_153_2.waveIndex) or arg_153_1
		local var_153_1 = {
			source = "stageDetail",
			stageId = self.stageId_,
			waveIndex = var_153_0
		}

		if arg_153_2 then
			var_153_1.enemyId = arg_153_2.enemyId or nil
		end

		SummerRaceAction.OpenInfoPop(var_153_1)
	end
end

function SummerRaceModifyView:OnDetailSlotAction(arg_154_1, arg_154_2, arg_154_3)
	if arg_154_3 ~= "select" then
		return
	end

	if self.activePanelType_ ~= var_0_3.MODIFY then
		self:HandleInfoSlotAction(arg_154_2)

		return
	end

	self:HandleModifySlotAction(arg_154_2)
end

function SummerRaceModifyView:OnRewardClick(arg_155_1)
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

function SummerRaceModifyView:HandleInfoSlotAction(arg_156_1)
	if arg_156_1 == nil then
		return
	end

	if arg_156_1.itemId == nil or tostring(arg_156_1.itemId) == "" then
		self.infoSelectedSlotKey_ = nil
	else
		self.infoSelectedSlotKey_ = var_0_52(arg_156_1)
	end

	self:ApplyInfoVehiclePanel(self.infoVehicleSnapshot_, self.infoVehicleDisplayModel_)
end

function SummerRaceModifyView:HandleModifySlotAction(arg_157_1)
	if self.activePanelType_ ~= var_0_3.MODIFY then
		self:HandleInfoSlotAction(arg_157_1)

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

	if self.selectedModifySlot_ ~= nil and self.selectedModifySlot_.slotType == arg_157_1.slotType and tonumber(self.selectedModifySlot_.slotIndex) == tonumber(arg_157_1.slotIndex) then
		SummerRaceAction.ClearModifySlotSelection()

		return
	end

	SummerRaceAction.SelectModifySlot(arg_157_1.slotType, arg_157_1.slotIndex)
end

function SummerRaceModifyView:HideModifyTips()
	if self.tipsController_ ~= nil then
		self.tipsController_:SetSelectedState("none")
	end

	self.activeModifyTipsItemId_ = nil
	self.activeModifyTipsSignature_ = nil
end

function SummerRaceModifyView:SetModifyTipsState(arg_159_1, arg_159_2)
	local var_159_0 = var_0_58(arg_159_1, arg_159_2)

	if self.activeModifyTipsSignature_ == var_159_0 then
		return
	end

	if self.tipsController_ ~= nil then
		self.tipsController_:SetSelectedState(arg_159_1)
	end

	self.activeModifyTipsSignature_ = var_159_0
end

function SummerRaceModifyView:HideAllTips()
	self:HideModifyTips()

	if self.battleInfoView_ ~= nil and type(self.battleInfoView_.HideTips) == "function" then
		self.battleInfoView_:HideTips(true)
	end
end

function SummerRaceModifyView:RefreshModifyPanel()
	if self.bodySwitchTransitioning_ == true then
		return
	end

	local var_161_0 = self.bodyList_ or {}
	local var_161_1 = self.optionList_ or {}

	self.modifyPageModel_ = SummerRaceData:GetModifyPageModel()
	self.bodyList_ = self.modifyPageModel_.bodyList or {}
	self.optionList_ = self.modifyPageModel_.weaponOptionList or {}
	self.modifySlotList_ = self.modifyPageModel_.slotList or {}
	self.vehicleLayout_ = self.modifyPageModel_.vehicleLayout
	self.vehicleDisplayModel_ = self.modifyPageModel_.vehicleDisplay
	self.selectedModifySlot_ = self.modifyPageModel_.selectedSlot

	if self.modifyPageModel_.costSummary then
		self.optionCostAvailableCost_ = self.modifyPageModel_.costSummary.remainingCost or 0
	end

	self.bodyHpText_.text = tostring(self.modifyPageModel_.selectedBody.hp or "")

	self:RefreshModifyInfoPanel()

	self.costText_.text = string.format("%s/%s", self.modifyPageModel_.costSummary.totalCost, self.modifyPageModel_.costSummary.budgetCost)
	self.confirmBtn_.interactable = self.modifyPageModel_.costSummary.isOverflow ~= true

	local var_161_2 = var_0_29(self.modifyPageModel_.filterType)

	self.bottomTabController_:SetSelectedState(var_161_2)
	var_0_30(self.filterAllSelectControllerEx_, var_161_2 == "all")
	var_0_30(self.filterWeaponSelectControllerEx_, var_161_2 == "weapon")
	var_0_30(self.filterEquipSelectControllerEx_, var_161_2 == "parts")
	self.optionMaskController_:SetSelectedState(self.modifyPageModel_.optionListLocked and "show" or "hide")

	if var_0_71(var_161_0, self.bodyList_, "bodyId") then
		self.bodyItemList_:StartScroll(#self.bodyList_)
	else
		self:RefreshChangedBodyItems(var_161_0)
	end

	if var_0_71(var_161_1, self.optionList_, "itemId") then
		self.weaponOptionItemList_:StartScroll(#self.optionList_)
	else
		self:RefreshChangedOptionItems(var_161_1)
	end

	self:RefreshVisibleOptionItemCostStates()
	self:RefreshModifyVehicleDisplay()
end

function SummerRaceModifyView:FinishBodySwitchTransition()
	self.bodySwitchTransitioning_ = false

	self:RefreshModifyPanel()

	local function var_162_0()
		self:FadeInModifyVehicleSlotLayer()
	end

	if self.vehicleDisplayView_ ~= nil and self.vehicleDisplayView_:PlayBodyAnimation(var_0_11, false) == true then
		var_162_0()

		return
	end

	var_162_0()
end

function SummerRaceModifyView:PlayBodySwitchTransition(arg_164_1)
	if self.bodySwitchTransitioning_ == true then
		return
	end

	local var_164_0 = tostring(arg_164_1 or "")

	if self.modifyPageModel_ and self.modifyPageModel_.selectedBody then
		if var_164_0 ~= "" and tostring(self.modifyPageModel_.selectedBody.bodyId or nil or "") == var_164_0 then
			SummerRaceData:MarkBodyNewRedPointRead(arg_164_1, true)

			return
		end

		if SummerRaceData:CanSelectBody(arg_164_1) ~= true then
			SummerRaceAction.SelectBody(arg_164_1)

			return
		end
	end

	self.bodySwitchTransitioning_ = true

	self:HideModifyVehicleSlotLayerForBodySwitch()

	local function var_164_2()
		if SummerRaceAction.SelectBody(arg_164_1) then
			SummerRaceData:MarkBodyNewRedPointRead(arg_164_1, true)
			self:FinishBodySwitchTransition()
		else
			self.bodySwitchTransitioning_ = false

			self:ShowModifyVehicleSlotLayerImmediate()
		end
	end

	if self.vehicleDisplayView_ == nil then
		var_164_2()

		return
	end

	if self.vehicleDisplayView_:PlayBodyAnimation(var_0_12, false, var_164_2) ~= true then
		var_164_2()
	end
end

function SummerRaceModifyView:BuildStageDetailPanelModel()
	return SummerRaceData:GetStageDetailModel(self.stageId_)
end

function SummerRaceModifyView:BuildInfoPanelModel()
	if self.activePanelType_ == var_0_3.CHALLENGE then
		return self:BuildChallengePanelModel()
	end

	return self:BuildStageDetailPanelModel()
end

function SummerRaceModifyView:BuildChallengePanelModel()
	return SummerRaceData:GetChallengePageModel()
end

function SummerRaceModifyView:ApplyStageDetailPanelModel(arg_169_1)
	self.stageId_ = arg_169_1.stageInfo.stageId

	self.battleInfoView_:ApplyStageDetailModel(arg_169_1)
	self:ApplyInfoVehiclePanel(arg_169_1.vehicleSnapshot, arg_169_1.vehicleDisplay)
end

function SummerRaceModifyView:ApplyInfoPanelModel(arg_170_1)
	if self.activePanelType_ == var_0_3.CHALLENGE then
		self:ApplyChallengePanelModel(arg_170_1)

		return
	end

	self:ApplyStageDetailPanelModel(arg_170_1)
end

function SummerRaceModifyView:ApplyChallengePanelModel(arg_171_1)
	if arg_171_1.stageInfo ~= nil then
		self.stageId_ = arg_171_1.stageInfo.stageId
	end

	self.battleInfoView_:ApplyChallengeModel(arg_171_1)
	self:ApplyInfoVehiclePanel(arg_171_1.currentBuild, arg_171_1.vehicleDisplay)
end

function SummerRaceModifyView:RefreshChallengePanel()
	self:ApplyChallengePanelModel(self:BuildChallengePanelModel())
end

function SummerRaceModifyView:HandleStageBattleStart()
	local var_173_0 = self:BuildStageDetailPanelModel()

	if var_173_0 ~= nil and var_173_0.stageInfo ~= nil then
		self.stageId_ = var_173_0.stageInfo.stageId
	end

	SummerRaceAction.EnterStageBattle(self.stageId_, var_0_3.STAGE_DETAIL)
end

function SummerRaceModifyView:HandleChallengeBattleStart()
	SummerRaceAction.EnterChallengeBattle(var_0_3.CHALLENGE)
end

function SummerRaceModifyView:RefreshInfoPanel()
	self:ApplyInfoPanelModel(self:BuildInfoPanelModel())
end

function SummerRaceModifyView:BuildInfoPanelModelByPanelType(arg_176_1)
	if arg_176_1 == var_0_3.CHALLENGE then
		return self:BuildChallengePanelModel()
	end

	return self:BuildStageDetailPanelModel()
end

function SummerRaceModifyView:RefreshBattleInfoAdminPos(arg_177_1)
	if self.battleInfoView_ == nil or type(self.battleInfoView_.SyncAdminPos) ~= "function" then
		return
	end

	local var_177_0 = self:BuildInfoPanelModelByPanelType(arg_177_1)

	self.battleInfoView_:SyncAdminPos(var_177_0 and var_177_0.vehicleDisplay)
end

function SummerRaceModifyView:ShowModifyPanel(arg_178_1)
	self:HideModifyTips()

	if self.battleInfoView_ ~= nil and type(self.battleInfoView_.SetOpenAnimEnabled) == "function" then
		self.battleInfoView_:SetOpenAnimEnabled(true)
	end

	if self.bodyTipsView_ ~= nil then
		self.bodyTipsView_:SetData(nil)
	end

	if self.weaponTipsView_ ~= nil then
		self.weaponTipsView_:SetData(nil)
	end

	if self.equipTipsView_ ~= nil then
		self.equipTipsView_:SetData(nil)
	end

	SetActive(self.bgGo_, true)
	var_0_85(self, var_0_3.MODIFY)
	SetActive(self.modifyPanelGo_, true)
	var_0_79(self.battleInfoCanvasGroup_, false)
	SetActive(self.battleInfoGo_, false)
	self:SetDropAreaHintState(var_0_28.NONE)

	if self.modifyPageModel_ ~= nil then
		self:RefreshModifyInfoPanel()
	end

	if arg_178_1 then
		self:PlayModifyAnim(var_0_4)
	end
end

function SummerRaceModifyView:ShowBattleInfoPanel()
	var_0_85(self, self.activePanelType_)
	SetActive(self.bgGo_, false)
	SetActive(self.modifyPanelGo_, false)
	SetActive(self.battleInfoGo_, true)
	var_0_79(self.battleInfoCanvasGroup_, true)

	if self.battleInfoView_ ~= nil and type(self.battleInfoView_.PlayOpenAnim) == "function" then
		self.battleInfoView_:PlayOpenAnim()
	end

	self:SetDropAreaHintState(var_0_28.NONE)
end

function SummerRaceModifyView:ClearModifyVehicleSlots()
	for iter_180_0 = 1, #(self.vehicleSlotItemViews_ or {}) do
		local var_180_1 = self.vehicleSlotItemViews_[iter_180_0].slotGestureListener_

		if self.vehicleSlotItemViews_[iter_180_0].slotGestureListener_ == nil and self.vehicleSlotItemViews_[iter_180_0].gameObject_ ~= nil then
			var_180_1 = self.vehicleSlotItemViews_[iter_180_0].gameObject_:GetComponent(typeof(EventTriggerListener))
		end

		if var_180_1 ~= nil then
			var_180_1:RemoveAllListeners()
			var_0_69(self, var_180_1)

			self.vehicleSlotItemViews_[iter_180_0].slotGestureListener_ = nil
		end

		self.vehicleSlotItemViews_[iter_180_0]:Dispose()

		if self.vehicleSlotItemViews_[iter_180_0].gameObject_ ~= nil then
			Object.Destroy(self.vehicleSlotItemViews_[iter_180_0].gameObject_)
		end
	end

	self.vehicleSlotItemViews_ = {}
	self.vehicleSlotSignature_ = ""
end

function SummerRaceModifyView:EnsureModifyVehicleSlotLayer()
	if self.vehicleSlotLayerGo_ == nil then
		self.vehicleSlotLayerGo_ = GameObject("SlotLayer")

		local var_181_0 = self.vehicleSlotLayerGo_:AddComponent(typeof(RectTransform))

		var_181_0:SetParent(self.carRootGo_.transform, false)

		var_181_0.anchorMin = Vector2.New(0.5, 0.5)
		var_181_0.anchorMax = Vector2.New(0.5, 0.5)
		var_181_0.pivot = Vector2.New(0.5, 0.5)
		var_181_0.anchoredPosition = Vector2.zero
		var_181_0.sizeDelta = Vector2.zero
		self.vehicleSlotLayerCanvasGroup_ = var_0_80(self.vehicleSlotLayerGo_)
	elseif self.vehicleSlotLayerGo_.transform.parent ~= self.carRootGo_.transform then
		self.vehicleSlotLayerGo_.transform:SetParent(self.carRootGo_.transform, false)
	end

	if self.vehicleSlotLayerCanvasGroup_ == nil then
		self.vehicleSlotLayerCanvasGroup_ = var_0_80(self.vehicleSlotLayerGo_)
	end

	self.vehicleSlotLayerGo_.transform:SetAsLastSibling()

	return self.vehicleSlotLayerGo_.transform
end

function SummerRaceModifyView:ClearModifyVehicleDisplay()
	var_0_74(self)

	self.vehicleSlotLayerHoldHidden_ = false

	self:ClearModifyVehicleSlots()

	if self.vehicleSlotLayerGo_ ~= nil then
		Object.Destroy(self.vehicleSlotLayerGo_)

		self.vehicleSlotLayerGo_ = nil
		self.vehicleSlotLayerCanvasGroup_ = nil
	end

	self.vehicleModuleLayerCanvasGroup_ = nil
end

function SummerRaceModifyView:GetModifyVehicleModuleLayerCanvasGroup()
	if self.vehicleDisplayView_ == nil or type(self.vehicleDisplayView_.GetModuleLayerGo) ~= "function" then
		return nil
	end

	local var_183_0 = self.vehicleDisplayView_:GetModuleLayerGo()

	if var_183_0 == nil then
		self.vehicleModuleLayerCanvasGroup_ = nil

		return nil
	end

	if self.vehicleModuleLayerCanvasGroup_ == nil then
		self.vehicleModuleLayerCanvasGroup_ = var_0_80(var_183_0)
	end

	return self.vehicleModuleLayerCanvasGroup_
end

function SummerRaceModifyView:SetModifyVehicleSlotLayerVisible(arg_184_1, arg_184_2)
	if self.vehicleSlotLayerGo_ == nil then
		return
	end

	self.vehicleSlotLayerCanvasGroup_ = self.vehicleSlotLayerCanvasGroup_ or var_0_80(self.vehicleSlotLayerGo_)

	if self.vehicleSlotLayerCanvasGroup_ == nil then
		return
	end

	local var_184_0 = arg_184_2 == true

	self.vehicleSlotLayerCanvasGroup_.alpha = arg_184_1
	self.vehicleSlotLayerCanvasGroup_.interactable = var_184_0
	self.vehicleSlotLayerCanvasGroup_.blocksRaycasts = var_184_0

	local var_184_1 = self:GetModifyVehicleModuleLayerCanvasGroup()

	if var_184_1 ~= nil then
		var_184_1.alpha = arg_184_1
		var_184_1.interactable = var_184_0
		var_184_1.blocksRaycasts = var_184_0
	end
end

function SummerRaceModifyView:HideModifyVehicleSlotLayerForBodySwitch()
	var_0_74(self)

	self.vehicleSlotLayerHoldHidden_ = true

	self:SetModifyVehicleSlotLayerVisible(0, false)
end

function SummerRaceModifyView:ShowModifyVehicleSlotLayerImmediate()
	var_0_74(self)

	self.vehicleSlotLayerHoldHidden_ = false

	self:SetModifyVehicleSlotLayerVisible(1, true)
end

function SummerRaceModifyView:FadeInModifyVehicleSlotLayer()
	var_0_74(self)

	self.vehicleSlotLayerHoldHidden_ = false

	if self.activePanelType_ ~= var_0_3.MODIFY or self.vehicleSlotLayerGo_ == nil then
		return
	end

	self.vehicleSlotLayerCanvasGroup_ = self.vehicleSlotLayerCanvasGroup_ or var_0_80(self.vehicleSlotLayerGo_)

	if self.vehicleSlotLayerCanvasGroup_ == nil then
		return
	end

	self:SetModifyVehicleSlotLayerVisible(0, false)

	self.vehicleSlotLayerFadeTween_ = LeanTween.value(self.vehicleSlotLayerGo_, 0, 1, var_0_14):setDelay(var_0_13):setEase(LeanTweenType.easeOutQuad):setOnUpdate(LuaHelper.FloatAction(function(arg_188_0)
		self:SetModifyVehicleSlotLayerVisible(arg_188_0, false)
	end)):setOnComplete(System.Action(function()
		self.vehicleSlotLayerFadeTween_ = nil

		self:SetModifyVehicleSlotLayerVisible(1, true)
	end))
end

function SummerRaceModifyView:ApplyModifySlotTransform(arg_190_1, arg_190_2)
	if arg_190_1 == nil or arg_190_1.transform_ == nil or arg_190_2 == nil then
		return
	end

	local var_190_0 = arg_190_1.transform_:GetComponent(typeof(RectTransform))

	if var_190_0 == nil then
		return
	end

	var_190_0.anchoredPosition = var_0_62(self.vehicleDisplayView_, arg_190_2.displayLocalPosition) or var_0_61(self.vehicleDisplayView_, arg_190_2.localPosition)
	var_190_0.localEulerAngles = Vector3.New(0, 0, tonumber(arg_190_2.localAngle) or 0)
	var_190_0.localScale = Vector3.New(1, 1, 1)
end

function SummerRaceModifyView:BuildModifyVehicleSlots()
	if self.vehicleSlotItemPrefab_ == nil then
		error("[SummerRaceModifyView] missing slot item prefab: " .. var_0_20)
	end

	local var_191_0 = self:EnsureModifyVehicleSlotLayer()

	for iter_191_0 = 1, #self.modifySlotList_ do
		local var_191_1 = Object.Instantiate(self.vehicleSlotItemPrefab_, var_191_0)
		local var_191_2 = var_0_63(self.modifySlotList_[iter_191_0])
		local var_191_3 = SummerRaceEquipSlotItemView.New(var_191_1)

		var_191_2.playEquipAnim = self:ShouldPlayEquipAnim(var_191_2)

		self:ApplyModifySlotTransform(var_191_3, var_191_2)
		var_191_3:SetData(var_191_2, iter_191_0, handler(self, self.OnDetailSlotAction))

		local var_191_4 = var_191_1

		if var_191_3.dragAreaObj_ ~= nil then
			var_191_4 = var_191_3.dragAreaObj_
		elseif var_191_3.icon_ ~= nil and var_191_3.icon_.gameObject ~= nil then
			var_191_4 = var_191_3.icon_.gameObject
		end

		var_191_3.slotGestureListener_ = var_0_45(self, var_191_4, function(arg_192_0)
			self:OnModifySlotPointerDown(iter_191_0, arg_192_0, var_191_1)
		end, function(arg_193_0)
			self:OnModifySlotDrag(iter_191_0, arg_193_0)
		end, function(arg_194_0)
			self:OnModifySlotPointerUp(iter_191_0, arg_194_0)
		end, function(arg_195_0)
			self:OnModifySlotEndDrag(iter_191_0, arg_195_0)
		end)
		self.vehicleSlotItemViews_[#self.vehicleSlotItemViews_ + 1] = var_191_3
	end

	self.vehicleSlotSignature_ = var_0_56(self.modifySlotList_)
end

function SummerRaceModifyView:RefreshModifyVehicleSlots()
	for iter_196_0 = 1, #self.modifySlotList_ do
		local var_196_0 = var_0_63(self.modifySlotList_[iter_196_0])

		var_196_0.playEquipAnim = self:ShouldPlayEquipAnim(var_196_0)

		SetActive(self.vehicleSlotItemViews_[iter_196_0].gameObject_, true)
		self:ApplyModifySlotTransform(self.vehicleSlotItemViews_[iter_196_0], var_196_0)
		self.vehicleSlotItemViews_[iter_196_0]:SetData(var_196_0, iter_196_0, handler(self, self.OnDetailSlotAction))
	end
end

function SummerRaceModifyView:RefreshModifyVehicleDisplay()
	local var_197_0 = var_0_56(self.modifySlotList_)
	local var_197_1 = self.vehicleDisplayModel_
	local var_197_2 = var_0_84(self)
	local var_197_3 = self.activePanelType_ == var_0_3.MODIFY

	if self.dragSlotSourceData_ ~= nil and var_197_1 ~= nil then
		var_197_1 = var_0_67(var_197_1)
		var_197_1.modules = {}

		for iter_197_0 = 1, #(self.vehicleDisplayModel_.modules or {}) do
			if not var_0_68(self.vehicleDisplayModel_.modules[iter_197_0], self.dragSlotSourceData_) then
				var_197_1.modules[#var_197_1.modules + 1] = var_0_63(self.vehicleDisplayModel_.modules[iter_197_0])
			end
		end
	end

	self.vehicleDisplayView_:AttachHost(var_197_2)
	self.vehicleDisplayView_:SetData(var_197_1)

	if type(self.vehicleDisplayView_.SetModuleDragSourceSlotData) == "function" then
		self.vehicleDisplayView_:SetModuleDragSourceSlotData(self.dragSlotSourceData_)
	end

	local var_197_4 = #self.vehicleSlotItemViews_ ~= #self.modifySlotList_ or self.vehicleSlotSignature_ ~= var_197_0

	if var_197_1 then
		if var_197_1 == nil or (tostring(var_197_1.bodySkeletonDataPath or "") or "") == "" then
			self:ClearModifyVehicleDisplay()

			return
		end

		if not var_197_3 then
			self:ClearModifyVehicleSlots()

			return
		end
	end

	self:EnsureModifyVehicleSlotLayer()

	if self.vehicleSlotLayerHoldHidden_ == true then
		self:SetModifyVehicleSlotLayerVisible(0, false)
	elseif self.vehicleSlotLayerFadeTween_ == nil then
		self:SetModifyVehicleSlotLayerVisible(1, true)
	end

	if var_197_4 then
		self:ClearModifyVehicleSlots()
		self:BuildModifyVehicleSlots()
	else
		self:RefreshModifyVehicleSlots()
	end
end

function SummerRaceModifyView:StopModifyAnimTimer(arg_198_1)
	if self.modifyAnimTimer_ ~= nil then
		self.modifyAnimTimer_:Stop()

		self.modifyAnimTimer_ = nil
	end

	if arg_198_1 == true then
		manager.ui:UIEventEnabledByUI(true, false)
	end
end

function SummerRaceModifyView:PlayModifyAnim(arg_199_1, arg_199_2, arg_199_3, arg_199_4)
	self:StopModifyAnimTimer(false)

	if arg_199_4 == true then
		manager.ui:UIEventEnabledByUI(false, true)
	end

	local var_199_0 = var_0_82(self.modifyAnimator_, arg_199_1, arg_199_2)

	if var_199_0 == nil then
		self:StopModifyAnimTimer(arg_199_4)

		if arg_199_3 ~= nil then
			arg_199_3()
		end

		return
	end

	local var_199_1 = 0
	local var_199_2 = var_0_8 + 0.2

	self.modifyAnimator_:Play(var_199_0, -1, 0)
	self.modifyAnimator_:Update(0)

	self.modifyAnimTimer_ = Timer.New(function()
		var_199_1 = var_199_1 + var_0_7

		local var_200_0 = var_0_81(self.modifyAnimator_, var_199_0) and self.modifyAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1

		if not var_200_0 and var_199_1 >= var_199_2 then
			var_200_0 = true
		end

		if var_200_0 then
			self:StopModifyAnimTimer(arg_199_4)

			if arg_199_3 ~= nil then
				arg_199_3()
			end
		end
	end, var_0_7, -1)

	self.modifyAnimTimer_:Start()
end

function SummerRaceModifyView:PlayModifyExit(arg_201_1)
	if arg_201_1 ~= var_0_3.MODIFY and self.battleInfoView_ ~= nil and type(self.battleInfoView_.SetOpenAnimEnabled) == "function" then
		self.battleInfoView_:SetOpenAnimEnabled(false)
	end

	SetActive(self.modifyPanelGo_, true)
	SetActive(self.battleInfoGo_, true)
	var_0_79(self.battleInfoCanvasGroup_, false)
	var_0_85(self, arg_201_1)
	self:RefreshBattleInfoAdminPos(arg_201_1)
	self:PlayModifyAnim(var_0_5, var_0_6, function()
		self.activePanelType_ = arg_201_1
		self.returnPanelType_ = nil

		self:RefreshInfoPanel()
		self:ShowBattleInfoPanel()
	end, true)
end

function SummerRaceModifyView:RefreshView()
	if self.modifyAnimTimer_ ~= nil or self.bodySwitchTransitioning_ == true then
		return
	end

	if self.activePanelType_ == var_0_3.MODIFY then
		self:RefreshModifyPanel()

		return
	end

	self:RefreshInfoPanel()
end

function SummerRaceModifyView:Dispose()
	self:HideAllTips()
	self:ClearOptionListGestureState()
	self:ClearOptionDragState(false)
	self:ClearSlotGestureState()
	self:StopEquipAnimTimer()
	var_0_76(self)
	var_0_77(self)

	self.bodySwitchTransitioning_ = false

	SummerRaceModifyView.super.Dispose(self)

	if self.bodyItemList_ then
		self.bodyItemList_:Dispose()

		self.bodyItemList_ = nil
	end

	if self.weaponOptionItemList_ then
		self.weaponOptionItemList_:Dispose()

		self.weaponOptionItemList_ = nil
	end

	if self.battleInfoView_ then
		self.battleInfoView_:Dispose()

		self.battleInfoView_ = nil
	end

	if self.vehicleDisplayView_ then
		self.vehicleDisplayView_:Dispose()

		self.vehicleDisplayView_ = nil
	end

	self:ClearModifyVehicleDisplay()
	self:StopModifyAnimTimer(true)

	if self.vehicleSlotItemPrefab_ ~= nil then
		Asset.Unload(var_0_20)

		self.vehicleSlotItemPrefab_ = nil
	end

	if self.propertiesItemPrefab_ ~= nil then
		Asset.Unload(var_0_22)

		self.propertiesItemPrefab_ = nil
	end

	if self.optionDragPreviewPrefab_ ~= nil then
		Asset.Unload(var_0_21)

		self.optionDragPreviewPrefab_ = nil
	end

	if self.bodyTipsView_ then
		self.bodyTipsView_:Dispose()

		self.bodyTipsView_ = nil
	end

	if self.weaponTipsView_ then
		self.weaponTipsView_:Dispose()

		self.weaponTipsView_ = nil
	end

	if self.equipTipsView_ then
		self.equipTipsView_:Dispose()

		self.equipTipsView_ = nil
	end

	self.tipsController_ = nil
	self.windowBarBackHandler_ = nil
end

return SummerRaceModifyView
