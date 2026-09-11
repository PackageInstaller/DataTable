local NewHeroArchivePlotItemView = class("NewHeroArchivePlotItemView", ReduxView)

function NewHeroArchivePlotItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function NewHeroArchivePlotItemView:Init()
	self:InitUI()
end

function NewHeroArchivePlotItemView:InitUI()
	self:BindCfgUI()

	self.plotIcon_.immediate = true

	self:AddUIListener()

	self.picController_ = ControllerUtil.GetController(self.transform_, "plot")
	self.controller_ = ControllerUtil.GetController(self.transform_, "item")
	self.plotPiccontroller_ = ControllerUtil.GetController(self.plotBtn_.transform, "get")
	self.redPointController_ = ControllerUtil.GetController(self.transform_, "name")
end

function NewHeroArchivePlotItemView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		if not self.isUnlock then
			if self.type_ == 1 then
				ShowTips(string.format(GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_LOVE"), self.all))
			elseif self.type_ == 2 then
				ShowTips(string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_1"), self.trustTips, (GetTips("HERO_TRUST_LEVEL_DES_" .. self.all))))
			end

			return
		end

		if self.needViewedFrontPlot or self.needViewedFrontSuperPlot then
			ShowTips(GetTips("ERROR_HERO_ARCHIVES_PREVIOUS_PLOT_NOT_VIEWED"))

			return
		end

		if self.needViewedNormalPlot then
			ShowTips(GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_COMMON_PLOT_NOT_VIEWED_TIP"))

			return
		end

		manager.story:StartStoryById(self.plotID_, function(arg_6_0)
			HeroAction.ReadStory(self.archiveID_, self.plotID_, self.type_, self.index_)

			if self.stroyCallBack then
				self.stroyCallBack()
			end
		end)
	end)
	self:AddBtnListener(self.plotBtn_, nil, function()
		if self.isLock then
			ShowTips(GetTips("ERROR_NO_UNLOCK_INBETWEENING"))

			return
		end

		if self.plotIsViewed == 0 then
			for iter_7_0, iter_7_1 in ipairs(self.collectPicList_) do
				IllustratedAction.ViewIllustration(iter_7_1, CollectConst.ILLUSTRATION)
			end

			local var_7_0 = {}

			for iter_7_2, iter_7_3 in ipairs(self.collectPicList_) do
				local var_7_1 = IllustratedData:GetIllustrationInfo()[iter_7_3]

				if var_7_1 and var_7_1.is_receive == 0 then
					table.insert(var_7_0, iter_7_3)
				end
			end

			IllustratedAction.ReceiveIllustrationReward(var_7_0)
			self:RefreshUI()
		else
			self:Go("/illuIllustrationDetail", {
				ID = self.collectPicList_[1],
				chapterList = {
					self.collectPicList_[1]
				}
			})
		end
	end)
end

function NewHeroArchivePlotItemView:SetData(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	self.data_ = arg_8_1
	self.plotID_ = arg_8_2
	self.archiveID_ = arg_8_3
	self.index_ = arg_8_4
	self.type_ = arg_8_5
	self.needViewedNormalPlot = false
	self.needViewedFrontPlot = false
	self.needViewedFrontSuperPlot = false
	self.recordData_ = HeroRecordCfg[self.archiveID_]
	self.archiveData_ = ArchiveData:GetArchive(arg_8_3)
	self.collectPicList_ = CollectPictureCfg.get_id_list_by_additional_parameter[self.plotID_]

	self:RefreshUI()
end

function NewHeroArchivePlotItemView:SetStoryCallBack(arg_9_1)
	self.stroyCallBack = arg_9_1
end

function NewHeroArchivePlotItemView:SetPlotCallBack(arg_10_1)
	self.callPlotback = arg_10_1
end

function NewHeroArchivePlotItemView:RefreshUI()
	self.title_.text = GetI18NText(StoryCfg[self.plotID_].name)

	self:RefreshPlotPicUI()
	self:RefreshPlotUI()
end

function NewHeroArchivePlotItemView:RefreshPlotUI()
	self:CheckIsUnlock()

	if self.isUnlock and not self.needViewedFrontPlot and not self.needViewedNormalPlot and not self.needViewedFrontSuperPlot then
		self:RefreshUnLockUI()
	else
		self:RefreshLockText()
	end
end

function NewHeroArchivePlotItemView:CheckIsUnlock()
	local var_13_1
	local var_13_2 = 0

	for iter_13_0, iter_13_1 in pairs(self.archiveData_.video_list) do
		var_13_2 = var_13_2 + 1
	end

	if self.type_ == 1 then
		self.gameSettingCfgID = GameSetting.hero_plot_unlock_condition.value[self.index_]

		local var_13_3

		self.isUnlock, var_13_3, var_13_1 = IsConditionAchieved(self.gameSettingCfgID, {
			heroId = self.archiveID_
		})
		self.needViewedFrontPlot = var_13_2 < self.index_ - 1
	elseif self.type_ == 2 then
		self.gameSettingCfgID = GameSetting.hero_super_plot_unlock_condition.value[self.index_]
		self.isUnlock = false
		self.trustTips = GetI18NText(HeroCfg[self.recordData_.hero_id[1]].name)

		for iter_13_2, iter_13_3 in pairs(self.recordData_.hero_id) do
			local var_13_5, var_13_6, var_13_7 = IsConditionAchieved(self.gameSettingCfgID, {
				heroId = iter_13_3
			})

			var_13_1 = var_13_7

			if var_13_5 then
				self.isUnlock = true
			end

			if iter_13_2 > 1 then
				self.trustTips = string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_2"), self.trustTips, (GetI18NText(HeroCfg[iter_13_3].name)))
			end
		end

		self.needViewedFrontSuperPlot = #ArchiveData:GetHasViewedSuperHeartList(self.archiveID_) < self.index_ - 1
		self.needViewedNormalPlot = var_13_2 < #self.recordData_.plot_id
	end

	self.all = var_13_1

	self.redPointController_:SetSelectedState("no")
end

function NewHeroArchivePlotItemView:RefreshUnLockUI()
	local var_14_0

	if self.type_ == 1 then
		self.controller_:SetSelectedState("1")

		var_14_0 = ArchiveData:IsStoryRead(self.archiveID_, self.plotID_)
	elseif self.type_ == 2 then
		self.controller_:SetSelectedState("3")

		var_14_0 = ArchiveData:IsSuperHeartRead(self.archiveID_, self.index_)
	end

	if var_14_0 then
		self.redPointController_:SetSelectedState("no")
	else
		self.redPointController_:SetSelectedState("yes")
	end
end

function NewHeroArchivePlotItemView:RefreshLockText()
	self.lockText_.text = GetI18NText(ConditionCfg[self.gameSettingCfgID].desc)

	if self.type_ == 1 then
		self.controller_:SetSelectedState("2")

		if self.needViewedFrontPlot and self.isUnlock then
			self.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_PREVIOUS_PLOT_NOT_VIEWED")
		end
	elseif self.type_ == 2 then
		self.controller_:SetSelectedState("4")

		if self.isUnlock then
			if self.needViewedFrontPlot or self.needViewedFrontSuperPlot then
				self.lockText_.text = GetTips("ERROR_HERO_ARCHIVES_PREVIOUS_PLOT_NOT_VIEWED")
			elseif self.needViewedNormalPlot then
				self.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_COMMON_PLOT_NOT_VIEWED_TIP")
			end
		else
			self.lockText_.text = string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_1"), self.trustTips, (GetTips("HERO_TRUST_LEVEL_DES_" .. self.all)))
		end
	end
end

function NewHeroArchivePlotItemView:RefreshPlotPicUI()
	if self.collectPicList_ then
		self.picController_:SetSelectedState("yes")
	else
		self.picController_:SetSelectedState("no")

		return
	end

	self.plotIcon_.spriteSync = "TextureConfig/IllustratedHandbook/Collect_s/" .. CollectPictureCfg[self.collectPicList_[1]].picture

	local var_16_0 = 0

	self.overLappingGo_:SetActive(#self.collectPicList_ > 1)

	for iter_16_0, iter_16_1 in pairs(self.collectPicList_) do
		var_16_0 = var_16_0 + CollectPictureCfg[iter_16_1].reward[1][2]

		local var_16_1 = IllustratedData:GetIllustrationInfo()[iter_16_1]

		self.plotIsViewed = var_16_1 and (var_16_1.is_receive or 0) or 0
	end

	self.rewardCount_.text = "x" .. var_16_0
	self.isLock = false

	for iter_16_2, iter_16_3 in pairs(self.collectPicList_) do
		if IllustratedData:GetIllustrationInfo()[iter_16_3] == nil then
			self.plotPiccontroller_:SetSelectedState("lock")

			self.isLock = true

			return
		end
	end

	if self.plotIsViewed == 1 then
		self.plotPiccontroller_:SetSelectedState("yes")
	else
		self.plotPiccontroller_:SetSelectedState("no")
	end
end

function NewHeroArchivePlotItemView:Dispose()
	NewHeroArchivePlotItemView.super.Dispose(self)
end

return NewHeroArchivePlotItemView
