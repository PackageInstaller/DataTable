local var_0_0 = class("RogueCardGameForumPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.defaultCon_ = arg_4_0.fansController_:GetController("default0")
	arg_4_0.qualityCon_ = arg_4_0.fansController_:GetController("quality")
	arg_4_0.progressCon_ = arg_4_0.controller_:GetController("Progress")
	arg_4_0.likeCon_ = arg_4_0.controller_:GetController("like")
	arg_4_0.btnCon_ = arg_4_0.controller_:GetController("btn")
	arg_4_0.typeCon_ = arg_4_0.controller_:GetController("Type")
	arg_4_0.storyCon_ = arg_4_0.controller_:GetController("Story")
	arg_4_0.panelTypeCon_ = arg_4_0.controller_:GetController("PanelType")
	arg_4_0.lodingCon_ = arg_4_0.controller_:GetController("loading")
	arg_4_0.itemList_ = {}
	arg_4_0.onInterruptHandler = handler(arg_4_0, arg_4_0.OnInterrupt)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnGo_, nil, function()
		if RogueCardGameData:GetThreadState() > 0 then
			local var_6_0 = RogueCardGameData:GetThreadId()
			local var_6_1 = RogueCardPostingCfg[var_6_0]

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("ROGUE_CARD_TERMINATE_INVESTIGATION_OTHER_STORY"), GetI18NText(var_6_1.name)),
				OkCallback = function()
					if arg_5_0.postId == 107 then
						arg_5_0:Back()
					end

					RogueCardGameTools.SetCurPostingId(arg_5_0.postId)
					RogueCardGameAction.StartPost(arg_5_0.postId)
				end
			})
		else
			if arg_5_0.postId == 107 then
				arg_5_0:Back()
			end

			RogueCardGameTools.SetCurPostingId(arg_5_0.postId)
			RogueCardGameAction.StartPost(arg_5_0.postId)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.interruptBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("ROGUE_CARD_TERMINATE_INVESTIGATION_STORY"),
			OkCallback = function()
				RogueCardGameAction.InterruptPost(arg_5_0.postId)
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.continueBtn_, nil, function()
		RogueCardGameTools.SetCurPostingId(arg_5_0.postId)

		local var_10_0 = RogueCardGameData:GetThreadState()

		if (var_10_0 == 1 or var_10_0 == 2) and arg_5_0.cfg.story_id1 > 0 then
			manager.story:StartStoryById(arg_5_0.cfg.story_id1, function(arg_11_0)
				RogueCardGameAction.OnCompleteStory(arg_5_0.postId, arg_5_0.cfg.story_id1, 1)
			end, false)
			RogueCardGameAction.CompleteStory(arg_5_0.postId, arg_5_0.cfg.story_id1, 1)
		elseif var_10_0 == 3 then
			RogueCardGameAction.ContinueProgressPost(arg_5_0.postId)
		elseif var_10_0 == 4 and arg_5_0.cfg.story_id2 > 0 then
			RogueCardGameData:SetSettleResult(1)
			manager.story:StartStoryById(arg_5_0.cfg.story_id2, function(arg_12_0)
				RogueCardGameAction.OnCompleteStory(arg_5_0.postId, arg_5_0.cfg.story_id1, 2, true)
			end, false)
			RogueCardGameAction.CompleteStory(arg_5_0.postId, arg_5_0.cfg.story_id2, 2, true)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.againBtn_, nil, function()
		if RogueCardGameData:GetThreadState() > 0 then
			local var_13_0 = RogueCardGameData:GetThreadId()
			local var_13_1 = RogueCardPostingCfg[var_13_0]

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("ROGUE_CARD_TERMINATE_INVESTIGATION_OTHER_STORY"), GetI18NText(var_13_1.name)),
				OkCallback = function()
					if arg_5_0.postId == 107 then
						arg_5_0:Back()
					end

					RogueCardGameTools.SetCurPostingId(arg_5_0.postId)
					RogueCardGameAction.RebackPost(arg_5_0.postId)
				end
			})
		else
			if arg_5_0.postId == 107 then
				arg_5_0:Back()
			end

			RogueCardGameTools.SetCurPostingId(arg_5_0.postId)
			RogueCardGameAction.RebackPost(arg_5_0.postId)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		if not arg_5_0.isStory then
			arg_5_0:Back()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.postBtn_, nil, function()
		if not arg_5_0.isStory then
			arg_5_0:Back()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.likeBtn_, nil, function()
		arg_5_0.likeCon_:SetSelectedIndex(1)
		RogueCardGameAction.ClickLikePost(arg_5_0.postId)
	end)
	arg_5_0:AddBtnListener(arg_5_0.unLikeBtn_, nil, function()
		arg_5_0.likeCon_:SetSelectedIndex(0)
		RogueCardGameAction.ClickLikePost(arg_5_0.postId)
	end)
