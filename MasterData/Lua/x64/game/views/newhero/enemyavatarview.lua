local EnemyAvatarView = class("EnemyAvatarView", ReduxView)

function EnemyAvatarView:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function EnemyAvatarView:Init()
	if EnemyAvatarView.outlinePropID == nil then
		EnemyAvatarView.outlinePropID = UnityEngine.Shader.PropertyToID("_OutlineThickness")
	end

	self:InitUI()
	self:AddUIListener()
end

function EnemyAvatarView:InitUI()
	self.playable_ = self:FindCom(typeof(PlayableDirector), "")
	self.backGo_ = self:FindGo("back")
end

function EnemyAvatarView:AddUIListener()
	self:AddDragListener(self.backGo_, function()
		self.startRot_ = self.bossModel_ and self.rotaNote_.localEulerAngles or Vector3.zero
		self.lastDeltaX_ = 0
	end, function(arg_6_0, arg_6_1)
		if self.bossModel_ then
			local var_6_0 = self.lastRotateY_ or self.rotaNote_.localEulerAngles.y

			if var_6_0 > 180 then
				var_6_0 = var_6_0 - 360
			end

			local var_6_1 = var_6_0 + (arg_6_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_6_0

			if var_6_0 + (arg_6_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_6_0 < -HeroConst.MAX_RORATE_ANGLE then
				var_6_1 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_6_0 + (arg_6_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_6_0 > HeroConst.MAX_RORATE_ANGLE then
				var_6_1 = HeroConst.MAX_RORATE_ANGLE
			end

			local var_6_2 = var_6_0 + var_6_1

			if var_6_0 + var_6_1 < self.rot_limit_[1] then
				var_6_2 = self.rot_limit_[1]
			elseif var_6_2 > self.rot_limit_[2] then
				var_6_2 = self.rot_limit_[2]
			end

			self.lastRotateY_ = var_6_2
			self.lastDeltaX_ = arg_6_0
			self.rotaNote_.localRotation = Quaternion.RotateTowards(self.rotaNote_.localRotation, Quaternion.Euler(self.startRot_.x, var_6_2, self.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function EnemyAvatarView:OnEnter()
	self:InitBackScene()
end

function EnemyAvatarView:OnExit()
	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)
	end

	self:Finish()

	self.lastRotateY_ = nil
end

function EnemyAvatarView:SetBossID(arg_9_1)
	if self.bossID_ == arg_9_1 then
		return
	end

	self:Finish()
	self:LoadModel(arg_9_1)

	self.bossID_ = arg_9_1
end

function EnemyAvatarView:ShowBossModel(arg_10_1)
	if self.bossModel_ then
		SetActive(self.bossModel_, arg_10_1)
	end
end

function EnemyAvatarView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(GameDisplayCfg.collect_monster_background_pos.value[1], GameDisplayCfg.collect_monster_background_pos.value[2], GameDisplayCfg.collect_monster_background_pos.value[3])
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(GameDisplayCfg.collect_monster_background_pos.scale[1], GameDisplayCfg.collect_monster_background_pos.scale[2], GameDisplayCfg.collect_monster_background_pos.scale[3])
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.Bg.path .. CameraCfg.enemyFile.pictureName)
end

function EnemyAvatarView:Finish()
	if self.animator_ then
		if self.playable_ then
			self.playable_:Stop()
		end

		local var_12_0 = self.animator_.gameObject:GetComponent("LipSync")

		if var_12_0 then
			var_12_0:ResetEmotion(0)
		end
	end

	self.bossID_ = nil

	if self.bossModel_ then
		manager.resourcePool:DestroyOrReturn(self.bossModel_, ASSET_TYPE.TPOSE)

		self.bossModel_ = nil
		self.animator_ = nil
		self.actionTimer_ = nil
		self.actioning_ = false
	end
end

function EnemyAvatarView:AdjustOutlineThickness(arg_13_1, arg_13_2)
	if isNil(arg_13_1) or EnemyAvatarView.outlinePropID == nil then
		return
	end

	local var_13_0 = UnityEngine.MaterialPropertyBlock.New()
	local var_13_1 = arg_13_1:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for iter_13_0 = 0, var_13_1.Length - 1 do
		var_13_1[iter_13_0]:GetPropertyBlock(var_13_0)

		for iter_13_1 = 0, var_13_1[iter_13_0].sharedMaterials.Length - 1 do
			if var_13_1[iter_13_0].sharedMaterials[iter_13_1]:HasProperty(EnemyAvatarView.outlinePropID) then
				var_13_0:SetFloat(EnemyAvatarView.outlinePropID, var_13_1[iter_13_0].sharedMaterials[iter_13_1]:GetFloat(EnemyAvatarView.outlinePropID) * arg_13_2)
				var_13_1[iter_13_0]:SetPropertyBlock(var_13_0, iter_13_1)
			end
		end
	end
end

function EnemyAvatarView:InitModel(arg_14_1, arg_14_2)
	self.bossModel_ = arg_14_1
	self.rotaNote_ = arg_14_1.transform
	self.animator_ = self:FindCom(typeof(Animator), "", self.bossModel_.transform)

	if self.animator_ == nil then
		-- block empty
	end

	self:FindCom(typeof(CharacterEffect), "", self.bossModel_.transform):ForceUpdate()
end

function EnemyAvatarView:LoadModel(arg_15_1)
	local var_15_0 = manager.resourcePool:Get("Char/" .. MonsterCfg[arg_15_1].model_name, ASSET_TYPE.TPOSE)

	self.rot_limit_ = CollectMonsterCfg[arg_15_1].model_rot_limit or {
		-180,
		180
	}
	var_15_0.transform.localPosition = Vector3(CollectMonsterCfg[arg_15_1].model_pos[1][1], CollectMonsterCfg[arg_15_1].model_pos[1][2], CollectMonsterCfg[arg_15_1].model_pos[1][3])
	var_15_0.transform.localEulerAngles = Vector3(CollectMonsterCfg[arg_15_1].model_rot[1][1], CollectMonsterCfg[arg_15_1].model_rot[1][2], CollectMonsterCfg[arg_15_1].model_rot[1][3])
	var_15_0.transform.localScale = Vector3(CollectMonsterCfg[arg_15_1].model_scale[1][1], CollectMonsterCfg[arg_15_1].model_scale[1][2], CollectMonsterCfg[arg_15_1].model_scale[1][3])

	self:InitModel(var_15_0, CollectMonsterCfg[arg_15_1].id)
	self:AdjustOutlineThickness(var_15_0, CollectMonsterCfg[arg_15_1].model_scale[1][1])
end

function EnemyAvatarView:Dispose()
	self:RemoveAllListeners()
	self:Finish()
	EnemyAvatarView.super.Dispose(self)
end

return EnemyAvatarView
