local ChapterV2MapTestLocation = class("ChapterV2MapTestLocation", ReduxView)

function ChapterV2MapTestLocation:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChapterV2MapTestLocation:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.notify:Invoke(CHAPTER_MAP_LOCATION_CLICK, self.locationId_)
	end)
end

function ChapterV2MapTestLocation:SetData(arg_4_1, arg_4_2)
	self.locationId_ = arg_4_1
	self.isSelect_ = arg_4_2

	self:RefreshUI()
end

function ChapterV2MapTestLocation:RefreshUI()
	local var_5_0 = ChapterV2MapLocationCfg[self.locationId_]

	self.text_.text = self.isSelect_ and "->" .. var_5_0.name or var_5_0.name
	self.text_.text = self.text_.text .. " " .. var_5_0.id .. " > " .. #(ChapterV2MapTools.GetLocationEvents(self.locationId_) or {})

	self:BindRedPoint()
end

function ChapterV2MapTestLocation:Dispose()
	self:UnbindRedPoint()
	ChapterV2MapTestLocation.super.Dispose(self)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterV2MapTestLocation:BindRedPoint()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_LOCATION, self.locationId_))
end

function ChapterV2MapTestLocation:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_)
end

return ChapterV2MapTestLocation
