local WorldMediaCollectionMemoryLayer = class("WorldMediaCollectionMemoryLayer", import(".WorldMediaCollectionTemplateLayer"))

function WorldMediaCollectionMemoryLayer:getUIName()
	return "WorldMediaCollectionMemoryUI"
end

function WorldMediaCollectionMemoryLayer:OnInit()
	WorldMediaCollectionMemoryLayer.super.OnInit(self)
	assert(self.viewParent, "Need assign ViewParent for " .. self.__cname)

	self._top = self._tf:Find("Top")
	self.memoryMask = self._top:Find("StoryMask")

	setActive(self.memoryMask, false)

	return
end

function WorldMediaCollectionMemoryLayer:GetDetailLayer()
	if not self.detailUI then
		self.detailUI = WorldMediaCollectionMemoryDetailLayer.New(self, self._tf, self.event, self.contextData)

		self.detailUI:Load()
		self.detailUI:SetStoryMask(self.memoryMask)
	end

	return self.detailUI
end

function WorldMediaCollectionMemoryLayer:HideDetailLayer()
	if not self.detailUI then
		return
	end

	self.detailUI.buffer:Hide()

	return
end

function WorldMediaCollectionMemoryLayer:CloseDetailLayer()
	if self.detailUI then
		self.detailUI:Destroy()

		self.detailUI = nil
	end

	return
end

function WorldMediaCollectionMemoryLayer:GetGroupLayer()
	if not self.groupUI then
		self.groupUI = WorldMediaCollectionMemoryGroupLayer.New(self, self._tf, self.event, self.contextData)

		self.groupUI:RegisterView(self)
		self.groupUI:Load()
	end

	return self.groupUI
end

function WorldMediaCollectionMemoryLayer:HideGroupLayer()
	if not self.groupUI then
		return
	end

	self.groupUI.buffer:Hide()

	return
end

function WorldMediaCollectionMemoryLayer:CloseGroupLayer()
	if self.groupUI then
		self.groupUI:Destroy()

		self.groupUI = nil
	end

	return
end

function WorldMediaCollectionMemoryLayer:SwitchBetweenGroupsAndItems(arg_9_1)
	if self.groupUI then
		self.groupUI.buffer:SetActive(arg_9_1)
	end

	if self.detailUI then
		self.detailUI.buffer:SetActive(not arg_9_1)
	end

	return
end

function WorldMediaCollectionMemoryLayer:OnSelected()
	WorldMediaCollectionMemoryLayer.super.OnSelected(self)

	local var_10_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.QIXI_ACTIVITY_ID)

	if var_10_0 and not var_10_0:isEnd() then
		local var_10_1 = _.flatten((var_10_0:getConfig("config_data")))
		local var_10_2 = getProxy(TaskProxy):getTaskById(var_10_1[#var_10_1])

		if var_10_2 and not var_10_2:isFinish() then
			pg.NewStoryMgr.GetInstance():Play("HOSHO8", function()
				self:emit(CollectionScene.ACTIVITY_OP, {
					cmd = 2,
					activity_id = var_10_0.id
				})

				return
			end, true)
		end
	end

	local var_10_3 = self.contextData.memoryGroup

	self.contextData.memoryGroup = nil

	if var_10_3 and pg.memory_group[var_10_3] then
		self:ShowSubMemories(pg.memory_group[var_10_3])
	else
		self:MemoryFilter()
		self:SwitchReddotMemory()
	end

	return
end

function WorldMediaCollectionMemoryLayer:OnReselected()
	self:Return2MemoryGroup()

	return
end

function WorldMediaCollectionMemoryLayer:OnDeselected()
	self.contextData.memoryGroup = nil

	WorldMediaCollectionMemoryLayer.super.OnDeselected(self)

	return
end

function WorldMediaCollectionMemoryLayer:Hide()
	self:HideDetailLayer()
	self:HideGroupLayer()
	WorldMediaCollectionMemoryLayer.super.Hide(self)

	return
end

function WorldMediaCollectionMemoryLayer:OnBackward()
	return self:Return2MemoryGroup()
end

function WorldMediaCollectionMemoryLayer:SwitchMemoryFilter(arg_16_1)
	if arg_16_1 == 1 then
		self.memoryFilterIndex = {
			true,
			true,
			true
		}
	else
		for iter_16_0 in ipairs(self.memoryFilterIndex) do
			self.memoryFilterIndex[iter_16_0] = arg_16_1 - 1 == iter_16_0
		end
	end

	return
end

function WorldMediaCollectionMemoryLayer:MemoryFilter()
	local var_17_0 = self:GetGroupLayer()

	var_17_0.buffer:Show()
	var_17_0.buffer:MemoryFilter()
	self:HideDetailLayer()

	return
end

function WorldMediaCollectionMemoryLayer:SwitchReddotMemory()
	self:GetGroupLayer().buffer:SwitchReddotMemory()

	return
end

function WorldMediaCollectionMemoryLayer:ShowSubMemories(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = self:GetDetailLayer()

	var_19_0.buffer:Show()
	var_19_0.buffer:ShowSubMemories(arg_19_1, arg_19_3)

	if not arg_19_2 then
		self:HideGroupLayer()
	end

	return
end

function WorldMediaCollectionMemoryLayer:Return2MemoryGroup()
	local var_20_0 = self:GetGroupLayer()

	if var_20_0:GetCurrentMode() == var_20_0.LINE_MODE then
		if not self.contextData.memoryGroup then
			var_20_0:SwitchStoryLineMode(var_20_0.FORM_MODE)
		else
			var_20_0.storyLineView:TryPlayBGM()
		end
	elseif not self.contextData.memoryGroup then
		return
	end

	var_20_0.buffer:Show()
	var_20_0.buffer:Return2MemoryGroup()

	self.contextData.memoryGroup = nil

	self:HideDetailLayer()

	return true
end

function WorldMediaCollectionMemoryLayer:Return2Line()
	return
end

function WorldMediaCollectionMemoryLayer:UpdateView()
	local var_22_0 = self.contextData.memoryGroup and self.groupUI or self.detailUI

	if not var_22_0 then
		return
	end

	var_22_0.buffer:UpdateView()

	return
end

function WorldMediaCollectionMemoryLayer:WrapToStoryLine(arg_23_1)
	local var_23_0 = self:GetGroupLayer()

	var_23_0:SwitchStoryLineMode(var_23_0.LINE_MODE)
	var_23_0.storyLineView:ShowNodeDetail(arg_23_1)

	return
end

function WorldMediaCollectionMemoryLayer:OnDestroy()
	self:CloseDetailLayer()
	self:CloseGroupLayer()
	WorldMediaCollectionMemoryLayer.super.OnDestroy(self)

	return
end

return WorldMediaCollectionMemoryLayer
