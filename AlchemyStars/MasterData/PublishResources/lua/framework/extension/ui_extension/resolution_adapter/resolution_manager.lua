local openSafeWide = true
local openFitMaxWidthHeight = true
local PIXELSIZE_BASEHEIGHT = 1080
local PIXELSIZE_BASEWIDTH = 1920
local MAX_WIDTH_HEIGHT_RATIO_W = 2539
local MAX_WIDTH_HEIGHT_RATIO_H = 1080
local MIN_WIDTH_HEIGHT_RATIO_W = 2732
local MIN_WIDTH_HEIGHT_RATIO_H = 2048
local FULL_SCREEN_ANCHOR_INFO = Vector4(0, 0, 1, 1)
_enum("ResolutionType", {Normal = "Normal", SafeWide = "SafeWide"})
_class("ResolutionManager", Object)
ResolutionManager = ResolutionManager
local BANG_WIDTH_KEY = "BangWidthKey"
local BANG_WIDTH_REGISTERED_KEY = "IsBangWidthRegisteredKey"
local NO_CASE = string.nocase
local SCREEN = UnityEngine.Screen
local EQUAL_IGNORE_CASE = string.equal_with_ignorecase
local SCREEN_STANDARDRATE = PIXELSIZE_BASEWIDTH / PIXELSIZE_BASEHEIGHT
local ANCHOR_MAX_WIDTH = MAX_WIDTH_HEIGHT_RATIO_W * (PIXELSIZE_BASEHEIGHT / MAX_WIDTH_HEIGHT_RATIO_H)
local ANCHOR_MAX_HEIGHT = MIN_WIDTH_HEIGHT_RATIO_H * (PIXELSIZE_BASEWIDTH / MIN_WIDTH_HEIGHT_RATIO_W)
local FIX_SAFEAREA_ANDROID_KEY = "FixSafeareaAndroidKey"
local MAX_SCREEN_CHANGE_SCALE = 1
local RuntimePlatform = UnityEngine.RuntimePlatform

function ResolutionManager:Constructor()
  Log.debug("[UIResolution] unity safearea:", SCREEN.safeArea, ", unity screen width:", SCREEN.width, ", height:", SCREEN.height)
  self.data = nil
  self.bOpenSafeWide = false
  self.bSafeWide = false
  self.safeWideWidthByConfig = 0
  self.blackWidth = 0
  self.blackHeight = 0
  self.permanentBlackSides = nil
  self.blackSideLeftRectTrans = nil
  self.blackSideRightRectTrans = nil
  self.blackSideTopRectTrans = nil
  self.blackSideBottomRectTrans = nil
end

function ResolutionManager:CalculateBlack()
  if not _G.APPVER1220 then
  end
  self = self or GameGlobal.ResolutionManager()
  if openFitMaxWidthHeight then
    local blackWidth = math.ceil((ResolutionManager.RealWidth() - ANCHOR_MAX_WIDTH) * 0.5)
    if blackWidth < 0 then
      blackWidth = 0
    end
    self.blackWidth = blackWidth
    local blackHeight = math.ceil((ResolutionManager.RealHeight() - ANCHOR_MAX_HEIGHT) * 0.5)
    if blackHeight < 0 then
      blackHeight = 0
    end
    self.blackHeight = blackHeight
    self:RefreshPermanentBlackSides()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIBlackChange)
  end
end

function ResolutionManager:Init()
  ResolutionManager.CalculateBlack(self)
  Log.debug("[UIResolution]realWidth=", ResolutionManager.RealWidth(), " realHeight=", ResolutionManager.RealHeight(), ",openFitMaxWidthHeight=", openFitMaxWidthHeight, ",blackWidth=", self.blackWidth, ",blackHeight=", self.blackHeight)
  self.data = Cfg.cfg_device_safe_area()
  self:SetResolution()
end

