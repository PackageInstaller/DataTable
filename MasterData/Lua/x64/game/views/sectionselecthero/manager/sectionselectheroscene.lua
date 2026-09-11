local var_0_0 = singletonClass("SectionSelectHeroScene")

function var_0_0:Ctor()
	self.posStateControllerList_ = {}
	self.posStateGoList_ = {}
	self.needChangeEffect_ = false
	self.needChangeEffectList_ = {}
	self.modelTransTweenDataDic_ = {}

	self:ResetModelParams()
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

function var_0_0:LoadHeroModels(arg_4_1, arg_4_2)
	if not arg_4_1 then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(self.skinIDList_) do
		if arg_4_1[iter_4_0] ~= iter_4_1 then
			self:StopLoadTargetModel(iter_4_0)
			self:DestroyTargetModel(iter_4_0)
		end
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_1) do
		self:LoadTargetModel(iter_4_2, iter_4_3, arg_4_2[iter_4_2])
	end

	if not self:IsLoadingModel() then
		self:OnAllModelLoadEnd()
	end

	self:SetALlStateGoActive(true)
end

function var_0_0:LoadTargetModel(arg_5_1, arg_5_2, arg_5_3)
	self:LoadTargetModelEx(arg_5_1, arg_5_2, function(arg_6_0, arg_6_1)
		if not arg_6_1 then
			self:DisposeVfx(arg_6_0)
		end

		self:CheckAndAttachOathRing(arg_6_0, arg_5_3)
	end)
end

function var_0_0:LoadTargetModelEx(arg_7_1, arg_7_2, arg_7_3)
	if self.skinIDList_[arg_7_1] == arg_7_2 then
		arg_7_3(self.charModelList_[arg_7_1], false)

		return
	end

	self.skinIDList_[arg_7_1] = arg_7_2

	if self.charModelList_[arg_7_1] then
		self:DestroyTargetModel(arg_7_1)
	end

	if not arg_7_2 or not SkinCfg[arg_7_2] then
		return
	end

	self:StartLoadModelEx(arg_7_2, arg_7_1, arg_7_3)
end

function var_0_0:StartLoadModelEx(arg_8_1, arg_8_2, arg_8_3)
	manager.ui:UIEventEnabled(false)
	self:StopLoadTargetModel(arg_8_2)

	self.loadingTaskList_[arg_8_2] = {
		skinID = arg_8_1
	}
	self.loadingTaskList_[arg_8_2].loadAsyncIndex = manager.resourcePool:AsyncLoad("Char/" .. SkinCfg[arg_8_1].ui_modelId, ASSET_TYPE.TPOSE, function(arg_9_0)
		SetActive(arg_9_0, false)
		self:InitModel(arg_9_0, arg_8_2)
		arg_8_3(arg_9_0, true)
		self:OnTargetModelLoadEnd(arg_9_0, arg_8_2)
	end)
end

function var_0_0:OnTargetModelLoadEnd(arg_10_1, arg_10_2)
	self.loadingTaskList_[arg_10_2] = nil

	if self.needChangeEffect_ then
		self.needChangeEffectList_[arg_10_2] = true
	end

	if not self:IsLoadingModel() then
		self:OnAllModelLoadEnd()
	end
end

function var_0_0:OnAllModelLoadEnd()
	for iter_11_0, iter_11_1 in pairs(self.charModelList_) do
		SetActive(iter_11_1, true)

		if self.needChangeEffectList_[iter_11_0] then
			self:PlayModelChangeEffect(iter_11_1)
		end
	end

	self.needChangeEffectList_ = {}

	manager.ui:UIEventEnabled(true)
	manager.notify:Invoke(SECTION_HERO_MODEL_LOADED)
end

function var_0_0:DestroyModels()
	self:StopModelTransTween()
	self:OnlyDestoryModels()
	self:ResetModelParams()
	self:SetNeedChangeEffect(false)
end

