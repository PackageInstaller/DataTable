local ActivityMatrixStoryReviewTalkItem = class("ActivityMatrixStoryReviewTalkItem", ReduxView)

function ActivityMatrixStoryReviewTalkItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityMatrixStoryReviewTalkItem:Init()
	self:InitUI()
end

function ActivityMatrixStoryReviewTalkItem:InitUI()
	self:BindCfgUI()
end

function ActivityMatrixStoryReviewTalkItem:SetData(arg_4_1)
	local var_4_1 = arg_4_1[2] or 0

	self.m_head.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Story/Character/" .. (arg_4_1[1] or ""))
	self.m_content.text = StoryWordCfg[var_4_1] and GetI18NText(StoryWordCfg[var_4_1].content) or ""
end

return ActivityMatrixStoryReviewTalkItem
