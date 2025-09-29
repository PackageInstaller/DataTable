-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/cell/CommLabel.lua

module("logic.extensions.common.cell.CommLabel", package.seeall)

local M = class("CommLabel", SimpleCellComponent)

M.SignType = {
	Sign1 = 1,
	SignTrial = 3,
	Sign2 = 2
}

function M:buildUI()
	local registry = self._registry

	self._goSign1 = registry:getGo("com_label_787295976")
	self._goSign2 = registry:getGo("com_label_1181881388")
	self._goSign3 = registry:getGo("com_label_-849213222")
	self._textLabel1 = registry:getText("com_label_-1513538352")
	self._textLabel2 = registry:getText("com_label_1979641530")
end

function M:_setData(signType, label)
	self._signType = signType
	self._label = label
end

function M:_refreshUI()
	local isSign1 = self._signType == M.SignType.Sign1
	local isSign2 = self._signType == M.SignType.Sign2
	local isSign3 = self._signType == M.SignType.SignTrial

	self._textLabel1.text = isSign1 and self._label or self._textLabel1.text
	self._textLabel2.text = isSign2 and self._label or self._textLabel2.text

	goutil.setActive(self._goSign1, isSign1)
	goutil.setActive(self._goSign2, isSign2)
	goutil.setActive(self._goSign3, isSign3)
end

return M
