local PlayRoomMainFilterBtn = class("PlayRoomMainFilterBtn", import("view.base.BasePanel"))

function PlayRoomMainFilterBtn:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	PlayRoomMainFilterBtn.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function PlayRoomMainFilterBtn:Init()
	return
end

function PlayRoomMainFilterBtn:didEnter(arg_3_1, arg_3_2)
	setText(self.uiText, arg_3_1.text)
	setText(self.uiText2, arg_3_1.text)
	onButton(self, self.uiBtn, function()
		arg_3_1.clickBtn()

		return
	end)
	setActive(self._go, true)

	self.data = arg_3_1

	return
end

function PlayRoomMainFilterBtn:willExit()
	self:detach()
	Object.Destroy(self._go)

	self._tf = nil
	self._go = nil

	return
end

function PlayRoomMainFilterBtn:RefreshUI()
	setActive(self.uiSelectTf, self.data.selected())
	setActive(self.uiUnSelectTf, not self.data.selected())

	return
end

return PlayRoomMainFilterBtn
