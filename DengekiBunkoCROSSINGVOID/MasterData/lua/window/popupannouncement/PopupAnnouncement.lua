local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local S = require("Common/Singleton")
local m_configDataManager = S:Get("ConfigDataManager")
local m_is_check_dontshow = false
local m_visions_table = {}
local m_noticeData
local m_is_main_loaded = false
local m_is_detail_load = false
local m_on_close_callback

function SetupWindow()
  WU.BindButtonEvent(REF.Close, OnUIClose)
  WU.BindButtonEvent(REF.BtnCheckBox, OnCheckBoxClick)
  REF.DontshowLabel.UILabel.text = WU.GetString("Window_Disable_For_Today")
  ShowLoadingProgress()
  WU.BindButtonEvent(REF.clickSlot1, function()
    OnVisionClick(1)
  end)
  WU.BindButtonEvent(REF.clickSlot2_1, function()
    OnVisionClick(1)
  end)
  WU.BindButtonEvent(REF.clickSlot2_2, function()
    OnVisionClick(2)
  end)
  WU.BindButtonEvent(REF.clickSlot3_1, function()
    OnVisionClick(1)
  end)
  WU.BindButtonEvent(REF.clickSlot3_2, function()
    OnVisionClick(2)
  end)
  WU.BindButtonEvent(REF.clickSlot3_3, function()
    OnVisionClick(3)
  end)
  for i = 1, #REF.VisionMain do
    local view = REF.VisionMain[i - 1]
    view["$gameObject"]:SetActive(false)
  end
  this:RegisterGameEvent("OnWWWTextureSuccess", OnTextureLoad)
  this:RegisterGameEvent("OnWWWTextureFailure", OnTextureFailure)
end

function OnTextureLoad(url, tex2d)
  if m_noticeData and m_noticeData.mainImageFullScreen == url then
    m_is_main_loaded = true
    REF.VisionMain.UITexture.mainTexture = tex2d
    CheckAndTryDisplayAll()
  end
end

function OnTextureFailure(url)
  if m_noticeData and m_noticeData.mainImageFullScreen == url then
    m_is_main_loaded = false
  end
end

function ShowLoadingProgress()
  local sign = REF.Sign2
  sign.UISpriteAnimation.enabled = true
  local tween = sign.TweenAlpha
  tween.duration = 1 - sign.UISprite.alpha
  tween.from = sign.UISprite.alpha
  tween.to = 1
  WU.RestartTween(tween)
end

function CheckAndTryDisplayAll()
  if m_is_main_loaded then
    UpdateSubVisions()
    REF.VisionMain.gameObject:SetActive(true)
    REF.BtnCheckBox.gameObject:SetActive(true)
    REF.CloseBackground.gameObject:SetActive(true)
    this:SetData("hasShowAd", true)
    REF.Sign2.gameObject:SetActive(false)
  end
end

function SetNoticeData(noticeData)
  m_noticeData = noticeData
end

function ConsiderActiveTag(subItem)
  local curTime = CS.GameTime.serverUtc
  local activeTagSprite = "close"
  if subItem.preDatetime and curTime < subItem.preDatetime then
    return "soon_2"
  end
  if curTime < subItem.beginDatetime then
    activeTagSprite = "soon"
  elseif curTime < subItem.endDatetime then
    activeTagSprite = "open"
  end
  return activeTagSprite
end

function ConfigSubSlot(ref, item)
  local sprite = ConsiderActiveTag(item)
  ref.UISprite.spriteName = sprite
  ref.UISprite:MakePixelPerfect()
end

function UpdateSubVisions()
  if not m_noticeData then
    return
  end
  m_visions_table = m_noticeData.notices
  info("PopupAnnouncement", table.dump(m_visions_table))
  local subCount = #m_visions_table
  if subCount == 1 then
    REF.clickSlot1.gameObject:SetActive(true)
  elseif subCount == 2 then
    REF.clickSlot2_1.gameObject:SetActive(true)
    REF.clickSlot2_2.gameObject:SetActive(true)
    ConfigSubSlot(REF.clickSlot2_1, m_visions_table[1])
    ConfigSubSlot(REF.clickSlot2_2, m_visions_table[2])
  elseif subCount == 3 then
    REF.clickSlot3_1.gameObject:SetActive(true)
    REF.clickSlot3_2.gameObject:SetActive(true)
    REF.clickSlot3_3.gameObject:SetActive(true)
    ConfigSubSlot(REF.clickSlot3_1, m_visions_table[1])
    ConfigSubSlot(REF.clickSlot3_2, m_visions_table[2])
    ConfigSubSlot(REF.clickSlot3_3, m_visions_table[3])
  else
    error("Ad subItem count is not configured correctly, should be in [1,2,3] subCount=" .. subCount)
  end
