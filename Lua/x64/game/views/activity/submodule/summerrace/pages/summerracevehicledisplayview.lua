local var_0_0 = class("SummerRaceVehicleDisplayView")
local var_0_1 = 100
local var_0_2 = "Assets/ABResources/SummerRaceActivity/Spine/Weapon/SummerRaceWeapon_Boomerang/SummerRaceWeapon_Boomerang_SkeletonData.asset"
local var_0_3 = "Assets/ABResources/SummerRaceActivity/Spine/Weapon/SummerRaceWeapon_Boomerang_Out/SummerRaceWeapon_Boomerang_SkeletonData.asset"
local var_0_4 = 0.7

local function var_0_5(arg_1_0)
	local var_1_0 = SummerRaceConst.DISPLAY.CANVAS_SCALE
	local var_1_1 = arg_1_0 and tonumber(arg_1_0.x) or 0
	local var_1_2 = arg_1_0 and tonumber(arg_1_0.y) or 0

	return Vector3.New(var_1_1 * var_1_0, -var_1_2 * var_1_0, 0)
end

local function var_0_6(arg_2_0)
	if type(arg_2_0) ~= "string" or arg_2_0 == "" then
		return ""
	end

	local var_2_0 = string.gsub(arg_2_0, "\\", "/")
	local var_2_1 = "Assets/ABResources/"

	if string.sub(var_2_0, 1, #var_2_1) == var_2_1 then
		var_2_0 = string.sub(var_2_0, #var_2_1 + 1)
	end

	return var_2_0
end

local function var_0_7(arg_3_0)
	local var_3_0 = var_0_6(arg_3_0)
	local var_3_1 = string.gsub(var_3_0, "%.png$", "")
	local var_3_2 = string.gsub(var_3_1, "%.jpg$", "")

	return (string.gsub(var_3_2, "%.jpeg$", ""))
end

local function var_0_8(arg_4_0)
	return var_0_6(arg_4_0) == var_0_6(var_0_2)
end

local function var_0_9(arg_5_0)
	local var_5_0 = {}

	for iter_5_0 = 1, #(arg_5_0 or {}) do
		local var_5_1 = arg_5_0[iter_5_0]
		local var_5_2 = var_5_1.localPosition or {}

		var_5_0[#var_5_0 + 1] = string.format("%s|%s|%s|%s|%s", tostring(var_5_1.name or ""), tostring(var_5_2.x or 0), tostring(var_5_2.y or 0), tostring(var_5_1.radius or 0), tostring(var_5_1.visualPath or "") .. "|" .. tostring(var_5_1.innerVisualPath or ""))
	end

	return table.concat(var_5_0, ";")
end

local function var_0_10(arg_6_0)
	local var_6_0 = {}

	for iter_6_0 = 1, #(arg_6_0 or {}) do
		local var_6_1 = arg_6_0[iter_6_0]
		local var_6_2 = var_6_1.localPosition or {}
		local var_6_3 = var_6_1.moduleLocalOffset or {}

		var_6_0[#var_6_0 + 1] = string.format("%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s", tostring(var_6_1.itemId or ""), tostring(var_6_1.skeletonDataPath or ""), tostring(var_6_2.x or 0), tostring(var_6_2.y or 0), tostring(var_6_1.localAngle or 0), tostring(var_6_1.visualLocalAngle or 0), tostring(var_6_1.slotIndex or 0), tostring(var_6_1.moduleSize and var_6_1.moduleSize.x or 0), tostring(var_6_1.moduleSize and var_6_1.moduleSize.y or 0), tostring(var_6_3.x or 0), tostring(var_6_3.y or 0))
	end

	return table.concat(var_6_0, ";")
end

local function var_0_11(arg_7_0)
	if type(arg_7_0) ~= "table" or #arg_7_0 == 0 then
		return ""
	end

	return table.concat(arg_7_0, ";")
end

local function var_0_12(arg_8_0)
	local var_8_0 = arg_8_0 and arg_8_0.bodyBoundsSize or {}
	local var_8_1 = arg_8_0 and arg_8_0.bodyBoundsCenter or {}

	return string.format("%s|%s|%s|%s", tostring(var_8_0.x or 0), tostring(var_8_0.y or 0), tostring(var_8_1.x or 0), tostring(var_8_1.y or 0))
end

local function var_0_13(arg_9_0, arg_9_1)
	if arg_9_0 == nil or arg_9_1 == nil then
		return false
	end

	return arg_9_0.slotType == arg_9_1.slotType and tonumber(arg_9_0.slotIndex) == tonumber(arg_9_1.slotIndex)
end

local function var_0_14(arg_10_0)
	arg_10_0.anchorMin = Vector2.New(0.5, 0.5)
	arg_10_0.anchorMax = Vector2.New(0.5, 0.5)
	arg_10_0.pivot = Vector2.New(0.5, 0.5)
	arg_10_0.anchoredPosition = Vector2.zero
	arg_10_0.sizeDelta = Vector2.zero
	arg_10_0.localEulerAngles = Vector3.zero
	arg_10_0.localScale = Vector3.New(1, 1, 1)
end

local function var_0_15(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.anchorMin = Vector2.New(0.5, 0.5)
	arg_11_0.anchorMax = Vector2.New(0.5, 0.5)
	arg_11_0.pivot = Vector2.New(0.5, 0.5)
	arg_11_0.localPosition = arg_11_1 or Vector3.zero
	arg_11_0.localEulerAngles = Vector3.New(0, 0, tonumber(arg_11_2) or 0)
	arg_11_0.localScale = Vector3.New(1, 1, 1)
	arg_11_0.sizeDelta = Vector2.zero
end

local function var_0_16(arg_12_0, arg_12_1)
	if arg_12_0 == nil then
		return
	end

	local var_12_0 = arg_12_1 and arg_12_1.moduleLocalOffset or {}
	local var_12_1 = SummerRaceConst.DISPLAY.CANVAS_SCALE
	local var_12_2 = (tonumber(var_12_0.x) or 0) * var_12_1
	local var_12_3 = (tonumber(var_12_0.y) or 0) * var_12_1

	arg_12_0.localPosition = Vector3.New(var_12_2, var_12_3, 0)
	arg_12_0.localEulerAngles = Vector3.New(0, 0, tonumber(arg_12_1 and arg_12_1.visualLocalAngle) or 0)
end

local function var_0_17(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 and arg_13_1.moduleSize or nil
	local var_13_1 = tonumber(arg_13_1 and arg_13_1.moduleScale) or 1

	if var_13_1 <= 0 then
		var_13_1 = 1
	end

	local var_13_2 = 1
	local var_13_3 = arg_13_0 and arg_13_0.sizeDelta or nil
	local var_13_4 = var_13_3 and tonumber(var_13_3.x) or 0
	local var_13_5 = var_13_3 and tonumber(var_13_3.y) or 0
	local var_13_6 = (var_13_0 and tonumber(var_13_0.x) or 0) * SummerRaceConst.DISPLAY.CANVAS_SCALE
	local var_13_7 = (var_13_0 and tonumber(var_13_0.y) or 0) * SummerRaceConst.DISPLAY.CANVAS_SCALE

	if var_13_4 > 0 and var_13_5 > 0 and var_13_6 > 0 and var_13_7 > 0 then
		var_13_2 = math.min(var_13_6 / var_13_4, var_13_7 / var_13_5)
	end

	local var_13_8 = var_13_2 * var_13_1

	arg_13_0.localScale = Vector3.New(var_13_8, var_13_8, var_13_8)
end

local function var_0_18(arg_14_0, arg_14_1)
	local var_14_0 = var_0_7(arg_14_1)

	if var_14_0 == "" then
		error("[SummerRaceVehicleDisplayView] invalid sprite path: " .. tostring(arg_14_1))
	end

	if type(SetSpriteWithoutAtlasAsync) ~= "function" then
		error("[SummerRaceVehicleDisplayView] SetSpriteWithoutAtlasAsync is unavailable")
	end

	SetSpriteWithoutAtlasAsync(arg_14_0, var_14_0)
end

local function var_0_19(arg_15_0)
	local var_15_0 = arg_15_0:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

	if var_15_0 == nil then
		var_15_0 = arg_15_0:AddComponent(typeof(Spine.Unity.SkeletonGraphic))
	end

	var_15_0.raycastTarget = false

	return var_15_0
end

local function var_0_20(arg_16_0, arg_16_1)
	if type(arg_16_1) ~= "table" or #arg_16_1 == 0 then
		return
	end

	if SummerRaceLuaBridge == nil or SummerRaceLuaBridge.RequestApplySkeletonGraphicSkinStack == nil then
		error("[SummerRaceVehicleDisplayView] SummerRaceLuaBridge.RequestApplySkeletonGraphicSkinStack is unavailable")
	end

	if SummerRaceLuaBridge.RequestApplySkeletonGraphicSkinStack(arg_16_0, table.concat(arg_16_1, ";")) ~= true then
		error("[SummerRaceVehicleDisplayView] failed to apply body skin stack")
	end
end

local function var_0_21(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_0 == nil or arg_17_0.AnimationState == nil or tostring(arg_17_1 or "") == "" then
		return false
	end

	local var_17_0, var_17_1 = pcall(function()
		local var_18_0 = arg_17_0.AnimationState:SetAnimation(0, arg_17_1, arg_17_2 == true)

		if var_18_0 ~= nil and type(arg_17_3) == "number" and arg_17_3 > 0 then
			var_18_0.TimeScale = arg_17_3
		end
	end)

	if var_17_0 ~= true then
		Debug.LogWarning(string.format("[SummerRaceVehicleDisplayView] failed to play body spine animation: %s, %s", tostring(arg_17_1), tostring(var_17_1)))

		return false
	end

	return true
end

local function var_0_22(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = var_0_6(arg_19_1)

	if var_19_0 == "" then
		error("[SummerRaceVehicleDisplayView] invalid spine asset path: " .. tostring(arg_19_1))
	end

	local var_19_1 = Asset.Load(var_19_0)

	if var_19_1 == nil then
		error("[SummerRaceVehicleDisplayView] missing spine asset: " .. tostring(var_19_0))
	end

	local var_19_2 = arg_19_0:GetComponent(typeof(RectTransform))
	local var_19_3 = var_19_2 and var_19_2.localPosition or Vector3.zero
	local var_19_4 = var_19_2 and var_19_2.localEulerAngles or Vector3.zero
	local var_19_5 = var_19_2 and var_19_2.localScale or Vector3.New(1, 1, 1)

	arg_19_0.skeletonDataAsset = var_19_1
	arg_19_0.initialSkinName = ""
	arg_19_0.startingAnimation = ""
	arg_19_0.startingLoop = true

	arg_19_0:Initialize(true)
	var_0_20(arg_19_0, arg_19_2)
	arg_19_0:MatchRectTransformWithBounds()

	if var_19_2 ~= nil then
		local var_19_6 = SummerRaceConst.DISPLAY.CANVAS_SCALE / 100

		var_19_2.sizeDelta = Vector2.New(var_19_2.sizeDelta.x * var_19_6, var_19_2.sizeDelta.y * var_19_6)
		var_19_2.localPosition = var_19_3
		var_19_2.localEulerAngles = var_19_4
		var_19_2.localScale = var_19_5
	end

	arg_19_0:UpdateMesh()

	arg_19_0.color = Color.New(1, 1, 1, 1)
end

local function var_0_23(arg_20_0, arg_20_1)
	local var_20_0 = var_0_6(arg_20_1)

	if var_20_0 == "" then
		error("[SummerRaceVehicleDisplayView] invalid spine asset path: " .. tostring(arg_20_1))
	end

	local var_20_1 = Asset.Load(var_20_0)

	if var_20_1 == nil then
		error("[SummerRaceVehicleDisplayView] missing spine asset: " .. tostring(var_20_0))
	end

	arg_20_0.skeletonDataAsset = var_20_1
	arg_20_0.initialSkinName = ""
	arg_20_0.startingAnimation = ""
	arg_20_0.startingLoop = true

	arg_20_0:Initialize(true)
	arg_20_0:UpdateMesh()

	arg_20_0.color = Color.New(1, 1, 1, 1)
end

local function var_0_24(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_0 and tonumber(arg_21_0.x) or 0
	local var_21_1 = arg_21_0 and tonumber(arg_21_0.y) or 0
	local var_21_2 = arg_21_1 and tonumber(arg_21_1.x) or 0
	local var_21_3 = arg_21_1 and tonumber(arg_21_1.y) or 0
	local var_21_4 = SummerRaceConst.DISPLAY.CANVAS_SCALE

	if var_21_4 <= 0 then
		error("[SummerRaceVehicleDisplayView] invalid display canvas scale: " .. tostring(var_21_4))
	end

	local var_21_5 = (var_21_0 - var_21_2) * var_21_4
	local var_21_6 = (var_21_1 - var_21_3) * var_21_4

	return Vector3.New(var_21_5, var_21_6, 0)
end

function var_0_0.Ctor(arg_22_0, arg_22_1)
	arg_22_0.rootGo_ = arg_22_1
	arg_22_0.rootTransform_ = arg_22_1.transform
	arg_22_0.bodyLayerGo_ = nil
	arg_22_0.wheelLayerGo_ = nil
	arg_22_0.moduleLayerGo_ = nil
	arg_22_0.bodySpineGo_ = nil
	arg_22_0.bodySpineGraphic_ = nil
	arg_22_0.bodySkeletonDataPath_ = ""
	arg_22_0.bodySkinSignature_ = ""
	arg_22_0.wheelVisualList_ = {}
	arg_22_0.wheelSignature_ = ""
	arg_22_0.moduleSpinePool_ = {}
	arg_22_0.moduleSignature_ = ""
	arg_22_0.bodyBoundsSignature_ = ""
	arg_22_0.moduleDragSourceSlotData_ = nil
	arg_22_0.moduleReplaceSlotData_ = nil
	arg_22_0.displayModel_ = nil
	arg_22_0.bodyAnimationCompleteHandler_ = nil
end

function var_0_0.GetDisplayTransform(arg_23_0)
	arg_23_0.rootTransform_ = arg_23_0.rootGo_ and arg_23_0.rootGo_.transform or arg_23_0.rootTransform_

	return arg_23_0.rootTransform_
end

function var_0_0.AttachHost(arg_24_0, arg_24_1)
	if arg_24_1 == nil then
		return
	end

	arg_24_0.rootGo_ = arg_24_1
	arg_24_0.rootTransform_ = arg_24_1.transform

	local var_24_0 = arg_24_0:GetDisplayTransform()

	if var_24_0 == nil then
		return
	end

	if arg_24_0.bodyLayerGo_ ~= nil and arg_24_0.bodyLayerGo_.transform.parent ~= var_24_0 then
		arg_24_0.bodyLayerGo_.transform:SetParent(var_24_0, false)
	end

	if arg_24_0.wheelLayerGo_ ~= nil and arg_24_0.wheelLayerGo_.transform.parent ~= var_24_0 then
		arg_24_0.wheelLayerGo_.transform:SetParent(var_24_0, false)
	end

	if arg_24_0.moduleLayerGo_ ~= nil and arg_24_0.moduleLayerGo_.transform.parent ~= var_24_0 then
		arg_24_0.moduleLayerGo_.transform:SetParent(var_24_0, false)
	end

	if arg_24_0.bodyLayerGo_ ~= nil then
		arg_24_0.bodyLayerGo_.transform:SetSiblingIndex(0)
	end

	if arg_24_0.wheelLayerGo_ ~= nil then
		arg_24_0.wheelLayerGo_.transform:SetSiblingIndex(1)
	end

	if arg_24_0.moduleLayerGo_ ~= nil then
		arg_24_0.moduleLayerGo_.transform:SetSiblingIndex(2)
	end
end

function var_0_0.GetBodyRectSize(arg_25_0)
	if arg_25_0.bodySpineGo_ == nil then
		return nil
	end

	local var_25_0 = arg_25_0.bodySpineGo_:GetComponent(typeof(RectTransform))

	if var_25_0 == nil then
		return nil
	end

	return {
		x = var_25_0.sizeDelta.x,
		y = var_25_0.sizeDelta.y
	}
end

function var_0_0.ConvertBodyLocalPointToUiPosition(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.displayModel_ or {}

	return var_0_24(arg_26_1, var_26_0.bodyBoundsCenter, var_26_0.bodyBoundsSize, arg_26_0:GetBodyRectSize())
end

function var_0_0.ConvertDisplayLocalPointToUiPosition(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1 and tonumber(arg_27_1.x) or 0
	local var_27_1 = arg_27_1 and tonumber(arg_27_1.y) or 0

	return Vector3.New(var_27_0 * var_0_1, var_27_1 * var_0_1, 0)
end

function var_0_0.SetData(arg_28_0, arg_28_1)
	arg_28_0.displayModel_ = arg_28_1 or nil

	arg_28_0:Refresh()
end

function var_0_0.GetModuleLayerGo(arg_29_0)
	return arg_29_0.moduleLayerGo_
end

function var_0_0.SetModuleDragSourceSlotData(arg_30_0, arg_30_1)
	arg_30_0.moduleDragSourceSlotData_ = arg_30_1

	arg_30_0:ApplyModuleDragSourceVisibility()
end

function var_0_0.SetModuleReplaceSlotData(arg_31_0, arg_31_1)
	arg_31_0.moduleReplaceSlotData_ = arg_31_1

	arg_31_0:ApplyModuleDragSourceVisibility()
end

function var_0_0.ApplyModuleDragSourceVisibility(arg_32_0)
	if arg_32_0.moduleSpinePool_ == nil then
		return
	end

	for iter_32_0 = 1, #arg_32_0.moduleSpinePool_ do
		local var_32_0 = arg_32_0.moduleSpinePool_[iter_32_0]

		if var_32_0 ~= nil and var_32_0.go ~= nil then
			local var_32_1 = var_32_0.isActiveModule == true and not var_0_13(var_32_0.moduleData, arg_32_0.moduleDragSourceSlotData_)
			local var_32_2 = var_0_13(var_32_0.moduleData, arg_32_0.moduleReplaceSlotData_) and var_0_4 or 1

			SetActive(var_32_0.go, var_32_1)

			if var_32_0.graphic ~= nil then
				var_32_0.graphic.color = Color.New(1, 1, 1, var_32_2)
			end
		end
	end
end

function var_0_0.ClearBodyAnimationCompleteHandler(arg_33_0)
	if arg_33_0.bodyAnimationCompleteHandler_ ~= nil and arg_33_0.bodySpineGraphic_ ~= nil and arg_33_0.bodySpineGraphic_.AnimationState ~= nil then
		arg_33_0.bodySpineGraphic_.AnimationState.Complete = arg_33_0.bodySpineGraphic_.AnimationState.Complete - arg_33_0.bodyAnimationCompleteHandler_
	end

	arg_33_0.bodyAnimationCompleteHandler_ = nil
end

function var_0_0.PlayBodyAnimation(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	arg_34_0:ClearBodyAnimationCompleteHandler()

	if arg_34_0.bodySpineGraphic_ == nil then
		return false
	end

	if var_0_21(arg_34_0.bodySpineGraphic_, arg_34_1, arg_34_2, arg_34_4) ~= true then
		return false
	end

	if arg_34_3 ~= nil and arg_34_2 ~= true then
		local var_34_0

		local function var_34_1()
			arg_34_0:ClearBodyAnimationCompleteHandler()
			arg_34_3()
		end

		arg_34_0.bodyAnimationCompleteHandler_ = var_34_1
		arg_34_0.bodySpineGraphic_.AnimationState.Complete = arg_34_0.bodySpineGraphic_.AnimationState.Complete + var_34_1
	end

	return true
end

function var_0_0.EnsureLayerRoots(arg_36_0)
	local var_36_0 = arg_36_0:GetDisplayTransform()

	if arg_36_0.bodyLayerGo_ == nil then
		arg_36_0.bodyLayerGo_ = GameObject("BodyLayer")

		local var_36_1 = arg_36_0.bodyLayerGo_:AddComponent(typeof(RectTransform))

		arg_36_0.bodyLayerGo_.transform:SetParent(var_36_0, false)
		var_0_14(var_36_1)
	elseif arg_36_0.bodyLayerGo_.transform.parent ~= var_36_0 then
		arg_36_0.bodyLayerGo_.transform:SetParent(var_36_0, false)
	end

	if arg_36_0.wheelLayerGo_ == nil then
		arg_36_0.wheelLayerGo_ = GameObject("WheelLayer")

		local var_36_2 = arg_36_0.wheelLayerGo_:AddComponent(typeof(RectTransform))

		arg_36_0.wheelLayerGo_.transform:SetParent(var_36_0, false)
		var_0_14(var_36_2)
	elseif arg_36_0.wheelLayerGo_.transform.parent ~= var_36_0 then
		arg_36_0.wheelLayerGo_.transform:SetParent(var_36_0, false)
	end

	if arg_36_0.moduleLayerGo_ == nil then
		arg_36_0.moduleLayerGo_ = GameObject("ModuleLayer")

		local var_36_3 = arg_36_0.moduleLayerGo_:AddComponent(typeof(RectTransform))

		arg_36_0.moduleLayerGo_.transform:SetParent(var_36_0, false)
		var_0_14(var_36_3)
	elseif arg_36_0.moduleLayerGo_.transform.parent ~= var_36_0 then
		arg_36_0.moduleLayerGo_.transform:SetParent(var_36_0, false)
	end

	arg_36_0.bodyLayerGo_.transform:SetSiblingIndex(0)
	arg_36_0.wheelLayerGo_.transform:SetSiblingIndex(1)
	arg_36_0.moduleLayerGo_.transform:SetSiblingIndex(2)
end

function var_0_0.EnsureBodySpineGraphic(arg_37_0)
	arg_37_0:EnsureLayerRoots()

	if arg_37_0.bodySpineGo_ == nil then
		arg_37_0.bodySpineGo_ = GameObject("BodySpine")

		local var_37_0 = arg_37_0.bodySpineGo_:AddComponent(typeof(RectTransform))

		arg_37_0.bodySpineGo_.transform:SetParent(arg_37_0.bodyLayerGo_.transform, false)
		var_0_15(var_37_0, Vector3.zero, 0)

		arg_37_0.bodySpineGraphic_ = var_0_19(arg_37_0.bodySpineGo_)
	elseif arg_37_0.bodySpineGo_.transform.parent ~= arg_37_0.bodyLayerGo_.transform then
		arg_37_0.bodySpineGo_.transform:SetParent(arg_37_0.bodyLayerGo_.transform, false)
	end

	if arg_37_0.bodySpineGraphic_ == nil then
		arg_37_0.bodySpineGraphic_ = var_0_19(arg_37_0.bodySpineGo_)
	end

	return arg_37_0.bodySpineGraphic_
end

function var_0_0.EnsureModuleSpineGraphic(arg_38_0, arg_38_1)
	arg_38_0:EnsureLayerRoots()

	local var_38_0 = arg_38_0.moduleSpinePool_[arg_38_1]

	if var_38_0 == nil or var_38_0.go == nil then
		local var_38_1 = GameObject("ModuleSpine_" .. tostring(arg_38_1))
		local var_38_2 = var_38_1:AddComponent(typeof(RectTransform))
		local var_38_3 = GameObject("Visual")
		local var_38_4 = var_38_3:AddComponent(typeof(RectTransform))

		var_38_1.transform:SetParent(arg_38_0.moduleLayerGo_.transform, false)
		var_0_15(var_38_2, Vector3.zero, 0)
		var_38_3.transform:SetParent(var_38_1.transform, false)
		var_0_15(var_38_4, Vector3.zero, 0)

		var_38_0 = {
			go = var_38_1,
			rectTransform = var_38_2,
			visualGo = var_38_3,
			visualRectTransform = var_38_4,
			graphic = var_0_19(var_38_3)
		}
		arg_38_0.moduleSpinePool_[arg_38_1] = var_38_0
	elseif var_38_0.go.transform.parent ~= arg_38_0.moduleLayerGo_.transform then
		var_38_0.go.transform:SetParent(arg_38_0.moduleLayerGo_.transform, false)
	end

	if var_38_0.rectTransform == nil then
		var_38_0.rectTransform = var_38_0.go:GetComponent(typeof(RectTransform))
	end

	if var_38_0.visualGo == nil then
		local var_38_5 = var_38_0.go:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

		if var_38_5 ~= nil then
			Object.Destroy(var_38_5)
		end

		var_38_0.visualGo = GameObject("Visual")
		var_38_0.visualRectTransform = var_38_0.visualGo:AddComponent(typeof(RectTransform))

		var_38_0.visualGo.transform:SetParent(var_38_0.go.transform, false)
		var_0_15(var_38_0.visualRectTransform, Vector3.zero, 0)
	elseif var_38_0.visualGo.transform.parent ~= var_38_0.go.transform then
		var_38_0.visualGo.transform:SetParent(var_38_0.go.transform, false)
	end

	if var_38_0.visualRectTransform == nil then
		var_38_0.visualRectTransform = var_38_0.visualGo:GetComponent(typeof(RectTransform))
	end

	if var_38_0.graphic == nil then
		var_38_0.graphic = var_0_19(var_38_0.visualGo)
	end

	return var_38_0
end

function var_0_0.ClearWheelVisuals(arg_39_0)
	for iter_39_0 = 1, #(arg_39_0.wheelVisualList_ or {}) do
		Object.Destroy(arg_39_0.wheelVisualList_[iter_39_0])
	end

	arg_39_0.wheelVisualList_ = {}
	arg_39_0.wheelSignature_ = ""
end

function var_0_0.RecycleUnusedModuleSpines(arg_40_0, arg_40_1)
	if not arg_40_0.moduleSpinePool_ then
		return
	end

	for iter_40_0 = arg_40_1 + 1, #arg_40_0.moduleSpinePool_ do
		local var_40_0 = arg_40_0.moduleSpinePool_[iter_40_0]

		if var_40_0 ~= nil and var_40_0.go ~= nil then
			var_40_0.isActiveModule = false
			var_40_0.moduleData = nil

			SetActive(var_40_0.go, false)
		end
	end
end

function var_0_0.ClearModuleSpines(arg_41_0)
	if not arg_41_0.moduleSpinePool_ then
		return
	end

	for iter_41_0 = 1, #arg_41_0.moduleSpinePool_ do
		local var_41_0 = arg_41_0.moduleSpinePool_[iter_41_0]

		if var_41_0 ~= nil and var_41_0.go ~= nil then
			Object.Destroy(var_41_0.go)
		end
	end

	arg_41_0.moduleSpinePool_ = {}
	arg_41_0.moduleSignature_ = ""
end

function var_0_0.ClearVehicleDisplay(arg_42_0)
	arg_42_0:ClearBodyAnimationCompleteHandler()
	arg_42_0:ClearWheelVisuals()
	arg_42_0:ClearModuleSpines()

	if arg_42_0.bodySpineGo_ ~= nil then
		Object.Destroy(arg_42_0.bodySpineGo_)

		arg_42_0.bodySpineGo_ = nil
		arg_42_0.bodySpineGraphic_ = nil
	end

	if arg_42_0.bodyLayerGo_ ~= nil then
		Object.Destroy(arg_42_0.bodyLayerGo_)

		arg_42_0.bodyLayerGo_ = nil
	end

	if arg_42_0.wheelLayerGo_ ~= nil then
		Object.Destroy(arg_42_0.wheelLayerGo_)

		arg_42_0.wheelLayerGo_ = nil
	end

	if arg_42_0.moduleLayerGo_ ~= nil then
		Object.Destroy(arg_42_0.moduleLayerGo_)

		arg_42_0.moduleLayerGo_ = nil
	end

	arg_42_0.bodySkeletonDataPath_ = ""
	arg_42_0.bodySkinSignature_ = ""
	arg_42_0.bodyBoundsSignature_ = ""
	arg_42_0.moduleDragSourceSlotData_ = nil
	arg_42_0.moduleReplaceSlotData_ = nil
end

function var_0_0.BuildBodyVisual(arg_43_0)
	local var_43_0 = arg_43_0.displayModel_ or {}
	local var_43_1 = tostring(var_43_0.bodyVisualType or "")
	local var_43_2 = tostring(var_43_0.bodySkeletonDataPath or "")
	local var_43_3 = var_43_0.bodySkinNames or {}

	if var_43_1 ~= "spine" then
		error("[SummerRaceVehicleDisplayView] unsupported bodyVisualType: " .. tostring(var_43_1))
	end

	if var_43_2 == "" then
		error("[SummerRaceVehicleDisplayView] bodySkeletonDataPath is required for vehicle display")
	end

	local var_43_4 = arg_43_0:EnsureBodySpineGraphic()

	var_0_15(arg_43_0.bodySpineGo_:GetComponent(typeof(RectTransform)), Vector3.zero, 0)
	SetActive(arg_43_0.bodySpineGo_, true)
	var_0_22(var_43_4, var_43_2, var_43_3)

	arg_43_0.bodySkeletonDataPath_ = var_0_6(var_43_2)
	arg_43_0.bodySkinSignature_ = var_0_11(var_43_3)
	arg_43_0.bodyBoundsSignature_ = var_0_12(var_43_0)
end

function var_0_0.BuildWheelVisuals(arg_44_0)
	arg_44_0:ClearWheelVisuals()

	arg_44_0.wheelSignature_ = "__disabled__"
end

function var_0_0.BuildModuleVisuals(arg_45_0)
	arg_45_0:EnsureLayerRoots()

	local var_45_0 = arg_45_0.displayModel_ and arg_45_0.displayModel_.modules or {}
	local var_45_1 = 0

	for iter_45_0 = 1, #var_45_0 do
		local var_45_2 = var_45_0[iter_45_0]
		local var_45_3 = tostring(var_45_2.skeletonDataPath or "")

		if var_45_2.hasVisual ~= true or var_45_3 == "" then
			-- block empty
		else
			if tostring(var_45_2.visualType or "") ~= "spine" then
				error("[SummerRaceVehicleDisplayView] unsupported module visualType: " .. tostring(var_45_2.visualType))
			end

			var_45_1 = var_45_1 + 1

			local var_45_4 = arg_45_0:EnsureModuleSpineGraphic(var_45_1)

			var_45_4.moduleData = var_45_2
			var_45_4.isActiveModule = true
			var_45_4.go.name = "ModuleSpine_" .. tostring(var_45_2.itemId or var_45_1)

			local var_45_5 = var_45_2.displayLocalPosition ~= nil and arg_45_0:ConvertDisplayLocalPointToUiPosition(var_45_2.displayLocalPosition) or arg_45_0:ConvertBodyLocalPointToUiPosition(var_45_2.localPosition)

			var_0_15(var_45_4.rectTransform, var_45_5, var_45_2.localAngle)
			SetActive(var_45_4.go, true)
			var_0_22(var_45_4.graphic, var_45_3)
			var_0_16(var_45_4.visualRectTransform, var_45_2)
			var_0_17(var_45_4.visualRectTransform, var_45_2)

			if var_0_8(var_45_3) then
				var_0_23(var_45_4.graphic, var_0_3)
			end
		end
	end

	arg_45_0:RecycleUnusedModuleSpines(var_45_1)

	arg_45_0.moduleSignature_ = var_0_10(var_45_0)

	arg_45_0:ApplyModuleDragSourceVisibility()
end

function var_0_0.Refresh(arg_46_0)
	if arg_46_0.displayModel_ == nil then
		arg_46_0:ClearVehicleDisplay()

		return
	end

	local var_46_0 = var_0_6(arg_46_0.displayModel_.bodySkeletonDataPath or "")
	local var_46_1 = var_0_11(arg_46_0.displayModel_.bodySkinNames or {})
	local var_46_2 = var_0_12(arg_46_0.displayModel_)

	if var_46_0 == "" then
		error("[SummerRaceVehicleDisplayView] displayModel has no body spine asset")
	end

	arg_46_0:EnsureLayerRoots()

	local var_46_3 = arg_46_0.bodySpineGo_ == nil or arg_46_0.bodySkeletonDataPath_ ~= var_46_0 or arg_46_0.bodySkinSignature_ ~= var_46_1
	local var_46_4 = arg_46_0.bodyBoundsSignature_ ~= var_46_2

	if var_46_3 or var_46_4 then
		arg_46_0:BuildBodyVisual()
	end

	local var_46_5 = var_0_10(arg_46_0.displayModel_.modules or {})

	if arg_46_0.wheelSignature_ ~= "__disabled__" then
		arg_46_0:BuildWheelVisuals()
	end

	if var_46_3 or var_46_4 or arg_46_0.moduleSignature_ ~= var_46_5 then
		arg_46_0:BuildModuleVisuals()
	end
end

function var_0_0.Dispose(arg_47_0)
	arg_47_0:ClearBodyAnimationCompleteHandler()
	arg_47_0:ClearVehicleDisplay()

	arg_47_0.displayModel_ = nil
	arg_47_0.rootGo_ = nil
	arg_47_0.rootTransform_ = nil
end

return var_0_0
