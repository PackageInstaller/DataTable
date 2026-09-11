local RogueCardGameForumPopView = class("RogueCardGameForumPopView", ReduxView)

function RogueCardGameForumPopView:UIName()
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI"
end

function RogueCardGameForumPopView:UIParent()
	return manager.ui.uiPop.transform
end

function RogueCardGameForumPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueCardGameForumPopView:InitUI()
	self:BindCfgUI()

	self.defaultCon_ = self.fansController_:GetController("default0")
	self.qualityCon_ = self.fansController_:GetController("quality")
	self.progressCon_ = self.controller_:GetController("Progress")
	self.likeCon_ = self.controller_:GetController("like")
	self.btnCon_ = self.controller_:GetController("btn")
	self.typeCon_ = self.controller_:GetController("Type")
	self.storyCon_ = self.controller_:GetController("Story")
	self.panelTypeCon_ = self.controller_:GetController("PanelType")
	self.lodingCon_ = self.controller_:GetController("loading")
	self.itemList_ = {}
	self.onInterruptHandler = handler(self, self.OnInterrupt)
end

function RogueCardGameForumPopView:AddUIListener()
	self:AddBtnListener(self.btnGo_, nil, function()
		if RogueCardGameData:GetThreadState() > 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("ROGUE_CARD_TERMINATE_INVESTIGATION_OTHER_STORY"), GetI18NText(RogueCardPostingCfg[RogueCardGameData:GetThreadId()].name)),
				OkCallback = function()
					if self.postId == 107 then
						self:Back()
					end

					RogueCardGameTools.SetCurPostingId(self.postId)
					RogueCardGameAction.StartPost(self.postId)
				end
			})
		else
			if self.postId == 107 then
				self:Back()
			end

			RogueCardGameTools.SetCurPostingId(self.postId)
			RogueCardGameAction.StartPost(self.postId)
		end
	end)
	self:AddBtnListener(self.interruptBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("ROGUE_CARD_TERMINATE_INVESTIGATION_STORY"),
			OkCallback = function()
				RogueCardGameAction.InterruptPost(self.postId)
			end
		})
	end)
	self:AddBtnListener(self.continueBtn_, nil, function()
		RogueCardGameTools.SetCurPostingId(self.postId)

		local var_10_0 = RogueCardGameData:GetThreadState()

		if (var_10_0 == 1 or var_10_0 == 2) and self.cfg.story_id1 > 0 then
			manager.story:StartStoryById(self.cfg.story_id1, function(arg_11_0)
				RogueCardGameAction.OnCompleteStory(self.postId, self.cfg.story_id1, 1)
			end, false)
			RogueCardGameAction.CompleteStory(self.postId, self.cfg.story_id1, 1)
		elseif var_10_0 == 3 then
			RogueCardGameAction.ContinueProgressPost(self.postId)
		elseif var_10_0 == 4 and self.cfg.story_id2 > 0 then
			RogueCardGameData:SetSettleResult(1)
			manager.story:StartStoryById(self.cfg.story_id2, function(arg_12_0)
				RogueCardGameAction.OnCompleteStory(self.postId, self.cfg.story_id1, 2, true)
			end, false)
			RogueCardGameAction.CompleteStory(self.postId, self.cfg.story_id2, 2, true)
		end
	end)
	self:AddBtnListener(self.againBtn_, nil, function()
		if RogueCardGameData:GetThreadState() > 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("ROGUE_CARD_TERMINATE_INVESTIGATION_OTHER_STORY"), GetI18NText(RogueCardPostingCfg[RogueCardGameData:GetThreadId()].name)),
				OkCallback = function()
					if self.postId == 107 then
						self:Back()
					end

					RogueCardGameTools.SetCurPostingId(self.postId)
					RogueCardGameAction.RebackPost(self.postId)
				end
			})
		else
			if self.postId == 107 then
				self:Back()
			end

			RogueCardGameTools.SetCurPostingId(self.postId)
			RogueCardGameAction.RebackPost(self.postId)
		end
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		if not self.isStory then
			self:Back()
		end
	end)
	self:AddBtnListener(self.postBtn_, nil, function()
		if not self.isStory then
			self:Back()
		end
	end)
	self:AddBtnListener(self.likeBtn_, nil, function()
		self.likeCon_:SetSelectedIndex(1)
		RogueCardGameAction.ClickLikePost(self.postId)
	end)
	self:AddBtnListener(self.unLikeBtn_, nil, function()
		self.likeCon_:SetSelectedIndex(0)
		RogueCardGameAction.ClickLikePost(self.postId)
	end)
