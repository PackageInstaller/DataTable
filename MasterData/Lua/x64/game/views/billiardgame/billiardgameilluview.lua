local BilliardGameIlluView = class("BilliardGameIlluView", ReduxView)

function BilliardGameIlluView:UIName()
	return "Widget/System/Activity_SummerPub/BilliardGame/BilliardGame_IllustratedPopUI"
end

function BilliardGameIlluView:UIParent()
	return manager.ui.uiPop.transform
end

function BilliardGameIlluView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BilliardGameIlluView:InitUI()
	self:BindCfgUI()

	self.itemScroll_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, BilliardGameIlluItemView)
	self.tabController_ = self.exController_:GetController("tab")
	self.lockController_ = self.exController_:GetController("lock")
	self.movie_ = self.movieGo_:GetComponent("CriManaMovieControllerForUI")
	self.moviePlayer_ = self.movie_.player
	self.moviePlayer_.uiRenderMode = true
	self.playingItemId_ = nil
	self.startTimer_ = nil
	self.stopTimer_ = nil
end

function BilliardGameIlluView:AddUIListener()
	self.AddBtnListener(self, self.btnMon_, self, function()
		self:EnterTag(1, true)
	end)
	self:AddBtnListener(self.btnBorgan_, nil, function()
		self:EnterTag(2, true)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Clear()
		self:Back()
	end)
end

