local var_0_0 = import("game.views.qworld.stageInfo.QWorldStageInfoView")
local var_0_1 = class("SeaWarfareNormalStageInfoView", var_0_0)

function var_0_1.InitParams(arg_1_0)
	var_0_1.super.InitParams(arg_1_0)

	arg_1_0.seaWarfareStageID_ = arg_1_0.params_.seaWarfareStageID
	arg_1_0.modelDataList_ = {}
	arg_1_0.cameraParams = arg_1_0.params_.cameraParams
	arg_1_0.animTimerDic_ = {}
end

function var_0_1.LaunchBattle(arg_2_0)
	SeaWarfareTools.LaunchBattle(arg_2_0.seaWarfareStageID_)
end

function var_0_1.GetRewardCfgList(arg_3_0)
	local var_3_0 = SeaWarfareStageCfg[arg_3_0.seaWarfareStageID_].reward

	return getRewardFromDropCfg(var_3_0, true)
end

function var_0_1.OnEnter(arg_4_0)
	arg_4_0:ProcessCullDynamic()
	var_0_1.super.OnEnter(arg_4_0)
	arg_4_0:CameraEnter()
	arg_4_0:LoadModels()
	arg_4_0:PlayModelsAnim()
end

function var_0_1.ProcessCullDynamic(arg_5_0)
	QWorldMgr:CullDynamic(true, nil, {
		QWorldAgentLayer.NPC
	})
end

function var_0_1.CameraEnter(arg_6_0)
	if arg_6_0.cameraParams then
		local var_6_0 = arg_6_0.cameraParams[1]
		local var_6_1 = arg_6_0.cameraParams[2]

		QWorldMgr:EnableCustomCamera(var_6_0, var_6_1 or 1, QWorldCameraLayer.System)
	end
end

function var_0_1.OnExit(arg_7_0)
	var_0_1.super.OnExit(arg_7_0)
	arg_7_0:StopAllAnimTiemr()
	arg_7_0:CameraExit()
	arg_7_0:UnloadModel()
end

function var_0_1.CameraExit(arg_8_0)
	if arg_8_0.cameraParams then
		local var_8_0 = arg_8_0.cameraParams[1]
		local var_8_1 = arg_8_0.cameraParams[2]

		QWorldMgr:ExitCustomCameraByGroup(var_8_0, var_8_1 or 1)
	end
end

function var_0_1.LoadModels(arg_9_0)
	local var_9_0 = SeaWarfareStageCfg[arg_9_0.seaWarfareStageID_]

	if type(var_9_0.model_list) ~= "table" then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_0.model_list) do
		arg_9_0.modelDataList_[#arg_9_0.modelDataList_ + 1] = arg_9_0:CreateModelData(iter_9_1)
	end
end

function var_0_1.CreateModelData(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:InstantiateModel(arg_10_1)

	return {
		model = var_10_0,
		modelAssetPath = arg_10_0:GetModelAssetPath(arg_10_1),
		animator = var_10_0:GetComponentInChildren(typeof(Animator))
	}
end

function var_0_1.InstantiateModel(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1[2]
	local var_11_1 = arg_11_1[3]
	local var_11_2 = arg_11_1[4]
	local var_11_3 = arg_11_1[5]
	local var_11_4 = arg_11_1[6]
	local var_11_5 = arg_11_1[7]
	local var_11_6 = Vector3.New(var_11_0, var_11_1, var_11_2)
	local var_11_7 = Quaternion.Euler(var_11_3, var_11_4, var_11_5)
	local var_11_8 = arg_11_0:GetModelAssetPath(arg_11_1)
	local var_11_9 = Object.Instantiate(Asset.Load(var_11_8))

	var_11_9.transform.localPosition = var_11_6
	var_11_9.transform.localRotation = var_11_7

	return var_11_9
end

function var_0_1.GetModelAssetPath(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1[1]

	return "QWWorld/NPC/" .. var_12_0
end

function var_0_1.UnloadModel(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.modelDataList_) do
		GameObject.Destroy(iter_13_1.model)
		Asset.Unload(iter_13_1.modelAssetPath)
	end

	arg_13_0.modelDataList_ = {}
end

function var_0_1.OnClickStartBattle(arg_14_0)
	arg_14_0:Go("/seaWarfareNormalBattleReady", {
		stageID = arg_14_0.seaWarfareStageID_
	})
end

function var_0_1.OnClickBackBtn(arg_15_0)
	var_0_1.super.OnClickBackBtn(arg_15_0)
	QWorldMgr:CullDynamic(false)
end

function var_0_1.UpdateBar(arg_16_0)
	var_0_1.super.UpdateBar(arg_16_0)
	manager.windowBar:RegistBackCallBack(function()
		arg_16_0:Back()
		QWorldMgr:CullDynamic(false)
	end)
end

function var_0_1.PlayModelsAnim(arg_18_0)
	local var_18_0 = SeaWarfareStageCfg[arg_18_0.seaWarfareStageID_]

	if type(var_18_0.model_list) ~= "table" then
		return
	end

	for iter_18_0, iter_18_1 in ipairs(var_18_0.model_list) do
		local var_18_1 = iter_18_1[8]

		if var_18_1 then
			arg_18_0:PlayAnimWithCallback(arg_18_0.modelDataList_[iter_18_0].animator, var_18_1, function()
				local var_19_0 = arg_18_0.modelDataList_[iter_18_0].animator:GetCurrentAnimatorStateInfo(0).length
				local var_19_1 = SeaWarfareConst.ANIM_CROSS_FADE_TIME / var_19_0

				arg_18_0.modelDataList_[iter_18_0].animator:CrossFade("stand_female", var_19_1, 0)
			end)
		end
	end
end

function var_0_1.PlayAnimWithCallback(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0:StopTargetAnimTimer(arg_20_1)
	arg_20_1:Play(arg_20_2)

	local var_20_0 = Timer.New(function()
		local var_21_0 = arg_20_1:GetCurrentAnimatorStateInfo(0)

		if var_21_0:IsName(arg_20_2) and var_21_0.normalizedTime >= 1 then
			if arg_20_0.animTimerDic_[arg_20_1] ~= nil then
				arg_20_0.animTimerDic_[arg_20_1]:Stop()
			end

			if arg_20_3 ~= nil then
				arg_20_3()
			end
		end
	end, 0.033, -1)

	var_20_0:Start()

	arg_20_0.animTimerDic_[arg_20_1] = var_20_0
end

function var_0_1.StopAllAnimTiemr(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.animTimerDic_) do
		arg_22_0:StopTargetAnimTimer(iter_22_0)
	end

	arg_22_0.animTimerDic_ = {}
end

function var_0_1.StopTargetAnimTimer(arg_23_0, arg_23_1)
	if arg_23_0.animTimerDic_[arg_23_1] then
		arg_23_0.animTimerDic_[arg_23_1]:Stop()

		arg_23_0.animTimerDic_[arg_23_1] = nil
	end
end

return var_0_1
