local Island3dTaskTrackPanel = class("Island3dTaskTrackPanel", import("view.base.BaseSubView"))

function Island3dTaskTrackPanel:getUIName()
	return "Island3dTaskTrackPanel"
end

function Island3dTaskTrackPanel:OnLoaded()
	self.uiAnim = self._tf:GetComponent(typeof(Animation))
	self.uiAnimEvent = self._tf:GetComponent(typeof(DftAniEvent))

	self.uiAnimEvent:SetEndEvent(function()
		self:Hide()

		return
	end)

	self.mainTrackCard = IslandTaskTrackCard.New(self._tf:Find("content"), self.event, IslandTaskTrackCard.TYPES.MAIN)
	self.otherTrackCard = IslandTaskTrackCard.New(self._tf:Find("other_content"), self.event, IslandTaskTrackCard.TYPES.OTHER)

	return
end

function Island3dTaskTrackPanel:OnInit()
	onButton(self, self.mainTrackCard._tf, function()
		if not getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(IslandGuideChecker.MOVE_TASK_ID) then
			return
		end

		self:emit(IslandMediator.OPEN_PAGE, "Island3dTaskPage", {
			0,
			self.mainTask.id
		})

		return
	end, SFX_PANEL)
	onButton(self, self.otherTrackCard._tf, function()
		if not getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(IslandGuideChecker.MOVE_TASK_ID) then
			return
		end

		self:emit(IslandMediator.OPEN_PAGE, "Island3dTaskPage", {
			0,
			self.otherTask.id
		})

		return
	end, SFX_PANEL)

	self.unlock = getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(pg.island_set.main_page_function_unlock.key_value_varchar[2])

	return
end

function Island3dTaskTrackPanel:Show()
	setActive(self._tf, self.unlock)
	self:ShowOrHideResUI(true)
	self:PlayBGM()
	self:UpdataAllTask()

	return
end

function Island3dTaskTrackPanel:UpdataAllTask()
	self.mainTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetMainTraceTask()

	if not self.mainTask then
		self.mainTrackCard:UnTrackUI()
	end

	self.otherTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTraceTask()

	if not self.otherTask then
		self.otherTrackCard:UnTrackUI()
	end

	if not self.mainTask and not self.otherTask then
		return
	end

	if self.unlock then
		self.uiAnim:Play("Island3dTaskTrackPanel_in")
	end

	self:UpdateTask(IslandTaskTrackCard.TYPES.MAIN)
	self:UpdateTask(IslandTaskTrackCard.TYPES.OTHER)

	return
end

function Island3dTaskTrackPanel:UpdateTask(arg_9_1)
	if arg_9_1 == IslandTaskTrackCard.TYPES.MAIN then
		self.mainTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetMainTraceTask()

		self.mainTrackCard:Update(self.mainTask, self.unlock)
	elseif arg_9_1 == IslandTaskTrackCard.TYPES.OTHER then
		self.otherTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTraceTask()

		self.otherTrackCard:Update(self.otherTask, self.unlock)
	end

	return
end

function Island3dTaskTrackPanel:UpdateProgress(arg_10_1)
	if arg_10_1 == IslandTaskTrackCard.TYPES.MAIN then
		self.mainTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetMainTraceTask()

		if self.mainTask then
			self.mainTrackCard:UpdateProgress(self.mainTask)
		end
	elseif arg_10_1 == IslandTaskTrackCard.TYPES.OTHER then
		self.otherTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTraceTask()

		if self.otherTask then
			self.otherTrackCard:UpdateProgress(self.otherTask)
		end
	end

	return
end

function Island3dTaskTrackPanel:RemoveTask(arg_11_1)
	if arg_11_1 == IslandTaskTrackCard.TYPES.MAIN then
		self.mainTrackCard:RemoveTask()
	elseif arg_11_1 == IslandTaskTrackCard.TYPES.OTHER then
		self.otherTrackCard:RemoveTask()
	end

	self:emit(IslandMediator.ON_SET_TRACE_ID, 0, arg_11_1)

	self.mainTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetMainTraceTask()
	self.otherTask = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTraceTask()

	if not self.mainTask and not self.otherTask then
		self:Hide()
	end

	return
end

function Island3dTaskTrackPanel:SetUnlock()
	self.unlock = true

	if self.mainTask then
		self.mainTrackCard:Update(self.mainTask, self.unlock)
	end

	if self.otherTask then
		self.otherTrackCard:Update(self.otherTask, self.unlock)
	end

	return
end

function Island3dTaskTrackPanel:Hide()
	Island3dTaskTrackPanel.super.Hide(self)
	self.mainTrackCard:UnTrackUI()
	self.otherTrackCard:UnTrackUI()

	return
end

function Island3dTaskTrackPanel:OnDestroy()
	self.uiAnimEvent:SetEndEvent(nil)
	self.mainTrackCard:Dispose()

	self.mainTrackCard = nil

	self.otherTrackCard:Dispose()

	self.otherTrackCard = nil

	return
end

return Island3dTaskTrackPanel
