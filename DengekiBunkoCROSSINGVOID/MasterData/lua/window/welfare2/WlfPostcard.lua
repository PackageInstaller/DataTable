local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local m_activityInfo, m_postcards, m_item, m_shareOn
local m_currenPostcardIndex = 0
local m_totalstatus, m_singlestatus
local m_effectOnIndex = -1
local m_fullscreenEffectOn = false
local m_theme, m_redPointPath
local m_swimConfig = {
  actorName = {
    [1] = {
      lower = "mikoto",
      upper = "Mikoto",
      fullBG = "mikoto"
    },
    [2] = {
      lower = "kirino",
      upper = "Kirino",
      fullBG = "kirino"
    },
    [3] = {
      lower = "kuroyukihime",
      upper = "Kuroyukihime",
      fullBG = "kuroyukihime"
    },
    [4] = {
      lower = "mashiro",
      upper = "Mashiro",
      fullBG = "mashiro"
    }
  },
  postcardCount = 4,
  showLongIntruduction = true
}
local m_coffeeConfig = {
  actorName = {
    [1] = {
      lower = "taiga",
      upper = "Taiga",
      fullBG = "taiga"
    },
    [2] = {
      lower = "kuroko",
      upper = "Kuroko",
      fullBG = "kuroko"
    }
  },
  postcardCount = 2
}
local m_mikuConfig = {
  actorName = {
    [1] = {
      lower = "ruka",
      upper = "Ruka",
      fullBG = "ruka"
    },
    [2] = {
      lower = "renrin",
      upper = "Ren_Rin",
      fullBG = "renrin"
    },
    [3] = {
      lower = "miku",
      upper = "Miku",
      fullBG = "miku"
    }
  },
  postcardCount = 3
}
local m_swimV2Config = {
  actorName = {
    [1] = {
      lower = "llenn",
      upper = "Llenn",
      fullBG = "llenn"
    },
    [2] = {
      lower = "kuroyukihime",
      upper = "Kuroyukihime_2",
      fullBG = "kuroyukihime_2"
    },
    [3] = {
      lower = "mashiro",
      upper = "Mashiro_2",
      fullBG = "mashiro_2"
    }
  },
  postcardCount = 3
}
local m_isCloseTab = false

function Awake()
  if REF.DialogContainer then
    WU.BindButtonEvent(REF.DialogContainer, OnDialogContainerClick)
  end
  WU.BindButtonEvent(_ENV["$"](REF.Main).Item, OnItemClick)
  WU.BindButtonEvent(REF.ButtonTotalAward, OnButtonTotalAwardClick)
  WU.BindButtonEvent(_ENV["$"](REF.Detail).Item, OnItemClick)
  WU.BindButtonEvent(REF.ButtonBack, OnButtonBackClick)
  WU.BindButtonEvent(REF.ButtonAward, OnButtonAwardClick)
  WU.BindButtonEvent(REF.MaskClick, function()
    if m_fullscreenEffectOn then
      return
    end
    ToggleFullScreen(false)
  end)
  WU.BindButtonEvent(REF.TextureFull, function()
    if m_fullscreenEffectOn then
      return
    end
    ToggleFullScreen(true)
  end)
  WU.BindButtonEvent(REF.ButtonShare, OnShareClick)
  WU.TraverseChildren(REF.Postcards, function(go)
    WU.BindButtonEvent(_ENV["$"](go).ButtonPostcard, OnPostcardClick)
  end)
  WU.TraverseChildren(REF.Pieces, function(go)
    WU.BindButtonEvent(_ENV["$"](go).BlockIcon, OnPieceClick)
  end)
end

function OnEnable()
  m_shareOn = WU.IsShareSwitchOn()
  if m_shareOn then
    this:RegisterGameEvent("UI/WindowUninited", OnShareWindowUninited)
  end
  this:RegisterGameEvent("WelfareTabClicked", OnClickTab)
  this:RegisterGameEvent("Welfare/PostcardRefresh", OnPostCardRefresh)
  m_fullscreenEffectOn = false
  m_isCloseTab = false
  InitContent()
end

function OnPostCardRefresh()
  local idx = m_currenPostcardIndex
  InitContent()
  m_currenPostcardIndex = idx
