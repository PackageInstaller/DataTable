local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local JSON = require("Internal/json")
local ACU = require("Common/ActivityUtil")
local PowerIncreaseInfo
local ResType = PB.enum.ResourceType.ResPlayerPower
local ResMoney = PB.enum.ResourceType.ResPlayerMoney
local m_lastMoney, m_money, m_bindMoney
local m_pressed = false
local m_pressTime = 0
local m_showTips = false
local m_lastUpdateUtc
local m_powerPressed = false
local m_moneyPressed = false
local m_lastResIncreaseTimeMap = {}
local m_isRequesting = false
local m_wasPowerFull = false
local REFRESH_INTERVAL = 0.5
local m_refreshTimer = REFRESH_INTERVAL
local REQUEST_INTERVAL = 5
local m_requestTimer = REQUEST_INTERVAL
local m_mallData
local m_mallRecord = {}
local m_mapMallRed
local m_openedMallActivityIds = {}
local m_hasGetGiftSaku

function SetupWindow()
  WU.BindPressEvent(REF.ButtonPower, function(go, pressed)
    m_powerPressed = true
    m_moneyPressed = false
    m_pressed = pressed
    if not pressed then
      OnPowerRelease(go)
    end
  end)
  WU.BindPressEvent(REF.ButtonMoney, function(go, pressed)
    m_powerPressed = false
    m_moneyPressed = true
    m_pressed = pressed
    if not pressed then
      OnMoneyRelease(go)
    end
  end)
  WU.BindButtonEvent(REF.ButtonGold, OnGoldClick)
  WU.BindButtonEvent(REF.ButtonMoney, OnMoneyClick)
  m_mallData = PB.all("Mall"):where(function(_, p)
    return p.isMonth == false and p.giftPage == 1
  end):toarray()
  REF.GM.gameObject:SetActive(true)
  WU.BindButtonEvent(REF.GM, function()
    CS.SceneCity.Instance:OpenGMToolKit()
  end)
end

function UpdateMallRed()
  local bRed = false
  local buyCount = 0
  local baseInfo = DB:GetData("fci/baseinfo/")
  if baseInfo == nil then
    return
  end
  local redRecord = WU.GetGameDataCache("MallRed" .. DB:GetData("playerId"))
  m_mapMallRed = {}
  for i, v in ipairs(m_mallData) do
    local key = v.id
    local buyCount = m_mallRecord[key]
    if buyCount == nil then
      buyCount = 0
    end
    local mallData = v
    local bEnough = WU.IsEnoughMoney(mallData.price, mallData.resourceType)
    if mallData.resourceType == PB.enum.ResourceType.ResPlayerGold then
      local stockAmount = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[mallData.resourceType] .. "_0")
      if stockAmount == nil then
        stockAmount = 0
      end
      bEnough = stockAmount >= mallData.price
    end
    if baseInfo.level >= mallData.limitLv and buyCount < mallData.maxBuyCount and bEnough and (redRecord == nil or redRecord and redRecord[tostring(v.id)] == nil) then
      bRed = true
      m_mapMallRed[v.id] = 1
    end
  end
  DB:SetData("RedPointPurchase", bRed)
end

function UpdateSale(id, buyCount)
  m_mallRecord[tonumber(id)] = tonumber(buyCount)
  UpdateMallRed()
  UpdatePurchaseRedPoint()
end

function UpdateRedMark(res)
  if res and res.mallRecord and res.mallRecord.summary then
    for k, v in pairs(res.mallRecord.summary) do
      local key = tonumber(k)
      local buyCount = tonumber(v.buyCount)
      if m_mallRecord[key] == nil or buyCount > m_mallRecord[key] then
        m_mallRecord[key] = buyCount
      end
    end
  end
  UpdateMallRed()
  UpdatePurchaseRedPoint()
end

function BindMallData()
  this:UnregisterGameEvent("UpdateSale", UpdateSale)
  this:RegisterGameEvent("UpdateSale", UpdateSale)
  this:Unbind("fci/mall-info/", UpdateRedMark)
  this:Bind("fci/mall-info/", UpdateRedMark)
  this:Unbind("fci/baseinfo/", UpdateRedMark)
  this:Bind("fci/baseinfo/", UpdateRedMark)
  this:BroadcastGameEvent("UpdateMallData")
  this:RegisterGameEvent("RecordPoint", function()
    RecordPoint()
    UpdateMallRed()
    UpdatePurchaseRedPoint()
  end)
  this:RegisterGameEvent("UpdatePointGiftActivity", function()
    local baseinfo = DB:GetData("fci/baseinfo/")
    UpdateOpenedActivityList()
    if baseinfo.level >= 5 then
      RecordGiftActivityActivityIds()
      UpdateGiftActivityRedPoint()
      UpdatePurchaseRedPoint()
    end
  end)
