local Dorm3dGameBaseSubView = class("Dorm3dGameBaseSubView", import("view.base.BaseEventLogic"))

function Dorm3dGameBaseSubView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(self)
	Dorm3dGameBaseSubView.super.Ctor(self, arg_1_2)

	self._tf = arg_1_1
	self.go = arg_1_1.gameObject
	self.contextData = arg_1_3

	self:Init()

	return
end

function Dorm3dGameBaseSubView:Init()
	return
end

function Dorm3dGameBaseSubView:Flush()
	return
end

function Dorm3dGameBaseSubView:Show()
	setActive(self._tf, true)

	return
end

function Dorm3dGameBaseSubView:Hide()
	setActive(self._tf, false)

	return
end

function Dorm3dGameBaseSubView:Dispose()
	self:cleanManagedTween()
	self:disposeEvent()
	pg.DelegateInfo.Dispose(self)

	return
end

return Dorm3dGameBaseSubView