function var_0_0:OnlyDestoryModels()
	self:StopLoadModel()

	for iter_13_0, iter_13_1 in pairs(self.charModelList_) do
		self:DestroyTargetModel(iter_13_0)
	end
end

function var_0_0:StopLoadModel()
	manager.ui:UIEventEnabled(true)

	for iter_14_0, iter_14_1 in pairs(self.loadingTaskList_) do
		self:StopLoadTargetModel(iter_14_0)
	end
end

function var_0_0:StopLoadTargetModel(arg_15_1)
	if self.loadingTaskList_[arg_15_1] then
		manager.resourcePool:StopAsyncQuest(self.loadingTaskList_[arg_15_1].loadAsyncIndex)

		self.loadingTaskList_[arg_15_1] = nil
	end
end

function var_0_0:DestroyTargetModel(arg_16_1)
	if self.charModelList_[arg_16_1] then
		self:InterruptModelTween(self.charModelList_[arg_16_1])
		self:DisposeVfx(self.charModelList_[arg_16_1])
		manager.resourcePool:DestroyOrReturn(self.charModelList_[arg_16_1], ASSET_TYPE.TPOSE)
	end

	self.charModelList_[arg_16_1] = nil
end

function var_0_0:IsLoadingModel()
	return table.nums(self.loadingTaskList_) > 0
end

function var_0_0:InitModel(arg_18_1, arg_18_2)
	self.charModelList_[arg_18_2] = arg_18_1

	self:InitModelTransform(arg_18_1, arg_18_2)
end

function var_0_0:AddManagedVfx(arg_19_1, arg_19_2)
	if self.managedVfx == nil then
		self.managedVfx = {}
	end

	self.managedVfx[arg_19_1] = self.managedVfx[arg_19_1] or {}

	table.insert(self.managedVfx[arg_19_1], arg_19_2)
end

function var_0_0:DisposeVfx(arg_20_1)
	local var_20_0 = nullable(self.managedVfx, arg_20_1)

	if var_20_0 then
		for iter_20_0, iter_20_1 in ipairs(var_20_0) do
			LuaForUtil.StopEffect(iter_20_1)
		end

		self.managedVfx[arg_20_1] = nil
	end
end

function var_0_0:DisposeAllVfx()
	if self.managedVfx then
		for iter_21_0, iter_21_1 in pairs(self.managedVfx) do
			for iter_21_2, iter_21_3 in pairs(iter_21_1) do
				LuaForUtil.StopEffect(iter_21_3)
			end
		end

		self.managedVfx = nil
	end
end

function var_0_0:CheckAndAttachOathRing(arg_22_1, arg_22_2)
	if arg_22_2:IsHeroOath() then
		self:AttachOathRing(arg_22_1)
	end
end

function var_0_0:AttachOathRing(arg_23_1)
	self:AddManagedVfx(arg_23_1, (LuaForUtil.PlayAttachEffect(LuaForUtil.GetRoleAttachPoint(arg_23_1.transform, OathTools.OathRingAttachPoint), OathTools.OathRingAssetPath, Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), true, 1, 0, math.huge)))
end

function var_0_0:InitModelTransform(arg_24_1, arg_24_2)
	self:UpdateModelTrans(arg_24_1, arg_24_2)
end

function var_0_0:UpdateModelTrans(arg_25_1, arg_25_2, arg_25_3)
	if arg_25_1 then
		if not arg_25_3 then
			arg_25_1.transform.localEulerAngles = SectionSelectHeroConst.HeroModelTransform[arg_25_2].rotation
			arg_25_1.transform.localPosition = SectionSelectHeroConst.HeroModelTransform[arg_25_2].position
			arg_25_1.transform.localScale = SectionSelectHeroConst.HeroModelTransform[arg_25_2].scale
		else
			self:StartModelTransTween(arg_25_1, arg_25_2)
		end
	end
end

