local RogueCardGameForumPopReplyItem = class("RogueCardGameForumPopReplyItem", ReduxView)

function RogueCardGameForumPopReplyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function RogueCardGameForumPopReplyItem:RefreshData(arg_2_1, arg_2_2)
	self.postCfg = arg_2_2
	self.cfg = RogueCardCommentCfg[arg_2_1]
	self.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/" .. self.cfg.comment_icon)
	self.playerText_.text = GetI18NText(self.cfg.comment_name)

	SetActive(self.authorGo_, GetI18NText(self.cfg.comment_name) == GetI18NText(self.postCfg.user_name))

	self.descText_.text = GetI18NText(self.cfg.comment_desc)

	if GetI18NText(self.cfg.comment_name) == GetTips("ROGUE_CARD_ACCOUNT_NAME") then
		local var_2_0 = RogueCardGameData:GetFansNum()
		local var_2_1 = 0

		for iter_2_0, iter_2_1 in ipairs(GameSetting.rogue_card_title_condition.value) do
			if iter_2_1 <= var_2_0 then
				var_2_1 = iter_2_0
			end
		end

		SetActive(self.fanIcon_.gameObject, var_2_1 > 0)

		self.fanIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_2_1)
	else
		SetActive(self.fanIcon_.gameObject, false)
	end
end

function RogueCardGameForumPopReplyItem:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function RogueCardGameForumPopReplyItem:Dispose()
	RogueCardGameForumPopReplyItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return RogueCardGameForumPopReplyItem
