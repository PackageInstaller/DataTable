local HeroRaiseTrackMgr = class("HeroRaiseTrackMgr")

function HeroRaiseTrackMgr:Ctor()
	self.view_ui = nil
	self.view_data = nil
	self.last_view_ui = nil
	self.last_view_data = nil
	self.track = nil
	self.raiseModel = nil
	self.touchView_ = nil
	self.servantTrackController = nil
	self.cowBoyTrackController = nil
	self.astrolableController = nil

	self:Init()

	self.sceneTxAni_ = nil
	self.breakFx_ = nil
	self.afterModelLoadedCallback_ = {}
end

function HeroRaiseTrackMgr:Init()
	self.view_ui = HeroRaiseTrackConst.ViewType.null
	self.view_data = {}
	self.last_view_ui = HeroRaiseTrackConst.ViewType.null
	self.last_view_data = {}
	self.track = HeroRaiseTrack.New()
	self.raiseModel = HeroRaiseModel.New()
	self.astrolableController = NormalAstrolabe.New()

	self:InjectMethod()
end

function HeroRaiseTrackMgr:InjectMethod()
	import("manager.heroRaiseTrack." .. "HeroRaiseTrackMgr_CustomScene"):Inject(self)
	import("manager.heroRaiseTrack." .. "customScene.cowboyControl.HeroRaiseTrackMgr_Cowboy"):Inject(self)
end

function HeroRaiseTrackMgr:Dispose()
	if self.track then
		self.track:Dispose()
	end

	if self.raiseModel then
		self.raiseModel:Dispose()
	end

	if self.touchView_ then
		self.touchView_:Dispose()
	end

	if self.breakFx_ then
		self.breakFx_:Dispose()

		self.breakFx_ = nil
	end

	self:DisposeCustomScene()
	self:UnloadSceneAni()
	self:UnloadAstrolabe()
	self:RemoveTween()

	self.view_ui = HeroRaiseTrackConst.ViewType.null
	self.view_data = {}
	self.last_view_ui = HeroRaiseTrackConst.ViewType.null
	self.last_view_data = {}
	self.sceneTxAni_ = nil
end

function HeroRaiseTrackMgr:_PreloadModelAsync(arg_5_1)
	if self.isAsyncLoading_ then
		if self.curLoadingSkinId_ == arg_5_1 then
			return
		end

		self.afterModelLoadedCallback_[self.curLoadingSkinId_] = nil
	end

	if self.raiseModel:GetSkinID() == arg_5_1 then
		self.afterModelLoadedCallback_[arg_5_1] = nil
		self.isAsyncLoading_ = nil
		self.curLoadingSkinId_ = nil
		self.curLoadingModelId_ = nil

		return
	end

	self.curLoadingSkinId_ = arg_5_1
	self.curLoadingModelId_ = SkinCfg[arg_5_1].modelId

	local var_5_0 = true

	self.isAsyncLoading_ = manager.resourcePool:AsyncLoad(HeroUITimelineMgr.GetModelPath(self.curLoadingSkinId_, self.curLoadingModelId_), ASSET_TYPE.TPOSE, function(arg_6_0)
		manager.resourcePool:DestroyOrReturn(arg_6_0, ASSET_TYPE.TPOSE)

		if self.afterModelLoadedCallback_[arg_5_1] then
			for iter_6_0, iter_6_1 in ipairs(self.afterModelLoadedCallback_[arg_5_1]) do
				iter_6_1()
			end
		end

		self.afterModelLoadedCallback_[arg_5_1] = nil
		self.curLoadingSkinId_ = nil
		self.curLoadingModelId_ = nil
		self.isAsyncLoading_ = nil
		var_5_0 = nil
	end)

	if not true then
		self.isAsyncLoading_ = nil
	end
end

function HeroRaiseTrackMgr:_AfterModelLoaded(arg_7_1)
	if self.isAsyncLoading_ then
		local var_7_0 = self.afterModelLoadedCallback_[self.curLoadingSkinId_] or {}

		table.insert(var_7_0, arg_7_1)

		self.afterModelLoadedCallback_[self.curLoadingSkinId_] = var_7_0
	else
		arg_7_1()
	end
end

function HeroRaiseTrackMgr:CancelAllAsyncLoadModelOp()
	if self.isAsyncLoading_ then
		manager.resourcePool:StopAsyncQuest(self.isAsyncLoading_)
	end

	self.isAsyncLoading_ = nil
	self.curLoadingSkinId_ = nil
	self.afterModelLoadedCallback_ = {}
end

