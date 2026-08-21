local var_0_0 = class("HeroRaiseTrackMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.view_ui = nil
	arg_1_0.view_data = nil
	arg_1_0.last_view_ui = nil
	arg_1_0.last_view_data = nil
	arg_1_0.track = nil
	arg_1_0.raiseModel = nil
	arg_1_0.touchView_ = nil
	arg_1_0.servantTrackController = nil
	arg_1_0.cowBoyTrackController = nil
	arg_1_0.astrolableController = nil

	arg_1_0:Init()

	arg_1_0.sceneTxAni_ = nil
	arg_1_0.breakFx_ = nil
	arg_1_0.afterModelLoadedCallback_ = {}
end

function var_0_0.Init(arg_2_0)
	arg_2_0.view_ui = HeroRaiseTrackConst.ViewType.null
	arg_2_0.view_data = {}
	arg_2_0.last_view_ui = HeroRaiseTrackConst.ViewType.null
	arg_2_0.last_view_data = {}
	arg_2_0.track = HeroRaiseTrack.New()
	arg_2_0.raiseModel = HeroRaiseModel.New()
	arg_2_0.astrolableController = NormalAstrolabe.New()

	arg_2_0:InjectMethod()
end

function var_0_0.InjectMethod(arg_3_0)
	local var_3_0 = "manager.heroRaiseTrack."

	import(var_3_0 .. "HeroRaiseTrackMgr_CustomScene"):Inject(arg_3_0)
	import(var_3_0 .. "customScene.cowboyControl.HeroRaiseTrackMgr_Cowboy"):Inject(arg_3_0)
end

function var_0_0.Dispose(arg_4_0)
	if arg_4_0.track then
		arg_4_0.track:Dispose()
	end

	if arg_4_0.raiseModel then
		arg_4_0.raiseModel:Dispose()
	end

	if arg_4_0.touchView_ then
		arg_4_0.touchView_:Dispose()
	end

	if arg_4_0.breakFx_ then
		arg_4_0.breakFx_:Dispose()

		arg_4_0.breakFx_ = nil
	end

	arg_4_0:DisposeCustomScene()
	arg_4_0:UnloadSceneAni()
	arg_4_0:UnloadAstrolabe()
	arg_4_0:RemoveTween()

	arg_4_0.view_ui = HeroRaiseTrackConst.ViewType.null
	arg_4_0.view_data = {}
	arg_4_0.last_view_ui = HeroRaiseTrackConst.ViewType.null
	arg_4_0.last_view_data = {}
	arg_4_0.sceneTxAni_ = nil
end

function var_0_0._PreloadModelAsync(arg_5_0, arg_5_1)
	if arg_5_0.isAsyncLoading_ then
		if arg_5_0.curLoadingSkinId_ == arg_5_1 then
			return
		end

		arg_5_0.afterModelLoadedCallback_[arg_5_0.curLoadingSkinId_] = nil
	end

	if arg_5_0.raiseModel:GetSkinID() == arg_5_1 then
		arg_5_0.afterModelLoadedCallback_[arg_5_1] = nil
		arg_5_0.isAsyncLoading_ = nil
		arg_5_0.curLoadingSkinId_ = nil
		arg_5_0.curLoadingModelId_ = nil

		return
	end

	local var_5_0 = SkinCfg[arg_5_1]

	arg_5_0.curLoadingSkinId_ = arg_5_1
	arg_5_0.curLoadingModelId_ = var_5_0.modelId

	local var_5_1 = HeroUITimelineMgr.GetModelPath(arg_5_0.curLoadingSkinId_, arg_5_0.curLoadingModelId_)
	local var_5_2 = true

	arg_5_0.isAsyncLoading_ = manager.resourcePool:AsyncLoad(var_5_1, ASSET_TYPE.TPOSE, function(arg_6_0)
		manager.resourcePool:DestroyOrReturn(arg_6_0, ASSET_TYPE.TPOSE)

		local var_6_0 = arg_5_0.afterModelLoadedCallback_[arg_5_1]

		if var_6_0 then
			for iter_6_0, iter_6_1 in ipairs(var_6_0) do
				iter_6_1()
			end
		end

		arg_5_0.afterModelLoadedCallback_[arg_5_1] = nil
		arg_5_0.curLoadingSkinId_ = nil
		arg_5_0.curLoadingModelId_ = nil
		arg_5_0.isAsyncLoading_ = nil
		var_5_2 = nil
	end)

	if not var_5_2 then
		arg_5_0.isAsyncLoading_ = nil
	end
end

function var_0_0._AfterModelLoaded(arg_7_0, arg_7_1)
	if arg_7_0.isAsyncLoading_ then
		local var_7_0 = arg_7_0.curLoadingSkinId_
		local var_7_1 = arg_7_0.afterModelLoadedCallback_[var_7_0] or {}

		table.insert(var_7_1, arg_7_1)

		arg_7_0.afterModelLoadedCallback_[var_7_0] = var_7_1
	else
		arg_7_1()
	end
end

function var_0_0.CancelAllAsyncLoadModelOp(arg_8_0)
	if arg_8_0.isAsyncLoading_ then
		manager.resourcePool:StopAsyncQuest(arg_8_0.isAsyncLoading_)
	end

	arg_8_0.isAsyncLoading_ = nil
	arg_8_0.curLoadingSkinId_ = nil
	arg_8_0.afterModelLoadedCallback_ = {}
end

function var_0_0.SetModelState(arg_9_0, arg_9_1)
	arg_9_0:_PreloadModelAsync(arg_9_1)
	arg_9_0:_AfterModelLoaded(function()
		local var_10_0 = false

		if arg_9_0.raiseModel and arg_9_0.raiseModel:GetSkinID() ~= arg_9_1 then
			arg_9_0.raiseModel:SetSkinID(arg_9_1)
			arg_9_0:RefreshTrackState(arg_9_1)
			arg_9_0:RefreshCameraState(arg_9_1)
			arg_9_0:RemainAni()
			arg_9_0:RefreshTouchHero()
			arg_9_0:RefreshSceneAni()
			arg_9_0:RefreshSceneStateBySkinID(arg_9_1)
		end
	end)
end

function var_0_0.SetModelStateByHeroProxy(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:GetHeroUsingSkinInfo(arg_11_2).id

	arg_11_0:_PreloadModelAsync(var_11_0)
	arg_11_0:_AfterModelLoaded(function()
		local var_12_0 = false

		if arg_11_0.raiseModel and arg_11_0.raiseModel:GetSkinID() ~= var_11_0 then
			arg_11_0.raiseModel:SetSkinID(var_11_0)
			arg_11_0:RefreshTrackStateByHeroProxy(arg_11_1, arg_11_2)
			arg_11_0:RefreshCameraState(var_11_0)
			arg_11_0:RemainAni()
			arg_11_0:RefreshTouchHero()
			arg_11_0:RefreshSceneAni()
			arg_11_0:RefreshSceneStateByHeroProxy(arg_11_1, arg_11_2)
		end
	end)
end

function var_0_0.SetViewState(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = false

	if arg_13_1 and arg_13_0.view_ui ~= arg_13_1 then
		arg_13_0.last_view_ui = arg_13_0.view_ui
		arg_13_0.view_ui = arg_13_1
		var_13_0 = true
	end

	if arg_13_2 then
		if not arg_13_2[3] then
			arg_13_2[3] = 0
		end

		if arg_13_0.view_data[1] ~= arg_13_2[1] or arg_13_0.view_data[2] ~= arg_13_2[2] or arg_13_0.view_data[3] ~= arg_13_2[3] then
			if arg_13_2[1] then
				if arg_13_0.view_data then
					arg_13_0.last_view_data[1] = arg_13_0.view_data[1] or nil
				end

				arg_13_0.view_data[1] = arg_13_2[1]
				var_13_0 = true
			end

			if arg_13_2[2] then
				if arg_13_0.view_data then
					arg_13_0.last_view_data[2] = arg_13_0.view_data[2] or nil
				end

				arg_13_0.view_data[2] = arg_13_2[2]
				var_13_0 = true
			end

			if arg_13_2[3] then
				if arg_13_0.view_data then
					arg_13_0.last_view_data[3] = arg_13_0.view_data[3] or nil
				end

				arg_13_0.view_data[3] = arg_13_2[3]
				var_13_0 = true
			else
				arg_13_0.last_view_data[3] = arg_13_0.view_data[3] or nil
				arg_13_0.view_data[3] = 0
			end
		end
	end

	if var_13_0 then
		arg_13_0:RefreshCameraState()
		arg_13_0:RefreshAni()
		arg_13_0:RefreshSceneAni()
	end

	if arg_13_3 then
		arg_13_0:RefreshTouchView(arg_13_3)
		arg_13_0:RefreshTouchHero()
	else
		arg_13_0:RefreshTouchView(nil)
	end
end

function var_0_0.CheckEffect(arg_14_0)
	if arg_14_0.view_data and arg_14_0.view_ui == HeroRaiseTrackConst.ViewType.heroRaiseCommon then
		local var_14_0 = arg_14_0.view_data[1]

		if var_14_0 == HeroRaiseTrackConst.HeroRaiseType.attr or var_14_0 == HeroRaiseTrackConst.HeroRaiseType.skill then
			arg_14_0.raiseModel:PlayEffect()
		end
	end
end

function var_0_0.PlayTalk(arg_15_0)
	arg_15_0:_AfterModelLoaded(function()
		if arg_15_0.raiseModel then
			arg_15_0.raiseModel:PlayTalk()
		end
	end)
end

function var_0_0.RefreshTrackState(arg_17_0, arg_17_1)
	local var_17_0 = SkinCfg[arg_17_1].hero
	local var_17_1 = (HeroCfg[var_17_0] or HeroCfg[HeroTools.FindOriginalFormHeroID(arg_17_1)]).id
	local var_17_2 = HeroPosAndRotCfg[var_17_0].hero_view_height

	arg_17_0:RefreshModelVfx(var_17_1)
	arg_17_0.track:SetTrackData(var_17_2)
end

function var_0_0.RefreshTrackStateByHeroProxy(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = HeroPosAndRotCfg[arg_18_2]
	local var_18_1 = var_18_0.hero_view_height

	arg_18_0:RefreshModelVfxEx(arg_18_2, arg_18_1:IsHeroOath(arg_18_2))
	arg_18_0.track:SetTrackData(var_18_0.hero_view_height)
end

function var_0_0.RefreshSceneStateBySkinID(arg_19_0, arg_19_1)
	local var_19_0 = (HeroCfg[SkinCfg[arg_19_1].hero] or HeroCfg[HeroTools.FindOriginalFormHeroID(arg_19_1)]).id
	local var_19_1 = OathTools.IsOath(var_19_0)

	arg_19_0:RefreshScenePiaoDaiFx(var_19_1 and "oath" or "normal")
end

function var_0_0.RefreshSceneStateByHeroProxy(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1:IsHeroOath(arg_20_2)

	arg_20_0:RefreshScenePiaoDaiFx(var_20_0 and "oath" or "normal")
end

function var_0_0.RefreshScenePiaoDaiFx(arg_21_0, arg_21_1)
	if arg_21_0.scenePiaoDaiFx then
		for iter_21_0, iter_21_1 in pairs(arg_21_0.scenePiaoDaiFx) do
			SetActive(iter_21_1, arg_21_1 == iter_21_0)
		end
	end
end

function var_0_0.RefreshModelVfx(arg_22_0, arg_22_1)
	arg_22_0:RefreshModelVfxEx(arg_22_1, OathTools.IsOath(arg_22_1))
end

function var_0_0.RefreshModelVfxEx(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.raiseModel:DisposeVfx()

	local var_23_0 = HeroCfg[arg_23_1]

	if var_23_0.private ~= 1 and var_23_0.role_type ~= 1 then
		arg_23_0.raiseModel:PlayEffect()
	end

	if arg_23_2 then
		arg_23_0.raiseModel:AttachOathRing()
	end
end

function var_0_0.RefreshCameraState(arg_24_0)
	if not arg_24_0.view_ui then
		return
	end

	if isNil(arg_24_0.brain) then
		arg_24_0.brain = manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	end

	if arg_24_0.view_ui == HeroRaiseTrackConst.ViewType.null then
		arg_24_0:UnloadSceneAni()
		arg_24_0:UnloadWeaponServant()

		if not isNil(arg_24_0.brain) then
			arg_24_0.brain.m_CustomBlends = nil
		end

		manager.ui:SetMainCameraCom("CinemachineBrain", false)
		manager.ui:ResetMainCamera()
		arg_24_0.track:SetActive(false)
		arg_24_0:SetAstrolableAtive(false)

		arg_24_0.lastState_ = HeroRaiseTrackConst.ModelState.none

		arg_24_0.raiseModel:Finish()

		arg_24_0.view_ui = HeroRaiseTrackConst.ViewType.null
		arg_24_0.view_data = {}
		arg_24_0.last_view_ui = HeroRaiseTrackConst.ViewType.null
		arg_24_0.last_view_data = {}
	elseif arg_24_0.view_ui == HeroRaiseTrackConst.ViewType.heroRaiseCommon then
		arg_24_0:LoadSceneAni()

		if not isNil(arg_24_0.brain) and isNil(arg_24_0.brain.m_CustomBlends) then
			arg_24_0.brain.m_CustomBlends = Asset.Load("UI/HeroCamera/CameraData/MainCamera_Blends.asset")
		end

		manager.ui:SetMainCameraCom("CinemachineBrain", true)
		manager.ui:SetMainCamera("hero")
		arg_24_0.track:SetActive(true)

		if arg_24_0.view_data then
			local var_24_0 = arg_24_0.view_data[1] * 10 + arg_24_0.view_data[2] or 10
			local var_24_1 = arg_24_0.view_data[1]
			local var_24_2 = arg_24_0.view_data[3] or 0

			arg_24_0.track:ChangeCamera(var_24_0)

			local var_24_3 = false
			local var_24_4 = false

			if var_24_1 == HeroRaiseTrackConst.HeroRaiseType.weapon then
				if var_24_2 ~= HeroRaiseTrackConst.HeroServantType.weapon then
					var_24_3 = true
				else
					var_24_4 = true
				end
			end

			if var_24_3 then
				arg_24_0:LoadWeaponServant()
			else
				arg_24_0:UnloadWeaponServant(var_24_4)
			end

			arg_24_0.lastState_ = arg_24_0.raiseModel:GetState()

			if var_24_1 == HeroRaiseTrackConst.HeroRaiseType.attr then
				arg_24_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.skill then
				arg_24_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.weapon then
				if var_24_2 == HeroRaiseTrackConst.HeroServantType.servant then
					arg_24_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.none)
				else
					arg_24_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.weapon)
				end
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.equip then
				arg_24_0.raiseModel:SetState(var_24_2 == 0 and HeroRaiseTrackConst.ModelState.hero or HeroRaiseTrackConst.ModelState.none)
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.transition then
				arg_24_0.raiseModel:SetState(var_24_2 == 0 and HeroRaiseTrackConst.ModelState.hero or HeroRaiseTrackConst.ModelState.none)
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.astrolabe then
				arg_24_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.chip then
				arg_24_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.adminsystem then
				arg_24_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			end

			if HeroRaiseTrackConst.HeroRaiseRotate[var_24_0] then
				arg_24_0:PlayModelRotation(HeroRaiseTrackConst.HeroRaiseRotate[var_24_0])
			else
				arg_24_0:PlayModelRotation()
			end
		end
	end
end

function var_0_0.RefreshTouchView(arg_25_0, arg_25_1)
	if arg_25_0.touchView_ then
		arg_25_0.touchView_:Dispose()

		arg_25_0.touchView_ = nil
	end

	if isNil(arg_25_1) then
		return
	end

	arg_25_0.touchView_ = HeroRaiseModelToucherView.New(arg_25_1)
end

function var_0_0.RefreshTouchHero(arg_26_0)
	if arg_26_0.touchView_ then
		local var_26_0 = arg_26_0.raiseModel:GetRotateGo()

		if not isNil(var_26_0) then
			arg_26_0.touchView_:SetRotateNode(var_26_0.transform)
		end
	end
end

function var_0_0.RefreshAstrolabeColor(arg_27_0, arg_27_1)
	local var_27_0 = manager.ui:GetSceneSettingBySceneName("X100")

	if var_27_0 then
		if arg_27_1 then
			arg_27_0:CreateTimer(var_27_0, ASTROLABE_COLOR[1], ASTROLABE_COLOR[2], ASTROLABE_COLOR[3])
		else
			arg_27_0:CreateTimer(var_27_0, 1, 1, 1)
		end
	end
end

function var_0_0.CreateTimer(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	arg_28_0:RemoveTween()

	local var_28_0 = arg_28_1.probeLightingBase.r
	local var_28_1 = arg_28_1.probeLightingBase.g
	local var_28_2 = arg_28_1.probeLightingBase.b

	arg_28_0.tweenValue_ = LeanTween.value(0, 1, ASTROLABE_COLOR_TIME):setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
		localR = Mathf.Lerp(var_28_0, arg_28_2, arg_29_0)
		localG = Mathf.Lerp(var_28_1, arg_28_3, arg_29_0)
		localB = Mathf.Lerp(var_28_2, arg_28_4, arg_29_0)
		arg_28_1.probeLightingBase = Color.New(localR, localG, localB)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_28_0:RemoveTween()
	end))
end

function var_0_0.RemoveTween(arg_31_0)
	if arg_31_0.tweenValue_ then
		arg_31_0.tweenValue_:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(arg_31_0.tweenValue_.id)

		arg_31_0.tweenValue_ = nil
	end
end

function var_0_0.RemainAni(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_0.raiseModel:GetState() == HeroRaiseTrackConst.ModelState.hero and arg_32_0.view_data and arg_32_0.view_data[1] and arg_32_0.view_data[2] then
		local var_32_0 = arg_32_0.view_data[1] * 10 + arg_32_0.view_data[2] or 10

		if arg_32_2 and arg_32_2 ~= "" then
			arg_32_0.raiseModel:SwitchAni("", arg_32_2, var_32_0)
		else
			arg_32_0.raiseModel:SwitchAni("", HeroRaiseTrackConst.HeroAniName[var_32_0])
		end
	end
end

function var_0_0.RefreshAni(arg_33_0)
	if arg_33_0.view_data and arg_33_0.view_data[1] and arg_33_0.view_data[2] then
		if arg_33_0.breakFx_ == nil then
			arg_33_0.breakFx_ = HeroRaiseCameraTx.New()

			arg_33_0.breakFx_:Init("UI/HeroGodHood/TX_Property_Break_01.prefab")
		end

		local var_33_0 = arg_33_0.view_data[1] * 10 + arg_33_0.view_data[2] or 10
		local var_33_1 = 0

		if arg_33_0.last_view_data and arg_33_0.last_view_data[1] and arg_33_0.last_view_data[2] then
			var_33_1 = arg_33_0.last_view_data[1] * 10 + arg_33_0.last_view_data[2] or 0
		end

		if var_33_0 == 12 then
			arg_33_0.breakFx_:PlayAnim("TX_Property_Break_star")
		elseif var_33_1 == 12 then
			arg_33_0.breakFx_:PlayAnim("TX_Property_Break_end")
		end

		local var_33_2 = {}

		if (var_33_0 ~= 12 or var_33_1 ~= 21) and (var_33_0 ~= 21 or var_33_1 ~= 12) then
			table.insert(var_33_2, HeroRaiseTrackConst.HeroAniName[var_33_1] or "")
			table.insert(var_33_2, HeroRaiseTrackConst.HeroAniName[var_33_0] or "")
			arg_33_0.raiseModel:SwitchAni(var_33_2[1], var_33_2[2], var_33_0, var_33_1)
		elseif var_33_0 == 12 and var_33_1 == 21 then
			arg_33_0.raiseModel:RemainAni(HeroRaiseTrackConst.HeroAniName[21])
		end
	elseif arg_33_0.breakFx_ then
		arg_33_0.breakFx_:Dispose()

		arg_33_0.breakFx_ = nil
	end
end

function var_0_0.RefreshSceneAni(arg_34_0)
	if arg_34_0.view_data and arg_34_0.view_data[1] and arg_34_0.view_data[2] then
		local var_34_0 = arg_34_0.view_data[1] * 10 + arg_34_0.view_data[2] or 10
		local var_34_1 = 0

		if arg_34_0.last_view_data and arg_34_0.last_view_data[1] and arg_34_0.last_view_data[2] then
			var_34_1 = arg_34_0.last_view_data[1] * 10 + arg_34_0.last_view_data[2] or 0
		end

		if var_34_0 == 10 or var_34_0 == 20 then
			if var_34_1 ~= 10 and var_34_1 ~= 20 then
				arg_34_0:PlaySceneAni("TX_Property_Corrector_star1")
			else
				arg_34_0:PlaySceneAni("TX_Property_Corrector_stand")
			end
		elseif var_34_1 ~= 10 and var_34_1 ~= 20 then
			arg_34_0:PlaySceneAni("TX_Property_Corrector_hide")
		else
			arg_34_0:PlaySceneAni("TX_Property_Corrector_end1")
		end
	end
end

function var_0_0.RemainSceneAni(arg_35_0)
	if arg_35_0.view_data and arg_35_0.view_data[1] and arg_35_0.view_data[2] then
		local var_35_0 = arg_35_0.view_data[1] * 10 + arg_35_0.view_data[2] or 10

		if var_35_0 == 10 or var_35_0 == 20 then
			arg_35_0:PlaySceneAni("TX_Property_Corrector_stand")
		end
	end
end

function var_0_0.PlaySceneAni(arg_36_0, arg_36_1)
	if isNil(arg_36_0.sceneTxAni_) then
		return
	end

	arg_36_0.sceneTxAni_:Play(arg_36_1)
	arg_36_0.sceneTxAni_:Update(0)
end

function var_0_0.LoadSceneAni(arg_37_0)
	if isNil(arg_37_0.sceneTxTrans_) then
		local var_37_0 = SceneManager.GetSceneByName("X100")
		local var_37_1 = var_37_0:GetRootGameObjects()
		local var_37_2

		if var_37_1 ~= nil then
			for iter_37_0 = 0, var_37_1.Length - 1 do
				if var_37_1[iter_37_0].name == var_37_0.name then
					var_37_2 = var_37_1[iter_37_0]

					break
				end
			end
		end

		arg_37_0.sceneTxTrans_ = var_37_2.transform:Find("X100_base_003/TX_Property_Corrector")
		arg_37_0.scenePiaoDaiFx = {
			normal = arg_37_0.sceneTxTrans_:Find("fx_X100_piaodai").gameObject,
			oath = arg_37_0.sceneTxTrans_:Find("fx_x100_shiyuepiaodian").gameObject
		}

		if arg_37_0.sceneTxTrans_ then
			arg_37_0.sceneTxAni_ = arg_37_0.sceneTxTrans_:GetComponentInChildren(typeof(Animator))
		end
	end
end

function var_0_0.UnloadSceneAni(arg_38_0)
	if arg_38_0.scenePiaoDaiFx then
		for iter_38_0, iter_38_1 in pairs(arg_38_0.scenePiaoDaiFx) do
			if not isNil(iter_38_1) then
				SetActive(iter_38_1, false)
			end
		end
	end

	arg_38_0.sceneTxTrans_ = nil
	arg_38_0.sceneTxAni_ = nil
	arg_38_0.scenePiaoDaiFx = nil
end

function var_0_0.RemoveTween(arg_39_0)
	if arg_39_0.tween then
		arg_39_0.tween:setOnComplete(nil)
		LeanTween.cancel(arg_39_0.m_arror.gameObject)

		arg_39_0.tween = nil
	end
end

function var_0_0.PlayModelRotation(arg_40_0, arg_40_1)
	if arg_40_0.raiseModel then
		arg_40_0.raiseModel:SetModelRotation(arg_40_1)
	end
end

function var_0_0.SetWeaponServantID(arg_41_0, arg_41_1)
	if arg_41_0.servantTrackController then
		arg_41_0.servantTrackController:SetServantID(arg_41_1)
	end
end

function var_0_0.LoadWeaponServant(arg_42_0)
	if arg_42_0.servantTrackController and arg_42_0.servantTrackController:CheckValid() then
		return
	end

	if arg_42_0.servantTrackController then
		arg_42_0.servantTrackController:Dispose()

		arg_42_0.servantTrackController = nil
	end

	local var_42_0 = Asset.Load("UI/HeroGodHood/TX_WeaponServant.prefab")
	local var_42_1 = Object.Instantiate(var_42_0, manager.ui.mainCamera.transform)

	if not isNil(var_42_1) then
		arg_42_0.servantTrackController = ServantTrackController.New()

		arg_42_0.servantTrackController:Init(var_42_1)
	end
end

function var_0_0.PlayServantAnim(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_0.servantTrackController then
		arg_43_0.servantTrackController:PlayAnim(arg_43_1, arg_43_2)
	end
end

function var_0_0.UnloadWeaponServant(arg_44_0, arg_44_1)
	if arg_44_0.servantTrackController then
		if arg_44_1 then
			arg_44_0:PlayServantAnim("Fade")
		else
			arg_44_0.servantTrackController:Dispose()

			arg_44_0.servantTrackController = nil
		end
	end
end

function var_0_0.UnloadAstrolabe(arg_45_0)
	if arg_45_0.astrolableController then
		arg_45_0.astrolableController:Dispose()
	end
end

function var_0_0.SetAstrolableAtive(arg_46_0, arg_46_1)
	if arg_46_0.astrolableController then
		arg_46_0.astrolableController:SetActive(arg_46_1)

		if not arg_46_1 then
			arg_46_0:RefreshAstrolableState(AstrolabeConst.AnimationState.Hide)
		end
	end
end

function var_0_0.RefreshAstrolableState(arg_47_0, arg_47_1)
	if arg_47_0.astrolableController then
		arg_47_0.astrolableController:RefreshAnimationState(arg_47_1)
	end
end

return var_0_0
