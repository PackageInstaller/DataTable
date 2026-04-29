local ActivityN28ComponentStatus = {
  None = 0,
  Open = 1,
  Close = 2,
  TimeLock = 3,
  MissionLock = 4,
  ActivityEnd = 5
}
_enum("ActivityN28ComponentStatus", ActivityN28ComponentStatus)
_class("UIActivityN28Helper", Object)
UIActivityN28Helper = UIActivityN28Helper

function UIActivityN28Helper:Constructor()
end

function UIActivityN28Helper.CheckComponentStatus(component)
  if not component then
    return ActivityN28ComponentStatus.Close, 0
  end
  local info = component:GetComponentInfo()
  if not info then
    return ActivityN28ComponentStatus.Close, 0
  end
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if curTime >= info.m_close_time then
    return ActivityN28ComponentStatus.Close, 0
  end
  local opentTime = info.m_open_time
  local unLockTime = info.m_unlock_time
  local time = opentTime
  if unLockTime > time then
    time = unLockTime
  end
  if curTime > time then
    if not info.m_b_unlock then
      return ActivityN28ComponentStatus.MissionLock, 0
    end
    return ActivityN28ComponentStatus.Open, info.m_close_time - curTime
  end
  return ActivityN28ComponentStatus.TimeLock, time - curTime
end

function UIActivityN28Helper.GetRemainString(seconds)
  if seconds < 0 then
    seconds = 0
  end
  local days = math.floor(seconds / 86400)
  local remainingSeconds = seconds % 86400
  local hours = math.floor(remainingSeconds / 3600)
  remainingSeconds = remainingSeconds % 3600
  local minutes = math.floor(remainingSeconds / 60)
  days = string.format("%02d", days)
  hours = string.format("%02d", hours)
  minutes = string.format("%02d", minutes)
  local timeStr = StringTable.Get("str_n28_main_btn_unlock_time", days .. ":", hours .. ":", minutes)
  if seconds < 60 then
    timeStr = StringTable.Get("str_n28_less_one_minus")
  end
  return timeStr
end

function UIActivityN28Helper.GetTimeString(seconds)
  if seconds < 0 then
    seconds = 0
  end
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_n28_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_n28_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_n28_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get("str_n28_minus", minus)
    end
  else
    timeStr = StringTable.Get("str_n28_less_one_minus")
  end
  return timeStr
end

function UIActivityN28Helper.GetItemCountStr(byteCount, count, preColor, countColor)
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
  if 0 <= count then
    for i = 1, byteCount - dight do
      pre = pre .. "0"
    end
  else
    for i = 1, byteCount - dight - 1 do
      pre = pre .. "0"
    end
  end
  if 0 < count then
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  elseif count == 0 then
    return string.format("<color=" .. preColor .. ">%s</color>", pre)
  else
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  end
end

function UIActivityN28Helper.ShowRewards(rewards, callback)
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

function UIActivityN28Helper.GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. id
  return key
end

function UIActivityN28Helper.GetNewFlagStatus(id)
  local key = UIActivityN28Helper.GetNewFlagKey(id)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIActivityN28Helper.SetNewFlagStatus(id, status)
  local key = UIActivityN28Helper.GetNewFlagKey(id)
  if status then
    UnityEngine.PlayerPrefs.SetInt(key, 0)
  else
    UnityEngine.PlayerPrefs.SetInt(key, 1)
  end
end

function UIActivityN28Helper.CheckHard(component)
  if not component then
    return ActivityN28ComponentStatus.Close, 0
  end
  local info = component:GetComponentInfo()
  if not info then
    return ActivityN28ComponentStatus.Close, 0
  end
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if curTime >= info.m_close_time then
    return ActivityN28ComponentStatus.Close, 0
  end
  local opentTime = info.m_open_time
  local unLockTime = info.m_unlock_time
  local time = opentTime
  if unLockTime > time then
    time = unLockTime
  end
  if curTime > time then
    return ActivityN28ComponentStatus.Open, info.m_close_time - curTime
  end
  return ActivityN28ComponentStatus.TimeLock, time - curTime
end

function UIActivityN28Helper.LocalDB_Get_CrossDay(btnName, funcName)
  local lastTime = UIActivityN28Helper.LocalDB_Get(btnName, funcName)
  Log.debug("UICN12N41Helper.LocalDB_Get_CrossDay() btnName =", btnName, ", funcName =", funcName, ", lastTime =", lastTime)
  local isCross = HelperProxy:IsCrossDayTo(lastTime)
  return isCross
end

function UIActivityN28Helper.LocalDB_Set_CrossDay(btnName, funcName)
  local value = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  UIActivityN28Helper.LocalDB_Set(btnName, funcName, value)
end

function UIActivityN28Helper.LocalDB_Get(btnName, funcName, value)
  value = value or 1
  local key = UIActivityN28Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.GetInt(key, value)
end

function UIActivityN28Helper.LocalDB_Set(btnName, funcName, value)
  value = value or 1
  local key = UIActivityN28Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.SetInt(key, value)
end

function UIActivityN28Helper._LocalDB_GetKey(btnName, funcName)
  local key = "UIActivityN28Helper_" .. btnName .. "_" .. funcName .. "_"
  return UIActivityHelper.GetLocalDBKeyWithPstId(key)
end
