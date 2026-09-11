LoopScrollViewBaseItem = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")

local ChapterV2MapArchiveCollectItem = class("ChapterV2MapArchiveCollectItem", LoopScrollViewBaseItem)

function ChapterV2MapArchiveCollectItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.posControl_ = self.conEx_:GetController("zoom")
end

function ChapterV2MapArchiveCollectItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		ChapterV2MapTools.OpenEvent(self.eventId_)
	end)
end

function ChapterV2MapArchiveCollectItem:SetData(arg_4_1, arg_4_2)
	self.index_ = arg_4_2
	self.eventId_ = arg_4_1

	self:Show(true)
	self:RefreshUI()
end

function ChapterV2MapArchiveCollectItem:GetItemHeight()
	return self.transform_.sizeDelta.y
end

function ChapterV2MapArchiveCollectItem:RefreshUI()
	self.titleText_.text = ChapterV2MapEventCfg[self.eventId_].name

	self.posControl_:SetSelectedState(self.index_ % 2 == 1 and "state0" or "state1")
end

function ChapterV2MapArchiveCollectItem:Dispose()
	ChapterV2MapArchiveCollectItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return ChapterV2MapArchiveCollectItem
