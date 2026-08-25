local social = require("ejoysdk_lua.social.ejoysdk_social")
local ioDirectory = CS.System.IO.Directory
local LuaCSharpUtil = CS.Z1Client.LuaCSharpUtil
local ShareComp, Super = System.NewClass("ShareComp", Component, IUpdater)

function ShareComp:ctor()
  Super.ctor(self)
end

function ShareComp:OpenShareSummonPanel(itemId, itemId2, afterCall, poolId, layer)
  itemId2 = itemId2 or 0
  local cfg = DT.Item[itemId]
  local cfg2 = DT.Item[itemId2]
  local uiUrl
  if cfg.Type == cd.ItemType.SkinItem then
    uiUrl = Urls.ShareOneSkinView
  elseif cfg2 and cfg2.Quality == CommonDefine.CommonQuality.Orange then
    if cfg.Type == cfg2.Type then
      uiUrl = cfg.Type == CommonDefine.ItemType.Weapon and Urls.ShareTwoWeaponView or Urls.ShareTwoAwakerView
    else
      uiUrl = Urls.ShareAwakerAndWeaponView
      if cfg.Type == cd.ItemType.Weapon and cfg2.Type == cd.ItemType.AwakerItem then
        itemId, itemId2 = itemId2, itemId
      end
    end
  else
    uiUrl = cfg.Type == CommonDefine.ItemType.Weapon and Urls.ShareOneWeaponView or Urls.ShareOneAwakerView
  end
  local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
  if cfg and cfg2 and poolCfg.Type == cd.SummonPoolType.LuckyBag then
    if cfg.Type == cd.ItemType.AwakerItem and cfg2.Type == cd.ItemType.Weapon then
      uiUrl = Urls.ShareAwakerAndWeaponView
    elseif cfg.Type == cd.ItemType.Weapon and cfg2.Type == cd.ItemType.AwakerItem then
      uiUrl = Urls.ShareAwakerAndWeaponView
      itemId, itemId2 = itemId2, itemId
    end
  end
  if uiUrl then
    UIManager.Instance:SetTempPanelLayer(uiUrl, UIDefine.LayerCfg.TopRoot.na)
    UIManager.Instance:Reopen(uiUrl, itemId, itemId2, poolId)
  end
  
  local function finishCaptureScreen(tex)
    UIManager.Instance:Reopen(Urls.ShareSummonView, itemId, tex)
    if afterCall then
      afterCall()
    end
    if uiUrl then
      UIManager.Instance:CloseByUrl(uiUrl)
    end
  end
  
  EventMgr.Instance.HideWhenCaptureScreen:Dispatch(false)
  self:CaptureScreen(finishCaptureScreen)
end

function ShareComp:OpenSharePlayerInfoPanel()
  UIManager.Instance:Show(Urls.UIMaskPanel)
  FrameWaiter.OnNextFrame(function()
    local function finishCaptureScreen(tex)
      UIManager.Instance:Reopen(Urls.SocialSharePlayerInfoPanel, tex)
      
      UIManager.Instance:CloseByUrl(Urls.UIMaskPanel)
    end
    
    EventMgr.Instance.HideWhenCaptureScreen:Dispatch(false)
    self:CaptureScreen(finishCaptureScreen)
  end, 1)
end

function ShareComp:CaptureScreen(call)
  EventMgr.Instance.ScreenCaptureEvent:Dispatch(1)
  
  local function back(tex)
    local newTex = self:ResizeTexture(tex)
    call(newTex)
    EventMgr.Instance.ScreenCaptureEvent:Dispatch(0)
  end
  
  LuaCSharpUtil.CaptureScreen(back)
end

function ShareComp:ResizeTexture(tex)
  local defaultW = UIRootMgr.GetBGImageWidth()
  local defaultH = UIRootMgr.GetBGImageHeight()
  local bgProportion = defaultW / defaultH
  local screenW = CS.UnityEngine.Screen.width
  local screenH = CS.UnityEngine.Screen.height
  local curProportion = screenW / screenH
  local uiRoot = CS.UnityEngine.GameObject.Find("UIRoot")
  local canvasScaler = uiRoot:GetComponent(typeof(CS.UnityEngine.UI.CanvasScaler))
  local referrenceProportion = canvasScaler.referenceResolution.x / canvasScaler.referenceResolution.y
  local safeArea = CS.UnityEngine.GameObject.Find("UIRoot/SafeArea")
  local rectTrans = safeArea:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local ratio = math.abs(rectTrans.rect.width / rectTrans.rect.height)
  local isMatchHeight = curProportion > referrenceProportion
  if isMatchHeight and bgProportion < curProportion then
    local newTexWidth = tex.height * ratio
    local x = (tex.width - newTexWidth) / 2
    tex = LuaCSharpUtil.ResizeTexture(tex, x, 0, newTexWidth, tex.height)
  elseif not isMatchHeight and curProportion < referrenceProportion then
    local newTexHeight = tex.width / ratio
    local y = (tex.height - newTexHeight) / 2
    tex = LuaCSharpUtil.ResizeTexture(tex, 0, y, tex.width, newTexHeight)
  end
  return tex
end

