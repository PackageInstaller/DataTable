-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\BattleTrapManager.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local ResBattleTrap = require("ClientData/ResBattleTrap")
local strClassName = "BattleTrapManager"
local BattleTrapManager = Class(strClassName)

function BattleTrapManager:ctor(mgr, traps)
	self.mgr = mgr
	self.traps = {}

	self:initTrap(traps)

	self.trapStateCache = {}
end

function BattleTrapManager:initTrap(traps)
	for index = 0, BattleConst.BATTLE_MAX_TRAP_INIT_NUM do
		local trapId = traps[index * 2 + 1]
		local trapPos = traps[index * 2 + 2]

		if trapId and trapPos then
			self:addTrap(trapId, trapPos)
		else
			break
		end
	end
end

function BattleTrapManager:addTrap(trapId, trapPos)
	if ResBattleTrap[trapId] then
		local isMonster = false

		if trapPos < 0 then
			trapPos = -trapPos
			isMonster = true
		end

		local coordX, coordY = self.mgr:getCoordByPos(trapPos, isMonster)

		if coordX then
			if not self.traps[coordY] then
				self.traps[coordY] = {}
			end

			if not self.traps[coordY][coordX] then
				self.traps[coordY][coordX] = {}
			end

			table.insert(self.traps[coordY][coordX], ResBattleTrap[trapId])
			self.mgr:addOutput(BattleConst.MATRIX_EVENT_ADD_TRAP, nil, {
				trapId,
				coordX,
				coordY
			})
		end
	end
end

function BattleTrapManager:toRealCoord(target, coordX, coordY)
	if self.trapStateCache[target] then
		self.mgr:delGlobalState(self.trapStateCache[target], target)

		self.trapStateCache[target] = nil
	end

	if self.traps[coordY] and self.traps[coordY][coordX] then
		for index = #self.traps[coordY][coordX], 1, -1 do
			local trapInfo = self.traps[coordY][coordX][index]

			if trapInfo.trap_type == 1 then
				table.remove(self.traps[coordY][coordX], index)

				if #self.traps[coordY][coordX] == 0 then
					self.traps[coordY][coordX] = nil

					if next(self.traps[coordY]) == nil then
						self.traps[coordY] = nil
					end
				end

				self.mgr:addOutput(BattleConst.MATRIX_EVENT_DEL_TRAP, nil, {
					trapInfo.id,
					coordX,
					coordY
				})
			end

			if trapInfo.event_id then
				self.mgr:triggerGlobalEvent(trapInfo.event_id, target)
			end

			if trapInfo.state_id then
				self.mgr:addGlobalState(trapInfo.state_id, target)

				self.trapStateCache[target] = trapInfo.state_id
			end
		end
	end
end

return BattleTrapManager
