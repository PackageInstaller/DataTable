local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local PU = require("Common/PlatformUtil")
local Msdk = CS.Msdk
local m_imagePath, m_config, m_fromWindow
local m_writeStatus = true
local m_readStatus = true
local m_waitFlames = 0
local m_socialPlatform, m_shareWidgets
local m_file = "Share/"
local m_shareActorId = 0

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonWXFriend, OnShareWXFriendClick)
  WU.BindButtonEvent(REF.ButtonWXZone, OnShareWXZoneClick)
  WU.BindButtonEvent(REF.ButtonQQFriend, OnShareQQFriedClick)
  WU.BindButtonEvent(REF.ButtonQQZone, OnShareQQZoneClick)
  m_imagePath = CS.ResourceManager.Instance.SharePath .. "/screencapture.png"
  m_writeStatus = CS.NativeInterface.External_CheckPermission("android.permission.WRITE_EXTERNAL_STORAGE")
  m_readStatus = CS.NativeInterface.External_CheckPermission("android.permission.READ_EXTERNAL_STORAGE")
  local accountCache = this:GetData("accountCache")
  m_socialPlatform = accountCache.socialPlatform
  if accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ then
    REF.QQ.gameObject:SetActive(true)
    REF.WeiXin.gameObject:SetActive(false)
  elseif accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
    REF.QQ.gameObject:SetActive(false)
    REF.WeiXin.gameObject:SetActive(true)
  end
end

function InitWindow()
  m_shareActorId = 0
  REF.BottomBar["$Show"]()
  CS.GameGlobal.Instance.ShowClickEffect = false
  this:Bind("fci/baseinfo/", OnPlayerInfoChange)
  this:Bind("ShareConfig", OnShareConfigChange)
end

function UninitWindow()
  WU.ToggleTopBar(m_fromWindow, true)
  REF.BottomBar["$Hide"]()
  CS.GameGlobal.Instance.ShowClickEffect = true
  this:Unbind("fci/baseinfo/", OnPlayerInfoChange)
end

function OnPlayerInfoChange(baseInfo)
  if baseInfo then
    AU.SetPlayerName(REF.LabelName, this:GetData("accountCache"), baseInfo)
    REF.LabelLevel.UILabel.text = WU.GetString("Window_Level", baseInfo.level)
    REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](baseInfo)
  end
end

function OnShareWXFriendClick()
  ShareWeiXin(Msdk.eWechatScene.WechatScene_Session, "MSG_SHARE_FRIEND_HIGH_SCORE")
end

function OnShareWXZoneClick()
  ShareWeiXin(Msdk.eWechatScene.WechatScene_Timeline, "MSG_SHARE_MOMENT_HIGH_SCORE")
end

function OnShareQQFriedClick()
  ShareQQ(Msdk.eQQScene.QQScene_Session)
end

function OnShareQQZoneClick()
  ShareQQ(Msdk.eQQScene.QQScene_QZone)
end

function ShareWeiXin(scene, mediaTag, onComplete)
  local isWXInstalled = Msdk.WGPlatform.Instance:WGIsPlatformInstalled(Msdk.ePlatform.ePlatform_Weixin)
  if not isWXInstalled then
    WU.ShowMessageOK(WU.GetString("Platform_WXNotInstalled"))
    return
  end
  if not m_writeStatus or not m_readStatus then
    WU.ShowMessageOK(WU.GetString("Platform_CheckStoragePermission"))
    return
  end
  WU.ToggleRendering(REF.BottomBar, false)
  this:DelayInvokeEndOfFrame(function()
    local jump = "WECHAT_SNS_JUMP_URL"
    if m_shareActorId == 0 then
      m_shareActorId = this:GetData("ShareActorId")
    end
    if m_shareActorId and 0 < m_shareActorId then
      local info = PB.get("ShareActor", m_shareActorId)
      if info then
        jump = string.format("MESSAGE_ACTION_JUMP_H5_1#scene_id=%d", info.wxSceneID)
      end
    end
    CaptureScreenAndSend("Weixin", scene, mediaTag, jump)
  end)
