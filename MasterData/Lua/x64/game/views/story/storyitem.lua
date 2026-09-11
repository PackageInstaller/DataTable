local StoryItem = class("StoryItem", ReduxView)

function StoryItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.data_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.info_ = arg_1_3

	self:InitUI()
	self:Init()
end

function StoryItem:InitUI()
	self:BindCfgUI()

	self.name_.text = GetI18NText(self.info_.name)

	self:AddBtnListener(nil, nil, "OnClick")
end

function StoryItem:Init()
	self:RefreshUI()
end

function StoryItem:RefreshUI()
	self.lv_.text = self.info_.id

	self:Show(true)
end

function StoryItem:SetIndex(arg_5_1)
	self.transform_:SetSiblingIndex(arg_5_1)
end

function StoryItem:Dispose()
	self:RemoveAllListeners()

	self.data_ = nil
	self.index_ = nil

	StoryItem.super.Dispose(self)
end

function StoryItem:OnClick()
	manager.story:StartStory(self.info_.id)
end

function StoryItem:Show(arg_8_1)
	if self.isShow_ == arg_8_1 then
		return
	end

	self.isShow_ = arg_8_1

	SetActive(self.gameObject_, arg_8_1)
end

return StoryItem
