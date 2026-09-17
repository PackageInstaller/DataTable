local this = class("playerStore", G_BaseStore)
this.event = {
  refreshBaseInfo = "refrshBase",
  refreshAttr = "refreshAttr",
  syncAttrInfoComplete = "syncAttrInfoComplete",
  syncActAttrInfoComplete = "syncActAttrInfoComplete",
  refreshMapInfo = "refreshMapInfo",
  refreshModAvatar = "refreshModAvatar",
  modAvatarLoadFinish = "modAvatarLoadFinish",
  refreshPlayerStatus = "playerStore_refreshPlayerStatus",
  refreshMountStatus = "refreshMountStatus",
  playerLevelUp = "playerLevelUp",
  playerExpUp = "playerExpUp",
  refreshHeroListAndToggleModuleShowState = "refreshHeroListAndToggleModuleShowState"
}
this:importPartialClass(require(L_R.store .. "player.playerState"))
this:importPartialClass(require(L_R.store .. "player.playerAction"))

function this:clear()
  this.super.clear(self)
  if self.staminaTimer then
    Timer.remove(self.staminaTimer)
    self.staminaTimer = nil
  end
  if self.infoLock then
    self.infoLock = nil
  end
  if self.cachedInfo then
    self.cachedInfo = nil
  end
end

function this:setPlayerName(name)
  self.data.baseInfo.playerName = name
end

function this:isPlayerLogin()
  return self.data.baseInfo.id ~= nil
end

function this:ResetExpUp(isBlock)
  self.expUpParam.isExpUpBlock = isBlock
  self.expUpParam.lastLv = self.data.baseInfo.lv
end

function this:tickInfoLock()
  if self.infoLock == nil then
    self.infoLock = true
    self.cachedLastExp = -1
  elseif self.cachedInfo then
    self.infoLock = nil
    self:refreshBaseInfo(self.cachedInfo)
    self.cachedInfo = nil
    self.cachedLastExp = -1
  end
end

function this:refreshBaseInfo(baseInfo)
  if self.infoLock and self.cachedInfo == nil then
    self.cachedLastExp = L_PlayerStore:getExp()
    self.cachedInfo = baseInfo
    return
  end
  local lastExp = self.cachedLastExp ~= nil and self.cachedLastExp >= 0 and self.cachedLastExp or L_PlayerStore:getExp()
  table.merge(self.data.baseInfo, baseInfo)
  if baseInfo.lv or baseInfo.exp then
    self:refreshExpUpParam(lastExp)
  end
  C_EntityManager.AVATAR_OBJ_MODEL_INDEX = L_GameUtil.getHeroModelConstId()
  self:call(self.event.refreshBaseInfo)
  if baseInfo.scene_showcase then
    L_SituationStore:sync_situationData(baseInfo.scene_showcase)
  end
end

function this:onExpUpMsgStart()
  self.expMsgOngoing = true
  self.expMsgQueued = false
  self.expMsgQueuedIsReplay = false
end

function this:onExpUpMsgEnd(didRequeue)
  if not self.expMsgOngoing then
    return
  end
  if didRequeue and self.expMsgOngoing then
    self.expMsgOngoing = false
    self.expMsgQueued = true
    self.expMsgQueuedIsReplay = true
    return
  end
  self.expMsgOngoing = false
  self.expMsgQueuedIsReplay = false
  if not math.isEmpty(self.totalExpParam.fromLv) then
    self.expUpParam = {
      curLv = self.totalExpParam.toLv,
      curExp = self.totalExpParam.toExp,
      lastLv = self.totalExpParam.fromLv,
      lastExp = self.totalExpParam.fromExp,
      isLevelUp = self.totalExpParam.isLevelUp
    }
    AzurWorld.FlymsgManager:Enqueue("playerExpUp_flyMsg", {})
    self.expMsgQueued = true
    self.expMsgQueuedIsReplay = false
  else
    self.expMsgQueued = false
    self.expMsgQueuedIsReplay = false
    self.expUpParam.lastLv = self.expUpParam.curLv
    self.expUpParam.lastExp = self.expUpParam.curExp
  end
  self.totalExpParam = {
    fromExp = 0,
    fromLv = 0,
    toExp = 0,
    toLv = 0,
    isLevelUp = false
  }