end

function var_0_0.OnTop(arg_19_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnBehind(arg_20_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_21_0)
	arg_21_0.postId = arg_21_0.params_.postId
	arg_21_0.type = arg_21_0.params_.type or 1
	arg_21_0.cfg = RogueCardPostingCfg[arg_21_0.postId]
	arg_21_0.isStory = arg_21_0.params_.story and true or false
	arg_21_0.scrollBar_.value = 1
	arg_21_0.scrollBar_2.value = 1

	arg_21_0:RefreshView()

	if not arg_21_0.isStory then
		manager.notify:RegistListener(ROGUE_CARD_GAME_INTERRUPT_SUCCESS, arg_21_0.onInterruptHandler)
	end
end

function var_0_0.OnEnterOver(arg_22_0)
	if not manager.ui:GetUISeparateRender() then
		manager.ui:SetUISeparateRender(true)

		arg_22_0.separateFlag_ = true
	end

	if arg_22_0.params_.callback then
		arg_22_0.params_.callback()
	end
end

function var_0_0.RefreshView(arg_23_0)
	arg_23_0.type = arg_23_0.params_.type or 1

	arg_23_0.panelTypeCon_:SetSelectedState(tostring(arg_23_0.type == 2))
	arg_23_0.storyCon_:SetSelectedState(tostring(arg_23_0.isStory))

	local var_23_0 = RogueCardGameTools.IsLikesPostById(arg_23_0.postId)

	SetActive(arg_23_0.likeLizi_, not var_23_0)
	arg_23_0.likeCon_:SetSelectedIndex(var_23_0 and 1 or 0)

	arg_23_0.leftPostIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/story/" .. arg_23_0.cfg.background_1)

	if arg_23_0.type == 2 then
		arg_23_0.postTitleText_.text = GetI18NText(arg_23_0.cfg.name)
		arg_23_0.postDescText_.text = GetI18NText(arg_23_0.cfg.desc)
		arg_23_0.postImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/story/" .. arg_23_0.cfg.background_1)
		arg_23_0.bgText_.text = GetI18NText(arg_23_0.cfg.background_text)
	else
		if arg_23_0.cfg.type == 1 then
			arg_23_0.nameText_.text = ""
		else
			arg_23_0.nameText_.text = GetI18NText(arg_23_0.cfg.background_text)
		end

		arg_23_0.likeText_.text = string.format("%.1f", arg_23_0.cfg.likes / 1000) .. "k"
		arg_23_0.titleText_.text = GetI18NText(arg_23_0.cfg.name)
		arg_23_0.descText_.text = GetI18NText(arg_23_0.cfg.desc)
		arg_23_0.playerText_.text = GetI18NText(arg_23_0.cfg.user_name)
		arg_23_0.rewardFansText_.text = string.format("%.1f", arg_23_0.cfg.fans / 1000) .. "k"
		arg_23_0.rewardLikeText_.text = string.format("%.1f", arg_23_0.cfg.likes / 1000) .. "k"
		arg_23_0.contextDescText_.text = GetTips("ROGUE_CARD_COMMENT_TIPS1")
		arg_23_0.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/" .. arg_23_0.cfg.user_icon)

		local var_23_1 = RogueCardGameData:GetFansNum()
		local var_23_2 = 0

		for iter_23_0, iter_23_1 in ipairs(GameSetting.rogue_card_title_condition.value) do
			if iter_23_1 <= var_23_1 then
				var_23_2 = iter_23_0
			end
		end

		if var_23_2 <= 0 then
			arg_23_0.defaultCon_:SetSelectedIndex(0)
		else
			arg_23_0.defaultCon_:SetSelectedIndex(1)
			arg_23_0.qualityCon_:SetSelectedIndex(var_23_2 - 1)

			arg_23_0.fansTitleText_.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_23_2)
		end

		if GetI18NText(arg_23_0.cfg.user_name) ~= GetTips("ROGUE_CARD_ACCOUNT_NAME") then
			arg_23_0.defaultCon_:SetSelectedIndex(0)
		end

		arg_23_0:CreatItem()
		arg_23_0:RefreshState()
	end
