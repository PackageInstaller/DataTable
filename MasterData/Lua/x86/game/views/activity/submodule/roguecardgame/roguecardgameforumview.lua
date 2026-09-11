local RogueCardGameForumView = class("RogueCardGameForumView", ReduxView)

function RogueCardGameForumView:UIName()
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_ForumUI"
end

function RogueCardGameForumView:UIParent()
	return manager.ui.uiMain.transform
end

function RogueCardGameForumView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueCardGameForumView:InitUI()
	self:BindCfgUI()

	self.btnConList_ = {}

	for iter_4_0 = 1, 4 do
		self.btnConList_[iter_4_0] = self["btnCon_" .. iter_4_0]:GetController("select")
	end

	self.selectToggle = 1
	self.postList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, RogueCardGameForumItem)
	self.defaultCon_ = self.fansTitleController_:GetController("default0")
	self.qualityCon_ = self.fansTitleController_:GetController("quality")
	self.onRefreshBtnConHandler = handler(self, self.OnRefreshBtnCon)
end

function RogueCardGameForumView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.postDataList_[arg_5_1])
end

function RogueCardGameForumView:AddUIListener()
	self:AddBtnListener(self.allBtn_, nil, function()
		self.selectToggle = 1

		self:RefreshView()
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		self.selectToggle = 2

		self:RefreshView()
	end)
	self:AddBtnListener(self.talkBtn_, nil, function()
		self.selectToggle = 3

		self:RefreshView()
	end)
	self:AddBtnListener(self.callBackBtn_, nil, function()
		self.selectToggle = 4

		self:RefreshView()
	end)
	self:AddBtnListener(self.tipsBtn_, nil, function()
		if self.tipsGo_.activeSelf == false then
			SetActive(self.tipsGo_, true)
		else
			SetActive(self.tipsGo_, false)
		end
	end)
	self:AddBtnListener(self.tipsBtn_2, nil, function()
		if self.tipsGo_.activeSelf == false then
			SetActive(self.tipsGo_, true)
		else
			SetActive(self.tipsGo_, false)
		end
	end)
end

function RogueCardGameForumView:StopUpdateTimer()
	if self.updateTimer then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end
end

function RogueCardGameForumView:UpdateTimeTxt()
	local var_14_0 = os.time()
	local var_14_1 = os.date("!*t", var_14_0 + os.difftime(var_14_0, os.time(os.date("!*t", var_14_0))))

	self.dayText_.text = string.format("%s/%s", var_14_1.month, var_14_1.day)
	self.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function RogueCardGameForumView:OnEnter()
	SetActive(self.tipsGo_, false)
	self:RefreshView()
	self:RegistEventListener(ROGUE_CARD_GAME_REFRESH_BTNCON, self.onRefreshBtnConHandler)
end

function RogueCardGameForumView:OnEnterOver()
	if self.params_.isTips then
		self.isTips = self.params_.isTips
		self.params_.isTips = nil
	end

	if self.isTips then
		JumpTools.OpenPageByJump("rogueCardGameForumPopView", {
			postId = RogueCardGameTools.GetCurPostingId()
		})

		return
	end

	if self.params_.isSettle and RogueCardGameTools.GetSettleFirst() then
		self:OpenSettlePopView()

		self.params_.isSettle = nil
	end
end

function RogueCardGameForumView:OpenSettlePopView()
	JumpTools.OpenPageByJump("rogueCardGameReportPopView")
end

