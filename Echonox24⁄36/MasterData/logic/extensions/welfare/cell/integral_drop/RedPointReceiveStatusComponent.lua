-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/cell/integral_drop/RedPointReceiveStatusComponent.lua

module("logic.extensions.welfare.cell.integral_drop.RedPointReceiveStatusComponent", package.seeall)

local M = class("RedPointReceiveStatusComponent", ReceiveStatusComponent)

function M:onInit()
	M.super.onInit(self)

	local registry = self._cell:getViewElementsRegistry()
	local mainGo = registry:findUIElement("rewards_detail_item_2141037416")

	self._redPoint = goutil.findChild(mainGo, "red_point")
end

function M:setRewardStatus(status)
	goutil.setActive(self._canGetSignGo, false)
	goutil.setActive(self._hasGotSignGo, false)
	goutil.setActive(self._redPoint, false)

	if status == CommEnum.RewardEnum.HasGot then
		goutil.setActive(self._hasGotSignGo, true)
	elseif status == CommEnum.RewardEnum.CanGot then
		goutil.setActive(self._canGetSignGo, true)
		goutil.setActive(self._redPoint, true)
	end
end

return M
