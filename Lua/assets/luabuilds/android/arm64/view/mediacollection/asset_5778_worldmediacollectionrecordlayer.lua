local WorldMediaCollectionRecordLayer = class("WorldMediaCollectionRecordLayer", import(".WorldMediaCollectionTemplateLayer"))

function WorldMediaCollectionRecordLayer:getUIName()
	return "WorldMediaCollectionRecordUI"
end

function WorldMediaCollectionRecordLayer:OnInit()
	self._top = self._tf:Find("Top")
	self.memoryMask = self._top:Find("StoryMask")

	return
end

function WorldMediaCollectionRecordLayer:OnSelected()
	WorldMediaCollectionRecordLayer.super.OnSelected(self)

	if self.contextData.recordGroup then
		self:ShowRecordGroup(self.contextData.recordGroup)
	else
		self:OpenGroupLayer()
	end

	return
end

function WorldMediaCollectionRecordLayer:Backward()
	if not self.contextData.recordGroup then
		return
	end

	self.contextData.recordGroup = nil

	if self.contextData.storyNodeID then
		self.contextData.storyNodeID = nil

		self.viewParent:WarpToStoryNode(self.contextData.storyNodeID)
	else
		self:OpenGroupLayer()
	end

	return true
end

function WorldMediaCollectionRecordLayer:OnBackward()
	return self:Backward()
end

function WorldMediaCollectionRecordLayer:OnReselected()
	self:Backward()

	return
end

function WorldMediaCollectionRecordLayer:OnDeselected()
	self.contextData.recordGroup = nil

	WorldMediaCollectionRecordLayer.super.OnDeselected(self)

	return
end

function WorldMediaCollectionRecordLayer:Hide()
	self:HideDetailLayer()
	self:HideGroupLayer()
	WorldMediaCollectionRecordLayer.super.Hide(self)

	return
end

function WorldMediaCollectionRecordLayer:GetDetailLayer()
	if not self.detailUI then
		self.detailUI = WorldMediaCollectionRecordDetailLayer.New(self, self._tf, self.event, self.contextData)

		self.detailUI:RegisterView(self.viewComponent)
		self.detailUI:Load()
		self.detailUI:SetStoryMask(self.memoryMask)
	end

	return self.detailUI
end

function WorldMediaCollectionRecordLayer:ShowRecordGroup(arg_10_1)
	local var_10_0 = self:GetDetailLayer()

	var_10_0.buffer:Show()
	var_10_0.buffer:ShowRecordGroup(arg_10_1)
	self:HideGroupLayer()

	return
end

function WorldMediaCollectionRecordLayer:HideDetailLayer()
	if not self.detailUI then
		return
	end

	self.detailUI.buffer:Hide()

	return
end

function WorldMediaCollectionRecordLayer:CloseDetailLayer()
	if self.detailUI then
		self.detailUI:Destroy()

		self.detailUI = nil
	end

	return
end

function WorldMediaCollectionRecordLayer:OpenGroupLayer()
	local var_13_0 = self:GetGroupLayer()

	var_13_0.buffer:Show()
	var_13_0.buffer:RecordFilter()
	self:HideDetailLayer()

	return
end

function WorldMediaCollectionRecordLayer:GetGroupLayer()
	if not self.groupUI then
		self.groupUI = WorldMediaCollectionRecordGroupLayer.New(self, self._tf, self.event, self.contextData)

		self.groupUI:RegisterView(self.viewComponent)
		self.groupUI:Load()
	end

	return self.groupUI
end

function WorldMediaCollectionRecordLayer:HideGroupLayer()
	if not self.groupUI then
		return
	end

	self.groupUI.buffer:Hide()

	return
end

function WorldMediaCollectionRecordLayer:CloseGroupLayer()
	if self.groupUI then
		self.groupUI:Destroy()

		self.groupUI = nil
	end

	return
end

function WorldMediaCollectionRecordLayer:OnDestroy()
	self:CloseDetailLayer()
	self:CloseGroupLayer()
	WorldMediaCollectionRecordLayer.super.OnDestroy(self)

	return
end

return WorldMediaCollectionRecordLayer
