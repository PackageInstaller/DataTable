local CourtYardLeftPanel = class("CourtYardLeftPanel", import(".CourtYardBasePanel"))

function CourtYardLeftPanel:GetUIName()
	return "main/leftPanel"
end

function CourtYardLeftPanel:init()
	self.viewBtn = self._tf:Find("eye_btn")

	return
end

function CourtYardLeftPanel:OnRegister()
	onToggle(self, self.viewBtn, function(arg_4_0)
		self:emit(CourtYardMediator.FOLD, arg_4_0)

		return
	end, SFX_PANEL)

	return
end

function CourtYardLeftPanel:OnEnterEditMode()
	CourtYardLeftPanel.super.OnEnterEditMode(self)
	setActive(self.viewBtn, false)

	return
end

function CourtYardLeftPanel:OnExitEditMode()
	CourtYardLeftPanel.super.OnExitEditMode(self)
	setActive(self.viewBtn, true)

	return
end

function CourtYardLeftPanel:UpdateFloor()
	return
end

function CourtYardLeftPanel:OnVisitRegister()
	onToggle(self, self.viewBtn, function(arg_9_0)
		self:emit(CourtYardMediator.FOLD, arg_9_0)

		return
	end, SFX_PANEL)

	return
end

function CourtYardLeftPanel:GetMoveX()
	return {}
end

function CourtYardLeftPanel:OnFlush(arg_11_1)
	return
end

return CourtYardLeftPanel
