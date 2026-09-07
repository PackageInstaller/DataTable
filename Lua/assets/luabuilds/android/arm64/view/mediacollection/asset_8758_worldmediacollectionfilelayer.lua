local WorldMediaCollectionFileLayer = class("WorldMediaCollectionFileLayer", import(".WorldMediaCollectionTemplateLayer"))

function WorldMediaCollectionFileLayer:getUIName()
	return "WorldMediaCollectionFileUI"
end

function WorldMediaCollectionFileLayer:OnInit()
	self._top = self._tf:Find("Top")

	return
end

function WorldMediaCollectionFileLayer:GetDetailLayer()
	if not self.detailLayer then
		self.detailLayer = WorldMediaCollectionFileDetailLayer.New(self, self._tf, self.event, self.contextData)

		self.detailLayer:Load()
	end

	return self.detailLayer
end

function WorldMediaCollectionFileLayer:OpenDetailLayer(arg_4_1, arg_4_2)
	local var_4_0 = self:GetDetailLayer()

	self.contextData.FileGroupIndex = arg_4_1

	var_4_0.buffer:Show()

	if arg_4_2 then
		var_4_0.buffer:Openning()
	else
		var_4_0.buffer:Enter()
	end

	self:HideGroupLayer()

	return
end

function WorldMediaCollectionFileLayer:HideDetailLayer()
	if not self.detailLayer then
		return
	end

	self.detailLayer.buffer:Hide()

	return
end

function WorldMediaCollectionFileLayer:CloseDetailLayer()
	if self.detailLayer then
		self.detailLayer:Destroy()

		self.detailLayer = nil
	end

	return
end

function WorldMediaCollectionFileLayer:GetGroupLayer()
	if not self.groupLayer then
		self.groupLayer = WorldMediaCollectionFileGroupLayer.New(self, self._tf, self.event, self.contextData)

		self.groupLayer:Load()
	end

	return self.groupLayer
end

function WorldMediaCollectionFileLayer:OpenGroupLayer()
	local var_8_0 = self:GetGroupLayer()

	var_8_0.buffer:Show()
	var_8_0.buffer:UpdateGroupList()
	self:HideDetailLayer()

	return
end

function WorldMediaCollectionFileLayer:HideGroupLayer()
	if not self.groupLayer then
		return
	end

	self.groupLayer.buffer:Hide()

	return
end

function WorldMediaCollectionFileLayer:CloseGroupLayer()
	if self.groupLayer then
		self.groupLayer:Destroy()

		self.groupLayer = nil
	end

	return
end

function WorldMediaCollectionFileLayer:OnSelected()
	WorldMediaCollectionFileLayer.super.OnSelected(self)

	if self.contextData.FileGroupIndex then
		self:OpenDetailLayer(self.contextData.FileGroupIndex)
	else
		self:OpenGroupLayer()
	end

	return
end

function WorldMediaCollectionFileLayer:OnReselected()
	WorldMediaCollectionFileLayer.super.OnReselected(self)
	self:Backward()

	return
end

function WorldMediaCollectionFileLayer:OnDeselected()
	self.contextData.FileGroupIndex = nil
	self.contextData.SelectedFile = nil

	WorldMediaCollectionFileLayer.super.OnDeselected(self)

	return
end

function WorldMediaCollectionFileLayer:Hide()
	self:HideDetailLayer()
	self:HideGroupLayer()
	WorldMediaCollectionFileLayer.super.Hide(self)

	return
end

function WorldMediaCollectionFileLayer:Backward()
	if not self.contextData.FileGroupIndex then
		return
	end

	self.contextData.FileGroupIndex = nil
	self.contextData.SelectedFile = nil

	self:OpenGroupLayer()

	return true
end

function WorldMediaCollectionFileLayer:OnBackward()
	return self:Backward()
end

function WorldMediaCollectionFileLayer:OnDestroy()
	self:CloseDetailLayer()
	self:CloseGroupLayer()
	WorldMediaCollectionFileLayer.super.OnDestroy(self)

	return
end

return WorldMediaCollectionFileLayer
