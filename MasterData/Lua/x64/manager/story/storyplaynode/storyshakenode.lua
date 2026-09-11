local StoryShakeNode = class("StoryShakeNode", require("manager/story/StoryPlayNode/StoryPlayBaseNode"))
local var_0_1 = math.sin
local var_0_2 = Mathf.Deg2Rad

function StoryShakeNode:OnCtor(arg_1_1)
	self.actorTrans_ = nil
	self.actorType_ = StoryPlayerConst.ACTOR_TYPE.None
	self.actorName_ = ""
	self.assetPath_ = ""
	self.shakeTarget_ = StoryPlayerConst.SHAKE_TARGET.NONE
	self.offset_ = Vector3.zero
	self.frequency_ = 0
	self.originalPos_ = Vector3.zero
	self.originalRotation_ = Quaternion.identity
	self.noiseSettingsAssetPath_ = ""
	self.amplitudeGain_ = 1
	self.frequencyGain_ = 1
end

function StoryShakeNode:SetConfig(arg_2_1)
	StoryShakeNode.super.SetConfig(self, arg_2_1)

	self.actorType_ = arg_2_1.actorType
	self.actorName_ = arg_2_1.actorName
	self.assetPath_ = arg_2_1.assetPath
	self.shakeTarget_ = arg_2_1.shakeTarget
	self.offset_ = arg_2_1.offset
	self.frequency_ = arg_2_1.frequency

	if self.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.CAMERA then
		self.noiseSettingsAssetPath_ = arg_2_1.noiseSettingsAssetPath
		self.amplitudeGain_ = arg_2_1.amplitudeGain
		self.frequencyGain_ = arg_2_1.frequencyGain
	end
end

function StoryShakeNode:OnPlay()
	self:InitActorTrans()

	if self.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.CAMERA then
		self:InitCinemachineShake()
	end
end

function StoryShakeNode:OnUpdate()
	if self.actorTrans_ == nil then
		return
	end

	self:UpdateShake()
end

function StoryShakeNode:OnFinish()
	self:ResetShake()

	if self.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.CAMERA then
		LuaForUtil.UpdateCameraSetting()
	end
end

function StoryShakeNode:InitActorTrans()
	if self.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.CAMERA then
		self.actorTrans_ = manager.ui.mainCamera.transform
	elseif self.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.DIALOG then
		self.actorTrans_ = self.storyPlayer_.dialog_.transform
	elseif self.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.DIALOG_HEAD then
		self.actorTrans_ = self.storyPlayer_.iconTrs_
	else
		local var_6_0 = self.storyPlayer_:GetActorGo(self.actorType_, self.actorName_, self.assetPath_)

		if var_6_0 ~= nil then
			self.actorTrans_ = var_6_0.transform
		end
	end

	if self.actorTrans_ ~= nil then
		self.originalPos_ = self.actorTrans_.localPosition
		self.originalRotation_ = self.actorTrans_.localRotation
	end
end

function StoryShakeNode:InitCinemachineShake()
	manager.ui:SetMainCameraCom("CinemachineBrain", true)

	local var_7_0 = self.storyPlayer_:GetCurVirtualCamera()

	SetActive(var_7_0.gameObject, true)
	self.storyPlayer_:InitVirtualCamera()
	LuaForUtil.SetVCMNoise(var_7_0, self.noiseSettingsAssetPath_, self.amplitudeGain_, self.frequencyGain_)
end

function StoryShakeNode:UpdateShake()
	if self.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.CAMERA then
		return
	end

	self.actorTrans_.localPosition = self.originalPos_ + self.offset_ * var_0_1(self:GetCurTime() * self.frequency_ * 360 * var_0_2)
end

function StoryShakeNode:ResetShake()
	self:ResetActor()

	if self.shakeTarget_ == StoryPlayerConst.SHAKE_TARGET.CAMERA then
		self:ResetCinemachineShake()
	end
end

function StoryShakeNode:ResetActor()
	if self.actorTrans_ == nil then
		return
	end

	self.actorTrans_.localPosition = self.originalPos_
	self.actorTrans_.localRotation = self.originalRotation_
	self.actorTrans_ = nil
end

function StoryShakeNode:ResetCinemachineShake()
	Asset.Unload(self.noiseSettingsAssetPath_)

	local var_11_0 = self.storyPlayer_:GetCurVirtualCamera()

	LuaForUtil.SetVCMNoise(var_11_0)
	SetActive(var_11_0.gameObject, false)
	manager.ui:SetMainCameraCom("CinemachineBrain", false)
end

return StoryShakeNode