end

function this:refreshExpUpParam(lastExp)
  local lastLv = self.lastLv
  local curLv = self.data.baseInfo.lv
  local curExp = self.data.baseInfo.exp
  local maxLv = L_GameTpl:getPlayerLevelTpl():getMaxLevel()
  local wasAlreadyMax = not math.isEmpty(lastLv) and lastLv >= maxLv
  if math.isEmpty(lastLv) then
    self.lastLv = curLv
  else
    if lastLv < curLv then
      self:call(self.event.playerLevelUp, lastLv)
      for i = lastLv + 1, curLv do
        L_ReddotManager:markNew(L_ReddotManager.DotDef.LevelUnlockHomeContent, i)
      end
      L_GameUtil.LogClientADEvent("user_levelup", {level = curLv})
    elseif curLv == lastLv and lastExp ~= curExp then
      self:call(self.event.playerExpUp, lastExp)
    end
    self.lastLv = curLv
  end
  if math.isEmpty(self.expUpParam.lastLv) then
    self.expUpParam.lastLv = curLv
    self.expUpParam.lastExp = curExp
    self.expUpParam.curLv = curLv
    self.expUpParam.curExp = curExp
    return
  end
  if wasAlreadyMax and curLv >= maxLv then
    if not self.expMsgQueued and not self.expMsgOngoing then
      self.expUpParam.lastLv = curLv
      self.expUpParam.lastExp = curExp
      self.expUpParam.curLv = curLv
      self.expUpParam.curExp = curExp
      self.expUpParam.isLevelUp = false
    end
    return
  end
  if lastLv == curLv and lastExp == curExp then
    return
  end
  if self.expMsgOngoing then
    if math.isEmpty(self.totalExpParam.fromLv) then
      self.totalExpParam.fromExp = self.expUpParam.curExp
      self.totalExpParam.fromLv = self.expUpParam.curLv
    end
    self.totalExpParam.toExp = curExp
    self.totalExpParam.toLv = curLv
    self.totalExpParam.isLevelUp = self.totalExpParam.toLv ~= self.totalExpParam.fromLv
  elseif self.expMsgQueued then
    if self.expMsgQueuedIsReplay then
      if math.isEmpty(self.totalExpParam.fromLv) then
        self.totalExpParam.fromExp = self.expUpParam.curExp
        self.totalExpParam.fromLv = self.expUpParam.curLv
      end
      self.totalExpParam.toExp = curExp
      self.totalExpParam.toLv = curLv
      self.totalExpParam.isLevelUp = self.totalExpParam.toLv ~= self.totalExpParam.fromLv
    else
      self.expUpParam.curLv = curLv
      self.expUpParam.curExp = curExp
      self.expUpParam.isLevelUp = self.expUpParam.lastLv ~= self.expUpParam.curLv
    end
  else
    self.expUpParam.curLv = curLv
    self.expUpParam.curExp = curExp
    self.expUpParam.isLevelUp = self.expUpParam.lastLv ~= self.expUpParam.curLv
    AzurWorld.FlymsgManager:Enqueue("playerExpUp_flyMsg", {})
    self.expMsgQueued = true
    self.expMsgQueuedIsReplay = false
  end
end

