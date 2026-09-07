local VoteEntranceScene = class("VoteEntranceScene", import("view.base.BaseUI"))

VoteEntranceScene.MAIN_STAGE_CLOSE = 0
VoteEntranceScene.MAIN_STAGE_OPEN = 1
VoteEntranceScene.MAIN_STAGE_FINAL = 2
VoteEntranceScene.MAIN_STAGE_END = 3
VoteEntranceScene.SUB_STAGE_CLOSE = 0
VoteEntranceScene.SUB_STAGE_META = 1
VoteEntranceScene.SUB_STAGE_KID = 2
VoteEntranceScene.SUB_STAGE_SIREN = 3
VoteEntranceScene.EXCHANGE_STAGE_CLOSE = 0
VoteEntranceScene.EXCHANGE_STAGE_OPEN = 1
VoteEntranceScene.BILLBOARD_STAGE_NORMAL = 0
VoteEntranceScene.BILLBOARD_STAGE_FINAL = 1

function VoteEntranceScene:getUIName()
	return "VoteEntranceUI"
end

function VoteEntranceScene:init()
	self.backBtn = self._tf:Find("frame/back")
	self.homeBtn = self._tf:Find("frame/home")
	self.helpBtn = self._tf:Find("frame/help")
	self.votesTr = self._tf:Find("frame/votes")
	self.votesTxt = self._tf:Find("frame/votes/Text"):GetComponent(typeof(Text))
	self.scheduleTr = self._tf:Find("frame/schedule")
	self.scheduleTxt = self.scheduleTr:Find("Text"):GetComponent(typeof(Text))
	self.scheduleImg = self.scheduleTr:GetComponent(typeof(Image))
	self.awardBtn = self._tf:Find("frame/award")
	self.mainTr = self._tf:Find("bg/main"):GetComponent(typeof(Image))
	self.mainTip = self.mainTr.gameObject.transform:Find("tip")
	self.mainTitle = self.mainTr.gameObject.transform:Find("title")
	self.awardItem = self._tf:Find("bg/main/item")
	self.dropTr = self.awardItem:Find("Award")
	self.dropGetTr = self.awardItem:Find("get")
	self.dropGotTr = self.awardItem:Find("got")
	self.subTr = self._tf:Find("bg/sub"):GetComponent(typeof(Image))
	self.subTip = self.subTr.gameObject.transform:Find("tip")
	self.subTitle = self.subTr.gameObject.transform:Find("title")
	self.exchangeTr = self._tf:Find("bg/exchange"):GetComponent(typeof(Image))
	self.exchangeTip = self.exchangeTr.gameObject.transform:Find("tip")
	self.exchangeTitle = self.exchangeTr.gameObject.transform:Find("title")
	self.billboardTr = self._tf:Find("bg/billboard"):GetComponent(typeof(Image))
	self.billboardTip = self.billboardTr.gameObject.transform:Find("tip")
	self.honorTr = self._tf:Find("bg/honor"):GetComponent(typeof(Image))
	self.honorTip = self.honorTr.gameObject.transform:Find("tip")
	self.awardWindowPage = VoteAwardWindowPage.New(self._tf, self.event)

	VoteStoryUtil.Notify(VoteStoryUtil.ENTER_SCENE)
	setActive(self.dropGetTr, false)
	setActive(self.dropGotTr, false)

	return
end

function VoteEntranceScene:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(VoteEntranceScene.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.homeBtn, function()
		self:emit(VoteEntranceScene.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.vote_help_2025.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.awardBtn, function()
		self.awardWindowPage:ExecuteAction("Show")

		return
	end, SFX_PANEL)

	self.voteActivity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VOTE)

	self:FlushAll()

	return
end

function VoteEntranceScene:FlushAll()
	self.allPreheatStoriesPlayed = VoteStoryUtil.AllPreheatStoriesPlayed()

	self:UpdateSchedule()
	self:UpdateVotes()
	self:UpdateMainEntrance()
	self:UpdateSubEntrance()
	self:UpdateExchangeEntrance()
	self:UpdateBillboardEntrance()
	self:UpdateHonorEntrance()

	return
end

