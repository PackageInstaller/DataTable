local var_0_0 = singletonClass("SectionSelectHeroScene")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.posStateControllerList_ = {}
	arg_1_0.posStateGoList_ = {}
	arg_1_0.needChangeEffect_ = false
	arg_1_0.needChangeEffectList_ = {}
	arg_1_0.modelTransTweenDataDic_ = {}

	arg_1_0:ResetModelParams()
end

function var_0_0.ResetModelParams(arg_2_0)
	arg_2_0.skinIDList_ = {}
	arg_2_0.charModelList_ = {}
	arg_2_0.loadingTaskList_ = {}
end

function var_0_0.SetNeedChangeEffect(arg_3_0, arg_3_1)
	arg_3_0.needChangeEffect_ = arg_3_1 == true
	arg_3_0.needChangeEffectList_ = {}
end

function var_0_0.LoadHeroModels(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_1 then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.skinIDList_) do
		if arg_4_1[iter_4_0] ~= iter_4_1 then
			arg_4_0:StopLoadTargetModel(iter_4_0)
			arg_4_0:DestroyTargetModel(iter_4_0)
		end
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_1) do
		arg_4_0:LoadTargetModel(iter_4_2, iter_4_3, arg_4_2[iter_4_2])
	end

	if not arg_4_0:IsLoadingModel() then
		arg_4_0:OnAllModelLoadEnd()
	end

	arg_4_0:SetALlStateGoActive(true)
end

