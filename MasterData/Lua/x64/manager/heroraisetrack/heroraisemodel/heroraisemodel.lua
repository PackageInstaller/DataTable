local HeroRaiseModel = class("HeroRaiseModel")

function HeroRaiseModel:Ctor()
	self.skinID = nil
	self.modelID = nil
	self.weaponID = nil
	self.tpose = nil
	self.ui_tpose = nil
	self.weapon_tpose = nil
	self.state = HeroRaiseTrackConst.ModelState.none
	self.animator_ = nil
	self.lastAni_ = HeroRaiseTrackConst.HeroAniName[21]
	self.rotateGo_ = nil
	self.talkTimer_ = nil
end

function HeroRaiseModel:PlayTalk()
	if self.skinID then
		self:StopTimer()

		self.talkTimer_ = Timer.New(function()
			self:PickHeroTalkAndPlay({
				"choose",
				"choose2"
			})
		end, 1)

		self.talkTimer_:Start()
	end
end

local function var_0_1(arg_4_0, arg_4_1)
	local var_4_0 = HeroTools.FindMatchSkinVoiceCfg(arg_4_0, arg_4_1)
	local var_4_1 = var_4_0.id
	local var_4_2 = HeroTools.GetHeroIDFromFormID(arg_4_0) or SkinCfg[arg_4_0].hero
	local var_4_3 = var_4_0.use_skin_id ~= 0 and var_4_0.use_skin_id or var_4_2

	if not HeroTools.IsUnlockVoice(var_4_2, var_4_1) then
		return false
	end

	if HeroVoiceDescCfg.GetConfig(var_4_3, var_4_1) == nil then
		return false
	end

	return true
end