end

function RogueCardGameForumPopView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function RogueCardGameForumPopView:OnBehind()
	manager.windowBar:HideBar()
end

function RogueCardGameForumPopView:OnEnter()
	self.postId = self.params_.postId
	self.type = self.params_.type or 1
	self.cfg = RogueCardPostingCfg[self.postId]
	self.isStory = not not self.params_.story
	self.scrollBar_.value = 1
	self.scrollBar_2.value = 1

	self:RefreshView()

	if not self.isStory then
		manager.notify:RegistListener(ROGUE_CARD_GAME_INTERRUPT_SUCCESS, self.onInterruptHandler)
	end
end

function RogueCardGameForumPopView:OnEnterOver()
	if not manager.ui:GetUISeparateRender() then
		manager.ui:SetUISeparateRender(true)

		self.separateFlag_ = true
	end

	if self.params_.callback then
		self.params_.callback()
	end
end

function RogueCardGameForumPopView:RefreshView()
	self.type = self.params_.type or 1

	self.panelTypeCon_:SetSelectedState(tostring(self.type == 2))
	self.storyCon_:SetSelectedState(tostring(self.isStory))

	local var_23_0 = RogueCardGameTools.IsLikesPostById(self.postId)

	SetActive(self.likeLizi_, not var_23_0)
	self.likeCon_:SetSelectedIndex(var_23_0 and 1 or 0)

	self.leftPostIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/story/" .. self.cfg.background_1)

	if self.type == 2 then
		self.postTitleText_.text = GetI18NText(self.cfg.name)
		self.postDescText_.text = GetI18NText(self.cfg.desc)
		self.postImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/story/" .. self.cfg.background_1)
		self.bgText_.text = GetI18NText(self.cfg.background_text)
	else
		self.nameText_.text = self.cfg.type == 1 and "" or GetI18NText(self.cfg.background_text)
		self.likeText_.text = string.format("%.1f", self.cfg.likes / 1000) .. "k"
		self.titleText_.text = GetI18NText(self.cfg.name)
		self.descText_.text = GetI18NText(self.cfg.desc)
		self.playerText_.text = GetI18NText(self.cfg.user_name)
		self.rewardFansText_.text = string.format("%.1f", self.cfg.fans / 1000) .. "k"
		self.rewardLikeText_.text = string.format("%.1f", self.cfg.likes / 1000) .. "k"
		self.contextDescText_.text = GetTips("ROGUE_CARD_COMMENT_TIPS1")
		self.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/" .. self.cfg.user_icon)

		local var_23_1 = RogueCardGameData:GetFansNum()
		local var_23_2 = 0

		for iter_23_0, iter_23_1 in ipairs(GameSetting.rogue_card_title_condition.value) do
			if iter_23_1 <= var_23_1 then
				var_23_2 = iter_23_0
			end
		end

		if var_23_2 <= 0 then
			self.defaultCon_:SetSelectedIndex(0)
		else
			self.defaultCon_:SetSelectedIndex(1)
			self.qualityCon_:SetSelectedIndex(var_23_2 - 1)

			self.fansTitleText_.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_23_2)
		end

		if GetI18NText(self.cfg.user_name) ~= GetTips("ROGUE_CARD_ACCOUNT_NAME") then
			self.defaultCon_:SetSelectedIndex(0)
		end

		self:CreatItem()
		self:RefreshState()
	end
