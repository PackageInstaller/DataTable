local ChapterV2MapTestEvent = class("ChapterV2MapTestEvent", ReduxView)

function ChapterV2MapTestEvent:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChapterV2MapTestEvent:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.notify:Invoke(CHAPTER_MAP_LOCATION_EVENT_CLICK, self.eventId_)
	end)
end

function ChapterV2MapTestEvent:SetData(arg_4_1, arg_4_2)
	self.eventId_ = arg_4_1
	self.isSelect_ = arg_4_2

	self:RefreshUI()
end

function ChapterV2MapTestEvent:RefreshUI()
	local var_5_0 = ChapterV2MapEventCfg[self.eventId_]

	self.text_.text = self.isSelect_ and "->" .. var_5_0.name or var_5_0.name
	self.text_.text = self.text_.text .. " " .. var_5_0.id

	self:BindRedPoint()
end

function ChapterV2MapTestEvent:Dispose()
	self:UnbindRedPoint()
	ChapterV2MapTestEvent.super.Dispose(self)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterV2MapTestEvent:BindRedPoint()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_EVENT, self.eventId_))
end

function ChapterV2MapTestEvent:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_)
end

return ChapterV2MapTestEvent