function HeroRaiseModel:PickHeroTalkAndPlay(arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if var_0_1(self.skinID, iter_5_1) then
			table.insert(var_5_0, iter_5_1)
		end
	end

	if next(var_5_0) then
		HeroTools.PlayTalkBySkinID(self.skinID, var_5_0[math.random(#var_5_0)])
	end
end

function HeroRaiseModel:GetRotateGo()
	if self.state == HeroRaiseTrackConst.ModelState.none then
		return nil
	else
		return self.rotateGo_
	end
end

function HeroRaiseModel:GetSkinID()
	return self.skinID
end

function HeroRaiseModel:GetState()
	return self.state
end

function HeroRaiseModel:SetSkinID(arg_9_1)
	if arg_9_1 and self.skinID ~= arg_9_1 then
		self.skinID = arg_9_1
		self.modelID = SkinCfg[arg_9_1].modelId
		self.weaponID = SkinCfg[arg_9_1].weapon_modelId

		self:RefreshModel()
	end
end

function HeroRaiseModel:SetState(arg_10_1)
	if arg_10_1 ~= self.state then
		self.state = arg_10_1

		self:RefreshModel()
	end
end

function HeroRaiseModel:SetModelRotation(arg_11_1)
	if not isNil(self.rotateGo_) then
		LeanTween.cancel(self.rotateGo_)

		if arg_11_1 then
			LeanTween.rotateLocal(self.rotateGo_, arg_11_1, HERO_RAISE_ROTATE_TIME):setEase(LeanTweenType.easeOutQuart)
		else
			LeanTween.rotateLocal(self.rotateGo_, Vector3(0, 0, 0), HERO_RAISE_ROTATE_TIME):setEase(LeanTweenType.easeOutQuart)
		end
	end
end

function HeroRaiseModel:RefreshModel()
	self:StopTimer()
	self:Stop()

	if self.state == HeroRaiseTrackConst.ModelState.none then
		self:UnloadHeroModel()
		self:UnloadWeaponModel()
	elseif self.state == HeroRaiseTrackConst.ModelState.hero then
		self:UnloadWeaponModel()
		self:LoadHeroModel()
	elseif self.state == HeroRaiseTrackConst.ModelState.weapon then
		self:UnloadHeroModel()
		self:LoadWeaponModel()
	end
end

function HeroRaiseModel:ResetHeroModel()
	self:PlayAni("action1_1", true, nil)

	if self.tpose then
		local var_13_0 = self.tpose:GetComponent("UIPoseMoveController")

		self.tpose.transform.localPosition = var_13_0:GetInitPosition()
		self.tpose.transform.localEulerAngles = var_13_0:GetInitRotation()
		self.tpose.transform.localScale = Vector3(1, 1, 1)
	end
end

function HeroRaiseModel:ResetWeaponModel()
	self.weapon_tpose.transform.localPosition = Vector3(500, 0, 1)
	self.weapon_tpose.transform.localEulerAngles = Vector3(0, 0, 0)
	self.weapon_tpose.transform.localScale = Vector3(1, 1, 1)
end

function HeroRaiseModel:LoadHeroModel()
	if not self.modelID then
		return
	end

	self:UnloadHeroModel()

	self.tpose = manager.resourcePool:Get(HeroUITimelineMgr.GetModelPath(self.skinID, self.modelID), ASSET_TYPE.TPOSE)
	self.ui_tpose = self.tpose.transform:Find(string.format("%dui/%dui_tpose", self.skinID, self.skinID)).gameObject
	self.rotateGo_ = self.tpose.transform:Find(string.format("%dui", self.skinID)).gameObject
	self.animator_ = self.ui_tpose:GetComponent(typeof(Animator))

	LuaForUtil.ShowWeapon(self.animator_.transform, false)
	manager.heroUiTimeline:BindHero(self.skinID, self.modelID, self.tpose)
	self:ResetHeroModel()
end

function HeroRaiseModel:UnloadHeroModel()
	manager.heroUiTimeline:Unbind()
	self:Stop()
	self:StopTimer()

	if not isNil(self.tpose) then
		manager.resourcePool:DestroyOrReturn(self.tpose, ASSET_TYPE.TPOSE)
	end

	self.tpose = nil
	self.ui_tpose = nil
	self.rotateGo_ = nil
	self.animator_ = nil
end

function HeroRaiseModel:LoadWeaponModel()
	if not self.weaponID then
		return
	end

	self:UnloadWeaponModel()

	self.weapon_tpose = manager.resourcePool:Get("Weapon/" .. self.weaponID, ASSET_TYPE.WEAPON)
	self.rotateGo_ = self.weapon_tpose

	self:ResetWeaponModel()
end

function HeroRaiseModel:UnloadWeaponModel()
	self:Stop()
	self:StopTimer()

	if not isNil(self.weapon_tpose) then
		manager.resourcePool:DestroyOrReturn(self.weapon_tpose, ASSET_TYPE.WEAPON)
	end

	self.weapon_tpose = nil
	self.rotateGo_ = nil
end

function HeroRaiseModel:Finish()
	self:DisposeVfx()
	self:UnloadHeroModel()
	self:UnloadWeaponModel()

	self.skinID = nil
	self.modelID = nil
	self.weaponID = nil
	self.tpose = nil
	self.ui_tpose = nil
	self.weapon_tpose = nil
	self.animator_ = nil
	self.rotateGo_ = nil
end

function HeroRaiseModel:AddManagedVfx(arg_20_1)
	if self.managedVfx == nil then
		self.managedVfx = {}
	end

	table.insert(self.managedVfx, arg_20_1)
end

function HeroRaiseModel:DisposeVfx()
	if self.managedVfx then
		for iter_21_0, iter_21_1 in ipairs(self.managedVfx) do
			if iter_21_1 and not isNil(iter_21_1) then
				LuaForUtil.StopEffect(iter_21_1)
			end
		end

		self.managedVfx = nil
	end
end

function HeroRaiseModel:PlayEffect()
	if self.ui_tpose then
		manager.audio:PlayUIAudioByVoice("hero_change")
		self:AddManagedVfx((LuaForUtil.PlayEffect(self.ui_tpose.transform, "Effect/tongyong/fx_appear_UI", Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)))
	end
end

function HeroRaiseModel:AttachOathRing()
	if self.ui_tpose then
		self:AddManagedVfx((LuaForUtil.PlayAttachEffect(LuaForUtil.GetRoleAttachPoint(self.ui_tpose.transform, OathTools.OathRingAttachPoint), OathTools.OathRingAssetPath, Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), true, 1, 0, math.huge)))
	end
end

function HeroRaiseModel:RemainAni(arg_24_1)
	self.lastAni_ = arg_24_1
end

function HeroRaiseModel:SwitchAni(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	if arg_25_3 == nil then
		arg_25_3 = 0
	end

	if arg_25_4 == nil then
		arg_25_4 = 0
	end

	if self.state ~= HeroRaiseTrackConst.ModelState.hero then
		return
	end

	local var_25_0 = true

	if self.lastAni_ and self.lastAni_ ~= "" and arg_25_1 == "" and arg_25_2 == HeroRaiseTrackConst.HeroAniName[12] and arg_25_3 < HeroRaiseTrackConst.PageIndex.VirtualCamera_AdminMain then
		self:PlayAni(self.lastAni_ .. "_2", var_25_0, nil)

		return
	end

	self.lastAni_ = arg_25_2

	if arg_25_1 == arg_25_2 then
		return
	end

	if not arg_25_2 or arg_25_2 == "" then
		if not isNil(self.tpose) then
			LuaForUtil.EnableEyeController(self.tpose.transform, true)
			manager.resourcePool:ResetBlendShapes(self.tpose.transform)
		end

		self:RemainAni(HeroRaiseTrackConst.HeroAniName[12])

		return
	end

	self:_PrepareTimeline(arg_25_2)

	if arg_25_1 == "" then
		if arg_25_2 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
			self:PlayAni(arg_25_2, var_25_0, nil)
		else
			self:PlayAni(arg_25_2 .. "_1", var_25_0, function()
				self:PlayAni(arg_25_2 .. "_2", var_25_0, nil)
			end)
		end

		return
	end

	if arg_25_1 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
		if arg_25_4 == HeroRaiseTrackConst.PageIndex.VirtualCamera_Admin_Skin or arg_25_4 == HeroRaiseTrackConst.PageIndex.VirtualCamera_Admin_Chip then
			self:PlayAni(HeroRaiseTrackConst.HeroRaiseIdleAniName, var_25_0, nil)
		else
			self:PlayAni(arg_25_2 .. "_1", var_25_0, function()
				self:PlayAni(arg_25_2 .. "_2", var_25_0, nil)
			end)
		end

		return
	end

	if arg_25_2 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
		self:PlayAni(arg_25_1 .. "_3", var_25_0, function()
			self:PlayAni(arg_25_2, var_25_0, nil)
		end)

		return
	end

	if arg_25_4 == HeroRaiseTrackConst.PageIndex.VirtualCamera_AdminMain and (arg_25_3 == HeroRaiseTrackConst.PageIndex.VirtualCamera_Admin_Skin or arg_25_3 == HeroRaiseTrackConst.PageIndex.VirtualCamera_Admin_Chip) then
		self:PlayAni(arg_25_2 .. "_1", var_25_0, function()
			self:PlayAni(arg_25_2 .. "_2", var_25_0, nil)
		end)

		return
	end

	if arg_25_4 == HeroRaiseTrackConst.PageIndex.VirtualCamera_Admin_Skin or arg_25_4 == HeroRaiseTrackConst.PageIndex.VirtualCamera_Admin_Chip then
		self:PlayAni(arg_25_1 .. "_3", var_25_0, function()
			self:PlayAni(HeroRaiseTrackConst.HeroRaiseIdleAniName, var_25_0, nil)
		end)

		return
	end

	self:PlayAni(arg_25_1 .. "_3", var_25_0, function()
		self:PlayAni(arg_25_2 .. "_1", var_25_0, function()
			self:PlayAni(arg_25_2 .. "_2", var_25_0, nil)
		end)
	end)
end

function HeroRaiseModel:ResetBlendShapes()
	if self.ui_tpose then
		LuaForUtil.EnableEyeController(self.ui_tpose.transform, true)
		manager.resourcePool:ResetBlendShapes(self.ui_tpose.transform)
	end
end

local var_0_2 = 0.5

function HeroRaiseModel:PlayAni(arg_34_1, arg_34_2, arg_34_3)
	manager.heroUiTimeline:PlayAction(arg_34_1, {
		isUniqueBlending = true,
		fadeSecond = var_0_2,
		isLoop = self:_IsLoopClip(arg_34_1),
		group = self:_GetGroup(arg_34_1)
	})
	manager.heroUiTimeline:SetCallbackBlendSignal(function(arg_35_0)
		if arg_34_3 ~= nil then
			arg_34_3()
		end
	end)
end

function HeroRaiseModel:Stop()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end

	manager.heroUiTimeline:SetCallbackBlendSignal(nil)
end

function HeroRaiseModel:GetAnimator()
	if self.animator_ then
		return self.animator_
	end

	return nil
end

function HeroRaiseModel:StopTimer()
	if self.talkTimer_ then
		self.talkTimer_:Stop()

		self.talkTimer_ = nil
	end
end

function HeroRaiseModel:_PrepareTimeline(arg_39_1)
	if arg_39_1 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
		return
	end

	manager.heroUiTimeline:PrepareAction(arg_39_1 .. "_1")
	manager.heroUiTimeline:PrepareAction(arg_39_1 .. "_2")
end

function HeroRaiseModel:_IsLoopClip(arg_40_1)
	if arg_40_1 == "action1_1" then
		return true
	end

	if string.find(arg_40_1, "_2") then
		return true
	end

	return false
end

function HeroRaiseModel:_GetGroup(arg_41_1)
	for iter_41_0, iter_41_1 in pairs(HeroRaiseTrackConst.HeroAniName) do
		if string.find(arg_41_1, iter_41_1) then
			return iter_41_1
		end
	end

	return arg_41_1
end

function HeroRaiseModel:Dispose()
	self:StopTimer()
	self:Finish()
end

return HeroRaiseModel
