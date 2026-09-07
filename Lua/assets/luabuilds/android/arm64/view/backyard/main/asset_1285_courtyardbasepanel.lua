local CourtYardBasePanel = class("CourtYardBasePanel", import("...base.BasePanel"))
local var_0_1 = 0.5
local var_0_2 = 0
local var_0_3 = 1

function CourtYardBasePanel:Ctor(arg_1_1)
	self.state = var_0_2

	local var_1_0 = arg_1_1._tf:Find((self:GetUIName()))

	self._go = var_1_0.gameObject
	self._tf = var_1_0
	self.contextData = arg_1_1.contextData

	self:Attach(arg_1_1)

	return
end

function CourtYardBasePanel:Attach(arg_2_1)
	CourtYardBasePanel.super.attach(self, arg_2_1)
	self:init()
	self:Active()

	self.state = var_0_3

	return
end

function CourtYardBasePanel:Active()
	if self:IsVisit() then
		self:OnVisitRegister()
	else
		self:OnRegister()
	end

	return
end

function CourtYardBasePanel:Detach()
	if self.state == var_0_3 then
		self.state = var_0_2

		CourtYardBasePanel.super.detach(self)
	end

	self:OnDispose()

	return
end

function CourtYardBasePanel:Fold(arg_5_1)
	local var_5_0 = self:GetMoveX()
	local var_5_1 = self:GetMoveY()

	if _.any(var_5_1, function(arg_6_0)
		return LeanTween.isTweening(go(arg_6_0[1]))
	end) or _.any(var_5_0, function(arg_7_0)
		return LeanTween.isTweening(go(arg_7_0[1]))
	end) then
		return
	end

	_.each(var_5_0, function(arg_8_0)
		self:Tween("moveX", arg_5_1, arg_8_0[1], (arg_5_1 or nil) and arg_8_0[1].anchoredPosition3D.x + arg_8_0[1].rect.width * arg_8_0[2])

		return
	end)
	_.each(var_5_1, function(arg_9_0)
		self:Tween("moveY", arg_5_1, arg_9_0[1], (arg_5_1 or nil) and arg_9_0[1].anchoredPosition3D.y + arg_9_0[1].rect.height * arg_9_0[2])

		return
	end)

	return
end

function CourtYardBasePanel:Flush(arg_10_1, arg_10_2)
	if self.state == var_0_3 then
		self.dorm = arg_10_1

		if self:IsVisit() then
			self:OnVisitFlush()
		else
			self:OnFlush(arg_10_2)
		end
	end

	return
end

function CourtYardBasePanel:GetMoveX()
	return {}
end

function CourtYardBasePanel:GetMoveY()
	return {}
end

function CourtYardBasePanel:Tween(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	LeanTween[arg_13_1](arg_13_3, arg_13_4, var_0_1):setOnComplete(System.Action(function()
		if arg_13_2 then
			setActive(arg_13_3, false)
		end

		return
	end)):setOnStart(System.Action(function()
		if not arg_13_2 then
			setActive(arg_13_3, true)
		end

		return
	end))

	return
end

function CourtYardBasePanel:IsInner()
	return self.contextData.floor == 1 or self.contextData.floor == 2
end

function CourtYardBasePanel:OnEnterOrExitEdit(arg_17_1)
	if arg_17_1 then
		self:OnEnterEditMode()
	else
		self:OnExitEditMode()
	end

	return
end

function CourtYardBasePanel:IsVisit()
	return self.contextData.mode == CourtYardConst.SYSTEM_VISIT
end

function CourtYardBasePanel:OnEnterEditMode()
	setActive(self._tf, false)

	return
end

function CourtYardBasePanel:OnExitEditMode()
	setActive(self._tf, true)

	return
end

function CourtYardBasePanel:GetUIName()
	assert(false)

	return
end

function CourtYardBasePanel:OnRegister()
	return
end

function CourtYardBasePanel:OnVisitRegister()
	return
end

function CourtYardBasePanel:OnDispose()
	return
end

function CourtYardBasePanel:OnVisitFlush()
	return
end

function CourtYardBasePanel:OnFlush(arg_26_1)
	return
end

function CourtYardBasePanel:OnRemoveLayer(arg_27_1)
	return
end

function CourtYardBasePanel:onBackPressed()
	return false
end

function CourtYardBasePanel:UpdateFloor()
	return
end

function CourtYardBasePanel:SetActive(arg_30_1, arg_30_2)
	setActiveViaLayer(arg_30_1, arg_30_2)

	return
end

return CourtYardBasePanel
