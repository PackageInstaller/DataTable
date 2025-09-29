-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/cell/RoomHarvestHoldRoomLstCell.lua

module("logic.extensions.housemain.cell.RoomHarvestHoldRoomLstCell", package.seeall)

local M = class("RoomHarvestHoldRoomLstCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:buildUI()
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._itemRoot = goutil.findChild(self.mainGO, "layout").gameObject
	self._itemPrefab = goutil.findChild(self.mainGO, "layout/holding_item").gameObject
end

function M:destroyUI()
	for _, value in pairs(self._cellItem or {}) do
		value:destroyUI()
	end

	self.mainGO = nil
	self._txtTitle = nil
	self._itemRoot = nil
	self._itemPrefab = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._cellItem = {}
end

function M:onExit()
	for _, value in pairs(self._cellItem or {}) do
		value:onExit()
	end

	self._holdRoomLst = nil
end

function M:getMainGo()
	return self.mainGO
end

function M:setTitle(contentStr)
	self._txtTitle.text = contentStr
end

function M:setData(holdRoomLst)
	self._holdRoomLst = holdRoomLst

	self:_updateHoldRoom()
end

function M:_updateHoldRoom()
	local rootTrans = self._itemRoot.transform
	local count = self._holdRoomLst and #self._holdRoomLst or 0

	while count > rootTrans.childCount do
		goutil.cloneAndSetParent(self._itemPrefab, rootTrans)
	end

	for i = 0, rootTrans.childCount - 1 do
		local show = i < count
		local tempGo = rootTrans:GetChild(i).gameObject

		if show then
			local curIndex = i + 1
			local itemData = self._holdRoomLst[curIndex]
			local className = RoomHarvestHoldRoomCell
			local shower = Astral.LuaComponentContainer.Get(tempGo, className)

			if shower == nil then
				shower = Astral.LuaComponentContainer.Add(tempGo, className)

				shower:buildUI()
				shower:bindEvents()
				shower:onEnter()
			end

			shower:setData(itemData)

			self._cellItem[tempGo:GetInstanceID()] = shower
		end

		goutil.setActive(tempGo, show)
	end
end

return M