end

function UpdateOpenedActivityList()
  local activityInfoList = DB:GetData("ActivityList")
  if activityInfoList == nil then
    return
  end
  m_openedMallActivityIds = {}
  for i, v in ipairs(activityInfoList) do
    local preheartTime
    if v.type == PB.enum.ActivityType.Mall then
      local shouldAdd = false
      local isPreheat = false
      local inPreheat = v.timestampPreheat < CS.GameTime.serverUtc and CS.GameTime.serverUtc < v.timestampStart
      if v.timestampPreheat and v.timestampPreheat > 0 then
        shouldAdd = v.timestampPreheat < CS.GameTime.serverUtc and CS.GameTime.serverUtc < v.timestampStart
        isPreheat = true
      end
      if v.weekdayPreheart and 0 < v.weekdayPreheart and CS.GameTime.serverUtc > v.timestampStart and CS.GameTime.serverUtc < v.timestampEnd then
        local minDay = 999
        local maxDay = 0
        for i, day in ipairs(v.weekdays) do
          if day < minDay then
            minDay = day
          end
          if day > maxDay then
            maxDay = day
          end
        end
        local localTime = CS.GameTime.serverNow
        local dayOfWeek = U.ToInt(localTime.DayOfWeek)
        if dayOfWeek == 0 then
          dayOfWeek = 7
        end
        if minDay > dayOfWeek then
          local willTime = CS.System.DateTime(localTime.Year, localTime.Month, localTime.Day)
          willTime = willTime:AddDays(minDay - dayOfWeek)
          isPreheat = true
          shouldAdd = true
          preheartTime = CS.GameTime.ToSecondsForTimeZone(willTime)
        elseif maxDay < dayOfWeek then
          local willTime = CS.System.DateTime(localTime.Year, localTime.Month, localTime.Day)
          willTime = willTime:AddDays(minDay + 7 - dayOfWeek)
          isPreheat = true
          shouldAdd = true
          preheartTime = CS.GameTime.ToSecondsForTimeZone(willTime)
        elseif minDay <= dayOfWeek and maxDay >= dayOfWeek then
          shouldAdd = true
          local willTime = CS.System.DateTime(localTime.Year, localTime.Month, localTime.Day)
          willTime = willTime:AddDays(maxDay - dayOfWeek + 1)
          v.timestampEnd = CS.GameTime.ToSecondsForTimeZone(willTime)
        end
      end
      if not shouldAdd and ACU.IsOpenForDoing(v) then
        shouldAdd = true
      end
      if shouldAdd and not inPreheat then
        table.insert(m_openedMallActivityIds, v.activityId)
      end
    end
  end
end

function IsShow()
  local switch = this:GetData("AccountSwitch")
  return switch and not switch.MallNoPay
end

