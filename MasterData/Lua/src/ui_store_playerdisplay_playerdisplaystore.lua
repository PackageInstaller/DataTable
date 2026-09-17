local this = class("playerDisplayStore", G_BaseStore)
this.event = {
  dressItemSync = " dressItemSync"
}
this:importPartialClass(require(L_R.store .. "playerDisplay.playerDisplayState"))
this:importPartialClass(require(L_R.store .. "playerDisplay.playerDisplayAction"))

function this:ctor()
  this.super.ctor(self)
  self._playerCardDressTpl = L_GameTpl:getPlayercardDressTpl()
  self._playerCardDressListTpl = L_GameTpl:getPlayercardDressListTpl()
end

function this:hasItem(id)
  return self.data.allItem[id] ~= nil
end

function this:isCurDress(id)
  local hero = self:getcurHero()
  if hero == nil then
    return false
  end
  if self:getcurHero().config == id or self:getcurPet() == id or self:getCurbackground() == id or self:getCurbase() == id or self:getCurHead() == id or self:getCurHeadFrame() == id then
    return true
  end
  return false
end

function this:getTexFilePath(name, folder, customPath)
  local path = ""
  customPath = customPath or L_PhotoStore.path.imgStandeeHeroSavePath
  path = customPath .. folder
  return string.format("%s/%s.png", path, name)
end

function this:updateCaptureInfo(id, url)
  local item = self:getItem(id)
  if item ~= nil then
    item.url = url
  end
end