function var_0_0:StartModelTransTween(arg_26_1, arg_26_2)
	if self.modelTransTweenDataDic_[arg_26_1] then
		self:InterruptModelTween(arg_26_1)
	end

	local var_26_0 = {}

	self.modelTransTweenDataDic_[arg_26_1] = var_26_0
	var_26_0.modelTrans = arg_26_1.transform
	var_26_0.originRotation = arg_26_1.transform.localRotation
	var_26_0.originPosition = arg_26_1.transform.localPosition
	var_26_0.originScale = arg_26_1.transform.localScale
	var_26_0.targetRotation = Quaternion.Euler(SectionSelectHeroConst.HeroModelTransform[arg_26_2].rotation.x, SectionSelectHeroConst.HeroModelTransform[arg_26_2].rotation.y, SectionSelectHeroConst.HeroModelTransform[arg_26_2].rotation.z)
	var_26_0.targetPosition = SectionSelectHeroConst.HeroModelTransform[arg_26_2].position
	var_26_0.targetScale = SectionSelectHeroConst.HeroModelTransform[arg_26_2].scale
	var_26_0.leanTween = LeanTween.value(0, 1, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
		self:OnUpdateModelTransTween(arg_27_0, arg_26_1)
	end)):setOnComplete(System.Action(function()
		self:OnCompleteModelTransTween(arg_26_1)
	end)):setEase(LeanTweenType.easeOutCubic)
end

function var_0_0:StopModelTransTween(arg_29_1, arg_29_2)
	if self.modelTransTweenDataDic_[arg_29_1] then
		self:InterruptModelTween(arg_29_1)
	end
end

function var_0_0:InterruptModelTween(arg_30_1)
	if self.modelTransTweenDataDic_[arg_30_1] then
		LeanTween.cancel(self.modelTransTweenDataDic_[arg_30_1].leanTween.id)
		self.modelTransTweenDataDic_[arg_30_1].leanTween:setOnUpdate(nil):setOnComplete(nil)

		self.modelTransTweenDataDic_[arg_30_1].leanTween = nil
		self.modelTransTweenDataDic_[arg_30_1] = nil
	end
end

function var_0_0:OnUpdateModelTransTween(arg_31_1, arg_31_2)
	if not self.modelTransTweenDataDic_[arg_31_2] then
		return
	end

	local var_31_0 = self.modelTransTweenDataDic_[arg_31_2]

	self.modelTransTweenDataDic_[arg_31_2].modelTrans.localRotation = Quaternion.Lerp(self.modelTransTweenDataDic_[arg_31_2].originRotation, self.modelTransTweenDataDic_[arg_31_2].targetRotation, arg_31_1)
	self.modelTransTweenDataDic_[arg_31_2].modelTrans.localPosition = Vector3.Lerp(var_31_0.originPosition, var_31_0.targetPosition, arg_31_1)
	self.modelTransTweenDataDic_[arg_31_2].modelTrans.localScale = Vector3.Lerp(var_31_0.originScale, var_31_0.targetScale, arg_31_1)
end

function var_0_0:OnCompleteModelTransTween(arg_32_1)
	if not self.modelTransTweenDataDic_[arg_32_1] then
		return
	end

	local var_32_0 = self.modelTransTweenDataDic_[arg_32_1]

	if not isNil(self.modelTransTweenDataDic_[arg_32_1].modelTrans) then
		self.modelTransTweenDataDic_[arg_32_1].modelTrans.localRotation = var_32_0.targetRotation
		self.modelTransTweenDataDic_[arg_32_1].modelTrans.localPosition = var_32_0.targetPosition
		self.modelTransTweenDataDic_[arg_32_1].modelTrans.localScale = var_32_0.targetScale
	end

	var_32_0.modelTrans = nil

	LeanTween.cancel(var_32_0.leanTween.id)
	var_32_0.leanTween:setOnUpdate(nil):setOnComplete(nil)

	var_32_0.leanTween = nil
	self.modelTransTweenDataDic_[arg_32_1] = nil
end