function UpdateGiftActivityRedPoint()
  local data = PB.all("Mall")
  local activityGiftIds = {}
  for _, d in pairs(data) do
    if not d.isMonth and d.giftPage == 2 then
      local __, id = table.find(m_openedMallActivityIds, function(k, v)
        return v == d.activityId
      end)
      if id ~= nil then
        table.insert(activityGiftIds, id)
      end
    end
  end
  local currentActivityIds = DB:GetData("PurchaseGiftActivityIds")
  local redPointstatus = DB:GetData("RedPointPurchaseGiftActivity")
  if currentActivityIds == nil then
    currentActivityIds = WU.GetGameDataCache("ActivityIds" .. DB:GetData("playerId"))
  end
  if redPointstatus == nil then
    redPointstatus = WU.GetGameDataCache("RedPointRecordGiftActivity" .. DB:GetData("playerId"))
    DB:SetData("RedPointPurchaseGiftActivity", redPointstatus and IsShow())
  end
  for i = 1, #activityGiftIds do
    if not table.has(currentActivityIds, activityGiftIds[i]) and IsShow() then
      DB:SetData("RedPointPurchaseGiftActivity", true)
      redPointstatus = true
      break
    end
  end
  if not redPointstatus then
    local mallInfo = this:GetData("fci/mall-info/")
    local dailyIds = mallInfo and mallInfo.mallRecord and mallInfo.mallRecord.dailyMallId
    local refreshTime = mallInfo.mallRecord.dailyMallRefreshTime
    if dailyIds and dailyIds[1] then
      local infos = WU.GetGameDataCache("DailyRandomRefreshe" .. DB:GetData("playerId")) or _ENV["!"]({})
      for i = 1, #dailyIds do
        local id = dailyIds[i]
        local record = infos[id]
        if (record == nil or record.refreshTime == nil or refreshTime > record.refreshTime) and IsShow() then
          DB:SetData("RedPointPurchaseGiftActivity", true)
          redPointstatus = true
          break
        end
      end
    end
  end
  DB:SetData("PurchaseGiftActivityIds", activityGiftIds)
  WU.SetGameDataCache("ActivityIds" .. DB:GetData("playerId"), activityGiftIds)
  WU.SetGameDataCache("RedPointRecordGiftActivity" .. DB:GetData("playerId"), redPointstatus)
end

function UpdateDirectPurchaseGiftRedPoint()
  local data = PB.all("Mall")
  local dirctPurchaseGiftIds = {}
  for _, d in pairs(data) do
    if not d.isMonth and d.giftPage == 3 then
      local __, id = table.find(m_openedMallActivityIds, function(k, v)
        return v == d.activityId
      end)
      if id ~= nil then
        table.insert(dirctPurchaseGiftIds, id)
      end
    end
  end
  local hasNewDirctPurchaseGiftId = false
  local curDirctPurchaseGiftIds = WU.GetGameDataCache("DirctPurchaseGiftIds" .. DB:GetData("playerId")) or {}
  for _, id in pairs(dirctPurchaseGiftIds) do
    local __, d = table.find(curDirctPurchaseGiftIds, function(k, v)
      return v == id
    end)
    if d == nil then
      hasNewDirctPurchaseGiftId = true
      break
    end
  end
  DB:SetData("RedPointDirctPurchaseGift", hasNewDirctPurchaseGiftId and IsShow())
end

function UpdatePurchaseRedPoint()
  local bRed = DB:GetData("RedPointPurchase")
  local GiftActivityBRed = DB:GetData("RedPointPurchaseGiftActivity")
  local hasNewDirctPurchaseGiftId = DB:GetData("RedPointDirctPurchaseGift")
  if GiftActivityBRed == nil then
    GiftActivityBRed = bRed
  end
  REF.SpriteRed.gameObject:SetActive(bRed or GiftActivityBRed or hasNewDirctPurchaseGiftId)
end

function InitWindow()
  REF.NodeEffect.gameObject:SetActive(false)
  REF.SpriteRed.gameObject:SetActive(false)
  this:Bind("fci/baseinfo/", function(baseinfo)
    local resPlayerLevelInitConfig = PB.get("PlayerLevelInitConfig", baseinfo.level)
    local _, find = table.find(resPlayerLevelInitConfig.incInfo, function(k, v)
      return v.type == ResType
    end)
    PowerIncreaseInfo = find
    local power = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[ResType] .. "_0")
    local isPowerFull = power >= PowerIncreaseInfo.max
    if m_wasPowerFull and not isPowerFull then
      TryRequestResourceChange(true)
    end
    m_wasPowerFull = isPowerFull
    UpdateOpenedActivityList()
    UpdateDirectPurchaseGiftRedPoint()
    if baseinfo.level >= 5 then
      RecordGiftActivityActivityIds()
      UpdateGiftActivityRedPoint()
      UpdatePurchaseRedPoint()
    end
  end)
  this:Bind("fci/resource/" .. PB.enum.ResourceType.__keys[ResType] .. "_0", function(power)
    local isPowerFull = power >= PowerIncreaseInfo.max
    if m_wasPowerFull and not isPowerFull then
      TryRequestResourceChange(true)
    end
    m_wasPowerFull = isPowerFull
  end)
  this:Bind("fci/resource/" .. PB.enum.ResourceType.__keys[ResMoney] .. "_0", function(money)
    UpdateMallRed()
    UpdatePurchaseRedPoint()
  end)
  this:Bind("fci/resource/ResPlayerMoney_0", OnSetPlayerMoney)
  this:Bind("fci/resource/ResPlayerPower_0", OnSetPlayerPower)
  this:Bind("fci/resource/ResPlayerGold_0", OnSetBaseResource)
  if WU.FindWindow("Login") == nil and this:GetData("NavigationContext") == "City" then
    REF["$UILuaWindow"]:PlayUITweener()
  end
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
  this:RegisterGameEvent("NewDayCome0", OnNewDayCome)
  BindMallData()
  this:Bind("RedPointDirctPurchaseGift", function()
    UpdatePurchaseRedPoint()
  end)
  TryRequestResourceChange(true)
  this:Bind("surpriseEventInfo", OnSurpriseEvent)
  this:Bind("hasGetGiftSaku", OnHasGetGiftSaku)
  this:Bind("hasGiftSaku", OnHasGiftSaku)
