-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/model/LivingFacilitiesMouldMo.lua

module("logic.extensions.livingfacilities.model.LivingFacilitiesMouldMo", package.seeall)

local M = class("LivingFacilitiesMouldMo")

function M:ctor()
	self.id = false
	self._name = false
	self._icon = false
	self._typeList = false
	self._furnitureList = false
	self._isHashDirty = true
	self._hashCodeStr = nil
end

function M:initByCo(co)
	self.id = co.id
	self._name = co.name
	self._typeList = co.type or {}
	self._icon = co.icon
	self._furnitureList = {}

	local listString = co.list
	local listStringList = string.split(listString, "|")

	for i, furnitureString in ipairs(listStringList) do
		if not string.nilorempty(furnitureString) then
			local furnitureStringList = string.split(furnitureString, "#")
			local NO = {
				id = tonumber(furnitureStringList[1]),
				pos = {
					x = tonumber(furnitureStringList[2]),
					y = tonumber(furnitureStringList[3])
				},
				angle = tonumber(furnitureStringList[4])
			}
			local mo = HouseFurnitureMO.New()

			mo:setDataByAgent(NO)
			table.insert(self._furnitureList, mo)

			if not self:_checkMouldFurn(mo) then
				printWarn(string.format("<color=#FF0000>家具模板的适用设施类型配置错误，联系策划修改，模板id：%s，家具id：%s</color>", self.id, NO.id))
			end
		end
	end

	self._isHashDirty = true
end

function M:initByAgent(agent)
	self._name = agent.name
	self._furnitureList = {}

	for _, furniture in ipairs(agent.furnitures or {}) do
		local mo = HouseFurnitureMO.New()

		mo:setDataByAgent(furniture)
		table.insert(self._furnitureList, mo)
	end

	self._isHashDirty = true
end

function M:initByFurniture(name, furnitureList)
	self._name = name
	self._furnitureList = {}

	for _, furniture in ipairs(furnitureList or {}) do
		local NO = {
			id = furniture.furnitureId,
			pos = {
				x = furniture.coordX,
				y = furniture.coordY
			},
			angle = furniture.angle
		}
		local mo = HouseFurnitureMO.New()

		mo:setDataByAgent(NO)
		table.insert(self._furnitureList, mo)
	end

	self._isHashDirty = true
end

function M:getId()
	return self.id
end

function M:getName()
	return self._name
end

function M:getIcon()
	return self._icon
end

function M:matchType(type)
	if #self._typeList == 0 then
		return true
	elseif table.indexof(self._typeList, type) then
		return true
	end

	return false
end

function M:getFurnitureList()
	return self._furnitureList
end

function M:getCollectProgress()
	local tempList = self:getCollectList()
	local totalMyCount = 0
	local totalCount = 0

	for id, count in pairs(tempList) do
		local data = RoomFurnitureEditModel.instance:getEditData(id)
		local myNum = data and data:getCount() or 0

		totalMyCount = totalMyCount + math.min(myNum, count)
		totalCount = totalCount + count
	end

	return totalMyCount, totalCount
end

function M:getCollectList()
	local tempList = {}

	for i, furniture in ipairs(self._furnitureList) do
		local id = furniture:getId()

		tempList[id] = tempList[id] and tempList[id] + 1 or 1
	end

	return tempList
end

function M:getCollectCountList()
	local tempList = self:getCollectList()
	local furnitureList = {}

	for id, count in pairs(tempList) do
		local data = RoomFurnitureEditModel.instance:getEditData(id)
		local myNum = data and data:getCount() or 0
		local furniture = {
			id = id,
			count = count,
			myNum = myNum
		}

		table.insert(furnitureList, furniture)
	end

	return furnitureList
end

function M:getHashCodeStr()
	if self._isHashDirty == true or self._hashCodeStr == nil then
		self._hashCodeStr = self:_calculateHashCodeStr()
		self._isHashDirty = false
	end

	return self._hashCodeStr
end

function M:_calculateHashCodeStr()
	local code = 0

	local function _calculFunc(num)
		code = code * 31 + num
	end

	for _, mo in ipairs(self._furnitureList) do
		_calculFunc(mo:getFmodId())
		_calculFunc(mo:getCoordX())
		_calculFunc(mo:getCoordY())
		_calculFunc(mo:getAngle())
	end

	return string.format("%.0f", code)
end

function M:_checkMouldFurn(mo)
	local furnTypes = mo:getFitZoneTypes()

	if furnTypes == nil or #furnTypes == 0 then
		return true
	end

	if self._typeList == nil or #self._typeList == 0 then
		return true
	end

	for x, furnType in ipairs(furnTypes) do
		for y, mouldType in ipairs(self._typeList) do
			if furnType == mouldType then
				return true
			end
		end
	end

	return false
end

return M
