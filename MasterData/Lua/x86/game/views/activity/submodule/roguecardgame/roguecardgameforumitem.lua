local RogueCardGameForumItem = class("RogueCardGameForumItem", ReduxView)

function RogueCardGameForumItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RogueCardGameForumItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RogueCardGameForumItem:InitUI()
	self:BindCfgUI()

	self.typeCon_ = self.controller_:GetController("type")
	self.tittleCon_ = self.controller_:GetController("tittle")
	self.progressCon_ = self.controller_:GetController("Progress")
	self.tabCon_ = self.controller_:GetController("tab")
	self.likeCon_ = self.controller_:GetController("like")
end

function RogueCardGameForumItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		local var_5_0 = RogueCardGameData:GetPostInfoById(self.postId)

		JumpTools.OpenPageByJump("rogueCardGameForumPopView", {
			postId = self.postId,
			callback = function()
				if not RogueCardGameTools.IsViewPost(self.postId) and self.cfg.type ~= 2 then
					RogueCardGameData:SetPostStateInfo(self.postId, 1)
					RogueCardGameAction.ViewThreadPost(self.postId)
				elseif RogueCardGameTools.IsViewPost(self.postId) and self.cfg.type ~= 2 and var_5_0.complete_state == 1 and RogueCardGameTools.GetIsFinishPreById(self.postId) then
					RogueCardGameData:SetPostStateInfo(self.postId, 2)
					manager.notify:Invoke(ROGUE_CARD_GAME_REFRESH_BTNCON, self.postId)
				end
			end
		})
	end)
end

function RogueCardGameForumItem:SetData(arg_7_1)
	self.postId = arg_7_1
	self.cfg = RogueCardPostingCfg[arg_7_1]

	self.likeCon_:SetSelectedIndex(RogueCardGameTools.IsLikesPostById(self.postId) and 1 or 0)

	self.bgIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/story/" .. self.cfg.background_1)
	self.nameText_.text = GetI18NText(self.cfg.background_text)
	self.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/" .. self.cfg.user_icon)
	self.titleText_.text = GetI18NText(self.cfg.name)
	self.descText_.text = textLimit(string.gsub(GetI18NText(self.cfg.desc), "\n", ""), 75) .. "..."
	self.posterNameText_.text = GetI18NText(self.cfg.user_name)
	self.lookText_.text = string.format("%.1f", self.cfg.views / 1000) .. "k"
	self.likeText_.text = string.format("%.1f", self.cfg.likes / 1000) .. "k"
	self.talkText_.text = RogueCardGameTools.GetPostTalkNum(self.postId)

	self.typeCon_:SetSelectedIndex(self.cfg.type == 1 and 0 or 1)

	if GetI18NText(self.cfg.user_name) == GetTips("ROGUE_CARD_ACCOUNT_NAME") then
		local var_7_0 = RogueCardGameData:GetFansNum()
		local var_7_1 = 0

		for iter_7_0, iter_7_1 in ipairs(GameSetting.rogue_card_title_condition.value) do
			if iter_7_1 <= var_7_0 then
				var_7_1 = iter_7_0
			end
		end

		SetActive(self.fansIcon_.gameObject, var_7_1 > 0)

		self.fansIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_7_1)

		self.tabCon_:SetSelectedIndex(1)
	else
		self.tabCon_:SetSelectedIndex(0)
		SetActive(self.fansIcon_.gameObject, false)
	end

	self.progressCon_:SetSelectedIndex((RogueCardGameTools.GetPostStateById(arg_7_1)))
	self.tittleCon_:SetSelectedIndex(RogueCardGameTools.GetIsViewsPost(arg_7_1) and 1 or 0)
	self:RefreshBtnCon()
end

function RogueCardGameForumItem:RefreshBtnCon()
	local var_8_0, var_8_1 = self:GetBtnConResult(self.postId)

	if self.cfg.type == 2 then
		var_8_0 = false
		var_8_1 = false
	end

	SetActive(self.newGo_, var_8_0)
	SetActive(self.newTalkGo_, var_8_1)
end

function RogueCardGameForumItem:GetBtnConResult(arg_9_1)
	local var_9_0 = not RogueCardGameTools.IsViewPost(arg_9_1)
	local var_9_2 = RogueCardGameData:GetPostInfoById(arg_9_1)
	local var_9_3 = false

	for iter_9_0, iter_9_1 in ipairs(self.cfg.comments) do
		if RogueCardCommentCfg[iter_9_1].comment_show == 1 then
			var_9_3 = true
		end
	end

	return var_9_0, (var_9_2 and var_9_2.complete_state == 1 and var_9_3 and RogueCardGameTools.GetIsFinishPreById(self.postId) or nil) and true
end

function RogueCardGameForumItem:Dispose()
	self:RemoveAllListeners()
	RogueCardGameForumItem.super.Dispose(self)
end

return RogueCardGameForumItem
