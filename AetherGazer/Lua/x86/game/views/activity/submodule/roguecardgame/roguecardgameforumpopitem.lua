local var_0_0 = class("RogueCardGameForumPopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.items = {}
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.commentId = arg_2_1
	arg_2_0.commentCfg = RogueCardCommentCfg[arg_2_0.commentId]
	arg_2_0.cfg = arg_2_2
	arg_2_0.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/" .. arg_2_0.commentCfg.comment_icon)

	SetActive(arg_2_0.authorGo_, GetI18NText(arg_2_0.commentCfg.comment_name) == GetI18NText(arg_2_0.cfg.user_name))

	arg_2_0.playerText_.text = GetI18NText(arg_2_0.commentCfg.comment_name)
	arg_2_0.descText_.text = GetI18NText(arg_2_0.commentCfg.comment_desc)

	arg_2_0:RefreshItem()

	if GetI18NText(arg_2_0.commentCfg.comment_name) == GetTips("ROGUE_CARD_ACCOUNT_NAME") then
		SetActive(arg_2_0.fansIcon_.gameObject, true)

		local var_2_0 = RogueCardGameData:GetFansNum()
		local var_2_1 = 0

		for iter_2_0, iter_2_1 in ipairs(GameSetting.rogue_card_title_condition.value) do
			if iter_2_1 <= var_2_0 then
				var_2_1 = iter_2_0
			end
		end

		arg_2_0.fansIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_2_1)
	else
		SetActive(arg_2_0.fansIcon_.gameObject, false)
	end
end

function var_0_0.RefreshItem(arg_3_0)
	if arg_3_0.items then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.items) do
			iter_3_1:Dispose()
		end

		arg_3_0.items = {}
	end

	local var_3_0 = #arg_3_0.commentCfg.comment_sub

	for iter_3_2 = 1, var_3_0 do
		if not arg_3_0.items[iter_3_2] then
			local var_3_1 = Object.Instantiate(arg_3_0.replyItem_, arg_3_0.content_)

			arg_3_0.items[iter_3_2] = RogueCardGameForumPopReplyItem.New(var_3_1)
		end

		local var_3_2 = arg_3_0.commentCfg.comment_sub[iter_3_2]

		arg_3_0.items[iter_3_2]:Show(true)
		arg_3_0.items[iter_3_2]:RefreshData(var_3_2, arg_3_0.cfg)
	end

	for iter_3_3 = var_3_0 + 1, #arg_3_0.items do
		arg_3_0.items[iter_3_3]:Show(false)
	end
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)

	if arg_5_0.items then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.items) do
			iter_5_1:Dispose()
		end

		arg_5_0.items = nil
	end

	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.gameObject_ = nil
	arg_5_0.transform_ = nil
end

return var_0_0
