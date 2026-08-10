local var_0_0 = class("RogueCardGameForumView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_ForumUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.btnConList_ = {}

	for iter_4_0 = 1, 4 do
		arg_4_0.btnConList_[iter_4_0] = arg_4_0["btnCon_" .. iter_4_0]:GetController("select")
	end

	arg_4_0.selectToggle = 1
	arg_4_0.postList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.listGo_, RogueCardGameForumItem)
	arg_4_0.defaultCon_ = arg_4_0.fansTitleController_:GetController("default0")
	arg_4_0.qualityCon_ = arg_4_0.fansTitleController_:GetController("quality")
	arg_4_0.onRefreshBtnConHandler = handler(arg_4_0, arg_4_0.OnRefreshBtnCon)
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.postDataList_[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.allBtn_, nil, function()
		arg_6_0.selectToggle = 1

		arg_6_0:RefreshView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.taskBtn_, nil, function()
		arg_6_0.selectToggle = 2

		arg_6_0:RefreshView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.talkBtn_, nil, function()
		arg_6_0.selectToggle = 3

		arg_6_0:RefreshView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.callBackBtn_, nil, function()
		arg_6_0.selectToggle = 4

		arg_6_0:RefreshView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.tipsBtn_, nil, function()
		if arg_6_0.tipsGo_.activeSelf == false then
			SetActive(arg_6_0.tipsGo_, true)
		else
			SetActive(arg_6_0.tipsGo_, false)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.tipsBtn_2, nil, function()
		if arg_6_0.tipsGo_.activeSelf == false then
			SetActive(arg_6_0.tipsGo_, true)
		else
			SetActive(arg_6_0.tipsGo_, false)
		end
	end)
end

function var_0_0.StopUpdateTimer(arg_13_0)
	if arg_13_0.updateTimer then
		arg_13_0.updateTimer:Stop()

		arg_13_0.updateTimer = nil
	end
end

function var_0_0.UpdateTimeTxt(arg_14_0)
	local var_14_0 = os.time()
	local var_14_1 = os.difftime(var_14_0, os.time(os.date("!*t", var_14_0)))
	local var_14_2 = os.date("!*t", var_14_0 + var_14_1)

	arg_14_0.dayText_.text = string.format("%s/%s", var_14_2.month, var_14_2.day)
	arg_14_0.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function var_0_0.OnEnter(arg_15_0)
	SetActive(arg_15_0.tipsGo_, false)
	arg_15_0:RefreshView()
	arg_15_0:RegistEventListener(ROGUE_CARD_GAME_REFRESH_BTNCON, arg_15_0.onRefreshBtnConHandler)
end

function var_0_0.OnEnterOver(arg_16_0)
	if arg_16_0.params_.isTips then
		arg_16_0.isTips = arg_16_0.params_.isTips
		arg_16_0.params_.isTips = nil
	end

	if arg_16_0.isTips then
		local var_16_0 = RogueCardGameTools.GetCurPostingId()

		JumpTools.OpenPageByJump("rogueCardGameForumPopView", {
			postId = var_16_0
		})

		return
	end

	if arg_16_0.params_.isSettle and RogueCardGameTools.GetSettleFirst() then
		arg_16_0:OpenSettlePopView()

		arg_16_0.params_.isSettle = nil
	end
end

function var_0_0.OpenSettlePopView(arg_17_0)
	JumpTools.OpenPageByJump("rogueCardGameReportPopView")
end

