local ChapterV2MapTimelineClueItem = class("ChapterV2MapTimelineClueItem", ReduxView)

function ChapterV2MapTimelineClueItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.control_ = self.conEx_:GetController("starItem")
end

function ChapterV2MapTimelineClueItem:AddListeners()
	return
end

function ChapterV2MapTimelineClueItem:SetData(arg_3_1)
	self.control_:SetSelectedState(arg_3_1 and "on" or "off")
end

function ChapterV2MapTimelineClueItem:Dispose()
	ChapterV2MapTimelineClueItem.super.Dispose(self)

	self.gameObject_ = nil
	self.transform_ = nil
end

return ChapterV2MapTimelineClueItem
