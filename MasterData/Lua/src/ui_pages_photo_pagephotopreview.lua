local this = class("pagePhotoPreview", G_UIPageBase)

function this.bind()
  return {
    active_imgPhotoGraph = true,
    active_imgVideo = false,
    activeImgPreview = false,
    activeMoviePreview = false,
    activeShowInfo = false,
    activeShowLogo = false,
    activeLogo = true,
    activeInfo = false,
    txt_playerName = "",
    txt_playerLevel = "",
    activeEdit = false,
    img_playerHead = ""
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_save = function(self)
      if self.rt then
        self:saveTexture()
      elseif not string.isEmpty(self.moviePath) then
        self:saveMovie()
      end
    end,
    onClick_edit = function(self)
      L_UI:open("pagePhotoEdit", {
        rt = self.tex,
        onEditComplete = handler(self, self.onEditComplete)
      })
    end,
    onValueChange_togInfo = function(self, isOn)
      self.m_savePath = ""
      self:showPlayerInfo(isOn)
    end,
    onValueChange_togLogo = function(self, isOn)
      self.m_savePath = ""
      self:showLogo(isOn)
    end
  }
end

function this:preOpen(options)
  options.goWhiteCut = false
  self.bindComponents.blur.enabled = true
  self.saveFlags = {}
  self.rt = options.rt
  self.moviePath = options.moviePath
  self.isFullScreen = options.isFullScreen
  self.lastScreenWidth = C_Screen.width
  self.lastScreenHeight = C_Screen.height
  local shares
  local isPhoto = false
  self.m_savePath = ""
  if self.rt then
    isPhoto = true
    local temp = self.rt:ToTexture2D()
    local ratio = temp.width / temp.height
    if 2.3333333333333335 < ratio then
      self.tex = C_CameraCaptureUtil.CropTextureToRatio(temp, 21, 9)
      temp:ReleaseTexture()
    else
      self.tex = temp
    end
    C_CameraCaptureUtil.SetAlphaOne(self.tex)
    self.bind.activeEdit = not options.isPhotoTask
    self:showImg()
    self.bind.activeShowInfo = not options.isPhotoTask
    self.bind.activeShowLogo = not options.isPhotoTask
    self:fitPhotoSize()
    C_UIMgr.changeAudioState(self.pageName, "")
    if C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
      C_MJSDKManager.GetShareList(CS.MJUnionSDK.MJSDKManager.ShareEnum.Image, function(result)
        self:_onShareListReady(result, isPhoto)
      end)
      return
    end
    shares = C_MJSDKManager.GetShareList(CS.MJUnionSDK.MJSDKManager.ShareEnum.Image)
  elseif not string.isEmpty(self.moviePath) then
    self.bind.activeEdit = false
    self.bind.activeShowInfo = false
    self.bind.activeShowLogo = false
    self:showMovie()
    C_UIMgr.changeAudioState(self.pageName, "PlayBack")
    if C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
      C_MJSDKManager.GetShareList(CS.MJUnionSDK.MJSDKManager.ShareEnum.Video, function(result)
        self:_onShareListReady(result, isPhoto)
      end)
      return
    end
    shares = C_MJSDKManager.GetShareList(CS.MJUnionSDK.MJSDKManager.ShareEnum.Video)
  end
  self:_onShareListReady(shares, isPhoto)
end

function this:_onShareListReady(shares, isPhoto)
  if self.isFullScreen then
  end
  local tpl = L_GameTpl:getAppLinkTpl()
  local matches = {}
  if CS.UnityEngine.Application.isEditor then
    matches = tpl:getAllTpl(isPhoto)
  else
    matches = {}
    if shares then
      for i = 1, shares.Count do
        local config = tpl:tryGetTplById(shares[i - 1], isPhoto)
        if config then
          table.insert(matches, config)
        end
      end
    end
  end
  if isPhoto then
    table.sort(matches, function(a, b)
      return a.appSort < b.appSort
    end)
  else
    table.sort(matches, function(a, b)
      return a.appSortMoive < b.appSortMoive
    end)
  end
  self:initShareButtons(matches, isPhoto)
