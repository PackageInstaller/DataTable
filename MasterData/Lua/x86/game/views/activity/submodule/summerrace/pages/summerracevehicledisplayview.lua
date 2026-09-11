local SummerRaceVehicleDisplayView = class("SummerRaceVehicleDisplayView")
local var_0_1 = 100
local var_0_2 = "Assets/ABResources/SummerRaceActivity/Spine/Weapon/SummerRaceWeapon_Boomerang/SummerRaceWeapon_Boomerang_SkeletonData.asset"
local var_0_3 = "Assets/ABResources/SummerRaceActivity/Spine/Weapon/SummerRaceWeapon_Boomerang_Out/SummerRaceWeapon_Boomerang_SkeletonData.asset"
local var_0_4 = 0.7

local function var_0_6(arg_2_0)
	if type(arg_2_0) ~= "string" or arg_2_0 == "" then
		return ""
	end

	local var_2_0 = string.gsub(arg_2_0, "\\", "/")

	if string.sub(var_2_0, 1, #"Assets/ABResources/") == "Assets/ABResources/" then
		var_2_0 = string.sub(var_2_0, #"Assets/ABResources/" + 1)
	end

	return var_2_0
end

local function var_0_7(arg_3_0)
	return (string.gsub(string.gsub(string.gsub(var_0_6(arg_3_0), "%.png$", ""), "%.jpg$", ""), "%.jpeg$", ""))
end

local function var_0_8(arg_4_0)
	return var_0_6(arg_4_0) == var_0_6(var_0_2)
end

local function var_0_10(arg_6_0)
	local var_6_0 = {}

	for iter_6_0 = 1, #(arg_6_0 or {}) do
		local var_6_1 = arg_6_0[iter_6_0]
		local var_6_2 = arg_6_0[iter_6_0].localPosition or {}
		local var_6_3 = var_6_1.moduleLocalOffset or {}
		local var_6_4 = #var_6_0 + 1
		local var_6_5 = "%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s"
		local var_6_6 = tostring(var_6_1.itemId or "")
		local var_6_7 = tostring(var_6_1.skeletonDataPath or "")
		local var_6_8 = tostring(var_6_2.x or 0)
		local var_6_9 = tostring(var_6_2.y or 0)
		local var_6_10 = tostring(var_6_1.localAngle or 0)
		local var_6_11 = tostring(var_6_1.visualLocalAngle or 0)
		local var_6_12 = tostring(var_6_1.slotIndex or 0)

		var_6_0[var_6_4] = string.format(var_6_5, var_6_6, var_6_7, var_6_8, var_6_9, var_6_10, var_6_11, var_6_12, tostring((var_6_1.moduleSize or nil) and (var_6_1.moduleSize.x or 0)), tostring((var_6_1.moduleSize or nil) and (var_6_1.moduleSize.y or 0)), tostring(var_6_3.x or 0), tostring(var_6_3.y or 0))
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
	local var_8_0

	if arg_8_0 then
		var_8_0 = arg_8_0.bodyBoundsSize or {}

		local var_8_1

		if arg_8_0 then
			var_8_1 = arg_8_0.bodyBoundsCenter or {}
		end
	end

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

	if arg_12_1 then
		local var_12_0 = arg_12_1.moduleLocalOffset

		if not arg_12_1.moduleLocalOffset then
			var_12_0 = {}

			local var_12_1, var_12_2 = (tonumber(var_12_0.x) or 0) * SummerRaceConst.DISPLAY.CANVAS_SCALE, tonumber(var_12_0.y) or 0
		end
	end

	arg_12_0.localPosition = Vector3.New(var_12_1, var_12_2 * SummerRaceConst.DISPLAY.CANVAS_SCALE, 0)
	arg_12_0.localEulerAngles = Vector3.New(0, 0, tonumber(arg_12_1 and arg_12_1.visualLocalAngle) or 0)
end

local function var_0_17(arg_13_0, arg_13_1)
	local var_13_0

	if arg_13_1 then
		var_13_0 = arg_13_1.moduleSize or nil
	end

	local var_13_1 = tonumber(arg_13_1 and arg_13_1.moduleScale) or 1

	if var_13_1 <= 0 then
		var_13_1 = 1
	end

	local var_13_3

	if arg_13_0 then
		var_13_3 = arg_13_0.sizeDelta or nil
	end

	local var_13_4 = var_13_3 and tonumber(var_13_3.x) or 0
	local var_13_5 = var_13_3 and tonumber(var_13_3.y) or 0
	local var_13_6 = (var_13_0 and tonumber(var_13_0.x) or 0) * SummerRaceConst.DISPLAY.CANVAS_SCALE
	local var_13_7 = (var_13_0 and tonumber(var_13_0.y) or 0) * SummerRaceConst.DISPLAY.CANVAS_SCALE

	arg_13_0.localScale = Vector3.New(((var_13_4 > 0 and var_13_5 > 0 and var_13_6 > 0 and var_13_7 > 0 or nil) and math.min(var_13_6 / var_13_4, var_13_7 / var_13_5)) * var_13_1, ((var_13_4 > 0 and var_13_5 > 0 and var_13_6 > 0 and var_13_7 > 0 or nil) and math.min(var_13_6 / var_13_4, var_13_7 / var_13_5)) * var_13_1, ((var_13_4 > 0 and var_13_5 > 0 and var_13_6 > 0 and var_13_7 > 0 or nil) and math.min(var_13_6 / var_13_4, var_13_7 / var_13_5)) * var_13_1)
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
	local var_19_3

	if var_19_2 then
		var_19_3 = var_19_2.localPosition or Vector3.zero

		local var_19_4

		if var_19_2 then
			var_19_4 = var_19_2.localEulerAngles or Vector3.zero

			local var_19_5

			if var_19_2 then
				var_19_5 = var_19_2.localScale or Vector3.New(1, 1, 1)
			end
		end
	end

	arg_19_0.skeletonDataAsset = var_19_1
	arg_19_0.initialSkinName = ""
	arg_19_0.startingAnimation = ""
	arg_19_0.startingLoop = true

	arg_19_0:Initialize(true)
	var_0_20(arg_19_0, arg_19_2)
	arg_19_0:MatchRectTransformWithBounds()

	if var_19_2 ~= nil then
		var_19_2.sizeDelta = Vector2.New(var_19_2.sizeDelta.x * (SummerRaceConst.DISPLAY.CANVAS_SCALE / 100), var_19_2.sizeDelta.y * (SummerRaceConst.DISPLAY.CANVAS_SCALE / 100))
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

	if SummerRaceConst.DISPLAY.CANVAS_SCALE <= 0 then
		error("[SummerRaceVehicleDisplayView] invalid display canvas scale: " .. tostring(var_21_4))
	end

	return Vector3.New((var_21_0 - var_21_2) * var_21_4, (var_21_1 - var_21_3) * var_21_4, 0)
end

function SummerRaceVehicleDisplayView:Ctor(arg_22_1)
	self.rootGo_ = arg_22_1
	self.rootTransform_ = arg_22_1.transform
	self.bodyLayerGo_ = nil
	self.wheelLayerGo_ = nil
	self.moduleLayerGo_ = nil
	self.bodySpineGo_ = nil
	self.bodySpineGraphic_ = nil
	self.bodySkeletonDataPath_ = ""
	self.bodySkinSignature_ = ""
	self.wheelVisualList_ = {}
	self.wheelSignature_ = ""
	self.moduleSpinePool_ = {}
	self.moduleSignature_ = ""
	self.bodyBoundsSignature_ = ""
	self.moduleDragSourceSlotData_ = nil
	self.moduleReplaceSlotData_ = nil
	self.displayModel_ = nil
	self.bodyAnimationCompleteHandler_ = nil
end

function SummerRaceVehicleDisplayView:GetDisplayTransform()
	if self.rootGo_ then
		self.rootTransform_ = self.rootGo_.transform or self.rootTransform_
	end

	return self.rootTransform_
end

function SummerRaceVehicleDisplayView:AttachHost(arg_24_1)
	if arg_24_1 == nil then
		return
	end

	self.rootGo_ = arg_24_1
	self.rootTransform_ = arg_24_1.transform

	local var_24_0 = self:GetDisplayTransform()

	if var_24_0 == nil then
		return
	end

	if self.bodyLayerGo_ ~= nil and self.bodyLayerGo_.transform.parent ~= var_24_0 then
		self.bodyLayerGo_.transform:SetParent(var_24_0, false)
	end

	if self.wheelLayerGo_ ~= nil and self.wheelLayerGo_.transform.parent ~= var_24_0 then
		self.wheelLayerGo_.transform:SetParent(var_24_0, false)
	end

	if self.moduleLayerGo_ ~= nil and self.moduleLayerGo_.transform.parent ~= var_24_0 then
		self.moduleLayerGo_.transform:SetParent(var_24_0, false)
	end

	if self.bodyLayerGo_ ~= nil then
		self.bodyLayerGo_.transform:SetSiblingIndex(0)
	end

	if self.wheelLayerGo_ ~= nil then
		self.wheelLayerGo_.transform:SetSiblingIndex(1)
	end

	if self.moduleLayerGo_ ~= nil then
		self.moduleLayerGo_.transform:SetSiblingIndex(2)
	end
end

function SummerRaceVehicleDisplayView:GetBodyRectSize()
	if self.bodySpineGo_ == nil then
		return nil
	end

	local var_25_0 = self.bodySpineGo_:GetComponent(typeof(RectTransform))

	if var_25_0 == nil then
		return nil
	end

	return {
		x = var_25_0.sizeDelta.x,
		y = var_25_0.sizeDelta.y
	}
end

function SummerRaceVehicleDisplayView:ConvertBodyLocalPointToUiPosition(arg_26_1)
	local var_26_0 = self.displayModel_ or {}

	return var_0_24(arg_26_1, var_26_0.bodyBoundsCenter, var_26_0.bodyBoundsSize, self:GetBodyRectSize())
end

function SummerRaceVehicleDisplayView:ConvertDisplayLocalPointToUiPosition(arg_27_1)
	return Vector3.New((arg_27_1 and tonumber(arg_27_1.x) or 0) * var_0_1, (arg_27_1 and tonumber(arg_27_1.y) or 0) * var_0_1, 0)
end

function SummerRaceVehicleDisplayView:SetData(arg_28_1)
	self.displayModel_ = arg_28_1 or nil

	self:Refresh()
end

function SummerRaceVehicleDisplayView:GetModuleLayerGo()
	return self.moduleLayerGo_
end

function SummerRaceVehicleDisplayView:SetModuleDragSourceSlotData(arg_30_1)
	self.moduleDragSourceSlotData_ = arg_30_1

	self:ApplyModuleDragSourceVisibility()
end

function SummerRaceVehicleDisplayView:SetModuleReplaceSlotData(arg_31_1)
	self.moduleReplaceSlotData_ = arg_31_1

	self:ApplyModuleDragSourceVisibility()
end

function SummerRaceVehicleDisplayView:ApplyModuleDragSourceVisibility()
	if self.moduleSpinePool_ == nil then
		return
	end

	for iter_32_0 = 1, #self.moduleSpinePool_ do
		local var_32_0 = self.moduleSpinePool_[iter_32_0]

		if self.moduleSpinePool_[iter_32_0] ~= nil and var_32_0.go ~= nil then
			local var_32_1 = var_32_0.isActiveModule == true and not var_0_13(var_32_0.moduleData, self.moduleDragSourceSlotData_)
			local var_32_2

			if var_0_13(var_32_0.moduleData, self.moduleReplaceSlotData_) then
				var_32_2 = var_0_4 or 1
			end

			SetActive(var_32_0.go, var_32_1)

			if var_32_0.graphic ~= nil then
				var_32_0.graphic.color = Color.New(1, 1, 1, var_32_2)
			end
		end
	end
end

function SummerRaceVehicleDisplayView:ClearBodyAnimationCompleteHandler()
	if self.bodyAnimationCompleteHandler_ ~= nil and self.bodySpineGraphic_ ~= nil and self.bodySpineGraphic_.AnimationState ~= nil then
		self.bodySpineGraphic_.AnimationState.Complete = self.bodySpineGraphic_.AnimationState.Complete - self.bodyAnimationCompleteHandler_
	end

	self.bodyAnimationCompleteHandler_ = nil
end

function SummerRaceVehicleDisplayView:PlayBodyAnimation(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	self:ClearBodyAnimationCompleteHandler()

	if self.bodySpineGraphic_ == nil then
		return false
	end

	if var_0_21(self.bodySpineGraphic_, arg_34_1, arg_34_2, arg_34_4) ~= true then
		return false
	end

	if arg_34_3 ~= nil and arg_34_2 ~= true then
		self.bodyAnimationCompleteHandler_ = nil
		self.bodySpineGraphic_.AnimationState.Complete = self.bodySpineGraphic_.AnimationState.Complete + function()
			self:ClearBodyAnimationCompleteHandler()
			arg_34_3()
		end
	end

	return true
end

function SummerRaceVehicleDisplayView:EnsureLayerRoots()
	local var_36_0 = self:GetDisplayTransform()

	if self.bodyLayerGo_ == nil then
		self.bodyLayerGo_ = GameObject("BodyLayer")

		self.bodyLayerGo_.transform:SetParent(var_36_0, false)
		var_0_14((self.bodyLayerGo_:AddComponent(typeof(RectTransform))))
	elseif self.bodyLayerGo_.transform.parent ~= var_36_0 then
		self.bodyLayerGo_.transform:SetParent(var_36_0, false)
	end

	if self.wheelLayerGo_ == nil then
		self.wheelLayerGo_ = GameObject("WheelLayer")

		self.wheelLayerGo_.transform:SetParent(var_36_0, false)
		var_0_14((self.wheelLayerGo_:AddComponent(typeof(RectTransform))))
	elseif self.wheelLayerGo_.transform.parent ~= var_36_0 then
		self.wheelLayerGo_.transform:SetParent(var_36_0, false)
	end

	if self.moduleLayerGo_ == nil then
		self.moduleLayerGo_ = GameObject("ModuleLayer")

		self.moduleLayerGo_.transform:SetParent(var_36_0, false)
		var_0_14((self.moduleLayerGo_:AddComponent(typeof(RectTransform))))
	elseif self.moduleLayerGo_.transform.parent ~= var_36_0 then
		self.moduleLayerGo_.transform:SetParent(var_36_0, false)
	end

	self.bodyLayerGo_.transform:SetSiblingIndex(0)
	self.wheelLayerGo_.transform:SetSiblingIndex(1)
	self.moduleLayerGo_.transform:SetSiblingIndex(2)
end

function SummerRaceVehicleDisplayView:EnsureBodySpineGraphic()
	self:EnsureLayerRoots()

	if self.bodySpineGo_ == nil then
		self.bodySpineGo_ = GameObject("BodySpine")

		self.bodySpineGo_.transform:SetParent(self.bodyLayerGo_.transform, false)
		var_0_15(self.bodySpineGo_:AddComponent(typeof(RectTransform)), Vector3.zero, 0)

		self.bodySpineGraphic_ = var_0_19(self.bodySpineGo_)
	elseif self.bodySpineGo_.transform.parent ~= self.bodyLayerGo_.transform then
		self.bodySpineGo_.transform:SetParent(self.bodyLayerGo_.transform, false)
	end

	if self.bodySpineGraphic_ == nil then
		self.bodySpineGraphic_ = var_0_19(self.bodySpineGo_)
	end

	return self.bodySpineGraphic_
end

function SummerRaceVehicleDisplayView:EnsureModuleSpineGraphic(arg_38_1)
	self:EnsureLayerRoots()

	local var_38_0 = self.moduleSpinePool_[arg_38_1]

	if self.moduleSpinePool_[arg_38_1] == nil or var_38_0.go == nil then
		local var_38_1 = GameObject("ModuleSpine_" .. tostring(arg_38_1))
		local var_38_2 = var_38_1:AddComponent(typeof(RectTransform))
		local var_38_3 = GameObject("Visual")
		local var_38_4 = var_38_3:AddComponent(typeof(RectTransform))

		var_38_1.transform:SetParent(self.moduleLayerGo_.transform, false)
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
		self.moduleSpinePool_[arg_38_1] = var_38_0
	elseif var_38_0.go.transform.parent ~= self.moduleLayerGo_.transform then
		var_38_0.go.transform:SetParent(self.moduleLayerGo_.transform, false)
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

function SummerRaceVehicleDisplayView:ClearWheelVisuals()
	for iter_39_0 = 1, #(self.wheelVisualList_ or {}) do
		Object.Destroy(self.wheelVisualList_[iter_39_0])
	end

	self.wheelVisualList_ = {}
	self.wheelSignature_ = ""
end

function SummerRaceVehicleDisplayView:RecycleUnusedModuleSpines(arg_40_1)
	if not self.moduleSpinePool_ then
		return
	end

	for iter_40_0 = arg_40_1 + 1, #self.moduleSpinePool_ do
		if self.moduleSpinePool_[iter_40_0] ~= nil and self.moduleSpinePool_[iter_40_0].go ~= nil then
			self.moduleSpinePool_[iter_40_0].isActiveModule = false
			self.moduleSpinePool_[iter_40_0].moduleData = nil

			SetActive(self.moduleSpinePool_[iter_40_0].go, false)
		end
	end
end

function SummerRaceVehicleDisplayView:ClearModuleSpines()
	if not self.moduleSpinePool_ then
		return
	end

	for iter_41_0 = 1, #self.moduleSpinePool_ do
		if self.moduleSpinePool_[iter_41_0] ~= nil and self.moduleSpinePool_[iter_41_0].go ~= nil then
			Object.Destroy(self.moduleSpinePool_[iter_41_0].go)
		end
	end

	self.moduleSpinePool_ = {}
	self.moduleSignature_ = ""
end

function SummerRaceVehicleDisplayView:ClearVehicleDisplay()
	self:ClearBodyAnimationCompleteHandler()
	self:ClearWheelVisuals()
	self:ClearModuleSpines()

	if self.bodySpineGo_ ~= nil then
		Object.Destroy(self.bodySpineGo_)

		self.bodySpineGo_ = nil
		self.bodySpineGraphic_ = nil
	end

	if self.bodyLayerGo_ ~= nil then
		Object.Destroy(self.bodyLayerGo_)

		self.bodyLayerGo_ = nil
	end

	if self.wheelLayerGo_ ~= nil then
		Object.Destroy(self.wheelLayerGo_)

		self.wheelLayerGo_ = nil
	end

	if self.moduleLayerGo_ ~= nil then
		Object.Destroy(self.moduleLayerGo_)

		self.moduleLayerGo_ = nil
	end

	self.bodySkeletonDataPath_ = ""
	self.bodySkinSignature_ = ""
	self.bodyBoundsSignature_ = ""
	self.moduleDragSourceSlotData_ = nil
	self.moduleReplaceSlotData_ = nil
end

function SummerRaceVehicleDisplayView:BuildBodyVisual()
	local var_43_0 = self.displayModel_ or {}
	local var_43_1 = tostring(var_43_0.bodyVisualType or "")
	local var_43_2 = tostring(var_43_0.bodySkeletonDataPath or "")
	local var_43_3 = var_43_0.bodySkinNames or {}

	if var_43_1 ~= "spine" then
		error("[SummerRaceVehicleDisplayView] unsupported bodyVisualType: " .. tostring(var_43_1))
	end

	if var_43_2 == "" then
		error("[SummerRaceVehicleDisplayView] bodySkeletonDataPath is required for vehicle display")
	end

	local var_43_4 = self:EnsureBodySpineGraphic()

	var_0_15(self.bodySpineGo_:GetComponent(typeof(RectTransform)), Vector3.zero, 0)
	SetActive(self.bodySpineGo_, true)
	var_0_22(var_43_4, var_43_2, var_43_3)

	self.bodySkeletonDataPath_ = var_0_6(var_43_2)
	self.bodySkinSignature_ = var_0_11(var_43_3)
	self.bodyBoundsSignature_ = var_0_12(var_43_0)
end

function SummerRaceVehicleDisplayView:BuildWheelVisuals()
	self:ClearWheelVisuals()

	self.wheelSignature_ = "__disabled__"
end

function SummerRaceVehicleDisplayView:BuildModuleVisuals()
	self:EnsureLayerRoots()

	local var_45_0

	if self.displayModel_ then
		var_45_0 = self.displayModel_.modules or {}
	end

	local var_45_1 = 0

	for iter_45_0 = 1, #var_45_0 do
		local var_45_2 = var_45_0[iter_45_0]
		local var_45_3 = tostring(var_45_0[iter_45_0].skeletonDataPath or "")

		if var_45_2.hasVisual ~= true or var_45_3 == "" then
			-- block empty
		else
			if tostring((not var_45_2.visualType or nil) and "") ~= "spine" then
				error("[SummerRaceVehicleDisplayView] unsupported module visualType: " .. tostring(var_45_2.visualType))
			end

			var_45_1 = var_45_1 + 1

			local var_45_5 = self:EnsureModuleSpineGraphic(var_45_1)

			var_45_5.moduleData = var_45_2
			var_45_5.isActiveModule = true
			var_45_5.go.name = "ModuleSpine_" .. tostring(var_45_2.itemId or var_45_1)

			var_0_15(var_45_5.rectTransform, var_45_2.displayLocalPosition ~= nil and self:ConvertDisplayLocalPointToUiPosition(var_45_2.displayLocalPosition) or self:ConvertBodyLocalPointToUiPosition(var_45_2.localPosition), var_45_2.localAngle)
			SetActive(var_45_5.go, true)
			var_0_22(var_45_5.graphic, var_45_3)
			var_0_16(var_45_5.visualRectTransform, var_45_2)
			var_0_17(var_45_5.visualRectTransform, var_45_2)

			if var_0_8(var_45_3) then
				var_0_23(var_45_5.graphic, var_0_3)
			end
		end
	end

	self:RecycleUnusedModuleSpines(var_45_1)

	self.moduleSignature_ = var_0_10(var_45_0)

	self:ApplyModuleDragSourceVisibility()
end

function SummerRaceVehicleDisplayView:Refresh()
	if self.displayModel_ == nil then
		self:ClearVehicleDisplay()

		return
	end

	local var_46_0 = var_0_6(self.displayModel_.bodySkeletonDataPath or "")
	local var_46_1 = var_0_11(self.displayModel_.bodySkinNames or {})
	local var_46_2 = var_0_12(self.displayModel_)

	if var_46_0 == "" then
		error("[SummerRaceVehicleDisplayView] displayModel has no body spine asset")
	end

	self:EnsureLayerRoots()

	local var_46_3 = self.bodySpineGo_ == nil or self.bodySkeletonDataPath_ ~= var_46_0 or self.bodySkinSignature_ ~= var_46_1
	local var_46_4 = self.bodyBoundsSignature_ ~= var_46_2

	if self.bodySpineGo_ == nil or self.bodySkeletonDataPath_ ~= var_46_0 or self.bodySkinSignature_ ~= var_46_1 or var_46_4 then
		self:BuildBodyVisual()
	end

	local var_46_5 = var_0_10(self.displayModel_.modules or {})

	if self.wheelSignature_ ~= "__disabled__" then
		self:BuildWheelVisuals()
	end

	if var_46_3 or var_46_4 or self.moduleSignature_ ~= var_46_5 then
		self:BuildModuleVisuals()
	end
end

function SummerRaceVehicleDisplayView:Dispose()
	self:ClearBodyAnimationCompleteHandler()
	self:ClearVehicleDisplay()

	self.displayModel_ = nil
	self.rootGo_ = nil
	self.rootTransform_ = nil
end

return SummerRaceVehicleDisplayView