function var_0_0.LoadTargetModel(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local function var_5_0(arg_6_0, arg_6_1)
		if not arg_6_1 then
			arg_5_0:DisposeVfx(arg_6_0)
		end

		arg_5_0:CheckAndAttachOathRing(arg_6_0, arg_5_3)
	end

	arg_5_0:LoadTargetModelEx(arg_5_1, arg_5_2, var_5_0)
end

function var_0_0.LoadTargetModelEx(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_0.skinIDList_[arg_7_1] == arg_7_2 then
		arg_7_3(arg_7_0.charModelList_[arg_7_1], false)

		return
	end

	arg_7_0.skinIDList_[arg_7_1] = arg_7_2

	if arg_7_0.charModelList_[arg_7_1] then
		arg_7_0:DestroyTargetModel(arg_7_1)
	end

	if not arg_7_2 or not SkinCfg[arg_7_2] then
		return
	end

	arg_7_0:StartLoadModelEx(arg_7_2, arg_7_1, arg_7_3)
end

function var_0_0.StartLoadModelEx(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	manager.ui:UIEventEnabled(false)
	arg_8_0:StopLoadTargetModel(arg_8_2)

	local var_8_0 = {
		skinID = arg_8_1
	}

	arg_8_0.loadingTaskList_[arg_8_2] = var_8_0

	local var_8_1 = SkinCfg[arg_8_1]

	arg_8_0.loadingTaskList_[arg_8_2].loadAsyncIndex = manager.resourcePool:AsyncLoad("Char/" .. var_8_1.ui_modelId, ASSET_TYPE.TPOSE, function(arg_9_0)
		SetActive(arg_9_0, false)
		arg_8_0:InitModel(arg_9_0, arg_8_2)
		arg_8_3(arg_9_0, true)
		arg_8_0:OnTargetModelLoadEnd(arg_9_0, arg_8_2)
	end)
end

function var_0_0.OnTargetModelLoadEnd(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.loadingTaskList_[arg_10_2] = nil

	if arg_10_0.needChangeEffect_ then
		arg_10_0.needChangeEffectList_[arg_10_2] = true
	end

	if not arg_10_0:IsLoadingModel() then
		arg_10_0:OnAllModelLoadEnd()
	end
end

function var_0_0.OnAllModelLoadEnd(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.charModelList_) do
		SetActive(iter_11_1, true)

		if arg_11_0.needChangeEffectList_[iter_11_0] then
			arg_11_0:PlayModelChangeEffect(iter_11_1)
		end
	end

	arg_11_0.needChangeEffectList_ = {}

	manager.ui:UIEventEnabled(true)
	manager.notify:Invoke(SECTION_HERO_MODEL_LOADED)
end

function var_0_0.DestroyModels(arg_12_0)
	arg_12_0:StopModelTransTween()
	arg_12_0:OnlyDestoryModels()
	arg_12_0:ResetModelParams()
	arg_12_0:SetNeedChangeEffect(false)
end

function var_0_0.OnlyDestoryModels(arg_13_0)
	arg_13_0:StopLoadModel()

	for iter_13_0, iter_13_1 in pairs(arg_13_0.charModelList_) do
		arg_13_0:DestroyTargetModel(iter_13_0)
	end
end

function var_0_0.StopLoadModel(arg_14_0)
	manager.ui:UIEventEnabled(true)

	for iter_14_0, iter_14_1 in pairs(arg_14_0.loadingTaskList_) do
		arg_14_0:StopLoadTargetModel(iter_14_0)
	end
end

function var_0_0.StopLoadTargetModel(arg_15_0, arg_15_1)
	if arg_15_0.loadingTaskList_[arg_15_1] then
		manager.resourcePool:StopAsyncQuest(arg_15_0.loadingTaskList_[arg_15_1].loadAsyncIndex)

		arg_15_0.loadingTaskList_[arg_15_1] = nil
	end
end

function var_0_0.DestroyTargetModel(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.charModelList_[arg_16_1]

	if var_16_0 then
		arg_16_0:InterruptModelTween(var_16_0)
		arg_16_0:DisposeVfx(var_16_0)
		manager.resourcePool:DestroyOrReturn(var_16_0, ASSET_TYPE.TPOSE)
	end

	arg_16_0.charModelList_[arg_16_1] = nil
end

function var_0_0.IsLoadingModel(arg_17_0)
	return table.nums(arg_17_0.loadingTaskList_) > 0
end

function var_0_0.InitModel(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.charModelList_[arg_18_2] = arg_18_1

	arg_18_0:InitModelTransform(arg_18_1, arg_18_2)
end

function var_0_0.AddManagedVfx(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0.managedVfx == nil then
		arg_19_0.managedVfx = {}
	end

	arg_19_0.managedVfx[arg_19_1] = arg_19_0.managedVfx[arg_19_1] or {}

	table.insert(arg_19_0.managedVfx[arg_19_1], arg_19_2)
end

function var_0_0.DisposeVfx(arg_20_0, arg_20_1)
	local var_20_0 = nullable(arg_20_0.managedVfx, arg_20_1)

	if var_20_0 then
		for iter_20_0, iter_20_1 in ipairs(var_20_0) do
			LuaForUtil.StopEffect(iter_20_1)
		end

		arg_20_0.managedVfx[arg_20_1] = nil
	end
end

function var_0_0.DisposeAllVfx(arg_21_0)
	if arg_21_0.managedVfx then
		for iter_21_0, iter_21_1 in pairs(arg_21_0.managedVfx) do
			for iter_21_2, iter_21_3 in pairs(iter_21_1) do
				LuaForUtil.StopEffect(iter_21_3)
			end
		end

		arg_21_0.managedVfx = nil
	end
end

function var_0_0.CheckAndAttachOathRing(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2:IsHeroOath() then
		arg_22_0:AttachOathRing(arg_22_1)
	end
end

function var_0_0.AttachOathRing(arg_23_0, arg_23_1)
	local var_23_0 = LuaForUtil.GetRoleAttachPoint(arg_23_1.transform, OathTools.OathRingAttachPoint)
	local var_23_1 = LuaForUtil.PlayAttachEffect(var_23_0, OathTools.OathRingAssetPath, Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), true, 1, 0, math.huge)

	arg_23_0:AddManagedVfx(arg_23_1, var_23_1)
end

function var_0_0.InitModelTransform(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0:UpdateModelTrans(arg_24_1, arg_24_2)
end

function var_0_0.UpdateModelTrans(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_1 then
		if not arg_25_3 then
			arg_25_1.transform.localEulerAngles = SectionSelectHeroConst.HeroModelTransform[arg_25_2].rotation
			arg_25_1.transform.localPosition = SectionSelectHeroConst.HeroModelTransform[arg_25_2].position
			arg_25_1.transform.localScale = SectionSelectHeroConst.HeroModelTransform[arg_25_2].scale
		else
			arg_25_0:StartModelTransTween(arg_25_1, arg_25_2)
		end
	end
end

function var_0_0.StartModelTransTween(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_0.modelTransTweenDataDic_[arg_26_1] then
		arg_26_0:InterruptModelTween(arg_26_1)
	end

	local var_26_0 = {}

	arg_26_0.modelTransTweenDataDic_[arg_26_1] = var_26_0
	var_26_0.modelTrans = arg_26_1.transform
	var_26_0.originRotation = arg_26_1.transform.localRotation
	var_26_0.originPosition = arg_26_1.transform.localPosition
	var_26_0.originScale = arg_26_1.transform.localScale

	local var_26_1 = SectionSelectHeroConst.HeroModelTransform[arg_26_2].rotation

	var_26_0.targetRotation = Quaternion.Euler(var_26_1.x, var_26_1.y, var_26_1.z)
	var_26_0.targetPosition = SectionSelectHeroConst.HeroModelTransform[arg_26_2].position
	var_26_0.targetScale = SectionSelectHeroConst.HeroModelTransform[arg_26_2].scale
	var_26_0.leanTween = LeanTween.value(0, 1, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
		arg_26_0:OnUpdateModelTransTween(arg_27_0, arg_26_1)
	end)):setOnComplete(System.Action(function()
		arg_26_0:OnCompleteModelTransTween(arg_26_1)
	end)):setEase(LeanTweenType.easeOutCubic)
end

function var_0_0.StopModelTransTween(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0.modelTransTweenDataDic_[arg_29_1] then
		arg_29_0:InterruptModelTween(arg_29_1)
	end
end

function var_0_0.InterruptModelTween(arg_30_0, arg_30_1)
	if arg_30_0.modelTransTweenDataDic_[arg_30_1] then
		local var_30_0 = arg_30_0.modelTransTweenDataDic_[arg_30_1]

		LeanTween.cancel(var_30_0.leanTween.id)
		var_30_0.leanTween:setOnUpdate(nil):setOnComplete(nil)

		var_30_0.leanTween = nil
		arg_30_0.modelTransTweenDataDic_[arg_30_1] = nil
	end
end

function var_0_0.OnUpdateModelTransTween(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_0.modelTransTweenDataDic_[arg_31_2] then
		return
	end

	local var_31_0 = arg_31_0.modelTransTweenDataDic_[arg_31_2]
	local var_31_1 = var_31_0.modelTrans

	var_31_1.localRotation = Quaternion.Lerp(var_31_0.originRotation, var_31_0.targetRotation, arg_31_1)
	var_31_1.localPosition = Vector3.Lerp(var_31_0.originPosition, var_31_0.targetPosition, arg_31_1)
	var_31_1.localScale = Vector3.Lerp(var_31_0.originScale, var_31_0.targetScale, arg_31_1)
end

function var_0_0.OnCompleteModelTransTween(arg_32_0, arg_32_1)
	if not arg_32_0.modelTransTweenDataDic_[arg_32_1] then
		return
	end

	local var_32_0 = arg_32_0.modelTransTweenDataDic_[arg_32_1]
	local var_32_1 = var_32_0.modelTrans

	if not isNil(var_32_1) then
		var_32_1.localRotation = var_32_0.targetRotation
		var_32_1.localPosition = var_32_0.targetPosition
		var_32_1.localScale = var_32_0.targetScale
	end

	var_32_0.modelTrans = nil

	LeanTween.cancel(var_32_0.leanTween.id)
	var_32_0.leanTween:setOnUpdate(nil):setOnComplete(nil)

	var_32_0.leanTween = nil
	arg_32_0.modelTransTweenDataDic_[arg_32_1] = nil
end

function var_0_0.PlayModelChangeEffect(arg_33_0, arg_33_1)
	LuaForUtil.PlayEffect(arg_33_1.transform, SectionSelectHeroConst.HERO_CHANGE_FX_PATH, Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
end

function var_0_0.ReorderModelByPosList(arg_34_0, arg_34_1)
	local var_34_0 = {}
	local var_34_1 = {}

	for iter_34_0, iter_34_1 in pairs(arg_34_1) do
		local var_34_2 = arg_34_0.charModelList_[iter_34_1]

		var_34_1[iter_34_0], var_34_0[iter_34_0] = arg_34_0.skinIDList_[iter_34_1], var_34_2

		arg_34_0:InitModelTransform(var_34_2, iter_34_0)
	end

	arg_34_0.charModelList_ = var_34_0
	arg_34_0.skinIDList_ = var_34_1
end

function var_0_0.GetModel(arg_35_0, arg_35_1)
	return arg_35_0.charModelList_[arg_35_1]
end

function var_0_0.GetModelLocalPosition(arg_36_0, arg_36_1)
	if arg_36_0.charModelList_[arg_36_1] then
		return arg_36_0.charModelList_[arg_36_1].transform.localPosition
	else
		return nil
	end
end

function var_0_0.SetModelLocalPosition(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0.charModelList_[arg_37_1] then
		arg_37_0.charModelList_[arg_37_1].transform.localPosition = arg_37_2
	end
end

function var_0_0.SetModelLocalRotation(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_0.charModelList_[arg_38_1] then
		arg_38_0.charModelList_[arg_38_1].transform.localRotation = Quaternion.Euler(arg_38_2)
	end
end

function var_0_0.OnlyDisplayModel(arg_39_0, arg_39_1)
	for iter_39_0, iter_39_1 in pairs(arg_39_0.charModelList_) do
		SetActive(iter_39_1, iter_39_0 == arg_39_1)
	end
end

function var_0_0.DisplayAllModel(arg_40_0)
	for iter_40_0, iter_40_1 in pairs(arg_40_0.charModelList_) do
		SetActive(iter_40_1, true)
	end
end

function var_0_0.GetModelPowerPointScreenPos(arg_41_0, arg_41_1)
	if arg_41_0.charModelList_[arg_41_1] then
		local var_41_0 = arg_41_0.charModelList_[arg_41_1]:GetHeorModelAttachPointTrans("Bip001 Head")

		if var_41_0 then
			local var_41_1 = UnityEngine.Camera.main:WorldToScreenPoint(var_41_0.position)

			var_41_1.y = var_41_1.y + SectionSelectHeroTools.GetRuntimeScreenOffsetOfHeroInfoItem()

			return var_41_1
		end
	end

	return nil
end

function var_0_0.RefreshPositionState(arg_42_0, arg_42_1, arg_42_2)
	if isNil(arg_42_0.posStateControllerList_[arg_42_1]) then
		arg_42_0:RebindController(arg_42_1)
	end

	if not isNil(arg_42_0.posStateControllerList_[arg_42_1]) then
		arg_42_0.posStateControllerList_[arg_42_1]:SetSelectedState(arg_42_2)
	end
end

function var_0_0.RebindController(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0:GetStateGo(arg_43_1)

	if var_43_0 then
		arg_43_0.posStateControllerList_[arg_43_1] = var_43_0:GetComponent("ControllerExCollection"):GetController("state")
	end
end

function var_0_0.SetALlStateGoActive(arg_44_0, arg_44_1)
	for iter_44_0 = 1, 3 do
		local var_44_0 = arg_44_0:GetStateGo(iter_44_0)

		SetActive(var_44_0, arg_44_1)
	end
end

function var_0_0.GetStateGo(arg_45_0, arg_45_1)
	if isNil(arg_45_0.posStateGoList_[arg_45_1]) then
		local var_45_0 = GameObject.Find(string.format("X104/X104_SceneSteps/X104_Formation_HeroPos_%s", arg_45_1))

		arg_45_0.posStateGoList_[arg_45_1] = var_45_0
	end

	return arg_45_0.posStateGoList_[arg_45_1]
end

function var_0_0.GetStateGoScreenPos(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0:GetStateGo(arg_46_1)

	if var_46_0 then
		return UnityEngine.Camera.main:WorldToScreenPoint(var_46_0.transform.position)
	end

	return nil
end

function var_0_0.Dispose(arg_47_0)
	arg_47_0.posStateControllerList_ = {}
	arg_47_0.posStateGoList_ = {}

	arg_47_0:DestroyModels()
end

return var_0_0
