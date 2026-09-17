local this = class("moduleChatFriendList", G_UIModuleBase)
local _playerTitleTpl = L_GameTpl:getPlayerTitleTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local _petTpl = L_GameTpl:getPetTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    currentSelectPlayerId = 0,
    hasFriend = true,
    tabId = -1,
    friendInited = false
  }
end

function this.bind()
  return {
    offsetMax_bg = C_Vector2(0, 0),
    moduleCharacterStandee = {
      moduleName = "pages/playerCard/moduleCharacterStandee"
    },
    txt_achievement = "",
    txt_playerLevel = "",
    txt_qiboCollect = "",
    txt_heroCollect = "",
    txt_title = "",
    go_infoPanel = true,
    go_Info = false,
    go_InfoEmpty = true,
    go_closeInfoBtn = true
  }
end

function this.methods()
  return {
    onClick_closeInfo = function(self)
      L_UI:close("pageChat")
    end,
    onClick_friendInfoMask = function(self)
      self:emit("onClick_close")
    end
  }
end

function this:open(options)
  this.super.open(self, options)
  L_FriendStore:listenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList, self)
end

function this:close(options)
  this.super.close(self, options)
  L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList)
  L_TimerManager:clearTimer(self)
end

function this:ShowPlayerCard()
  local baseInfo = L_FriendStore:getPlayerBaseInfo(self.data.tabId)
  self.bind.txt_achievement = not baseInfo.stand_plates.achievement_point and "0" or tostring(baseInfo.stand_plates.achievement_point)
  self.bind.txt_playerLevel = tostring(L_FriendStore:getPlayerLevel(baseInfo))
  local qiboNum = not baseInfo.stand_plates.pet_count and 0 or tostring(baseInfo.stand_plates.pet_count)
  local heroNum = not baseInfo.stand_plates.hero_count and 0 or tonumber(baseInfo.stand_plates.hero_count)
  local heroTotal = tonumber(_heroTpl:getTotalCollect())
  self.bind.txt_qiboCollect = tostring(math.floor(qiboNum * 100 / _petTpl:getTotalIconographyshow()))
  self.bind.txt_heroCollect = heroNum >= heroTotal and "100" or tostring(math.floor(heroNum * 100 / heroTotal))
  self.bind.txt_title = L_FriendStore:getPlayerSign(baseInfo)
  if self.modules.moduleCharacterStandee then
    self.modules.moduleCharacterStandee:setStandeeByBaseInfo(baseInfo)
  end
end

function this:initModule(tabId)
  if not self.data.friendInited then
    local playerList = L_FriendStore:getFriendList()
    local players = {}
    for _, v in pairs(playerList) do
      table.insert(players, v:getPlayerUid())
    end
    local types = {
      L_Const.PlayerBasicQueryType.PBQT_ALL
    }
    L_FriendManager:requestBaseInfo(types, players, function()
      self.data.friendInited = true
      self:initFriendList(tabId)
      local empty = table.isEmpty(L_FriendStore:getFriendList())
      self.data.hasFriend = not empty
      self.bind.go_closeInfoBtn = not empty
      self.bind.go_infoPanel = not empty
      self.bind.offsetMax_bg = not empty and C_Vector2(0, 0) or C_Vector2(-1600, 0)
    end)
  else
    self:initFriendList(tabId)
    local empty = table.isEmpty(L_FriendStore:getFriendList())
    self.data.hasFriend = not empty
    self.bind.go_closeInfoBtn = not empty
    self.bind.go_infoPanel = not empty
    self.bind.offsetMax_bg = not empty and C_Vector2(0, 0) or C_Vector2(-1600, 0)
  end
end

function this:initFriendList(tabId)
  local tmp = {}
  local player = L_FriendStore:getFriendList()
  if tabId and 0 < tabId and L_FriendStore:getIsFriend(tabId) then
    self.data.tabId = tabId
  end
  if self.data.tabId == -1 then
    for i, v in pairs(player) do
      table.insert(tmp, {
        uid = v:getPlayerUid()
      })
    end
    table.sort(tmp, function(a, b)
      local baseInfoA = L_FriendStore:getPlayerBaseInfo(a.uid)
      local baseInfoB = L_FriendStore:getPlayerBaseInfo(b.uid)
      local onlineA = L_FriendStore:getPlayerIsOnline(baseInfoA) and 0 or 1
      local onlineB = L_FriendStore:getPlayerIsOnline(baseInfoB) and 0 or 1
      if onlineA == 0 and onlineB == 0 then
        local friendItemA = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), a.uid)
        local friendItemB = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), b.uid)
        local timeA = friendItemA:getInsertTime()
        local timeB = friendItemB:getInsertTime()
        return timeA < timeB
      elseif onlineA == 1 and onlineB == 1 then
        local offlineTimeA = L_FriendStore:getPlayerOffLineTime(baseInfoA)
        local offlineTimeB = L_FriendStore:getPlayerOffLineTime(baseInfoB)
        return offlineTimeA > offlineTimeB
      else
        return onlineA < onlineB
      end
    end)
  end
  if table.count(player) > 0 then
    if self.data.tabId == -1 then
      self.data.tabId = tmp[1].uid
    end
    self:ShowPlayerCard()
    if self.bindComponents.moduleCharacterStandee then
      self.bind.go_Info = true
      self.bind.go_InfoEmpty = false
      self.bindComponents.moduleCharacterStandee.gameObject:SetActive(true)
    end
  elseif self.bindComponents.moduleCharacterStandee then
    self.bind.go_Info = false
    self.bind.go_InfoEmpty = true
    self.bindComponents.moduleCharacterStandee.gameObject:SetActive(false)
  end
end

function this:onEvent_refreshIdList()
  self:initModule()
end

function this:playOpenAnim()
  if not self.bindComponents.anim_friendInfo then
    return
  end
  self.bindComponents.anim_friendInfo:Stop()
  self.bindComponents.anim_friendInfo:Play("anim_friendInfo_in")
  if self.data.hasFriend then
    L_AudioUtil.playSound("Play_SFX_System_UI_Friends")
  end
end

function this:playSwitchAnim(isOpen)
  if not self.bindComponents.anim_friendInfo then
    return
  end
  self.bindComponents.anim_friendInfo:Stop()
  if isOpen then
    self.bindComponents.anim_friendInfo:Play("anim_friendInfo_in")
    if self.data.hasFriend then
      L_AudioUtil.playSound("Play_SFX_System_UI_Friends")
    end
  else
    self.bindComponents.anim_friendInfo:Play("anim_friendInfo_close")
  end
end

function this:playCloseAnim()
  if not self.bindComponents.anim_friendInfo then
    return
  end
  self.bindComponents.anim_friendInfo:Stop()
  self.bindComponents.anim_friendInfo:Play("anim_friendInfo_close")
end

function this:playSwitchChatAnim()
  if not self.bindComponents.anim_friendInfo then
    return
  end
  self.bindComponents.anim_friendInfo:Stop()
  self.bindComponents.anim_friendInfo:Play("anim_friendInfo_switch")
  L_AudioUtil.playSound("Play_SFX_System_UI_Friends_Switch")
end

function this:onSetSelectTabId(tabId)
  self.data.tabId = tabId
  if self.isBind then
    self.bind.go_infoPanel = true
    self:ShowPlayerCard()
    self:playSwitchChatAnim()
  end
end

return this