function var_0_0.RefreshView(arg_18_0)
	arg_18_0.selectToggle = arg_18_0.selectToggle or 1
	arg_18_0.postDataList_ = RogueCardGameTools.GetPostDataList(arg_18_0.selectToggle)

	for iter_18_0 = 1, #arg_18_0.btnConList_ do
		if iter_18_0 == arg_18_0.selectToggle then
			arg_18_0.btnConList_[iter_18_0]:SetSelectedIndex(1)
		else
			arg_18_0.btnConList_[iter_18_0]:SetSelectedIndex(0)
		end
	end

	local var_18_0 = arg_18_0.postList_:GetScrolledPosition()

	arg_18_0.postList_:StartScrollByPosition(#arg_18_0.postDataList_, var_18_0)
	arg_18_0:RefreshLeft()
	arg_18_0:RefreshBtnCon()
end

function var_0_0.RefreshBtnCon(arg_19_0)
	local var_19_0 = RogueCardGameTools.GetPostDataList(1)
	local var_19_1, var_19_2 = var_0_0:GetBtnConResult(var_19_0)

	SetActive(arg_19_0.newGo_1, var_19_1)
	SetActive(arg_19_0.newTalkGo_1, var_19_2)

	if var_19_1 and var_19_2 then
		SetActive(arg_19_0.newGo_1, var_19_1)
		SetActive(arg_19_0.newTalkGo_1, false)
	end

	local var_19_3 = RogueCardGameTools.GetPostDataList(2)
	local var_19_4, var_19_5 = var_0_0:GetBtnConResult(var_19_3)

	SetActive(arg_19_0.newGo_2, var_19_4)
	SetActive(arg_19_0.newTalkGo_2, var_19_5)

	if var_19_4 and var_19_5 then
		SetActive(arg_19_0.newGo_2, var_19_4)
		SetActive(arg_19_0.newTalkGo_2, false)
	end

	local var_19_6 = RogueCardGameTools.GetPostDataList(3)
	local var_19_7, var_19_8 = var_0_0:GetBtnConResult(var_19_6)

	SetActive(arg_19_0.newGo_3, var_19_7)
	SetActive(arg_19_0.newTalkGo_3, var_19_8)

	if var_19_7 and var_19_8 then
		SetActive(arg_19_0.newGo_3, var_19_7)
		SetActive(arg_19_0.newTalkGo_3, fasle)
	end

	local var_19_9 = RogueCardGameTools.GetPostDataList(4)
	local var_19_10, var_19_11 = var_0_0:GetBtnConResult(var_19_9)

	SetActive(arg_19_0.newTalkGo_4, var_19_11)
end

function var_0_0.GetBtnConResult(arg_20_0, arg_20_1)
	local var_20_0 = false
	local var_20_1 = false

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		if not RogueCardGameTools.IsViewPost(iter_20_1) then
			var_20_0 = true
		end

		local var_20_2 = RogueCardGameData:GetPostInfoById(iter_20_1)
		local var_20_3 = RogueCardPostingCfg[iter_20_1].comments
		local var_20_4 = false

		for iter_20_2, iter_20_3 in ipairs(var_20_3) do
			if RogueCardCommentCfg[iter_20_3].comment_show == 1 then
				var_20_4 = true
			end
		end

		if var_20_2.complete_state == 1 and var_20_4 and RogueCardGameTools.GetIsFinishPreById(iter_20_1) then
			var_20_1 = true
		end
	end

	return var_20_0, var_20_1
end

function var_0_0.RefreshLeft(arg_21_0)
	arg_21_0.nameText_.text = GetTips("ROGUE_CARD_ACCOUNT_NAME")
	arg_21_0.tipsText_.text = GetTips("ROGUE_CARD_ACCOUNT_TIPS")

	local var_21_0 = RogueCardGameData:GetFansNum()
	local var_21_1 = 0

	for iter_21_0, iter_21_1 in ipairs(GameSetting.rogue_card_title_condition.value) do
		if iter_21_1 <= var_21_0 then
			var_21_1 = iter_21_0
		end
	end

	if var_21_1 <= 0 then
		arg_21_0.defaultCon_:SetSelectedIndex(0)
	else
		arg_21_0.defaultCon_:SetSelectedIndex(1)
		arg_21_0.qualityCon_:SetSelectedIndex(var_21_1 - 1)

		arg_21_0.fansTitleText_.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_21_1)
	end

	arg_21_0.fansText_.text = string.format("%.1f", RogueCardGameData:GetFansNum() / 1000) .. "k"
	arg_21_0.lookText_.text = string.format("%.1f", RogueCardGameData:GetViewsNum() / 1000) .. "k"
	arg_21_0.niceText_.text = string.format("%.1f", RogueCardGameData:GetLikeNum() / 1000) .. "k"
	arg_21_0.commentText_.text = RogueCardGameData:GetTalksNum()
end

function var_0_0.OnRefreshBtnCon(arg_22_0, arg_22_1)
	local var_22_0 = table.indexof(arg_22_0.postDataList_, arg_22_1)

	arg_22_0:RefreshUIListItem(arg_22_1, var_22_0)
	arg_22_0:RefreshLeft()
	arg_22_0:RefreshBtnCon()
end

function var_0_0.RefreshUIListItem(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.postList_ then
		arg_23_0.postList_:GetItemByIndex(arg_23_2):SetData(arg_23_1)
	end
end

function var_0_0.OnTop(arg_24_0)
	if arg_24_0.params_.isStory2Back then
		SetActive(arg_24_0.tipsGo_, false)
		arg_24_0:RefreshView()
		arg_24_0:OnEnterOver()

		arg_24_0.params_.isStory2Back = nil
	end

	arg_24_0:UpdateTimeTxt()
	arg_24_0:StopUpdateTimer()

	arg_24_0.updateTimer = Timer.New(function()
		arg_24_0:UpdateTimeTxt()
	end, 1, -1)

	arg_24_0.updateTimer:Start()
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

function var_0_0.OnExit(arg_27_0)
	arg_27_0.isTips = nil

	arg_27_0:StopUpdateTimer()
	arg_27_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_28_0)
	if arg_28_0.postList_ then
		arg_28_0.postList_:Dispose()

		arg_28_0.postList_ = nil
	end

	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