function HeroRaiseTrackMgr:SetModelState(arg_9_1)
	self:_PreloadModelAsync(arg_9_1)
	self:_AfterModelLoaded(function()
		if self.raiseModel and self.raiseModel:GetSkinID() ~= arg_9_1 then
			self.raiseModel:SetSkinID(arg_9_1)
			self:RefreshTrackState(arg_9_1)
			self:RefreshCameraState(arg_9_1)
			self:RemainAni()
			self:RefreshTouchHero()
			self:RefreshSceneAni()
			self:RefreshSceneStateBySkinID(arg_9_1)
		end
	end)
end

function HeroRaiseTrackMgr:SetModelStateByHeroProxy(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:GetHeroUsingSkinInfo(arg_11_2).id

	self:_PreloadModelAsync(var_11_0)
	self:_AfterModelLoaded(function()
		if self.raiseModel and self.raiseModel:GetSkinID() ~= var_11_0 then
			self.raiseModel:SetSkinID(var_11_0)
			self:RefreshTrackStateByHeroProxy(arg_11_1, arg_11_2)
			self:RefreshCameraState(var_11_0)
			self:RemainAni()
			self:RefreshTouchHero()
			self:RefreshSceneAni()
			self:RefreshSceneStateByHeroProxy(arg_11_1, arg_11_2)
		end
	end)
end

function HeroRaiseTrackMgr:SetViewState(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = false

	if arg_13_1 and self.view_ui ~= arg_13_1 then
		self.last_view_ui = self.view_ui
		self.view_ui = arg_13_1
		var_13_0 = true
	end

	if arg_13_2 then
		arg_13_2[3] = arg_13_2[3] or 0

		if self.view_data[1] ~= arg_13_2[1] or self.view_data[2] ~= arg_13_2[2] or self.view_data[3] ~= arg_13_2[3] then
			if arg_13_2[1] then
				if self.view_data then
					self.last_view_data[1] = self.view_data[1] or nil
				end

				self.view_data[1] = arg_13_2[1]
				var_13_0 = true
			end

			if arg_13_2[2] then
				if self.view_data then
					self.last_view_data[2] = self.view_data[2] or nil
				end

				self.view_data[2] = arg_13_2[2]
				var_13_0 = true
			end

			if arg_13_2[3] then
				if self.view_data then
					self.last_view_data[3] = self.view_data[3] or nil
				end

				self.view_data[3] = arg_13_2[3]
				var_13_0 = true
			else
				if not self.view_data[3] then
					self.last_view_data[3] = nil
				end

				self.view_data[3] = 0
			end
		end
	end

	if var_13_0 then
		self:RefreshCameraState()
		self:RefreshAni()
		self:RefreshSceneAni()
	end

	if arg_13_3 then
		self:RefreshTouchView(arg_13_3)
		self:RefreshTouchHero()
	else
		self:RefreshTouchView(nil)
	end
end

function HeroRaiseTrackMgr:CheckEffect()
	if self.view_data and self.view_ui == HeroRaiseTrackConst.ViewType.heroRaiseCommon then
		if self.view_data[1] == HeroRaiseTrackConst.HeroRaiseType.attr or self.view_data[1] == HeroRaiseTrackConst.HeroRaiseType.skill then
			self.raiseModel:PlayEffect()
		end
	end
end

function HeroRaiseTrackMgr:PlayTalk()
	self:_AfterModelLoaded(function()
		if self.raiseModel then
			self.raiseModel:PlayTalk()
		end
	end)
end

function HeroRaiseTrackMgr:RefreshTrackState(arg_17_1)
	self:RefreshModelVfx((HeroCfg[SkinCfg[arg_17_1].hero] or HeroCfg[HeroTools.FindOriginalFormHeroID(arg_17_1)]).id)
	self.track:SetTrackData(HeroPosAndRotCfg[SkinCfg[arg_17_1].hero].hero_view_height)
end

function HeroRaiseTrackMgr:RefreshTrackStateByHeroProxy(arg_18_1, arg_18_2)
	self:RefreshModelVfxEx(arg_18_2, arg_18_1:IsHeroOath(arg_18_2))
	self.track:SetTrackData(HeroPosAndRotCfg[arg_18_2].hero_view_height)
end

function HeroRaiseTrackMgr:RefreshSceneStateBySkinID(arg_19_1)
	self:RefreshScenePiaoDaiFx(OathTools.IsOath((HeroCfg[SkinCfg[arg_19_1].hero] or HeroCfg[HeroTools.FindOriginalFormHeroID(arg_19_1)]).id) and "oath" or "normal")
end

function HeroRaiseTrackMgr:RefreshSceneStateByHeroProxy(arg_20_1, arg_20_2)
	self:RefreshScenePiaoDaiFx(arg_20_1:IsHeroOath(arg_20_2) and "oath" or "normal")
end

function HeroRaiseTrackMgr:RefreshScenePiaoDaiFx(arg_21_1)
	if self.scenePiaoDaiFx then
		for iter_21_0, iter_21_1 in pairs(self.scenePiaoDaiFx) do
			SetActive(iter_21_1, arg_21_1 == iter_21_0)
		end
	end
end

function HeroRaiseTrackMgr:RefreshModelVfx(arg_22_1)
	self:RefreshModelVfxEx(arg_22_1, OathTools.IsOath(arg_22_1))
end

function HeroRaiseTrackMgr:RefreshModelVfxEx(arg_23_1, arg_23_2)
	self.raiseModel:DisposeVfx()

	if HeroCfg[arg_23_1].private ~= 1 and HeroCfg[arg_23_1].role_type ~= 1 then
		self.raiseModel:PlayEffect()
	end

	if arg_23_2 then
		self.raiseModel:AttachOathRing()
	end
end

function HeroRaiseTrackMgr:RefreshCameraState()
	if not self.view_ui then
		return
	end

	if isNil(self.brain) then
		self.brain = manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	end

	if self.view_ui == HeroRaiseTrackConst.ViewType.null then
		self:UnloadSceneAni()
		self:UnloadWeaponServant()

		if not isNil(self.brain) then
			self.brain.m_CustomBlends = nil
		end

		manager.ui:SetMainCameraCom("CinemachineBrain", false)
		manager.ui:ResetMainCamera()
		self.track:SetActive(false)
		self:SetAstrolableAtive(false)

		self.lastState_ = HeroRaiseTrackConst.ModelState.none

		self.raiseModel:Finish()

		self.view_ui = HeroRaiseTrackConst.ViewType.null
		self.view_data = {}
		self.last_view_ui = HeroRaiseTrackConst.ViewType.null
		self.last_view_data = {}
	elseif self.view_ui == HeroRaiseTrackConst.ViewType.heroRaiseCommon then
		self:LoadSceneAni()

		if not isNil(self.brain) and isNil(self.brain.m_CustomBlends) then
			self.brain.m_CustomBlends = Asset.Load("UI/HeroCamera/CameraData/MainCamera_Blends.asset")
		end

		manager.ui:SetMainCameraCom("CinemachineBrain", true)
		manager.ui:SetMainCamera("hero")
		self.track:SetActive(true)

		if self.view_data then
			local var_24_0 = self.view_data[1] * 10 + self.view_data[2] or 10
			local var_24_1 = self.view_data[1]
			local var_24_2 = self.view_data[3] or 0

			self.track:ChangeCamera(var_24_0)

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
				self:LoadWeaponServant()
			else
				self:UnloadWeaponServant(var_24_4)
			end

			self.lastState_ = self.raiseModel:GetState()

			if var_24_1 == HeroRaiseTrackConst.HeroRaiseType.attr then
				self.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.skill then
				self.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.weapon then
				if var_24_2 == HeroRaiseTrackConst.HeroServantType.servant then
					self.raiseModel:SetState(HeroRaiseTrackConst.ModelState.none)
				else
					self.raiseModel:SetState(HeroRaiseTrackConst.ModelState.weapon)
				end
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.equip then
				self.raiseModel:SetState((var_24_2 == 0 or nil) and (HeroRaiseTrackConst.ModelState.hero or HeroRaiseTrackConst.ModelState.none))
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.transition then
				self.raiseModel:SetState((var_24_2 == 0 or nil) and (HeroRaiseTrackConst.ModelState.hero or HeroRaiseTrackConst.ModelState.none))
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.astrolabe then
				self.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.chip then
				self.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif var_24_1 == HeroRaiseTrackConst.HeroRaiseType.adminsystem then
				self.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			end

			if HeroRaiseTrackConst.HeroRaiseRotate[var_24_0] then
				self:PlayModelRotation(HeroRaiseTrackConst.HeroRaiseRotate[var_24_0])
			else
				self:PlayModelRotation()
			end
		end
	end
end

function HeroRaiseTrackMgr:RefreshTouchView(arg_25_1)
	if self.touchView_ then
		self.touchView_:Dispose()

		self.touchView_ = nil
	end

	if isNil(arg_25_1) then
		return
	end

	self.touchView_ = HeroRaiseModelToucherView.New(arg_25_1)
end

function HeroRaiseTrackMgr:RefreshTouchHero()
	if self.touchView_ then
		local var_26_0 = self.raiseModel:GetRotateGo()

		if not isNil(var_26_0) then
			self.touchView_:SetRotateNode(var_26_0.transform)
		end
	end
end

function HeroRaiseTrackMgr:RefreshAstrolabeColor(arg_27_1)
	local var_27_0 = manager.ui:GetSceneSettingBySceneName("X100")

	if var_27_0 then
		if arg_27_1 then
			self:CreateTimer(var_27_0, ASTROLABE_COLOR[1], ASTROLABE_COLOR[2], ASTROLABE_COLOR[3])
		else
			self:CreateTimer(var_27_0, 1, 1, 1)
		end
	end
end

function HeroRaiseTrackMgr:CreateTimer(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	self:RemoveTween()

	local var_28_0 = arg_28_1.probeLightingBase.r
	local var_28_1 = arg_28_1.probeLightingBase.g
	local var_28_2 = arg_28_1.probeLightingBase.b

	self.tweenValue_ = LeanTween.value(0, 1, ASTROLABE_COLOR_TIME):setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
		localR = Mathf.Lerp(var_28_0, arg_28_2, arg_29_0)
		localG = Mathf.Lerp(var_28_1, arg_28_3, arg_29_0)
		localB = Mathf.Lerp(var_28_2, arg_28_4, arg_29_0)
		arg_28_1.probeLightingBase = Color.New(localR, localG, localB)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self:RemoveTween()
	end))
end

function HeroRaiseTrackMgr:RemoveTween()
	if self.tweenValue_ then
		self.tweenValue_:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(self.tweenValue_.id)

		self.tweenValue_ = nil
	end
end

function HeroRaiseTrackMgr:RemainAni(arg_32_1, arg_32_2)
	if self.raiseModel:GetState() == HeroRaiseTrackConst.ModelState.hero and self.view_data and self.view_data[1] and self.view_data[2] then
		local var_32_0 = self.view_data[1] * 10 + self.view_data[2] or 10

		if arg_32_2 and arg_32_2 ~= "" then
			self.raiseModel:SwitchAni("", arg_32_2, var_32_0)
		else
			self.raiseModel:SwitchAni("", HeroRaiseTrackConst.HeroAniName[var_32_0])
		end
	end
end

function HeroRaiseTrackMgr:RefreshAni()
	if self.view_data and self.view_data[1] and self.view_data[2] then
		if self.breakFx_ == nil then
			self.breakFx_ = HeroRaiseCameraTx.New()

			self.breakFx_:Init("UI/HeroGodHood/TX_Property_Break_01.prefab")
		end

		local var_33_0 = self.view_data[1] * 10 + self.view_data[2] or 10
		local var_33_1 = 0

		if self.last_view_data and self.last_view_data[1] and self.last_view_data[2] then
			var_33_1 = self.last_view_data[1] * 10 + self.last_view_data[2] or 0
		end

		if var_33_0 == 12 then
			self.breakFx_:PlayAnim("TX_Property_Break_star")
		elseif var_33_1 == 12 then
			self.breakFx_:PlayAnim("TX_Property_Break_end")
		end

		local var_33_2 = {}

		if var_33_0 ~= 12 or var_33_1 ~= 21 then
			if var_33_0 == 21 then
				if var_33_1 ~= 12 then
					table.insert(var_33_2, HeroRaiseTrackConst.HeroAniName[var_33_1] or "")
					table.insert(var_33_2, HeroRaiseTrackConst.HeroAniName[var_33_0] or "")
					self.raiseModel:SwitchAni(var_33_2[1], var_33_2[2], var_33_0, var_33_1)
				elseif var_33_0 == 12 and var_33_1 == 21 then
					self.raiseModel:RemainAni(HeroRaiseTrackConst.HeroAniName[21])
				end
			end
		end
	elseif self.breakFx_ then
		self.breakFx_:Dispose()

		self.breakFx_ = nil
	end
end

function HeroRaiseTrackMgr:RefreshSceneAni()
	if self.view_data and self.view_data[1] and self.view_data[2] then
		local var_34_0 = self.view_data[1] * 10 + self.view_data[2] or 10
		local var_34_1 = 0

		if self.last_view_data and self.last_view_data[1] and self.last_view_data[2] then
			var_34_1 = self.last_view_data[1] * 10 + self.last_view_data[2] or 0
		end

		if var_34_0 == 10 or var_34_0 == 20 then
			if var_34_1 ~= 10 and var_34_1 ~= 20 then
				self:PlaySceneAni("TX_Property_Corrector_star1")
			else
				self:PlaySceneAni("TX_Property_Corrector_stand")
			end
		elseif var_34_1 ~= 10 and var_34_1 ~= 20 then
			self:PlaySceneAni("TX_Property_Corrector_hide")
		else
			self:PlaySceneAni("TX_Property_Corrector_end1")
		end
	end
end

function HeroRaiseTrackMgr:RemainSceneAni()
	if self.view_data and self.view_data[1] and self.view_data[2] then
		local var_35_0 = self.view_data[1] * 10 + self.view_data[2] or 10

		if var_35_0 == 10 or var_35_0 == 20 then
			self:PlaySceneAni("TX_Property_Corrector_stand")
		end
	end
end

function HeroRaiseTrackMgr:PlaySceneAni(arg_36_1)
	if isNil(self.sceneTxAni_) then
		return
	end

	self.sceneTxAni_:Play(arg_36_1)
	self.sceneTxAni_:Update(0)
end

function HeroRaiseTrackMgr:LoadSceneAni()
	if isNil(self.sceneTxTrans_) then
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

		self.sceneTxTrans_ = var_37_2.transform:Find("X100_base_003/TX_Property_Corrector")
		self.scenePiaoDaiFx = {
			normal = self.sceneTxTrans_:Find("fx_X100_piaodai").gameObject,
			oath = self.sceneTxTrans_:Find("fx_x100_shiyuepiaodian").gameObject
		}

		if self.sceneTxTrans_ then
			self.sceneTxAni_ = self.sceneTxTrans_:GetComponentInChildren(typeof(Animator))
		end
	end
end

function HeroRaiseTrackMgr:UnloadSceneAni()
	if self.scenePiaoDaiFx then
		for iter_38_0, iter_38_1 in pairs(self.scenePiaoDaiFx) do
			if not isNil(iter_38_1) then
				SetActive(iter_38_1, false)
			end
		end
	end

	self.sceneTxTrans_ = nil
	self.sceneTxAni_ = nil
	self.scenePiaoDaiFx = nil
end

function HeroRaiseTrackMgr:RemoveTween()
	if self.tween then
		self.tween:setOnComplete(nil)
		LeanTween.cancel(self.m_arror.gameObject)

		self.tween = nil
	end
end

function HeroRaiseTrackMgr:PlayModelRotation(arg_40_1)
	if self.raiseModel then
		self.raiseModel:SetModelRotation(arg_40_1)
	end
end

function HeroRaiseTrackMgr:SetWeaponServantID(arg_41_1)
	if self.servantTrackController then
		self.servantTrackController:SetServantID(arg_41_1)
	end
end

function HeroRaiseTrackMgr:LoadWeaponServant()
	if self.servantTrackController and self.servantTrackController:CheckValid() then
		return
	end

	if self.servantTrackController then
		self.servantTrackController:Dispose()

		self.servantTrackController = nil
	end

	local var_42_0 = Object.Instantiate(Asset.Load("UI/HeroGodHood/TX_WeaponServant.prefab"), manager.ui.mainCamera.transform)

	if not isNil(var_42_0) then
		self.servantTrackController = ServantTrackController.New()

		self.servantTrackController:Init(var_42_0)
	end
end

function HeroRaiseTrackMgr:PlayServantAnim(arg_43_1, arg_43_2)
	if self.servantTrackController then
		self.servantTrackController:PlayAnim(arg_43_1, arg_43_2)
	end
end

function HeroRaiseTrackMgr:UnloadWeaponServant(arg_44_1)
	if self.servantTrackController then
		if arg_44_1 then
			self:PlayServantAnim("Fade")
		else
			self.servantTrackController:Dispose()

			self.servantTrackController = nil
		end
	end
end

function HeroRaiseTrackMgr:UnloadAstrolabe()
	if self.astrolableController then
		self.astrolableController:Dispose()
	end
end

function HeroRaiseTrackMgr:SetAstrolableAtive(arg_46_1)
	if self.astrolableController then
		self.astrolableController:SetActive(arg_46_1)

		if not arg_46_1 then
			self:RefreshAstrolableState(AstrolabeConst.AnimationState.Hide)
		end
	end
end

function HeroRaiseTrackMgr:RefreshAstrolableState(arg_47_1)
	if self.astrolableController then
		self.astrolableController:RefreshAnimationState(arg_47_1)
	end
end

return HeroRaiseTrackMgr