function RogueCardGameForumView:RefreshView()
	self.selectToggle = self.selectToggle or 1
	self.postDataList_ = RogueCardGameTools.GetPostDataList(self.selectToggle)

	for iter_18_0 = 1, #self.btnConList_ do
		if iter_18_0 == self.selectToggle then
			self.btnConList_[iter_18_0]:SetSelectedIndex(1)
		else
			self.btnConList_[iter_18_0]:SetSelectedIndex(0)
		end
	end

	self.postList_:StartScrollByPosition(#self.postDataList_, (self.postList_:GetScrolledPosition()))
	self:RefreshLeft()
	self:RefreshBtnCon()
end

function RogueCardGameForumView:RefreshBtnCon()
	local var_19_0, var_19_1 = RogueCardGameForumView:GetBtnConResult((RogueCardGameTools.GetPostDataList(1)))

	SetActive(self.newGo_1, var_19_0)
	SetActive(self.newTalkGo_1, var_19_1)

	if var_19_0 and var_19_1 then
		SetActive(self.newGo_1, var_19_0)
		SetActive(self.newTalkGo_1, false)
	end

	local var_19_2, var_19_3 = RogueCardGameForumView:GetBtnConResult((RogueCardGameTools.GetPostDataList(2)))

	SetActive(self.newGo_2, var_19_2)
	SetActive(self.newTalkGo_2, var_19_3)

	if var_19_2 and var_19_3 then
		SetActive(self.newGo_2, var_19_2)
		SetActive(self.newTalkGo_2, false)
	end

	local var_19_4, var_19_5 = RogueCardGameForumView:GetBtnConResult((RogueCardGameTools.GetPostDataList(3)))

	SetActive(self.newGo_3, var_19_4)
	SetActive(self.newTalkGo_3, var_19_5)

	if var_19_4 and var_19_5 then
		SetActive(self.newGo_3, var_19_4)
		SetActive(self.newTalkGo_3, fasle)
	end

	local var_19_6, var_19_7 = RogueCardGameForumView:GetBtnConResult((RogueCardGameTools.GetPostDataList(4)))

	SetActive(self.newTalkGo_4, var_19_7)
end

function RogueCardGameForumView:GetBtnConResult(arg_20_1)
	local var_20_0 = false
	local var_20_1 = false

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		if not RogueCardGameTools.IsViewPost(iter_20_1) then
			var_20_0 = true
		end

		local var_20_2 = RogueCardGameData:GetPostInfoById(iter_20_1)
		local var_20_3 = false

		for iter_20_2, iter_20_3 in ipairs(RogueCardPostingCfg[iter_20_1].comments) do
			if RogueCardCommentCfg[iter_20_3].comment_show == 1 then
				var_20_3 = true
			end
		end

		if var_20_2.complete_state == 1 and var_20_3 and RogueCardGameTools.GetIsFinishPreById(iter_20_1) then
			var_20_1 = true
		end
	end

	return var_20_0, var_20_1
end

function RogueCardGameForumView:RefreshLeft()
	self.nameText_.text = GetTips("ROGUE_CARD_ACCOUNT_NAME")
	self.tipsText_.text = GetTips("ROGUE_CARD_ACCOUNT_TIPS")

	local var_21_0 = RogueCardGameData:GetFansNum()
	local var_21_1 = 0

	for iter_21_0, iter_21_1 in ipairs(GameSetting.rogue_card_title_condition.value) do
		if iter_21_1 <= var_21_0 then
			var_21_1 = iter_21_0
		end
	end

	if var_21_1 <= 0 then
		self.defaultCon_:SetSelectedIndex(0)
	else
		self.defaultCon_:SetSelectedIndex(1)
		self.qualityCon_:SetSelectedIndex(var_21_1 - 1)

		self.fansTitleText_.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_21_1)
	end

	self.fansText_.text = string.format("%.1f", RogueCardGameData:GetFansNum() / 1000) .. "k"
	self.lookText_.text = string.format("%.1f", RogueCardGameData:GetViewsNum() / 1000) .. "k"
	self.niceText_.text = string.format("%.1f", RogueCardGameData:GetLikeNum() / 1000) .. "k"
	self.commentText_.text = RogueCardGameData:GetTalksNum()
end

function RogueCardGameForumView:OnRefreshBtnCon(arg_22_1)
	self:RefreshUIListItem(arg_22_1, (table.indexof(self.postDataList_, arg_22_1)))
	self:RefreshLeft()
	self:RefreshBtnCon()
end

function RogueCardGameForumView:RefreshUIListItem(arg_23_1, arg_23_2)
	if self.postList_ then
		self.postList_:GetItemByIndex(arg_23_2):SetData(arg_23_1)
	end
end

function RogueCardGameForumView:OnTop()
	if self.params_.isStory2Back then
		SetActive(self.tipsGo_, false)
		self:RefreshView()
		self:OnEnterOver()

		self.params_.isStory2Back = nil
	end

	self:UpdateTimeTxt()
	self:StopUpdateTimer()

	self.updateTimer = Timer.New(function()
		self:UpdateTimeTxt()
	end, 1, -1)

	self.updateTimer:Start()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	local var_24_0 = GameSetting.rogue_card_desc1.value

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_24_0
		})
	end)
end

function RogueCardGameForumView:OnExit()
	self.isTips = nil

	self:StopUpdateTimer()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function RogueCardGameForumView:Dispose()
	if self.postList_ then
		self.postList_:Dispose()

		self.postList_ = nil
	end

	RogueCardGameForumView.super.Dispose(self)
end

return RogueCardGameForumView
