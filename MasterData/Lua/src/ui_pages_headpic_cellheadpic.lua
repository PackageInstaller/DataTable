local this = class("cellHeadPic", G_UIModuleBase)
local _playerDressTpl = L_GameTpl:getPlayercardDressTpl()
local _typePaintingScaler = typeof(CS.Lens.Framework.UI.LPaintingScaler)
local _meshImageList = CS.System.Collections.Generic.List(CS.Lens.Framework.UI.LMeshImage)

function this.bind()
  return {
    img_head = nil,
    img_frame = nil,
    img_frameBg = nil,
    active_head = true,
    active_frame = true,
    active_frameBg = true,
    img_head_desaturate = false,
    img_frame_desaturate = false,
    img_frameBg_desaturate = false,
    active_mask1 = false,
    active_mask2 = false,
    active_mask3 = false,
    color_mask1 = C_Color.white,
    color_mask2 = C_Color.white,
    color_mask3 = C_Color.white
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.onClickCallback then
        self.onClickCallback()
      else
        self:emit("onClick", self.bind)
      end
    end
  }
end

function this:created(bindData, emitMethods, parent)
  this.super.created(self, bindData, emitMethods, parent)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshBaseInfo, self.onEvent_refreshBaseInfo, self)
end

function this:close()
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshBaseInfo, self.onEvent_refreshBaseInfo)
  this.super.close(self)
end

function this:bumpRenderVersion(key)
  self._renderVersion = self._renderVersion or {}
  self._renderVersion[key] = (self._renderVersion[key] or 0) + 1
  return self._renderVersion[key]
end

function this:getRenderVersion(key)
  self._renderVersion = self._renderVersion or {}
  return self._renderVersion[key] or 0
end

function this:findPaintingScaler(key)
  self._paintingScaler = self._paintingScaler or {}
  return self._paintingScaler[key]
end

function this:getPaintingScaler(key)
  self._paintingScaler = self._paintingScaler or {}
  if self._paintingScaler[key] then
    return self._paintingScaler[key]
  end
  local target
  if key == "head" then
    target = self.bindComponents.img_main
  elseif key == "frame" then
    target = self.bindComponents.img_FrameBg
  end
  if target == nil then
    return nil
  end
  local scaler = target.gameObject:GetComponent(_typePaintingScaler)
  if scaler == nil then
    scaler = target.gameObject:AddComponent(_typePaintingScaler)
    scaler.lMeshImageList = _meshImageList()
  end
  self._paintingScaler[key] = scaler
  return scaler
end

function this:setImageAlpha(component, alpha)
  if component == nil then
    return
  end
  local color = component.color
  color.a = alpha
  component.color = color
end

function this:resetHeadImageState()
  self.bind.active_head = true
  self:setImageAlpha(self.bindComponents.img_main, 1)
end

function this:resetFrameImageState()
  self.bind.active_frame = true
  self.bind.active_frameBg = true
  self:setImageAlpha(self.bindComponents.img_Frame, 1)
  self:setImageAlpha(self.bindComponents.img_FrameBg, 1)
end

function this:clearPainting(key)
  local scaler = self:findPaintingScaler(key)
  if scaler ~= nil then
    scaler.loadCallBack = nil
    scaler:LoadPainting("")
  end
end

function this:applyHeadTexture(tex)
  self:clearTexture()
  self:clearPainting("head")
  self:resetHeadImageState()
  if self.bindComponents.img_main ~= nil and tex ~= nil then
    self.bind.img_head = ""
    local rect = C_Rect(0, 0, tex.width, tex.height)
    local pivot = C_Vector2.one * 0.5
    if self.bindComponents.img_main.sprite ~= nil then
      Unity.Sprite.Destroy(self.bindComponents.img_main.sprite)
    end
    self.bindComponents.img_main.sprite = Unity.Sprite.Create(tex, rect, pivot)
    self.texCache = tex
    return true
  end
  return false
