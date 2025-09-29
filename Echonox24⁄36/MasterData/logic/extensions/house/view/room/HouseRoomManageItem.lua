-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/room/HouseRoomManageItem.lua

module("logic.extensions.house.view.room.HouseRoomManageItem", package.seeall)

local M = class("HouseRoomManageItem")
local RoomOpenTyp = HouseMainEnum.RoomOpenTyp

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGO = self._compContainer.gameObject

	self:buildUI()
	self:bindEvents()

	self._roomId = nil
	self._clickCallBack = nil
	self._clickHandler = nil
end

function M:OnDestroy()
	self:unbindEvents()

	self._roomId = nil
	self._clickCallBack = nil
	self._clickHandler = nil
	self._uiClickSelf = nil
end

function M:buildUI()
	self._goRoot = goutil.findChild(self._mainGO, "pos")
	self._goSelectPos = goutil.findChild(self._mainGO, "selectPos")
	self._txtName = goutil.findChildTextComponent(self._goRoot, "txtName")
	self._txtLv = goutil.findChildTextComponent(self._goRoot, "txtLv")
	self._goSelected = goutil.findChild(self._goRoot, "select")
	self._goClick = goutil.findChild(self._goRoot, "click")
	self._uiClickSelf = Astral.UIClickTrigger.Get(self._goClick)
	self._goCanUpgrade = goutil.findChild(self._goRoot, "canUpgrade")
	self._goNotSet = goutil.findChild(self._goRoot, "notSet")
	self._goNotActive = goutil.findChild(self._goRoot, "notActive")
	self._goCanActive = goutil.findChild(self._goRoot, "canActive")
	self._goLock = goutil.findChild(self._goRoot, "lock")
	self._txtLock = goutil.findChildTextComponent(self._goLock, "txtCondition")
end

function M:bindEvents()
	self._uiClickSelf:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
	self._uiClickSelf:RemoveClickListener()
end

function M:setRoomId(roomId)
	self._roomId = roomId

	self:refreshView()
end

function M:refreshView()
	local openType = HouseMainRoomModel.instance:getRoomOpenTyp(self._roomId)

	if openType == RoomOpenTyp.UnOpen or openType == RoomOpenTyp.OpenLock then
		goutil.setActive(self._mainGO, false)
	else
		goutil.setActive(self._mainGO, true)

		local level = HouseMainUtil.getRoomLv(self._roomId)
		local lvStr = level > 0 and string.format("Lv.%s", level) or ""

		self._txtLv.text = lvStr
		self._txtName.text = HouseMainUtil.getRoomName(self._roomId)

		local nameColorStr = "#D1D1D1"

		goutil.setActive(self._goCanUpgrade, false)
		goutil.setActive(self._goNotSet, false)
		goutil.setActive(self._goNotActive, false)
		goutil.setActive(self._goCanActive, false)
		goutil.setActive(self._goLock, false)

		if openType == RoomOpenTyp.OpenLock then
			self._txtLv.text = ""

			goutil.setActive(self._goLock, true)
		elseif openType == RoomOpenTyp.OpenUnActive then
			self._txtLv.text = ""
			nameColorStr = "#9F9F9F"

			local canActive = HouseMainUtil.canRoomActive(self._roomId)

			if canActive then
				goutil.setActive(self._goCanActive, true)
			else
				goutil.setActive(self._goNotActive, true)
			end
		elseif openType == RoomOpenTyp.OpenActive then
			local isNotSetting = HouseMainUtil.isRoomNotSetting(self._roomId)
			local canUpgrade = HouseMainUtil.canRoomUpgradeLv(self._roomId)

			if isNotSetting then
				self._txtLv.text = ""

				goutil.setActive(self._goNotSet, true)
			elseif canUpgrade then
				goutil.setActive(self._goCanUpgrade, true)
			end
		end

		self._txtName.color = parsecolor(nameColorStr)

		local unlockLv = HouseConfig.instance:getRoomUnlockLv(self._roomId)

		self._txtLock.text = string.format(lang("tip_supervisor_unlock_lv"), unlockLv)
	end
end

function M:getRoomId()
	return self._roomId
end

function M:setSelected(selected)
	goutil.setActive(self._goSelected, selected)

	local posX, posY, posZ = 0, 0, 0

	if selected then
		posX, posY, posZ = Astral.TransformUtil.GetLocalPos(self._goSelectPos.transform, 0, 0, 0)
	end

	Astral.TransformUtil.SetLocalPos(self._goRoot.transform, posX, posY, posZ)
end

function M:setClickCallback(callback, handler)
	self._clickCallBack = callback
	self._clickHandler = handler
end

function M:_onClickSelf()
	local openType = HouseMainRoomModel.instance:getRoomOpenTyp(self._roomId)

	if (openType == RoomOpenTyp.OpenActive or openType == RoomOpenTyp.OpenUnActive) and self._clickCallBack then
		self._clickCallBack(self._clickHandler, self._roomId)
	end
end

return M
