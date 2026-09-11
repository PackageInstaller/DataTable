local NewHeroArchiveDetailView = class("NewHeroArchiveDetailView", ReduxView)

function NewHeroArchiveDetailView:UIName()
	return "Widget/System/Hero_chain/HeroChainUI"
end

function NewHeroArchiveDetailView:UIParent()
	return manager.ui.uiMain.transform
end

function NewHeroArchiveDetailView:Init()
	self:InitUI()
end

function NewHeroArchiveDetailView:InitUI()
	self:BindCfgUI()

	self.bgImg_.immediate = true
	self.bgController_ = ControllerUtil.GetController(self.transform_, "bg")

	self:AddUIListener()
	self:RegistEventListener(UPDATE_WALLPAPER, function()
		self:RefreshBgUI()
	end)
	self:RegistEventListener(UPDATE_HEARTLIST, function()
		self:RefreshPlotList()
	end)

	self.uiList_ = LuaList.New(handler(self, self.IndexPlotItem), self.plotList_, NewHeroArchivePlotItemView)
	self.uiStoryList_ = LuaList.New(handler(self, self.IndexStoryItem), self.storyList_, NewHeroArchiveStoryItemView)
end

function NewHeroArchiveDetailView:IndexPlotItem(arg_7_1, arg_7_2)
	if arg_7_1 == #self.plotIdList_ or arg_7_1 == #self.superPlotIdList_ + #self.plotIdList_ then
		SetActive(arg_7_2.nextLine_, false)
	else
		SetActive(arg_7_2.nextLine_, true)
	end

	if arg_7_1 <= #self.plotIdList_ then
		arg_7_2:SetData(self.recordData_, self.recordData_.plot_id[arg_7_1], self.data_.archive_id, arg_7_1, 1)
	else
		arg_7_2:SetData(self.recordData_, self.recordData_.super_plot_id[arg_7_1 - #self.plotIdList_], self.data_.archive_id, arg_7_1 - #self.plotIdList_, 2)
	end

	arg_7_2:SetStoryCallBack(function()
		saveData("ModuleList_" .. USER_ID, "PlotIndex_" .. self.data_.archive_id, arg_7_1)

		self.index_ = arg_7_1
	end)
end

function NewHeroArchiveDetailView:IndexStoryItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(HeroAnedoteCfg[self.storyList_[arg_9_1]], self.data_.archive_id)
end

function NewHeroArchiveDetailView:AddUIListener()
	self:AddBtnListener(self.backgroundBtn_, nil, function()
		JumpTools.OpenPageByJump("newHeroWallPaperPopView", {
			data = self.data_
		})
	end)
	self:AddBtnListener(self.giftBtn_, nil, function()
		table.sort(self.recordData_.hero_id, function(arg_13_0, arg_13_1)
			local var_13_0 = HeroData:GetHeroData(arg_13_0)
			local var_13_1 = HeroData:GetHeroData(arg_13_1)
			local var_13_2 = ArchiveData:GetTrustLevel(arg_13_0)
			local var_13_3 = ArchiveData:GetTrustLevel(arg_13_1)

			if var_13_0.unlock == 1 and var_13_1.unlock == 0 then
				return true
			elseif var_13_0.unlock == 0 and var_13_1.unlock == 1 then
				return false
			elseif var_13_3 < var_13_2 then
				return true
			elseif var_13_2 < var_13_3 then
				return false
			else
				return arg_13_0 < arg_13_1
			end
		end)
		JumpTools.GoToSystem("/heroArchive", {
			pageID = 3,
			heroID = self.recordData_.hero_id[1]
		})
	end)
end

function NewHeroArchiveDetailView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.isBackHome_ = self.params_.isBackHome

	manager.windowBar:RegistBackCallBack(function()
		if self.isBackHome_ then
			JumpTools.OpenPageByJump("/home")
		else
			JumpTools.Back()
		end
	end)

	self.id_ = self.params_.id
	self.data_ = ArchiveData:GetArchive(self.id_)
	self.recordData_ = HeroRecordCfg[self.data_.archive_id]
	self.index_ = getData("ModuleList_" .. USER_ID, "PlotIndex_" .. self.data_.archive_id) or 0
	self.plotIdList_ = self.recordData_.plot_id
	self.superPlotIdList_ = self.recordData_.super_plot_id

	self.uiList_:StartScroll(#self.plotIdList_ + #self.superPlotIdList_, self.index_, true, false)

	self.storyList_ = {}
	self.heroIdList_ = self.recordData_.hero_id

	local var_14_0 = self.uiList_:GetScrolledPosition()

	self.timer = Timer.New(function()
		self.filmAni_:SetFloat("floatSpeed", (self.uiList_:GetScrolledPosition().x - var_14_0.x) * 3)

		var_14_0 = self.uiList_:GetScrolledPosition()
	end, 0.1, -1, true)

	self.timer:Start()

	for iter_14_0, iter_14_1 in pairs(self.heroIdList_) do
		if HeroAnedoteCfg[iter_14_1] then
			table.insert(self.storyList_, iter_14_1)
		end
	end

	self.uiStoryList_:StartScroll(#self.storyList_)
	self:RefreshUI()

	local var_14_1 = HeroTools.GetHeroOntologyID(self.id_)

	manager.redPoint:setTip(RedPointConst.HERO_STORY_ID .. var_14_1, 0)
	manager.redPoint:setTip(RedPointConst.HERO_SUPER_STORY_ID .. var_14_1, 0)
	manager.redPoint:setTip(RedPointConst.HERO_ANEDOTE_ID .. var_14_1, 0)

	local var_14_2, var_14_3, var_14_4 = ArchiveData:GetUnlockHeartListInfoLengthByHeroId(self.id_)

	saveData("HearListRedPoint", "heartStroy_" .. PlayerData:GetPlayerInfo().userID .. "_" .. HeroRecordCfg.get_id_list_by_hero_id[self.id_][1], {
		var_14_2,
		var_14_3,
		var_14_4
	})
end

function NewHeroArchiveDetailView:RefreshUI()
	self.favorItemList_ = self.favorItemList_ or {}

	for iter_17_0, iter_17_1 in ipairs(self.favorItemList_) do
		SetActive(iter_17_1.gameObject_, false)
		iter_17_1:ResetData()
	end

	local var_17_0 = false

	for iter_17_2, iter_17_3 in ipairs(self.heroIdList_) do
		if ArchiveData:GetTrustLevel(iter_17_3) > 0 then
			var_17_0 = true
		end
	end

	local var_17_1 = 0

	for iter_17_4, iter_17_5 in ipairs(self.heroIdList_) do
		local var_17_2 = HeroData:GetHeroData(self.heroIdList_[iter_17_4])

		if var_17_2.unlock == 1 then
			var_17_1 = var_17_1 + 1

			if not self.favorItemList_[var_17_1] then
				local var_17_3 = NewHeroArchiveHerofavorItemView.New(Object.Instantiate(self.favorabilityItem_), var_17_1)

				var_17_3.transform_:SetParent(self.favorabilityList_, false)
				table.insert(self.favorItemList_, var_17_3)
			end

			self.favorItemList_[var_17_1]:SetData(self.data_, var_17_2.id, var_17_1)
			SetActive(self.favorItemList_[var_17_1].gameObject_, true)
		end
	end

	for iter_17_6, iter_17_7 in ipairs(self.favorItemList_) do
		iter_17_7:RefreshUI(var_17_0)
	end

	self.uiStoryList_:Refresh()
	self:RefreshBgUI()
end

function NewHeroArchiveDetailView:RefreshBgUI()
	local var_18_0 = ArchiveData:GetSelectPicture(self.data_.archive_id)

	self.bgController_:SetSelectedState("role")

	if table.isEmpty(var_18_0) or var_18_0.type == 0 then
		local var_18_1 = false

		for iter_18_0, iter_18_1 in ipairs(self.heroIdList_) do
			if HeroData:GetHeroData(iter_18_1).unlock == 1 and not var_18_1 then
				ArchiveAction.SendSetWallPaper(self.data_.archive_id, iter_18_1, 1)

				self.bgImg_.spriteSync = "TextureConfig/Character/Icon/" .. iter_18_1
				var_18_1 = true
			end
		end

		if not var_18_1 then
			self.bgImg_.spriteSync = "TextureConfig/Character/Icon/" .. self.heroIdList_[1]
		end
	elseif var_18_0.type == 1 or var_18_0.type == 2 then
		self.bgController_:SetSelectedState("role")

		self.bgImg_.spriteSync = "TextureConfig/Character/Portrait/" .. var_18_0.id
	elseif var_18_0.type == 3 then
		self.bgController_:SetSelectedState("plot")

		self.plotImg_.spriteDownload = "TextureConfig/Background/" .. CollectPictureCfg[var_18_0.id].picture
	end
end

function NewHeroArchiveDetailView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function NewHeroArchiveDetailView:OnReceiveIllustrationReward(arg_20_1, arg_20_2)
	getReward((mergeReward((formatRewardCfgList(arg_20_1.item_list)))))
	self:RefreshPlotList()
end

function NewHeroArchiveDetailView:OnReceiveIllustration()
	self:RefreshPlotList()
end

function NewHeroArchiveDetailView:RefreshPlotList()
	self.uiList_:Refresh()
	self.uiList_:ScrollToIndex(self.index_, true, false)
end

function NewHeroArchiveDetailView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	if self.uiStoryList_ then
		self.uiStoryList_:Dispose()

		self.uiStoryList_ = nil
	end

	if self.favorItemList_ then
		for iter_23_0, iter_23_1 in ipairs(self.favorItemList_) do
			iter_23_1:Dispose()
		end
	end

	NewHeroArchiveDetailView.super.Dispose(self)
	self:RemoveAllEventListener()
end

return NewHeroArchiveDetailView
