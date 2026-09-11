local HeroPropertyPage = class("HeroPropertyPage", HeroPageBase)

function HeroPropertyPage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function HeroPropertyPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroPropertyPage:InitUI()
	self:BindCfgUI()

	self.lockController_ = self.controller_:GetController("lock")
	self.favoriteController_ = self.favorBtnController_:GetController("follow")
	self.favoriteShowController_ = self.favorBtnController_:GetController("favor")
	self.detailController_ = self.heroInfoController_:GetController("detail")
	self.heroInfoView_ = HeroInfoView.New(self, self.infoViewGo_)
end

function HeroPropertyPage:AddUIListener()
	self:AddBtnListener(self.archiveBtn_, nil, function()
		self:Go("/heroArchive", {
			pageID = 1,
			heroID = self.heroInfo_.id
		})
	end)
	self:AddBtnListener(self.storyBtn_, nil, function()
		JumpTools.GoToSystem("/newHeroDetailArchive", {
			id = HeroRecordCfg.get_id_list_by_hero_id[self.heroInfo_.id][1]
		})
		SDKTools.SendMessageToSDK("chain_story_enter", {
			chain_story_enter_source = 1,
			record_id = HeroRecordCfg.get_id_list_by_hero_id[self.heroInfo_.id][1]
		})
	end)
	self:AddBtnListener(self.favoriteBtn_, nil, function()
		if HeroData:IsFavorite(self.heroInfo_.id) then
			HeroAction.SetFavoriteHeroOff(self.heroInfo_.id)
		else
			HeroAction.SetFavoriteHeroOn(self.heroInfo_.id)
		end
	end)
	self:AddBtnListener(self.skinBtn_, nil, function()
		self:Go("/heroSkin", {
			heroID = self.heroInfo_.id
		})
	end)
	self:AddBtnListener(self.heroDisplayBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroDisplay", {
			heroID = self.heroInfo_.id
		})
	end)
	self:AddBtnListener(self.detailBtn_, nil, function()
		self.detailController_:SetSelectedState("true")

		if self.callback_ then
			self.callback_(self.detailHandler_)
		end
	end)
	self:AddBtnListener(self.trialBattleBtn_, nil, function()
		local var_11_0 = HeroTrialTools.GetLastOpenHeroTrial(self.heroInfo_.id)

		HeroTrialData:SetBattleWay(ActivityHeroTrialConst.BATTLE_WAY.HERO_VIEW, "/newHero", {
			isEnter = true,
			pageIndex = 1,
			type = HeroConst.HERO_DATA_TYPE.DEFAULT,
			hid = self.heroInfo_.id
		})

		if var_11_0 ~= 0 and HeroTrialTools.GetActivityIsUnlock(var_11_0) and PlayerData:GetPlayerInfo().userLevel >= 35 then
			HeroTrialTools.EnterActivityBattle(var_11_0)
		else
			HeroTrialTools.EnterResidentBattle(HeroCfg[self.heroInfo_.id].trial_stage)
		end
	end)
end

function HeroPropertyPage:SetHeroInfo(arg_12_1)
	self.heroInfo_ = arg_12_1
	self.unlockDirty_ = true

	if self.heroInfo_ == nil then
		self.unlockDirty_ = false
	elseif self.heroInfo_.unlock == 1 and arg_12_1.unlock == 1 then
		self.unlockDirty_ = false
	elseif self.heroInfo_.unlock == 0 and arg_12_1.unlock == 0 and self.heroInfo_ == arg_12_1 then
		self.unlockDirty_ = false
	end

	self.heroInfoView_:SetHeroInfo(self.heroInfo_)

	if self.unlockDirty_ then
		self.animator_:Play("Fx_HeroArrtUI_right_cx", 0, 0)
	end
end

function HeroPropertyPage:RefreshFavorite()
	self.favoriteShowController_:SetSelectedState(tostring(self.heroViewProxy_.showfavorBtn and self.heroInfo_.unlock == 1))
	self.favoriteController_:SetSelectedState(HeroData:IsFavorite(self.heroInfo_.id) == false and "false" or "true")
end

function HeroPropertyPage:OnHeroFavorite()
	self:RefreshFavorite()
