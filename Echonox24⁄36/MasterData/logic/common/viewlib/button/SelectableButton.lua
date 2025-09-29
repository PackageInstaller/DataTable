-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/button/SelectableButton.lua

module("logic.common.viewlib.button.SelectableButton", package.seeall)

local SelectableButton = class("SelectableButton")

function SelectableButton:ctor(mainGO, pathNormal, pathSelect)
	self.mainGO = mainGO

	self:buildUI(pathNormal, pathSelect)
end

function SelectableButton:destroy()
	self:destroyUI()

	self.mainGO = nil
end

function SelectableButton:buildUI(pathNormal, pathSelect)
	pathNormal = pathNormal or "imgNormal"
	pathSelect = pathSelect or "imgSelect"
	self._btnClick = Astral.UIClickTrigger.Get(self.mainGO)

	self._btnClick:AddClickListener(self._onClick, self)

	self._goNormal = goutil.findChild(self.mainGO, pathNormal)
	self._goSelect = goutil.findChild(self.mainGO, pathSelect)
	self._handler = Handler.New()
	self._isSelected = false
end

function SelectableButton:setSelected(isSelected)
	self._isSelected = isSelected

	self:_updateView()
end

function SelectableButton:addListener(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
end

function SelectableButton:removeListener()
	self._handler:clear()
end

function SelectableButton:destroyUI()
	if self._btnClick then
		self._btnClick:RemoveClickListener()

		self._btnClick = nil
	end

	self._handler:clear()

	self._handler = nil
	self._goNormal = nil
	self._goSelect = nil
end

function SelectableButton:_onClick()
	self:setSelected(not self._isSelected)
	self._handler:call(self._isSelected)
end

function SelectableButton:_updateView()
	goutil.setActive(self._goNormal, not self._isSelected)
	goutil.setActive(self._goSelect, self._isSelected)
end

return SelectableButton