function VoteEntranceScene:UpdateSchedule()
	if not self.allPreheatStoriesPlayed then
		setActive(self.scheduleTr, false)

		return
	end

	local var_9_0 = getProxy(VoteProxy):GetOpeningNonFunVoteGroup()

	var_9_0 = var_9_0 or getProxy(VoteProxy):GetOpeningFunVoteGroup()

	setActive(self.scheduleTr, var_9_0 ~= nil)

	if var_9_0 then
		self.scheduleTxt.text = var_9_0:getConfig("name")
	end

	local var_9_1 = "schedule_bg"

	if var_9_0 and var_9_0:isFinalsRace() then
		var_9_1 = "schedule_bg_finals"
	elseif var_9_0 and var_9_0:isResurrectionRace() then
		var_9_1 = "schedule_bg_resurrection"
	elseif var_9_0 and var_9_0:IsFunMetaRace() then
		var_9_1 = "schedule_bg_meta"
	elseif var_9_0 and var_9_0:IsFunSireRace() then
		var_9_1 = "schedule_bg_sire"
	elseif var_9_0 and var_9_0:IsFunKidRace() then
		var_9_1 = "schedule_bg_kid"
	end

	self.scheduleImg.sprite = GetSpriteFromAtlas("ui/Vote2023MainUI_atlas", var_9_1)

	return
end

function VoteEntranceScene:UpdateVotes()
	if not self.allPreheatStoriesPlayed then
		setActive(self.votesTr, false)
		setActive(self.awardBtn, false)

		return
	end

	setActive(self.awardBtn, not getProxy(VoteProxy):IsAllRaceEnd())

	local var_10_0 = getProxy(VoteProxy):GetOpeningNonFunVoteGroup()

	var_10_0 = var_10_0 or getProxy(VoteProxy):GetOpeningFunVoteGroup()

	setActive(self.votesTr, var_10_0 ~= nil)

	self.votesTxt.text = var_10_0 and var_10_0:IsFunRace() and self:GetSubVotes() or self:GetVotes()

	return
end

function VoteEntranceScene:UpdateMainEntrance()
	self.mainTr.sprite = GetSpriteFromAtlas("ui/Vote2023MainUI_atlas", "icon_main_" .. self:GetMainStageState())

	onButton(self, self.mainTr.gameObject, function()
		VoteStoryUtil.Notify(VoteStoryUtil.ENTER_MAIN_STAGE)

		if self:ShouldPlayMainStory() then
			return
		end

		if not self:CheckPreheatStories() then
			return
		end

		self:MarkMainRaceNonNew()

		if self:ExistMainStageAward() then
			self:emit(VoteEntranceMediator.SUBMIT_TASK)

			return
		end

		self:emit(VoteEntranceMediator.ON_VOTE)

		return
	end, SFX_PANEL)
	self:UpdateMainAward()

	local var_11_0 = getProxy(VoteProxy):GetOpeningNonFunVoteGroup()

	setGray(self.mainTitle, not (var_11_0 and var_11_0:IsOpening() or self:ExistMainStageAward() or self:ShouldPlayMainStory()), true)
	self:UpdateMainStageTip()

	return
end

function VoteEntranceScene:UpdateMainAward()
	local var_13_0 = self:GetMainStageState() == VoteEntranceScene.MAIN_STAGE_END
	local var_13_1 = false

	if var_13_0 then
		local var_13_2 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID):getConfig("config_client")[2] or -1

		updateDrop(self.dropTr, {
			type = pg.task_data_template[var_13_2].award_display[1][1],
			id = pg.task_data_template[var_13_2].award_display[1][2],
			count = pg.task_data_template[var_13_2].award_display[1][3]
		})

		local var_13_3 = getProxy(TaskProxy):getTaskById(var_13_2)

		var_13_3 = var_13_3 or getProxy(TaskProxy):getFinishTaskById(var_13_2)

		local var_13_4

		if var_13_3 then
			::label_13_0::

			var_13_1 = var_13_3:isFinish()
			var_13_4 = var_13_3 and var_13_3:isFinish() and not var_13_3:isReceive()
		end

		setActive(self.dropGetTr, var_13_4)
		setActive(self.dropGotTr, var_13_3 and var_13_3:isFinish() and var_13_3:isReceive())
	end

	setActive(self.awardItem, var_13_0 and var_13_1)

	return
