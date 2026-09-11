local ChapterV2MapTimelineItem = class("ChapterV2MapTimelineItem", ReduxView)

function ChapterV2MapTimelineItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.typeControl_ = self.conEx_:GetController("information")
	self.clueControl_ = self.conEx_:GetController("clue")
	self.mainSelectControl_ = self.conEx_:GetController("LordSelect")
	self.sideSelectControl_ = self.conEx_:GetController("BranchSelect")
	self.sideUnfinishControl_ = self.conEx_:GetController("LordUnfinished")
	self.clueUnfinishControl_ = self.conEx_:GetController("FragmentUnfinished")
	self.sideLockControl_ = self.conEx_:GetController("LordLock")
	self.clueList_ = LuaList.New(handler(self, self.IndexItem), self.clueUiList_, ChapterV2MapTimelineClueItem)
end

function ChapterV2MapTimelineItem:AddListeners()
	self:AddBtnListener(self.selectBtn_, nil, function()
		manager.notify:CallUpdateFunc(CHAPTER_MAP_TIMELINE_EVENT_CLICK, self.eventId_, self)
	end)
end

function ChapterV2MapTimelineItem:SetData(arg_4_1, arg_4_2)
	self.eventId_ = arg_4_1
	self.clueReadCount_ = 0
	self.clueTotalCount_ = 0

	self:RefreshUI(arg_4_2)
end

function ChapterV2MapTimelineItem:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1 <= self.clueReadCount_)
end

function ChapterV2MapTimelineItem:AddClue(arg_6_1)
	if ChapterV2MapData:IsEventCompleted(arg_6_1) then
		self.clueReadCount_ = self.clueReadCount_ + 1
	end

	self.clueTotalCount_ = self.clueTotalCount_ + 1

	self:UIUpdateClue()
end

function ChapterV2MapTimelineItem:UIUpdateSelect(arg_7_1)
	if ChapterV2MapEventCfg[self.eventId_].type == ChapterV2MapConst.MapEventType.MAIN then
		self.mainSelectControl_:SetSelectedState(arg_7_1 and "on" or "off")
	elseif ChapterV2MapEventCfg[self.eventId_].type == ChapterV2MapConst.MapEventType.SIDE then
		self.sideSelectControl_:SetSelectedState(arg_7_1 and "on" or "off")
	end
end

function ChapterV2MapTimelineItem:UIUpdateComplete(arg_8_1)
	self.sideUnfinishControl_:SetSelectedState(arg_8_1 and "off" or "on")
end

function ChapterV2MapTimelineItem:UIUpdateInteractable(arg_9_1)
	if ChapterV2MapEventCfg[self.eventId_].type == ChapterV2MapConst.MapEventType.SIDE then
		self.sideLockControl_:SetSelectedState(arg_9_1 and "off" or "on")
	end
end

function ChapterV2MapTimelineItem:UIUpdateClue()
	if self.clueTotalCount_ == 0 then
		self.clueControl_:SetSelectedState("off")
	else
		self.clueControl_:SetSelectedState("on")
		self.clueUnfinishControl_:SetSelectedState(self.clueTotalCount_ > self.clueReadCount_ and "on" or "off")
		self.clueList_:StartScroll(self.clueTotalCount_)

		self.bgRect_.sizeDelta = self.clueTotalCount_ <= 4 and Vector2(164, self.bgRect_.sizeDelta.y) or Vector2(202, self.bgRect_.sizeDelta.y)
	end
end

function ChapterV2MapTimelineItem:RefreshUI(arg_11_1)
	self.isSelect_ = arg_11_1
	self.gameObject_.name = self.eventId_

	local var_11_0 = self.eventId_

	self.text_.text = ChapterV2MapEventCfg[self.eventId_].name

	if ChapterV2MapEventCfg[self.eventId_].type == ChapterV2MapConst.MapEventType.MAIN then
		self.typeControl_:SetSelectedState("Lord")
	elseif ChapterV2MapEventCfg[self.eventId_].type == ChapterV2MapConst.MapEventType.SIDE then
		self.typeControl_:SetSelectedState("Branch")
	end

	self:UIUpdateSelect(self.isSelect_)
	self:UIUpdateComplete(ChapterV2MapData:IsEventCompleted(var_11_0))
	self:UIUpdateInteractable(ChapterV2MapData:IsEventCompleted(var_11_0) or ChapterV2MapTools.IsEventInteractable(var_11_0))
	self:UIUpdateClue()
end

function ChapterV2MapTimelineItem:Dispose()
	ChapterV2MapTimelineItem.super.Dispose(self)

	if self.clueList_ then
		self.clueList_:Dispose()

		self.clueList_ = nil
	end

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return ChapterV2MapTimelineItem
