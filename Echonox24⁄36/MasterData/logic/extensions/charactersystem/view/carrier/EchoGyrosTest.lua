-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/EchoGyrosTest.lua

module("logic.extensions.charactersystem.view.carrier.EchoGyrosTest", package.seeall)

local M = class("EchoGyrosTest", ViewComponent)

function M:buildUI()
	self._slider = UIComponentType.SliderAdapter(goutil.findChild(self.mainGO, "slider"))
	self._btnClose = self:getBtn("echo_gyros_test_-1919488534")
	self._simulatePos = Vector3.New(0, 0, 0)
end

function M:destroyUI()
	self._slider = nil
	self._btnClose = nil
end

function M:bindEvents()
	self._slider:AddOnValueChanged(self._onSliderChange, self)
	self._btnClose:AddClickListener(self._onClose, self)
end

function M:unbindEvents()
	self._slider:RemoveOnValueChanged()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self._gyrosObj = self:getFirstParam()
end

function M:onExit()
	self._gyrosObj:stopSimulate()

	self._gyrosObj = false
end

function M:_onSliderChange(sliderValue)
	sliderValue = (sliderValue - 0.5) * 2
	self._simulatePos.x = sliderValue

	local simulateData = {}

	simulateData.isSimulate = true
	simulateData.simulatePos = self._simulatePos

	self._gyrosObj:startSimulate(simulateData)
end

function M:_onClose()
	ViewMgr.instance:close(ViewName.EchoGyrosTest)
end

return M
