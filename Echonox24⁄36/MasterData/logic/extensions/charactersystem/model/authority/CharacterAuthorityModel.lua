-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/model/authority/CharacterAuthorityModel.lua

module("logic.extensions.charactersystem.model.authority.CharacterAuthorityModel", package.seeall)

local M = class("CharacterAuthorityModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._allHeroPowerInfos = {}
	self._allHeroPowerNodeMOs = {}
	self._heroPowerMapNodeMOs = {}
	self._heroUpgradeReports = {}
end

function M:onReset()
	M.super.ctor(self)

	self._unlockIndex = false
	self._isRunLineEffect = false
	self._isSend = false
	self._isRecieve = false
end

function M:updateHeroPowerInfo(heroId, nodesInfo, extNodesInfo)
	self._allHeroPowerInfos[heroId] = self._allHeroPowerInfos[heroId] or {}

	local allNodesInfo = {}

	nodesInfo = nodesInfo or {}
	extNodesInfo = extNodesInfo or {}

	for k, v in ipairs(nodesInfo) do
		table.insert(allNodesInfo, v)
	end

	local allExtNodesInfo = {}

	for k, v in ipairs(extNodesInfo) do
		table.insert(allExtNodesInfo, v)
	end

	self._allHeroPowerInfos[heroId].nodesInfo = allNodesInfo
	self._allHeroPowerInfos[heroId].extNodesInfo = allExtNodesInfo
end

function M:getNextBeUnlockIndex(heroId)
	self._allHeroPowerInfos[heroId] = self._allHeroPowerInfos[heroId] or {}

	if not self._allHeroPowerInfos[heroId].nodesInfo then
		return 1
	end

	local len = #self._allHeroPowerInfos[heroId].nodesInfo

	if len >= 20 then
		return 21, true
	end

	local normalPowerNode = HeroPowerConfig.instance:getCharacterNodes(heroId)

	for i = 1, #normalPowerNode do
		if self._allHeroPowerInfos[heroId].nodesInfo[len] == normalPowerNode[i] then
			if i < #normalPowerNode then
				return i + 1
			elseif i == #normalPowerNode then
				return 21, true
			end
		end
	end

	return 1
end

function M:getNextLevelUpIndex(heroId)
	self._allHeroPowerInfos[heroId] = self._allHeroPowerInfos[heroId] or {}

	if not self._allHeroPowerInfos[heroId].nodesInfo then
		return 1
	end

	local len = #self._allHeroPowerInfos[heroId].nodesInfo

	if len >= 20 then
		return 21
	end

	if len == 0 then
		return 1
	end

	local normalPowerNode = HeroPowerConfig.instance:getCharacterNodeInfos(heroId)

	for i = 1, #normalPowerNode do
		if self._allHeroPowerInfos[heroId].nodesInfo[len] < normalPowerNode[i].code and normalPowerNode[i].effect and normalPowerNode[i].effect[2] and normalPowerNode[i].effect[2] == 5 then
			if i < #normalPowerNode then
				return i
			elseif i == #normalPowerNode then
				return 21
			end
		end
	end

	return 1
end

function M:getAllNodeUnlockCount(heroId)
	self._allHeroPowerInfos[heroId] = self._allHeroPowerInfos[heroId] or {}

	local nodesInfo = self._allHeroPowerInfos[heroId].nodesInfo or {}
	local exNodesInfo = self._allHeroPowerInfos[heroId].extNodesInfo or {}

	return #nodesInfo + #exNodesInfo
end

function M:getIsNormalNodeAllUnlock(heroId)
	return #self._allHeroPowerInfos[heroId].nodesInfo >= 20
end

function M:getNodeIndex(nodeId)
	return math.fmod(nodeId, 25)
end

function M:addToNodes(nodesInfo, nodeId)
	local isContain = false

	for k, v in pairs(nodesInfo) do
		if v == nodeId then
			isContain = true
		end
	end

	if not isContain then
		table.insert(nodesInfo, nodeId)
	end
end

function M:getHeroPowerNodeInfos(heroId)
	if self._allHeroPowerInfos[heroId] then
		return self._allHeroPowerInfos[heroId].nodesInfo or {}
	else
		return {}
	end
end

function M:checkNodeIsUnlock(heroId, nodeId)
	if self._allHeroPowerInfos[heroId] then
		local normalNodes = self:getHeroPowerNodeInfos(heroId)
		local extNodes = self:getHeroPowerExtNodesInfo(heroId)

		for k, v in pairs(normalNodes) do
			if v == nodeId then
				return true
			end
		end

		for k, v in pairs(extNodes) do
			if v == nodeId then
				return true
			end
		end

		return false
	else
		return false
	end
end

function M:getHeroPowerExtNodesInfo(heroId)
	if self._allHeroPowerInfos[heroId] then
		return self._allHeroPowerInfos[heroId].extNodesInfo or {}
	else
		return {}
	end
end

function M:initHeroPowerNodesMO(heroId)
	if self._heroPowerMapNodeMOs[heroId] == nil then
		self._heroPowerMapNodeMOs[heroId] = {}
		self._allHeroPowerNodeMOs[heroId] = self._allHeroPowerNodeMOs[heroId] or {}

		local normalPowerNodes = HeroPowerConfig.instance:getCharacterNodes(heroId)
		local extraPowerNodes = HeroPowerConfig.instance:getCharacterExtNodes(heroId)
		local normalNodeMos = {}

		for k, nodeId in pairs(normalPowerNodes) do
			local co = HeroPowerConfig.instance:getNodeInfo(heroId, nodeId)
			local mo = HeroPowerNodeMo.New()

			mo:setConfig(co)
			mo:setHeroId(heroId)

			self._allHeroPowerNodeMOs[heroId][nodeId] = mo

			table.insert(normalNodeMos, mo)
		end

		self._heroPowerMapNodeMOs[heroId].normalNodes = normalNodeMos

		local extraNodeMos = {}

		for k, nodeId in pairs(extraPowerNodes) do
			local co = HeroPowerConfig.instance:getNodeInfo(heroId, nodeId)
			local mo = HeroPowerNodeMo.New()

			mo:setConfig(co)
			mo:setHeroId(heroId)

			self._allHeroPowerNodeMOs[heroId][nodeId] = mo

			table.insert(extraNodeMos, mo)
		end

		self._heroPowerMapNodeMOs[heroId].extraNodes = extraNodeMos
	end
end

function M:getHeroPowerNodeMO(heroId, nodeId)
	self._allHeroPowerNodeMOs[heroId] = self._allHeroPowerNodeMOs[heroId] or {}

	return self._allHeroPowerNodeMOs[heroId][nodeId]
end

function M:updateHeroRecord(heroId, records)
	self._heroUpgradeReports[heroId] = {}

	for k, v in ipairs(records) do
		local recordItem = {}

		recordItem.nodeId = v.nodeId
		recordItem.powerLv = CharacterExpConfig.instance:getPowerLvById(v.powerLv)
		recordItem.timestamp = v.timestamp

		table.insert(self._heroUpgradeReports[heroId], recordItem)
	end
end

function M:getHeroRecords(heroId)
	return self._heroUpgradeReports[heroId] or {}
end

function M:setUnLockNodeIndex(unLockIndex)
	self._unlockIndex = unLockIndex
end

function M:getUnLockNodeIndex(heroId)
	if self._unlockIndex then
		return self._unlockIndex
	end

	return 1
end

function M:setRunLineEffect(isRun)
	self._isRunLineEffect = isRun
end

function M:getRunLineEffect()
	return self._isRunLineEffect
end

function M:setPlayNodeEffectSend(isSend)
	self._isSend = isSend
end

function M:setPlayNodeEffectRecieve(isRecieve)
	self._isRecieve = isRecieve
end

function M:isPlayNodeEffect()
	return self._isSend and self._isRecieve
end

function M:getPowerNodeUnlockCache(heroId, nodeId)
	local heroPowerNodeMo = self:getHeroPowerNodeMO(heroId, nodeId)
	local skillId = heroPowerNodeMo:getSkillId() or 0
	local isAddSkill = false
	local preSkillEnhancedLst = {}

	if skillId > 0 then
		for _, data in ipairs(HeroPowerConfig.instance:getSkillAllEnhancedDataLst(heroId, skillId)) do
			if self:checkNodeIsUnlock(heroId, data.nodeId) then
				table.insert(preSkillEnhancedLst, data.enhancedCode)
			end
		end
	else
		skillId = heroPowerNodeMo:getAddSkillId()
		isAddSkill = true
	end

	local nodeActCache = {
		heroId = heroId,
		nodeId = nodeId,
		powerLvUpNum = heroPowerNodeMo:getPowerLevelUpNum() or 0,
		skillId = skillId,
		isAddSkill = isAddSkill,
		isUnlockSkill = heroPowerNodeMo:isUnlockSkill(),
		isEnhanceSkill = heroPowerNodeMo:isEnhanceSkill(),
		preSkillEnhancedLst = preSkillEnhancedLst,
		thisNodeSkillEnhancedCode = heroPowerNodeMo:getSkillEnhancedCode(),
		guideVideo = heroPowerNodeMo:getConfig().videoName
	}

	return nodeActCache
end

function M:checkRedPoint(heroId)
	local systemOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleAffinity, false)
	local configList = HeroPowerConfig.instance:getCharacterAllNodeInfos(heroId)
	local nextUnlockIndex, isAllNormalUnlock = CharacterAuthorityModel.instance:getNextBeUnlockIndex(heroId)
	local maxPowerLevel = HeroPowerConfig.instance:getMaxPowerGroupCount(heroId)
	local showTabFiveRedPoint = maxPowerLevel >= 5 and nextUnlockIndex > 20
	local hasRedDot = false

	for i = 1, #configList do
		local config = configList[i]
		local cost = config.cost
		local itemEnough = true
		local lzbEnough = true
		local tabIndex, tmp2 = math.modf(i / 5)

		if tmp2 ~= 0 then
			tabIndex = tabIndex + 1
		end

		if cost then
			for j = 1, #cost do
				local curNum = ItemModel.instance:getItemCountByItemId(cost[j].id)

				if curNum < cost[j].num then
					if cost[j].id == GameEnum.CurrencyCodeEnum.LzbCode then
						lzbEnough = false
					else
						itemEnough = false
					end
				end
			end
		end

		local isUnlock = self:checkNodeIsUnlock(heroId, config.code)
		local key = string.format("%s_%s", RedDotType.ERedDotKey.AFFINITY, tabIndex)

		if lzbEnough and itemEnough and not isUnlock then
			local isActive = systemOpen

			if tabIndex == 5 then
				isActive = systemOpen and showTabFiveRedPoint
			end

			if isActive then
				hasRedDot = true
			end

			GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
				key = key,
				isActive = isActive
			})

			for k = 1, 5 do
				if k ~= tabIndex then
					key = string.format("%s_%s", RedDotType.ERedDotKey.AFFINITY, k)

					GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
						isActive = false,
						key = key
					})
				end
			end

			break
		else
			GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
				isActive = false,
				key = key
			})
		end
	end

	return hasRedDot