function ShareComp:SaveTex_2_PersistentData(tex)
  local persistentDataPath = Utils.GetApplicationPersistenDataPath()
  local directoryPath = persistentDataPath .. "/Share/ScreenShot"
  local savePath = string.format("%s/%s.png", directoryPath, TimeUtils.GetServerTime())
  if not ioDirectory.Exists(directoryPath) then
    ioDirectory.CreateDirectory(directoryPath)
  end
  LuaCSharpUtil.SaveTexture(tex, savePath)
  return savePath
end

function ShareComp:SaveTex_2_PhoneAlbum(tex)
  local name = string.format("%s.png", TimeUtils.GetServerTime())
  local result = LuaCSharpUtil.SaveTexture2Album(tex, name)
  Logger.Info("SaveTex_2_PhoneAlbum result : %s, name : %s", result, name)
  local tipsId = 1 == result and 10723 or 10724
  Alert.Show(tipsId)
end

function ShareComp:ShareTwitter(message, tex)
  if not SdkMgr.Instance:IsSdkLogin() then
    Alert.ShowStr("没有启用SDK,接口无效")
    return
  end
  local platform = social.SHARE_PLATFORM.twitter_share_timeline
  local support = social.is_support(platform)
  if not support then
    Logger.Warn("ShareTwitter not support")
    Alert.Show(10715)
    return false
  end
  local texPath = self:SaveTex_2_PersistentData(tex)
  local param = {
    message = message,
    media = {
      {type = "image_url", data = texPath}
    }
  }
  social.share(platform, param, function(succ, ...)
    if succ then
      Logger.Info("ShareTwitter success, texName : %s", texPath)
      return true
    else
      local code, msg = ...
      Logger.Info("ShareTwitter fail, texPath : %s, code : %s, msg : %s", texPath, tostring(code), tostring(msg))
      return false
    end
  end)
end

function ShareComp:ShareTwitterBySystemShare(message)
  local param = {
    message = message,
    ios_white_list = {"twitter"},
    package_name = "com.twitter.android",
    package_activity_name = "com.twitter.composer.ComposerActivity"
  }
  social.share(social.SHARE_PLATFORM.system_share, param, function(succ, ...)
    if succ then
      Logger.Info("ShareTwitterBySystemShare success, message : %s", message)
    else
      Logger.Info("ShareTwitterBySystemShare fail, message : %s", message)
    end
  end)
end

function ShareComp:SystemShare(message)
  local param = {message = message}
  social.share(social.SHARE_PLATFORM.system_share, param, function(succ, ...)
    if succ then
      Logger.ReportApusInfo("SystemShare success, message : %s", message)
    else
      Logger.ReportApusInfo("SystemShare fail, message : %s", message)
    end
  end)
end

function ShareComp:ShareFaceBook(message, tex)
  if not SdkMgr.Instance:IsSdkLogin() then
    Alert.ShowStr("没有启用SDK,接口无效")
    return
  end
  local platform = social.SHARE_PLATFORM.facebook_share_timeline
  local support = social.is_support(platform)
  if not support then
    Logger.Warn("ShareFaceBook not support")
    Alert.Show(10715)
    return false
  end
  local texPath = self:SaveTex_2_PersistentData(tex)
  local param = {
    message = message,
    media = {
      {type = "image_url", data = texPath}
    }
  }
  social.share(platform, param, function(succ, ...)
    if succ then
      Logger.Info("ShareFaceBook success, texName : %s", texPath)
      return true
    else
      local code, msg = ...
      Logger.Info("ShareFaceBook fail, texPath : %s, code : %s, msg : %s", texPath, tostring(code), tostring(msg))
      return false
    end
  end)
end

function ShareComp:ShareLine(message, tex)
  if not SdkMgr.Instance:IsSdkLogin() then
    Alert.ShowStr("没有启用SDK,接口无效")
    return
  end
  local platform = social.SHARE_PLATFORM.line_share_messenger
  local support = social.is_support(platform)
  if not support then
    Logger.Warn("ShareLine not support")
    Alert.Show(10715)
    return false
  end
  local texPath = self:SaveTex_2_PersistentData(tex)
  local param = {
    message = message,
    media = {
      {type = "image_url", data = texPath}
    }
  }
  social.share(platform, param, function(succ, ...)
    if succ then
      Logger.Info("ShareLine success, texName : %s", texPath)
      return true
    else
      local code, msg = ...
      Logger.Info("ShareLine fail, texPath : %s, code : %s, msg : %s", texPath, tostring(code), tostring(msg))
      return false
    end
  end)
end

function ShareComp:ShareSystem(message, tex)
  local platform = social.SHARE_PLATFORM.system_share
  local support = social.is_support(platform)
  if not support then
    Logger.Warn("ShareSystem not support")
    return false
  end
  local texPath = self:SaveTex_2_PersistentData(tex)
  local param = {
    message = message,
    media = {
      {type = "image_url", data = texPath}
    }
  }
  social.share(platform, param, function(succ, ...)
    if succ then
      Logger.Info("ShareSystem success, texName : %s", texPath)
      return true
    else
      local code, msg = ...
      Logger.Info("ShareSystem fail, texPath : %s, code : %s, msg : %s", texPath, tostring(code), tostring(msg))
      return false
    end
  end)
end

return ShareComp