end

function this:applyPaintingRender(key, renderData)
  if renderData == nil or renderData.renderType ~= "painting" or string.isEmpty(renderData.paintingPath) then
    return false
  end
  local scaler = self:getPaintingScaler(key)
  if scaler == nil then
    return false
  end
  if key == "head" then
    self:clearTexture()
    self:resetHeadImageState()
    self.bind.img_head = ""
    self:setImageAlpha(self.bindComponents.img_main, 0)
  else
    self:resetFrameImageState()
    self:setImageAlpha(self.bindComponents.img_Frame, 0)
    self:setImageAlpha(self.bindComponents.img_FrameBg, 0)
  end
  scaler.hideBg = renderData.hideBg == true
  scaler.hideRole = renderData.hideRole == true
  scaler.FrameName = renderData.frameName or ""
  scaler.FallbackFrameName = renderData.fallbackFrameName or ""
  scaler.startingAnimation = renderData.startingAnimation or ""
  local paintingPath = renderData.paintingPath
  if type(paintingPath) == "string" then
    paintingPath = string.gsub(paintingPath, "UI/SoulEssence/pre_soulessence_", "UI/SoulEssenceHead/pre_soulessenceHead_", 1)
  end
  scaler:LoadPainting(paintingPath)
  if not string.isEmpty(renderData.playAnimation) then
    scaler:setPlayAnimation(renderData.playAnimation)
  end
  return true
end

function this:applyHeadRenderData(renderData, baseInfo)
  self:bumpRenderVersion("head")
  self:clearPainting("head")
  if renderData == nil then
    self:clearTexture()
    self.bind.active_head = false
    return
  end
  if self:applyPaintingRender("head", renderData) then
    return
  end
  if renderData.renderType == "photo" and not string.isEmpty(renderData.photoUrl) then
    local version = self:getRenderVersion("head")
    self:clearTexture()
    self:resetHeadImageState()
    self.bind.img_head = ""
    L_PhotoManager:loadHeadTex(renderData.photoUrl, function(tex)
      if version ~= self:getRenderVersion("head") then
        if tex ~= nil then
          C_PhotoManager.ReleaseTexture(tex)
        end
        return
      end
      if not self:applyHeadTexture(tex) then
        C_PhotoManager.ReleaseTexture(tex)
      end
    end, nil, nil, baseInfo)
    return
  end
  self:clearTexture()
  self:resetHeadImageState()
  if not string.isEmpty(renderData.spritePath) then
    self.bind.img_head = renderData.spritePath
  else
    self.bind.active_head = false
  end
end

function this:applyFrameRenderData(renderData)
  self:bumpRenderVersion("frame")
  self:clearPainting("frame")
  if renderData == nil then
    self.bind.active_frame = false
    self.bind.active_frameBg = false
    return
  end
  if self:applyPaintingRender("frame", renderData) then
    return
  end
  self:resetFrameImageState()
  if not string.isEmpty(renderData.spritePath) then
    self.bindComponents.img_Frame:LoadSprite(renderData.spritePath, false)
  else
    self.bind.active_frame = false
  end
  if not string.isEmpty(renderData.bgPath) then
    self.bindComponents.img_FrameBg:LoadSprite(renderData.bgPath, false)
  else
    self.bind.active_frameBg = false
  end
end

function this:setHeadSprite(tex)
  self:bumpRenderVersion("head")
  return self:applyHeadTexture(tex)
end

function this:destroy()
  if self.onClickCallback then
    self.onClickCallback = nil
  end
  self:clearTexture()
  self:clearPainting("head")
  self:clearPainting("frame")
end

function this:clearTexture()
  if self.texCache then
    C_PhotoManager.ReleaseTexture(self.texCache)
    self.texCache = nil
  end
end

function this:hideHeadRender()
  self:bumpRenderVersion("head")
  self:clearTexture()
  self:clearPainting("head")
  self.bind.active_head = false