function ResolutionManager:InitAfterUI(uiRootGameObject)
  local permanentBlackSidesTrans = uiRootGameObject.transform:Find("UICameras/depth_top/UI/TopPanel/PermanentBlackSides")
  self.permanentBlackSides = permanentBlackSidesTrans.gameObject
  self.blackSideLeftRectTrans = permanentBlackSidesTrans:GetChild(0)
  self.blackSideRightRectTrans = permanentBlackSidesTrans:GetChild(1)
  self.blackSideTopRectTrans = permanentBlackSidesTrans:GetChild(2)
  self.blackSideBottomRectTrans = permanentBlackSidesTrans:GetChild(3)
  self:RefreshPermanentBlackSides()
end

function ResolutionManager.CalculateUIResolution()
  self = self or GameGlobal.ResolutionManager()
  local vector2 = Vector2(SCREEN.width, SCREEN.height)
  local scaleFactor = 0
  scaleFactor = Mathf.Min(vector2.x / PIXELSIZE_BASEWIDTH, vector2.y / PIXELSIZE_BASEHEIGHT)
  local sizeDelta = Vector2(SCREEN.width / scaleFactor, SCREEN.height / scaleFactor)
  local info = ResolutionManager.GeAnchorInfo(-1)
  local blackW = info.x * sizeDelta.x * 2
  local w = 0
  if sizeDelta.x - blackW < PIXELSIZE_BASEWIDTH then
    w = PIXELSIZE_BASEWIDTH + blackW
  else
    w = sizeDelta.x
  end
  self.canvasRefrenceWidth = w
  Log.info("[Resolution] Canvas默认宽度:", w)
end

function ResolutionManager:RefreshPermanentBlackSides()
  if not self.permanentBlackSides then
    return
  end
  if self.blackWidth == 0 and self.blackHeight == 0 then
    if _G.APPVER1220 then
      self.permanentBlackSides:SetActive(false)
    else
      self.permanentBlackSides:SetActive(true)
    end
  else
    self.permanentBlackSides:SetActive(true)
    self.blackSideLeftRectTrans.sizeDelta = Vector2(self.blackWidth, 0)
    self.blackSideRightRectTrans.sizeDelta = Vector2(self.blackWidth, 0)
    self.blackSideTopRectTrans.sizeDelta = Vector2(0, self.blackHeight)
    self.blackSideBottomRectTrans.sizeDelta = Vector2(0, self.blackHeight)
  end
end

function ResolutionManager.InvokeBangWidthChangedListeners(uiBangWidth)
  UIHelper.InvokeBangWidthChangeListeners(uiBangWidth)
end

function ResolutionManager.BangWidthLocalDBKey()
  return BANG_WIDTH_KEY, BANG_WIDTH_REGISTERED_KEY
end

function ResolutionManager.GeFullScreenAnchorInfo()
  local realWidth = ResolutionManager.RealWidth()
  local realHeight = ResolutionManager.RealHeight()
  local blackWidth = ResolutionManager.BlackWidth()
  local blackHeight = ResolutionManager.BlackHeight()
  local minY = blackHeight / realHeight
  local MaxY = 1 - minY
  local minX = blackWidth / realWidth
  local MaxX = 1 - minX
  local vec4 = Vector4(minX, minY, MaxX, MaxY)
  local depth_top = UnityEngine.GameObject.Find("depth_top")
  if depth_top then
    local depth_topTran = depth_top.transform
    local cameraTran = depth_topTran:Find("Camera")
    if cameraTran then
      local camera = cameraTran:GetComponent("Camera")
      if camera then
        if vec4 ~= FULL_SCREEN_ANCHOR_INFO then
          camera.enabled = true
        else
          camera.enabled = false
        end
      end
    end
  end
  return vec4
end

