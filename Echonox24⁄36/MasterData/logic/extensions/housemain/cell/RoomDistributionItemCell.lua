-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/cell/RoomDistributionItemCell.lua

module("logic.extensions.housemain.cell.RoomDistributionItemCell", package.seeall)

local M = class("RoomDistributionItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:buildUI()
	self._btnSelf = UIComponentType.ButtonAdapter(self.mainGO)
	self._goTypRootNormal = goutil.findChild(self.mainGO, "type1").gameObject
	self._txtRoomName = goutil.findChildTextComponent(self.mainGO, "type1/txtName")
	self._txtLv = goutil.findChildTextComponent(self.mainGO, "type1/txtLevel")
	self._txtHint = goutil.findChildTextComponent(self.mainGO, "type1/txtHint1")
	self._txtRoleNum = goutil.findChildTextComponent(self.mainGO, "type1/txtRoleNum")
	self._goRoleNumIcon = goutil.findChild(self.mainGO, "type1/txtRoleNum/Image1").gameObject
	self._goProcessRoot = goutil.findChild(self.mainGO, "type1/progress")
	self._goTypRootSuspend = goutil.findChild(self.mainGO, "type2")
	self._goTypRootSuspend = self._goTypRootSuspend and self._goTypRootSuspend.gameObject or nil
	self._goTypRootUnOpen = goutil.findChild(self.mainGO, "type3")
	self._goTypRootUnOpen = self._goTypRootUnOpen and self._goTypRootUnOpen.gameObject or nil
	self._goTyp4 = goutil.findChild(self.mainGO, "type4")
	self._goTyp4 = self._goTyp4 and self._goTyp4.gameObject or nil
	self._goTypeUnActive = goutil.findChild(self.mainGO, "type5")

	if self._goTypeUnActive then
		self._goTypeUnActive = self._goTypeUnActive.gameObject
		self._txtUnActiveName = goutil.findChildTextComponent(self.mainGO, "type5/txtName")
		self._txtUnActiveLv = goutil.findChildTextComponent(self.mainGO, "type5/txtLevel")
	end

	self._goTypeUnUse = goutil.findChild(self.mainGO, "type6")

	if self._goTypeUnUse then
		self._goTypeUnUse = self._goTypeUnUse.gameObject
		self._txtUnUseName = goutil.findChildTextComponent(self.mainGO, "type6/txtName")
		self._txtUnUseLv = goutil.findChildTextComponent(self.mainGO, "type6/txtLevel")
	end

	self._formGroup = {}

	local formRoot = goutil.findChild(self.mainGO, "form")

	if formRoot then
		self._formGroup[HouseEnum.LivingRoomType.Ecology] = goutil.findChild(formRoot, "shengtaikongjian")
		self._formGroup[HouseEnum.LivingRoomType.Dormitory] = goutil.findChild(formRoot, "sushe")
		self._formGroup[HouseEnum.LivingRoomType.Mystery] = goutil.findChild(formRoot, "shenmikongjian")
		self._formGroup[HouseEnum.LivingRoomType.Technology] = goutil.findChild(formRoot, "kejizhongxin")
		self._formGroup[HouseEnum.LivingRoomType.Entertainment] = goutil.findChild(formRoot, "yulezhongxin")
	end

	self:setFormSign(nil)

	self._goSignRoot = goutil.findChild(self.mainGO, "signPos/room_distribution_sign").gameObject

	self:onCellBindUI()
end

function M:onCellBindUI()
	return
end

function M:destroyUI()
	self.mainGO = nil
	self._btnSelf = nil
	self._goTypRootNormal = nil
	self._txtRoomName = nil
	self._txtLv = nil
	self._txtHint = nil
	self._txtRoleNum = nil
	self._goRoleNumIcon = nil
	self._goProcessRoot = nil
	self._goTypRootSuspend = nil
	self._goTypRootUnOpen = nil
	self._goTyp4 = nil
	self._goTypeUnActive = nil
	self._txtUnActiveName = nil
	self._txtUnActiveLv = nil
	self._goTypeUnUse = nil
	self._txtUnUseName = nil
	self._txtUnUseLv = nil
	self._formGroup = nil

	self:onCellDestroyUI()
end

function M:onCellDestroyUI()
	return
end

function M:bindEvents()
	self._btnSelf:AddClickListener(self._onClick, self)
	self:onCellBindEvents()
end

function M:onCellBindEvents()
	return
end

function M:unbindEvents()
	self._btnSelf:RemoveClickListener()
	self:onCellUnBindEvents()
end

function M:onCellUnBindEvents()
	return
end

function M:onEnter()
	self:onCellEnter()
end

function M:onCellEnter()
	return
end

function M:onExit()
	self._handler = nil
	self._roomId = nil
	self._roomTyp = nil
	self._roomOpenState = nil

	self:onCellExit()
end

function M:onCellExit()
	return
end

function M:_onClick()
	HouseDispatcher:dispatchEvent(HouseEventType.TRY_FOCUS_ROOM, self:getRoomId() or 0)
end

function M:onCellClick()
	return
end

function M:getRoomId()
	return self._roomId
end

function M:getRoomTyp()
	return self._roomTyp
end

function M:getRoomOpenState()
	return self._roomOpenState
end

function M:getRoomName()
	return HouseMainUtil.getRoomName(self._roomId)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:setData(roomZoneCo)
	self._roomId = roomZoneCo.id
	self._roomTyp = roomZoneCo.roomType

	self:reflashData()
end

function M:reflashData()
	local roomOpenTyp = HouseMainEnum.RoomOpenTyp

	self._roomOpenState = HouseMainRoomModel.instance:getRoomOpenTyp(self._roomId)

	local roomName = self:getRoomName()

	self._txtRoomName.text = roomName

	self:setText(self._txtUnActiveName, roomName)
	self:setText(self._txtUnUseName, roomName)

	local lvStr = HouseMainRoomModel.instance:getRoomLvHint(self._roomId, self._roomTyp, self._roomOpenState)

	self._txtLv.text = lvStr

	self:setText(self._txtUnActiveLv, lvStr)
	self:setText(self._txtUnUseLv, lvStr)

	self._txtRoleNum.text = HouseMainRoomModel.instance:getRoomRoleNumHint(self._roomId)

	local showRoleNumIcon = self._roomOpenState == roomOpenTyp.OpenActive

	showRoleNumIcon = showRoleNumIcon and HouseMainRoomModel.instance:getRoomRoleMaxNum(self._roomId) > 0

	goutil.setActive(self._goRoleNumIcon, showRoleNumIcon)
	goutil.setActive(self._txtRoleNum.gameObject, showRoleNumIcon)
	goutil.setActive(self._goTypRootUnOpen, self._roomOpenState == roomOpenTyp.UnOpen)
	goutil.setActive(self._goTypRootSuspend, self._roomOpenState == roomOpenTyp.OpenLock)
	goutil.setActive(self._goTypeUnActive, self._roomOpenState == roomOpenTyp.OpenUnActive)
	goutil.setActive(self._goTypRootNormal, self._roomOpenState == roomOpenTyp.OpenActive)
	goutil.setActive(self._goTyp4, false)
	goutil.setActive(self._goTypeUnUse, false)
	self:onCellSetData()
end

function M:onCellSetData(roomZoneCo)
	return
end

function M:setText(txt, str)
	if txt then
		txt.text = str
	end
end

function M:createSign(signMark, rootTyp)
	if not self._signGroup then
		self._signGroup = {}
	end

	local root = self._goSignRoot
	local obj = self._signGroup[signMark]

	if obj == nil then
		obj = goutil.findChild(root, HouseMainEnum.SignMarkObjName[signMark]).gameObject
	end

	if obj then
		self._signGroup[signMark] = obj

		goutil.setActive(obj.gameObject, true)
		goutil.setActive(root, true)
	end
end

function M:hideSign()
	local tr = self._goSignRoot.transform

	for i = 0, tr.childCount - 1 do
		goutil.setActive(tr:GetChild(i).gameObject, false)
	end
end

function M:setFormSign(livingRoomType)
	if livingRoomType == HouseEnum.LivingRoomType.PrivateDormitory or livingRoomType == HouseEnum.LivingRoomType.SpecialDormitory then
		livingRoomType = HouseEnum.LivingRoomType.Dormitory
	end

	if livingRoomType == HouseEnum.LivingRoomType.Life then
		livingRoomType = HouseEnum.LivingRoomType.Ecology
	end

	for lRoomTyp, go in pairs(self._formGroup or {}) do
		goutil.setActive(go, lRoomTyp == livingRoomType)
	end
end

function M:setProgress(active, progress)
	if active then
		local imgProgress = goutil.findChildImageComponent(self._goProcessRoot, "fill")

		imgProgress.fillAmount = progress / 100

		goutil.setActive(self._goProcessRoot, true)
	else
		goutil.setActive(self._goProcessRoot, false)
	end
end

return M