end

function RogueCardGameForumPopView:RefreshState()
	if self.cfg.type ~= 1 then
		self.typeCon_:SetSelectedIndex(1)
		self.progressCon_:SetSelectedIndex(3)
	else
		self.typeCon_:SetSelectedIndex(0)

		if RogueCardGameData:GetThreadId() == self.postId then
			local var_24_0 = RogueCardGameData:GetThreadState()

			if var_24_0 < 1 then
				self.btnCon_:SetSelectedIndex(0)
				self.progressCon_:SetSelectedIndex(0)
			elseif var_24_0 >= 1 and var_24_0 <= 4 then
				self.btnCon_:SetSelectedIndex(1)
				self.progressCon_:SetSelectedIndex(1)
			elseif var_24_0 >= 5 then
				self.btnCon_:SetSelectedIndex(2)
				self.progressCon_:SetSelectedIndex(2)
				RogueCardGameTools.SetSettleFirst(false)
			end

			if RogueCardGameTools.GetIsFinishPreById(self.postId) then
				RogueCardGameTools.SetSettleFirst(false)
			else
				RogueCardGameTools.SetSettleFirst(true)
			end
		elseif RogueCardGameTools.GetIsFinishPreById(self.postId) then
			self.btnCon_:SetSelectedIndex(2)
			self.progressCon_:SetSelectedIndex(2)
			RogueCardGameTools.SetSettleFirst(false)
		else
			self.btnCon_:SetSelectedIndex(0)
			self.progressCon_:SetSelectedIndex(0)
			RogueCardGameTools.SetSettleFirst(true)
		end
	end
end

function RogueCardGameForumPopView:CreatItem()
	local var_25_0 = self.cfg.comments
	local var_25_1 = {}

	if self.isStory then
		for iter_25_0, iter_25_1 in ipairs(var_25_0) do
			if RogueCardCommentCfg[iter_25_1].comment_show ~= 1 then
				table.insert(var_25_1, iter_25_1)
			end
		end

		var_25_0 = var_25_1
	elseif not RogueCardGameTools.GetIsFinishPreById(self.postId) then
		for iter_25_2, iter_25_3 in ipairs(var_25_0) do
			if RogueCardCommentCfg[iter_25_3].comment_show ~= 1 then
				table.insert(var_25_1, iter_25_3)
			end
		end

		var_25_0 = var_25_1
	end

	local var_25_2 = #var_25_0

	for iter_25_4 = 1, #var_25_0 do
		self.itemList_[iter_25_4] = self.itemList_[iter_25_4] or RogueCardGameForumPopItem.New((Object.Instantiate(self.itemGo_, self.contentTrs_)))

		local var_25_3 = var_25_0[iter_25_4]

		self.itemList_[iter_25_4]:Show(true)
		self.itemList_[iter_25_4]:RefreshData(var_25_3, self.cfg)
	end

	for iter_25_5 = var_25_2 + 1, #self.itemList_ do
		self.itemList_[iter_25_5]:Show(false)
	end
end

function RogueCardGameForumPopView:OnInterrupt()
	self:RefreshView()
end

function RogueCardGameForumPopView:OnExit()
	if not self.isStory then
		manager.notify:RemoveListener(ROGUE_CARD_GAME_INTERRUPT_SUCCESS, self.onInterruptHandler)
	end

	if manager.ui:GetUISeparateRender() then
		manager.ui:SetUISeparateRender(false)

		self.separateFlag_ = false
	end

	self.params_.type = nil
end

function RogueCardGameForumPopView:Dispose()
	if self.itemList_ then
		for iter_28_0, iter_28_1 in ipairs(self.itemList_) do
			iter_28_1:Dispose()
		end

		self.itemList_ = nil
	end

	RogueCardGameForumPopView.super.Dispose(self)
end

return RogueCardGameForumPopView
