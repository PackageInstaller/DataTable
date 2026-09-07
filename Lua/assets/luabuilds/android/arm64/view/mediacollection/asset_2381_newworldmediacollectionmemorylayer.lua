local NewWorldMediaCollectionMemoryLayer = class("NewWorldMediaCollectionMemoryLayer", import(".WorldMediaCollectionTemplateLayer"))

function NewWorldMediaCollectionMemoryLayer:getUIName()
	return "NewWorldMediaCollectionMemoryUI"
end

function NewWorldMediaCollectionMemoryLayer:OnInit()
	NewWorldMediaCollectionMemoryLayer.super.OnInit(self)
	assert(self.viewParent, "Need assign ViewParent for " .. self.__cname)

	self._top = self._tf:Find("Top")
	self.memoryMask = self._top:Find("StoryMask")

	setActive(self.memoryMask, false)

	self.Layer = -1

	return
end

function NewWorldMediaCollectionMemoryLayer:GetDetailLayer()
	setActive(self._top:Find("RoleTitle"), true)
	setActive(self._top:Find("HonorTitle"), false)

	if not self.detailUI then
		self.detailUI = NewWorldMediaCollectionMemoryDetailLayer.New(self, self._tf, self.event, self.contextData)

		self.detailUI:Load()
		self.detailUI:SetStoryMask(self.memoryMask)
	end

	return self.detailUI
end

function NewWorldMediaCollectionMemoryLayer:HideDetailLayer()
	if not self.detailUI then
		return
	end

	self.detailUI.buffer:Hide()

	return
end

function NewWorldMediaCollectionMemoryLayer:CloseDetailLayer()
	if self.detailUI then
		self.detailUI:Destroy()

		self.detailUI = nil
	end

	return
end

function NewWorldMediaCollectionMemoryLayer:GetGroupLayer()
	setActive(self._top:Find("RoleTitle"), true)
	setActive(self._top:Find("HonorTitle"), false)

	if not self.groupUI then
		self.groupUI = NewWorldMediaCollectionMemoryGroupLayer.New(self, self._tf, self.event, self.contextData)

		self.groupUI:RegisterView(self)
		self.groupUI:Load()
	end

	return self.groupUI
end

function NewWorldMediaCollectionMemoryLayer:HideGroupLayer()
	if not self.groupUI then
		return
	end

	self.groupUI.buffer:Hide()

	return
end

function NewWorldMediaCollectionMemoryLayer:CloseGroupLayer()
	if self.groupUI then
		self.groupUI:Destroy()

		self.groupUI = nil
	end

	return
end

function NewWorldMediaCollectionMemoryLayer:GetHallGloryLayer()
	setActive(self._top:Find("RoleTitle"), false)
	setActive(self._top:Find("HonorTitle"), true)

	if not self.HallGloryUI then
		self.HallGloryUI = HallGloryLayer.New(self, self._tf, self.event, self.contextData)

		self.HallGloryUI:SetStoryMask(self.memoryMask)
		self.HallGloryUI:Load()
	end

	return self.HallGloryUI
end

function NewWorldMediaCollectionMemoryLayer:HideHallGloryLayer()
	if not self.HallGloryUI then
		return
	end

	self.HallGloryUI.buffer:Hide()

	return
end

function NewWorldMediaCollectionMemoryLayer:CloseHallGloryLayer()
	if self.HallGloryUI then
		self.HallGloryUI:Destroy()

		self.HallGloryUI = nil
	end

	return
end

function NewWorldMediaCollectionMemoryLayer:SwitchBetweenGroupsAndItems(arg_12_1)
	if self.groupUI then
		self.groupUI.buffer:SetActive(arg_12_1)
	end

	if self.detailUI then
		self.detailUI.buffer:SetActive(not arg_12_1)
	end

	return
end