end

function HeroPropertyPage:UpdateView()
	self:RefreshBtnActive()

	local var_15_0 = HeroTools.GetHeroOntologyID(self.heroInfo_.id) or self.heroInfo_.id

	manager.redPoint:bindUIandKey(self.archiveBtn_.transform, RedPointConst.HERO_ARCHIVE_ID .. self.heroInfo_.id, {
		x = 40,
		y = 40
	})
	manager.redPoint:bindUIandKey(self.storyBtn_.transform, RedPointConst.HERO_HEART_STORY_ROOT_ID .. var_15_0, {
		x = 40,
		y = 40
	})
	manager.redPoint:bindUIandKey(self.skinBtn_.transform, RedPointConst.HERO_SKIN_ID .. self.heroInfo_.id, {
		x = 40,
		y = 40
	})
	self.heroInfoView_:UpdateView(self.heroInfo_)
	self:RefreshFavorite()
	self:CheckLocked()
end

function HeroPropertyPage:RefreshBtnActive()
	self.archiveID_ = HeroTools.GetHeroOntologyID(self.heroInfo_.id)

	if self.archiveID_ then
		if #HeroRecordCfg[self.archiveID_].plot_id > 0 then
			self:SetStoryBtnActive(true)
		else
			self:SetStoryBtnActive(false)
		end
	else
		self:SetStoryBtnActive(false)
	end

	self:RefreshTrialBattleBtnActive()
end

function HeroPropertyPage:SetStoryBtnActive(arg_17_1)
	if self.storyBtnParent_ then
		SetActive(self.storyBtnParent_, arg_17_1)
		self.storyBtnParent_:SetActive(arg_17_1)
	else
		SetActive(self.storyBtn_.gameObject, arg_17_1)
	end
end

function HeroPropertyPage:RefreshTrialBattleBtnActive()
	SetActive(self.trialBattleBtn_.gameObject, not not (self.heroInfo_.unlock == 0 and self.heroViewProxy_.isSelf and (HeroCfg[self.heroInfo_.id].trial_stage ~= 0 or type(HeroCfg[self.heroInfo_.id].trial_activity) == "table")))
end

function HeroPropertyPage:CheckLocked()
	self.lockController_:SetSelectedState(tostring(not (self.heroInfo_.unlock ~= 0 and self.heroViewProxy_.isSelf)))
end

function HeroPropertyPage:Show()
	HeroPropertyPage.super.Show(self)
	self:UpdateView()
end

function HeroPropertyPage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0
	}, self.displayGo_)
end

function HeroPropertyPage:OnEnter(arg_22_1)
	self.heroViewProxy_ = arg_22_1

	if self.heroInfoView_ then
		self.heroInfoView_:OnEnter(arg_22_1)
	end

	self:RegistEventListener(HERO_DATA_MODIFY, handler(self, self.OnHeroModify))
	self:RegistEventListener(FAVORITE_HERO, handler(self, self.OnHeroFavorite))
end

function HeroPropertyPage:SwichToAll(arg_23_1, arg_23_2)
	self.detailController_:SetSelectedState("false")

	self.callback_ = arg_23_2
	self.detailHandler_ = arg_23_1
end

function HeroPropertyPage:SwichToDetail()
	self.detailController_:SetSelectedState("true")
end

function HeroPropertyPage:OnExit()
	self:RemoveAllEventListener()

	if self.heroInfoView_ then
		self.heroInfoView_:OnExit()
	end

	manager.redPoint:unbindUIandKey(self.archiveBtn_.transform)
	manager.redPoint:unbindUIandKey(self.storyBtn_.transform)
	manager.redPoint:unbindUIandKey(self.skinBtn_.transform)
end

function HeroPropertyPage:OnHeroModify(arg_26_1)
	if arg_26_1 == self.heroInfo_.id then
		self:UpdateView()
	end
end

function HeroPropertyPage:Dispose()
	self:RemoveAllListeners()

	if self.heroInfoView_ then
		self.heroInfoView_:Dispose()

		self.heroInfoView_ = nil
	end

	HeroPropertyPage.super.Dispose(self)
end

return HeroPropertyPage