end

function VoteEntranceScene:UpdateMainStageTip()
	setActive(self.mainTip, self:ShouldTipMainStage())

	return
end

function VoteEntranceScene:UpdateSubEntrance()
	self.subTr.sprite = GetSpriteFromAtlas("ui/Vote2023MainUI_atlas", "icon_sub_" .. self:GetSubStageState())

	self:UpdateSubStageTip()
	onButton(self, self.subTr.gameObject, function()
		VoteStoryUtil.Notify(VoteStoryUtil.ENTER_SUB_STAGE)

		if self:ShouldPlaySubStory() then
			return
		end

		if not self:CheckPreheatStories() then
			return
		end

		self:MarkSubRaceNonNew()
		self:emit(VoteEntranceMediator.ON_FUN_VOTE)

		return
	end, SFX_PANEL)

	local var_15_0 = getProxy(VoteProxy):GetOpeningFunVoteGroup()

	setGray(self.subTitle, not (var_15_0 and var_15_0:IsOpening() or self:ShouldPlaySubStory()), true)

	return
end

function VoteEntranceScene:UpdateSubStageTip()
	setActive(self.subTip, self:ShouldTipSubStage())

	return
end

function VoteEntranceScene:UpdateExchangeEntrance()
	self.exchangeTr.sprite = GetSpriteFromAtlas("ui/Vote2023MainUI_atlas", "icon_exchange_" .. self:GetExchangeState())

	self:UpdateExchangeTip()
	onButton(self, self.exchangeTr.gameObject, function()
		VoteStoryUtil.Notify(VoteStoryUtil.ENTER_EXCHANGE)

		if self:ShouldPlayExchangeStory() then
			return
		end

		if not self:CheckPreheatStories() then
			return
		end

		if getProxy(PlayerProxy):getRawData().level < 25 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("vote_tip_level_limit"))

			return
		end

		self:emit(VoteEntranceMediator.ON_EXCHANGE)

		return
	end, SFX_PANEL)

	local var_18_0 = getProxy(VoteProxy):GetOpeningNonFunVoteGroup()

	setGray(self.exchangeTitle, not (var_18_0 and var_18_0:IsOpening() or self:ShouldPlayExchangeStory()), true)

	return
end

function VoteEntranceScene:UpdateExchangeTip()
	setActive(self.exchangeTip, self:ShouldTipExchange())

	return
end

function VoteEntranceScene:UpdateBillboardEntrance()
	self.billboardTr.sprite = GetSpriteFromAtlas("ui/Vote2023MainUI_atlas", "icon_billboard_" .. self:GetBillboardState())

	self:UpdateBillboardTip()
	onButton(self, self.billboardTr.gameObject, function()
		VoteStoryUtil.Notify(VoteStoryUtil.ENTER_SCHEDULE)

		if self:ShouldPlayBillboardStory() then
			return
		end

		if not self:CheckPreheatStories() then
			return
		end

		self:emit(VoteEntranceMediator.ON_SCHEDULE)

		return
	end, SFX_PANEL)

	return
end

function VoteEntranceScene:UpdateBillboardTip()
	setActive(self.billboardTip, self:ShouldTipBillboard())

	return
end

function VoteEntranceScene:UpdateHonorEntrance()
	self:UpdateHonorTip()
	onButton(self, self.honorTr.gameObject, function()
		VoteStoryUtil.Notify(VoteStoryUtil.ENTER_HALL)

		if self:ShouldPlayHonorStory() then
			return
		end

		if not self:CheckPreheatStories() then
			return
		end

		self:emit(VoteEntranceMediator.GO_HALL)

		return
	end, SFX_PANEL)

	return
end

function VoteEntranceScene:UpdateHonorTip()
	setActive(self.honorTip, self:ShouldTipHonor())

	return
end

function VoteEntranceScene:onBackPressed()
	if self.awardWindowPage and self.awardWindowPage:GetLoaded() and self.awardWindowPage:isShowing() then
		self.awardWindowPage:Hide()

		return
	end

	VoteEntranceScene.super.onBackPressed(self)

	return
