local BaseSubPanel = class("BaseSubPanel", import("view.base.BaseSubView"))
local FuncBuffer = import("view.util.FuncBuffer")
local AutoLoader = import("view.util.AutoLoader")

function BaseSubPanel:Ctor(arg_1_1)
	assert(arg_1_1, "NIL Parent View")
	BaseSubPanel.super:Ctor(arg_1_1 and arg_1_1._tf, (arg_1_1 and isa(arg_1_1, BaseEventLogic) or nil) and (arg_1_1.event or nil), {})

	self.buffer = FuncBuffer.New()
	self.loader = AutoLoader.New()
	self.viewParent = arg_1_1

	return
end

function BaseSubPanel:Init()
	if self._state ~= BaseSubPanel.STATES.LOADED then
		return
	end

	self._state = BaseSubPanel.STATES.INITED

	bindComponent(self, self._go)
	self:OnInit()
	self:Show()
	self:HandleFuncQueue()
	self.buffer:SetNotifier(self)
	self.buffer:ExcuteAll()

	return
end

function BaseSubPanel:Destroy()
	if self._state == BaseSubPanel.STATES.DESTROY then
		return
	end

	if not self:GetLoaded() then
		self._state = BaseSubPanel.STATES.DESTROY

		return
	end

	self._state = BaseSubPanel.STATES.DESTROY

	pg.DelegateInfo.Dispose(self)
	self:Hide()
	self:OnDestroy()
	self.loader:Clear()
	self.buffer:Clear()
	bindComponent(self, self._go, true)
	self:disposeEvent()
	self:cleanManagedTween()

	self._tf = nil

	local var_3_0 = self:getUIName()

	if self._go ~= nil and var_3_0 then
		PoolMgr.GetInstance():ReturnUI(var_3_0, self._go)

		self._go = nil
	end

	return
end

function BaseSubPanel:Hide()
	self:OnHide()
	BaseSubPanel.super.Hide(self)

	return
end

function BaseSubPanel:RawHide()
	BaseSubPanel.super.Hide(self)

	return
end

function BaseSubPanel:Show()
	BaseSubPanel.super.Show(self)
	self:OnShow()

	return
end

function BaseSubPanel:RawShow()
	BaseSubPanel.super.Show(self)

	return
end

function BaseSubPanel:IsShowing()
	return self:GetLoaded() and isActive(self._go)
end

function BaseSubPanel:IsHiding()
	return self:GetLoaded() and not isActive(self._go)
end

function BaseSubPanel:SetParent(arg_10_1, ...)
	setParent(self._tf, arg_10_1, ...)

	return
end

function BaseSubPanel:OnShow()
	return
end

function BaseSubPanel:OnHide()
	return
end

return BaseSubPanel
