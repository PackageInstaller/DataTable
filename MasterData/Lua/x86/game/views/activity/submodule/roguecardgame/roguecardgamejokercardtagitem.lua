local RogueCardGameJokerCardTagItem = class("RogueCardGameJokerCardTagItem", ReduxView)

function RogueCardGameJokerCardTagItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RogueCardGameJokerCardTagItem:Init()
	self:InitUI()
end

function RogueCardGameJokerCardTagItem:InitUI()
	self:BindCfgUI()
end

function RogueCardGameJokerCardTagItem:RefreshData(arg_4_1)
	self.name_.text = GetTips("ROGUE_CARD_TAG_" .. arg_4_1)
end

function RogueCardGameJokerCardTagItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function RogueCardGameJokerCardTagItem:Dispose()
	RogueCardGameJokerCardTagItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return RogueCardGameJokerCardTagItem