end

function this:show()
  if self.isFullScreen then
  end
end

function this:update()
  local screenWidth = C_Screen.width
  local screenHeight = C_Screen.height
  if self.lastScreenWidth == screenWidth and self.lastScreenHeight == screenHeight then
    return
  end
  self.lastScreenWidth = screenWidth
  self.lastScreenHeight = screenHeight
  FrameScheduler.add(function()
    if self.isBind and self.tex then
      self:fitPhotoSize()
    end
  end, 1)
end

function this:showImg()
  self.bindComponents.imgPreview.texture = self.tex
  self.bind.activeImgPreview = true
  self.bind.active_imgPhotoGraph = true
  self.bind.active_imgVideo = false
  local mat = C_UnityObject.Instantiate(self.bindComponents.imgPreview.material)
  mat:EnableKeyword("FIX_TO_GAMMA")
  self.bindComponents.imgPreview.material = mat
  self.mat = mat
end

function this:initShareButtons(matches, isPhoto)
  local len = #matches
  local btn_share = self.bindComponents.btn_share
  if len < 1 then
    btn_share.gameObject:SetActive(false)
  else
    local p = btn_share.transform.parent
    local type_img = typeof(C_LImage)
    local shareBtns = {}
    local enumKey = isPhoto and CS.MJUnionSDK.MJSDKManager.ShareEnum.Image or CS.MJUnionSDK.MJSDKManager.ShareEnum.Video
    for i = 1, len do
      local config = matches[i]
      local btn = i == len and btn_share or C_GameObject.Instantiate(btn_share, p)
      local img = btn:GetComponentInChildren(type_img)
      img:LoadSprite(config.appIcon)
      btn.name = "share_button_" .. tostring(config.appId)
      btn.onClick:AddListener(function()
        if not self.m_savePath or self.m_savePath == "" then
          if isPhoto then
            self:saveTexture(function()
              self:_doShare(config.appId, enumKey)
            end)
          else
            self:saveMovie(function()
              self:_doShare(config.appId, enumKey)
            end)
          end
          return
        end
        self:_doShare(config.appId, enumKey)
      end)
      if i == len then
        btn.transform:SetAsLastSibling()
      end
      shareBtns[i] = btn
    end
    self.m_shareBtns = shareBtns
  end
end

function this:_doShare(channelId, enumKey)
  local isPlayerInfo = self.bind.activeInfo and 1 or 2
  CS.Lens.Gameplay.Managers.ShareManager.Share(channelId, enumKey, "", "", self.m_savePath, isPlayerInfo)
end

function this:saveTexture(completeCallback)
  local dir = CS.System.IO.Path.Combine(CS.UnityEngine.Application.persistentDataPath, "PHOTO_TEMP")
  local path = string.format("%s/photo_%s.png", dir, CS.System.DateTime.Now:ToString("yyMMddHHmmss"))
  
  local function callback(succ, galleryPath)
    printf(string.format("image share result :%s , galleryPath:%s", succ, galleryPath))
    if succ then
      if C_AppConfigManager.IsMobilePlatformForUI then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_address_mobile"))
      elseif L_PhotoManager.useHighResolution then
        L_FlyMsgManager:showNormalMsgByKey("notice_pagePhotoPreview_hero_01", {
          [0] = galleryPath or ""
        })
      else
        L_FlyMsgManager:showNormalMsgByKey("notice_photo_address", {
          [0] = galleryPath or ""
        })
      end
      self.m_savePath = path
      if completeCallback then
        completeCallback()
      end
    else
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_pagephotopreview_02"))
      printf("拍照保存失败" .. (galleryPath or ""))
    end
  end
  
  printf(string.format("image share path : %s", path))
  if self.bind.activeInfo or self.bind.activeLogo then
    local texture = self:saveWithRt()
    C_PhotoManager.SaveTexture2DToGallery(texture, path, callback)
  else
    C_PhotoManager.SaveTexture2DToGallery(self.tex, path, callback)
  end