end

function OnActivityStatusChanged(category, activityId, status, type)
  if type == PB.enum.ActivityType.ActivityType_Mall then
    UpdateOpenedActivityList()
    UpdateDirectPurchaseGiftRedPoint()
    local baseinfo = DB:GetData("fci/baseinfo/")
    if baseinfo.level >= 5 then
      UpdateGiftActivityRedPoint()
      UpdatePurchaseRedPoint()
    end
  end
end

function OnNewDayCome()
  local baseinfo = DB:GetData("fci/baseinfo/")
  if baseinfo.level >= 5 then
    this:GameRequest("fci/mall-info/"):Get(function(response)
      DB:SetData("fci/mall-info/", response)
      UpdateGiftActivityRedPoint()
      UpdatePurchaseRedPoint()
    end)
  end
end

function UpdateWindow(delta)
  if m_pressed then
    m_pressTime = m_pressTime + delta
    if 0.3 < m_pressTime and not m_showTips then
      m_showTips = true
    end
  end
  if m_refreshTimer >= REFRESH_INTERVAL then
    if m_requestTimer >= REQUEST_INTERVAL then
      TryRequestResourceChange()
      m_requestTimer = 0
    else
      PredictResourceChange()
    end
    m_refreshTimer = 0
  end
  m_refreshTimer = m_refreshTimer + delta
  m_requestTimer = m_requestTimer + delta
  UpdatePowerTips()
  UpdateMoneyTips()
end

function OnPowerRelease()
  if m_showTips then
    m_showTips = false
    m_lastUpdateUtc = nil
    WU.HideHoverTipsSpecial("HoverTipsPower")
  else
    OnPowerClick()
  end
  m_pressTime = 0
end

function OnMoneyRelease()
  if m_showTips then
    m_showTips = false
    m_lastUpdateUtc = nil
    WU.HideHoverTips()
  end
  m_pressTime = 0
end

function TryRequestResourceChange(force)
  local needRequest = false
  if not m_isRequesting then
    if force then
      needRequest = true
    elseif next(m_lastResIncreaseTimeMap) ~= nil then
      local serverUtc = CS.GameTime.serverUtc
      for k, lastResIncreaseTime in pairs(m_lastResIncreaseTimeMap) do
        local elapsedTimeSinceLastIncrease = serverUtc - lastResIncreaseTime.real
        if elapsedTimeSinceLastIncrease >= PowerIncreaseInfo.incSeconds then
          needRequest = true
          break
        end
      end
    end
    if needRequest then
      RequestResourceChange()
    end
  end
end

function PredictResourceChange()
  if next(m_lastResIncreaseTimeMap) ~= nil then
    local serverUtc = CS.GameTime.serverUtc
    for k, lastResIncreaseTime in pairs(m_lastResIncreaseTimeMap) do
      local elapsedTimeSinceLastIncrease = serverUtc - lastResIncreaseTime.predict
      if elapsedTimeSinceLastIncrease >= PowerIncreaseInfo.incSeconds then
        m_lastResIncreaseTimeMap[k].predict = lastResIncreaseTime.predict + PowerIncreaseInfo.incSeconds
        break
      end
    end
  end
end

