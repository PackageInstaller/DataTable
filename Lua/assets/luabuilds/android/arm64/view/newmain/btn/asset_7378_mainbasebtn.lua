local MainBaseBtn = class("MainBaseBtn", import("view.base.BaseEventLogic"))

function MainBaseBtn:Ctor(arg_1_1, arg_1_2)
	MainBaseBtn.super.Ctor(self, arg_1_2)

	self._tf = arg_1_1

	return
end

function MainBaseBtn:GetTarget()
	return self._tf
end

function MainBaseBtn:IsFixed()
	return false
end

function MainBaseBtn:OnClick()
	return
end

function MainBaseBtn:Flush(arg_5_1)
	return
end

function MainBaseBtn:Dispose()
	self:disposeEvent()

	return
end

return MainBaseBtn