end

function this:showMovie()
  self.bind.activeMoviePreview = true
  self.bind.active_imgPhotoGraph = false
  self.bind.active_imgVideo = true
  self.bindComponents.moviePlayer:PlayMovieByPath(self.moviePath, true)
  if C_AppConfigManager.Platform == C_EAppPlatform.IOS then
    local mat = C_UnityObject.Instantiate(self.bindComponents.VideoDisplay.material)
    mat:EnableKeyword("FIX_TO_GAMMA")
    self.bindComponents.VideoDisplay.material = mat
    self.mat = mat
  end
end

function this:saveMovie(callback)
  printf(string.format("movie share path : %s", self.moviePath))
  local path = "movie" .. CS.System.DateTime.Now:ToString("yyMMddHHmmss")
  C_PhotoManager.SaveVideoToGallery(self.moviePath, path, function(succ, galleryPath)
    printf(string.format("movie share result :%s , galleryPath:%s", succ, galleryPath))
    if succ then
      if C_AppConfigManager.IsMobilePlatformForUI then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_video_mobile_address"))
      else
        L_FlyMsgManager:showNormalMsgByKey("notice_video_pc_address", {
          [0] = galleryPath or ""
        })
      end
      self.m_savePath = self.moviePath
      if callback then
        callback()
      end
    else
      L_FlyMsgManager:showNormalMsgByKey("residual_code_pagephotopreview_02")
    end
  end)
end

function this:close()
  if self.rt then
    L_PhotoManager:releaseCaptureRT(self.rt)
  end
  if self.tex then
    self.tex:ReleaseTexture()
    self.tex = nil
  end
  if self.texCache then
    C_PhotoManager.ReleaseTexture(self.texCache)
    self.texCache = nil
  end
  if self.mat then
    C_UnityObject.Destroy(self.mat)
    self.mat = nil
  end
  if self.captureTex then
    self.captureTex:ReleaseTexture()
    self.captureTex = nil
  end
  if self.m_shareBtns then
    for i = 1, #self.m_shareBtns do
      self.m_shareBtns[i].onClick:RemoveAllListeners()
    end
    self.m_shareBtns = nil
  end
end

function this:fitPhotoSize()
  local width = self.tex.width
  local height = self.tex.height
  local containerSize = self.bindComponents.imgContainer.rect.size
  local ratio = width / height
  local targetWidth, targetHeight
  if ratio < containerSize.x / containerSize.y then
    targetHeight = containerSize.y
    targetWidth = targetHeight * ratio
  else
    targetWidth = containerSize.x
    targetHeight = targetWidth / ratio
  end
  local size = C_Vector2(targetWidth, targetHeight)
  self.bindComponents.imgRect.sizeDelta = size
  if targetWidth < targetHeight then
    local logoScale = targetWidth / targetHeight
    logoScale = math.max(0.5, logoScale)
    self.bindComponents.logoRect.localScale = C_Vector3(logoScale, logoScale, 1)
    self.bindComponents.playerInfoRect.localScale = C_Vector3(logoScale, logoScale, 1)
  else
    self.bindComponents.logoRect.localScale = C_Vector3(1, 1, 1)
    self.bindComponents.playerInfoRect.localScale = C_Vector3(1, 1, 1)
  end
end

function this:showLogo(isOn)
  self.bind.activeLogo = isOn
end

function this:showPlayerInfo(isOn)
  self.bind.activeInfo = isOn
  if isOn then
    self:initPlayerInfo()
  end
end