end

function ShareQQ(scene, onComplete)
  local isQQInstalled = Msdk.WGPlatform.Instance:WGIsPlatformInstalled(Msdk.ePlatform.ePlatform_QQ)
  if not isQQInstalled then
    WU.ShowMessageOK(WU.GetString("Platform_QQNotInstalled"))
    return
  end
  if not m_writeStatus or not m_readStatus then
    WU.ShowMessageOK(WU.GetString("Platform_CheckStoragePermission"))
    return
  end
  WU.ToggleRendering(REF.BottomBar, false)
  CaptureScreenAndSend("QQ", scene)
end

function SetShareActorId(id)
  m_shareActorId = id
end

function CaptureScreenAndSend(type, scene, mediaTag, jump)
  if m_config.shareName == "CollectionsActor" then
    local bytes
    local ref = REF.ShareContent[0]
    ref["$$SetSharePicture"]()
    this:DelayInvokeEndOfFrame(function()
      CS.GameUtility.ScreenCaptureBig(3400, m_imagePath)
      SendContentToTarget(type, m_imagePath, scene, mediaTag, jump)
    end)
  else
    this:DelayInvokeEndOfFrame(function()
      CS.GameUtility.ScreenCapture(m_imagePath)
      SendContentToTarget(type, m_imagePath, scene, mediaTag, jump)
    end)
  end
end

function SendContentToTarget(type, pathOrBytes, scene, mediaTag, jump)
  local path = pathOrBytes
  if type == "QQ" then
    Msdk.WGPlatform.Instance:WGSendToQQWithPhoto(scene, path)
  elseif type == "Weixin" then
    Msdk.WGPlatform.Instance:WGSendToWeixinWithPhotoPath(scene, mediaTag, path, "", jump)
  end
  WU.ToggleRendering(REF.BottomBar, true)
  WU.RecycleWindow(this)
end

function OnShareConfigChange(shareConfig)
  if shareConfig == nil then
    return
  end
  local shareName = shareConfig.shareName
  m_fromWindow = shareConfig.fromWindow
  m_waitFlames = 0
  if shareName == "CollectionsActor" then
    m_waitFlames = 10
  end
  ClearContentIfNeed(shareName)
  m_config = PB.get("ShareConfig", shareName)
  if m_config == nil then
    warning("ShareConfig.xlsx dont have config of shareName " .. shareName)
    m_config = PB.get("ShareConfig", "Default")
  end
  m_shareWidgets = BuildShareImage()
  SetLogoAndPlayer()
  SetButtonIfHave()
  WU.ToggleTopBar(m_fromWindow, false)
  if m_fromWindow ~= "ArmDetail" then
    REF.Effect.EffectGenerator:Play()
  end
  WU.SetActive(REF.TopRightInfo, not shareConfig.disableTopRight)
end