end

function OnDisable()
  ClearFullEffectUI()
  m_isCloseTab = true
  RefreshMain()
  REF.Detail.gameObject:SetActive(false)
  REF.Main.gameObject:SetActive(true)
  if m_shareOn then
    this:UnregisterGameEvent("UI/WindowUninited", OnShareWindowUninited)
  end
  this:UnregisterGameEvent("WelfareTabClicked", OnClickTab)
  this:UnregisterGameEvent("Welfare/PostcardRefresh", OnPostCardRefresh)
end

function InitContent()
  REF.Container.gameObject:SetActive(false)
  local acList = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.Postcard)
  if acList then
    m_activityInfo = acList[1]
  end
  if m_activityInfo.activityId == 26001 then
    m_theme = "coffee"
    m_redPointPath = "Welfare/CoffeePostcard"
  elseif m_activityInfo.activityId == 26002 then
    m_theme = "miku"
    m_redPointPath = "Welfare/MikuPostcard"
  elseif m_activityInfo.activityId == 26004 then
    m_theme = "swimV2"
    m_redPointPath = "Welfare/SwimV2Postcard"
  else
    m_theme = "swim"
    m_redPointPath = "Welfare/Postcard"
  end
  m_postcards = DB:GetData("fci/Postcard")
  if m_postcards == nil then
    DB:GameRequest("fci/Postcard"):Get(function(res)
      m_postcards = res
      DB:SetData("fci/Postcard", res)
      REF.Container.gameObject:SetActive(true)
      RefreshMain()
      ChangeRedStatus()
    end)
  else
    REF.Container.gameObject:SetActive(true)
    RefreshMain()
    ChangeRedStatus()
  end
end

function RefreshMain()
  local data = m_postcards
  if m_postcards.isFirstEnter then
    m_postcards.isFirstEnter = false
    this:GameRequest("fci/Postcard/"):Post({})
  end
  if m_theme == "swim" then
    m_swimConfig.showLongIntruduction = not m_postcards.isFirstEnter
    OnDialogContainerClick()
  else
    local timeStart = ACU.RenderTime2(m_activityInfo.timestampStart, true)
    local timeEnd = ACU.RenderTime2(m_activityInfo.timestampEnd, true)
    REF.LabelTime.UIHtmlLabel.text = WU.GetString("WindowTenCheckin_Time", timeStart, timeEnd)
  end
  if m_currenPostcardIndex == 0 then
    m_totalstatus, m_singlestatus = GetRewardStatus()
  end
  SetTotalAwardUI()
  if m_currenPostcardIndex == 0 then
    for i = 1, #m_singlestatus do
      local ref = REF.Postcards[i - 1]
      _ENV["$"](ref.ButtonPostcard)["@id"] = m_postcards.postcardInfo[i].postcardId
      _ENV["$"](ref.ButtonPostcard)["@index"] = i
      SetPostcardUI(i)
    end
  else
    SetPostcardUI(m_currenPostcardIndex)
  end
  m_item = PB.get("PostcardCell", 1, 1).cost
  _ENV["$"](REF.Main).Item.UITexture.mainTexturePath = "Texture/ItemIcon/ResItem_" .. m_item.id
  _ENV["$"](REF.Detail).Item.UITexture.mainTexturePath = "Texture/ItemIcon/ResItem_" .. m_item.id
  this:Bind("fci/item/" .. m_item.id, OnItemChange)
  m_currenPostcardIndex = 0
end

