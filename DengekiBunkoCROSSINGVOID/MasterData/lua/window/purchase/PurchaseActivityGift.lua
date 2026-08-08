local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local ACU = require("Common/ActivityUtil")
local m_iaphandler = S:Get("IAPHandler")
local m_activityManager = S:Get("ActivityManager")
local m_data
local m_remainTime = 0
local m_slotRef, m_giftInfos, m_mapMallRecord
local m_viewedList = {}

function UpdateWidget(go, wrapIndex, realIndex)
  local slotRef = _ENV["$"](go)
  if m_giftInfos then
    local giftInfo = m_giftInfos[realIndex + 1]
    if giftInfo then
      m_slotRef[giftInfo.id] = slotRef
      slotRef["$$SetData"](giftInfo, _ENV["$"](this))
    end
  end
end

function Awake()
  this:RegisterGameEvent("UpdateMallData", UpdateData)
  this:RegisterGameEvent("UpdateSale", function(id, buyCount)
    if m_slotRef == nil then
      return
    end
    local ref = m_slotRef[id]
    if ref then
      ref["$$SetBuyCount"](tonumber(buyCount))
    end
    SetDataBuyCount(id, tonumber(buyCount))
    UpdateData()
  end)
  this:RegisterGameEvent("PushTypePurchaseBuyRecord", function(params)
    local purchaseId = params[1]
    local mallInfo = GetMallInfoByProductID(purchaseId)
    if mallInfo then
      local ref = m_slotRef[mallInfo.id]
      local buyCount = tonumber(params[2])
      if ref then
        ref["$$SetBuyCount"](buyCount)
      end
      SetDataBuyCount(mallInfo.id, buyCount)
    end
  end)
  this:Bind("ActivityList", function(activityResp)
    if activityResp then
      UpdateData()
    end
  end)
end

function SetDataBuyCount(id, buyCount)
  local mallData = m_mapMallRecord[id]
  if mallData then
    mallData.buyCount = buyCount
  end
end

function UpdateBuyCount()
  this:GameRequest("fci/mall-info/"):Get(function(response)
    DB:SetData("fci/mall-info/", response)
    for k, v in pairs(response.mallRecord.summary) do
      local key = tonumber(k)
      local buyCount = tonumber(v.buyCount)
      SetDataBuyCount(key, buyCount)
    end
    for k, v in pairs(response.purchaseRecord.buyRecord) do
      local mallInfo = GetMallInfoByProductID(k)
      if mallInfo ~= nil then
        SetDataBuyCount(mallInfo.id, v.buyCount)
      end
    end
    UpdateData()
  end)
end

function GetMallInfoByProductID(proID)
  if m_data == nil then
    return nil
  end
  for i, v in ipairs(m_data) do
    if v.productId == proID then
      local activity = m_activityManager.GetActivitySync(PB.enum.ActivityType.Mall, v.activityId)
      if activity ~= nil and ACU.IsOpenForDoing(activity) then
        return v
      end
    end
  end
  return nil
end

function IsSaleFinish(data)
  if data.buyCount and data.buyCount >= data.maxBuyCount and data.maxBuyCount > 0 then
    return true
  end
  return false
end

function Start()
  this:RegisterGameEvent("UpdateActivityViewed", function()
    WU.SetGameDataCache("ActivityId_Viewed" .. DB:GetData("playerId"), m_viewedList)
  end)
end

