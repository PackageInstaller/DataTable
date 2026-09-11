local StageArchiveMomoTalkItem = class("StageArchiveMomoTalkItem", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function StageArchiveMomoTalkItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function StageArchiveMomoTalkItem:Init()
	self:InitUI()
	self:AddListeners()
end

function StageArchiveMomoTalkItem:InitUI()
	self:BindCfgUI()

	self.continueController_ = self.controllerEx_:GetController("continue")
end

function StageArchiveMomoTalkItem:AddListeners()
	return
end

function StageArchiveMomoTalkItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.talkID_ = arg_5_1
	self.index_ = arg_5_2
	self.isContinue_ = arg_5_3 or false

	self:Refresh()
end

function StageArchiveMomoTalkItem:Refresh()
	self.speakerIcon_.sprite = getSpriteViaConfig("StoryHeadIcon", StageArchivesCollectMomoTalkCfg[self.talkID_].speaker_icon)
	self.speakerName_.text = StageArchivesCollectMomoTalkCfg[self.talkID_].speaker_name
	self.talkContent_.text = StageArchivesCollectMomoTalkCfg[self.talkID_].speaker_desc

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.talkContent_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectBg_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGo_)
	self.continueController_:SetSelectedState(tostring(self.isContinue_))
end

function StageArchiveMomoTalkItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

return StageArchiveMomoTalkItem