function ResolutionManager.GeAnchorInfo(curBangWidth)
  local realWidth = ResolutionManager.RealWidth()
  local realHeight = ResolutionManager.RealHeight()
  local blackWidth = ResolutionManager.BlackWidth()
  local blackHeight = ResolutionManager.BlackHeight()
  local minY = blackHeight / realHeight
  local MaxY = 1 - minY
  local bangWidth
  if curBangWidth and 0 <= curBangWidth then
    bangWidth = curBangWidth
  else
    bangWidth = ResolutionManager.BangWidth()
  end
  local vec4
  if blackWidth > bangWidth then
    local minX = blackWidth / realWidth
    local MaxX = 1 - minX
    vec4 = Vector4(minX, minY, MaxX, MaxY)
  else
    vec4 = ResolutionManager.GeAnchorInfoBySafeArea(curBangWidth)
    vec4.y = minY
    vec4.w = MaxY
  end
  local depth_top = UnityEngine.GameObject.Find("depth_top")
  if depth_top then
    local depth_topTran = depth_top.transform
    local cameraTran = depth_topTran:Find("Camera")
    if cameraTran then
      local camera = cameraTran:GetComponent("Camera")
      if camera then
        if vec4 ~= FULL_SCREEN_ANCHOR_INFO then
          camera.enabled = true
        else
          camera.enabled = false
        end
      end
    end
  end
  return vec4
end

function ResolutionManager.GeAnchorInfoBySafeArea(uiBangWidth)
  local x, y, w, h
  local realWidth = ResolutionManager.RealWidth()
  local realHeight = ResolutionManager.RealHeight()
  local bangWidth, byEngine
  if uiBangWidth and 0 <= uiBangWidth then
    bangWidth = uiBangWidth
  else
    bangWidth, byEngine = ResolutionManager.BangWidth()
  end
  if byEngine then
    if PLATFORM == RuntimePlatform.Android then
      realWidth = ResolutionManager.RealWidth()
      realHeight = ResolutionManager.RealHeight()
      x = bangWidth
      y = 0
      w = realWidth - x * 2
      h = realHeight
    else
      realWidth = ResolutionManager.ScreenWidth()
      realHeight = ResolutionManager.ScreenHeight()
      local safeArea = SCREEN.safeArea
      x = safeArea.x
      y = 0
      w = safeArea.width
      h = realHeight
    end
  elseif 0 <= bangWidth then
    x, y, w, h = ResolutionManager.GetSafeAreaByBang(bangWidth)
  end
  local vec4 = ResolutionManager.GeAnchorInfoBySafeAreaInternal(x, y, w, h, realWidth, realHeight)
  return vec4
end

function ResolutionManager.BangWidth()
  local isBangWidthRegistered = LocalDB.GetInt(BANG_WIDTH_REGISTERED_KEY)
  if 0 < isBangWidthRegistered then
    local w = LocalDB.GetInt(BANG_WIDTH_KEY)
    if 100 < w then
      w = 100
      Log.debug("[fx] w >100 old pakge reset")
      LocalDB.SetInt(BANG_WIDTH_KEY, 100)
    end
  end
  if ResolutionManager.TheResolutionType() ~= ResolutionType.SafeWide then
    return 0
  end
  if not _G.APPVER1220 then
  end
  if not ResolutionManager.SafeAreaExist() then
    return 0
  end
  if 0 < isBangWidthRegistered then
    local w = LocalDB.GetInt(BANG_WIDTH_KEY)
    local bangCanvasPixel = ResolutionManager.GetBangCanvasPixelWidthByPercent(w / 100)
    if bangCanvasPixel > ResolutionManager.ConfigBangWidth() then
      Log.debug("bangCanvasPixel2", bangCanvasPixel, "ConfigBangWidth", ResolutionManager.ConfigBangWidth())
      return ResolutionManager.ConfigBangWidth()
    end
    Log.debug("[UIResolution]Get Bang from Local DB ", w, " canvas pixel width ", bangCanvasPixel)
    return bangCanvasPixel
  end
  return ResolutionManager.ConfigBangWidth()
end

function ResolutionManager.GetBangCanvasPixelWidthByPercent(percent)
  return ResolutionManager.ConfigBangWidth() * percent
end

function ResolutionManager.SafeAreaExist()
  local lessBlack = ResolutionManager.CheckSafeWidthLessBlackWidth()
  if lessBlack then
    return false
  end
  return SCREEN.safeArea.width < SCREEN.width and SCREEN.width / SCREEN.height > SCREEN_STANDARDRATE
end