end

function ShowNotice()
  if not m_noticeData then
    return
  end
  local noticeData = m_noticeData
  REF.CloseBackground.gameObject:SetActive(false)
  REF.Close.gameObject:SetActive(true)
  REF.BtnCheckBox.gameObject:SetActive(false)
  REF.VisionMain.gameObject:SetActive(false)
  DB:SetWWWTexture(noticeData.mainImageFullScreen)
end

function OnVisionClick(index)
  local item = m_visions_table[index]
  if item then
    local curTime = CS.GameTime.serverUtc
    if item.preDatetime and curTime < item.preDatetime then
      WU.ShowHintText(WU.GetString("Window_Activity_Before_Open"))
      return
    end
    if curTime > item.endDatetime then
      WU.ShowHintText(WU.GetString("Window_Activity_Close"))
      return
    end
    local accountCache = this:GetData("accountCache")
    local worldId = this:GetData("worldId")
    local jumpUrl = item.jumpUrl
    local isDirect = false
    if item.isDirect then
      isDirect = item.isDirect
    end
    this:GameRequest("fci/WebActivity"):Get(function(response)
      local activitiesString = "[]"
      if response.activities and #response.activities > 0 then
        activitiesString = "[" .. table.concat(response.activities, ",") .. "]"
      end
      local sns = "guest"
      local platform = accountCache.socialPlatform
      if platform then
        if platform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
          sns = "wx"
        elseif platform == PB.enum.MSDKLoginPlatform.MSDK_QQ then
          sns = "qq"
        end
      end
      local pushSessionId = CS.SceneCity.Instance:GetSessionId()
      if not isDirect then
        local contactUrl = jumpUrl
        if string.find(jumpUrl, "?") then
          contactUrl = jumpUrl .. "&"
        else
          contactUrl = jumpUrl .. "?"
        end
        local finalApi = string.format("/%sopenId=%s&session=%s&activityId=%s&sns=%s&worldId=%s&source=ad", contactUrl, accountCache.openId, pushSessionId, activitiesString, sns, worldId)
        CS.SceneBaseImpl.CurrentScene:OpenNotify(finalApi)
      else
        local contactUrl = jumpUrl
        if string.find(jumpUrl, "?") then
          contactUrl = jumpUrl .. "&"
        else
          contactUrl = jumpUrl .. "?"
        end
        local externalUrl = string.format("%sfci_openId=%s&fci_session=%s&fci_activityId=%s&fci_sns=%s&fci_worldId=%s&fci_source=ad", contactUrl, accountCache.openId, pushSessionId, activitiesString, sns, worldId)
        CS.SceneBaseImpl.CurrentScene:OpenUrlImpl(externalUrl)
      end
    end)
  end
end

function OnCheckBoxClick()
  if m_is_check_dontshow then
    m_is_check_dontshow = false
  else
    m_is_check_dontshow = true
  end
  local preferences = m_configDataManager.GetPreferences()
  preferences.disablePopupAnnouncement = _ENV["!"]({
    isDisable = m_is_check_dontshow,
    time = CS.GameTime.serverUtc,
    id = m_noticeData.id
  })
  UpdateCheckBox()
  m_configDataManager.SetPreferences(preferences)
end

function UpdateCheckBox()
  if m_is_check_dontshow then
    REF.BtnCheckBox.UISprite.spriteName = "selected"
  else
    REF.BtnCheckBox.UISprite.spriteName = "unchecked"
  end
end

function SetOnClose(callback)
  m_on_close_callback = callback
end

function OnUIClose()
  if REF.VisionMain.UITexture.mainTexture and m_is_main_loaded then
    CS.UnityEngine.GameObject.DestroyImmediate(REF.VisionMain.UITexture.mainTexture)
  end
  if m_on_close_callback then
    m_on_close_callback()
    m_on_close_callback = nil
  end
  WU.RecycleWindow(this)
end
