local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_configDataManager = S:Get("ConfigDataManager")

function Awake()
  WU.BindButtonEvent(REF.ButtonAgreement, OnUserProtocol)
  WU.BindButtonEvent(REF.ButtonProduction, OnClickCredits)
  CS.EventDelegate.Add(REF.TogglePayWithoutNotification.UIToggle.onChange, function()
    REF.InputPayLessThan.UIInput.enabled = CS.UIToggle.current.value
    REF.InputPayLessThan.BoxCollider2D.enabled = CS.UIToggle.current.value
    REF.InputPayLessThan.UISprite.graify = not CS.UIToggle.current.value
  end)
  local accountCache = this:GetData("accountCache")
  local platform = U.ToEnum(CS.Msdk.ePlatform, accountCache.socialPlatform)
  REF.WXReader.gameObject:SetActive(false)
  local url
  if platform == CS.Msdk.ePlatform.ePlatform_Weixin then
    REF.LabelWX.UILabel.text = WU.GetString("LocalVideo_WXReader")
    url = "fci/subscribe/0"
    CS.EventDelegate.Add(REF.ToggleWXReader.UIToggle.onChange, function()
      local enable = CS.UIToggle.current.value
      if enable then
        this:GameRequest(url):Post({opType = 0, platform = 0})
      else
        this:GameRequest(url):Post({opType = 1, platform = 0})
      end
    end)
  elseif platform == CS.Msdk.ePlatform.ePlatform_QQ then
    REF.LabelWX.UILabel.text = WU.GetString("LocalVideo_QQReader")
    url = "fci/subscribe/1"
    CS.EventDelegate.Add(REF.ToggleWXReader.UIToggle.onChange, function()
      local enable = CS.UIToggle.current.value
      if enable then
        this:GameRequest(url):Post({opType = 0, platform = 1})
      else
        this:GameRequest(url):Post({opType = 1, platform = 1})
      end
    end)
  end
  if url then
    this:GameRequest(url):Get(function(res)
      if res then
        REF.WXReader.gameObject:SetActive(true)
        REF.ToggleWXReader.UIToggle.value = res.isSubscribed
      end
    end)
  end
  CS.EventDelegate.Add(REF.InputPayLessThan.UIInput.onSubmit, function()
    local payLessThanNum = REF.InputPayLessThan.UIInput.value
    if payLessThanNum == nil or U.trim(payLessThanNum) == "" then
      return
    end
    if tonumber(payLessThanNum) <= 0 then
      return
    end
  end)
  WU.BindPressEvent(REF.UIUnloadTips, OnUIUnloadTipsClick)
  WU.BindPressEvent(REF.WXTips, OnWXTipsClick)
  WU.BindPressEvent(REF.AuraTips, OnAuraTipsClick)
  REF.ButtonPrivacyPolicy.gameObject:SetActive(true)
  REF.ButtonTermsofService.gameObject:SetActive(false)
  WU.BindButtonEvent(REF.ButtonPrivacyPolicy, onClickPrivacyGuide)
  REF.ButtonBottomGrid.UIGrid:Reposition()
end

function OnEnable()
  local preferences = m_configDataManager.GetPreferences()
  REF.ToggleUIUnload.UIToggle.value = preferences.memoryControl
  WU.ClearButtonEvent(REF.ToggleUIUnload)
  WU.BindButtonEvent(REF.ToggleUIUnload, function()
    WU.RecordButtonClick(100137021 .. fif(REF.ToggleUIUnload.UIToggle.value, 1, 0))
    if REF.ToggleUIUnload.UIToggle.value and not preferences.isDisableHD then
      WU.ShowMessageYesNo(WU.GetString("Setting_MemoryControl_Warining"), function(res)
        if res == "NO" then
          REF.ToggleUIUnload.UIToggle.value = false
        end
      end)
    end
  end)
  REF.ToggleAuraReader.UIToggle.value = preferences.auraHintControl
  REF.NoticeToggles.UIGrid:Reposition()
  REF.ToggleEnergyFull.UIToggle.value = preferences.energyFull or false
  REF.ToggleDispatchBack.UIToggle.value = preferences.dispatchBack or false
  REF.ToggleDrawEnergy.UIToggle.value = preferences.drawEnergy or false
  WU.BindButtonEvent(REF.ToggleAuraReader, function()
    WU.RecordButtonClick(100137022 .. fif(REF.ToggleAuraReader.UIToggle.value, 1, 0))
  end)
  WU.BindButtonEvent(REF.ToggleEnergyFull, function()
    WU.RecordButtonClick(100137023 .. fif(REF.ToggleEnergyFull.UIToggle.value, 1, 0))
  end)
  WU.BindButtonEvent(REF.ToggleDispatchBack, function()
    WU.RecordButtonClick(100137024 .. fif(REF.ToggleDispatchBack.UIToggle.value, 1, 0))
  end)
  WU.BindButtonEvent(REF.ToggleDrawEnergy, function()
    WU.RecordButtonClick(100137025 .. fif(REF.ToggleDrawEnergy.UIToggle.value, 1, 0))
  end)
end

function OnUserProtocol()
  WU.RecordButtonClick(1001370271)
  local url = PB.all("MsdkUrl")[1].UserProtocol
  if url == nil then
    warning("need fill url in table")
    return
  end
  WU.OpenUrl(url)
end

function OnClickCredits()
  WU.RecordButtonClick(1001370261)
  WU.AcquireWindowAsync("Credits")
end

function OnUIUnloadTipsClick(go, pressed)
  local title = WU.GetString("Account_UIUnload")
  local desc = WU.GetString("Account_UIUnload_Hint")
  if pressed then
    WU.ShowHoverTips(title, desc)
  else
    WU.HideHoverTips()
  end
end

function OnWXTipsClick(go, pressed)
  if pressed then
    local title, desc
    local accountCache = this:GetData("accountCache")
    local platform = U.ToEnum(CS.Msdk.ePlatform, accountCache.socialPlatform)
    if platform == CS.Msdk.ePlatform.ePlatform_Weixin then
      title = WU.GetString("LocalVideo_WXReader")
      desc = WU.GetString("Help_WXReader")
    else
      title = WU.GetString("LocalVideo_QQReader")
      desc = WU.GetString("Help_QQReader")
    end
    WU.ShowHoverTips(title, desc)
  else
    WU.HideHoverTips()
  end
end

function OnAuraTipsClick(go, pressed)
  local title = WU.GetString("Account_AuraHintControl")
  local desc = WU.GetString("Account_AuraHintControl_Hint")
  if pressed then
    WU.ShowHoverTips(title, desc)
  else
    WU.HideHoverTips()
  end
end

function onClickPrivacy()
  WU.RecordButtonClick(1001370281)
  local url = PB.all("MsdkUrl")[1].PrivacyPolicyUrl
  if url == nil then
    warning("need fill url in table")
    return
  end
  WU.OpenUrl(url)
end

function onClickPrivacyGuide()
  local url = PB.all("MsdkUrl")[1].PrivacyPolicyUrlGuide
  if url == nil then
    warning("need fill url in table")
    return
  end
  WU.OpenUrl(url)
end

function onClickServiceTerms()
  WU.RecordButtonClick(1001370291)
  local url = PB.all("MsdkUrl")[1].UserProtocolEnUrl
  if url == nil then
    warning("need fill url in table")
    return
  end
  WU.OpenUrl(url)
end