function BilliardGameIlluView:EnterTag(arg_9_1, arg_9_2)
	if self.tagType == arg_9_1 then
		return
	end

	self.tagType = arg_9_1

	if arg_9_1 == 1 then
		self.tabController_:SetSelectedIndex(0)
	else
		self.tabController_:SetSelectedIndex(1)
	end

	self:UpdateItemData(arg_9_1, 1)
	self.itemScroll_:StartScroll(#self.itemList_)
	self:SetSelectItem(1, true)

	if arg_9_2 then
		self.ani_:Play("UI_base", -1, 0)
	end
end

function BilliardGameIlluView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.stageId = self.params_.stageId

	local var_10_0 = false

	if self.stageId then
		if #self:GetListByTypeFromStage(2) > 0 then
			var_10_0 = true
		end
	else
		var_10_0 = true

		manager.redPoint:bindUIandKey(self.btnMon_.transform, RedPointConst.SUMMER_PUB_ILLUSTRATION_MON)
		manager.redPoint:bindUIandKey(self.btnBorgan_.transform, RedPointConst.SUMMER_PUB_ILLUSTRATION_BORGAN)
	end

	SetActive(self.btnBorgan_.gameObject, var_10_0)

	self.activity_ = ActivityConst.ACTIVITY_NYA_SUMMER_PUB
	self.tagType = -1

	self:EnterTag(1)
end

function BilliardGameIlluView:OnExit()
	manager.redPoint:unbindUIandKey(self.btnMon_.transform, RedPointConst.SUMMER_PUB_ILLUSTRATION_MON)
	manager.redPoint:unbindUIandKey(self.btnBorgan_.transform, RedPointConst.SUMMER_PUB_ILLUSTRATION_BORGAN)
	self:Clear()
	BilliardGameIlluView.super.OnExit(self)
end

function BilliardGameIlluView:Dispose()
	self.itemScroll_:Dispose()
	BilliardGameIlluView.super.Dispose(self)
end

function BilliardGameIlluView:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:RegisterBtnListener(handler(self, self.SetSelectItem))
	arg_13_2:RefreshUI(arg_13_1, self.itemList_[arg_13_1])
end

function BilliardGameIlluView:UpdateItemData(arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(self.itemList_ or {}) do
		self.itemList_[iter_14_0] = nil
	end

	self.itemList_ = {}

	local var_14_1 = SummerPubData:GetIlluInfo()

	for iter_14_2, iter_14_3 in ipairs(self.stageId and self:GetListByTypeFromStage(arg_14_1) or BilliardIllustrationsCfg.get_id_list_by_activity_id_type[self.activity_][arg_14_1] or {}) do
		local var_14_3 = {
			id = iter_14_3
		}

		if var_14_1[iter_14_3] then
			var_14_3.active = true
			var_14_3.viewState = var_14_1[iter_14_3]
		else
			var_14_3.active = not not self.stageId
		end

		var_14_3.select = iter_14_2 == arg_14_2

		table.insert(self.itemList_, var_14_3)
	end

	table.sort(self.itemList_, function(arg_15_0, arg_15_1)
		return arg_15_0.id < arg_15_1.id
	end)
end

function BilliardGameIlluView:GetListByTypeFromStage(arg_16_1)
	local var_16_0 = BilliardStageCfg[self.stageId].stage_illustration

	if BilliardStageCfg[self.stageId].stage_illustration == "" then
		var_16_0 = {}
	end

	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if BilliardIllustrationsCfg[iter_16_1].type == arg_16_1 then
			table.insert(var_16_1, iter_16_1)
		end
	end

	return var_16_1
end

function BilliardGameIlluView:SetSelectItem(arg_17_1, arg_17_2)
	if not arg_17_2 and self.selectItem_ == arg_17_1 then
		return
	end

	if self.itemList_[self.selectItem_] then
		self.itemList_[self.selectItem_].select = false
	end

	self.selectItem_ = arg_17_1

	if self.itemList_[self.selectItem_] then
		self.itemList_[self.selectItem_].select = true
		self.itemList_[self.selectItem_].viewState = 2
	end

	for iter_17_0, iter_17_1 in pairs((self.itemScroll_:GetItemList())) do
		iter_17_1:ShowSelect(arg_17_1 == iter_17_0)
	end

	if self.itemList_[self.selectItem_] then
		self:RefreshPanelDesc(self.itemList_[self.selectItem_])
		self:StopDelayTimer()

		self.delayTimer = FrameTimer.New(function()
			self:RefreshPanelMovie(self.itemList_[self.selectItem_].id)
		end, 1, 2)

		self.delayTimer:Start()
	else
		self:RefreshPanelDesc(nil)
	end

	SummerPubAction.ViewIllustration(self.itemList_[self.selectItem_].id)
end

function BilliardGameIlluView:StopDelayTimer()
	if self.delayTimer then
		self.delayTimer:Stop()

		self.delayTimer = nil
	end
end

function BilliardGameIlluView:RefreshPanelDesc(arg_20_1)
	if arg_20_1 then
		if arg_20_1.active then
			self.lockController_:SetSelectedIndex(1)

			self.nameText_.text = GetI18NText(BilliardIllustrationsCfg[arg_20_1.id].name)
			self.descText_.text = GetI18NText(BilliardIllustrationsCfg[arg_20_1.id].desc)
			self.skillDescText_.text = GetI18NText(BilliardIllustrationsCfg[arg_20_1.id].skill_desc)
			self.unlockMonImage_.sprite = pureGetSpriteWithoutAtlas(BilliardIllustrationsCfg[arg_20_1.id].icon)

			self.monUnlockAni_:Play("UI_Monstericon", -1, 0)
			self.monUnlockAni_:Update(0)
		else
			self.monLockAni_:Play("UI_Monstericon", -1, 0)
			self.monLockAni_:Update(0)
			self.lockController_:SetSelectedIndex(0)
		end
	else
		self.monLockAni_:Play("UI_Monstericon", -1, 0)
		self.monLockAni_:Update(0)
		self.lockController_:SetSelectedState(0)
	end
end

function BilliardGameIlluView:RefreshPanelMovie(arg_21_1)
	local var_21_0 = self:HasMovie(arg_21_1)

	if self.moviePlayer_ and tostring(self.moviePlayer_.status) == "Playing" and arg_21_1 == self.playingItemId_ then
		return
	end

	if self.playingItemId_ ~= nil and arg_21_1 ~= self.playingItemId_ then
		self.movie_:Stop()
		BilliardGameIlluView:StopMovieStopTimer()

		self.movieRaw_.material = nil
		self.stopTimer_ = FrameTimer.New(function(...)
			if self.moviePlayer_ and tostring(self.moviePlayer_.status) == "Stop" then
				self.playingItemId_ = nil

				self:StopMovieStopTimer()

				if var_21_0 then
					self:StartMovie(arg_21_1)
				end
			end
		end, 1, -1)

		self.stopTimer_:Start()
	end

	if self.playingItemId_ == nil and var_21_0 then
		self:StartMovie(arg_21_1)
	end
end

function BilliardGameIlluView:StartMovie(arg_23_1)
	self.start_path = BilliardIllustrationsCfg[arg_23_1].video

	self:Play()

	self.playingItemId_ = arg_23_1

	self:StopStartMovieTimer()

	self.startTimer_ = FrameTimer.New(function()
		if self.movie_ and self.movie_.isMaterialAvailable then
			self:StopStartMovieTimer()
		end
	end, 1, -1)

	self.startTimer_:Start()
end

function BilliardGameIlluView:HasMovie(arg_25_1)
	return not not (self.itemList_[self.selectItem_] and self.itemList_[self.selectItem_].active)
end

function BilliardGameIlluView:Play()
	SetFile(self.moviePlayer_, nil, self.start_path, CriMana.Player.SetMode.New)
	self.moviePlayer_:Prepare()
	self.moviePlayer_:SetVolume((manager.audio:GetMusicVolume()))
	self:SetVideoTrack(self.moviePlayer_, self.start_path)
	self.movie_:Play()
end

function BilliardGameIlluView:SetVideoTrack(arg_27_1, arg_27_2)
	local var_27_0 = manager.video:GetVedioTrackIndex(arg_27_2)

	arg_27_1:SetAudioTrack(var_27_0)
	arg_27_1:SetSubtitleChannel(var_27_0)
end

function BilliardGameIlluView:StopMovieStopTimer()
	if self.stopTimer_ then
		self.stopTimer_:Stop()

		self.stopTimer_ = nil
	end
end

function BilliardGameIlluView:StopStartMovieTimer()
	if self.startTimer_ then
		self.startTimer_:Stop()

		self.startTimer_ = nil
	end
end

function BilliardGameIlluView:Clear()
	if self.movie_ then
		self.movie_:Stop()
	end

	self:StopDelayTimer()
	self:StopStartMovieTimer()
	self:StopMovieStopTimer()

	self.playingItemId_ = nil
end

return BilliardGameIlluView