function RefreshDetail(postcardInfo)
  local ref = _ENV["$"](REF.Detail)
  local refPicture = _ENV["$"](REF.Pieces)
  local actorName = GetConfig("actorName")
  REF.TextureFull.UITexture.mainTexturePath = "Texture/Welfare/2400" .. actorName[m_currenPostcardIndex].fullBG
  REF.TextureBig.UITexture.mainTexturePath = "Texture/Welfare/2400" .. actorName[m_currenPostcardIndex].fullBG
  local status = m_singlestatus[m_currenPostcardIndex]
  REF.TextureFull.gameObject:SetActive(status <= 0)
  REF.CARD.gameObject:SetActive(0 < status)
  REF.ButtonShare.gameObject:SetActive(status <= 0 and m_shareOn)
  SetSingleAwardUI(status)
  if 0 < status then
    local records = postcardInfo.postcardCell
    local actorName = GetConfig("actorName")
    for i = 1, #records do
      local BlockIcon = _ENV["$"](refPicture.root[i - 1].BlockIcon)
      BlockIcon["@id"] = records[i].cellId
      BlockIcon["@index"] = i
      BlockIcon["@state"] = records[i].isLighten
      local indexstr = fif(i < 10, "0" .. tostring(i), tostring(i))
      BlockIcon["$UITexture"].mainTexturePath = "Texture/WelfarePostcard/Postcard" .. actorName[m_currenPostcardIndex].upper .. "/postcard_" .. actorName[m_currenPostcardIndex].lower .. indexstr
      if not records[i].isLighten then
        BlockIcon["$UITexture"].color = CS.NGUIMath.HexToColor(1)
        BlockIcon["$UITexture"].solidColor = true
      else
        BlockIcon["$UITexture"].color = CS.NGUIMath.HexToColor(4294967295)
        BlockIcon["$UITexture"].solidColor = false
      end
      if #refPicture.root[i - 1].WhiteEffect ~= 0 then
        refPicture.root[i - 1].WhiteEffect[0]["$gameObject"]:SetActive(false)
      end
    end
  end
end

function ChangeRedStatus()
  local item = this:GetData("fci/item/" .. m_item.id)
  local itemCount = 0
  if item then
    itemCount = item.count or 0
  end
  if m_totalstatus == 0 then
    RU.SetRedMark(m_redPointPath, true)
    return
  else
    for i = 1, #m_singlestatus do
      local open = true
      local ref = REF.Postcards[i - 1]
      local id = _ENV["$"](ref.ButtonPostcard)["@id"]
      if id then
        open = ACU.IsPostcardOpen(id)
      end
      if m_singlestatus[i] == 0 and open then
        RU.SetRedMark(m_redPointPath, true)
        return
      elseif 0 < m_singlestatus[i] and itemCount >= m_item.count and open then
        RU.SetRedMark(m_redPointPath, true)
        return
      end
    end
  end
  RU.SetRedMark(m_redPointPath, false)
end

function UpdatePostcardDataAndUI()
  local postcardInfo = m_postcards.postcardInfo[m_currenPostcardIndex]
  if 0 < m_singlestatus[m_currenPostcardIndex] then
    m_singlestatus[m_currenPostcardIndex] = m_singlestatus[m_currenPostcardIndex] - 1
  end
  SetSingleAwardUI(m_singlestatus[m_currenPostcardIndex], true)
  ChangeRedStatus()
end

function ClearFullEffectUI()
  if m_fullscreenEffectOn then
    local playTween = REF.Detail.UIPlayTween
    playTween.tweenGroup = 102
    playTween:Stop()
    playTween:ResetToBeginning()
    playTween.tweenGroup = 103
    playTween:Stop()
    playTween:ResetToBeginning()
    REF.Tools.gameObject:SetActive(true)
  end
end

function OnDialogContainerClick(go)
  if m_activityInfo == nil then
    return
  end
  local timeStart = ACU.RenderTime2(m_activityInfo.timestampStart, true)
  local timeEnd = ACU.RenderTime2(m_activityInfo.timestampEnd, true)
  m_swimConfig.showLongIntruduction = not m_swimConfig.showLongIntruduction
  local content = ""
  local tGroup = 0
  if m_swimConfig.showLongIntruduction then
    content = WU.GetString("WindowPostcard_Intruduction", timeStart, timeEnd)
    REF.DialogContainer.UISprite.height = 200
  else
    content = WU.GetString("WindowPostcard_IntruductionSimple", timeStart, timeEnd)
    REF.DialogContainer.UISprite.height = 120
  end
  REF.LabelIntruduction.UIHtmlLabel.text = content
end

function OnButtonTotalAwardClick(go)
  local awardList = PB.get("PostcardPrize", 0).prize
  if m_totalstatus ~= 0 then
    ShowAward(m_totalstatus, awardList)
  else
    GetAward(0)
  end
end

