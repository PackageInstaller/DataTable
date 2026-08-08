local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local IU = require("Common/ItemUtil")
local PU = require("Common/PlatformUtil")
local m_ownDays
local m_CountMaxChenkin = 4
local m_ProgressPixelBorder = 0
local m_ProgressPixelLength = 854 - 2 * m_ProgressPixelBorder
local m_GiftRemain = 4
local m_checkin, m_effectOn, m_updateProgressLaterForEffect, m_isWGChannel
local Msdk = CS.Msdk
local m_coroutine
local m_audioPlaying = false
local m_audioSource

function Start()
  WU.BindButtonEvent(REF.Treasure, OnTreasureClick)
  local resGifts = PB.all("SigninGift")
  for i = 1, m_CountMaxChenkin do
    local refBtn = REF.CheckinAccuGifts[i - 1]
    WU.BindButtonEvent(refBtn.root, OnBtnGiftClick)
    refBtn.Label.UILabel.text = WU.GetString("Window_Day", resGifts[i].days)
    local p = refBtn.root.transform.localPosition
    refBtn.root.transform.localPosition = CS.UnityEngine.Vector3(m_ProgressPixelBorder + (resGifts[i].days - 0) / (resGifts[m_CountMaxChenkin].days - 0) * m_ProgressPixelLength, p.y, p.z)
  end
  local channel = Msdk.WGPlatform.Instance:WGGetChannelId()
  if PU.IsPrivilegeIgnore(channel) then
    m_isWGChannel = false
  else
    m_isWGChannel = true
  end
end

function OnEnable()
  m_checkin = false
  this:Bind("AccountSwitch", UpdateGameCenter)
  this:BindRemote(DB:GameRequest("fci/signin/"), OnSigninInfoChange)
  this:RegisterGameEvent("ShowEndEffect", OnShowEndEffect)
  m_effectOn = false
  m_updateProgressLaterForEffect = false
end

function OnDisable()
  if m_audioSource then
    m_audioSource:Stop()
    m_audioSource = nil
  end
  if m_coroutine then
    this:StopCoroutine(m_coroutine)
    m_audioPlaying = false
    m_coroutine = nil
  end
  this:Unbind("fci/signin/", OnSigninInfoChange)
  this:UnregisterGameEvent("ShowEndEffect", OnShowEndEffect)
end

function OnSigninInfoChange(checkinData)
  if m_checkin then
    m_checkin = false
    ShowCheckinEffect(checkinData)
  else
    SetCheckinUI(checkinData)
  end
end

function OnTreasureClick()
  if m_effectOn then
    return
  end
  if this:GetData("fci/signin/").signed then
    WU.ShowHintText(WU.GetString("Window_HaveSignedIn"))
  else
    m_checkin = true
    this:GameRequest("fci/signin/"):Post(nil, function(result)
      if result.signed then
        DBH.ResChange(result.resChange)
        this:SetData("fci/signin/", result)
        m_effectOn = true
      end
    end)
  end
end

function SetCheckinUI(checkinData)
  if checkinData == nil then
    return
  end
  local data = PB.get("NormalSignInTheme", checkinData.themeActivityId, checkinData.themeId)
  if data and checkinData.themeActivityId then
    REF.TextureActorPortrait.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. data.id .. "a"
    WU.SetActive(REF.BoardSpeechText, true)
    WU.ToggleRendering(REF.BoardSpeechText, false)
    REF.TextureActorPortrait.transform.localScale = CS.UnityEngine.Vector3(data.position.scale, data.position.scale, data.position.scale)
    REF.TextureActorPortrait.transform.localPosition = CS.UnityEngine.Vector3(data.position.Xoffset, data.position.Yoffset, REF.TextureActorPortrait.localPosition.z)
    local audioPath = data.voice
    local text = WU.GetString(data.actorText)
    WU.ClearButtonEvent(REF.TextureActorPortrait)
    if checkinData.themeActivityId ~= 0 then
      WU.BindButtonEvent(REF.TextureActorPortrait, function()
        PlayAudio(audioPath, text)
      end)
    else
      WU.SetActive(REF.BoardSpeechText, false)
    end
  else
    warning("Debug", "read data fail ActivityID:" .. checkinData.themeActivityId .. " , ID:" .. checkinData.themeId)
    REF.TextureActorPortrait.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_10072a"
    WU.SetActive(REF.BoardSpeechText, false)
    WU.ClearButtonEvent(REF.TextureActorPortrait)
  end
  m_GiftRemain = m_CountMaxChenkin
  local refTreasure = _ENV["$"](REF.Treasure)
  if checkinData.themeActivityId ~= 0 then
    REF.Effect_letter_A.EffectGenerator.m_EffectName = "UI_letter_A_1"
    REF.Effect_letter_B.EffectGenerator.m_EffectName = "UI_letter_B_1"
    REF.Effect_letter_C.EffectGenerator.m_EffectName = "UI_letter_C_1"
  end
  REF.Effect_letter_A.gameObject:SetActive(not checkinData.signed)
  REF.Effect_letter_star.gameObject:SetActive(not checkinData.signed)
  REF.Effect_letter_C.gameObject:SetActive(checkinData.signed)
  REF.Effect_letter_B.gameObject:SetActive(false)
  local resGifts = PB.all("SigninGift")
  m_ownDays = checkinData.days
  local len = 4
  if not m_updateProgressLaterForEffect then
    REF.CheckinAccuProgress.UIProgressBar.value = (m_ownDays - 0) / (resGifts[len].days - 0)
    for i = 1, #REF.CheckinAccuGifts do
      SetBtnGiftView(REF.CheckinAccuGifts[i - 1], resGifts[i])
    end
  end
