local ChapterV2MapGoLocationItem = class("ChapterV2MapGoLocationItem", BaseView)

function ChapterV2MapGoLocationItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.lockController_ = self.controllerEx_:GetController("goBtn")

	self:BindRedPoint()
end

function ChapterV2MapGoLocationItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		ChapterV2MapTools.GoMap(self.tagCfg_.behaviour_parameters[1])
	end)
end

function ChapterV2MapGoLocationItem:SetData(arg_4_1, arg_4_2)
	self.locationId_ = arg_4_1
	self.isSelect_ = arg_4_2

	self:RefreshUI()
end

function ChapterV2MapGoLocationItem:RefreshUI()
	self.transform_:SetLocalPosition(Vector2(ChapterV2MapLocationCfg[self.locationId_].position[1], ChapterV2MapLocationCfg[self.locationId_].position[2]))

	self.tagList_ = ChapterV2MapData:GetLocationActiveTagList(self.locationId_)
	self.tagCfg_ = ChapterV2MapTagCfg[self.tagList_[1]]

	self.lockController_:SetSelectedState(tostring(not ChapterV2MapTools.IsLocationUnlock(self.locationId_)))

	self.nameText_.text = ChapterV2MapLocationCfg[self.locationId_].name
end

function ChapterV2MapGoLocationItem:SetClickTag(arg_6_1)
	self.clickTag_ = arg_6_1
end

function ChapterV2MapGoLocationItem:Dispose()
	self:UnbindRedPoint()
	Object.Destroy(self.gameObject_)
	ChapterV2MapGoLocationItem.super.Dispose(self)
end

function ChapterV2MapGoLocationItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.nameText_.transform, string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_LOCATION, self.locationId_))
end

function ChapterV2MapGoLocationItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.nameText_.transform)
end

return ChapterV2MapGoLocationItem
