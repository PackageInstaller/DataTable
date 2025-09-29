-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/HoldingRoomChangeViewTitleCell.lua

module("logic.extensions.containmentzone.cell.HoldingRoomChangeViewTitleCell", package.seeall)

local M = class("HoldingRoomChangeViewTitleCell", UIReusableLuaBehavior)

function M:buildUI()
	self._goDi = goutil.findChild(self.mainGO, "imgDegreeDi").gameObject
	self._goIcon = goutil.findChild(self.mainGO, "imgDegree").gameObject
	self._imgClass = goutil.findChildImageComponent(self.mainGO, "imgDegree")
	self._imgDi = goutil.findChildImageComponent(self.mainGO, "imgDegreeDi")
	self._animation = self.mainGO:GetComponent(ComponentType.Animation)
end

function M:destroyUI()
	self._goDi = nil
	self._goIcon = nil
	self._imgClass = nil
	self._imgDi = nil
	self._animation = nil
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
	self._animation:Stop()
end

function M:setShow(show)
	goutil.setActive(self._goDi, show)
	goutil.setActive(self._goIcon, show)
end

function M:refreshSelect(selectProtomerId)
	return
end

function M:setIcon(degree)
	local cfg = ContainmentConfig.instance:getProtomerDegreeCoByDegreeId(degree)
	local icon = cfg.icon
	local iconDi = cfg.back

	IconLoader.setSprite(self._imgClass, IconType.DynSpriteAtlas_Room, icon)
	IconLoader.setSprite(self._imgDi, IconType.DynSpriteAtlas_Room, iconDi)
end

function M:playOpenAni()
	self._animation:Stop()
	self._animation:Play("holding_title_item")
end

function M:fixAni()
	self._imgDi.color = Color.New(0, 0, 0, 1)
	self._imgClass.fillAmount = 1
end

return M