end

function PlayAudio(audioPath, text)
  if not m_audioPlaying and audioPath ~= nil then
    REF.BoardSpeechText.UIHtmlLabel.text = text
    WU.ToggleRendering(REF.BoardSpeechText, true)
    m_audioSource = CS.SoundManager.Instance:PlaySound(audioPath)
    if m_audioSource then
      m_audioPlaying = true
      m_coroutine = this:DelayInvokeInSeconds(m_audioSource.clip.length, function()
        m_audioPlaying = false
        WU.ToggleRendering(REF.BoardSpeechText, false)
      end)
    else
      warning("debug", "AudioSource is nil:audioPath:" .. audioPath)
    end
  end
end

function ShowCheckinEffect(checkinData)
  local data = PB.get("NormalSignInTheme", checkinData.themeActivityId, checkinData.themeId)
  if data and checkinData.themeActivityId then
    PlayAudio(data.audioPath, WU.GetString(data.actorText))
  else
    warning("Debug", "read data fail ActivityID:" .. checkinData.themeActivityId .. " , ID:" .. checkinData.themeId)
    PlayAudio("Voice/emi/Emi00_1130_s", "")
  end
  REF.Effect_letter_A.gameObject:SetActive(false)
  REF.Effect_letter_C.gameObject:SetActive(false)
  REF.Effect_letter_B.gameObject:SetActive(true)
  this:DelayInvokeInSeconds(0.7, function()
    SetCheckinUI(checkinData)
  end)
  this:DelayInvokeInSeconds(1.4, function()
    WU.ShowRewards(checkinData.resChange, function()
      m_effectOn = false
    end)
  end)
end

function SetBtnGiftView(ref, giftInfo)
  ref["@giftInfo"] = giftInfo
  local giftsGot = this:GetData("fci/signin/").giftGot
  local isGiftGot = table.has(giftsGot, giftInfo.days)
  local canGetGift = m_ownDays >= giftInfo.days
  ref["@canGetGift"] = canGetGift
  ref["@isGiftGot"] = isGiftGot
  ref.Glow.gameObject:SetActive(canGetGift and not isGiftGot)
  WU.SetActive(ref.Icon, true)
  if isGiftGot then
    ref["$UIButton"].normalSprite = "mission/mission_close"
    m_GiftRemain = m_GiftRemain - 1
  elseif canGetGift then
    WU.SetActive(ref.Icon, false)
  else
    ref["$UIButton"].normalSprite = "mission/mission_open"
  end
end

function OnBtnGiftClick(go)
  if m_effectOn then
    return
  end
  local ref = _ENV["$"](go)
  local info = ref["@giftInfo"]
  if info == nil then
    error("Checkin", "ref userdata is nil")
    return
  end
  if ref["@canGetGift"] then
    if ref["@isGiftGot"] then
      local title
      if info.days ~= nil then
        title = WU.GetString("Window_SigninGiftTitle")
      else
        title = WU.GetString("Window_ActivePointRewardTitle")
      end
      local buttonTitle = WU.GetString("WindowGacha_Close")
      WU.AcquireWindowAsync("RewardPreview", function(ui)
        _ENV["$"](ui)["$$SetView"](info.reward, title, "", true, buttonTitle)
        for i, v in ipairs(info.reward) do
          if v.type == PB.enum.ResourceType.ResActor then
            _ENV["$"](ui)["$$SetCustomActorInfo"](v.id, info.quality)
          end
        end
      end)
    else
      this:GameRequest("fci/signin/gift/"):Post({
        days = info.days
      }, function(result)
        local callbackEffect
        if m_GiftRemain == 1 then
          m_updateProgressLaterForEffect = true
          
          function callbackEffect()
            this:BroadcastGameEvent("ShowEndEffect")
          end
          
          DB:SyncRemote(DB:GameRequest("fci/signin/"))
        else
          local all = this:GetData("fci/signin/")
          table.insert(all.giftGot, info.days)
          this:SetData("fci/signin/", all)
        end
        DBH.ResChange(result.resChange)
        WU.ShowRewards(result.resChange, callbackEffect)
      end)
    end
  else
    local title
    if info.days ~= nil then
      title = WU.GetString("Window_SigninGiftTitle")
    else
      title = WU.GetString("Window_ActivePointRewardTitle")
    end
    local content = WU.GetString("TaskActivePointRewardPreview", m_ownDays, info.targetActivePoint or info.days)
    WU.AcquireWindowAsync("RewardPreview", function(ui)
      _ENV["$"](ui)["$$SetView"](info.reward, title, content, false)
      for i, v in ipairs(info.reward) do
        if v.type == PB.enum.ResourceType.ResActor then
          _ENV["$"](ui)["$$SetCustomActorInfo"](v.id, v.quality)
        end
      end
    end)
  end
