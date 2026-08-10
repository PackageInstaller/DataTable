local var_0_0 = class("RogueCardGameForumPopReplyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.postCfg = arg_2_2
	arg_2_0.cfg = RogueCardCommentCfg[arg_2_1]
	arg_2_0.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/" .. arg_2_0.cfg.comment_icon)
	arg_2_0.playerText_.text = GetI18NText(arg_2_0.cfg.comment_name)

	SetActive(arg_2_0.authorGo_, GetI18NText(arg_2_0.cfg.comment_name) == GetI18NText(arg_2_0.postCfg.user_name))

	arg_2_0.descText_.text = GetI18NText(arg_2_0.cfg.comment_desc)

	if GetI18NText(arg_2_0.cfg.comment_name) == GetTips("ROGUE_CARD_ACCOUNT_NAME") then
		local var_2_0 = RogueCardGameData:GetFansNum()
		local var_2_1 = 0

		for iter_2_0, iter_2_1 in ipairs(GameSetting.rogue_card_title_condition.value) do
			if iter_2_1 <= var_2_0 then
				var_2_1 = iter_2_0
			end
		end

		SetActive(arg_2_0.fanIcon_.gameObject, var_2_1 > 0)

		arg_2_0.fanIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_2_1)
	else
		SetActive(arg_2_0.fanIcon_.gameObject, false)
	end
end

function var_0_0.Show(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.gameObject_ = nil
	arg_4_0.transform_ = nil
end

return var_0_0