function ResolutionManager.CheckSafeWidthLessBlackWidth()
  if ResolutionManager.TheResolutionType() ~= ResolutionType.SafeWide then
    return false
  end
  local maxBangWidth = ResolutionManager.GetBangCanvasPixelWidthByPercent(1)
  local blackWidth = ResolutionManager.BlackWidth()
  if maxBangWidth <= blackWidth then
    return true
  end
  return false
end

function ResolutionManager.ConfigBangWidth()
  if not _G.APPVER1220 then
  end
  local res = 0
  if SCREEN.width / SCREEN.height <= SCREEN_STANDARDRATE then
    return res, true
  end
  local screenWidth = SCREEN.width
  local rate = ResolutionManager.RealWidth() / screenWidth
  local width = SCREEN.safeArea.width
  width = ResolutionManager.FixSafeAreaWidth()
  local w = (screenWidth - width) * rate
  if 0 < w then
    if PLATFORM == RuntimePlatform.IPhonePlayer then
      res = w * 0.5
    else
      res = w
    end
  end
  Log.debug("[UIResolution]Get Bang from Unity ", res)
  return res, true
end

function ResolutionManager.OldConfigBangWidth()
  local byEngine = false
  local realWidth = ResolutionManager.RealWidth()
  local safeWidth = ResolutionManager.SafeWideWidth()
  local res = 0
  local w = 0
  if safeWidth <= 0 then
    byEngine = true
    safeWidth = SCREEN.safeArea.width
    if PLATFORM == RuntimePlatform.Android then
      local screenWidth = ResolutionManager.ScreenWidth()
      local rate = realWidth / screenWidth
      w = (screenWidth - safeWidth) * rate
    else
      realWidth = ResolutionManager.ScreenWidth()
      w = realWidth - safeWidth
    end
  else
    w = realWidth - safeWidth
  end
  if 0 < w then
    if PLATFORM == RuntimePlatform.Android and byEngine then
      res = w
    else
      res = w * 0.5 * (ResolutionManager.RealWidth() / realWidth)
    end
  end
  if byEngine then
    Log.debug("[UIResolution]Get Bang from Unity ", res)
  else
    Log.debug("[UIResolution]Get Bang from Our Config ", res)
  end
  return res, byEngine
end

function ResolutionManager.FixSafeAreaWidth()
  if not IsAndroid() then
    return SCREEN.safeArea.width
  end
  if not SCREEN.safeArea.x == 0 then
    return SCREEN.safeArea.width
  end
  local localscale = LocalDB.GetFloat(FIX_SAFEAREA_ANDROID_KEY)
  if localscale == nil or localscale == 0 then
    localscale = SCREEN.safeArea.width / SCREEN.safeArea.height
    LocalDB.SetFloat(FIX_SAFEAREA_ANDROID_KEY, localscale)
  end
  if localscale ~= nil then
    local curScale = SCREEN.safeArea.width / SCREEN.safeArea.height
    if curScale ~= localscale then
      if math.abs(curScale - localscale) > MAX_SCREEN_CHANGE_SCALE then
        return SCREEN.safeArea.width
      end
      return SCREEN.safeArea.height * localscale
    end
  end
  return SCREEN.safeArea.width
end

function ResolutionManager.RealWidth()
  local screenRate = ResolutionManager.ScreenWidth() / ResolutionManager.ScreenHeight()
  if screenRate > SCREEN_STANDARDRATE then
    return PIXELSIZE_BASEHEIGHT * screenRate
  else
    return PIXELSIZE_BASEWIDTH
  end
end

function ResolutionManager.RealHeight()
  local screenRate = ResolutionManager.ScreenWidth() / ResolutionManager.ScreenHeight()
  if screenRate >= SCREEN_STANDARDRATE then
    return PIXELSIZE_BASEHEIGHT
  else
    return PIXELSIZE_BASEWIDTH / screenRate
  end
end

function ResolutionManager.ScreenWidth()
  return SCREEN.width
end

function ResolutionManager.ScreenHeight()
  return SCREEN.height
end

function ResolutionManager.BlackWidth()
  return GameGlobal.ResolutionManager().blackWidth