function OnButtonAwardClick(go)
  if m_fullscreenEffectOn or m_effectOnIndex ~= -1 then
    return
  end
  local postcardId = m_postcards.postcardInfo[m_currenPostcardIndex].postcardId
  local awardList = PB.get("PostcardPrize", postcardId).prize
  if m_singlestatus[m_currenPostcardIndex] ~= 0 then
    ShowAward(m_singlestatus[m_currenPostcardIndex], awardList)
  else
    GetAward(postcardId, m_currenPostcardIndex)
  end
end

function OnPostcardClick(go)
  local index = _ENV["$"](go)["@index"]
  local open, startTime = ACU.IsPostcardOpen(index)
  if not open then
    local openTip = WU.GetString("Window_Month_Day_Hour", startTime.Month, startTime.Day, startTime.Hour)
    WU.ShowHintText(WU.GetString("WindowPostcard_PostCardNotOpen", openTip))
    return
  end
  m_currenPostcardIndex = index
  StopPrePieceEffect()
  RefreshDetail(m_postcards.postcardInfo[index])
  REF.Main.gameObject:SetActive(false)
  REF.Detail.gameObject:SetActive(true)
end

function OnButtonBackClick(go)
  if not m_fullscreenEffectOn then
    RefreshMain()
    REF.Detail.gameObject:SetActive(false)
    REF.Main.gameObject:SetActive(true)
  end
end

function OnClickTab(wlfName)
  local clickSelf = false
  if wlfName == "Postcard" and m_theme == "swim" then
    clickSelf = true
  elseif wlfName == "CoffeePostcard" and m_theme == "coffee" then
    clickSelf = true
  elseif wlfName == "SwimV2Postcard" and m_theme == "swimV2" then
    clickSelf = true
  end
  if not clickSelf then
    ClearFullEffectUI()
    m_isCloseTab = true
    RefreshMain()
    REF.Detail.gameObject:SetActive(false)
    REF.Main.gameObject:SetActive(true)
  end
end

function ToggleFullScreen(visible)
  REF.FullScreen.gameObject:SetActive(visible)
  local window = WU.FindWindow("Welfare")
  WU.ToggleRendering(_ENV["$"](window).Left, not visible)
  WU.ToggleTopBar("Welfare", not visible)
end

function OnItemChange(item)
  if item then
    _ENV["$"](REF.Main).LabelBottleCount.UIHtmlLabel.text = math.floor(item.count)
    _ENV["$"](REF.Detail).LabelBottleCount.UIHtmlLabel.text = math.floor(item.count)
  else
    _ENV["$"](REF.Main).LabelBottleCount.UIHtmlLabel.text = 0
    _ENV["$"](REF.Detail).LabelBottleCount.UIHtmlLabel.text = 0
  end
end

function OnShareWindowUninited()
  ToggleFullScreen(false)
end

function OnPieceClick(go)
  if m_item == nil then
    m_item = PB.get("PostcardCell", 1, 1).cost
  end
  local ref = _ENV["$"](go)
  if ref["@state"] then
    return
  end
  local bottle = DB:GetData("fci/item/" .. m_item.id)
  local bottleCount
  if bottle then
    bottleCount = bottle.count
  else
    bottleCount = 0
  end
  local postcardInfo = m_postcards.postcardInfo[m_currenPostcardIndex]
  local postcardId = postcardInfo.postcardId
  local cellId = ref["@id"]
  local cellIndex = ref["@index"]
  local costCount = PB.get("PostcardCell", postcardId, cellId).cost.count
  local open, startTime = ACU.IsPostcardOpen(postcardId)
  if bottleCount < costCount and open then
    WU.ShowHintText(WU.GetString("WindowPostcard_TipNoPiece"))
  else
    local function req()
      this:GameRequest("fci/Postcard/Lighten/" .. postcardId):Post({cellId = cellId}, function(res)
        DBH.ResChange(res.resChange)
        
        ref["@state"] = true
        m_postcards.postcardInfo[m_currenPostcardIndex].postcardCell[cellIndex].isLighten = true
        UpdatePostcardDataAndUI()
        ShowPutIntoEffect(ref)
      end, function(res)
      end)
    end
    
    if not open then
      local openTip = WU.GetString("Window_Month_Day_Hour", startTime.Month, startTime.Day, startTime.Hour)
      WU.ShowHintText(WU.GetString("WindowPostcard_PostCardNotOpen", openTip))
      return
    else
      req()
    end
  end