function this:refreshModInfo(serverData)
  self.data.modAvatar = require(L_R.store .. "mod.data.modAvatar").new()
  self.data.modAvatar.sex = L_PlayerStore:getSex()
  self.data.modAvatar.height = serverData.height
  self.data.modAvatar.skinId = serverData.complexion
  if serverData.avatars then
    for i = 0, serverData.avatars.Count - 1 do
      local avatarType = serverData.avatars[i].avatarType
      local avatarUrl = serverData.avatars[i].avatarUrl
      if avatarType == L_Const.screenShotType.hearHeadImg then
        self.data.modAvatar.headImgUrl = avatarUrl
      elseif avatarType == L_Const.screenShotType.halfBodyImg then
        self.data.modAvatar.halfBodyUrl = avatarUrl
      elseif avatarType == L_Const.screenShotType.battleHeadImg then
        self.data.modAvatar.battleHeadUrl = avatarUrl
      elseif avatarType == L_Const.screenShotType.halfsHeadImg then
        self.data.modAvatar.halfsHeadUrl = avatarUrl
      elseif avatarType == L_Const.screenShotType.circleHeadImg then
        self.data.modAvatar.circleHeadUrl = avatarUrl
      elseif avatarType == L_Const.screenShotType.paintImg then
        self.data.modAvatar.paintUrl = avatarUrl
      elseif avatarType == L_Const.screenShotType.bodyImg then
        self.data.modAvatar.bodyUrl = avatarUrl
      end
    end
  end
  local _AvatarTpl = L_GameTpl:getWardrobeAvatarTpl()
  if serverData.parts then
    for i = 0, serverData.parts.Count - 1 do
      local v = serverData.parts[i]
      local modWardrobe = require(L_R.store .. "mod.data.modWardrobe").new()
      modWardrobe.type = v.type
      modWardrobe.colorIds = {}
      if v.colors then
        for ii = 0, v.colors.Count - 1 do
          table.insert(modWardrobe.colorIds, v.colors[ii].colorId)
        end
      end
      self.data.modAvatar.modPartData[v.type] = modWardrobe
    end
  end
  self:call(self.event.refreshModAvatar, serverData)
end

function this:initStaminaRecoverTimer()
  if self.staminaTimer then
    return
  end
  local scale, minus, limit = self:getMinuOrScale()
  if scale == nil or minus == nil then
    return
  end
  if 0 < minus then
    self.staminaTimer = Timer.once(minus, function()
      self:staminaRecoverTimerFunc()
      self.staminaTimer = Timer.repeated(scale, self.staminaRecoverTimerFunc, self)
    end)
  else
    self.staminaTimer = Timer.repeated(scale, self.staminaRecoverTimerFunc, self)
  end
end

function this:getMinuOrScale()
  local recover = self:getCurrency(L_Const.currencyType.staminaRecover)
  if recover == nil then
    return
  end
  local playerLevelTpl = L_GameTpl:getPlayerLevelTpl()
  local limit = tonumber(playerLevelTpl:getStamina(playerLevelTpl:getTplById(L_PlayerStore:getLv())))
  local scale = tonumber(L_GameConstTpl:getData("STAMINA_TIME", L_Const.GameTplType.int))
  local minus = scale + recover.attr_val - L_TimeUtil.getServerTime()
  return scale, minus, limit
end

function this:staminaRecoverTimerFunc()
  L_PlayerStore:req_SyncStamina()
end

function this:modifyDisplayHero(hero)
  self.data.baseInfo.info.hero = {}
  for i, v in ipairs(hero) do
    local heroData = L_HeroStore:getHero(v.hero_id)
    local configId = L_HeroStore:getHeroConfigId(heroData)
    table.insert(self.data.baseInfo.info.hero, {
      id = v.hero_id,
      lv = L_HeroStore:getHeroLevel(heroData),
      config = configId,
      pos = v.pos,
      skin = v.skin
    })
  end
end

function this:modifyDisplayPet(pet)
  self.data.baseInfo.info.pet = {}
  for i, v in ipairs(pet) do
    local petData = L_PetStore:getPetItem(v.pet_guid)
    table.insert(self.data.baseInfo.info.pet, {
      guid = v.pet_guid,
      id = petData.id,
      lv = petData.lv,
      pos = v.pos
    })
  end
end

function this:getIsNewPlayer()
  local playerName = self:getPlayerName()
  local isNew = string.find(playerName, "&") == 1
  return isNew
end

return this
