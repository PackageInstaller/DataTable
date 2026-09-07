local PlayRoomMainFilterPanel = class("PlayRoomMainFilterPanel", import("view.base.BasePanel"))

function PlayRoomMainFilterPanel:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._go = arg_1_1.gameObject

	PlayRoomMainFilterPanel.super.Ctor(self, self._go)

	self._parentClass = arg_1_2
	self.data = arg_1_3

	self:attach(arg_1_2)
	self:Init()

	return
end

function PlayRoomMainFilterPanel:Init()
	self.btnItemList = {}

	return
end

function PlayRoomMainFilterPanel:didEnter(arg_3_1, arg_3_2)
	setText(self.uiTitleText, arg_3_1.titleText)

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.btnList) do
		self.btnItemList[iter_3_0] = PlayRoomMainFilterBtn.New(Object.Instantiate(self.uiTplBtn, self.uiTplPanel), self)

		self.btnItemList[iter_3_0]:didEnter(iter_3_1, arg_3_2)
	end

	setActive(self._go, arg_3_1.hide ~= true)

	return
end

function PlayRoomMainFilterPanel:willExit()
	self:detach()

	for iter_4_0, iter_4_1 in ipairs(self.btnItemList) do
		iter_4_1:willExit()
	end

	self.btnItemList = nil

	Object.Destroy(self._go)

	self._tf = nil
	self._go = nil

	return
end

function PlayRoomMainFilterPanel:RefreshUI()
	for iter_5_0, iter_5_1 in ipairs(self.btnItemList) do
		iter_5_1:RefreshUI()
	end

	return
end

return PlayRoomMainFilterPanel