function RequestResourceChange()
  m_isRequesting = true
  this:GameRequest("fci/baseresource/update/"):SyncInput(false):Get(function(result)
    DBH.ResChange(result.resChange)
    for resType, lastResIncTime in pairs(result.lastResIncTime) do
      local resTypeInt = tonumber(resType)
      local _, resChange = table.find(result.resChange, function(k2, v2)
        return v2.baseRes.type == resTypeInt
      end)
      if resChange then
        m_lastResIncreaseTimeMap[resTypeInt] = {}
        m_lastResIncreaseTimeMap[resTypeInt].real = lastResIncTime
        m_lastResIncreaseTimeMap[resTypeInt].predict = lastResIncTime
      end
    end
    m_isRequesting = false
  end)
end

function GetLastResIncreaseTime(resType)
  local result
  local lastRecoveryTime = m_lastResIncreaseTimeMap[ResType]
  if lastRecoveryTime then
    local real = lastRecoveryTime.real or 0
    local predict = lastRecoveryTime.predict or 0
    result = math.max(real, predict)
  end
  return result
end

function GetPredictResource(resType, resValue)
  local predictValue = resValue
  local lastResIncreaseTime = m_lastResIncreaseTimeMap[resType]
  if lastResIncreaseTime then
    local real = lastResIncreaseTime.real or 0
    local predict = lastResIncreaseTime.predict or 0
    if real < predict and 0 < PowerIncreaseInfo.incSeconds then
      local predictDiff = math.floor((predict - real) / PowerIncreaseInfo.incSeconds)
      predictValue = math.min(resValue + predictDiff, PowerIncreaseInfo.max)
    end
  end
  return predictValue
end

function UpdatePowerTips()
  if not (m_powerPressed and m_showTips) or m_lastUpdateUtc == CS.GameTime.serverUtc then
    return
  end
  local recoverCycleString = WU.RenderCountDownTime(PowerIncreaseInfo.incSeconds, 32, false, true)
  local power = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[ResType] .. "_0")
  local lastRecoveryTime = GetLastResIncreaseTime(ResType)
  if not lastRecoveryTime then
    return
  end
  power = GetPredictResource(ResType, power)
  local nextRecoverText, allRecoverText
  if power < PowerIncreaseInfo.max then
    local serverUtc = CS.GameTime.serverUtc
    local elapsedTimeSinceLastRecovery = serverUtc - lastRecoveryTime
    nextRecoverText = WU.RenderCountDownTime(math.max(0, PowerIncreaseInfo.incSeconds - elapsedTimeSinceLastRecovery), 32)
    allRecoverText = WU.RenderCountDownTime(math.max(0, PowerIncreaseInfo.incSeconds * math.ceil((PowerIncreaseInfo.max - power) / PowerIncreaseInfo.inc) - elapsedTimeSinceLastRecovery), 32)
    local fullSeconds = math.max(0, PowerIncreaseInfo.incSeconds * math.ceil((PowerIncreaseInfo.max - power) / PowerIncreaseInfo.inc) - elapsedTimeSinceLastRecovery)
  else
    nextRecoverText = WU.GetString("Window_PowerAllRecovered")
    allRecoverText = WU.GetString("Window_PowerAllRecovered")
  end
  local intervalText = WU.GetString("Window_PowerReoverInterval", recoverCycleString, PowerIncreaseInfo.inc)
  nextRecoverText = WU.GetString("Window_PowerRecoverTimeFormat", nextRecoverText)
  allRecoverText = WU.GetString("Window_PowerRecoverTimeFormat", allRecoverText)
  local curPower = WU.GetString("Window_PowerCurrent") .. WU.GetString("Window_PowerRecoverTimeFormat", power .. "/" .. PowerIncreaseInfo.max)
  WU.ShowHoverTips2("HoverTipsPower", WU.GetString("Window_PowerRecoveryTitle"), curPower, WU.GetString("Window_PowerNextRecover"), nextRecoverText, WU.GetString("Window_PowerAllRecover"), allRecoverText, intervalText)
  m_lastUpdateUtc = CS.GameTime.serverUtc
end

function UpdateMoneyTips()
  if not (m_moneyPressed and m_showTips) or m_lastUpdateUtc == CS.GameTime.serverUtc then
    return
  end
  local allMoney = this:GetData("fci/resource/ResPlayerMoney_0") or 0
  local payMoney = this:GetData("fci/resource/ResPlayerPayMoney_0") or 0
  local text = WU.GetString("Window_Money_Tip", allMoney - payMoney, payMoney)
  WU.ShowHoverTips3(text)
  m_lastUpdateUtc = CS.GameTime.serverUtc