function this:getLocalPath(url)
  if not string.isEmpty(url) then
    local strArr = string.split(url, "/")
    local name = strArr[#strArr]
    local path = L_PlayerDisplayStore:getTexFilePath(name, L_PlayerStore:getPlayerId())
    return path
  end
  return ""
end

function this:getHeroStandeeCapture(url, isSelf, callback)
  if isSelf then
    self:getHeroStandeeCaptureSelf(url, callback)
  else
    local function successCall(self, tex)
      callback(tex, url)
    end
    
    local function failCall(self, key)
    end
    
    C_CDNManager.DownloadToTex(url, handler(self, successCall), handler(self, failCall))
  end
end

function this:getHeroStandeeCaptureSelf(url, callback)
  local imgFilePath = self:getLocalPath(url)
  local isExists = C_File.Exists(imgFilePath)
  
  local function getCallback(flag, tex)
    if flag then
      callback(tex, url)
      if not isExists then
        C_PhotoManager.SaveTexture2DByPath(imgFilePath, tex, true)
      end
    end
  end
  
  if isExists then
    C_PhotoManager.GetTexture2DByPath(imgFilePath, function(tex)
      callback(tex, url)
    end)
  else
    local function successCall(self, tex)
      if getCallback then
        getCallback(true, tex)
      end
    end
    
    local function failCall(self, key)
      if getCallback then
        getCallback(false, nil, key)
      end
    end
    
    C_CDNManager.DownloadToTex(url, handler(self, successCall), handler(self, failCall))
  end
end

function this:buildRedDotTree()
  if self.redDotRootNode ~= nil then
    return
  end
  self:getRedDotRootNode()
  self:buildRedDotTab()
  self:buildRedDotItem()
  if self.redDotRootNode ~= nil then
    self.redDotRootNode:RefreshState()
  end
end

function this:getRedDotRootNode()
  local node = AzurWorld.RedDotMgr:BuildRedDotByConfig("20000")
  self.redDotRootNode = node
  return node
end

function this:buildRedDotTab()
  for _, config in pairs(self._playerCardDressListTpl.data) do
    if config ~= nil and config.team == 2 and config.show == 1 and L_ConditionManager:isComplete(config.condition) then
      AzurWorld.RedDotMgr:RegistRedDot("playerDisplay_tab_" .. tostring(config.id), self.redDotRootNode)
    end
  end
end

function this:buildRedDotItem()
  local allDressConfig = self._playerCardDressTpl.data
  for _, config in pairs(allDressConfig) do
    local type = config.type
    local id = config.id
    local tabNode = AzurWorld.RedDotMgr:GetRedDot("playerDisplay_tab_" .. type)
    if tabNode ~= nil then
      do
        local node = AzurWorld.RedDotMgr:RegistRedDot("playerDisplay_item_" .. tostring(id), tabNode, function()
          return L_ReddotManager:haveNew(L_ReddotManager.DotDef.PlayerDressItem, id)
        end)
      end
    end
  end
end

function this:getTabRedDotNode(tabId)
  return AzurWorld.RedDotMgr:GetRedDot(tabId)
end

function this:registRedDot(id, rootRedDotNode, check)
  local node = AzurWorld.RedDotMgr:RegistRedDot(id, rootRedDotNode, check)
  return node
end

function this:loadHeadPic(baseInfo, callback)
  local headId = baseInfo.stand_plates.profile
  local tpl = self._playerCardDressTpl:getTplById(headId)
  if tpl == nil then
    local url = L_FriendStore:getPlayerAvatarsFormationHead(baseInfo)
    L_PhotoManager:loadHeadTex(url, function(tex)
      callback(nil, tex)
    end, nil, nil, baseInfo)
    return
  end
  if tpl and tpl.type == L_Const.playerDressType.head then
    local isDefault = self._playerCardDressTpl:getDefault(tpl)
    if isDefault == 1 then
      local url = L_FriendStore:getPlayerAvatarsFormationHead(baseInfo)
      L_PhotoManager:loadHeadTex(url, function(tex)
        callback(nil, tex)
      end, nil, nil, baseInfo)
    else
      local iconStr = self._playerCardDressTpl:getProfilePic(tpl)
      callback(iconStr, nil)
    end
  end
end

function this:getHeadPath(baseInfo)
  local headId = baseInfo.stand_plates.profile
  local tpl = self._playerCardDressTpl:getTplById(headId)
  local url = L_FriendStore:getPlayerAvatarsFormationHead(baseInfo)
  if tpl == nil then
    return true, L_PhotoManager:getDefaultHeadPath(url, baseInfo and baseInfo.sex)
  end
  if tpl.type == L_Const.playerDressType.head then
    local isDefault = self._playerCardDressTpl:getDefault(tpl)
    if isDefault == 1 then
      local defualtPath = L_PhotoManager:getDefaultHeadPath(url, baseInfo and baseInfo.sex)
      if defualtPath then
        return true, defualtPath
      end
      return false, url
    else
      return true, self._playerCardDressTpl:getProfilePic(tpl)
    end
  end
end

function this:loadHeadPicByPlayerCardDressId(playerCardDressId, callback)
  local tpl = self._playerCardDressTpl:getTplById(playerCardDressId)
  if tpl == nil then
    return
  end
  if tpl and tpl.type == L_Const.playerDressType.head then
    local iconStr = self._playerCardDressTpl:getProfilePic(tpl)
    callback(iconStr, nil)
  end
end

function this:loadHeadPicByPlayerId(playerId, callback)
  local baseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
  if baseInfo == nil then
    return false
  end
  self:loadHeadPic(baseInfo, callback)
  return true
end

function this:loadHeadFrame(baseInfo)
  local headFrameId = baseInfo.stand_plates.profile_frame
  local tpl = self._playerCardDressTpl:getTplById(headFrameId)
  if tpl == nil then
    local frame, tplId = self:getDefaultFrame()
    tpl = self._playerCardDressTpl:getTplById(tplId)
  end
  if tpl and tpl.type == L_Const.playerDressType.headFrame then
    local frame = self._playerCardDressTpl:getPic(tpl)
    local frameBg = self._playerCardDressTpl:getFramePic(tpl)
    return frame, frameBg
  end
  return nil, nil
end

function this:loadDefaultHeadFrame()
  local frame, tplId = self:getDefaultFrame()
  local tpl = self._playerCardDressTpl:getTplById(tplId)
  if tpl and tpl.type == L_Const.playerDressType.headFrame then
    local frame = self._playerCardDressTpl:getPic(tpl)
    local frameBg = self._playerCardDressTpl:getFramePic(tpl)
    return frame, frameBg
  end
end

function this:getDefaultFrame()
  if self.defaultFrame then
    return self.defaultFrame, self.defaultFrameId
  end
  for i, v in pairs(self._playerCardDressTpl.data) do
    if v.type == L_Const.playerDressType.headFrame and self._playerCardDressTpl:getDefault(v) == 1 then
      local defaultFrame = self._playerCardDressTpl:getPic(v)
      local id = self._playerCardDressTpl:getId(v)
      self.defaultFrame = defaultFrame
      self.defaultFrameId = id
      return defaultFrame, id
    end
  end
end

function this:getDefaultHead()
  if self.defaultHeadId then
    return self.defaultHeadId
  end
  for i, v in pairs(self._playerCardDressTpl.data) do
    if v.type == L_Const.playerDressType.head and self._playerCardDressTpl:getDefault(v) == 1 then
      self.defaultHeadId = self._playerCardDressTpl:getId(v)
      return self.defaultHeadId
    end
  end
end

function this:getHeadBaseInfo(baseInfo)
  return baseInfo or L_PlayerStore:getPlayerBaseInfo()
end

function this:getDressPreviewRenderData(id, baseInfo)
  local tpl = self._playerCardDressTpl:getTplById(id)
  if tpl == nil then
    return nil
  end
  local renderData = {
    id = id,
    type = tpl.type,
    isDefault = self._playerCardDressTpl:getDefault(tpl) == 1,
    paintingPath = self._playerCardDressTpl:getPreviewPaintingPath(tpl),
    startingAnimation = self._playerCardDressTpl:getPreviewStartingAnimation(tpl),
    playAnimation = self._playerCardDressTpl:getPreviewPlayAnimation(tpl),
    frameName = self._playerCardDressTpl:getPreviewFrameName(tpl),
    fallbackFrameName = self._playerCardDressTpl:getPreviewFallbackFrameName(tpl),
    hideBg = self._playerCardDressTpl:getPreviewHideBg(tpl),
    hideRole = self._playerCardDressTpl:getPreviewHideRole(tpl)
  }
  if not string.isEmpty(renderData.paintingPath) then
    renderData.renderType = "painting"
    return renderData
  end
  if tpl.type == L_Const.playerDressType.head then
    if renderData.isDefault then
      local curBaseInfo = self:getHeadBaseInfo(baseInfo)
      renderData.renderType = "photo"
      renderData.photoUrl = L_FriendStore:getPlayerAvatars(curBaseInfo, L_Const.avatarTextureIndex.half_formation)
    else
      renderData.renderType = "sprite"
      renderData.spritePath = self._playerCardDressTpl:getProfilePic(tpl)
    end
  elseif tpl.type == L_Const.playerDressType.headFrame then
    renderData.renderType = "sprite"
    renderData.spritePath = self._playerCardDressTpl:getPic(tpl)
    renderData.bgPath = self._playerCardDressTpl:getFramePic(tpl)
  else
    renderData.renderType = "none"
  end
  return renderData
end

function this:getHeadPreviewRenderData(headId, frameId, baseInfo)
  if math.isEmpty(headId) then
    headId = self:getDefaultHead()
  end
  if math.isEmpty(frameId) then
    local _, defaultFrameId = self:getDefaultFrame()
    frameId = defaultFrameId
  end
  if math.isEmpty(headId) or math.isEmpty(frameId) then
    return nil
  end
  return {
    head = self:getDressPreviewRenderData(headId, baseInfo),
    frame = self:getDressPreviewRenderData(frameId, baseInfo)
  }
end

function this:clearCache()
end

return this
