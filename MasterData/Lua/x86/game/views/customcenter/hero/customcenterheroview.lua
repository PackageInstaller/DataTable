local CustomCenterHeroView = class("CustomCenterHeroView", ReduxView)

function CustomCenterHeroView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.randomController_ = self.controllerEx_:GetController("random")
	self.useStateController_ = self.controllerEx_:GetController("useState")
	self.battleSkinBtn_ = BattleSkinBtnView.New(self.battleSkinBtnGo_)
	self.randomToggleView_ = CustomCenterToggle.New(self.randomGo_)

	self.randomToggleView_:RegisterClickListener(function()
		local var_2_0 = not CustomCenterTools.IsRandomHero()

		CustomCenterAction.SwitchHeroRandom(var_2_0, function()
			if var_2_0 == true and CustomCenterTools.GetRandomHeroCnt() <= 0 then
				CustomCenterTools.UpdateCacheRandomHeroSkinID((PlayerData:GetCacheHeroSkinID(self.heroID_)))
				CustomCenterAction.SaveRandomHeroSkinList(function()
					if not CustomCenterTools.IsRandomScene() and CustomCenterTools.IsDLCScene((HomeSceneSettingData:GetCurSceneID())) then
						HomeSceneSettingAction.SetHomeScene(GameSetting.home_sence_default.value[2], true, true)
					end

					manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_HERO_SKIN_LIST)
				end)
			elseif var_2_0 == false then
				manager.notify:Invoke(CUSTOM_CENTER_SWITCH_RANDOM_HERO)
			elseif var_2_0 == true then
				if not CustomCenterTools.IsRandomScene() and CustomCenterTools.IsDLCScene((HomeSceneSettingData:GetCurSceneID())) then
					HomeSceneSettingAction.SetHomeScene(GameSetting.home_sence_default.value[2], true, true)
				end
			end

			manager.notify:Invoke(CUSTOM_CENTER_SWITCH_RANDOM_HERO)
		end)
	end)

	self.addToggleView_ = CustomCenterToggle.New(self.addGo_)

	self.addToggleView_:RegisterClickListener(function()
		local var_5_0 = PlayerData:GetCacheHeroSkinID(self.heroID_)

		if CustomCenterTools:GetRandomHeroCnt() <= 1 and CustomCenterTools.IsContentRandomHeroSkinID(var_5_0) then
			ShowMessageBox({
				content = GetTips("RANDOM_ASSIST_TIPS2"),
				OkCallback = function()
					CustomCenterAction.SwitchHeroRandom(false, function()
						manager.notify:Invoke(CUSTOM_CENTER_SWITCH_RANDOM_HERO)
						CustomCenterTools.UpdateCacheRandomHeroSkinID(var_5_0)
						CustomCenterAction.SaveRandomHeroSkinList(function()
							if CustomCenterTools.IsContentRandomHeroSkinID((PlayerData:GetCacheHeroSkinID(self.heroID_))) then
								HeroTools.PlayVoice(self.heroID_, "assistant")
							end

							manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_HERO_SKIN_LIST)
						end)
					end)
				end
			})

			return
		end

		CustomCenterTools.UpdateCacheRandomHeroSkinID(var_5_0)
		CustomCenterAction.SaveRandomHeroSkinList(function()
			if CustomCenterTools.IsContentRandomHeroSkinID((PlayerData:GetCacheHeroSkinID(self.heroID_))) then
				HeroTools.PlayVoice(self.heroID_, "assistant")
			end

			manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_HERO_SKIN_LIST)
		end)
	end)

	self.customCenterHeroSkinView_ = CustomCenterHeroSkinPanel.New(self.skinPanel_)
	self.OnChangePosterGirlHandler_ = handler(self, self.OnChangePosterGirl)
	self.OnSwitchRandomModeHandler_ = handler(self, self.OnSwitchRandomMode)
	self.OnChangeHeroBattleSkinHandler_ = handler(self, self.RefreshItemBattleSkin)
end

function CustomCenterHeroView:OnEnter()
	manager.notify:RegistListener(CHANGE_POSTER_GIRL, self.OnChangePosterGirlHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_SWITCH_RANDOM_MODE, self.OnSwitchRandomModeHandler_)
	manager.notify:RegistListener(HERO_BATTLE_SKIN_CHANGE, self.OnChangeHeroBattleSkinHandler_)
end

function CustomCenterHeroView:OnExit()
	manager.notify:RemoveListener(CHANGE_POSTER_GIRL, self.OnChangePosterGirlHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_SWITCH_RANDOM_MODE, self.OnSwitchRandomModeHandler_)
	manager.notify:RemoveListener(HERO_BATTLE_SKIN_CHANGE, self.OnChangeHeroBattleSkinHandler_)
end

function CustomCenterHeroView:RefreshItemBattleSkin(arg_12_1)
	self.battleSkinID_ = arg_12_1

	self.customCenterHeroSkinView_:RefreshItemBattleSkin(self.battleSkinID_)
end

function CustomCenterHeroView:Dispose()
	self.OnChangePosterGirlHandler_ = nil
	self.OnSwitchRandomModeHandler_ = nil

	if self.battleSkinBtn_ then
		self.battleSkinBtn_:Dispose()

		self.battleSkinBtn_ = nil
	end

	self.randomToggleView_:Dispose()

	self.randomToggleView_ = nil

	self.addToggleView_:Dispose()

	self.addToggleView_ = nil

	self.customCenterHeroSkinView_:Dispose()

	self.customCenterHeroSkinView_ = nil

	CustomCenterHeroView.super.Dispose(self)
