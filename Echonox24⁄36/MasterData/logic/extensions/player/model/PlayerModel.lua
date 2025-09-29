-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/player/model/PlayerModel.lua

module("logic.extensions.player.model.PlayerModel", package.seeall)

local M = class("PlayerModel", BaseModel)

function M:ctor()
	self._playerInfo = {}
	self._playerInfo.id = "0"
	self._playerInfo.nickName = ""
	self._playerInfo.exp = 0
	self._playerInfo.level = 1
	self._allDungenonMo = false
	self._playerInfo.prologueFinished = false
	self._prefaceDungeons = {}
	self._prefaceDungeonIndex = 0
	self._playerInfo.registerTime = 0
	self._playerInfo.loginTime = 0
	self._playerInfo.lastLogoutTime = 0
	self._playerInfo.prologueChangeNameFinished = false
	self._playerInfo.energyLimit = 0
	self._playerInfo.backpackLimits = false
	self._playerInfo.createPlayerFinished = false
	self._playerInfo.isInitialized = false
end

function M:onInit()
	local defaultUserId = "0"
	local appKey = "028bf095-c6f7-4429-8186-5a8ef24f4464"

	CrashSightAgent.InitForPC(appKey, defaultUserId)
end

function M:onReset()
	self._playerInfo.isInitialized = false
	self._allDungenonMo = false
	self._prefaceDungeonIndex = 0
	self._realNameInfo = false
end

function M:getId()
	if not self._playerInfo then
		return 0
	end

	return self._playerInfo.id
end

function M:setNickName(nickName)
	self._playerInfo.nickName = nickName
end

function M:getNickName()
	return self._playerInfo.nickName
end

function M:setLevel(level)
	self._playerInfo.level = level
end

function M:getLevel()
	return self._playerInfo.level
end

function M:getLevelDesc()
	return StringUtil.convertLevel(self._playerInfo.level)
end

function M:getExp()
	return self._playerInfo.exp
end

function M:getMaxExp()
	return PlayerConfig.instance:getExpByLevel(self._playerInfo.level)
end

function M:setPrologueState(id)
	table.removebyvalue(self._prefaceDungeons, id)
end

function M:getPrologueStages()
	return self._prefaceDungeons
end

function M:getPrologueStageId()
	local len = #self._prefaceDungeons

	self._prefaceDungeonIndex = self._prefaceDungeonIndex + 1

	if len >= self._prefaceDungeonIndex then
		return self._prefaceDungeons[self._prefaceDungeonIndex]
	end

	return false
end

function M:setPrologueFinished(prologueFinished)
	self._playerInfo.prologueFinished = prologueFinished
end

function M:getPrologueFinished()
	return self._playerInfo.prologueFinished
end

function M:setPrologueChangeNameFinished(isFinish)
	self._playerInfo.prologueChangeNameFinished = isFinish
end

function M:getPrologueChangeNameFinished()
	return self._playerInfo.prologueChangeNameFinished
end

function M:getPrologueDungeonMO()
	return self._allDungenonMo or {}
end

function M:getRegisterTime()
	return self._playerInfo.registerTime
end

function M:getLoginTime()
	return self._playerInfo.loginTime
end

function M:getLastLogoutTime()
	return self._playerInfo.lastLogoutTime
end

function M:getLoginTimeDataStr()
	return TimeUtil.instance:stampToDateStr(self._playerInfo.loginTime)
end

function M:getLastLogoutTimeDataStr()
	return TimeUtil.instance:stampToDateStr(self._playerInfo.lastLogoutTime)
end

function M:isInitialized()
	return self._playerInfo.isInitialized
end

function M:getEnergyLimit()
	return self._playerInfo.energyLimit
end

function M:getBackpackLimit(itemType, constKey)
	for i = 1, #self._playerInfo.backpackLimits do
		local limitMo = self._playerInfo.backpackLimits[i]

		if itemType == limitMo.itemType then
			return limitMo.limit
		end
	end

	if itemType == GameEnum.ItemTypeEnum.EquipItemType or itemType == GameEnum.ItemTypeEnum.DiceItem then
		return EquipmentConfig.instance:getConstNum(constKey)
	end

	return ConstConfig.instance:getNumValueByKey(constKey)