end

function OnShowEndEffect()
  local resGifts = PB.all("SigninGift")
  local smogTime = {}
  for i = 1, m_CountMaxChenkin do
    local refBtn = REF.CheckinAccuGifts[i - 1]
    local p = refBtn.root.transform.localPosition
    local time = 1.0 / m_ProgressPixelLength * (m_ProgressPixelLength - refBtn.root.transform.localPosition.x)
    table.insert(smogTime, time)
  end
  for i = m_CountMaxChenkin, 1, -1 do
    this:DelayInvokeInSeconds(smogTime[i], function()
      SetBtnGiftView(REF.CheckinAccuGifts[i - 1], resGifts[i])
      REF.CheckinAccuGifts[i - 1].EffectSmog.EffectGenerator:Play()
      WU.RestartTween(REF.CheckinAccuGifts[i - 1].Icon.TweenScale)
    end)
  end
  REF.EffectProgress.EffectGenerator:Play()
  REF.CheckinAccuProgress.UIProgressBar.value = 0
  m_updateProgressLaterForEffect = false
end

function UpdateGameCenter(accountSwitch)
  if accountSwitch == nil then
    return
  end
  local accountCache = this:GetData("accountCache")
  local data = DB:GetData("fci/gamecenter")
  local platform = accountCache.socialPlatform
  REF.CenterGrid.gameObject:SetActive(false)
  if data then
    local buffCnt = 0
    if platform == PB.enum.MSDKLoginPlatform.MSDK_QQ then
      buffCnt = CheckQQFlag(buffCnt)
    elseif platform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
      buffCnt = CheckWXFlag(buffCnt)
    end
    if 0 < buffCnt and m_isWGChannel then
      REF.CenterGrid.gameObject:SetActive(true)
      REF.CenterGrid.UIGrid:Reposition()
    end
  end
end

function CheckWXFlag(buffCnt)
  local misc = PB.all("Misc"):first()
  local accountCache = this:GetData("accountCache")
  local data = DB:GetData("fci/gamecenter")
  local switch = this:GetData("AccountSwitch")
  REF.GameCenter.gameObject:SetActive(false)
  REF.GameVip.gameObject:SetActive(false)
  if switch and switch.WXGameCenterPrivilege then
    local now = CS.GameTime.serverNow
    local loginTime = CS.GameTime.UtcToLocal(data.gamecenterLoginTime)
    local isLogin = now.Day == loginTime.Day
    REF.GameCenter.gameObject:SetActive(isLogin)
    REF.SpriteGameCenter.UISprite.spriteName = "login_wechat_game_icon"
    if isLogin then
      REF.LabelCoin.UILabel.text = "+" .. tostring(misc.gameCenterDSRewardCount)
      buffCnt = buffCnt + misc.gameCenterDSRewardCount
    end
  end
  return buffCnt
end

function CheckQQFlag(buffCnt)
  local misc = PB.all("Misc"):first()
  local accountCache = this:GetData("accountCache")
  local data = DB:GetData("fci/gamecenter")
  local switch = this:GetData("AccountSwitch")
  REF.GameCenter.gameObject:SetActive(false)
  REF.GameVip.gameObject:SetActive(false)
  if switch and switch.QQGameCenterPrivilege then
    local now = CS.GameTime.serverNow
    local loginTime = CS.GameTime.UtcToLocal(data.gamecenterLoginTime)
    local isLogin = now.Day == loginTime.Day
    REF.GameCenter.gameObject:SetActive(isLogin)
    REF.SpriteGameCenter.UISprite.spriteName = "login_qq_game_icon"
    if isLogin then
      REF.LabelCoin.UILabel.text = "+" .. tostring(misc.gameCenterDSRewardCount)
      buffCnt = buffCnt + misc.gameCenterDSRewardCount
    end
  end
  if switch and switch.QQVipPrivilege then
    local svip = data.qqvip & PB.enum.QQVIPFlag.VIP_SUPER
    if svip == PB.enum.QQVIPFlag.VIP_SUPER then
      buffCnt = buffCnt + misc.vipSuperDSRewardCount
      REF.GameVip.gameObject:SetActive(true)
      REF.LabelVipCoin.UILabel.text = "+" .. tostring(misc.vipSuperDSRewardCount)
    end
  end
  return buffCnt
end
