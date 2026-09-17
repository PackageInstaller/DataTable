local this = class("moduleNestPlayerInfo", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local C_NestCoopPlayerState = CS.Protocal.Cs.NestCoopPlayerState

function this.bind()
  return {
    icon_head = nil,
    txt_name = nil,
    listPets = {
      moduleName = "pages/petDuel/nestCoop/cellNestPlayerPet"
    },
    activePet = nil,
    activeState = nil,
    activeLoading = nil,
    activeDisconnect = nil,
    activeConnected = nil,
    txtNum = nil,
    img_Sort = nil
  }
end

function this.methods()
  return {}
end

function this:initData(data)
  self.dataSrc = data
  self.playerId = data.playerId
  self.npcId = data.npcId
  self.npcGuid = data.npcGuid
  self.heroId = data.heroId
  self.index = data.index
  self.bind.txt_name = self.dataSrc.playerName
  if L_GameUtil.isDefaultHero(self.heroId) then
    L_FriendManager:loadHeroHeadTex(self.playerId, L_Const.avatarTextureIndex.half_formation, function(tex)
      if tex then
        if self.headTex then
          C_PhotoManager.ReleaseTexture(self.headTex)
        end
        self.headTex = tex
        self.imgHead.sprite = Unity.Sprite.Create(tex, C_Rect(0, 0, tex.width, tex.height), C_Vector2.one * 0.5)
        self.bindComponents.imgHead.preserveAspect = true
      end
    end)
  else
    self.bind.icon_head = "Assets/Arts/UI/Icon/HeroM/tex_icon_hero_m_" .. self.heroId .. ".png"
  end
  if self.npcId ~= nil then
    local heroId = data.heroId
    self.bind.icon_head = "Assets/Arts/UI/Icon/HeroM/tex_icon_hero_m_" .. heroId .. ".png"
  end
  self:initPetList()
  self.updateHandler = self.updateHandler or Timer.repeated(1, self.update, self)
  self:update()
  if self.playerId then
    if C_KiboDuelSystemMgr:IsSoloNest() then
      self.bind.activePet = true
    else
      local status = C_NestCoopMgr:GetPlayerState(self.playerId)
      if status then
        self:setPlayerStatus(status)
      end
    end
  elseif self.npcGuid then
    self.bind.activePet = true
    self.bind.activeLoading = false
    self.bind.activeDisconnect = false
  end
end

function this:initView(_num, _color)
  self.bind.txtNum = _num
  local _, numColor = C_ColorUtility.TryParseHtmlString(_color)
  self.bind.img_Sort = numColor
end

function this:open(options)
  self.imgHead = self.bindComponents.imgHead
  self.ani_playerState = self.bindComponents.ani_playerState
  self.onEntityChangedHandler = handler(self, self.onEntityChanged)
  C_EntityManager.entityBirthHandler:Add(self.onEntityChangedHandler)
  C_EntityManager.entityOnRemoveHandler:Add(self.onEntityChangedHandler)
  self.isSolo = C_KiboDuelSystemMgr:IsSoloNest()
  if not self.isSolo then
    self.onPlayerStatusChangedHandler = self.onPlayerStatusChangedHandler or handler(self, self.onPlayerStatusChanged)
    C_NestCoopMgr:RegisterEvent(C_ENestCoopEvent.ChangePlayerStatus, self.onPlayerStatusChangedHandler)
    self.serverStatusChangedHandler = self.serverStatusChangedHandler or function()
      if self.playerId then
        local status = C_NestCoopMgr:GetPlayerState(self.playerId)
        if status then
          self:setPlayerStatus(status)
        end
      end
    end
    C_NestCoopMgr:RegisterEvent(C_ENestCoopEvent.SyncServerData, self.serverStatusChangedHandler)
    local status = C_NestCoopMgr:GetPlayerState(self.playerId)
    if status then
      self:setPlayerStatus(status)
    end
  else
    self.bind.activeState = false
  end
end

function this:onEntityChanged(entityHandler)
  if entityHandler and entityHandler.entity.data.entityType == C_EEntityType.KiBo then
    self.needRefresh = true
  end
end

function this:onPlayerStatusChanged(e, varList)
  local playerId = varList:GetInt(0)
  local status = varList:GetObject(1)
  if playerId == self.playerId and not self.isSolo then
    self:setPlayerStatus(status)
  end
end

function this:setPlayerStatus(status)
  local nestState = C_NestCoopMgr.GetNestCoopStatus
  print("巢穴玩家ui状态变更" .. (self.playerId or "") .. " " .. tostring(status) .. "当前副本状态" .. tostring(nestState))
  self.bind.activePet = status == C_NestCoopPlayerState.NcpsReady and nestState == C_NestCoopStatus.NccsStart
  self.bind.activeState = nestState ~= C_NestCoopStatus.NccsStart or status == C_NestCoopPlayerState.NcpsNone or status == C_NestCoopPlayerState.NcpsQuit or status == C_NestCoopPlayerState.NcpsLoad
  self.bind.activeLoading = status == C_NestCoopPlayerState.NcpsLoad
  self.bind.activeDisconnect = status == C_NestCoopPlayerState.NcpsQuit or status == C_NestCoopPlayerState.NcpsNone
  self.bind.activeConnected = status == C_NestCoopPlayerState.NcpsReady and (nestState == C_NestCoopStatus.NccsReady1 or nestState == C_NestCoopStatus.NccsReady2 or nestState == C_NestCoopStatus.NccsPreStart)
  if self.bind.activeDisconnect and not self.isDisconnect then
    self.ani_playerState:Rewind()
    self.ani_playerState:Play("anim_DuelNestCoopInfo_playerStatus_todisconnect")
  elseif self.bind.activeConnected and not self.isConnected then
    self.ani_playerState:Rewind()
    self.ani_playerState:Play("anim_DuelNestCoopInfo_playerStatus_toloaded")
  elseif self.bind.activeLoading and not self.isLoading then
    self.ani_playerState:Rewind()
    self.ani_playerState:Play("anim_DuelNestCoopInfo_playerStatus_in")
  end
  self.isDisconnect = self.bind.activeDisconnect
  self.isConnected = self.bind.activeConnected
  self.isLoading = self.bind.activeLoading
  self.curPlayerState = status
end

function this:initPetList()
  local list = {
    {},
    {},
    {}
  }
  self.bind.listPets:clear()
  self.bind.listPets:insert_array(list)
end

function this:update()
  if self.needRefresh and (self.playerId or self.npcGuid) then
    self.needRefresh = false
    local petEntityIds
    if self.playerId then
      petEntityIds = C_KiboDuelSystemMgr:GetPetEntityIdByPlayerId(self.playerId)
    elseif self.npcGuid then
      petEntityIds = C_KiboDuelSystemMgr:GetPetEntityIdByNpcId(self.npcGuid)
    end
    if petEntityIds == nil then
      return
    end
    local allModules = {}
    for i, v in pairs(self.modules.listPets) do
      local module = v
      table.insert(allModules, module)
    end
    local resEntityIds = {}
    for i = 0, petEntityIds.Count - 1 do
      local entityId = petEntityIds[i]
      local has = false
      for k, m in pairs(self.modules.listPets) do
        local module = m
        if module.entityId == entityId then
          has = true
          table.remove(allModules, table.indexOf(allModules, module))
          break
        end
      end
      if not has then
        table.insert(resEntityIds, entityId)
      end
    end
    for i = 1, #resEntityIds do
      local entityId = resEntityIds[i]
      local module = allModules[i]
      if module then
        module:setData({entityId = entityId})
      end
    end
  end
end

function this:close()
  if self.headTex then
    C_PhotoManager.ReleaseTexture(self.headTex)
  end
  if self.onEntityChangedHandler then
    C_EntityManager.entityBirthHandler:Remove(self.onEntityChangedHandler)
    C_EntityManager.entityOnRemoveHandler:Remove(self.onEntityChangedHandler)
    self.onEntityChangedHandler = nil
  end
  if self.updateHandler then
    Timer.remove(self.updateHandler)
    self.updateHandler = nil
  end
  if self.onPlayerStatusChangedHandler then
    C_NestCoopMgr:UnregisterEvent(C_ENestCoopEvent.ChangePlayerStatus, self.onPlayerStatusChangedHandler)
    self.onPlayerStatusChangedHandler = nil
  end
  if self.serverStatusChangedHandler then
    C_NestCoopMgr:UnregisterEvent(C_ENestCoopEvent.SyncServerData, self.serverStatusChangedHandler)
    self.serverStatusChangedHandler = nil
  end
end

function this:refresh()
end

return this
