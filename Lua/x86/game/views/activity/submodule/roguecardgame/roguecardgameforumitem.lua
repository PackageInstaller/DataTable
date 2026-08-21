local var_0_0 = class("RogueCardGameForumItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.typeCon_ = arg_3_0.controller_:GetController("type")
	arg_3_0.tittleCon_ = arg_3_0.controller_:GetController("tittle")
	arg_3_0.progressCon_ = arg_3_0.controller_:GetController("Progress")
	arg_3_0.tabCon_ = arg_3_0.controller_:GetController("tab")
	arg_3_0.likeCon_ = arg_3_0.controller_:GetController("like")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = RogueCardGameData:GetPostInfoById(arg_4_0.postId)

		JumpTools.OpenPageByJump("rogueCardGameForumPopView", {
			postId = arg_4_0.postId,
			callback = function()
				if not RogueCardGameTools.IsViewPost(arg_4_0.postId) and arg_4_0.cfg.type ~= 2 then
					RogueCardGameData:SetPostStateInfo(arg_4_0.postId, 1)
					RogueCardGameAction.ViewThreadPost(arg_4_0.postId)
				elseif RogueCardGameTools.IsViewPost(arg_4_0.postId) and arg_4_0.cfg.type ~= 2 and var_5_0.complete_state == 1 and RogueCardGameTools.GetIsFinishPreById(arg_4_0.postId) then
					RogueCardGameData:SetPostStateInfo(arg_4_0.postId, 2)
					manager.notify:Invoke(ROGUE_CARD_GAME_REFRESH_BTNCON, arg_4_0.postId)
				end
			end
		})
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.postId = arg_7_1
	arg_7_0.cfg = RogueCardPostingCfg[arg_7_1]

	local var_7_0 = RogueCardGameTools.IsLikesPostById(arg_7_0.postId)

	arg_7_0.likeCon_:SetSelectedIndex(var_7_0 and 1 or 0)

	arg_7_0.bgIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/story/" .. arg_7_0.cfg.background_1)
	arg_7_0.nameText_.text = GetI18NText(arg_7_0.cfg.background_text)
	arg_7_0.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/" .. arg_7_0.cfg.user_icon)
	arg_7_0.titleText_.text = GetI18NText(arg_7_0.cfg.name)

	local var_7_1 = textLimit(string.gsub(GetI18NText(arg_7_0.cfg.desc), "\n", ""), 75) .. "..."

	arg_7_0.descText_.text = var_7_1
	arg_7_0.posterNameText_.text = GetI18NText(arg_7_0.cfg.user_name)
	arg_7_0.lookText_.text = string.format("%.1f", arg_7_0.cfg.views / 1000) .. "k"
	arg_7_0.likeText_.text = string.format("%.1f", arg_7_0.cfg.likes / 1000) .. "k"
	arg_7_0.talkText_.text = RogueCardGameTools.GetPostTalkNum(arg_7_0.postId)

	arg_7_0.typeCon_:SetSelectedIndex(arg_7_0.cfg.type == 1 and 0 or 1)

	if GetI18NText(arg_7_0.cfg.user_name) == GetTips("ROGUE_CARD_ACCOUNT_NAME") then
		local var_7_2 = RogueCardGameData:GetFansNum()
		local var_7_3 = 0

		for iter_7_0, iter_7_1 in ipairs(GameSetting.rogue_card_title_condition.value) do
			if iter_7_1 <= var_7_2 then
				var_7_3 = iter_7_0
			end
		end

		SetActive(arg_7_0.fansIcon_.gameObject, var_7_3 > 0)

		arg_7_0.fansIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_7_3)

		arg_7_0.tabCon_:SetSelectedIndex(1)
	else
		arg_7_0.tabCon_:SetSelectedIndex(0)
		SetActive(arg_7_0.fansIcon_.gameObject, false)
	end

	local var_7_4 = RogueCardGameTools.GetPostStateById(arg_7_1)

	arg_7_0.progressCon_:SetSelectedIndex(var_7_4)

	local var_7_5 = RogueCardGameTools.GetIsViewsPost(arg_7_1)

	arg_7_0.tittleCon_:SetSelectedIndex(var_7_5 and 1 or 0)
	arg_7_0:RefreshBtnCon()
end

function var_0_0.RefreshBtnCon(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:GetBtnConResult(arg_8_0.postId)

	if arg_8_0.cfg.type == 2 then
		var_8_0 = false
		var_8_1 = false
	end

	SetActive(arg_8_0.newGo_, var_8_0)
	SetActive(arg_8_0.newTalkGo_, var_8_1)
end

function var_0_0.GetBtnConResult(arg_9_0, arg_9_1)
	local var_9_0 = false
	local var_9_1 = false

	if not RogueCardGameTools.IsViewPost(arg_9_1) then
		var_9_0 = true
	end

	local var_9_2 = RogueCardGameData:GetPostInfoById(arg_9_1)
	local var_9_3 = arg_9_0.cfg.comments
	local var_9_4 = false

	for iter_9_0, iter_9_1 in ipairs(var_9_3) do
		if RogueCardCommentCfg[iter_9_1].comment_show == 1 then
			var_9_4 = true
		end
	end

	if var_9_2 and var_9_2.complete_state == 1 and var_9_4 and RogueCardGameTools.GetIsFinishPreById(arg_9_0.postId) then
		var_9_1 = true
	end

	return var_9_0, var_9_1
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
