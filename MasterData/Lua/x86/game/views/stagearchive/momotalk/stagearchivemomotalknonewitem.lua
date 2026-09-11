local StageArchiveMomoTalkNoNewItem = class("StageArchiveMomoTalkNoNewItem", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function StageArchiveMomoTalkNoNewItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
end

function StageArchiveMomoTalkNoNewItem:SetData(arg_2_1)
	self.index_ = arg_2_1
end

function StageArchiveMomoTalkNoNewItem:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

return StageArchiveMomoTalkNoNewItem