end

function OnPowerClick()
  WU.RecordButtonClick(991)
  WU.Exchange(PB.enum.ResourceType.ResPlayerPower)
end

function OnGoldClick()
  WU.RecordButtonClick(992)
  WU.Exchange(PB.enum.ResourceType.ResPlayerGold)
end

function OnMoneyClick()
  WU.RecordButtonClick(993)
  local topWindow = WU.TopWindow()
  if topWindow == nil or topWindow.name ~= "Purchase" then
    WU.AcquireWindowAsync("Purchase")
  end
end

function RecordPoint()
  local redRecord = WU.GetGameDataCache("MallRed" .. DB:GetData("playerId"))
  if redRecord == nil then
    redRecord = {}
  end
  for k, v in pairs(m_mapMallRed) do
    redRecord[tostring(k)] = v
  end
  WU.SetGameDataCache("MallRed" .. DB:GetData("playerId"), redRecord)
end

function RecordGiftActivityActivityIds()
  local activityIds = WU.GetGameDataCache("ActivityIds" .. DB:GetData("playerId"))
  local redPointRecord = WU.GetGameDataCache("RedPointRecordGiftActivity" .. DB:GetData("playerId"))
  if activityIds == nil then
    activityIds = {}
  end
  if redPointRecord == nil then
    redPointRecord = false
  end
  WU.SetGameDataCache("ActivityIds" .. DB:GetData("playerId"), activityIds)
  WU.SetGameDataCache("RedPointRecordGiftActivity" .. DB:GetData("playerId"), redPointRecord)
end

function OnSetPlayerMoney(money)
  if money then
    REF.labelMoneyValue.UILabel.text = tostring(money)
    if m_lastMoney ~= nil and money > m_lastMoney then
      local delta = money - m_lastMoney
    end
    m_lastMoney = money
    UpdateMallRed()
    UpdatePurchaseRedPoint()
  end
end

function OnSetPlayerPower(power)
  if power then
    REF.labelPowerValue.UILabel.text = tostring(power)
    local fullSeconds = math.max(0, PowerIncreaseInfo.incSeconds * math.ceil((PowerIncreaseInfo.max - power) / PowerIncreaseInfo.inc))
    this:BroadcastGameEvent("PowerFullSeconds", fullSeconds)
  end
end

function OnSetBaseResource(gold)
  if gold then
    REF.labelGoldValue.UILabel.text = tostring(gold)
    UpdateMallRed()
    UpdatePurchaseRedPoint()
  end
end

function OnSurpriseEvent(result)
  local realTopWindow = this:GetData("allWindowNameInfo")[1]
  local hasResource = PB.get("UIWindowConfig", realTopWindow).showResource
  if result and result.surpriseEvent then
    local info = result.surpriseEvent
    local expireTime = info.expireTime
    local lastTriggerTime = CS.GameTime.UtcToLocal(info.lastTriggerTime)
    local timeNow = CS.GameTime.serverNow
    local endTime = lastTriggerTime:AddSeconds(expireTime)
    local mallInfo = PB.get("Mall", info.mallResId)
    if mallInfo == nil then
      return
    end
    if timeNow < endTime then
      if m_mallRecord[info.mallResId] and m_mallRecord[info.mallResId] >= mallInfo.maxBuyCount then
        REF.NodeEffect.gameObject:SetActive(false)
      else
        REF.NodeEffect.gameObject:SetActive(true)
      end
      if not info.isChecked and hasResource then
        WU.AcquireWindowAsync("SurpriseEventUp", function(window)
          _ENV["$"](window)["$$SetData"](result)
          this:GameRequest("fci/surprise-event/" .. info.eventUid .. "/"):Patch({
            eventUid = info.eventUid
          }, function()
            result.surpriseEvent.isChecked = true
          end)
        end)
      end
    end
  end
end

function OnHasGiftSaku(result)
  if not result then
    REF.NodeEffect.gameObject:SetActive(false)
  elseif m_hasGetGiftSaku ~= nil and not m_hasGetGiftSaku then
    REF.NodeEffect.gameObject:SetActive(true)
  end
end

function OnHasGetGiftSaku(result)
  if result == nil then
    m_hasGetGiftSaku = nil
    return
  end
  m_hasGetGiftSaku = not result
end
