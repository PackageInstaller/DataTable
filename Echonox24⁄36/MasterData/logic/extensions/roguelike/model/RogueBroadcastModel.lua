-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/model/RogueBroadcastModel.lua

module("logic.extensions.roguelike.model.RogueBroadcastModel", package.seeall)

local RogueBroadcastMo = class("RogueBroadcastMo")

function RogueBroadcastMo:ctor()
	self.sourceId = 0
	self.isRole = false
	self.effectId = 0
	self.effectCount = 0
	self.hpChange = 0
	self.entryId = 0
	self.round = 0
	self.targetId = 0
end

function RogueBroadcastMo:initByData(data)
	self.sourceId = data.sourceId
	self.isRole = data.isRole
	self.effectId = data.effectId
	self.effectCount = data.effectCount
	self.hpChange = data.hpChange
	self.entryId = data.entryId
	self.round = data.round
	self.targetId = data.targetId
	self.pattern = data.pattern
	self.diceCount = data.diceCount
end

local M = class("RogueBroadcastModel")

function M:ctor()
	self._moList = {}
	self._sourceId = 0
end

function M:clearList()
	self._moList = {}
	self._sourceId = 0
end

function M:setRound(round)
	self._round = round
end

function M:setCurSourceId(sourceId, isRole)
	self._sourceId = sourceId
	self._isRole = isRole
end

function M:addMo(mo, round)
	round = round or 1
	self._moList[round] = self._moList[round] or {}

	table.insert(self._moList[round], mo)
end

function M:addMoByHpChange(hpChange, sourceId, targetId, isRole)
	if hpChange == 0 then
		return
	end

	local mo = {}

	mo.sourceId = sourceId
	mo.targetId = targetId
	mo.isRole = isRole
	mo.round = self._round
	mo.hpChange = hpChange

	self:addMo(mo, self._round)
end

function M:addMoByRoleHpChange(roleId, hpChange)
	if self._round then
		local mo = {}

		mo.sourceId = self._curSourceId
		mo.targetId = roleId
		mo.isRole = true
		mo.round = self._curIsRole and self._round or self._round - 1
		mo.hpChange = hpChange

		self:addMo(mo, mo.round)
	end
end

function M:addMoByDiceResult(playerDices, roleId, actionCo)
	local result = {}

	for k, v in pairs(playerDices) do
		local pattern = v:getUpPattern()

		if pattern ~= RoguelikeConst.DICE_PATTERN.WHITE then
			result[pattern] = result[pattern] or 0
			result[pattern] = result[pattern] + 1
		end
	end

	local firstData
	local iconType, icon = self:getTargetHeadIcon(actionCo)

	for k, v in pairs(result) do
		local mo = {}

		mo.sourceId = roleId
		mo.isRole = true
		mo.round = self._round
		mo.pattern = k
		mo.diceCount = v
		mo.icon = icon
		mo.iconType = iconType

		if firstData == nil then
			firstData = mo
		end
	end

	if firstData == nil then
		local mo = {}

		mo.sourceId = roleId
		mo.isRole = true
		mo.round = self._round
		mo.icon = icon
		mo.iconType = iconType
		mo.pattern = actionCo.attr
		mo.diceCount = 0
		firstData = mo
	end

	self._curSourceId = firstData.sourceId
	self._curIsRole = firstData.isRole

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ADD_BROADCAST_HEAD, firstData)
end

function M:getTargetHeadIcon(actionCo)
	local iconType = IconType.RoleCard
	local icon

	if actionCo.showHead == 1 then
		local roleMos = RogueMgr.instance:getModel():getAllRoleMos()
		local characterCO = CharacterConfig.instance:getCfgInfoByID(roleMos[1].roleProp:getRoleId())

		if characterCO then
			local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

			icon = modelCO.halfIconName
		end

		return iconType, icon
	elseif actionCo.showHead == 2 then
		iconType = IconType.RunGroup

		local monsterProp = RogueMgr.instance:getModel():getCurMonster().monsterProp
		local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(monsterProp:getId())

		icon = string.format("rungroup_monster_head/%s", monsterCo.staticRes)

		return iconType, icon
	elseif actionCo.showHead == 3 then
		local roleMos = RogueMgr.instance:getModel():getAllRoleMos()
		local index = RogueMgr.instance:getModel():getCurRoleIndex()

		for k1, v1 in pairs(roleMos) do
			if index < k1 and not v1.roleProp:getIsDeath() then
				local characterCO = CharacterConfig.instance:getCfgInfoByID(v1.roleProp:getRoleId())

				if characterCO then
					local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

					icon = modelCO.halfIconName
				end

				return iconType, icon
			end
		end

		for k1, v1 in pairs(roleMos) do
			if index ~= k1 and not v1.roleProp:getIsDeath() then
				local characterCO = CharacterConfig.instance:getCfgInfoByID(v1.roleProp:getRoleId())

				if characterCO then
					local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

					icon = modelCO.halfIconName
				end

				return iconType, icon
			end
		end
	end

	return iconType, icon
end

function M:getNextRoleId()
	local roleMos = RogueMgr.instance:getModel():getAllRoleMos()
	local index = RogueMgr.instance:getModel():getCurRoleIndex()

	for k1, v1 in pairs(roleMos) do
		if index < k1 and not v1.roleProp:getIsDeath() then
			return v1.roleProp:getRoleId()
		end
	end

	for k1, v1 in pairs(roleMos) do
		if index ~= k1 and not v1.roleProp:getIsDeath() then
			return v1.roleProp:getRoleId()
		end
	end
end

function M:addMoByMonsterAttack(monsterId)
	local mo = {}

	mo.sourceId = monsterId
	mo.isRole = false
	mo.round = self._round

	local judgeMgr = RogueMgr.instance:getRogueFlow().judgeMgr

	mo.pattern = judgeMgr:getCombatDiceFeatures()
	mo.diceCount = 1

	local actionId = RogueMgr.instance:getRogueFlow().judgeMgr:getMonsterActionId()
	local actionCo = RoguelikeConfig.instance:getMonsterActionById(actionId)
	local iconType, icon = self:getTargetHeadIcon(actionCo)

	mo.icon = icon
	mo.iconType = iconType

	self:addMo(mo, self._round)

	self._curSourceId = mo.sourceId
	self._curIsRole = mo.isRole

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ADD_BROADCAST_HEAD, mo)
end

function M:addMoByDefence(defenceCount, sourceId, targetId)
	local mo = {}

	mo.sourceId = sourceId
	mo.targetId = targetId
	mo.isRole = true
	mo.round = self._round
	mo.defenceCount = defenceCount

	self:addMo(mo, self._round)
end

function M:addMoByEntry(entryId, count, roleId)
	local mo = {}

	mo.sourceId = self._sourceId
	mo.isRole = self._isRole
	mo.round = self._round
	mo.entryId = entryId
	mo.entryCount = count

	local actionCo = {
		showHead = 3
	}
	local iconType, icon = self:getTargetHeadIcon(actionCo)

	mo.icon = icon
	mo.iconType = iconType

	if roleId == nil then
		mo.targetId = self:getNextRoleId()
	else
		mo.targetId = roleId
	end

	mo.sourceId = RogueMgr.instance:getModel():getCurRoleMo():getRoleId()

	self:addMo(mo, self._round)
end

function M:getMoBySourceIdAndRound(sourceId, round)
	local result = {}

	for k, v in pairs(self._moList[round] or {}) do
		if v.sourceId == sourceId then
			table.insert(result, v)
		end
	end

	return result
end

M.instance = M.New()

return M