end

function VoteEntranceScene:willExit()
	if self.awardWindowPage then
		self.awardWindowPage:Destroy()

		self.awardWindowPage = nil
	end

	return
end

function VoteEntranceScene:ExistMainStageAward()
	local var_29_0 = getProxy(TaskProxy)
	local var_29_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	if not var_29_1 or var_29_1:isEnd() then
		return false
	end

	local var_29_2 = var_29_1:getConfig("config_client")[2] or -1
	local var_29_3 = var_29_0:getTaskById(var_29_2) or var_29_0:getFinishTaskById(var_29_2)

	return var_29_3 and var_29_3:isFinish() and not var_29_3:isReceive()
end

function VoteEntranceScene:GetMainStageState()
	if not self.allPreheatStoriesPlayed then
		return VoteEntranceScene.MAIN_STAGE_CLOSE
	end

	local var_30_0 = getProxy(VoteProxy):GetOpeningNonFunVoteGroup()

	if getProxy(VoteProxy):IsAllRaceEnd() then
		return VoteEntranceScene.MAIN_STAGE_END
	elseif var_30_0 then
		if var_30_0:isFinalsRace() then
			return VoteEntranceScene.MAIN_STAGE_FINAL
		else
			return VoteEntranceScene.MAIN_STAGE_OPEN
		end
	else
		return VoteEntranceScene.MAIN_STAGE_CLOSE
	end

	return
end

function VoteEntranceScene:ShouldTipMainStage()
	if not self.allPreheatStoriesPlayed then
		return self:ShouldPlayMainStory()
	else
		return self:GetVotes() > 0 or self:IsNewMainRace() or self:ShouldPlayMainStory() or isActive(self.dropGetTr)
	end

	return
end

function VoteEntranceScene:ShouldPlayMainStory()
	local var_32_0 = self.voteActivity and (not self.voteActivity:isEnd() and not pg.NewStoryMgr.GetInstance():IsPlayed((VoteStoryUtil.GetStoryNameByType(VoteStoryUtil.ENTER_MAIN_STAGE))) or false)

	return (false or nil) and true
end

function VoteEntranceScene:IsNewMainRace()
	return getProxy(VoteProxy):IsNewRace((getProxy(VoteProxy):GetOpeningNonFunVoteGroup()))
end

function VoteEntranceScene:MarkMainRaceNonNew()
	getProxy(VoteProxy):MarkRaceNonNew((getProxy(VoteProxy):GetOpeningNonFunVoteGroup()))

	return
end

function VoteEntranceScene:GetSubStageState()
	if not self.allPreheatStoriesPlayed then
		return VoteEntranceScene.SUB_STAGE_CLOSE
	end

	local var_35_0 = getProxy(VoteProxy):GetOpeningFunVoteGroup()

	if var_35_0 then
		if var_35_0:IsFunSireRace() then
			return VoteEntranceScene.SUB_STAGE_SIREN
		elseif var_35_0:IsFunMetaRace() then
			return VoteEntranceScene.SUB_STAGE_META
		elseif var_35_0:IsFunKidRace() then
			return VoteEntranceScene.SUB_STAGE_KID
		else
			assert(false)
		end
	else
		return VoteEntranceScene.SUB_STAGE_CLOSE
	end

	return
end

function VoteEntranceScene:ShouldTipSubStage()
	if not self.allPreheatStoriesPlayed then
		return self:ShouldPlaySubStory()
	else
		return self:GetSubVotes() > 0 or self:IsNewSubRace() or self:ShouldPlaySubStory()
	end

	return
end

function VoteEntranceScene:ShouldPlaySubStory()
	local var_37_0 = self.voteActivity and (not self.voteActivity:isEnd() and not pg.NewStoryMgr.GetInstance():IsPlayed((VoteStoryUtil.GetStoryNameByType(VoteStoryUtil.ENTER_SUB_STAGE))) or false)

	return (false or nil) and true
end