function var_0_0.PlayModelChangeEffect(arg_33_0, arg_33_1)
	LuaForUtil.PlayEffect(arg_33_1.transform, SectionSelectHeroConst.HERO_CHANGE_FX_PATH, Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
end

function var_0_0:ReorderModelByPosList(arg_34_1)
	local var_34_0 = {}
	local var_34_1 = {}

	for iter_34_0, iter_34_1 in pairs(arg_34_1) do
		var_34_1[iter_34_0], var_34_0[iter_34_0] = self.skinIDList_[iter_34_1], self.charModelList_[iter_34_1]

		self:InitModelTransform(self.charModelList_[iter_34_1], iter_34_0)
	end

	self.charModelList_ = {}
	self.skinIDList_ = {}
end

function var_0_0:GetModel(arg_35_1)
	return self.charModelList_[arg_35_1]
end

function var_0_0:GetModelLocalPosition(arg_36_1)
	if self.charModelList_[arg_36_1] then
		return self.charModelList_[arg_36_1].transform.localPosition
	else
		return nil
	end
end

function var_0_0:SetModelLocalPosition(arg_37_1, arg_37_2)
	if self.charModelList_[arg_37_1] then
		self.charModelList_[arg_37_1].transform.localPosition = arg_37_2
	end
end

function var_0_0:SetModelLocalRotation(arg_38_1, arg_38_2)
	if self.charModelList_[arg_38_1] then
		self.charModelList_[arg_38_1].transform.localRotation = Quaternion.Euler(arg_38_2)
	end
end

function var_0_0:OnlyDisplayModel(arg_39_1)
	for iter_39_0, iter_39_1 in pairs(self.charModelList_) do
		SetActive(iter_39_1, iter_39_0 == arg_39_1)
	end
end

function var_0_0:DisplayAllModel()
	for iter_40_0, iter_40_1 in pairs(self.charModelList_) do
		SetActive(iter_40_1, true)
	end
end

function var_0_0:GetModelPowerPointScreenPos(arg_41_1)
	if self.charModelList_[arg_41_1] then
		local var_41_0 = self.charModelList_[arg_41_1]:GetHeorModelAttachPointTrans("Bip001 Head")

		if var_41_0 then
			local var_41_1 = UnityEngine.Camera.main:WorldToScreenPoint(var_41_0.position)

			var_41_1.y = var_41_1.y + SectionSelectHeroTools.GetRuntimeScreenOffsetOfHeroInfoItem()

			return var_41_1
		end
	end

	return nil
end

function var_0_0:RefreshPositionState(arg_42_1, arg_42_2)
	if isNil(self.posStateControllerList_[arg_42_1]) then
		self:RebindController(arg_42_1)
	end

	if not isNil(self.posStateControllerList_[arg_42_1]) then
		self.posStateControllerList_[arg_42_1]:SetSelectedState(arg_42_2)
	end
end

function var_0_0:RebindController(arg_43_1)
	local var_43_0 = self:GetStateGo(arg_43_1)

	if var_43_0 then
		self.posStateControllerList_[arg_43_1] = var_43_0:GetComponent("ControllerExCollection"):GetController("state")
	end
end

function var_0_0:SetALlStateGoActive(arg_44_1)
	for iter_44_0 = 1, 3 do
		SetActive(self:GetStateGo(iter_44_0), arg_44_1)
	end
end

function var_0_0:GetStateGo(arg_45_1)
	if isNil(self.posStateGoList_[arg_45_1]) then
		self.posStateGoList_[arg_45_1] = GameObject.Find(string.format("X104/X104_SceneSteps/X104_Formation_HeroPos_%s", arg_45_1))
	end

	return self.posStateGoList_[arg_45_1]
end

function var_0_0:GetStateGoScreenPos(arg_46_1)
	local var_46_0 = self:GetStateGo(arg_46_1)

	if var_46_0 then
		return UnityEngine.Camera.main:WorldToScreenPoint(var_46_0.transform.position)
	end

	return nil
end

function var_0_0:Dispose()
	self.posStateControllerList_ = {}
	self.posStateGoList_ = {}

	self:DestroyModels()
end

return var_0_0
