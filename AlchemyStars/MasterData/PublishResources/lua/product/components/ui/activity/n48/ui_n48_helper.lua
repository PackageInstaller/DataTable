local ActivityN48ComponentStatus = {
  None = 0,
  Open = 1,
  Close = 2,
  TimeLock = 3,
  MissionLock = 4,
  ActivityEnd = 5
}
_enum("ActivityN48ComponentStatus", ActivityN48ComponentStatus)
local N48ToolFunctions = {
  GetRemainTime = function(time, color)
    local colorStart, colorEnd, day, hour, minute, daystr, hourstr, minutestr
    day = math.floor(time / 86400)
    hour = math.floor(time / 3600) % 24
    minute = math.floor(time / 60) % 60
    if color then
      colorStart = "<color=#" .. color .. ">"
      colorEnd = "</color>"
      if day then
        daystr = colorStart .. day .. colorEnd
      else
        daystr = day
      end
      if hour then
        hourstr = colorStart .. hour .. colorEnd
      else
        hourstr = hour
      end
      if minute then
        minutestr = colorStart .. minute .. colorEnd
      else
        minutestr = minute
      end
    else
      daystr = day
      hourstr = hour
      minutestr = minute
    end
    local timestring = ""
    if 0 < day then
      timestring = daystr .. StringTable.Get("str_activity_common_day")
      if 0 < hour then
        timestring = timestring .. hourstr .. StringTable.Get("str_activity_common_hour")
      end
    elseif 0 < hour then
      timestring = hourstr .. StringTable.Get("str_activity_common_hour")
      if 0 < minute then
        timestring = timestring .. minutestr .. StringTable.Get("str_activity_common_minute")
      end
    elseif 0 < minute then
      timestring = minutestr .. StringTable.Get("str_activity_common_minute")
    else
      timestring = StringTable.Get("str_activity_common_less_minute")
    end
    return timestring
  end,
  GetRemainTimer = function(endtime)
    local remainTime = 0
    local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
    local curtime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    remainTime = endtime - curtime
    return remainTime
  end,
  ShowRewards = function(rewards, callback)
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
  end,
  SetGrey = function(objs, gray)
    if not objs then
      return
    end
    for _, obj in pairs(objs) do
      local rawimg = obj.gameObject:GetComponent("RawImage")
      local emiMat = UnityEngine.Material:New(rawimg.material)
      local texture = rawimg.material.mainTexture
      rawimg.material = emiMat
      rawimg.material.mainTexture = texture
      rawimg.material:SetFloat("_LuminosityAmount", gray)
    end
  end,
  GetItemIcon = function(itemid)
    local cfg = Cfg.cfg_item[itemid]
    if not cfg then
      return ""
    end
    return cfg.Icon
  end,
  GetLottleryNewName = function()
    local dbStr = "N48LottleryNew"
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstid = roleModule:GetPstId()
    dbStr = dbStr .. pstid
    return dbStr
  end,
  GetLocalPoltNewName = function(polt_id)
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstid = roleModule:GetPstId()
    local dbStr = "N48" .. polt_id .. pstid
    return dbStr
  end,
  GetBigRawrdData = function()
    local data = {}
    data.size = {356, 357}
    data.state = {
      nomarl = "N48_shop_grand1",
      select = "N48_shop_grand2",
      pop = "N48_shop_grand3",
      grey = "N48_shop_grand4"
    }
    data.getPos = {}
    return data
  end
}
_enum("N48ToolFunctions", N48ToolFunctions)
_class("UIActivityN48Helper", Object)
UIActivityN48Helper = UIActivityN48Helper

function UIActivityN48Helper.GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. id
  return key
end

function UIActivityN48Helper.GetNewFlagStatus(id)
  local key = UIActivityN48Helper.GetNewFlagKey(id)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIActivityN48Helper.SetNewFlagStatus(id, status)
  local key = UIActivityN48Helper.GetNewFlagKey(id)
  if status then
    UnityEngine.PlayerPrefs.SetInt(key, 0)
  else
    UnityEngine.PlayerPrefs.SetInt(key, 1)
  end
end

function UIActivityN48Helper.LocalDB_Get_CrossDay(btnName, funcName)
  local lastTime = UIActivityN48Helper.LocalDB_Get(btnName, funcName)
  Log.debug("UICN12N41Helper.LocalDB_Get_CrossDay() btnName =", btnName, ", funcName =", funcName, ", lastTime =", lastTime)
  local isCross = HelperProxy:IsCrossDayTo(lastTime)
  return isCross
end

function UIActivityN48Helper.LocalDB_Set_CrossDay(btnName, funcName)
  local value = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  UIActivityN48Helper.LocalDB_Set(btnName, funcName, value)
end

function UIActivityN48Helper.LocalDB_Get(btnName, funcName, value)
  value = value or 1
  local key = UIActivityN48Helper._LocalDB_GetKey(btnName, funcName)
  return LocalDB.GetInt(key, value)
end

function UIActivityN48Helper.LocalDB_Set(btnName, funcName, value)
  value = value or 1
  local key = UIActivityN48Helper._LocalDB_GetKey(btnName, funcName)
  LocalDB.SetInt(key, value)
end

function UIActivityN48Helper._LocalDB_GetKey(btnName, funcName)
  local key = "UIActivityN48Helper_" .. btnName .. "_" .. funcName .. "_"
  return UIActivityHelper.GetLocalDBKeyWithPstId(key)
end

function UIActivityN48Helper.GetComponentId(name)
  local tb = {
    login = ECampaignN48ComponentID.CUMULATIVE_LOGIN,
    power = ECampaignN48ComponentID.POWER2ITEM,
    line = ECampaignN48ComponentID.LINE_MISSION,
    black = ECampaignN48ComponentID.HEIXIA,
    shop = ECampaignN48ComponentID.SHOP,
    shared = ECampaignN48ComponentID.SHARED,
    game = ECampaignN48ComponentID.MINI_GAME
  }
  return tb[name]
end

function UIActivityN48Helper.CheckComponentStatus(component)
  if not component then
    return ActivityN48ComponentStatus.Close, 0
  end
  local info = component:GetComponentInfo()
  if not info then
    return ActivityN48ComponentStatus.Close, 0
  end
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if curTime >= info.m_close_time then
    return ActivityN48ComponentStatus.Close, 0
  end
  local opentTime = info.m_open_time
  local unLockTime = info.m_unlock_time
  local time = opentTime
  if unLockTime > time then
    time = unLockTime
  end
  if curTime > time then
    if not info.m_b_unlock then
      return ActivityN48ComponentStatus.MissionLock, 0
    end
    return ActivityN48ComponentStatus.Open, info.m_close_time - curTime
  end
  return ActivityN48ComponentStatus.TimeLock, time - curTime
end
