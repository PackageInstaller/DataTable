local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local DBH = require("Manager/DataBindingHandler")
local m_giftRecords, m_inviteeList, m_shareOn, m_hasInvitedAll, m_isInit, m_oldSortOrder, m_stBusy

function SetupWindow()
  WU.TraverseChildren(REF.ActorPortraits, function(go)
    WU.BindButtonEvent(_ENV["$"](go).root, OnPoritraitClick)
  end)
  WU.TraverseChildren(REF.Gifts, function(go)
    WU.BindButtonEvent(_ENV["$"](go).root, OnGiftClick)
  end)
  WU.BindButtonEvent(REF.BtnInvite, function()
    if m_stBusy then
      return
    end
    WU.AcquireWindowAsync("ChristmasPartyInvite")
  end)
  WU.BindButtonEvent(REF.BtnInviteResult, OnBtnInviteResultClick)
  WU.BindButtonEvent(REF.BtnShare, OnBtnShareClick)
  WU.BindButtonEvent(REF.BtnSave, OnBtnSaveClick)
end

function InitWindow()
  ResetUI()
  this:RegisterGameEvent("ChristmasParty/OnScreenshotSuccess", OnScreenshotSuccess)
  this:RegisterGameEvent("ChristmasParty/OnScreenshotFailure", OnScreenshotFailure)
  this:RegisterGameEvent("ChristmasParty/OnActorIsInvited", OnActorIsInvited)
  m_shareOn = WU.IsShareSwitchOn()
  if m_shareOn then
    this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  end
  local path = "fci/activity-shop-goods/buy-record"
  local res = this:GetData(path)
  if res == nil then
    DB:GameRequest(path):Get(function(res)
      if res == nil then
        return
      end
      m_giftRecords = res.buyRecord or _ENV["!"]({})
      this:SetData(path, res)
      UpdateUI()
    end)
  else
    m_giftRecords = res.buyRecord or _ENV["!"]({})
    UpdateUI()
  end
end

function ResetUI()
  m_isInit = true
  m_stBusy = false
  WU.SetActive(REF.ActorPortraits, false)
  WU.SetActive(REF.Gifts, false)
  WU.SetActive(REF.BtnInviteResult, false)
  WU.SetActive(REF.BtnShare, false)
  WU.SetActive(REF.BtnSave, false)
  WU.SetActive(REF.BtnInvite, false)
end

function OnWindowUninited(window)
  if window.name == "Share" and WU.TopWindow().name == "ChristmasParty" then
    RebuildUI(true)
  end
end

function UpdateUI()
  if m_giftRecords == nil then
    return
  end
  local configs = PB.all("ActivityInviteActorInfo"):where(function(k, v)
    return v.activityType == PB.enum.ActivityType.Christmas
  end):toarray()
  m_inviteeList = _ENV["!"]({})
  m_hasInvitedAll = true
  for i = 1, #configs do
    local config = configs[i]
    local _, v = table.find(m_giftRecords, function(k, v)
      return v.id == config.goodId
    end)
    local hasInvited = v ~= nil and v.buyCount ~= 0
    local giftBoxId = PB.get("ActivityShopGoods", config.goodId).res[1].id
    local gift = this:GetData("fci/item/" .. giftBoxId) or {}
    local isGiftPacked = gift.count ~= nil and gift.count ~= 0
    local t = {
      config = configs[i],
      hasInvited = hasInvited,
      isGiftPacked = isGiftPacked
    }
    table.insert(m_inviteeList, t)
    m_hasInvitedAll = m_hasInvitedAll and hasInvited
    _ENV["$"](REF["NodeGift" .. t.config.index])["@info"] = t
    WU.SetActive(REF["NodeGift" .. t.config.index], hasInvited and isGiftPacked)
    local ref = _ENV["$"](REF["NodeActor" .. t.config.index])
    ref["@info"] = t
    local isSolid = not hasInvited
    local color = fif(isSolid, CS.NGUIMath.HexToColor(624318207), CS.NGUIMath.HexToColor(4294967295))
    ref.TextureStatic.UITexture.color = color
    ref.TextureStatic.UITexture.solidColor = isSolid
    if ref.TextureShadow then
      ref.TextureShadow.gameObject:SetActive(hasInvited)
    end
  end
  this:SetData("ChristmasParty/InviteeList", m_inviteeList)
  REF.BtnSave.gameObject:SetActive(m_hasInvitedAll)
  REF.BtnShare.gameObject:SetActive(m_hasInvitedAll and m_shareOn)
  REF.Grid.UIGrid:Reposition()
  REF.BtnInvite.gameObject:SetActive(not m_hasInvitedAll)
  WU.SetActive(REF.BtnInviteResult, true)
  WU.SetActive(REF.ActorPortraits, true)
  WU.SetActive(REF.Gifts, true)
  if m_isInit then
    REF.Body.UIPlayTween:Play(true)
    m_isInit = false
  end
