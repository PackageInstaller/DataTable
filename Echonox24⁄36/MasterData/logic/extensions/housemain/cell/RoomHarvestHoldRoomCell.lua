-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/cell/RoomHarvestHoldRoomCell.lua

module("logic.extensions.housemain.cell.RoomHarvestHoldRoomCell", package.seeall)

local M = class("RoomHarvestHoldRoomCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:buildUI()
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "icon")
	self._imgProcess = goutil.findChildImageComponent(self.mainGO, "fillDi/fill")
	self._txtPointAdd = goutil.findChildTextComponent(self.mainGO, "txtNum")
	self._goMarkCanUpgrade = goutil.findChild(self.mainGO, "sign/canUpgrade")
	self._goMarkNewInfo = goutil.findChild(self.mainGO, "sign/newInformation")
	self._txtReportNum = goutil.findChildTextComponent(self.mainGO, "txtSettlementTime")
end

function M:destroyUI()
	self.mainGO = nil
	self._imgIcon = nil
	self._imgProcess = nil
	self._txtPointAdd = nil
	self._goMarkCanUpgrade = nil
	self._goMarkNewInfo = nil
	self._txtReportNum = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setData(predictInfo)
	local cfgRoomId = predictInfo.cfgRoomId

	self:setIcon(predictInfo.protomerId)
	self:updateProcess(predictInfo)
	self:updateReportNum(predictInfo.reportNum)

	self._txtPointAdd.text = string.format("+%d", predictInfo.addPoint)

	goutil.setActive(self._goMarkCanUpgrade, predictInfo.canUpgradeModule)
	goutil.setActive(self._goMarkNewInfo, predictInfo.unLockIntelligence and #predictInfo.unLockIntelligence > 0)
end

function M:setIcon(protomerId)
	ContainmentUtil.setProtomerDynIcon(self._imgIcon, protomerId, true)
end

function M:updateProcess(predictInfo)
	local process = 1

	if predictInfo.pointMax > 0 then
		process = predictInfo.pointNow / predictInfo.pointMax
	end

	self._imgProcess.fillAmount = process
end

function M:updateReportNum(num)
	self._txtReportNum.text = string.format("x%d", num or 1)
end

return M