end

function M:updatePlayerInfo(loadPlayerReply)
	local playerInfo = loadPlayerReply.playerInfo

	self._playerInfo.id = playerInfo.id
	self._playerInfo.nickName = playerInfo.userName
	self._playerInfo.level = playerInfo.lv
	self._playerInfo.exp = playerInfo.exp

	self:updatePrefaceDungeons(playerInfo.prologueDungeons)

	self._playerInfo.prologueFinished = playerInfo.prologueFinished
	self._playerInfo.registerTime = playerInfo.registerTime
	self._playerInfo.loginTime = playerInfo.loginTime
	self._playerInfo.lastLogoutTime = playerInfo.lastLogoutTime
	self._playerInfo.prologueChangeNameFinished = playerInfo.prologueChangeNameFinished
	self._playerInfo.energyLimit = playerInfo.energyLimit
	self._playerInfo.createPlayerFinished = playerInfo.createPlayerFinished
	self._playerInfo.isInitialized = true
	self._playerInfo.backpackLimits = {}

	for i = 1, #playerInfo.backpackLimit do
		local limitMo = playerInfo.backpackLimit[i]

		table.insert(self._playerInfo.backpackLimits, limitMo)
	end

	CrashSightAgent.SetUserId(self._playerInfo.id)
end

function M:updatePrefaceDungeons(finishDungeons)
	self._prefaceDungeons = {}

	local len = #finishDungeons

	if not self._allDungenonMo then
		self._allDungenonMo = {}

		local allDungeonIds = ConstConfig.instance:getNumValuesByKey(ConstConfigKeyEnum.PrologueDungeons)

		for i = 1, #allDungeonIds do
			table.insert(self._allDungenonMo, {
				finish = false,
				id = allDungeonIds[i]
			})
		end
	end

	for i = 1, #self._allDungenonMo do
		for j = 1, len do
			if self._allDungenonMo[i].id == finishDungeons[j] then
				self._allDungenonMo[i].finish = true
			end
		end
	end

	for i = 1, #self._allDungenonMo do
		if not self._allDungenonMo[i].finish then
			table.insert(self._prefaceDungeons, self._allDungenonMo[i].id)
		end
	end
end

function M:updatePlayerLevelInfo(playerLevelInfoReply)
	local playerLevelInfo = playerLevelInfoReply.playerLevelInfo
	local preLevel = self._playerInfo.level

	if preLevel < playerLevelInfo.lv then
		local info = {
			preEnergy = ItemModel.instance:getItemCountByItemId(CommEnum.CurrencyCodeEnum.TlCode),
			preLevel = preLevel,
			preExp = self._playerInfo.exp,
			currentLevel = playerLevelInfo.lv,
			currentExp = playerLevelInfo.exp
		}

		GlobalDispatcher:dispatchEvent(EventType.PLAYER_LEVEL_UP, info)

		local zoneId = BootstrapGameConfigMgr.getZoneId()
		local roleId = PlayerModel.instance:getId()
		local roleName = PlayerModel.instance:getNickName()
		local roleLevel = PlayerModel.instance:getLevel()
		local serverName = LoginModel.instance:getServerName()
		local roleCTime = PlayerModel.instance:getRegisterTime()
		local loginTime = PlayerModel.instance:getLoginTimeDataStr()
		local lastLogoutTime = PlayerModel.instance:getLastLogoutTimeDataStr()

		SDKGameRoleInfo.roleId = roleId
		SDKGameRoleInfo.roleName = roleName
		SDKGameRoleInfo.roleLevel = playerLevelInfo.lv
		SDKGameRoleInfo.serverId = tostring(zoneId)
		SDKGameRoleInfo.serverName = serverName
		SDKGameRoleInfo.roleCTime = tonumber(roleCTime)
		SDKGameRoleInfo.loginTime = loginTime
		SDKGameRoleInfo.lastLogoutTime = lastLogoutTime
		SDKGameRoleInfo.registerTime = roleCTime
		SDKGameRoleInfo.type = 3

		SDKManager.getSDKInstacne():upgradeRole(SDKGameRoleInfo)
	end

	self._playerInfo.level = playerLevelInfo.lv
	self._playerInfo.exp = playerLevelInfo.exp
