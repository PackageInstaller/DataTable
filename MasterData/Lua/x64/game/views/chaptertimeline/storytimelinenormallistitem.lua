local StoryTimeLineNormalListItem = class("StoryTimeLineNormalListItem", ReduxView)

function StoryTimeLineNormalListItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function StoryTimeLineNormalListItem:Init()
	self:BindCfgUI()

	self.selectedController_ = ControllerUtil.GetController(self.transform_, "isSelected")

	self:AddListener()
end

function StoryTimeLineNormalListItem:AddListener()
	self:AddBtnListener(self.normalBtn_, nil, function()
		if self.callback_ then
			self.callback_(self.index_)
		end
	end)
	self:AddBtnListener(self.openBtn_, nil, function()
		if self.openCallback_ then
			self.openCallback_(self.index_)
		end
	end)
end

function StoryTimeLineNormalListItem:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.id_ = arg_6_2
	self.cfg_ = ChapterClassSiftCfg[self.id_]

	self:RefreshUI()
end

function StoryTimeLineNormalListItem:RefreshUI()
	self.nameText_.text = self.cfg_.class_name
end

function StoryTimeLineNormalListItem:SetSelected(arg_8_1)
	self.selectedController_:SetSelectedState(tostring(self.index_ == arg_8_1))
end

function StoryTimeLineNormalListItem:SetClickCallBack(arg_9_1)
	self.callback_ = arg_9_1
end

function StoryTimeLineNormalListItem:SetOpenCallback(arg_10_1)
	self.openCallback_ = arg_10_1
end

function StoryTimeLineNormalListItem:Dispose()
	self.callback_ = nil

	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return StoryTimeLineNormalListItem