function VoteEntranceScene:IsNewSubRace()
	return getProxy(VoteProxy):IsNewRace((getProxy(VoteProxy):GetOpeningFunVoteGroup()))
end

function VoteEntranceScene:MarkSubRaceNonNew()
	getProxy(VoteProxy):MarkRaceNonNew((getProxy(VoteProxy):GetOpeningFunVoteGroup()))

	return
end

function VoteEntranceScene:GetExchangeState()
	if not self.allPreheatStoriesPlayed then
		return VoteEntranceScene.EXCHANGE_STAGE_CLOSE
	end

	if getProxy(VoteProxy):GetOpeningNonFunVoteGroup() then
		return VoteEntranceScene.EXCHANGE_STAGE_OPEN
	else
		return VoteEntranceScene.EXCHANGE_STAGE_CLOSE
	end

	return
end

function VoteEntranceScene:ShouldTipExchange()
	return self:ShouldPlayExchangeStory()
end

function VoteEntranceScene:ShouldPlayExchangeStory()
	local var_42_0 = self.voteActivity and (not self.voteActivity:isEnd() and not pg.NewStoryMgr.GetInstance():IsPlayed((VoteStoryUtil.GetStoryNameByType(VoteStoryUtil.ENTER_EXCHANGE))) or false)

	return (false or nil) and true
end

function VoteEntranceScene:GetBillboardState()
	if not self.allPreheatStoriesPlayed then
		return VoteEntranceScene.BILLBOARD_STAGE_NORMAL
	end

	local var_43_0 = getProxy(VoteProxy):GetOpeningNonFunVoteGroup()

	if var_43_0 and var_43_0:isFinalsRace() then
		return VoteEntranceScene.BILLBOARD_STAGE_FINAL
	else
		return VoteEntranceScene.BILLBOARD_STAGE_NORMAL
	end

	return
end

function VoteEntranceScene:ShouldTipBillboard()
	return self:ShouldPlayBillboardStory()
end

function VoteEntranceScene:ShouldPlayBillboardStory()
	local var_45_0 = self.voteActivity and (not self.voteActivity:isEnd() and not pg.NewStoryMgr.GetInstance():IsPlayed((VoteStoryUtil.GetStoryNameByType(VoteStoryUtil.ENTER_SCHEDULE))) or false)

	return (false or nil) and true
end

function VoteEntranceScene:ShouldTipHonor()
	if not self.allPreheatStoriesPlayed then
		return self:ShouldPlayHonorStory()
	else
		local var_46_0 = getProxy(VoteProxy):ExistPastVoteAward()

		var_46_0 = var_46_0 or self:ShouldPlayHonorStory()

		return var_46_0
	end

	return
end

function VoteEntranceScene:ShouldPlayHonorStory()
	local var_47_0 = self.voteActivity and (not self.voteActivity:isEnd() and not pg.NewStoryMgr.GetInstance():IsPlayed((VoteStoryUtil.GetStoryNameByType(VoteStoryUtil.ENTER_HALL))) or false)

	return (false or nil) and true
end

function VoteEntranceScene:GetVotes()
	local var_48_0 = self:GetMainStageState()

	if var_48_0 == VoteEntranceScene.MAIN_STAGE_OPEN or var_48_0 == VoteEntranceScene.MAIN_STAGE_FINAL then
		local var_48_1 = getProxy(VoteProxy):GetOpeningNonFunVoteGroup()

		return (var_48_1 or nil) and (getProxy(VoteProxy):GetVotesByConfigId(var_48_1.configId) or 0)
	end

	return 0
end

function VoteEntranceScene:GetSubVotes()
	if VoteEntranceScene.SUB_STAGE_CLOSE ~= self:GetSubStageState() then
		local var_49_0 = getProxy(VoteProxy):GetOpeningFunVoteGroup()

		return (var_49_0 or nil) and (getProxy(VoteProxy):GetVotesByConfigId(var_49_0.configId) or 0)
	else
		return 0
	end

	return
end

function VoteEntranceScene:CheckPreheatStories()
	if not self.allPreheatStoriesPlayed then
		pg.NewGuideMgr.GetInstance():Play("NG0043")

		return false
	end

	return true
end

return VoteEntranceScene