end

function ShowAward(state, awardList)
  if 0 < state then
    local title = WU.GetString("WindowPostcard_TotalAwardTittle")
    WU.AcquireWindowAsync("RewardPreview", function(ui)
      _ENV["$"](ui)["$$SetView"](awardList, title, "", false)
      for i, v in ipairs(awardList) do
        if v.type == PB.enum.ResourceType.ResActor then
          _ENV["$"](ui)["$$SetCustomActorInfo"](v.id, v.quality)
        end
      end
    end)
  elseif state < 0 then
    local title = WU.GetString("WindowPostcard_TotalAwardTittle")
    local buttonTitle = WU.GetString("WindowGacha_Close")
    WU.AcquireWindowAsync("RewardPreview", function(ui)
      _ENV["$"](ui)["$$SetView"](awardList, title, "", true, buttonTitle)
      for i, v in ipairs(awardList) do
        if v.type == PB.enum.ResourceType.ResActor then
          _ENV["$"](ui)["$$SetCustomActorInfo"](v.id, info.quality)
        end
      end
    end)
  end
end

function GetAward(postcardId, index)
  this:GameRequest("fci/Postcard/ReceivePrize/"):Post({postcardId = postcardId}, function(result)
    if index then
      m_singlestatus[index] = -1
      m_postcards.prizeInfo[index + 1].prizeReceiveStatus = true
    else
      m_postcards.prizeInfo[1].prizeReceiveStatus = true
      m_totalstatus = -1
    end
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange)
    ChangeRedStatus()
    if index then
      SetSingleAwardUI(-1)
    else
      SetTotalAwardUI(-1)
    end
  end)
end

function GetRewardStatus()
  local postcardCount = GetConfig("postcardCount")
  local single = {}
  for i = 1, postcardCount do
    single[i] = 0
  end
  local total = 0
  local rewardList = m_postcards.prizeInfo
  for i = 2, #rewardList do
    if rewardList[i].prizeReceiveStatus then
      single[i - 1] = -1
    else
      local cells = m_postcards.postcardInfo[i - 1].postcardCell
      for ii = 1, #cells do
        if cells[ii].isLighten == false then
          single[i - 1] = single[i - 1] + 1
        end
      end
      if single[i - 1] ~= 0 then
        total = total + 1
      end
    end
  end
  if rewardList[1].prizeReceiveStatus then
    total = -1
  end
  return total, single
end

