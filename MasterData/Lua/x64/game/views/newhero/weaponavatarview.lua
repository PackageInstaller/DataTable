local WeaponAvatarView = class("WeaponAvatarView", ReduxView)
local var_0_1 = {
	weapon = 2,
	hero = 1
}

function WeaponAvatarView:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function WeaponAvatarView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeaponAvatarView:InitUI()
	self.playable_ = self:FindCom(typeof(PlayableDirector), "")
	self.backGo_ = self:FindGo("back")
end

function WeaponAvatarView:AddUIListener()
	if self.backGo_ then
		self:AddDragListener(self.backGo_, function()
			self.startRot_ = self.weaponModel_ and self.rotateNode_ and self.rotateNode_.localEulerAngles or Vector3.zero
			self.lastRotateY_ = nil
			self.lastDeltaX_ = 0
		end, function(arg_6_0, arg_6_1)
			if self.weaponModel_ and self.rotateNode_ then
				local var_6_0 = self.lastRotateY_ or self.rotateNode_.localEulerAngles.y
				local var_6_1 = var_6_0 + (arg_6_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_6_0

				if var_6_0 + (arg_6_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_6_0 < -HeroConst.MAX_RORATE_ANGLE then
					var_6_1 = -HeroConst.MAX_RORATE_ANGLE
				elseif var_6_0 + (arg_6_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_6_0 > HeroConst.MAX_RORATE_ANGLE then
					var_6_1 = HeroConst.MAX_RORATE_ANGLE
				end

				self.lastRotateY_ = var_6_0 + var_6_1
				self.lastDeltaX_ = arg_6_0
				self.rotateNode_.localRotation = Quaternion.RotateTowards(self.rotateNode_.localRotation, Quaternion.Euler(self.startRot_.x, var_6_0 + var_6_1, self.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
			end
		end)
	end
end

function WeaponAvatarView:OnEnter(arg_7_1)
	self.type_ = arg_7_1

	self:InitBackScene(arg_7_1)
end

function WeaponAvatarView:OnExit()
	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)
	end

	self:Finish()
end

function WeaponAvatarView:SetWeaponID(arg_9_1)
	if self.weaponID_ == SkinCfg[arg_9_1].id then
		return
	end

	self:Finish()
	self:LoadModel(SkinCfg[arg_9_1].id)

	self.weaponID_ = SkinCfg[arg_9_1].id
end

function WeaponAvatarView:ShowWeaponModel(arg_10_1)
	if self.weaponModel_ then
		SetActive(self.weaponModel_, arg_10_1)
	end

	SetActive(self.backGo_, arg_10_1)
end

function WeaponAvatarView:InitBackScene(arg_11_1)
	if arg_11_1 == var_0_1.hero then
		return
	end

	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	local var_11_0
	local var_11_1

	if arg_11_1 == var_0_1.weapon then
		var_11_0 = GameDisplayCfg.weapon_background_pos.value
		var_11_1 = CameraCfg.weapon.pictureName
	elseif arg_11_1 == var_0_1.hero then
		var_11_0 = GameDisplayCfg.hero_modelld_background_pos.value
		var_11_1 = CameraCfg.hero.pictureName
	end

	self.backGroundTrs_.localPosition = Vector3(var_11_0[1], var_11_0[2], var_11_0[3])
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.Bg.path .. var_11_1)
end

function WeaponAvatarView:Finish()
	if self.animator_ then
		if self.playable_ then
			self.playable_:Stop()
		end

		local var_12_0 = self.animator_.gameObject:GetComponent("LipSync")

		if var_12_0 then
			var_12_0:ResetEmotion(0)
		end
	end

	self.weaponID_ = nil

	if self.weaponModel_ then
		manager.resourcePool:DestroyOrReturn(self.weaponModel_, ASSET_TYPE.WEAPON)

		self.weaponModel_ = nil
		self.animator_ = nil
		self.actionTimer_ = nil
		self.actioning_ = false
		self.weapomNode_ = nil
		self.weapomNode2_ = nil
		self.weapomNode3_ = nil
	end
end

function WeaponAvatarView:InitModel(arg_13_1, arg_13_2)
	self.weaponModel_ = arg_13_1
	self.animator_ = self:FindCom(typeof(Animator), "", self.weaponModel_.transform)

	if self.animator_ == nil then
		-- block empty
	end

	self.rotateNode_ = self.weaponModel_.transform
	self.rotateNode_.localEulerAngles = Vector3.zero
end

function WeaponAvatarView:LoadModel(arg_14_1)
	local var_14_0 = SkinCfg[arg_14_1]
	local var_14_1 = manager.resourcePool:Get("Weapon/" .. SkinCfg[arg_14_1].weapon_modelId, ASSET_TYPE.WEAPON)
	local var_14_2
	local var_14_3

	if self.type_ == 1 then
		var_14_2 = GameDisplayCfg.weapon_pos1.value
		var_14_3 = GameDisplayCfg.weapon_rot1.value
	elseif self.type_ == 2 then
		var_14_2 = GameDisplayCfg.weapon_pos1.value
		var_14_3 = GameDisplayCfg.weapon_rot1.value
	end

	var_14_1.transform.localPosition = Vector3(var_14_2[1], var_14_2[2], var_14_2[3])
	var_14_1.transform.localEulerAngles = Vector3(var_14_3[1], var_14_3[2], var_14_3[3])
	var_14_1.transform.localScale = Vector3(1, 1, 1)

	self:InitModel(var_14_1, var_14_0.id)
end

function WeaponAvatarView:Dispose()
	self:RemoveAllListeners()
	self:Finish()
	WeaponAvatarView.super.Dispose(self)
end

return WeaponAvatarView
