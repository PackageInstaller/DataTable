local ActivityComponentStatus = {
  None = 0,
  Open = 1,
  Close = 2,
  TimeLock = 3,
  MissionLock = 4,
  ActivityEnd = 5
}
_enum("ActivityComponentStatus", ActivityComponentStatus)
_class("UIActivityCustomHelper", Object)
UIActivityCustomHelper = UIActivityCustomHelper

function UIActivityCustomHelper:Constructor()
end

function UIActivityCustomHelper.CheckComponentStatus(component)
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
    if (next(info.m_unlock_items) or info.m_need_mission_id ~= 0) and not info.m_b_unlock then
      return ActivityComponentStatus.MissionLock, 0
    end
    return ActivityComponentStatus.Open, info.m_close_time - curTime
  end
  return ActivityComponentStatus.TimeLock, time - curTime
end

function UIActivityCustomHelper.GetTimeString(seconds, dayStr, hourStr, minusStr, lessOneMinusStr)
  if seconds < 0 then
    seconds = 0
  end
  dayStr = dayStr or "str_activity_day"
  hourStr = hourStr or "str_activity_hour"
  minusStr = minusStr or "str_activity_minus"
  lessOneMinusStr = lessOneMinusStr or "str_activity_less_one_minus"
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get(dayStr, day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get(hourStr, hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get(hourStr, hour)
    end
    local minus = math.floor(seconds / 60)
    if 0 < minus then
      timeStr = timeStr .. StringTable.Get(minusStr, minus)
    end
  else
    timeStr = StringTable.Get(lessOneMinusStr)
  end
  return timeStr
end

function UIActivityCustomHelper.GetItemCountStr(byteCount, count, preColor, countColor)
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

function UIActivityCustomHelper.ShowRewards(rewards, callback)
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

function UIActivityCustomHelper.GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. id
  return key
end

function UIActivityCustomHelper.GetNewFlagStatus(id)
  local key = UIActivityCustomHelper.GetNewFlagKey(id)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIActivityCustomHelper.SetNewFlagStatus(id, status)
  local key = UIActivityCustomHelper.GetNewFlagKey(id)
  if status then
    UnityEngine.PlayerPrefs.SetInt(key, 0)
  else
    UnityEngine.PlayerPrefs.SetInt(key, 1)
  end
end
