local var_0_0 = class("StoryShakeNode", require("manager/story/StoryPlayNode/StoryPlayBaseNode"))
local var_0_1 = math.sin
local var_0_2 = Mathf.Deg2Rad

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.actorTrans_ = nil
	arg_1_0.actorType_ = StoryPlayerConst.ACTOR_TYPE.None
	arg_1_0.actorName_ = ""
	arg_1_0.assetPath_ = ""
	arg_1_0.shakeTarget_ = StoryPlayerConst.SHAKE_TARGET.NONE
	arg_1_0.offset_ = Vector3.zero
	arg_1_0.frequency_ = 0
	arg_1_0.originalPos_ = Vector3.zero
	arg_1_0.originalRotation_ = Quaternion.identity
	arg_1_0.noiseSettingsAssetPath_ = ""
	arg_1_0.amplitudeGain_ = 1
	arg_1_0.frequencyGain_ = 1
end

function var_0_0.SetConfig(arg_2_0, arg_2_1)
	var_0_0.super.SetConfig(arg_2_0, arg_2_1)

	arg_2_0.actorType_ = arg_2_1.actorType
	arg_2_0.actorName_ = arg_2_1.actorName
	arg_2_0.assetPath_ = arg_2_1.assetPath
	arg_2_0.shakeTarget_ = arg_2_1.shakeTarget
	arg_2_0.offset_ = arg_2_1.offset
	arg_2_0.frequency_ = arg_2_1.frequency

	if arg_2_0.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.CAMERA then
		arg_2_0.noiseSettingsAssetPath_ = arg_2_1.noiseSettingsAssetPath
		arg_2_0.amplitudeGain_ = arg_2_1.amplitudeGain
		arg_2_0.frequencyGain_ = arg_2_1.frequencyGain
	end
end

function var_0_0.OnPlay(arg_3_0)
	arg_3_0:InitActorTrans()

	if arg_3_0.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.CAMERA then
		arg_3_0:InitCinemachineShake()
	end
end

function var_0_0.OnUpdate(arg_4_0)
	if arg_4_0.actorTrans_ == nil then
		return
	end

	arg_4_0:UpdateShake()
end

function var_0_0.OnFinish(arg_5_0)
	arg_5_0:ResetShake()

	if arg_5_0.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.CAMERA then
		LuaForUtil.UpdateCameraSetting()
	end
end

function var_0_0.InitActorTrans(arg_6_0)
	if arg_6_0.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.CAMERA then
		arg_6_0.actorTrans_ = manager.ui.mainCamera.transform
	elseif arg_6_0.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.DIALOG then
		arg_6_0.actorTrans_ = arg_6_0.storyPlayer_.dialog_.transform
	elseif arg_6_0.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.DIALOG_HEAD then
		arg_6_0.actorTrans_ = arg_6_0.storyPlayer_.iconTrs_
	else
		local var_6_0 = arg_6_0.storyPlayer_:GetActorGo(arg_6_0.actorType_, arg_6_0.actorName_, arg_6_0.assetPath_)

		if var_6_0 ~= nil then
			arg_6_0.actorTrans_ = var_6_0.transform
		end
	end

	if arg_6_0.actorTrans_ ~= nil then
		arg_6_0.originalPos_ = arg_6_0.actorTrans_.localPosition
		arg_6_0.originalRotation_ = arg_6_0.actorTrans_.localRotation
	end
end

function var_0_0.InitCinemachineShake(arg_7_0)
	manager.ui:SetMainCameraCom("CinemachineBrain", true)

	local var_7_0 = arg_7_0.storyPlayer_:GetCurVirtualCamera()

	SetActive(var_7_0.gameObject, true)
	arg_7_0.storyPlayer_:InitVirtualCamera()
	LuaForUtil.SetVCMNoise(var_7_0, arg_7_0.noiseSettingsAssetPath_, arg_7_0.amplitudeGain_, arg_7_0.frequencyGain_)
end

function var_0_0.UpdateShake(arg_8_0)
	if arg_8_0.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.CAMERA then
		return
	end

	local var_8_0 = arg_8_0:GetCurTime() * arg_8_0.frequency_ * 360
	local var_8_1 = var_0_1(var_8_0 * var_0_2)

	arg_8_0.actorTrans_.localPosition = arg_8_0.originalPos_ + arg_8_0.offset_ * var_8_1
end

function var_0_0.ResetShake(arg_9_0)
	arg_9_0:ResetActor()

	if arg_9_0.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.CAMERA then
		arg_9_0:ResetCinemachineShake()
	end
end

function var_0_0.ResetActor(arg_10_0)
	if arg_10_0.actorTrans_ == nil then
		return
	end

	arg_10_0.actorTrans_.localPosition = arg_10_0.originalPos_
	arg_10_0.actorTrans_.localRotation = arg_10_0.originalRotation_
	arg_10_0.actorTrans_ = nil
end

function var_0_0.ResetCinemachineShake(arg_11_0)
	Asset.Unload(arg_11_0.noiseSettingsAssetPath_)

	local var_11_0 = arg_11_0.storyPlayer_:GetCurVirtualCamera()

	LuaForUtil.SetVCMNoise(var_11_0)
	SetActive(var_11_0.gameObject, false)
	manager.ui:SetMainCameraCom("CinemachineBrain", false)
end

return var_0_0
