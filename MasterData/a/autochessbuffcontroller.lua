local AutoChessBuff = require("AutoChessBuff")
local BuffHandlerBase = require("BuffHandlerBase")

---@class AutoChessBuffController
local AutoChessBuffController = class("AutoChessBuffController")

---@param owner AutoChessEntity
function AutoChessBuffController:ctor(owner)
	self.owner = owner
	---@type table<integer, AutoChessBuff> buff
	self.buffMap = {}
end


---@param buffInfo AutoChessBuffInfo
function AutoChessBuffController:AddBuff(buffInfo)
	if buffInfo == nil then
		return
	end
	local bufId = buffInfo.id
	local cfg = Config.GetAutoChessBuffTable(bufId, 1)
	if cfg == nil then
		return nil
	end
	local oldBuff = self.buffMap[bufId]
	if oldBuff ~= nil then
		oldBuff:OnRefresh()
		return oldBuff
	end
	local buff = AutoChessBuff:new(self.owner, buffInfo)
	self.buffMap[bufId] = buff
	buff:OnAdd()
	return buff
end

function AutoChessBuffController:RemoveBuff(buffId)
	local buff = self.buffMap[buffId]
	if buff == nil then
		return
	end
	buff:Remove()
	self.buffMap[buffId] = nil
end


---是否拥有某个buff
---@param buffId int
---@return boolean isHas 是否拥有buff
function AutoChessBuffController:HasBuff(buffId)
	return self.buffMap[buffId] ~= nil
end





---@param dt number
function AutoChessBuffController:Update(dt)
	for buffId, buff in pairs(self.buffMap) do
		---@cast buffId int
		---@cast buff AutoChessBuff
		buff:OnUpdate(dt)
		if buff.isRemoved then
			self.buffMap[buffId] = nil
		end
	end
end


---@param eventType AutoChessCombatEvent
function AutoChessBuffController:TakeEvent(eventType, ...)

    for buffId, buff in pairs(self.buffMap) do
		---@cast buff AutoChessBuff
        buff:TakeEvent(eventType, ...)
    end
end






return AutoChessBuffController
