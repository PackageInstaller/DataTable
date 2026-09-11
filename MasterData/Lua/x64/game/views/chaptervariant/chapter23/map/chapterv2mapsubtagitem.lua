local ChapterV2MapSubTagItem = class("ChapterV2MapSubTagItem", ReduxView)

function ChapterV2MapSubTagItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.controllerEx_:GetController("state")
	self.selectController_ = self.controllerEx_:GetController("select")
end

function ChapterV2MapSubTagItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self.OnClickSubTag(self, self, self.tagId_)
	end)
end

function ChapterV2MapSubTagItem:SetData(arg_4_1, arg_4_2)
	self.tagId_ = arg_4_1
	self.isSelect_ = arg_4_2

	self:RefreshUI()
end

function ChapterV2MapSubTagItem:RefreshUI()
	self.tagCfg_ = ChapterV2MapTagCfg[self.tagId_]
	self.text_.text = self.isSelect_ and "->" .. self.tagCfg_.tag_name or self.tagCfg_.tag_name

	local var_5_0 = ChapterV2MapConst.ICONTYPE.NONE

	if self.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBLOCATION then
		local var_5_1 = ChapterV2MapTagCfg[ChapterV2MapData:GetLocationActiveTagList(self.tagId_)[1]]

		if var_5_1 then
			if ChapterV2MapEventCfg[var_5_1.behaviour_parameters[1]] then
				var_5_0 = ChapterV2MapEventCfg[var_5_1.behaviour_parameters[1]].type
			end
		end
	elseif ChapterV2MapEventCfg[self.tagCfg_.behaviour_parameters[1]] then
		var_5_0 = ChapterV2MapEventCfg[self.tagCfg_.behaviour_parameters[1]].type
	end

	self.stateController_:SetSelectedState(tostring(var_5_0))
	self.selectController_:SetSelectedState(tostring(self.isSelect_))
	self:BindRedPoint()
end

function ChapterV2MapSubTagItem:SetSelectedState(arg_6_1)
	self.isSelect_ = arg_6_1

	self.selectController_:SetSelectedState(tostring(self.isSelect_))
end

function ChapterV2MapSubTagItem:SetClickCallBack(arg_7_1)
	self.clickCallBack_ = arg_7_1
end

function ChapterV2MapSubTagItem:OnClickSubTag(arg_8_1, arg_8_2)
	if self.clickCallBack_ then
		self.clickCallBack_(arg_8_1, arg_8_2)
	end
end

function ChapterV2MapSubTagItem:Dispose()
	self:UnbindRedPoint()
	ChapterV2MapSubTagItem.super.Dispose(self)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterV2MapSubTagItem:BindRedPoint()
	local var_10_0

	if self.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.EVENT then
		var_10_0 = self.tagCfg_.behaviour_parameters[1]
	elseif self.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBLOCATION then
		var_10_0 = ChapterV2MapTools.GetLocationEvents(self.tagId_)[1]
	end

	if var_10_0 and var_10_0 ~= 0 then
		manager.redPoint:bindUIandKey(self.text_.transform, string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_EVENT, var_10_0))
	else
		self:UnbindRedPoint()
	end
end

function ChapterV2MapSubTagItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.text_.transform)
end

return ChapterV2MapSubTagItem
