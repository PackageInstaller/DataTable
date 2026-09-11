local RogueCardGameCardBuffStyleItem = class("RogueCardGameCardBuffStyleItem", ReduxView)

function RogueCardGameCardBuffStyleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RogueCardGameCardBuffStyleItem:Init()
	self:InitUI()

	self.lockCon_ = self.controller_:GetController("lock")
end

function RogueCardGameCardBuffStyleItem:InitUI()
	self:BindCfgUI()
end

function RogueCardGameCardBuffStyleItem:RefreshData(arg_4_1, arg_4_2)
	self.deck = arg_4_1
	self.diff = arg_4_2

	if RogueCardGameTools.IsUnlockDiff(self.deck, self.diff) then
		self.lockCon_:SetSelectedIndex(1)
	else
		self.lockCon_:SetSelectedIndex(0)
	end

	RichTextTools.SetMixedTextWithImage(self.desc_, GetI18NText(RogueCardDifficultyCfg[arg_4_2].desc))

	self.desc_.text = GetI18NText(RogueCardDifficultyCfg[arg_4_2].desc)
end

function RogueCardGameCardBuffStyleItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function RogueCardGameCardBuffStyleItem:Dispose()
	RogueCardGameCardBuffStyleItem.super.Dispose(self)
end

return RogueCardGameCardBuffStyleItem
