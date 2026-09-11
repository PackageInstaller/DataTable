local ChapterV2MapEventItem = class("ChapterV2MapEventItem", ReduxView)

function ChapterV2MapEventItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.typeControl_ = self.conEx_:GetController("information")
end

function ChapterV2MapEventItem:AddListeners()
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.isTrack_ then
			manager.notify:Invoke(CHAPTER_MAP_TRACK_EVENT_CLICK, self.eventId_)
		else
			manager.notify:Invoke(CHAPTER_MAP_LOCATION_EVENT_CLICK, self.eventId_)
		end
	end)
end

function ChapterV2MapEventItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.eventId_ = arg_4_1
	self.isTrack_ = arg_4_2
	self.isSelect_ = arg_4_3
	self.gameObject_.name = tostring(arg_4_1)

	self:RefreshUI()
end

function ChapterV2MapEventItem:RefreshUI()
	local var_5_0 = ChapterV2MapEventCfg[self.eventId_]

	if self.isTrack_ then
		local var_5_1, var_5_2 = ChapterV2MapTools.IsEventInteractable(self.eventId_)

		self.text_.text = var_5_1 and var_5_0.trace_text or var_5_2 and ConditionCfg[var_5_2].desc or GetTips("ERROR_USER_NOT_ACHIEVE_CONDITION")
	else
		self.text_.text = var_5_0.name
	end

	if var_5_0.type == ChapterV2MapConst.MapEventType.MAIN then
		self.typeControl_:SetSelectedState("main")
	elseif var_5_0.type == ChapterV2MapConst.MapEventType.SIDE then
		self.typeControl_:SetSelectedState("side")
	elseif var_5_0.type == ChapterV2MapConst.MapEventType.SUPPLEMENT then
		self.typeControl_:SetSelectedState("clue")
	end
end

function ChapterV2MapEventItem:Dispose()
	ChapterV2MapEventItem.super.Dispose(self)

	self.gameObject_ = nil
	self.transform_ = nil
end

return ChapterV2MapEventItem