end

function this:setHeadPicByTpl(headTplId, frameTplId, hideFrame, hideHead)
  if hideHead then
    self:hideHeadRender()
  elseif not math.isEmpty(headTplId) then
    self:applyHeadRenderData(L_PlayerDisplayStore:getDressPreviewRenderData(headTplId))
  end
  if hideFrame then
    self:bumpRenderVersion("frame")
    self:clearPainting("frame")
    self.bind.active_frame = false
    self.bind.active_frameBg = false
    return
  end
  if not math.isEmpty(frameTplId) then
    self:applyFrameRenderData(L_PlayerDisplayStore:getDressPreviewRenderData(frameTplId))
  end
end

function this:setPreviewByDressIds(headTplId, frameTplId, baseInfo, hideHead)
  local renderData = L_PlayerDisplayStore:getHeadPreviewRenderData(headTplId, frameTplId, baseInfo)
  if hideHead then
    self:hideHeadRender()
  else
    self:applyHeadRenderData(renderData and renderData.head, baseInfo)
  end
  self:applyFrameRenderData(renderData and renderData.frame)
end

function this:setStaticPreviewByDressIds(headTplId, frameTplId, baseInfo, hideHead)
  if math.isEmpty(headTplId) then
    headTplId = L_PlayerDisplayStore:getDefaultHead()
  end
  if math.isEmpty(frameTplId) then
    local _, defaultFrameId = L_PlayerDisplayStore:getDefaultFrame()
    frameTplId = defaultFrameId
  end
  if hideHead then
    self:bumpRenderVersion("head")
    self:clearPainting("head")
    self:clearTexture()
    self:resetHeadImageState()
    self.bind.active_head = true
    self.bind.img_head = ""
    self.bind.img_head_desaturate = false
  else
    local headTpl = _playerDressTpl:getTplById(headTplId)
    self:bumpRenderVersion("head")
    self:clearPainting("head")
    self:clearTexture()
    if headTpl == nil then
      self.bind.active_head = false
    elseif _playerDressTpl:getDefault(headTpl) == 1 then
      local version = self:getRenderVersion("head")
      local curBaseInfo = baseInfo or L_PlayerStore:getPlayerBaseInfo()
      self:resetHeadImageState()
      self.bind.img_head = ""
      L_PhotoManager:loadHeadTex(L_FriendStore:getPlayerAvatars(curBaseInfo, L_Const.avatarTextureIndex.half_formation), function(tex)
        if version ~= self:getRenderVersion("head") then
          if tex ~= nil then
            C_PhotoManager.ReleaseTexture(tex)
          end
          return
        end
        if not self:applyHeadTexture(tex) then
          C_PhotoManager.ReleaseTexture(tex)
        end
      end)
    else
      self:resetHeadImageState()
      self.bind.img_head = _playerDressTpl:getProfilePic(headTpl)
    end
  end
  local frameTpl = _playerDressTpl:getTplById(frameTplId)
  self:bumpRenderVersion("frame")
  self:clearPainting("frame")
  if frameTpl == nil then
    self.bind.active_frame = false
    self.bind.active_frameBg = false
    return
  end
  self:resetFrameImageState()
  self.bindComponents.img_Frame:LoadSprite(_playerDressTpl:getPic(frameTpl), false)
  self.bindComponents.img_FrameBg:LoadSprite(_playerDressTpl:getFramePic(frameTpl), false)
end

function this:setHeadPicByPlayId(data)
  self:setInfoByPlayerId(data.playerId, data.callback, data.isGetNewBaseInfo)
end

function this:setHeadPhoto(isRes, path)
  self:bumpRenderVersion("head")
  self:clearPainting("head")
  if isRes then
    if not string.isEmpty(path) then
      self:resetHeadImageState()
      self.bind.img_head = path
    else
      self.bind.active_head = false
    end
  else
    self.bindComponents.img_main:LoadPhoto(path)
  end
