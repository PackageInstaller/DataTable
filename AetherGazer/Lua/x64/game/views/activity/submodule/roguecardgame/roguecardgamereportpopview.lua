local var_0_0 = class("RogueCardGameReportPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunReportPopUI"
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

	arg_4_0.fanslvlCon_ = arg_4_0.controller_:GetController("fanslvl")
	arg_4_0.defaultCon_ = arg_4_0.fansController_:GetController("default0")
	arg_4_0.qualityCon_ = arg_4_0.fansController_:GetController("quality")
	arg_4_0.rollingText_ = arg_4_0.rollingGo_:GetComponent("RollingNumber")
	arg_4_0.fansCon_1 = arg_4_0.fansTitleCon_1:GetController("quality")
	arg_4_0.fansCon_2 = arg_4_0.fansTitleCon_2:GetController("quality")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.postId = RogueCardGameTools.GetCurPostingId()
	arg_7_0.cfg = RogueCardPostingCfg[arg_7_0.postId]

	arg_7_0:RefreshView()
end

function var_0_0.RefreshView(arg_8_0)
	arg_8_0.hotPostId = RogueCardGameTools.GetHotPostId(arg_8_0.postId)
	arg_8_0.nameText_.text = GetTips("ROGUE_CARD_ACCOUNT_NAME")

	local var_8_0 = RogueCardGameData:GetFansNum()
	local var_8_1 = 0
	local var_8_2 = 0
	local var_8_3 = 0

	for iter_8_0, iter_8_1 in ipairs(GameSetting.rogue_card_title_condition.value) do
		if var_8_0 < iter_8_1 then
			var_8_1 = iter_8_1
			var_8_3 = iter_8_1 - var_8_0

			break
		end
	end

	if var_8_1 < var_8_0 then
		arg_8_0.leftDesc_.text = GetTips("ROGUE_CARD_GAP_SCORE2")
	else
		arg_8_0.leftDesc_.text = string.format(GetTips("ROGUE_CARD_GAP_SCORE1"), var_8_3)
	end

	arg_8_0.leftViewText_.text = string.format("%.1f", RogueCardGameData:GetViewsNum() / 1000) .. "k"
	arg_8_0.leftLikeText_.text = string.format("%.1f", RogueCardGameData:GetLikeNum() / 1000) .. "k"
	arg_8_0.leftTalkText_.text = RogueCardGameData:GetTalksNum()

	local var_8_4 = RogueCardGameData:GetFansNum() - arg_8_0.cfg.fans < 0 and 1 or RogueCardGameData:GetFansNum() - arg_8_0.cfg.fans
	local var_8_5 = math.floor(arg_8_0.cfg.fans / var_8_4 * 1000 + 0.5) / 1000
	local var_8_6 = string.format("%.3f", var_8_5)
	local var_8_7 = string.format("%.3f", math.floor(var_8_6 * 100 + 0.5))

	arg_8_0.multipleText_.text = "+" .. math.floor(var_8_7) .. "%"

	local var_8_8 = string.format("%.8d", RogueCardGameData:GetFansNum())

	arg_8_0.rollingText_:ScrollTo(var_8_8)

	arg_8_0.postIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/story/" .. RogueCardPostingCfg[arg_8_0.hotPostId].background_1)
	arg_8_0.postNameText_.text = GetI18NText(RogueCardPostingCfg[arg_8_0.hotPostId].background_text)
	arg_8_0.postTitleText_.text = GetI18NText(RogueCardPostingCfg[arg_8_0.hotPostId].name)
	arg_8_0.postDescText_.text = GetI18NText(RogueCardPostingCfg[arg_8_0.hotPostId].desc)
	arg_8_0.rightViewText_.text = string.format("%.1f", RogueCardPostingCfg[arg_8_0.hotPostId].views / 1000) .. "k"
	arg_8_0.rightLikeText_.text = string.format("%.1f", RogueCardPostingCfg[arg_8_0.hotPostId].likes / 1000) .. "k"

	local var_8_9 = RogueCardGameTools.GetPostTalkNum(arg_8_0.hotPostId)

	arg_8_0.rightTalkText_.text = var_8_9

	local var_8_10 = 0
	local var_8_11 = GameSetting.rogue_card_title_condition.value

	for iter_8_2, iter_8_3 in ipairs(var_8_11) do
		if iter_8_3 <= var_8_0 then
			var_8_10 = iter_8_2
		end
	end

	if var_8_10 <= 0 then
		arg_8_0.defaultCon_:SetSelectedIndex(0)

		arg_8_0.fansAddText_.text = GetTips("ROGUE_CARD_GAP_SCORE4")

		arg_8_0.fanslvlCon_:SetSelectedIndex(0)
	elseif var_8_10 == 1 and RogueCardGameData:GetFansNum() - arg_8_0.cfg.fans < var_8_11[var_8_10] then
		arg_8_0.defaultCon_:SetSelectedIndex(1)
		arg_8_0.qualityCon_:SetSelectedIndex(var_8_10 - 1)

		arg_8_0.fansTitleText_.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_10)

		arg_8_0.fanslvlCon_:SetSelectedIndex(1)

		arg_8_0.fansAddText_.text = GetTips("ROGUE_CARD_GAP_SCORE3")
		arg_8_0.fansIcon_1.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_8_10)
		arg_8_0.fansTitle_1.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_10)
	elseif var_8_10 == 2 and RogueCardGameData:GetFansNum() - arg_8_0.cfg.fans < var_8_11[var_8_10] then
		arg_8_0.defaultCon_:SetSelectedIndex(1)
		arg_8_0.qualityCon_:SetSelectedIndex(var_8_10 - 1)

		arg_8_0.fansTitleText_.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_10)

		arg_8_0.fanslvlCon_:SetSelectedIndex(2)

		arg_8_0.fansAddText_.text = GetTips("ROGUE_CARD_GAP_SCORE3")
		arg_8_0.fansIcon_1.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_8_10 - 1)
		arg_8_0.fansTitle_1.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_10 - 1)
		arg_8_0.fansIcon_2.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_8_10)
		arg_8_0.fansTitle_2.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_10)

		arg_8_0.fansCon_1:SetSelectedIndex(0)
		arg_8_0.fansCon_2:SetSelectedIndex(1)
	elseif var_8_10 == 3 and RogueCardGameData:GetFansNum() - arg_8_0.cfg.fans < var_8_11[var_8_10] then
		arg_8_0.defaultCon_:SetSelectedIndex(1)
		arg_8_0.qualityCon_:SetSelectedIndex(var_8_10 - 1)

		arg_8_0.fansTitleText_.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_10)

		arg_8_0.fanslvlCon_:SetSelectedIndex(2)

		arg_8_0.fansAddText_.text = GetTips("ROGUE_CARD_GAP_SCORE3")
		arg_8_0.fansIcon_1.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_8_10 - 1)
		arg_8_0.fansTitle_1.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_10 - 1)
		arg_8_0.fansIcon_2.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_8_10)
		arg_8_0.fansTitle_2.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_10)

		arg_8_0.fansCon_1:SetSelectedIndex(1)
		arg_8_0.fansCon_2:SetSelectedIndex(2)
	else
		arg_8_0.defaultCon_:SetSelectedIndex(1)
		arg_8_0.qualityCon_:SetSelectedIndex(var_8_10 - 1)

		arg_8_0.fansTitleText_.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_10)

		arg_8_0.fanslvlCon_:SetSelectedIndex(0)
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