end

function ResolutionManager.BlackHeight()
  return GameGlobal.ResolutionManager().blackHeight
end

function ResolutionManager.BaseWidth()
  return PIXELSIZE_BASEWIDTH
end

function ResolutionManager.BaseHeight()
  return PIXELSIZE_BASEHEIGHT
end

function ResolutionManager.SafeWideWidth()
  local resolutionMng = GameGlobal.ResolutionManager()
  if resolutionMng.bOpenSafeWide then
    if resolutionMng.bSafeWide then
      Log.debug("[UIResolution]current device is safewide type！")
    end
  else
    Log.debug("[UIResolution]safewide type is not open！")
  end
  return resolutionMng.safeWideWidthByConfig
end

function ResolutionManager:SetResolution()
  if openSafeWide then
    local deviceModel = UIHelper.GetDeviceModel()
    Log.debug("[UIResolution]ResolutionManager:SetResolution, ", deviceModel)
    local nowSafeAreaWidth = -1
    for deviceName, device in next, self.data, nil do
      if EQUAL_IGNORE_CASE(deviceName, deviceModel) then
        nowSafeAreaWidth = device.safeWidth
        break
      end
    end
    if nowSafeAreaWidth ~= -1 then
      Log.debug("[UIResolution]ResolutionManager:SetResolution, nowSafeAreaWidth ", nowSafeAreaWidth)
      self:SetDeviceReslutionInfo(true, nowSafeAreaWidth, true)
    else
      self:SetDeviceReslutionInfo(true, 0, false)
    end
  else
    self:SetDeviceReslutionInfo(false, 0, false)
  end
end

function ResolutionManager:SetDeviceReslutionInfo(bOpenSafeWide, safeWideWidth, bSafeWide)
  Log.debug("[UIResolution]ResolutionManager:SetDeviceReslutionInfo, bOpenSafeWide= ", bOpenSafeWide, ", safeWideWidth= ", safeWideWidth, ", bSafeWide= ", bSafeWide)
  self.bOpenSafeWide = bOpenSafeWide
  self.safeWideWidthByConfig = safeWideWidth
  self.bSafeWide = bSafeWide
end

function ResolutionManager.TheResolutionType()
  local resolutionMng = GameGlobal.ResolutionManager()
  if resolutionMng.bOpenSafeWide then
    return ResolutionType.SafeWide
  else
    return ResolutionType.Normal
  end
end

function ResolutionManager.GetSafeAreaByBang(bangWidth)
  local x, y, w, h = 0
  local insets = bangWidth
  if SCREEN.width > SCREEN.height then
    x = insets
    y = 0
  else
    x = 0
    y = insets
  end
  local realWidth = ResolutionManager.RealWidth()
  local realHeight = ResolutionManager.RealHeight()
  w = realWidth - x * 2
  h = realHeight - y * 2
  return x, y, w, h
end

function ResolutionManager.GeAnchorInfoBySafeAreaInternal(x, y, w, h, realWidth, realHeight)
  Log.debug("[UIResolution]New safe area applied : LeftBottom x=", x, " LeftBottom y=", y, " w=", w, " h=", h, " on full extents ScreenWidth=", ResolutionManager.ScreenWidth(), " ScreenHeight=", ResolutionManager.ScreenHeight(), [[
,
 RealWidth=]], realWidth, ", RealHeight=", realHeight)
  local anchorMinX = x / realWidth
  local anchorMinY = y / realHeight
  local anchorMaxX = (x + w) / realWidth
  local anchorMaxY = (y + h) / realHeight
  return Vector4(anchorMinX, anchorMinY, anchorMaxX, anchorMaxY)
end

function ResolutionManager.IsAspectOutofSupport()
  local aspect = ResolutionManager.ScreenWidth() / ResolutionManager.ScreenHeight()
  return aspect > MAX_WIDTH_HEIGHT_RATIO_W / MAX_WIDTH_HEIGHT_RATIO_H or aspect < MIN_WIDTH_HEIGHT_RATIO_W / MIN_WIDTH_HEIGHT_RATIO_H
end
