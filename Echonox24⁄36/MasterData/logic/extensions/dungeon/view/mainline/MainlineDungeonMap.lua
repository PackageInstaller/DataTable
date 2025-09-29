-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/mainline/MainlineDungeonMap.lua

module("logic.extensions.dungeon.view.mainline.MainlineDungeonMap", package.seeall)

local M = class("MainlineDungeonMap")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject

	self:buildUI()
end

function M:buildUI()
	self._levelGoList = {}
	self._nameBarCellList = {}

	for i = 0, self.mainGO.transform.childCount - 1 do
		local tmpGo = self.mainGO.transform:GetChild(i).gameObject
		local index = self:getDungeonIndexByName(tmpGo.name, "level_item_")

		if index then
			self._levelGoList[index] = tmpGo
			self._nameBarCellList[index] = Astral.LuaComponentContainer.Add(tmpGo, MainlineDungeonCell)
		end
	end
end

function M:setVisible(status)
	goutil.setActive(self.mainGO, status)
end

function M:_refreshView(dungeonIds)
	local maxPosX = 0

	for index, levelGo in pairs(self._levelGoList) do
		self._nameBarCellList[index]:setDungeonId(dungeonIds[index], index)

		local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(dungeonIds[index])

		if dungeonMo and dungeonMo:getIsShowInScene() and maxPosX < self._levelGoList[index].transform.anchoredPosition.x then
			maxPosX = self._levelGoList[index].transform.anchoredPosition.x
		end
	end

	return maxPosX
end

function M:setDifficulty(difficulty)
	return
end

function M:getNodeByIndex(index)
	return self._nameBarCellList[index].mainGO
end

function M:destroyUI()
	for index, levelGo in pairs(self._levelGoList) do
		self._nameBarCellList[index]:clear()
	end
end

function M:clear()
	self:destroyUI()
	goutil.destroy(self.mainGO)
end

function M:getNodeInfoByIndex(index)
	return self._nameBarCellList[index] or false
end

function M:getNodeAnchoredPosX(index)
	if self._levelGoList[index] then
		return self._levelGoList[index].transform.anchoredPosition.x
	end
end

function M:setSelectedDungeon(dungeonId)
	for idx, cell in pairs(self._nameBarCellList) do
		cell:setSelected(dungeonId == cell:getDungeonId())
	end
end

function M:getDungeonIndexByName(name, splitStr)
	local stringParam = string.split(name, splitStr)

	stringParam = string.split(stringParam[2], "_")

	if #stringParam == 1 then
		return tonumber(stringParam[1])
	elseif #stringParam == 3 then
		return tonumber(stringParam[2]) * 100 + tonumber(stringParam[3])
	else
		printError("节点命名格式不对:", name)
	end

	return nil
end

return M
