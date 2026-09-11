local HeroPreviewFileInformationPage = class("HeroPreviewFileInformationPage", HeroFileInformationPage)

function HeroPreviewFileInformationPage:InitUI()
	self:BindCfgUI()
	self:AddBtnListeners()

	self.curHeroID_ = 0
	self.curRecordID_ = 0
	self.relationNetController_ = self.rightControllerEx_:GetController("relationNet")
	self.lockController_ = self.controller_:GetController("lock")
	self.recommendController_ = self.controller_:GetController("recommend")
	self.items = {}
end

function HeroPreviewFileInformationPage:AddBtnListeners()
	self:AddBtnListener(self.portraitBtn_, nil, function()
		self:Go("heroPortrait", {
			heroID = self.curHeroID_
		})
	end)
	self:AddBtnListener(self.poltBtn_, nil, function()
		if ObtainHeroMovieCfg[self.curHeroID_] then
			self:Go("/heroMovieReplay", {
				heroID = self.curHeroID_
			})
			OperationRecorder.RecordButtonTouch("video_play_recruit_illustration" .. self.curHeroID_)
		end
	end)
	self:AddBtnListener(self.recommendBtn_, nil, function()
		self.recommendController_:SetSelectedState("true")
	end)
	self:AddBtnListener(self.bgmask_, nil, function()
		self.recommendController_:SetSelectedState("false")
	end)
	self:AddBtnListener(self.cooperationBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("video_play_comboskill_illustration")
		DestroyLua()

		HeroCooperationBridge.heroId = self.curHeroID_
		HeroCooperationBridge.entrance = ViewConst.SYSTEM_ID.ILLUSTRATION

		CooperateSkillBridge.Launcher()
	end)
end

function HeroPreviewFileInformationPage:Show(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 ~= self.curHeroID_ then
		local var_8_0 = HeroCfg[arg_8_2]

		self.heroCfg_ = HeroCfg[arg_8_2]
		self.lableText_.text = GetI18NText(var_8_0.name)
		self.summaryText_.text = GetI18NText(var_8_0.hero_desc)
		self.campImg_.sprite = HeroTools.GetRaceIcon(var_8_0.race)
		self.attackTypeImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroCfg_.id)

		self:RefreshChargeType()

		self.rareImg_.sprite = getSprite("Atlas/Common", "star_" .. var_8_0.rare)
		self.rangeTypeText_.text = CharactorParamCfg[self.heroCfg_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
		self.lockSummaryText_.text = GetI18NText(var_8_0.hero_desc)
		self.curHeroID_ = arg_8_2
	end

	if arg_8_1 ~= self.curRecordID_ then
		self.nameText_.text = GetI18NText(HeroRecordCfg[arg_8_1].name)
		self.heightText_.text = GetI18NText(HeroRecordCfg[arg_8_1].height)
		self.weightText_.text = GetI18NText(HeroRecordCfg[arg_8_1].weight)
		self.birthdayText_.text = GetI18NText(HeroRecordCfg[arg_8_1].birthday)
		self.organizationText_.text = GetI18NText(HeroRecordCfg[arg_8_1].organization)
		self.hobbyText_.text = GetI18NText(HeroRecordCfg[arg_8_1].like)
		self.curRecordID_ = arg_8_1
	end

	self.lockController_:SetSelectedState("false")
	SetActive(self.portraitBtn_.gameObject, HeroData:GetHeroData(arg_8_2).unlock == 1)

	self.plotTxt_.text = HeroData:GetHeroData(arg_8_2).unlock == 1 and GetTips("PULL_ANIMATION_REPLAY") or GetTips("PULL_ANIMATION_PREVIEW")
	self.scroll_.enabled = false
	self.scroll_.enabled = true

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.summaryContent_)
	self.relationNetController_:SetSelectedState("lock")
	SetActive(self.poltBtn_.gameObject, ObtainHeroMovieCfg[self.curHeroID_] ~= nil)
	SetActive(self.gameObject_, true)
	self:RefreshRecommend(arg_8_3)
	self:RefreshCooperationBtn()
	self:UpdateAdult()
end

function HeroPreviewFileInformationPage:UpdateAdult()
	SetActive(self.adultMarkGo_, HeroTools.IsNeedDisplayAdult(self.curHeroID_))
end

function HeroPreviewFileInformationPage:RefreshRecommend(arg_10_1)
	self.recommendController_:SetSelectedState("false")

	if HeroCfg[self.curHeroID_].recommend_team and #HeroCfg[self.curHeroID_].recommend_team > 0 and arg_10_1 then
		SetActive(self.recommendBtn_.gameObject, true)

		for iter_10_0 = 1, #HeroCfg[self.curHeroID_].recommend_team do
			self.items[iter_10_0] = self.items[iter_10_0] or HeroPreviewReCommendItem.New((Object.Instantiate(self.boxGo_, self.boxParent_)))

			self.items[iter_10_0]:RefreshData(HeroCfg[self.curHeroID_].recommend_team[iter_10_0], self.curHeroID_)
		end

		for iter_10_1 = #HeroCfg[self.curHeroID_].recommend_team + 1, #self.items do
			self.items[iter_10_1]:Show(false)
		end
	else
		SetActive(self.recommendBtn_.gameObject, false)
	end
end

function HeroPreviewFileInformationPage:UpdateView(arg_11_1, arg_11_2, arg_11_3)
	HeroPreviewFileInformationPage.super.UpdateView(self, arg_11_1, arg_11_2)
	self.relationNetController_:SetSelectedState("lock")
	self:RefreshRecommend(arg_11_3)
end

function HeroPreviewFileInformationPage:RefreshChargeType()
	self.chargeTypeText_.text = HeroTools.GetChargeTextByType(self.heroCfg_.mechanism_type[1])
end

function HeroPreviewFileInformationPage:RefreshCooperationBtn()
	local var_13_0 = ComboSkillTools.GetHeroComboSkill(self.curHeroID_)

	if var_13_0 and #var_13_0 > 0 then
		SetActive(self.cooperationBtn_.gameObject, true)
	else
		SetActive(self.cooperationBtn_.gameObject, false)
	end
end

function HeroPreviewFileInformationPage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		1
	}, self.displayGo_)
end

function HeroPreviewFileInformationPage:Dispose()
	if self.items then
		for iter_15_0, iter_15_1 in ipairs(self.items) do
			iter_15_1:Dispose()
		end

		self.items = nil
	end

	HeroPreviewFileInformationPage.super.Dispose(self)
end

return HeroPreviewFileInformationPage
