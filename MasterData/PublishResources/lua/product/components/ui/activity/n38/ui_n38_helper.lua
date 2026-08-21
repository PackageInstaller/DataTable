_class("UIN38Helper", Object)
UIN38Helper = UIN38Helper

function UIN38Helper:Constructor()
end

function UIN38Helper.GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N9
end

function UIN38Helper.GetComponentId(name)
  local tb = {
    login = ECampaignCN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN,
    line = ECampaignCN9ComponentID.ECAMPAIGN_N9_LINE_MISSION,
    hard = ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION,
    black = ECampaignCN9ComponentID.ECAMPAIGN_N9_HEIXIA,
    power = ECampaignCN9ComponentID.ECAMPAIGN_N9_POWER2ITEM,
    exchange = ECampaignCN9ComponentID.ECAMPAIGN_N9_SHOP
  }
  return tb[name]
end

function UIN38Helper.GetComponent(campaign, name)
  local cmptId = UIN38Helper.GetComponentId(name)
  local component = campaign:GetComponent(cmptId)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return cmptId, component, componentInfo
end

function UIN38Helper.CheckComponentStatus(component)
  if not component then
    return ActivityComponentStatus.Close, 0
  end
  local info = component:GetComponentInfo()
  if not info then
    return ActivityComponentStatus.Close, 0
  end
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if curTime >= info.m_close_time then
    return ActivityComponentStatus.Close, 0
  end
  local opentTime = info.m_open_time
  local unLockTime = info.m_unlock_time
  local time = opentTime
  if unLockTime > time then
    time = unLockTime
  end
  if curTime > time then
    if not info.m_b_unlock then
      return ActivityComponentStatus.MissionLock, 0
    end
    return ActivityComponentStatus.Open, info.m_close_time - curTime
  end
  return ActivityComponentStatus.TimeLock, time - curTime
end

function UIN38Helper.GetTimeString(seconds)
  if seconds < 0 then
    seconds = 0
  end
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_n26_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_n26_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_n26_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get("str_n26_minus", minus)
    end
  else
    timeStr = StringTable.Get("str_n26_less_one_minus")
  end
  return timeStr
end

function UIN38Helper.GetItemCountStr(byteCount, count, preColor, countColor)
  local dight = 0
  local tmpCount = count
  if tmpCount < 0 then
    tmpCount = -tmpCount
  end
  while 0 < tmpCount do
    tmpCount = math.floor(tmpCount / 10)
    dight = dight + 1
  end
  local pre = ""
  for i = 1, byteCount - dight do
    pre = pre .. "0"
  end
  if 0 < count then
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  else
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", "000000", count)
  end
end

function UIN38Helper.ShowRewards(rewards, callback)
  local petIdList = {}
  local mPet = GameGlobal.GetModule(PetModule)
  for _, reward in pairs(rewards) do
    if mPet:IsPetID(reward.assetid) then
      table.insert(petIdList, reward)
    end
  end
  if table.count(petIdList) > 0 then
    GameGlobal.UIStateManager():ShowDialog("UIPetObtain", petIdList, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      GameGlobal.UIStateManager():ShowDialog("UIGetItemController", rewards, function()
        if callback then
          callback()
        end
      end)
    end)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIGetItemController", rewards, function()
    if callback then
      callback()
    end
  end)
end

function UIN38Helper.GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. id
  return key
end

function UIN38Helper.GetNewFlagStatus(id)
  local key = UIN38Helper.GetNewFlagKey(id)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIN38Helper.SetNewFlagStatus(id, status)
  local key = UIN38Helper.GetNewFlagKey(id)
  if status then
    UnityEngine.PlayerPrefs.SetInt(key, 0)
  else
    UnityEngine.PlayerPrefs.SetInt(key, 1)
  end
end

function UIN38Helper._LocalDB_GetKey(btnName, funcName)
  local key = "UIN38Helper" .. btnName .. "_" .. funcName .. "_"
  return UIActivityHelper.GetLocalDBKeyWithPstId(key)
end

function UIN38Helper.LocalDB_Has(btnName, funcName)
  local key = UIN38Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.HasKey(key)
end

function UIN38Helper.LocalDB_Get(btnName, funcName, value)
  value = value or 1
  local key = UIN38Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.GetInt(key, value)
end

function UIN38Helper.LocalDB_Set(btnName, funcName, value)
  value = value or 1
  local key = UIN38Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.SetInt(key, value)
end

function UIN38Helper.LocalDB_Delete(btnName, funcName)
  local key = UIN38Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.Delete(key)
end

function UIN38Helper.SetBattlePassBtn(uiView, widgetName, bp_campaign)
  local useStateUI = false
  local open_sample = bp_campaign:CheckCampaignOpen()
  if open_sample then
    local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonCampaignEnter")
    obj:SetData(bp_campaign, useStateUI)
  end
  local obj = uiView:GetGameObject(widgetName)
  obj:SetActive(open_sample)
end

function UIN38Helper.SetExchangeBtn(uiView, widgetName, campaign)
  local cmptId, component, componentInfo = UIN38Helper.GetComponent(campaign, "exchange")
  local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, "UIActivityCommonComponentEnter")
  local btnName = "ExchangeBtn"
  
  local function newCallback()
    local new = not UIN38Helper.LocalDB_Has(btnName, "New")
    return new
  end
  
  obj:SetNew("New", newCallback)
  
  local function redCallback()
    return campaign:CheckComponentOpen(cmptId) and campaign:CheckComponentRed(cmptId)
  end
  
  obj:SetRed("Red", redCallback)
  local color1, color2 = "#71a29c", "#ffffff"
  UIN38Helper.SetExchangeCostItem_PreZero(component, obj, "Icon", "Count", color1, color2)
  
  local function clickCallback()
    UIN38Helper.LocalDB_Set(btnName, "New")
    GameGlobal.UIStateManager():ShowDialog("UIN38Shop")
  end
  
  obj:SetData(campaign, clickCallback)
end

function UIN38Helper.SetExchangeCostItem_PreZero(component, uiView, widgeIcon, widgeCount, color1, color2)
  local itemId = component:GetCostItemId()
  UIWidgetHelper.SetItemIcon(uiView, itemId, widgeIcon)
  UIWidgetHelper.SetItemCount(uiView, itemId, widgeCount, function(count)
    count = math.min(count, 999999)
    local preZero = UIActivityHelper.GetZeroStrFrontNum(6, count)
    local str = UIActivityHelper.GetColorText(color1, preZero, color2, tostring(count))
    return str
  end)
end

function UIN38Helper.IsFirstTimeEnterToday(key)
  key = UIActivityHelper.GetLocalDBKeyWithPstId(key)
  local time = LocalDB.GetInt(key, -1)
  local first = false
  if time == -1 then
    first = true
  else
    local now = GetSvrTimeNow()
    if 86400 < now - time then
      first = true
    else
      local crossDay = HelperProxy:GetInstance():IsCrossDayTo(time)
      if crossDay then
        first = true
      end
    end
  end
  return first
end

function UIN38Helper.SetFirstEnterTodayFlag(key)
  key = UIActivityHelper.GetLocalDBKeyWithPstId(key)
  local now = GetSvrTimeNow()
  LocalDB.SetInt(key, now)
end