end

function M:checkRedPointForBattle(heroIds)
	for i, heroId in ipairs(heroIds) do
		if self:checkRedPoint(heroId) then
			return heroId
		end
	end

	return false
end

function M:getHeroCanAffinityInLstForFailTips(heroIds)
	local tempList = BattleTableUtil.getTempList()
	local maxLess = 0
	local recommend = false

	if heroIds and #heroIds > 0 then
		for _, _heroId in ipairs(heroIds) do
			local allNodes = HeroPowerConfig.instance:getCharacterAllNodeInfos(_heroId)
			local unlockCount = CharacterAuthorityModel.instance:getAllNodeUnlockCount(_heroId)
			local less = #allNodes - unlockCount

			if unlockCount < 20 then
				recommend = true
			end

			if maxLess < less then
				table.clear(tempList)
				table.insert(tempList, _heroId)

				maxLess = less
			elseif less == maxLess then
				table.insert(tempList, _heroId)
			end
		end
	end

	local heroCode = BattleCalculateMgr.instance:findFirstHeroCodeByDefaultRules(tempList)

	BattleTableUtil.releaseTempList(tempList)

	return recommend, heroCode
end

function M:isEnhanceSkill(heroId, skillId)
	for _, enhanceData in ipairs(HeroPowerConfig.instance:getAllSkillEnhanceNodeLst(heroId, skillId) or {}) do
		local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(enhanceData.effectId)

		if skillEnhanceCOWrapper and not string.nilorempty(skillEnhanceCOWrapper:getDescription()) then
			return true
		end
	end

	return false
end

function M:isTagUnlock(heroId, tagType)
	local tagIdx = HeroPowerConfig.instance:getTagNodeByHeroId(heroId, tagType)
	local isUnlock = true

	if tagIdx then
		local data = HeroDepotModel.instance:getHeroInfoByID(heroId)

		if not data then
			return isUnlock
		end

		self:updateHeroPowerInfo(heroId, data:getNodesInfo(), data:getExtNodesInfo())

		isUnlock = self:checkNodeIsUnlock(heroId, tagIdx)
	end

	return isUnlock
end

M.instance = M.New()

return M
