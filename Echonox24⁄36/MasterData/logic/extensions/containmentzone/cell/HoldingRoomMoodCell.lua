-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/HoldingRoomMoodCell.lua

module("logic.extensions.containmentzone.cell.HoldingRoomMoodCell", package.seeall)

local M = class("HoldingRoomMoodCell", UIReusableLuaBehavior)

function M:buildUI()
	self._imgFill = goutil.findChildImageComponent(self.mainGO, "fill")
end

function M:destroyUI()
	self._imgFill = nil
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

function M:setImgFill(fillAmount)
	self._imgFill.fillAmount = fillAmount
end

function M:setShow(show)
	goutil.setActive(self.mainGO, show)
end

return M
