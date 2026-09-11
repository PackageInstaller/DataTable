local RogueCardGameReportPopView = class("RogueCardGameReportPopView", ReduxView)

function RogueCardGameReportPopView:UIName()
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunReportPopUI"
end

function RogueCardGameReportPopView:UIParent()
	return manager.ui.uiPop.transform
end

function RogueCardGameReportPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueCardGameReportPopView:InitUI()
	self:BindCfgUI()

	self.fanslvlCon_ = self.controller_:GetController("fanslvl")
	self.defaultCon_ = self.fansController_:GetController("default0")
	self.qualityCon_ = self.fansController_:GetController("quality")
	self.rollingText_ = self.rollingGo_:GetComponent("RollingNumber")
	self.fansCon_1 = self.fansTitleCon_1:GetController("quality")
	self.fansCon_2 = self.fansTitleCon_2:GetController("quality")
end

function RogueCardGameReportPopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function RogueCardGameReportPopView:OnEnter()
	self.postId = RogueCardGameTools.GetCurPostingId()
	self.cfg = RogueCardPostingCfg[self.postId]

	self:RefreshView()
end

function RogueCardGameReportPopView:RefreshView()
	self.hotPostId = RogueCardGameTools.GetHotPostId(self.postId)
	self.nameText_.text = GetTips("ROGUE_CARD_ACCOUNT_NAME")

	local var_8_0 = RogueCardGameData:GetFansNum()
	local var_8_1 = 0
	local var_8_3 = 0

	for iter_8_0, iter_8_1 in ipairs(GameSetting.rogue_card_title_condition.value) do
		if var_8_0 < iter_8_1 then
			var_8_1 = iter_8_1
			var_8_3 = iter_8_1 - var_8_0

			break
		end
	end

	self.leftDesc_.text = var_8_1 < var_8_0 and GetTips("ROGUE_CARD_GAP_SCORE2") or string.format(GetTips("ROGUE_CARD_GAP_SCORE1"), var_8_3)
	self.leftViewText_.text = string.format("%.1f", RogueCardGameData:GetViewsNum() / 1000) .. "k"
	self.leftLikeText_.text = string.format("%.1f", RogueCardGameData:GetLikeNum() / 1000) .. "k"
	self.leftTalkText_.text = RogueCardGameData:GetTalksNum()
	self.multipleText_.text = "+" .. math.floor((string.format("%.3f", math.floor(string.format("%.3f", math.floor(self.cfg.fans / (RogueCardGameData:GetFansNum() - self.cfg.fans < 0 and 1 or RogueCardGameData:GetFansNum() - self.cfg.fans) * 1000 + 0.5) / 1000) * 100 + 0.5)))) .. "%"

	self.rollingText_:ScrollTo((string.format("%.8d", RogueCardGameData:GetFansNum())))

	self.postIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/story/" .. RogueCardPostingCfg[self.hotPostId].background_1)
	self.postNameText_.text = GetI18NText(RogueCardPostingCfg[self.hotPostId].background_text)
	self.postTitleText_.text = GetI18NText(RogueCardPostingCfg[self.hotPostId].name)
	self.postDescText_.text = GetI18NText(RogueCardPostingCfg[self.hotPostId].desc)
	self.rightViewText_.text = string.format("%.1f", RogueCardPostingCfg[self.hotPostId].views / 1000) .. "k"
	self.rightLikeText_.text = string.format("%.1f", RogueCardPostingCfg[self.hotPostId].likes / 1000) .. "k"
	self.rightTalkText_.text = RogueCardGameTools.GetPostTalkNum(self.hotPostId)

	local var_8_5 = 0

	for iter_8_2, iter_8_3 in ipairs(GameSetting.rogue_card_title_condition.value) do
		if iter_8_3 <= var_8_0 then
			var_8_5 = iter_8_2
		end
	end

	if var_8_5 <= 0 then
		self.defaultCon_:SetSelectedIndex(0)

		self.fansAddText_.text = GetTips("ROGUE_CARD_GAP_SCORE4")

		self.fanslvlCon_:SetSelectedIndex(0)
	elseif var_8_5 == 1 and RogueCardGameData:GetFansNum() - self.cfg.fans < GameSetting.rogue_card_title_condition.value[var_8_5] then
		self.defaultCon_:SetSelectedIndex(1)
		self.qualityCon_:SetSelectedIndex(var_8_5 - 1)

		self.fansTitleText_.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_5)

		self.fanslvlCon_:SetSelectedIndex(1)

		self.fansAddText_.text = GetTips("ROGUE_CARD_GAP_SCORE3")
		self.fansIcon_1.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_8_5)
		self.fansTitle_1.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_5)
	elseif var_8_5 == 2 and RogueCardGameData:GetFansNum() - self.cfg.fans < GameSetting.rogue_card_title_condition.value[var_8_5] then
		self.defaultCon_:SetSelectedIndex(1)
		self.qualityCon_:SetSelectedIndex(var_8_5 - 1)

		self.fansTitleText_.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_5)

		self.fanslvlCon_:SetSelectedIndex(2)

		self.fansAddText_.text = GetTips("ROGUE_CARD_GAP_SCORE3")
		self.fansIcon_1.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_8_5 - 1)
		self.fansTitle_1.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_5 - 1)
		self.fansIcon_2.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_8_5)
		self.fansTitle_2.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_5)

		self.fansCon_1:SetSelectedIndex(0)
		self.fansCon_2:SetSelectedIndex(1)
	elseif var_8_5 == 3 and RogueCardGameData:GetFansNum() - self.cfg.fans < GameSetting.rogue_card_title_condition.value[var_8_5] then
		self.defaultCon_:SetSelectedIndex(1)
		self.qualityCon_:SetSelectedIndex(var_8_5 - 1)

		self.fansTitleText_.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_5)

		self.fanslvlCon_:SetSelectedIndex(2)

		self.fansAddText_.text = GetTips("ROGUE_CARD_GAP_SCORE3")
		self.fansIcon_1.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_8_5 - 1)
		self.fansTitle_1.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_5 - 1)
		self.fansIcon_2.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/JokerCard_fansicon_0" .. var_8_5)
		self.fansTitle_2.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_5)

		self.fansCon_1:SetSelectedIndex(1)
		self.fansCon_2:SetSelectedIndex(2)
	else
		self.defaultCon_:SetSelectedIndex(1)
		self.qualityCon_:SetSelectedIndex(var_8_5 - 1)

		self.fansTitleText_.text = GetTips("ROGUE_CARD_TITLE_TIPS" .. var_8_5)

		self.fanslvlCon_:SetSelectedIndex(0)
	end
end

function RogueCardGameReportPopView:Dispose()
	RogueCardGameReportPopView.super.Dispose(self)
end

return RogueCardGameReportPopView