end

function CustomCenterHeroView:AddListeners()
	self:AddBtnListener(self.clearBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("CUSTOM_CENTER_CLEAR_HERO"),
			OkCallback = function()
				manager.notify:Invoke(CUSTOM_CENTER_CLEAR_HERO)
				manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_HERO_SKIN_LIST)
			end
		})
	end)
	self:AddBtnListener(self.randomBtn_, nil, function()
		JumpTools.OpenPageByJump("randomHeroModePop", {
			type = PlayerData:GetRandomHeroMode()
		})
	end)
	self:AddBtnListener(self.useBtn_, nil, function()
		local var_18_0 = PlayerData:GetCacheHeroSkinID(self.heroID_)
		local var_18_1 = SkinCfg[var_18_0].hero

		HeroAction.SelectSkinWithCallback(SkinCfg[var_18_0].hero, var_18_0, function()
			return
		end)

		if CustomCenterTools.IsRandomScene() and CustomCenterTools.HasDLCScene(var_18_0) then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("RANDOM_SCENE_TIPS"),
				OkCallback = function()
					CustomCenterAction.SwitchSceneRandom(false, function()
						PlayerAction.ChangePosterGirlWithCallback(var_18_1, function()
							CustomCenterTools.SetUseSelectedScene()
						end)
					end)
				end,
				CancelCallback = function()
					PlayerAction.ChangePosterGirlWithCallback(var_18_1)
				end
			})
		else
			local var_18_2 = HomeSceneSettingData:GetCacheSceneID()
			local var_18_3 = PlayerData:GetPlayerInfo().poster_girl

			PlayerAction.ChangePosterGirlWithCallback(SkinCfg[var_18_0].hero, function()
				HomeSceneSettingAction.SetHomeScene(HomeSceneSettingData:GetCacheSceneID(), true)

				if var_18_3 == var_18_1 then
					HeroTools.PlayVoice(self.heroID_, "cloth")
				else
					HeroTools.PlayVoice(var_18_1, "assistant")
				end
			end)
		end
	end)
end

function CustomCenterHeroView:Show(arg_25_1, arg_25_2)
	self.heroID_ = arg_25_2

	if arg_25_1 then
		self.customCenterHeroSkinView_:RefreshUI(arg_25_2)
		self:RefreshUI()

		self.battleSkinID_ = HeroData:GetHeroBattleUsingSkinInfo(arg_25_2).id

		self.customCenterHeroSkinView_:RefreshItemBattleSkin(self.battleSkinID_)
	end

	SetActive(self.gameObject_, arg_25_1)
end

function CustomCenterHeroView:RefreshUI()
	self:RefreshBattleSkinBtn()
	self:RefreshRandomPanel()
end

function CustomCenterHeroView:RefreshBattleSkinBtn()
	if self.heroID_ == nil then
		self.battleSkinBtn_:Show(false)

		return
	end

	local var_27_0 = PlayerData:GetCacheHeroSkinID(self.heroID_)

	if var_27_0 and HeroTools.GetSkinIsUnlock(var_27_0) and var_27_0 ~= self.heroID_ then
		self.battleSkinBtn_:Show(true)
		self.battleSkinBtn_:RefreshUI(self.heroID_, var_27_0)
	else
		self.battleSkinBtn_:Show(false)
	end
end

function CustomCenterHeroView:RefreshRandomPanel()
	if CustomCenterTools.IsRandomHero() then
		self.randomController_:SetSelectedState("true")
		self.randomToggleView_:SetSelectedState(true)
		self:RefreshRandomText()
		self:RefreshRandomCnt()
		self:RefreshBattleSkinBtn()
		self:RefreshAddBtn()
		self.customCenterHeroSkinView_:UpdateSkinItem()
		self.customCenterHeroSkinView_:RefreshItemBattleSkin(self.battleSkinID_)
	else
		self.randomController_:SetSelectedState("false")
		self.randomToggleView_:SetSelectedState(false)
		self:RefreshUseBtn()
	end
end

function CustomCenterHeroView:RefreshRandomCnt()
	self.numText_.text = CustomCenterTools.GetRandomHeroCnt()
end

function CustomCenterHeroView:RefreshRandomText()
	local var_30_0 = PlayerData:GetRandomHeroMode()

	self.randomModeText_.text = var_30_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY and GetTips("RANDOM_MODE_SETTING_PERDAY") or var_30_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_LOGIN and GetTips("RANDOM_MODE_SETTING_PERTIME") or var_30_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER and GetTips("RANDOM_MODE_SETTING_PERPLAY") or "unknown"
end

function CustomCenterHeroView:RefreshUseBtn()
	if self.heroID_ == nil then
		return
	end

	if PlayerData:GetCacheHeroSkinID(self.heroID_) == PlayerData:GetPosterGirlHeroSkinId() then
		self.useStateController_:SetSelectedState("true")
	else
		self.useStateController_:SetSelectedState("false")
	end
end

function CustomCenterHeroView:RefreshAddBtn()
	self.addToggleView_:SetSelectedState((CustomCenterTools.IsContentRandomHeroSkinID((PlayerData:GetCacheHeroSkinID(self.heroID_)))))
end

function CustomCenterHeroView:OnChangePosterGirl()
	self:RefreshUseBtn()
	self:RefreshBattleSkinBtn()
	self.customCenterHeroSkinView_:UpdateSkinItem()
end

function CustomCenterHeroView:OnSwitchRandomMode()
	self:RefreshRandomText()
end

return CustomCenterHeroView
