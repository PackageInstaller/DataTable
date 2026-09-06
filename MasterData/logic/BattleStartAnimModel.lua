-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlestartanim/model/BattleStartAnimModel.lua

module("logic.extensions.battlestartanim.model.BattleStartAnimModel", package.seeall)

local BattleStartAnimModel = class("BattleStartAnimModel", BaseModel)

BattleStartAnimModel.Lock = 1
BattleStartAnimModel.Unuse = 2
BattleStartAnimModel.Using = 3
BattleStartAnimModel.BtnText = {
	"获取途径",
	"使用",
	"使用中"
}

function BattleStartAnimModel:ctor()
	return
end

function BattleStartAnimModel:onInit()
	self:onReset()
end

function BattleStartAnimModel:onReset()
	self._propList = {}
	self._propDic = {}
	self._targetUserId = 0
	self._otherPropList = {}
end

function BattleStartAnimModel:_clearProp()
	self._propList = {}
	self._propDic = {}
end

function BattleStartAnimModel:onLoadAllUniquePropsRes(msg)
	local propList = GameUtil.pbToTable(msg.propList) or {}

	if #propList > 0 then
		self:_clearProp()

		for i, v in ipairs(propList) do
			self._propList[v.type] = self._propList[v.type] or {}
			self._propDic[v.type] = self._propDic[v.type] or {}

			table.insert(self._propList[v.type], v)

			self._propDic[v.type][v.id] = v
		end
	end
end

function BattleStartAnimModel:onUseUniquePropRes(msg)
	local list = self._propList[msg.type]

	if list then
		for i, v in ipairs(list) do
			if msg.type == v.type then
				v.isUse = msg.id == v.id
			end
		end
	end
end

function BattleStartAnimModel:onNotifyUniquePropChangeRes(msg)
	local changePropList = GameUtil.pbToTable(msg.propList) or {}
	local newList = {}

	for i1, v1 in ipairs(changePropList) do
		local isExist = false
		local list = self._propList[v1.type]

		if list then
			for i2, v2 in ipairs(list) do
				if v1.type == v2.type and v1.id == v2.id then
					v2.isUse = v1.isUse
					v2.overdueTime = v1.overdueTime
					isExist = true

					break
				end
			end
		end

		if not isExist then
			newList[v1.type] = newList[v1.type] or {}

			table.insert(newList[v1.type], v1)
		end
	end

	for type, v1 in pairs(newList) do
		for i2, v2 in ipairs(v1) do
			self._propList[type] = self._propList[type] or {}
			self._propDic[type] = self._propDic[type] or {}

			table.insert(self._propList[type], v2)

			self._propDic[type][v2.id] = v2
		end
	end
end

function BattleStartAnimModel:onGetOtherUniquePropsRes(msg)
	self._targetUserId = msg.targetUserId
	self._otherPropList = GameUtil.pbToTable(msg.propList) or {}
end

function BattleStartAnimModel:onUpdateSetTop(msg)
	local type = msg.type
	local id = msg.id
	local setTopMillis = msg.setTopMillis
	local list = self._propList[type]

	if list then
		for i, v in ipairs(list) do
			if v.type == type and v.id == id then
				v.setTopMillis = setTopMillis

				break
			end
		end
	end
end

function BattleStartAnimModel:getState(type, id)
	if self._propDic[type] and self._propDic[type][id] then
		local overdueTime = checknumber(self._propDic[type][id].overdueTime)
		local isAvailable = overdueTime == -1 or ServerTime.now() < overdueTime / 1000

		if isAvailable then
			return (self._propDic[type][id].isUse or nil) and (BattleStartAnimModel.Using or BattleStartAnimModel.Unuse)
		else
			return BattleStartAnimModel.Lock
		end
	end

	return BattleStartAnimModel.Lock
end

function BattleStartAnimModel:isWith(type, id)
	local state = BattleStartAnimModel.instance:getState(type, id)

	return state == BattleStartAnimModel.Unuse or state == BattleStartAnimModel.Using or false
end

function BattleStartAnimModel:getSetTopMillis(type, id)
	if self._propDic[type] and self._propDic[type][id] then
		return checknumber(self._propDic[type][id].setTopMillis)
	end

	return 0
end

function BattleStartAnimModel:getOtherState(type, id)
	for i, v in ipairs(self._otherPropList) do
		if v.type == type and v.id == id then
			return (v.isUse or nil) and (BattleStartAnimModel.Using or BattleStartAnimModel.Unuse)
		end
	end

	return BattleStartAnimModel.Lock
end

function BattleStartAnimModel:getOtherSetTopMillis(type, id)
	for i, v in ipairs(self._otherPropList) do
		if v.type == type and v.id == id then
			return checknumber(v.setTopMillis)
		end
	end

	return 0
end

function BattleStartAnimModel:getOtherMessageSkinId()
	for i, v in ipairs(self._otherPropList) do
		if v.type == MatType.PlayerMessageSkin then
			return v.id
		end
	end

	return BattleStartAnimModel.Lock
end

function BattleStartAnimModel:getUsingItemId(matType)
	local propList = self._propDic[matType]

	if propList then
		for k, v in pairs(propList) do
			if v.isUse then
				return v.id
			end
		end
	end

	return 0
end

function BattleStartAnimModel:getTimeTxt(type, id)
	if self._propDic[type] and self._propDic[type][id] then
		local overdueTime = checknumber(self._propDic[type][id].overdueTime)

		if overdueTime == -1 then
			return "永久"
		elseif ServerTime.now() < overdueTime / 1000 then
			local sec = overdueTime / 1000 - ServerTime.now()
			local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(sec)

			return string.format("%d天%d小时", day, hour)
		else
			return "已过期"
		end
	else
		return "已过期"
	end
end

BattleStartAnimModel.instance = BattleStartAnimModel.New()

return BattleStartAnimModel