function SetLogoAndPlayer()
  WU.SetActive(REF.LogoInfo, not m_config.isHideLogoAndPlayer)
  WU.SetActive(REF.PlayerInfo, not m_config.isHideLogoAndPlayer)
  if m_config.isHideLogoAndPlayer then
    return
  end
  local defaultConfig = PB.get("ShareConfig", "Default")
  local ref = _ENV["$"](REF.PlayerInfo)
  ref.SpriteBG.gameObject:SetActive(true)
  local playerBg = fif(m_config.playerBg == "" or m_config.playerBg == nil, defaultConfig.playerBg, m_config.playerBg)
  local pBgColor, pLabelColor
  if playerBg == "black" then
    pBgColor = CS.NGUIMath.HexToColor(522731571)
    pLabelColor = CS.NGUIMath.HexToColor(4294967295)
  elseif playerBg == "transparent" then
    pBgColor = CS.NGUIMath.HexToColor(4294967040)
    pLabelColor = CS.NGUIMath.HexToColor(995593215)
  elseif playerBg == "white" then
    pBgColor = CS.NGUIMath.HexToColor(4294967244)
    pLabelColor = CS.NGUIMath.HexToColor(995593215)
  end
  ref.SpriteBG.UISprite.color = pBgColor
  ref.LabelName.UILabel.color = pLabelColor
  ref.LabelLevel.UILabel.color = pLabelColor
  local playerPos
  local playerX = fif(m_config.playerX == 0 or m_config.playerX == nil, defaultConfig.playerX, m_config.playerX)
  local playerY = fif(m_config.playerY == 0 or m_config.playerY == nil, defaultConfig.playerY, m_config.playerY)
  local photoPos = REF.WidgetIconPlayerHeadPhoto.transform.localPosition
  local photoPosX = 125
  local wg = Msdk.WGPlatform.Instance
  local installChannel = wg:WGGetChannelId()
  if m_socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ or PU.IsPrivilegeIgnore(installChannel) then
    playerX = -100
    REF.SpriteQR.gameObject:SetActive(false)
    photoPosX = -5
  end
  REF.WidgetIconPlayerHeadPhoto.transform.localPosition = CS.UnityEngine.Vector3(photoPosX, photoPos.y, 0)
  ref["$transform"].localPosition = CS.UnityEngine.Vector3(playerX, playerY, 0)
  ref = _ENV["$"](REF.LogoInfo)
  local logoColor = fif(m_config.logoColor == "" or m_config.logoColor == nil, defaultConfig.logoColor, m_config.logoColor)
  ref.SpriteLogo.UISprite.spriteName = "logo_" .. logoColor
  local logoX = fif(m_config.logoX == 0 or m_config.logoX == nil, defaultConfig.logoX, m_config.logoX)
  local logoY = fif(m_config.logoY == 0 or m_config.logoY == nil, defaultConfig.logoY, m_config.logoY)
  ref["$transform"].localPosition = CS.UnityEngine.Vector3(logoX, logoY, 0)
end

function SetButtonIfHave()
  if m_config.shareName == "GachaResult" or m_config.shareName == "CollectionsActor" then
    REF.ButtonEdit.gameObject:SetActive(true)
    WU.BindButtonEvent(REF.ButtonEdit, OnResultEdit)
  else
    REF.ButtonEdit.gameObject:SetActive(false)
  end
end

function ClearContentIfNeed(shareName)
  if shareName and m_shareWidgets then
    WU.RemoveAllChild(REF.ShareContent)
    for i = 1, #m_shareWidgets do
      m_shareWidgets[i] = nil
    end
    m_shareWidgets = nil
  end
end

function BuildShareImage()
  if not m_config.isDynamicContent then
    return
  end
  local widgets = {}
  local prefabs = m_config.widgets
  for i = 1, #prefabs do
    local widget = REF.ShareContent.transform:Find(prefabs[i])
    if widget == nil then
      local prefabsPath = m_file .. prefabs[i]
      widget = _ENV["$"](WU.InstantiateWindowPrefab(REF.ShareContent, prefabsPath))
      WU.HandleGameObjectAttached(widget["$gameObject"])
    else
      widget = _ENV["$"](widget)
    end
    if i ~= 1 then
      widget["$gameObject"]:SetActive(false)
    end
    table.insert(widgets, widget)
  end
  if widgets[1]["$$SetShareInfo"] then
    local data = DB:GetData("Share/" .. m_config.shareName)
    widgets[1]["$$SetShareInfo"](data)
  end
  return widgets
end

function OnResultEdit()
  WU.AcquireWindowAsync("ItemPick", function(window)
    local shareInfo = DB:GetData("Share/" .. m_config.shareName)
    local selectedActors = DB:GetData("Share/SelectedActors")
    _ENV["$"](window)["$$SetEditInfo"](shareInfo.actorList, shareInfo.count, selectedActors, m_config.shareName)
  end)
end
