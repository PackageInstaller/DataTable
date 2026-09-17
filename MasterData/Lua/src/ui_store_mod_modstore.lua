local this = class("modStore", G_BaseStore)
math.randomseed(os.time())
this.event = {
  refreshHeight = "refreshHeight",
  refreshUI = "refreshUI"
}
this:importPartialClass(require(L_R.store .. "mod.modState"))
this:importPartialClass(require(L_R.store .. "mod.modAction"))

function this:selectSkinWardrobeId(wardrobeAvatarId)
  if self.tempAvatarCtrl then
    self.tempAvatarCtrl:SetWardrobeId(self.modType.skin, wardrobeAvatarId)
  end
end

function this:selectModWardrobeId(wardrobeType, avatarId)
  if self.tempAvatarCtrl then
    self.tempAvatarCtrl:SetWardrobeId(wardrobeType, avatarId)
  end
end

function this:setTempAvatarCtrl(ctrl)
  self.tempAvatarCtrl = ctrl
end

function this:selectModColorId(wardrobeType, colorIndex, colorId)
  if self.tempAvatarCtrl then
    colorIndex = colorIndex or -1
    colorId = colorId or -1
    self.tempAvatarCtrl:SetColorId(wardrobeType, colorId, colorIndex)
  end
end

function this:getPlayerModData(sex)
  if L_PlayerStore:getIsNewPlayer() then
    return self:getDefaultData(sex)
  end
  local modAvatar = AzurWorld.avatarMgr:GetAvatarData(L_PlayerStore:getPlayerId())
  if modAvatar then
    return modAvatar
  end
  return self:getDefaultData(sex)
end

function this:resetDefaultData(typeList)
  if self.tempAvatarCtrl then
    self.tempAvatarCtrl:ResetDefualt()
  end
  self:call(self.event.refreshUI)
end

function this:randomSkinData()
  C_MJLog.LogInfo("modStore randomSkinData 废弃")
end

function this:randomDataByWardrobeTypeInter(wardrobeType)
  C_MJLog.LogInfo("modStore randomDataByWardrobeTypeInter 废弃")
end

function this:randomDataByWardrobeType(wardrobeType, hideRefresh)
  if wardrobeType == self.modType.skin then
    self:randomSkinData()
  else
    self:randomDataByWardrobeTypeInter(wardrobeType)
  end
  if hideRefresh then
  else
    self:call(self.event.refreshUI)
  end
end

function this:allRandomData(typeList)
  C_MJLog.LogInfo("modStore allRandomData 废弃")
end

function this:getOldDefaultData(sex)
  C_MJLog.LogInfo("modStore getOldDefaultData 废弃")
  return data
end

function this:getDefaultData(sex)
  if math.isEmpty(sex) or sex < 1 then
    sex = 2
  end
  return AzurWorld.avatarMgr:GetDefaultAvatarData(sex)
end

function this:getDefaultPartData(sex, partType)
end

function this:setIsChanged(state)
  self._isChanged = state
end

function this:isModDataChange()
  return self._isChanged
end

function this:transitionDataToServer(avatarData, urlData)
  local serverData = {}
  serverData.parts = {}
  serverData.sex = avatarData.Sex
  serverData.complexion = avatarData.Complexion
  for i, v in pairs(avatarData.PartInfoDict) do
    local partInfo = {}
    partInfo.type = i
    partInfo.id = v.id
    partInfo.colors = {}
    for j, k in pairs(v:GetColorIds()) do
      local colorInfo = {}
      colorInfo.index = j
      colorInfo.color_id = k
      table.insert(partInfo.colors, colorInfo)
    end
    partInfo.color_formular_ids = {}
    for j, k in pairs(v:GetColorFormulaIds()) do
      table.insert(partInfo.color_formular_ids, k)
    end
    table.insert(serverData.parts, partInfo)
  end
  serverData.avatars = {}
  if not string.isEmpty(urlData.headImgUrl) then
    local avatarPair = {}
    avatarPair.avatar_type = L_Const.screenShotType.hearHeadImg
    avatarPair.avatar_url = urlData.headImgUrl
    table.insert(serverData.avatars, avatarPair)
  end
  if not string.isEmpty(urlData.halfBodyUrl) then
    local avatarPair = {}
    avatarPair.avatar_type = L_Const.screenShotType.halfBodyImg
    avatarPair.avatar_url = urlData.halfBodyUrl
    table.insert(serverData.avatars, avatarPair)
  end
  if not string.isEmpty(urlData.battleHeadUrl) then
    local avatarPair = {}
    avatarPair.avatar_type = L_Const.screenShotType.battleHeadImg
    avatarPair.avatar_url = urlData.battleHeadUrl
    table.insert(serverData.avatars, avatarPair)
  end
  if not string.isEmpty(urlData.halfsHeadUrl) then
    local avatarPair = {}
    avatarPair.avatar_type = L_Const.screenShotType.halfsHeadImg
    avatarPair.avatar_url = urlData.halfsHeadUrl
    table.insert(serverData.avatars, avatarPair)
  end
  if not string.isEmpty(urlData.circleHeadUrl) then
    local avatarPair = {}
    avatarPair.avatar_type = L_Const.screenShotType.circleHeadImg
    avatarPair.avatar_url = urlData.circleHeadUrl
    table.insert(serverData.avatars, avatarPair)
  end
  if not string.isEmpty(urlData.paintUrl) then
    local avatarPair = {}
    avatarPair.avatar_type = L_Const.screenShotType.paintImg
    avatarPair.avatar_url = urlData.paintUrl
    table.insert(serverData.avatars, avatarPair)
  end
  if not string.isEmpty(urlData.bodyUrl) then
    local avatarPair = {}
    avatarPair.avatar_type = L_Const.screenShotType.bodyImg
    avatarPair.avatar_url = urlData.bodyUrl
    table.insert(serverData.avatars, avatarPair)
  end
  return serverData
end

return this