end

function var_0_0.RefreshState(arg_24_0)
	if arg_24_0.cfg.type ~= 1 then
		arg_24_0.typeCon_:SetSelectedIndex(1)
		arg_24_0.progressCon_:SetSelectedIndex(3)
	else
		arg_24_0.typeCon_:SetSelectedIndex(0)

		if RogueCardGameData:GetThreadId() == arg_24_0.postId then
			local var_24_0 = RogueCardGameData:GetThreadState()

			if var_24_0 < 1 then
				arg_24_0.btnCon_:SetSelectedIndex(0)
				arg_24_0.progressCon_:SetSelectedIndex(0)
			elseif var_24_0 >= 1 and var_24_0 <= 4 then
				arg_24_0.btnCon_:SetSelectedIndex(1)
				arg_24_0.progressCon_:SetSelectedIndex(1)
			elseif var_24_0 >= 5 then
				arg_24_0.btnCon_:SetSelectedIndex(2)
				arg_24_0.progressCon_:SetSelectedIndex(2)
				RogueCardGameTools.SetSettleFirst(false)
			end

			if RogueCardGameTools.GetIsFinishPreById(arg_24_0.postId) then
				RogueCardGameTools.SetSettleFirst(false)
			else
				RogueCardGameTools.SetSettleFirst(true)
			end
		elseif RogueCardGameTools.GetIsFinishPreById(arg_24_0.postId) then
			arg_24_0.btnCon_:SetSelectedIndex(2)
			arg_24_0.progressCon_:SetSelectedIndex(2)
			RogueCardGameTools.SetSettleFirst(false)
		else
			arg_24_0.btnCon_:SetSelectedIndex(0)
			arg_24_0.progressCon_:SetSelectedIndex(0)
			RogueCardGameTools.SetSettleFirst(true)
		end
	end
end

function var_0_0.CreatItem(arg_25_0)
	local var_25_0 = arg_25_0.cfg.comments
	local var_25_1 = {}

	if arg_25_0.isStory then
		for iter_25_0, iter_25_1 in ipairs(var_25_0) do
			if RogueCardCommentCfg[iter_25_1].comment_show ~= 1 then
				table.insert(var_25_1, iter_25_1)
			end
		end

		var_25_0 = var_25_1
	elseif not RogueCardGameTools.GetIsFinishPreById(arg_25_0.postId) then
		for iter_25_2, iter_25_3 in ipairs(var_25_0) do
			if RogueCardCommentCfg[iter_25_3].comment_show ~= 1 then
				table.insert(var_25_1, iter_25_3)
			end
		end

		var_25_0 = var_25_1
	end

	local var_25_2 = #var_25_0

	for iter_25_4 = 1, var_25_2 do
		if not arg_25_0.itemList_[iter_25_4] then
			local var_25_3 = Object.Instantiate(arg_25_0.itemGo_, arg_25_0.contentTrs_)

			arg_25_0.itemList_[iter_25_4] = RogueCardGameForumPopItem.New(var_25_3)
		end

		local var_25_4 = var_25_0[iter_25_4]

		arg_25_0.itemList_[iter_25_4]:Show(true)
		arg_25_0.itemList_[iter_25_4]:RefreshData(var_25_4, arg_25_0.cfg)
	end

	for iter_25_5 = var_25_2 + 1, #arg_25_0.itemList_ do
		arg_25_0.itemList_[iter_25_5]:Show(false)
	end
end

function var_0_0.OnInterrupt(arg_26_0)
	arg_26_0:RefreshView()
end

function var_0_0.OnExit(arg_27_0)
	if not arg_27_0.isStory then
		manager.notify:RemoveListener(ROGUE_CARD_GAME_INTERRUPT_SUCCESS, arg_27_0.onInterruptHandler)
	end

	if manager.ui:GetUISeparateRender() then
		manager.ui:SetUISeparateRender(false)

		arg_27_0.separateFlag_ = false
	end

	arg_27_0.params_.type = nil
end

function var_0_0.Dispose(arg_28_0)
	if arg_28_0.itemList_ then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0.itemList_) do
			iter_28_1:Dispose()
		end

		arg_28_0.itemList_ = nil
	end

	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