end

function M:getCurExpPercent()
	return PlayerConfig.instance:calcLevelProgress(self._playerInfo.level, self._playerInfo.exp)
end

function M:updateRealNameInfo(realNameInfo)
	if self._realNameInfo and self._realNameInfo.realNameResult ~= realNameInfo.realNameResult then
		GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_REAL_NAME_STATE_CHANGE, realNameInfo.realNameResult)
	end

	self._realNameInfo = realNameInfo
end

function M:getRealNameInfo()
	return self._realNameInfo
end

function M:getIsVisitor()
	if self._realNameInfo then
		return self._realNameInfo.userType == GameEnum.RealNameUserTypeEnum.Visitor
	end

	return false
end

function M:hadRealNameAuthSuccess()
	if self._realNameInfo then
		return self._realNameInfo.realNameResult == GameEnum.RealNameStatusEnum.Success
	end

	return false
end

function M:isSpeakLimit()
	if self._realNameInfo then
		return self._realNameInfo.speakLimit
	end

	return false
end

function M:getOnlineLimitTime()
	if self._realNameInfo then
		return self._realNameInfo.onlineLimitTime
	end

	return nil
end

function M:setSixAttrOnCreate(sixConfigId)
	local config = PlayerConfig.instance:getAttrTemplateById(sixConfigId)
	local sixAttr = config.attributes

	for k, v in ipairs(sixAttr) do
		self._playerInfo.attribute = {}
		self._playerInfo.attribute[k] = v
	end
end

function M:setPlayerImage(image)
	self._playerInfo.image = image
end

function M:setPlayerCardInfo(playerCardInfo)
	self._playerCardInfo = playerCardInfo
end

function M:getPlayerCardInfo()
	return self._playerCardInfo
end

function M:getPlayerCardModelId()
	local manModelId = ConstConfig.instance:getNumValueByKey("DefaultManModelId")
	local womanModelId = ConstConfig.instance:getNumValueByKey("DefaultWoManModelId")
	local modelId = self._playerCardInfo.image == CommEnum.ImageEnum.Boy and manModelId or womanModelId

	return modelId
end

function M:setMyPlayerInfo(playerCardInfo)
	self._myPlayerInfo = playerCardInfo

	GlobalDispatcher:dispatchEvent(EventType.PLAYER_ATTRIBUTE_UPGRADE)
end

function M:getMyPlayerInfo()
	return self._myPlayerInfo
end

function M:getPersonalPath()
	return string.format("%s/user_%s", UnityEngine.Application.persistentDataPath, self._playerInfo.id)
end

function M:setIsCreatedPlayer(res)
	self._playerInfo.createPlayerFinished = res
end

function M:isCreatedPlayer()
	return self._playerInfo.createPlayerFinished
end

function M:getDefaultPortrait()
	local ids = ConstConfig.instance:getNumValuesByKey("DefaultPortrait")
	local i = self._playerCardInfo.image == CommEnum.ImageEnum.Boy and 2 or 1

	return ids[i]
end

function M:getPlayerRoleCode()
	return ConstConfig.instance:getNumValueByKey("PlayerRoleCode")
end

function M:getLocalStorageString(key)
	local key = string.format("%s#%s", key, self:getId())

	return Astral.LocalStorage.Instance:GetString(key, "")
end

function M:setLocalStorageString(key, value)
	if not key then
		return
	end

	local key = string.format("%s#%s", key, self:getId())

	Astral.LocalStorage.Instance:SetString(key, value)
end

function M:getLocalStorageInt(key, defaultValue)
	local key = string.format("%s#%s", key, self:getId())

	return Astral.LocalStorage.Instance:GetInt(key, defaultValue)
end

function M:setLocalStorageInt(key, value)
	if not key then
		return
	end

	local key = string.format("%s#%s", key, self:getId())

	Astral.LocalStorage.Instance:SetInt(key, value)
end

M.instance = M.New()

return M
