local RogueCardGameForumPopItem = class("RogueCardGameForumPopItem", ReduxView)

function RogueCardGameForumPopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.items = {}
end

function RogueCardGameForumPopItem:RefreshData(arg_2_1, arg_2_2)
	self.commentId = arg_2_1
	self.commentCfg = RogueCardCommentCfg[self.commentId]
	self.cfg = arg_2_2
	self.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/" .. self.commentCfg.comment_icon)

	SetActive(self.authorGo_, GetI18NText(self.commentCfg.comment_name) == GetI18NText(self.cfg.user_name))

	self.playerText_.text = GetI18NText(self.commentCfg.comment_name)
	self.descText_.text = GetI18NText(self.commentCfg.comment_desc)

	self:RefreshItem()

	if GetI18NText(self.commentCfg.comment_name) == GetTips("ROGUE_CARD_ACCOUNT_NAME") then
		SetActive(self.fansIcon_.gameObject, true)

		local var_2_0 = RogueCardGameData:GetFansNum()
		local var_2_1 = 0

		for iter_2_0, iter_2_1 in ipairs(GameSetting.rogue_card_title_condition.value) do
			if iter_2_1 <= var_2_0 then
				var_2_1 = iter_2_0
			end
		end

		self.fansIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_2_1)
	else
		SetActive(self.fansIcon_.gameObject, false)
	end
end

function RogueCardGameForumPopItem:RefreshItem()
	if self.items then
		for iter_3_0, iter_3_1 in ipairs(self.items) do
			iter_3_1:Dispose()
		end

		self.items = {}
	end

	local var_3_0 = #self.commentCfg.comment_sub

	for iter_3_2 = 1, #self.commentCfg.comment_sub do
		self.items[iter_3_2] = self.items[iter_3_2] or RogueCardGameForumPopReplyItem.New((Object.Instantiate(self.replyItem_, self.content_)))

		local var_3_1 = self.commentCfg.comment_sub[iter_3_2]

		self.items[iter_3_2]:Show(true)
		self.items[iter_3_2]:RefreshData(var_3_1, self.cfg)
	end

	for iter_3_3 = var_3_0 + 1, #self.items do
		self.items[iter_3_3]:Show(false)
	end
end

function RogueCardGameForumPopItem:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function RogueCardGameForumPopItem:Dispose()
	RogueCardGameForumPopItem.super.Dispose(self)

	if self.items then
		for iter_5_0, iter_5_1 in ipairs(self.items) do
			iter_5_1:Dispose()
		end

		self.items = nil
	end

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return RogueCardGameForumPopItem