function ShowPutIntoEffect(ref)
  StopPrePieceEffect(true)
  local index = ref["@index"]
  m_effectOnIndex = index
  local playTween = REF.Detail.UIPlayTween
  local reff = REF.Pieces[index - 1]
  local actorName = GetConfig("actorName")
  local indexstr = fif(index < 10, "0" .. tostring(index), tostring(index))
  local postcardTex = WU.AcquireAsset("Texture/WelfarePostcard/Postcard" .. actorName[m_currenPostcardIndex].upper .. "/postcard_" .. actorName[m_currenPostcardIndex].lower .. indexstr)
  local pMaskTex = WU.AcquireAsset("Texture/WelfarePostcard/PostcardEffect/postcardMask_" .. indexstr)
  local pGlow = WU.AcquireAsset("Texture/WelfarePostcard/PostcardEffect/postcardADD_" .. indexstr)
  _ENV["$"](reff.PieceEffect).Postcard.MeshRenderer.material:SetTexture("_MainTex", postcardTex)
  _ENV["$"](reff.PieceEffect).PostcardMASK.MeshRenderer.material:SetTexture("_MainTex", pMaskTex)
  _ENV["$"](reff.PieceEffect).PostcardGLOW.MeshRenderer.material:SetTexture("_MainTex", pGlow)
  _ENV["$"](reff.PieceEffect).FlowGlow.MeshRenderer.material:SetTexture("_MaskTex", postcardTex)
  TogglePieceEffect(true, reff)
  REF.LightEffect.EffectGenerator:Play()
  REF.TextureTint.TweenAlpha:ResetToBeginning()
  REF.TextureTint.TweenAlpha:PlayForward()
  REF.TextureTintADD.TweenAlpha:ResetToBeginning()
  REF.TextureTintADD.TweenAlpha:PlayForward()
  reff.PieceEffect.EffectGenerator:Play(function()
    TogglePieceEffect(false, reff)
    reff.BlockIcon.UITexture.color = CS.NGUIMath.HexToColor(4294967295)
    reff.BlockIcon.UITexture.solidColor = false
    m_effectOnIndex = -1
  end)
  playTween.tweenGroup = 102
  playTween:ResetToBeginning()
  playTween:Play(true)
  if m_singlestatus[m_currenPostcardIndex] == 0 then
    m_fullscreenEffectOn = true
    m_totalstatus = m_totalstatus - 1
    this:DelayInvokeInSeconds(2.5, function()
      REF.Tools.gameObject:SetActive(false)
      REF.FSStarEffect.gameObject:SetActive(true)
      REF.FSStarEffect.EffectGenerator:Play(function()
        REF.FSStarEffect.gameObject:SetActive(false)
        m_fullscreenEffectOn = false
      end)
      playTween.tweenGroup = 103
      playTween:ResetToBeginning()
      playTween:Play(true)
      local map = _ENV["!"]({})
      local order = _ENV["!"]({})
      local num = #REF.Pieces
      for i = 1, num do
        table.insert(map, i)
      end
      for i = 1, num do
        local t = math.random(1, num - i + 1)
        table.insert(order, map[t])
        table.remove(map, t)
      end
      for i = 1, #order do
        local t = i
        local index = order[i]
        local indexstr = fif(index < 10, "0" .. tostring(index), tostring(index))
        local pGlow = WU.AcquireAsset("Texture/WelfarePostcard/PostcardEffect/postcardADD_" .. indexstr)
        local t = _ENV["$"](REF.Pieces[index - 1].WhiteEffect).PostcardGLOW
        _ENV["$"](REF.Pieces[index - 1].WhiteEffect).PostcardGLOW.MeshRenderer.material:SetTexture("_MainTex", pGlow)
        this:DelayInvokeInSeconds(i * 0.06, function()
          REF.Pieces[index - 1].WhiteEffect.EffectGenerator:Play(function()
          end)
        end)
      end
      local effectEnd = false
      this:DelayInvokeInSeconds(1.3, function()
        REF.TextureFull.gameObject:SetActive(true)
        ToggleFullScreen(true)
        REF.ButtonShare.gameObject:SetActive(m_shareOn)
        REF.Tools.gameObject:SetActive(true)
        if effectEnd then
          WU.SetActive(REF.TextureAward, false)
          REF.EffectBag.gameObject:SetActive(true)
        else
          effectEnd = true
        end
      end)
      local rotationTweens = REF.Detail.transform:GetComponents(typeof(CS.TweenScale))
      local t = rotationTweens[0].delay + rotationTweens[0].duration
      this:DelayInvokeInSeconds(t, function()
        REF.CARD.gameObject:SetActive(false)
        playTween:ResetToBeginning()
        if effectEnd then
          WU.SetActive(REF.TextureAward, false)
          REF.EffectBag.gameObject:SetActive(true)
        else
          effectEnd = true
        end
      end)
    end)
  end
end

function StopPrePieceEffect(current)
  if m_effectOnIndex ~= -1 then
    local preReff = REF.Pieces[m_effectOnIndex - 1]
    TogglePieceEffect(false, preReff)
    if current then
      preReff.BlockIcon.UITexture.color = CS.NGUIMath.HexToColor(4294967295)
      preReff.BlockIcon.UITexture.solidColor = false
    else
      REF.FSStarEffect.gameObject:SetActive(false)
    end
    local playTween = REF.Detail.UIPlayTween
    playTween.tweenGroup = 102
    playTween:Finish()
    m_effectOnIndex = -1
  end
end

function TogglePieceEffect(visible, ref)
  REF.LightEffect.gameObject:SetActive(visible)
  REF.TextureTint.gameObject:SetActive(visible)
  REF.TextureTintADD.gameObject:SetActive(visible)
  if ref then
    ref.PieceEffect.gameObject:SetActive(visible)
  end
end

function OnItemClick()
  WU.ShowItemDetail(m_item.id, false)
