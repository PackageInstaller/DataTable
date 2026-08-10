local var_0_0 = class("HeroRaiseModel")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.skinID = nil
	arg_1_0.modelID = nil
	arg_1_0.weaponID = nil
	arg_1_0.tpose = nil
	arg_1_0.ui_tpose = nil
	arg_1_0.weapon_tpose = nil
	arg_1_0.state = HeroRaiseTrackConst.ModelState.none
	arg_1_0.animator_ = nil
	arg_1_0.lastAni_ = HeroRaiseTrackConst.HeroAniName[21]
	arg_1_0.rotateGo_ = nil
	arg_1_0.talkTimer_ = nil
end

function var_0_0.PlayTalk(arg_2_0)
	if arg_2_0.skinID then
		arg_2_0:StopTimer()

		arg_2_0.talkTimer_ = Timer.New(function()
			arg_2_0:PickHeroTalkAndPlay({
				"choose",
				"choose2"
			})
		end, 1)

		arg_2_0.talkTimer_:Start()
	end
end

local function var_0_1(arg_4_0, arg_4_1)
	local var_4_0 = HeroTools.FindMatchSkinVoiceCfg(arg_4_0, arg_4_1)
	local var_4_1 = var_4_0.id
	local var_4_2 = HeroTools.GetHeroIDFromFormID(arg_4_0) or SkinCfg[arg_4_0].hero
	local var_4_3

	if var_4_0.use_skin_id ~= 0 then
		var_4_3 = var_4_0.use_skin_id
	else
		var_4_3 = var_4_2
	end

	if not HeroTools.IsUnlockVoice(var_4_2, var_4_1) then
		return false
	end

	if HeroVoiceDescCfg.GetConfig(var_4_3, var_4_1) == nil then
		return false
	end

	return true
end

