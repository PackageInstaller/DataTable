local var_0_0 = class("HeroPropertyPage", HeroPageBase)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lockController_ = arg_3_0.controller_:GetController("lock")
	arg_3_0.favoriteController_ = arg_3_0.favorBtnController_:GetController("follow")
	arg_3_0.favoriteShowController_ = arg_3_0.favorBtnController_:GetController("favor")
	arg_3_0.detailController_ = arg_3_0.heroInfoController_:GetController("detail")
	arg_3_0.heroInfoView_ = HeroInfoView.New(arg_3_0, arg_3_0.infoViewGo_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.archiveBtn_, nil, function()
		arg_4_0:Go("/heroArchive", {
			pageID = 1,
			heroID = arg_4_0.heroInfo_.id
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.storyBtn_, nil, function()
		JumpTools.GoToSystem("/newHeroDetailArchive", {
			id = HeroRecordCfg.get_id_list_by_hero_id[arg_4_0.heroInfo_.id][1]
		})
		SDKTools.SendMessageToSDK("chain_story_enter", {
			chain_story_enter_source = 1,
			record_id = HeroRecordCfg.get_id_list_by_hero_id[arg_4_0.heroInfo_.id][1]
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.favoriteBtn_, nil, function()
		if HeroData:IsFavorite(arg_4_0.heroInfo_.id) then
			HeroAction.SetFavoriteHeroOff(arg_4_0.heroInfo_.id)
		else
			HeroAction.SetFavoriteHeroOn(arg_4_0.heroInfo_.id)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.skinBtn_, nil, function()
		arg_4_0:Go("/heroSkin", {
			heroID = arg_4_0.heroInfo_.id
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.heroDisplayBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroDisplay", {
			heroID = arg_4_0.heroInfo_.id
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.detailBtn_, nil, function()
		arg_4_0.detailController_:SetSelectedState("true")

		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.detailHandler_)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.trialBattleBtn_, nil, function()
		local var_11_0 = HeroCfg[arg_4_0.heroInfo_.id]
		local var_11_1 = HeroTrialTools.GetLastOpenHeroTrial(arg_4_0.heroInfo_.id)

		HeroTrialData:SetBattleWay(ActivityHeroTrialConst.BATTLE_WAY.HERO_VIEW, "/newHero", {
			isEnter = true,
			pageIndex = 1,
			type = HeroConst.HERO_DATA_TYPE.DEFAULT,
			hid = arg_4_0.heroInfo_.id
		})

		if var_11_1 ~= 0 and HeroTrialTools.GetActivityIsUnlock(var_11_1) and PlayerData:GetPlayerInfo().userLevel >= 35 then
			HeroTrialTools.EnterActivityBattle(var_11_1)
		else
			HeroTrialTools.EnterResidentBattle(var_11_0.trial_stage)
		end
	end)
end

function var_0_0.SetHeroInfo(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.heroInfo_

	arg_12_0.heroInfo_ = arg_12_1
	arg_12_0.unlockDirty_ = true

	if var_12_0 == nil then
		arg_12_0.unlockDirty_ = false
	elseif var_12_0.unlock == 1 and arg_12_1.unlock == 1 then
		arg_12_0.unlockDirty_ = false
	elseif var_12_0.unlock == 0 and arg_12_1.unlock == 0 and var_12_0 == arg_12_1 then
		arg_12_0.unlockDirty_ = false
	end

	arg_12_0.heroInfoView_:SetHeroInfo(arg_12_0.heroInfo_)

	if arg_12_0.unlockDirty_ then
		arg_12_0.animator_:Play("Fx_HeroArrtUI_right_cx", 0, 0)
	end
end

function var_0_0.RefreshFavorite(arg_13_0)
	arg_13_0.favoriteShowController_:SetSelectedState(tostring(arg_13_0.heroViewProxy_.showfavorBtn and arg_13_0.heroInfo_.unlock == 1))
	arg_13_0.favoriteController_:SetSelectedState(HeroData:IsFavorite(arg_13_0.heroInfo_.id) == false and "false" or "true")
end

function var_0_0.OnHeroFavorite(arg_14_0)
	arg_14_0:RefreshFavorite()
end

function var_0_0.UpdateView(arg_15_0)
	arg_15_0:RefreshBtnActive()

	local var_15_0 = HeroTools.GetHeroOntologyID(arg_15_0.heroInfo_.id) or arg_15_0.heroInfo_.id

	manager.redPoint:bindUIandKey(arg_15_0.archiveBtn_.transform, RedPointConst.HERO_ARCHIVE_ID .. arg_15_0.heroInfo_.id, {
		x = 40,
		y = 40
	})
	manager.redPoint:bindUIandKey(arg_15_0.storyBtn_.transform, RedPointConst.HERO_HEART_STORY_ROOT_ID .. var_15_0, {
		x = 40,
		y = 40
	})
	manager.redPoint:bindUIandKey(arg_15_0.skinBtn_.transform, RedPointConst.HERO_SKIN_ID .. arg_15_0.heroInfo_.id, {
		x = 40,
		y = 40
	})
	arg_15_0.heroInfoView_:UpdateView(arg_15_0.heroInfo_)
	arg_15_0:RefreshFavorite()
	arg_15_0:CheckLocked()
end

function var_0_0.RefreshBtnActive(arg_16_0)
	arg_16_0.archiveID_ = HeroTools.GetHeroOntologyID(arg_16_0.heroInfo_.id)

	if arg_16_0.archiveID_ then
		if #HeroRecordCfg[arg_16_0.archiveID_].plot_id > 0 then
			arg_16_0:SetStoryBtnActive(true)
		else
			arg_16_0:SetStoryBtnActive(false)
		end
	else
		arg_16_0:SetStoryBtnActive(false)
	end

	arg_16_0:RefreshTrialBattleBtnActive()
end

function var_0_0.SetStoryBtnActive(arg_17_0, arg_17_1)
	if arg_17_0.storyBtnParent_ then
		SetActive(arg_17_0.storyBtnParent_, arg_17_1)
		arg_17_0.storyBtnParent_:SetActive(arg_17_1)
	else
		SetActive(arg_17_0.storyBtn_.gameObject, arg_17_1)
	end
end

function var_0_0.RefreshTrialBattleBtnActive(arg_18_0)
	local var_18_0 = false

	if arg_18_0.heroInfo_.unlock == 0 and arg_18_0.heroViewProxy_.isSelf and (HeroCfg[arg_18_0.heroInfo_.id].trial_stage ~= 0 or type(HeroCfg[arg_18_0.heroInfo_.id].trial_activity) == "table") then
		var_18_0 = true
	end

	SetActive(arg_18_0.trialBattleBtn_.gameObject, var_18_0)
end

function var_0_0.CheckLocked(arg_19_0)
	local var_19_0 = arg_19_0.heroInfo_.unlock ~= 0 and arg_19_0.heroViewProxy_.isSelf

	arg_19_0.lockController_:SetSelectedState(tostring(not var_19_0))
end

function var_0_0.Show(arg_20_0)
	var_0_0.super.Show(arg_20_0)
	arg_20_0:UpdateView()
end

function var_0_0.CameraEnter(arg_21_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0
	}, arg_21_0.displayGo_)
end

function var_0_0.OnEnter(arg_22_0, arg_22_1)
	arg_22_0.heroViewProxy_ = arg_22_1

	if arg_22_0.heroInfoView_ then
		arg_22_0.heroInfoView_:OnEnter(arg_22_1)
	end

	arg_22_0:RegistEventListener(HERO_DATA_MODIFY, handler(arg_22_0, arg_22_0.OnHeroModify))
	arg_22_0:RegistEventListener(FAVORITE_HERO, handler(arg_22_0, arg_22_0.OnHeroFavorite))
end

function var_0_0.SwichToAll(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.detailController_:SetSelectedState("false")

	arg_23_0.callback_ = arg_23_2
	arg_23_0.detailHandler_ = arg_23_1
end

function var_0_0.SwichToDetail(arg_24_0)
	arg_24_0.detailController_:SetSelectedState("true")
end

function var_0_0.OnExit(arg_25_0)
	arg_25_0:RemoveAllEventListener()

	if arg_25_0.heroInfoView_ then
		arg_25_0.heroInfoView_:OnExit()
	end

	manager.redPoint:unbindUIandKey(arg_25_0.archiveBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_25_0.storyBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_25_0.skinBtn_.transform)
end

function var_0_0.OnHeroModify(arg_26_0, arg_26_1)
	if arg_26_1 == arg_26_0.heroInfo_.id then
		arg_26_0:UpdateView()
	end
end

function var_0_0.Dispose(arg_27_0)
	arg_27_0:RemoveAllListeners()

	if arg_27_0.heroInfoView_ then
		arg_27_0.heroInfoView_:Dispose()

		arg_27_0.heroInfoView_ = nil
	end

	var_0_0.super.Dispose(arg_27_0)
end

return var_0_0