end

function OnBtnInviteResultClick()
  if m_stBusy then
    return
  end
  this:SetData("ChristmasParty/ResultMode", 2)
  WU.AcquireWindowAsync("ChristmasPartyInviteResult")
end

function OnPoritraitClick(go)
  if m_stBusy then
    return
  end
  local info = _ENV["$"](go)["@info"]
  if not info.hasInvited then
    WU.AcquireWindowAsync("ChristmasPartyInvite")
  end
end

function OnGiftClick(go)
  if m_stBusy then
    return
  end
  local ref = _ENV["$"](go)
  local info = ref["@info"]
  local giftBoxId = PB.get("ActivityShopGoods", info.config.goodId).res[1].id
  local gift = this:GetData("fci/item/" .. giftBoxId)
  this:GameRequest("fci/itemuse/"):Post({
    id = giftBoxId,
    count = gift.count
  }, function(result)
    info.isGiftPacked = false
    WU.SetActive(ref.root, false)
    RU.SetRedMark("Welfare/Christmas/Invite/" .. info.config.goodId, false)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange)
  end)
end

function OnActorIsInvited(curInvitee)
  m_stBusy = true
  local ref = _ENV["$"](REF["NodeActor" .. curInvitee.config.index])
  m_oldSortOrder = ref.root.UIPanel.sortingOrder
  ref.root.UIPanel.sortingOrder = m_oldSortOrder + 10
  REF.TextureBG.TweenScale:ResetToBeginning()
  REF.TextureBG.TweenScale:PlayForward()
  local tex = WU.AcquireAsset("Texture/Christmas/Christmas_" .. curInvitee.config.animRes .. "_Glow")
  ref.RoleGlow.MeshRenderer.material:SetTexture("_MainTex", tex)
  REF.Body.UIPlayTween:Play(true)
  this:DelayInvokeInSeconds(0.8, function()
    ref.root.UIPlayTween:Play(true)
    ref.EffectUnlock.EffectGenerator:Play()
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_RoleUnlock")
  end)
  this:DelayInvokeInSeconds(1.9, function()
    ref.root.UIPanel.sortingOrder = m_oldSortOrder
    m_stBusy = false
    local path = "fci/activity-shop-goods/buy-record"
    local res = this:GetData(path)
    m_giftRecords = res.buyRecord or _ENV["!"]({})
    UpdateUI()
  end)
end

function OnBtnShareClick()
  if m_stBusy then
    return
  end
  this:SetData("ShareConfig", {
    shareName = "ChristmasParty",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  RebuildUI(false)
  WU.AcquireWindowAsync("Share")
end

function OnBtnSaveClick()
  if m_stBusy then
    return
  end
  m_stBusy = true
  RebuildUI(false)
  WU.ToggleTopBar("ChristmasParty", false)
  local time = CS.GameTime.serverUtc
  local fileName = "screencapture" .. time .. ".png"
  this:DelayInvokeInSeconds(1, function()
    local m_imagePath = CS.ResourceManager.Instance.SharePath .. "/" .. fileName
    CS.GameUtility.ScreenCapture(m_imagePath)
    CS.NativeInterface.External_SaveToAlbum(m_imagePath, "ChristmasParty/OnScreenshotSuccess", "ChristmasParty/OnScreenshotFailure")
  end)
end

function RebuildUI(visible)
  REF.BtnShare.gameObject:SetActive(visible and m_hasInvitedAll and m_shareOn)
  REF.BtnSave.gameObject:SetActive(visible and m_hasInvitedAll)
  REF.BtnInvite.gameObject:SetActive(visible and not m_hasInvitedAll)
  REF.BtnInviteResult.gameObject:SetActive(visible)
  REF.Gifts.gameObject:SetActive(visible)
end

function OnScreenshotSuccess()
  RebuildUI(true)
  WU.ToggleTopBar("ChristmasParty", true)
  m_stBusy = false
  WU.ShowHintText(WU.GetString("Window_SaveSuccess"))
end

function OnScreenshotFailure()
  RebuildUI(true)
  WU.ToggleTopBar("ChristmasParty", true)
  m_stBusy = false
  WU.ShowHintText(WU.GetString("Window_SaveFail"))
end