function var_0_0.PickHeroTalkAndPlay(arg_5_0, arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if var_0_1(arg_5_0.skinID, iter_5_1) then
			table.insert(var_5_0, iter_5_1)
		end
	end

	if next(var_5_0) then
		local var_5_1 = var_5_0[math.random(#var_5_0)]

		HeroTools.PlayTalkBySkinID(arg_5_0.skinID, var_5_1)
	end
end

function var_0_0.GetRotateGo(arg_6_0)
	if arg_6_0.state == HeroRaiseTrackConst.ModelState.none then
		return nil
	else
		return arg_6_0.rotateGo_
	end
end

function var_0_0.GetSkinID(arg_7_0)
	return arg_7_0.skinID
end

function var_0_0.GetState(arg_8_0)
	return arg_8_0.state
end

function var_0_0.SetSkinID(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_0.skinID ~= arg_9_1 then
		local var_9_0 = SkinCfg[arg_9_1]

		arg_9_0.skinID = arg_9_1
		arg_9_0.modelID = var_9_0.modelId
		arg_9_0.weaponID = var_9_0.weapon_modelId

		arg_9_0:RefreshModel()
	end
end

function var_0_0.SetState(arg_10_0, arg_10_1)
	if arg_10_1 ~= arg_10_0.state then
		arg_10_0.state = arg_10_1

		arg_10_0:RefreshModel()
	end
end

function var_0_0.SetModelRotation(arg_11_0, arg_11_1)
	if not isNil(arg_11_0.rotateGo_) then
		LeanTween.cancel(arg_11_0.rotateGo_)

		if arg_11_1 then
			LeanTween.rotateLocal(arg_11_0.rotateGo_, arg_11_1, HERO_RAISE_ROTATE_TIME):setEase(LeanTweenType.easeOutQuart)
		else
			LeanTween.rotateLocal(arg_11_0.rotateGo_, Vector3(0, 0, 0), HERO_RAISE_ROTATE_TIME):setEase(LeanTweenType.easeOutQuart)
		end
	end
end

function var_0_0.RefreshModel(arg_12_0)
	arg_12_0:StopTimer()
	arg_12_0:Stop()

	if arg_12_0.state == HeroRaiseTrackConst.ModelState.none then
		arg_12_0:UnloadHeroModel()
		arg_12_0:UnloadWeaponModel()
	elseif arg_12_0.state == HeroRaiseTrackConst.ModelState.hero then
		arg_12_0:UnloadWeaponModel()
		arg_12_0:LoadHeroModel()
	elseif arg_12_0.state == HeroRaiseTrackConst.ModelState.weapon then
		arg_12_0:UnloadHeroModel()
		arg_12_0:LoadWeaponModel()
	end
end

function var_0_0.ResetHeroModel(arg_13_0)
	arg_13_0:PlayAni("action1_1", true, nil)

	if arg_13_0.tpose then
		local var_13_0 = arg_13_0.tpose:GetComponent("UIPoseMoveController")
		local var_13_1 = arg_13_0.tpose.transform

		var_13_1.localPosition = var_13_0:GetInitPosition()
		var_13_1.localEulerAngles = var_13_0:GetInitRotation()
		var_13_1.localScale = Vector3(1, 1, 1)
	end
end

function var_0_0.ResetWeaponModel(arg_14_0)
	local var_14_0 = arg_14_0.weapon_tpose.transform

	var_14_0.localPosition = Vector3(500, 0, 1)
	var_14_0.localEulerAngles = Vector3(0, 0, 0)
	var_14_0.localScale = Vector3(1, 1, 1)
end

function var_0_0.LoadHeroModel(arg_15_0)
	if not arg_15_0.modelID then
		return
	end

	arg_15_0:UnloadHeroModel()

	arg_15_0.tpose = manager.resourcePool:Get(HeroUITimelineMgr.GetModelPath(arg_15_0.skinID, arg_15_0.modelID), ASSET_TYPE.TPOSE)
	arg_15_0.ui_tpose = arg_15_0.tpose.transform:Find(string.format("%dui/%dui_tpose", arg_15_0.skinID, arg_15_0.skinID)).gameObject
	arg_15_0.rotateGo_ = arg_15_0.tpose.transform:Find(string.format("%dui", arg_15_0.skinID)).gameObject
	arg_15_0.animator_ = arg_15_0.ui_tpose:GetComponent(typeof(Animator))

	LuaForUtil.ShowWeapon(arg_15_0.animator_.transform, false)
	manager.heroUiTimeline:BindHero(arg_15_0.skinID, arg_15_0.modelID, arg_15_0.tpose)
	arg_15_0:ResetHeroModel()
end

function var_0_0.UnloadHeroModel(arg_16_0)
	manager.heroUiTimeline:Unbind()
	arg_16_0:Stop()
	arg_16_0:StopTimer()

	if not isNil(arg_16_0.tpose) then
		manager.resourcePool:DestroyOrReturn(arg_16_0.tpose, ASSET_TYPE.TPOSE)
	end

	arg_16_0.tpose = nil
	arg_16_0.ui_tpose = nil
	arg_16_0.rotateGo_ = nil
	arg_16_0.animator_ = nil
end

function var_0_0.LoadWeaponModel(arg_17_0)
	if not arg_17_0.weaponID then
		return
	end

	arg_17_0:UnloadWeaponModel()

	arg_17_0.weapon_tpose = manager.resourcePool:Get("Weapon/" .. arg_17_0.weaponID, ASSET_TYPE.WEAPON)
	arg_17_0.rotateGo_ = arg_17_0.weapon_tpose

	arg_17_0:ResetWeaponModel()
end

function var_0_0.UnloadWeaponModel(arg_18_0)
	arg_18_0:Stop()
	arg_18_0:StopTimer()

	if not isNil(arg_18_0.weapon_tpose) then
		manager.resourcePool:DestroyOrReturn(arg_18_0.weapon_tpose, ASSET_TYPE.WEAPON)
	end

	arg_18_0.weapon_tpose = nil
	arg_18_0.rotateGo_ = nil
end

function var_0_0.Finish(arg_19_0)
	arg_19_0:DisposeVfx()
	arg_19_0:UnloadHeroModel()
	arg_19_0:UnloadWeaponModel()

	arg_19_0.skinID = nil
	arg_19_0.modelID = nil
	arg_19_0.weaponID = nil
	arg_19_0.tpose = nil
	arg_19_0.ui_tpose = nil
	arg_19_0.weapon_tpose = nil
	arg_19_0.animator_ = nil
	arg_19_0.rotateGo_ = nil
end

function var_0_0.AddManagedVfx(arg_20_0, arg_20_1)
	if arg_20_0.managedVfx == nil then
		arg_20_0.managedVfx = {}
	end

	table.insert(arg_20_0.managedVfx, arg_20_1)
end

function var_0_0.DisposeVfx(arg_21_0)
	if arg_21_0.managedVfx then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0.managedVfx) do
			if iter_21_1 and not isNil(iter_21_1) then
				LuaForUtil.StopEffect(iter_21_1)
			end
		end

		arg_21_0.managedVfx = nil
	end
end

function var_0_0.PlayEffect(arg_22_0)
	if arg_22_0.ui_tpose then
		manager.audio:PlayUIAudioByVoice("hero_change")

		local var_22_0 = LuaForUtil.PlayEffect(arg_22_0.ui_tpose.transform, "Effect/tongyong/fx_appear_UI", Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)

		arg_22_0:AddManagedVfx(var_22_0)
	end
end

function var_0_0.AttachOathRing(arg_23_0)
	if arg_23_0.ui_tpose then
		local var_23_0 = LuaForUtil.GetRoleAttachPoint(arg_23_0.ui_tpose.transform, OathTools.OathRingAttachPoint)
		local var_23_1 = LuaForUtil.PlayAttachEffect(var_23_0, OathTools.OathRingAssetPath, Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), true, 1, 0, math.huge)

		arg_23_0:AddManagedVfx(var_23_1)
	end
end

function var_0_0.RemainAni(arg_24_0, arg_24_1)
	arg_24_0.lastAni_ = arg_24_1
end

function var_0_0.SwitchAni(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	if arg_25_3 == nil then
		arg_25_3 = 0
	end

	if arg_25_4 == nil then
		arg_25_4 = 0
	end

	if arg_25_0.state ~= HeroRaiseTrackConst.ModelState.hero then
		return
	end

	local var_25_0 = true

	if arg_25_0.lastAni_ and arg_25_0.lastAni_ ~= "" and arg_25_1 == "" and arg_25_2 == HeroRaiseTrackConst.HeroAniName[12] and arg_25_3 < HeroRaiseTrackConst.PageIndex.VirtualCamera_AdminMain then
		arg_25_0:PlayAni(arg_25_0.lastAni_ .. "_2", var_25_0, nil)

		return
	end

	arg_25_0.lastAni_ = arg_25_2

	if arg_25_1 == arg_25_2 then
		return
	end

	if not arg_25_2 or arg_25_2 == "" then
		if not isNil(arg_25_0.tpose) then
			LuaForUtil.EnableEyeController(arg_25_0.tpose.transform, true)
			manager.resourcePool:ResetBlendShapes(arg_25_0.tpose.transform)
		end

		arg_25_0:RemainAni(HeroRaiseTrackConst.HeroAniName[12])

		return
	end

	arg_25_0:_PrepareTimeline(arg_25_2)

	if arg_25_1 == "" then
		if arg_25_2 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
			arg_25_0:PlayAni(arg_25_2, var_25_0, nil)
		else
			arg_25_0:PlayAni(arg_25_2 .. "_1", var_25_0, function()
				arg_25_0:PlayAni(arg_25_2 .. "_2", var_25_0, nil)
			end)
		end

		return
	end

	if arg_25_1 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
		if arg_25_4 == HeroRaiseTrackConst.PageIndex.VirtualCamera_Admin_Skin or arg_25_4 == HeroRaiseTrackConst.PageIndex.VirtualCamera_Admin_Chip then
			arg_25_0:PlayAni(HeroRaiseTrackConst.HeroRaiseIdleAniName, var_25_0, nil)
		else
			arg_25_0:PlayAni(arg_25_2 .. "_1", var_25_0, function()
				arg_25_0:PlayAni(arg_25_2 .. "_2", var_25_0, nil)
			end)
		end

		return
	end

	if arg_25_2 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
		arg_25_0:PlayAni(arg_25_1 .. "_3", var_25_0, function()
			arg_25_0:PlayAni(arg_25_2, var_25_0, nil)
		end)

		return
	end

	if arg_25_4 == HeroRaiseTrackConst.PageIndex.VirtualCamera_AdminMain and (arg_25_3 == HeroRaiseTrackConst.PageIndex.VirtualCamera_Admin_Skin or arg_25_3 == HeroRaiseTrackConst.PageIndex.VirtualCamera_Admin_Chip) then
		arg_25_0:PlayAni(arg_25_2 .. "_1", var_25_0, function()
			arg_25_0:PlayAni(arg_25_2 .. "_2", var_25_0, nil)
		end)

		return
	end

	if arg_25_4 == HeroRaiseTrackConst.PageIndex.VirtualCamera_Admin_Skin or arg_25_4 == HeroRaiseTrackConst.PageIndex.VirtualCamera_Admin_Chip then
		arg_25_0:PlayAni(arg_25_1 .. "_3", var_25_0, function()
			arg_25_0:PlayAni(HeroRaiseTrackConst.HeroRaiseIdleAniName, var_25_0, nil)
		end)

		return
	end

	arg_25_0:PlayAni(arg_25_1 .. "_3", var_25_0, function()
		arg_25_0:PlayAni(arg_25_2 .. "_1", var_25_0, function()
			arg_25_0:PlayAni(arg_25_2 .. "_2", var_25_0, nil)
		end)
	end)
end

function var_0_0.ResetBlendShapes(arg_33_0)
	if arg_33_0.ui_tpose then
		LuaForUtil.EnableEyeController(arg_33_0.ui_tpose.transform, true)
		manager.resourcePool:ResetBlendShapes(arg_33_0.ui_tpose.transform)
	end
end

local var_0_2 = 0.5

function var_0_0.PlayAni(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	manager.heroUiTimeline:PlayAction(arg_34_1, {
		isUniqueBlending = true,
		fadeSecond = var_0_2,
		isLoop = arg_34_0:_IsLoopClip(arg_34_1),
		group = arg_34_0:_GetGroup(arg_34_1)
	})
	manager.heroUiTimeline:SetCallbackBlendSignal(function(arg_35_0)
		if arg_34_3 ~= nil then
			arg_34_3()
		end
	end)
end

function var_0_0.Stop(arg_36_0)
	if arg_36_0.timer_ ~= nil then
		arg_36_0.timer_:Stop()

		arg_36_0.timer_ = nil
	end

	manager.heroUiTimeline:SetCallbackBlendSignal(nil)
end

function var_0_0.GetAnimator(arg_37_0)
	if arg_37_0.animator_ then
		return arg_37_0.animator_
	end

	return nil
end

function var_0_0.StopTimer(arg_38_0)
	if arg_38_0.talkTimer_ then
		arg_38_0.talkTimer_:Stop()

		arg_38_0.talkTimer_ = nil
	end
end

function var_0_0._PrepareTimeline(arg_39_0, arg_39_1)
	if arg_39_1 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
		return
	end

	manager.heroUiTimeline:PrepareAction(arg_39_1 .. "_1")
	manager.heroUiTimeline:PrepareAction(arg_39_1 .. "_2")
end

function var_0_0._IsLoopClip(arg_40_0, arg_40_1)
	if arg_40_1 == "action1_1" then
		return true
	end

	if string.find(arg_40_1, "_2") then
		return true
	end

	return false
end

function var_0_0._GetGroup(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in pairs(HeroRaiseTrackConst.HeroAniName) do
		if string.find(arg_41_1, iter_41_1) then
			return iter_41_1
		end
	end

	return arg_41_1
end

function var_0_0.Dispose(arg_42_0)
	arg_42_0:StopTimer()
	arg_42_0:Finish()
end

return var_0_0
