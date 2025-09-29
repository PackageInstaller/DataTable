-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompModelMountFollow.lua

module("logic.battle.unit.comp.BattleUnitCompModelMountFollow", package.seeall)

local M = class("BattleUnitCompModelMountFollow", BattleUnitCompBase)
local vec3Temp1 = Vector3.New()

function M:onInit()
	self._dictMountGO = {}
	self._dictFollowGOs = {}

	self:_setEvents(true)
end

function M:onReuse()
	self:_setEvents(true)
end

function M:onReset()
	self:_setEvents(false)
	BattleTableUtil.clearTable(self._dictMountGO)
	BattleTableUtil.clearTable(self._dictFollowGOs)
end

function M:onDestroy()
	self:onReset()

	self._dictMountGO = nil
	self._dictFollowGOs = nil
end

function M:_setEvents(isOn)
	if isOn then
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	end
end

function M:addFollowGO(mountName, followGO, offsetX, offsetY, offsetZ)
	if self._dictFollowGOs[mountName] == nil then
		self._dictFollowGOs[mountName] = {}
	end

	local data = {}

	data.offsetX = offsetX or 0
	data.offsetY = offsetY or 0
	data.offsetZ = offsetZ or 0
	self._dictFollowGOs[mountName][followGO] = data
end

function M:removeFollowGO(mountName, followGO)
	if self._dictFollowGOs[mountName] then
		self._dictFollowGOs[mountName][followGO] = nil
	end
end

function M:update()
	if self._dictFollowGOs then
		for mountName, GOs in pairs(self._dictFollowGOs) do
			local mountGO = self._dictMountGO[mountName]

			if not goutil.isNil(mountGO) then
				for followGO, data in pairs(GOs) do
					if not goutil.isNil(followGO) then
						GameObjectUtils.SynchronizeGameObject(mountGO, followGO, data.offsetX, data.offsetY, data.offsetZ)
					end
				end
			end
		end
	end
end

function M:_onMeshModelLoaded()
	BattleTableUtil.clearTable(self._dictMountGO)

	local goInst = self._unit.meshModel:getInst()

	if goInst then
		for _, mountName in pairs(MeshModelMount) do
			self._dictMountGO[mountName] = goutil.findChild(goInst, mountName)
		end
	end
end

return M