end

function this:setHeadPic(headPath)
  self:bumpRenderVersion("head")
  self:clearTexture()
  self:clearPainting("head")
  if not string.isEmpty(headPath) then
    self:resetHeadImageState()
    self.bind.img_head = headPath
  else
    self.bind.active_head = false
  end
end

function this:setFrame(framePath)
  self:bumpRenderVersion("frame")
  self:clearPainting("frame")
  if not string.isEmpty(framePath) then
    self:resetFrameImageState()
    self.bindComponents.img_Frame:LoadSprite(framePath, false)
  else
    self.bind.active_frame = false
  end
end

function this:setFrameBg(frameBgPath)
  self:bumpRenderVersion("frame")
  self:clearPainting("frame")
  if not string.isEmpty(frameBgPath) then
    self:resetFrameImageState()
    self.bindComponents.img_FrameBg:LoadSprite(frameBgPath, false)
  else
    self.bind.active_frameBg = false
  end
end

function this:setInfoByPlayerId(playerId, callback, isGetNewBaseInfo)
  local baseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
  self.gameObject:SetActive(true)
  if baseInfo == nil or isGetNewBaseInfo then
    local types = {
      L_Const.PlayerBasicQueryType.PBQT_ALL
    }
    local players = {}
    table.insert(players, playerId)
    L_FriendManager:requestBaseInfo(types, players, function()
      local baseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
      if self and L_CommonUtil.isValid(self.gameObject) then
        self:updateInfoByPlayerInfo(baseInfo)
      end
      if callback then
        callback(baseInfo)
      end
    end)
    return
  else
    self:updateInfoByPlayerInfo(baseInfo)
    if callback then
      callback(baseInfo)
    end
  end
end

function this:setInfoPlayerCardDressId(tplPlayerCardDressId)
  local _, frameId = L_PlayerDisplayStore:getDefaultFrame()
  self:setPreviewByDressIds(tplPlayerCardDressId, frameId, L_PlayerStore:getPlayerBaseInfo())
end

function this:updateInfoByPlayerInfo(baseInfo)
  if not baseInfo then
    return
  end
  self:setPreviewByDressIds(baseInfo.stand_plates.profile, baseInfo.stand_plates.profile_frame, baseInfo)
end

function this:setFrameActive(active)
  self.bind.active_frame = active
  self.bind.active_frameBg = active
end

function this:setDesaturate(active)
  self.bind.img_head_desaturate = active
  self.bind.img_frame_desaturate = active
  self.bind.img_frameBg_desaturate = active
end

function this:setMask(active, color)
  self.bind.active_mask1 = active
  self.bind.active_mask2 = active
  self.bind.active_mask3 = active
  if color then
    self.bind.color_mask1 = color
    self.bind.color_mask2 = color
    self.bind.color_mask3 = color
  end
end

function this:ShowSelf()
  local defaultFrame, defaultFrameId = L_PlayerDisplayStore:getDefaultFrame()
  local defaultHeadId = L_PlayerDisplayStore:getDefaultHead()
  local pendingHeadId = L_PlayerDisplayStore:getCurHead() or defaultHeadId or 0
  local pendingFrameId = L_PlayerDisplayStore:getCurHeadFrame() or defaultFrameId or 0
  local headId = pendingHeadId or defaultHeadId or 0
  local frameId = pendingFrameId or defaultFrameId or 0
  self:setPreviewByDressIds(headId, frameId, L_PlayerStore:getPlayerBaseInfo(), false)
end

function this:SetOnClickCallback(callback)
  self.onClickCallback = callback
end

function this:SetOnRefreshPlayerBaseInfo(callback)
  self.onRefreshPlayerBaseInfo = callback
end

function this:onEvent_refreshBaseInfo()
  if self.onRefreshPlayerBaseInfo then
    self.onRefreshPlayerBaseInfo()
  end
end

return this