end

function GetConfig(key)
  local config
  if m_theme == "swim" then
    config = m_swimConfig
  elseif m_theme == "coffee" then
    config = m_coffeeConfig
  elseif m_theme == "miku" then
    config = m_mikuConfig
  elseif m_theme == "swimV2" then
    config = m_swimV2Config
  end
  return config and config[key]
end

function OnShareClick()
  WU.RecordButtonClick(901)
  this:SetData("ShareConfig", {
    shareName = "WelfarePostcard",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  ToggleFullScreen(true)
  WU.AcquireWindowAsync("Share", function()
  end)
end

function SetTotalAwardUI()
  local resource
  if m_theme == "swim" then
    if m_totalstatus == 0 then
      resource = "supply2"
    elseif m_totalstatus < 0 then
      resource = "supply3"
    elseif 0 < m_totalstatus then
      resource = "supply"
    end
    REF.ButtonTotalAward.UISprite.spriteName = resource
    REF.ButtonTotalAward.UISprite:MakePixelPerfect()
  elseif m_theme == "coffee" or m_theme == "miku" then
    if m_totalstatus == 0 then
      resource = "Texture/Welfare/sakura_coffee/supply_icon_2"
    elseif m_totalstatus < 0 then
      resource = "Texture/Welfare/sakura_coffee/supply_icon_3"
    elseif 0 < m_totalstatus then
      resource = "Texture/Welfare/sakura_coffee/supply_icon_1"
    end
    REF.TextureTotalAward.UITexture.mainTexturePath = resource
    WU.SetActive(REF.TextureTotalAward, m_totalstatus ~= 0)
  elseif m_theme == "swimV2" then
    if m_totalstatus == 0 then
      resource = "Texture/Welfare/swimming_pool/supply_icon_2"
    elseif m_totalstatus < 0 then
      resource = "Texture/Welfare/swimming_pool/supply_icon_3"
    elseif 0 < m_totalstatus then
      resource = "Texture/Welfare/swimming_pool/supply_icon_1"
    end
    REF.TextureTotalAward.UITexture.mainTexturePath = resource
    WU.SetActive(REF.TextureTotalAward, m_totalstatus ~= 0)
  end
  REF.EffectBox.gameObject:SetActive(m_totalstatus == 0)
end

function SetSingleAwardUI(status, waitEffect)
  local resource
  if m_theme == "swim" then
    if status == 0 then
      resource = "beach_gift_2"
    elseif status < 0 then
      resource = "beach_gift_3"
    elseif 0 < status then
      resource = "beach_gift"
    end
    REF.ButtonAward.UISprite.spriteName = resource
    REF.ButtonAward.UISprite:MakePixelPerfect()
  elseif m_theme == "coffee" then
    if status == 0 then
      resource = "Texture/Welfare/sakura_coffee/gift_icon_2"
    elseif status < 0 then
      resource = "Texture/Welfare/sakura_coffee/gift_icon_3"
    elseif 0 < status then
      resource = "Texture/Welfare/sakura_coffee/gift_icon_1"
    end
    REF.TextureAward.UITexture.mainTexturePath = resource
    if not waitEffect then
      WU.SetActive(REF.TextureAward, status ~= 0)
    end
  elseif m_theme == "miku" then
    if status == 0 then
      resource = "Texture/Welfare/miku_concert/gift_icon_2"
    elseif status < 0 then
      resource = "Texture/Welfare/miku_concert/gift_icon_3"
    elseif 0 < status then
      resource = "Texture/Welfare/miku_concert/gift_icon_1"
    end
    REF.TextureAward.UITexture.mainTexturePath = resource
    if not waitEffect then
      WU.SetActive(REF.TextureAward, status ~= 0)
    end
  elseif m_theme == "swimV2" then
    if status == 0 then
      resource = "Texture/Welfare/swimming_pool/gift_icon_2"
    elseif status < 0 then
      resource = "Texture/Welfare/swimming_pool/gift_icon_3"
    elseif 0 < status then
      resource = "Texture/Welfare/swimming_pool/gift_icon_1"
    end
    REF.TextureAward.UITexture.mainTexturePath = resource
    if not waitEffect then
      WU.SetActive(REF.TextureAward, status ~= 0)
    end
  end
  if not waitEffect then
    REF.EffectBag.gameObject:SetActive(status == 0)
  end
end

function SetPostcardUI(i)
  local ref = REF.Postcards[i - 1]
  if m_theme == "swim" then
    ref.ButtonPostcard.UISprite.spriteName = fif(m_singlestatus[i] <= 0, "postcard_small_0" .. tostring(i), "bottle_" .. tostring(i))
    ref.ButtonPostcard.UISprite:MakePixelPerfect()
    ref.SpriteSand.gameObject:SetActive(0 < m_singlestatus[i])
    local showBottoleEffect = 0 < m_singlestatus[i] and m_singlestatus[i] < #m_postcards.postcardInfo[i].postcardCell
    ref.BottleEffect.gameObject:SetActive(showBottoleEffect)
    ref.PostcardEffect.gameObject:SetActive(m_singlestatus[i] == 0)
  elseif m_theme == "coffee" then
    ref.ButtonPostcard.UITexture.mainTexturePath = fif(m_singlestatus[i] <= 0, "Texture/Welfare/sakura_coffee/Photo_frame_" .. i .. "_on", "Texture/Welfare/sakura_coffee/Photo_frame_" .. i .. "_off")
    local showEffect = 0 <= m_singlestatus[i]
    ref.PostcardEffect.gameObject:SetActive(showEffect)
  elseif m_theme == "miku" then
    local id = _ENV["$"](ref.ButtonPostcard)["@id"]
    local timeStart = PB.get("PostcardPrize", id).timeStart
    local open = ACU.IsPostcardOpen(id)
    local path = "miku_concert/ticket_" .. i .. "_off"
    ref.ButtonPostcard.UITexture.mainTexturePath = fif(m_singlestatus[i] <= 0, "Texture/Welfare/miku_concert/ticket_" .. i .. "_on", "Texture/Welfare/miku_concert/ticket_" .. i .. "_off")
    local rotates = {
      -13.19,
      9.45,
      8.28
    }
    local effectKey = WU.GetGameDataCache("MikuEffectShow" .. i .. DB:GetData("playerId"))
    local effectWeakKey = WU.GetGameDataCache("MikuEffectWeakShow" .. i .. DB:GetData("playerId"))
    local showEffect = effectKey == nil and m_singlestatus[i] <= 0 and open
    if showEffect then
      WU.SetGameDataCache("MikuEffectShow" .. i .. DB:GetData("playerId"), true)
    end
    if not REF.root.gameObject.activeSelf then
      return
    end
    local showEffectWeak = (effectWeakKey == nil or m_singlestatus[i] == 0) and open and not showEffect
    if showEffectWeak then
      WU.SetGameDataCache("MikuEffectWeakShow" .. i .. DB:GetData("playerId"), true)
    end
    if showEffect ~= ref.PostcardEffect.gameObject.activeSelf then
      ref.PostcardEffect.EffectGenerator:Reset()
      ref.PostcardEffect.gameObject:SetActive(showEffect)
    end
    ref.PostcardEffectWeak.gameObject:SetActive(true)
    this:DelayInvokeEndOfFrame(function()
      ref.PostcardEffectWeak.gameObject:SetActive(showEffectWeak)
      ref.EffectWeakPar.transform.localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, rotates[i])
    end)
  elseif m_theme == "swimV2" then
    ref.ButtonPostcard.UITexture.mainTexturePath = fif(m_singlestatus[i] <= 0, "Texture/Welfare/swimming_pool/poster_frame_" .. i .. "_on", "Texture/Welfare/swimming_pool/poster_frame_" .. i .. "_off")
    local showGlowEffect = 0 < m_singlestatus[i]
    ref.PostcardEffectGlow.gameObject:SetActive(showGlowEffect)
    local effectKey = WU.GetGameDataCache("SwimV2EffectShow" .. i .. DB:GetData("playerId")) == nil
    if effectKey and m_singlestatus[i] <= 0 then
      if not m_isCloseTab then
        ref.PostcardEffect.EffectGenerator:Play()
      end
      WU.SetGameDataCache("SwimV2EffectShow" .. i .. DB:GetData("playerId"), true)
    end
  end
end