function this:initPlayerInfo()
  local baseInfo = L_PlayerStore:getPlayerBaseInfo()
  L_PlayerDisplayStore:loadHeadPic(baseInfo, function(iconStr, tex)
    if iconStr then
      self.bind.img_playerHead = iconStr
    elseif tex and not self:setHeadSprite(tex) then
      C_PhotoManager.ReleaseTexture(tex)
    end
  end)
  self.bind.txt_playerName = L_PlayerStore:getPlayerName()
  self.bind.txt_playerLevel = "UID:" .. tostring(L_PlayerStore:getPlayerId())
end

function this:setHeadSprite(tex)
  if self.texCache then
    C_PhotoManager.ReleaseTexture(self.texCache)
    self.texCache = nil
  end
  if self.bindComponents.img_texIconHeroS ~= nil and tex ~= nil then
    self.bind.img_playerHead = ""
    local rect = C_Rect(0, 0, tex.width, tex.height)
    local pivot = C_Vector2.one * 0.5
    self.bindComponents.img_texIconHeroS.sprite = Unity.Sprite.Create(tex, rect, pivot)
    self.texCache = tex
    return true
  end
  return false
end

function this:initCaptureCanvas()
  local canvas = L_ResPool:syncGameObject("Program/UIScene/pre_UICaptureCanvas.prefab", C_LuaUtility.GetRootNode())
  self.captureCanvas = canvas
  L_Vector3.setPos(canvas.transform, C_UIMgr.SceneLoadDefaultPosition)
  local cam = canvas.transform:Find("UICaptureCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
  self.cam = cam
end

function this:copyRoot()
  local targetSize = C_Vector2(self.tex.width, self.tex.height)
  local curSize = self.bindComponents.imgRect.sizeDelta
  local scale = C_Vector3(targetSize.x / curSize.x, targetSize.y / curSize.y, 1)
  local newRoot = CS.Lens.Framework.AzurAssets.Instantiate(self.bindComponents.imgPreview.gameObject, false, self.captureCanvas.transform).Result
  newRoot.transform.localPosition = C_Vector3.zero
  newRoot.transform.localScale = scale
end

function this:saveWithRt()
  self:initCaptureCanvas()
  self:copyRoot()
  local camRt = L_PhotoManager:newCaptureRT(self.tex.width, self.tex.height)
  Unity.Rendering.Azur._2D.Utilities.ScreenCaptureHelper.RegistCaptureCamera(self.cam)
  self.cam.targetTexture = camRt
  self.cam:Render()
  if self.captureTex then
    self.captureTex:ReleaseTexture()
  end
  self.captureTex = C_CameraCaptureUtil.GetTextureFromRT(self.cam.targetTexture)
  Unity.Rendering.Azur._2D.Utilities.ScreenCaptureHelper.UnregistCaptureCamera(self.cam)
  C_CameraCaptureUtil.SetAlphaOne(self.captureTex)
  if self.captureCanvas then
    C_BoundGameObject.Destroy(self.captureCanvas)
  end
  L_PhotoManager:releaseCaptureRT(camRt)
  return self.captureTex
end

function this:addSaveFlag()
  local f = self:getSaveFlag()
  if f then
    self.saveFlags[f] = true
  end
end

function this:getSaveFlag()
  local f
  local isPlayerInfo = self.bind.activeInfo
  local isLogo = self.bind.activeLogo
  if isPlayerInfo and isLogo then
    f = 3
  elseif not isPlayerInfo and not isLogo then
    f = 0
  elseif isPlayerInfo then
    f = 1
  elseif isLogo then
    f = 2
  end
  if f then
    return f
  end
end

function this:onEditComplete(tex)
  if self.tex then
    self.tex:ReleaseTexture()
    self.tex = nil
  end
  self.tex = tex
  self.bindComponents.imgPreview.texture = self.tex
  self:fitPhotoSize()
  self.m_savePath = ""
  self.saveFlags = {}
end

return this