function NewWorldMediaCollectionMemoryLayer:OnSelected()
	NewWorldMediaCollectionMemoryLayer.super.OnSelected(self)

	local var_13_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.QIXI_ACTIVITY_ID)

	if var_13_0 and not var_13_0:isEnd() then
		local var_13_1 = _.flatten((var_13_0:getConfig("config_data")))
		local var_13_2 = getProxy(TaskProxy):getTaskById(var_13_1[#var_13_1])

		if var_13_2 and not var_13_2:isFinish() then
			pg.NewStoryMgr.GetInstance():Play("HOSHO8", function()
				self:emit(CollectionScene.ACTIVITY_OP, {
					cmd = 2,
					activity_id = var_13_0.id
				})

				return
			end, true)
		end
	end

	local var_13_3 = self.contextData.memoryGroup

	self.contextData.memoryGroup = nil

	if var_13_3 and pg.memory_group[var_13_3] then
		self:ShowSubMemories(pg.memory_group[var_13_3])
	else
		self:MemoryFilter()
		self:SwitchReddotMemory()
	end

	return
end

function NewWorldMediaCollectionMemoryLayer:OnReselected()
	self:Return2MemoryGroup()

	return
end

function NewWorldMediaCollectionMemoryLayer:OnDeselected()
	self.contextData.memoryGroup = nil

	NewWorldMediaCollectionMemoryLayer.super.OnDeselected(self)

	return
end

function NewWorldMediaCollectionMemoryLayer:Hide()
	self:HideDetailLayer()
	self:HideGroupLayer()
	self:HideHallGloryLayer()
	NewWorldMediaCollectionMemoryLayer.super.Hide(self)

	return
end

function NewWorldMediaCollectionMemoryLayer:OnBackward()
	return self:Return2MemoryGroup()
end

function NewWorldMediaCollectionMemoryLayer:SwitchMemoryFilter(arg_19_1)
	if arg_19_1 == 1 then
		self.memoryFilterIndex = {
			true,
			true,
			true
		}
	else
		for iter_19_0 in ipairs(self.memoryFilterIndex) do
			self.memoryFilterIndex[iter_19_0] = arg_19_1 - 1 == iter_19_0
		end
	end

	return
end

function NewWorldMediaCollectionMemoryLayer:MemoryFilter()
	local var_20_0 = self:GetGroupLayer()

	var_20_0.buffer:Show()
	var_20_0.buffer:MemoryFilter()
	self:HideDetailLayer()

	return
end

function NewWorldMediaCollectionMemoryLayer:SwitchReddotMemory()
	self:GetGroupLayer().buffer:SwitchReddotMemory()

	return
end

function NewWorldMediaCollectionMemoryLayer:ShowSubMemories(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = self:GetDetailLayer()

	var_22_0.buffer:Show()
	var_22_0.buffer:ShowSubMemories(arg_22_1, arg_22_3)

	if not arg_22_2 then
		self:HideGroupLayer()
		self:HideHallGloryLayer()
	end

	return
end

function NewWorldMediaCollectionMemoryLayer:ShowHallGloryLayer(arg_23_1, arg_23_2, arg_23_3)
	self:GetHallGloryLayer().buffer:Show()

	if not arg_23_2 then
		self:HideGroupLayer()
	end

	return
end

function NewWorldMediaCollectionMemoryLayer:Return2MemoryGroup()
	local var_24_1 = self:GetGroupLayer()

	if var_24_1.index == -1 then
		return
	elseif var_24_1.index == 1 then
		var_24_1.buffer:Show()
		var_24_1.buffer:Return2MemoryGroup()
		self:HideDetailLayer()
	elseif var_24_1.index == 2 then
		var_24_1.buffer:Show()
		var_24_1.buffer:Return2MemoryGroup()
		self:HideHallGloryLayer()
	end

	return true
end

function NewWorldMediaCollectionMemoryLayer:Return2Line()
	return
end

function NewWorldMediaCollectionMemoryLayer:UpdateView()
	local var_26_0 = self.contextData.memoryGroup and self.groupUI or self.detailUI

	if not var_26_0 then
		return
	end

	var_26_0.buffer:UpdateView()

	return
end

function NewWorldMediaCollectionMemoryLayer:WrapToStoryLine(arg_27_1)
	local var_27_0 = self:GetGroupLayer()

	var_27_0:SwitchStoryLineMode(var_27_0.LINE_MODE)
	var_27_0.storyLineView:ShowNodeDetail(arg_27_1)

	return
end

function NewWorldMediaCollectionMemoryLayer:OnDestroy()
	self:CloseDetailLayer()
	self:CloseGroupLayer()
	NewWorldMediaCollectionMemoryLayer.super.OnDestroy(self)

	return
end

return NewWorldMediaCollectionMemoryLayer
