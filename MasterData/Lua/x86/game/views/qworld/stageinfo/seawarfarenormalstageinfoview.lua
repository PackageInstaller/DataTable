local SeaWarfareNormalStageInfoView = class("SeaWarfareNormalStageInfoView", (import("game.views.qworld.stageInfo.QWorldStageInfoView")))

function SeaWarfareNormalStageInfoView:InitParams()
	SeaWarfareNormalStageInfoView.super.InitParams(self)

	self.seaWarfareStageID_ = self.params_.seaWarfareStageID
	self.modelDataList_ = {}
	self.cameraParams = self.params_.cameraParams
	self.animTimerDic_ = {}
end

function SeaWarfareNormalStageInfoView:LaunchBattle()
	SeaWarfareTools.LaunchBattle(self.seaWarfareStageID_)
end

function SeaWarfareNormalStageInfoView:GetRewardCfgList()
	return getRewardFromDropCfg(SeaWarfareStageCfg[self.seaWarfareStageID_].reward, true)
end

function SeaWarfareNormalStageInfoView:OnEnter()
	self:ProcessCullDynamic()
	SeaWarfareNormalStageInfoView.super.OnEnter(self)
	self:CameraEnter()
	self:LoadModels()
	self:PlayModelsAnim()
end

function SeaWarfareNormalStageInfoView:ProcessCullDynamic()
	QWorldMgr:CullDynamic(true, nil, {
		QWorldAgentLayer.NPC
	})
end

function SeaWarfareNormalStageInfoView:CameraEnter()
	if self.cameraParams then
		QWorldMgr:EnableCustomCamera(self.cameraParams[1], self.cameraParams[2] or 1, QWorldCameraLayer.System)
	end
end

function SeaWarfareNormalStageInfoView:OnExit()
	SeaWarfareNormalStageInfoView.super.OnExit(self)
	self:StopAllAnimTiemr()
	self:CameraExit()
	self:UnloadModel()
end

function SeaWarfareNormalStageInfoView:CameraExit()
	if self.cameraParams then
		QWorldMgr:ExitCustomCameraByGroup(self.cameraParams[1], self.cameraParams[2] or 1)
	end
end

function SeaWarfareNormalStageInfoView:LoadModels()
	if type(SeaWarfareStageCfg[self.seaWarfareStageID_].model_list) ~= "table" then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(SeaWarfareStageCfg[self.seaWarfareStageID_].model_list) do
		self.modelDataList_[#self.modelDataList_ + 1] = self:CreateModelData(iter_9_1)
	end
end

function SeaWarfareNormalStageInfoView:CreateModelData(arg_10_1)
	local var_10_0 = self:InstantiateModel(arg_10_1)

	return {
		model = var_10_0,
		modelAssetPath = self:GetModelAssetPath(arg_10_1),
		animator = var_10_0:GetComponentInChildren(typeof(Animator))
	}
end

function SeaWarfareNormalStageInfoView:InstantiateModel(arg_11_1)
	local var_11_0 = Object.Instantiate(Asset.Load((self:GetModelAssetPath(arg_11_1))))

	var_11_0.transform.localPosition = Vector3.New(arg_11_1[2], arg_11_1[3], arg_11_1[4])
	var_11_0.transform.localRotation = Quaternion.Euler(arg_11_1[5], arg_11_1[6], arg_11_1[7])

	return var_11_0
end

function SeaWarfareNormalStageInfoView:GetModelAssetPath(arg_12_1)
	return "QWWorld/NPC/" .. arg_12_1[1]
end

function SeaWarfareNormalStageInfoView:UnloadModel()
	for iter_13_0, iter_13_1 in ipairs(self.modelDataList_) do
		GameObject.Destroy(iter_13_1.model)
		Asset.Unload(iter_13_1.modelAssetPath)
	end

	self.modelDataList_ = {}
end

function SeaWarfareNormalStageInfoView:OnClickStartBattle()
	self:Go("/seaWarfareNormalBattleReady", {
		stageID = self.seaWarfareStageID_
	})
end

function SeaWarfareNormalStageInfoView:OnClickBackBtn()
	SeaWarfareNormalStageInfoView.super.OnClickBackBtn(self)
	QWorldMgr:CullDynamic(false)
end

function SeaWarfareNormalStageInfoView:UpdateBar()
	SeaWarfareNormalStageInfoView.super.UpdateBar(self)
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
		QWorldMgr:CullDynamic(false)
	end)
end

function SeaWarfareNormalStageInfoView:PlayModelsAnim()
	if type(SeaWarfareStageCfg[self.seaWarfareStageID_].model_list) ~= "table" then
		return
	end

	for iter_18_0, iter_18_1 in ipairs(SeaWarfareStageCfg[self.seaWarfareStageID_].model_list) do
		if iter_18_1[8] then
			self:PlayAnimWithCallback(self.modelDataList_[iter_18_0].animator, iter_18_1[8], function()
				self.modelDataList_[iter_18_0].animator:CrossFade("stand_female", SeaWarfareConst.ANIM_CROSS_FADE_TIME / self.modelDataList_[iter_18_0].animator:GetCurrentAnimatorStateInfo(0).length, 0)
			end)
		end
	end
end

function SeaWarfareNormalStageInfoView:PlayAnimWithCallback(arg_20_1, arg_20_2, arg_20_3)
	self:StopTargetAnimTimer(arg_20_1)
	arg_20_1:Play(arg_20_2)

	local var_20_0 = Timer.New(function()
		local var_21_0 = arg_20_1:GetCurrentAnimatorStateInfo(0)

		if var_21_0:IsName(arg_20_2) and var_21_0.normalizedTime >= 1 then
			if self.animTimerDic_[arg_20_1] ~= nil then
				self.animTimerDic_[arg_20_1]:Stop()
			end

			if arg_20_3 ~= nil then
				arg_20_3()
			end
		end
	end, 0.033, -1)

	var_20_0:Start()

	self.animTimerDic_[arg_20_1] = var_20_0
end

function SeaWarfareNormalStageInfoView:StopAllAnimTiemr()
	for iter_22_0, iter_22_1 in pairs(self.animTimerDic_) do
		self:StopTargetAnimTimer(iter_22_0)
	end

	self.animTimerDic_ = {}
end

function SeaWarfareNormalStageInfoView:StopTargetAnimTimer(arg_23_1)
	if self.animTimerDic_[arg_23_1] then
		self.animTimerDic_[arg_23_1]:Stop()

		self.animTimerDic_[arg_23_1] = nil
	end
end

return SeaWarfareNormalStageInfoView
