local var_0_0 = class("CustomCenterHeroView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.randomController_ = arg_1_0.controllerEx_:GetController("random")
	arg_1_0.useStateController_ = arg_1_0.controllerEx_:GetController("useState")
	arg_1_0.battleSkinBtn_ = BattleSkinBtnView.New(arg_1_0.battleSkinBtnGo_)
	arg_1_0.randomToggleView_ = CustomCenterToggle.New(arg_1_0.randomGo_)

	arg_1_0.randomToggleView_:RegisterClickListener(function()
		local var_2_0 = not CustomCenterTools.IsRandomHero()

		CustomCenterAction.SwitchHeroRandom(var_2_0, function()
			if var_2_0 == true and CustomCenterTools.GetRandomHeroCnt() <= 0 then
				local var_3_0 = PlayerData:GetCacheHeroSkinID(arg_1_0.heroID_)

				CustomCenterTools.UpdateCacheRandomHeroSkinID(var_3_0)
				CustomCenterAction.SaveRandomHeroSkinList(function()
					local var_4_0 = HomeSceneSettingData:GetCurSceneID()

					if not CustomCenterTools.IsRandomScene() and CustomCenterTools.IsDLCScene(var_4_0) then
						HomeSceneSettingAction.SetHomeScene(GameSetting.home_sence_default.value[2], true, true)
					end

					manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_HERO_SKIN_LIST)
				end)
			elseif var_2_0 == false then
				manager.notify:Invoke(CUSTOM_CENTER_SWITCH_RANDOM_HERO)
			elseif var_2_0 == true then
				local var_3_1 = HomeSceneSettingData:GetCurSceneID()

				if not CustomCenterTools.IsRandomScene() and CustomCenterTools.IsDLCScene(var_3_1) then
					HomeSceneSettingAction.SetHomeScene(GameSetting.home_sence_default.value[2], true, true)
				end
			end

			manager.notify:Invoke(CUSTOM_CENTER_SWITCH_RANDOM_HERO)
		end)
	end)

	arg_1_0.addToggleView_ = CustomCenterToggle.New(arg_1_0.addGo_)

	arg_1_0.addToggleView_:RegisterClickListener(function()
		local var_5_0 = PlayerData:GetCacheHeroSkinID(arg_1_0.heroID_)

		if CustomCenterTools:GetRandomHeroCnt() <= 1 and CustomCenterTools.IsContentRandomHeroSkinID(var_5_0) then
			ShowMessageBox({
				content = GetTips("RANDOM_ASSIST_TIPS2"),
				OkCallback = function()
					CustomCenterAction.SwitchHeroRandom(false, function()
						manager.notify:Invoke(CUSTOM_CENTER_SWITCH_RANDOM_HERO)
						CustomCenterTools.UpdateCacheRandomHeroSkinID(var_5_0)
						CustomCenterAction.SaveRandomHeroSkinList(function()
							local var_8_0 = PlayerData:GetCacheHeroSkinID(arg_1_0.heroID_)

							if CustomCenterTools.IsContentRandomHeroSkinID(var_8_0) then
								HeroTools.PlayVoice(arg_1_0.heroID_, "assistant")
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
			local var_9_0 = PlayerData:GetCacheHeroSkinID(arg_1_0.heroID_)

			if CustomCenterTools.IsContentRandomHeroSkinID(var_9_0) then
				HeroTools.PlayVoice(arg_1_0.heroID_, "assistant")
			end

			manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_HERO_SKIN_LIST)
		end)
	end)

	arg_1_0.customCenterHeroSkinView_ = CustomCenterHeroSkinPanel.New(arg_1_0.skinPanel_)
	arg_1_0.OnChangePosterGirlHandler_ = handler(arg_1_0, arg_1_0.OnChangePosterGirl)
	arg_1_0.OnSwitchRandomModeHandler_ = handler(arg_1_0, arg_1_0.OnSwitchRandomMode)
	arg_1_0.OnChangeHeroBattleSkinHandler_ = handler(arg_1_0, arg_1_0.RefreshItemBattleSkin)
end

function var_0_0.OnEnter(arg_10_0)
	manager.notify:RegistListener(CHANGE_POSTER_GIRL, arg_10_0.OnChangePosterGirlHandler_)
	manager.notify:RegistListener(CUSTOM_CENTER_SWITCH_RANDOM_MODE, arg_10_0.OnSwitchRandomModeHandler_)
	manager.notify:RegistListener(HERO_BATTLE_SKIN_CHANGE, arg_10_0.OnChangeHeroBattleSkinHandler_)
end

function var_0_0.OnExit(arg_11_0)
	manager.notify:RemoveListener(CHANGE_POSTER_GIRL, arg_11_0.OnChangePosterGirlHandler_)
	manager.notify:RemoveListener(CUSTOM_CENTER_SWITCH_RANDOM_MODE, arg_11_0.OnSwitchRandomModeHandler_)
	manager.notify:RemoveListener(HERO_BATTLE_SKIN_CHANGE, arg_11_0.OnChangeHeroBattleSkinHandler_)
end

function var_0_0.RefreshItemBattleSkin(arg_12_0, arg_12_1)
	arg_12_0.battleSkinID_ = arg_12_1

	arg_12_0.customCenterHeroSkinView_:RefreshItemBattleSkin(arg_12_0.battleSkinID_)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.OnChangePosterGirlHandler_ = nil
	arg_13_0.OnSwitchRandomModeHandler_ = nil

	if arg_13_0.battleSkinBtn_ then
		arg_13_0.battleSkinBtn_:Dispose()

		arg_13_0.battleSkinBtn_ = nil
	end

	arg_13_0.randomToggleView_:Dispose()

	arg_13_0.randomToggleView_ = nil

	arg_13_0.addToggleView_:Dispose()

	arg_13_0.addToggleView_ = nil

	arg_13_0.customCenterHeroSkinView_:Dispose()

	arg_13_0.customCenterHeroSkinView_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.AddListeners(arg_14_0)
	arg_14_0:AddBtnListener(arg_14_0.clearBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("CUSTOM_CENTER_CLEAR_HERO"),
			OkCallback = function()
				manager.notify:Invoke(CUSTOM_CENTER_CLEAR_HERO)
				manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_HERO_SKIN_LIST)
			end
		})
	end)
	arg_14_0:AddBtnListener(arg_14_0.randomBtn_, nil, function()
		JumpTools.OpenPageByJump("randomHeroModePop", {
			type = PlayerData:GetRandomHeroMode()
		})
	end)
	arg_14_0:AddBtnListener(arg_14_0.useBtn_, nil, function()
		local var_18_0 = PlayerData:GetCacheHeroSkinID(arg_14_0.heroID_)
		local var_18_1 = SkinCfg[var_18_0].hero

		HeroAction.SelectSkinWithCallback(var_18_1, var_18_0, function()
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

			PlayerAction.ChangePosterGirlWithCallback(var_18_1, function()
				HomeSceneSettingAction.SetHomeScene(HomeSceneSettingData:GetCacheSceneID(), true)

				if var_18_3 == var_18_1 then
					HeroTools.PlayVoice(arg_14_0.heroID_, "cloth")
				else
					HeroTools.PlayVoice(var_18_1, "assistant")
				end
			end)
		end
	end)
end

function var_0_0.Show(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.heroID_ = arg_25_2

	if arg_25_1 then
		arg_25_0.customCenterHeroSkinView_:RefreshUI(arg_25_2)
		arg_25_0:RefreshUI()

		arg_25_0.battleSkinID_ = HeroData:GetHeroBattleUsingSkinInfo(arg_25_2).id

		arg_25_0.customCenterHeroSkinView_:RefreshItemBattleSkin(arg_25_0.battleSkinID_)
	end

	SetActive(arg_25_0.gameObject_, arg_25_1)
end

function var_0_0.RefreshUI(arg_26_0)
	arg_26_0:RefreshBattleSkinBtn()
	arg_26_0:RefreshRandomPanel()
end

function var_0_0.RefreshBattleSkinBtn(arg_27_0)
	if arg_27_0.heroID_ == nil then
		arg_27_0.battleSkinBtn_:Show(false)

		return
	end

	local var_27_0 = PlayerData:GetCacheHeroSkinID(arg_27_0.heroID_)

	if var_27_0 and HeroTools.GetSkinIsUnlock(var_27_0) and var_27_0 ~= arg_27_0.heroID_ then
		arg_27_0.battleSkinBtn_:Show(true)
		arg_27_0.battleSkinBtn_:RefreshUI(arg_27_0.heroID_, var_27_0)
	else
		arg_27_0.battleSkinBtn_:Show(false)
	end
end

function var_0_0.RefreshRandomPanel(arg_28_0)
	if CustomCenterTools.IsRandomHero() then
		arg_28_0.randomController_:SetSelectedState("true")
		arg_28_0.randomToggleView_:SetSelectedState(true)
		arg_28_0:RefreshRandomText()
		arg_28_0:RefreshRandomCnt()
		arg_28_0:RefreshBattleSkinBtn()
		arg_28_0:RefreshAddBtn()
		arg_28_0.customCenterHeroSkinView_:UpdateSkinItem()
		arg_28_0.customCenterHeroSkinView_:RefreshItemBattleSkin(arg_28_0.battleSkinID_)
	else
		arg_28_0.randomController_:SetSelectedState("false")
		arg_28_0.randomToggleView_:SetSelectedState(false)
		arg_28_0:RefreshUseBtn()
	end
end

function var_0_0.RefreshRandomCnt(arg_29_0)
	arg_29_0.numText_.text = CustomCenterTools.GetRandomHeroCnt()
end

function var_0_0.RefreshRandomText(arg_30_0)
	local var_30_0 = PlayerData:GetRandomHeroMode()

	if var_30_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY then
		arg_30_0.randomModeText_.text = GetTips("RANDOM_MODE_SETTING_PERDAY")
	elseif var_30_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_LOGIN then
		arg_30_0.randomModeText_.text = GetTips("RANDOM_MODE_SETTING_PERTIME")
	elseif var_30_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER then
		arg_30_0.randomModeText_.text = GetTips("RANDOM_MODE_SETTING_PERPLAY")
	else
		arg_30_0.randomModeText_.text = "unknown"
	end
end

function var_0_0.RefreshUseBtn(arg_31_0)
	if arg_31_0.heroID_ == nil then
		return
	end

	if PlayerData:GetCacheHeroSkinID(arg_31_0.heroID_) == PlayerData:GetPosterGirlHeroSkinId() then
		arg_31_0.useStateController_:SetSelectedState("true")
	else
		arg_31_0.useStateController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshAddBtn(arg_32_0)
	local var_32_0 = PlayerData:GetCacheHeroSkinID(arg_32_0.heroID_)
	local var_32_1 = CustomCenterTools.IsContentRandomHeroSkinID(var_32_0)

	arg_32_0.addToggleView_:SetSelectedState(var_32_1)
end

function var_0_0.OnChangePosterGirl(arg_33_0)
	arg_33_0:RefreshUseBtn()
	arg_33_0:RefreshBattleSkinBtn()
	arg_33_0.customCenterHeroSkinView_:UpdateSkinItem()
end

function var_0_0.OnSwitchRandomMode(arg_34_0)
	arg_34_0:RefreshRandomText()
end

return var_0_0