function UpdateData()
  if m_data == nil then
    return
  end
  local activityInfoList = DB:GetData("ActivityList")
  m_slotRef = {}
  local activityIDs = {}
  m_viewedList = {}
  if activityInfoList then
    local localTime = CS.GameTime.serverNow
    local dayOfWeek = U.ToInt(localTime.DayOfWeek)
    if dayOfWeek == 0 then
      dayOfWeek = 7
    end
    for i, v in pairs(activityInfoList) do
      local preheartTime
      if v.type == PB.enum.ActivityType.Mall then
        local shouldAdd = false
        local isPreheat = false
        local maxDay = 0
        local minDay = 999
        if v.weekdays then
          for i, day in ipairs(v.weekdays) do
            if day < minDay then
              minDay = day
            end
            if day > maxDay then
              maxDay = day
            end
          end
        end
        local preheatOrder = v.timestampPreheat < CS.GameTime.serverUtc and CS.GameTime.serverUtc < v.timestampStart
        if v.timestampPreheat and 0 < v.timestampPreheat then
          shouldAdd = v.timestampPreheat < CS.GameTime.serverUtc and CS.GameTime.serverUtc < v.timestampStart
          isPreheat = true
        end
        if v.weekdayPreheart and 0 < v.weekdayPreheart and CS.GameTime.serverUtc > v.timestampStart and CS.GameTime.serverUtc < v.timestampEnd then
          if dayOfWeek < minDay then
            local willTime = CS.System.DateTime(localTime.Year, localTime.Month, localTime.Day)
            willTime = willTime:AddDays(minDay - dayOfWeek)
            isPreheat = true
            shouldAdd = true
            preheartTime = CS.GameTime.ToSecondsForTimeZone(willTime)
          elseif dayOfWeek > maxDay then
            local willTime = CS.System.DateTime(localTime.Year, localTime.Month, localTime.Day)
            willTime = willTime:AddDays(minDay + 7 - dayOfWeek)
            isPreheat = true
            shouldAdd = true
            preheartTime = CS.GameTime.ToSecondsForTimeZone(willTime)
          elseif dayOfWeek >= minDay and dayOfWeek <= maxDay then
            shouldAdd = true
            local willTime = CS.System.DateTime(localTime.Year, localTime.Month, localTime.Day)
            willTime = willTime:AddDays(maxDay - dayOfWeek + 1)
            v.timestampEnd = CS.GameTime.ToSecondsForTimeZone(willTime)
          end
        end
        if not shouldAdd and ACU.IsOpenForDoing(v) then
          shouldAdd = true
        end
        if shouldAdd then
          local activity = {}
          activity.id = v.activityId
          activity.startTime = v.timestampStart
          activity.endTime = v.timestampEnd
          activity.isPreheat = isPreheat
          activity.preheatOrder = preheatOrder
          activity.isNew = ACU.IsOpenForDoing(v) and not table.has(WU.GetGameDataCache("ActivityId_Viewed" .. DB:GetData("playerId")), v.activityId)
          local refreshTime = CS.System.DateTime(localTime.Year, localTime.Month, localTime.Day)
          if 0 < maxDay then
            local weekRefreshTime = refreshTime:AddDays(maxDay - dayOfWeek + 1)
            weekRefreshTime = CS.GameTime.ToSecondsForTimeZone(weekRefreshTime)
            if weekRefreshTime > activity.endTime then
              weekRefreshTime = nil
            end
            activity.weekRefreshTime = weekRefreshTime
          end
          local dayRefreshTime = v.timestampEnd
          activity.dayRefreshTime = dayRefreshTime
          if ACU.IsOpenForDoing(v) then
            table.insert(m_viewedList, v.activityId)
          end
          if preheartTime then
            activity.preheartTime = preheartTime
          end
          activityIDs[#activityIDs + 1] = activity
        end
      end
    end
  end
  local curDirctPurchaseGiftIds = WU.GetGameDataCache("DirctPurchaseGiftIds" .. DB:GetData("playerId")) or {}
  local ids = {}
  local giftInfos = {}
  for j, giftInfo in ipairs(m_data) do
    if giftInfo.activityId == 0 then
      if IsGiftDisplayNow(giftInfo) then
        giftInfos[#giftInfos + 1] = giftInfo
      end
    else
      for i, activity in ipairs(activityIDs) do
        if giftInfo.activityId == activity.id then
          local product
          local isProduct = giftInfo.productId and giftInfo.productId ~= ""
          if isProduct then
            product = m_iaphandler.GetProductsByID(giftInfo.productId)
          end
          if not isProduct or product ~= nil then
            giftInfo.startTime = activity.startTime
            giftInfo.endTime = activity.endTime
            giftInfo.isPreheat = activity.isPreheat
            giftInfo.preheartTime = activity.preheartTime
            giftInfo.preheatOrder = activity.preheatOrder
            giftInfo.isNew = activity.isNew
            giftInfos[#giftInfos + 1] = giftInfo
          end
          if giftInfo.maxCountClearInterval == PB.enum.MallBuyIntervalType.Day then
            giftInfo.refreshTime = activity.dayRefreshTime
          elseif giftInfo.maxCountClearInterval == PB.enum.MallBuyIntervalType.Week then
            giftInfo.refreshTime = activity.weekRefreshTime
          else
            giftInfo.refreshTime = nil
          end
          if giftInfo.giftPage == 3 then
            table.insert(ids, giftInfo.activityId)
            giftInfo.isNew = table.find(curDirctPurchaseGiftIds, function(k, v)
              return v == giftInfo.activityId
            end) == nil
          end
          break
        end
      end
    end
  end
  if 0 < #giftInfos and giftInfos[1].giftPage == 3 then
    WU.SetGameDataCache("DirctPurchaseGiftIds" .. DB:GetData("playerId"), ids)
  end
  table.sort(giftInfos, function(a, b)
    local isSaleFinishA = IsSaleFinish(a)
    local isSaleFinishB = IsSaleFinish(b)
    if isSaleFinishA ~= isSaleFinishB then
      return isSaleFinishA ~= true
    elseif isSaleFinishA == true then
      return a.id < b.id
    elseif a.giftType ~= b.giftType then
      return a.giftType == PB.enum.GiftType.DailyRandomRefresh
    elseif a.preheatOrder ~= b.preheatOrder then
      return a.preheatOrder ~= true
    else
      return a.id < b.id
    end
  end)
  if #giftInfos == 0 then
    REF.SpriteTips.gameObject:SetActive(true)
    REF.Drag.gameObject:SetActive(false)
  else
    REF.SpriteTips.gameObject:SetActive(false)
    REF.Drag.gameObject:SetActive(true)
  end
  local slotIndex = 0
  local slotCount = #REF.ItemList
  for i, v in ipairs(giftInfos) do
    slotIndex, slotCount = SetAttrImpl(v, REF.ItemList, slotIndex, slotCount)
  end
  for i = slotIndex, slotCount - 1 do
    REF.ItemList[i]["$gameObject"]:SetActive(false)
  end
  REF.ItemList.UITable:Reposition()
  m_giftInfos = giftInfos
end

function IsGiftDisplayNow(giftConfig)
  if giftConfig.giftType ~= PB.enum.GiftType.DailyRandomRefresh then
    return true
  end
  local mallInfo = this:GetData("fci/mall-info/")
  if mallInfo == nil or mallInfo.mallRecord == nil then
    return false
  end
  local dailyIds = mallInfo.mallRecord.dailyMallId
  if dailyIds == nil or dailyIds[1] == nil then
    return false
  end
  local _, v = table.find(dailyIds, function(k1, v1)
    return v1 == giftConfig.id
  end)
  if v ~= nil and v ~= 0 then
    giftConfig.endTime = mallInfo.mallRecord.dailyMallRefreshTime
    local infos = WU.GetGameDataCache("DailyRandomRefreshe" .. DB:GetData("playerId")) or _ENV["!"]({})
    local record = infos[giftConfig.id]
    if record == nil or record.showNew == true or record.refreshTime < mallInfo.mallRecord.dailyMallRefreshTime then
      giftConfig.isNew = true
      infos[giftConfig.id] = {
        showNew = false,
        refreshTime = mallInfo.mallRecord.dailyMallRefreshTime
      }
      WU.SetGameDataCache("DailyRandomRefreshe" .. DB:GetData("playerId"), infos)
    else
      giftConfig.isNew = false
    end
    return true
  else
    return false
  end
end

function SetGiftPage(giftPage)
  m_data = PB.all("Mall"):where(function(_, p)
    return p.isMonth == false and p.giftPage == giftPage
  end):toarray()
  m_mapMallRecord = {}
  for i, v in ipairs(m_data) do
    m_mapMallRecord[v.id] = v
    v.buyCount = 0
  end
  WU.TraverseChildren(REF.ItemList, function(g)
    g:SetActive(false)
  end)
  UpdateBuyCount()
  REF.ScrollView.UIScrollView:ResetPosition()
end

function SetAttrImpl(attr, listGasket, slotIndex, slotCount)
  local slotRef
  if slotIndex < slotCount then
    slotRef = listGasket[slotIndex]
  else
    local source = listGasket[0]["$gameObject"]
    local clone = CS.UnityEngine.GameObject.Instantiate(source, listGasket.transform)
    clone.name = source.name
    slotRef = _ENV["$"](clone)
    slotCount = slotCount + 1
  end
  slotRef["$gameObject"]:SetActive(true)
  slotRef["$$SetData"](attr)
  slotIndex = slotIndex + 1
  m_slotRef[attr.id] = slotRef
  return slotIndex, slotCount
end
