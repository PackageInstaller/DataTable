local WorldMediaCollectionAlbumLayer = class("WorldMediaCollectionAlbumLayer", import(".WorldMediaCollectionTemplateLayer"))

function WorldMediaCollectionAlbumLayer:getUIName()
	return "WorldMediaCollectionAlbumUI"
end

function WorldMediaCollectionAlbumLayer:OnInit()
	WorldMediaCollectionAlbumLayer.super.OnInit(self)
	assert(self.viewParent, "Need assign ViewParent for " .. self.__cname)

	self._top = self._tf:Find("Top")
	self.memoryMask = self._top:Find("StoryMask")

	setActive(self.memoryMask, false)

	return
end

function WorldMediaCollectionAlbumLayer:GetDetailLayer()
	if not self.detailUI then
		self.detailUI = WorldMediaCollectionMemoryDetailLayer.New(self, self._tf, self.event, self.contextData)

		self.detailUI:Load()
		self.detailUI:SetStoryMask(self.memoryMask)
	end

	return self.detailUI
end

function WorldMediaCollectionAlbumLayer:GetGroupLayer()
	if not self.groupUI then
		self.groupUI = WorldMediaCollectionAlbumGroupLayer.New(self, self._tf, self.event, self.contextData)

		self.groupUI:Load()
	end

	return self.groupUI
end

function WorldMediaCollectionAlbumLayer:HideGroupLayer()
	if not self.groupUI then
		return
	end

	self.groupUI.buffer:Hide()

	return
end

function WorldMediaCollectionAlbumLayer:CloseGroupLayer()
	if self.groupUI then
		self.groupUI:Destroy()

		self.groupUI = nil
	end

	return
end

function WorldMediaCollectionAlbumLayer:SwitchBetweenGroupsAndItems(arg_7_1)
	if self.groupUI then
		self.groupUI.buffer:SetActive(arg_7_1)
	end

	if self.detailUI then
		self.detailUI.buffer:SetActive(not arg_7_1)
	end

	return
end

function WorldMediaCollectionAlbumLayer:OnSelected()
	WorldMediaCollectionAlbumLayer.super.OnSelected(self)

	local var_8_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.QIXI_ACTIVITY_ID)

	if var_8_0 and not var_8_0:isEnd() then
		local var_8_1 = _.flatten((var_8_0:getConfig("config_data")))
		local var_8_2 = getProxy(TaskProxy):getTaskById(var_8_1[#var_8_1])

		if var_8_2 and not var_8_2:isFinish() then
			pg.NewStoryMgr.GetInstance():Play("HOSHO8", function()
				self:emit(CollectionScene.ACTIVITY_OP, {
					cmd = 2,
					activity_id = var_8_0.id
				})

				return
			end, true)
		end
	end

	local var_8_3 = self.contextData.memoryGroup

	self.contextData.memoryGroup = nil

	if var_8_3 and pg.memory_group[var_8_3] then
		self:ShowSubMemories(pg.memory_group[var_8_3])
	else
		self:MemoryFilter()
		self:SwitchReddotMemory()
	end

	return
end

function WorldMediaCollectionAlbumLayer:OnReselected()
	self:Return2MemoryGroup()

	return
end

function WorldMediaCollectionAlbumLayer:OnDeselected()
	self.contextData.memoryGroup = nil

	WorldMediaCollectionAlbumLayer.super.OnDeselected(self)

	return
end

function WorldMediaCollectionAlbumLayer:Hide()
	self:HideGroupLayer()
	WorldMediaCollectionAlbumLayer.super.Hide(self)

	return
end

function WorldMediaCollectionAlbumLayer:OnBackward()
	return self:Return2MemoryGroup()
end

function WorldMediaCollectionAlbumLayer:SwitchMemoryFilter(arg_14_1)
	if arg_14_1 == 1 then
		self.memoryFilterIndex = {
			true,
			true,
			true
		}
	else
		for iter_14_0 in ipairs(self.memoryFilterIndex) do
			self.memoryFilterIndex[iter_14_0] = arg_14_1 - 1 == iter_14_0
		end
	end

	return
end

function WorldMediaCollectionAlbumLayer:MemoryFilter()
	self:GetGroupLayer().buffer:Show()

	return
end

function WorldMediaCollectionAlbumLayer:SwitchReddotMemory()
	self:GetGroupLayer().buffer:SwitchReddotMemory()

	return
end

function WorldMediaCollectionAlbumLayer:ShowAlbum(arg_17_1)
	self.viewParent:emit(WorldMediaCollectionMediator.ON_ADD_SUBLAYER, (Context.New({
		mediator = _G[arg_17_1.ui_prefab.mediator],
		viewComponent = _G[arg_17_1.ui_prefab.scene]
	})))

	return
end

function WorldMediaCollectionAlbumLayer:Return2MemoryGroup()
	if not self.contextData.memoryGroup then
		return
	end

	local var_18_0 = self:GetGroupLayer()

	var_18_0.buffer:Show()
	var_18_0.buffer:Return2MemoryGroup()

	self.contextData.memoryGroup = nil

	return true
end

function WorldMediaCollectionAlbumLayer:UpdateView()
	local var_19_0 = self.contextData.memoryGroup and self.groupUI or self.detailUI

	if not var_19_0 then
		return
	end

	var_19_0.buffer:UpdateView()

	return
end

function WorldMediaCollectionAlbumLayer:OnDestroy()
	self:CloseGroupLayer()
	WorldMediaCollectionAlbumLayer.super.OnDestroy(self)

	return
end

return WorldMediaCollectionAlbumLayer
