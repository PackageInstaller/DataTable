_class("UIN0CookData", Object)
UIN0CookData = UIN0CookData

function UIN0CookData:LoadData(TT, res)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_DINNER, CampaignComType.E_CAMPAIGN_COM_NEWYEAR_DINNER)
  if res and not res:GetSucc() then
    return
  end
  if not self._campaign then
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._cookComp = self._localProcess:GetComponent(ECCampaignInlandDinnerComponentID.ECAMPAIGN_INLAND_DINNER)
  self._cookCompInfo = self._localProcess:GetComponentInfo(ECCampaignInlandDinnerComponentID.ECAMPAIGN_INLAND_DINNER)
  self._componentId = self._cookCompInfo.m_campaign_id * 100000 + self._cookCompInfo.m_component_type * 100 + self._cookCompInfo.m_component_id
end

function UIN0CookData:InitWith(campain, cookComp, cookCompInfo)
  self._campaign = campain
  self._cookComp = cookComp
  self._cookCompInfo = cookCompInfo
  self._componentId = self._cookCompInfo.m_campaign_id * 100000 + self._cookCompInfo.m_component_type * 100 + self._cookCompInfo.m_component_id
end

function UIN0CookData:GetCampaign()
  return self._campaign
end

function UIN0CookData:GetComponnet()
  return self._cookComp, self._cookCompInfo
end

function UIN0CookData:GetFirstPlayStoryID()
  local storyID = self._cookCompInfo.m_first_story_id
  return storyID
end

function UIN0CookData:CheckFirstPlayStory()
  return UIN0CookData.CheckRed_FirstStory(self._cookCompInfo)
end

function UIN0CookData:SetFirstPlayStoryAsRead()
  local key = UIN0CookData.GetFirstStoryKey(self._cookCompInfo)
  UIN0CookData.SetKey(key)
end

function UIN0CookData:GetEndPlayStoryID()
  local gKey = UIN0CookData.GetEndStoryKey(self._cookCompInfo)
  local cfgGlobal = Cfg.cfg_global[gKey]
  if cfgGlobal then
    return cfgGlobal.IntValue
  end
end

function UIN0CookData:GetMakeFoodNum()
  local data_info = self._cookCompInfo.data_info
  local food_list = data_info.food_list
  local count = 0
  if food_list then
    for k, v in pairs(food_list) do
      if v >= NewYearDinner_Status.E_NewYearDinner_Status_CAN_RECV then
        count = count + 1
      end
    end
  end
  return count
end

function UIN0CookData.GetCompInfoByCampaingn(campaingn)
  local localProcess = campaingn:GetLocalProcess()
  if not localProcess then
    return
  end
  local cookCompInfo = localProcess:GetComponentInfo(ECCampaignInlandDinnerComponentID.ECAMPAIGN_INLAND_DINNER)
  return cookCompInfo
end

function UIN0CookData.CheckRed_MatRequire(compInfo)
  local task_list = compInfo.task_list
  for k, v in pairs(task_list) do
    if v.status == NewYearDinner_Status.E_NewYearDinner_Status_CAN_RECV then
      return true
    end
  end
  return false
end

function UIN0CookData.CheckRed_Collect(compInfo)
  local data_info = compInfo.data_info
  local collect_list = data_info.collect_list
  for k, v in pairs(collect_list) do
    if v == NewYearDinner_Status.E_NewYearDinner_Status_CAN_RECV then
      return true
    end
  end
  return false
end

function UIN0CookData.CheckRed_CookBook(compInfo)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local data_info = compInfo.data_info
  local food_list = data_info.food_list
  local componnetId = compInfo.m_campaign_id * 100000 + compInfo.m_component_type * 100 + compInfo.m_component_id
  local cfgs = Cfg.cfg_component_newyear_dinner_food({ComponentID = componnetId})
  if not cfgs then
    return false
  end
  for k, v in pairs(cfgs) do
    local foodId = v.FoodID
    local costItem = v.CostItem
    local itemCount = itemModule:GetItemCount(costItem[1])
    local costNum = costItem[2]
    if itemCount >= costNum then
      local status = food_list[foodId]
      if status and status == NewYearDinner_Status.E_NewYearDinner_Status_UN_FINISH then
        return true
      end
    end
  end
end

function UIN0CookData:IsCookedAll()
  return UIN0CookData.IsCookedAllByCompInfo(self._cookCompInfo)
end

function UIN0CookData.IsCookedAllByCompInfo(compInfo)
  local componnetId = UIN0CookData.GetCompInfoId(compInfo)
  local cfgs = Cfg.cfg_component_newyear_dinner_food({ComponentID = componnetId})
  local data_info = compInfo.data_info
  local food_list = data_info.food_list
  if #food_list ~= #cfgs then
    return false
  end
  for k, v in pairs(food_list) do
    if v <= NewYearDinner_Status.E_NewYearDinner_Status_UN_FINISH then
      return false
    end
  end
  return true
end

function UIN0CookData.CheckNew_CookBook(compInfo)
  local componentId = UIN0CookData.GetCompInfoId(compInfo)
  local data_info = compInfo.data_info
  for i, v in ipairs(data_info.food_list) do
    if v == NewYearDinner_Status.E_NewYearDinner_Status_UN_FINISH and not UIN0CookData.HasKey(componentId .. i) then
      return true
    end
  end
  return false
end

function UIN0CookData.ClearNew_CookBook(compInfo)
  local componentId = UIN0CookData.GetCompInfoId(compInfo)
  local data_info = compInfo.data_info
  for i, v in ipairs(data_info.food_list) do
    if v == NewYearDinner_Status.E_NewYearDinner_Status_UN_FINISH then
      local key = componentId .. i
      if not UIN0CookData.HasKey(key) then
        UIN0CookData.SetKey(key)
      end
    end
  end
end

function UIN0CookData.CheckRed_FirstStory(compInfo)
  local key = UIN0CookData.GetFirstStoryKey(compInfo)
  if UIN0CookData.HasKey(key) then
    return false
  end
  return true
end

function UIN0CookData.CheckRed_EndStory(compInfo)
  local key = UIN0CookData.GetEndStoryKey(compInfo)
  if UIN0CookData.HasKey(key) then
    return false
  end
  return UIN0CookData.IsCookedAllByCompInfo(compInfo)
end

function UIN0CookData.ClearRed_EndStory(compInfo)
  local key = UIN0CookData.GetEndStoryKey(compInfo)
  UIN0CookData.SetKey(key)
end

function UIN0CookData.GetEndStoryKey(compInfo)
  local compId = UIN0CookData.GetCompInfoId(compInfo)
  return "cook_endstory_" .. compId
end

function UIN0CookData.GetFirstStoryKey(compInfo)
  local compId = UIN0CookData.GetCompInfoId(compInfo)
  return "cook_firststory_" .. compId
end

function UIN0CookData.GetCompInfoId(compInfo)
  local compId = compInfo.m_campaign_id * 100000 + compInfo.m_component_type * 100 + compInfo.m_component_id
  return compId
end

function UIN0CookData.GetTimeString(seconds)
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_n25_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_n25_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_n25_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get("str_n25_minus", minus)
    end
  else
    timeStr = StringTable.Get("str_n25_less_one_minus")
  end
  return timeStr
end

function UIN0CookData:GetCookState()
  if self._cookCompInfo then
    return self:GetState(self._cookCompInfo)
  end
  return UISummerOneEnterBtnState.NotOpen
end

function UIN0CookData:GetState(cInfo)
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if nowTimestamp < cInfo.m_unlock_time then
    return UISummerOneEnterBtnState.NotOpen
  elseif nowTimestamp > cInfo.m_close_time then
    return UISummerOneEnterBtnState.Closed
  elseif cInfo.m_b_unlock then
    return UISummerOneEnterBtnState.Normal
  else
    local cfgv = Cfg.cfg_campaign_mission[cInfo.m_need_mission_id]
    if cfgv then
      return UISummerOneEnterBtnState.Locked
    else
      return UISummerOneEnterBtnState.Normal
    end
  end
end

function UIN0CookData:IsActivityClose()
  if not self._cookCompInfo then
    return true
  end
  local endTime = self._cookCompInfo.m_close_time
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if endTime < curTime then
    return true
  end
end

function UIN0CookData:GetCollectStatus(collectId)
  if not self._cookCompInfo then
    return NewYearDinner_Status.E_NewYearDinner_Status_LOCK
  end
  local data_info = self._cookCompInfo.data_info
  local collect_list = data_info.collect_list
  local status = collect_list[collectId]
  if status then
    return status
  end
  return NewYearDinner_Status.E_NewYearDinner_Status_LOCK
end

function UIN0CookData:GetFoodStatus(foodId)
  if not self._cookCompInfo then
    return NewYearDinner_Status.E_NewYearDinner_Status_LOCK
  end
  local data_info = self._cookCompInfo.data_info
  local collect_list = data_info.food_list
  local status = collect_list[foodId]
  if status then
    return status
  end
  return NewYearDinner_Status.E_NewYearDinner_Status_LOCK
end

function UIN0CookData:GetComponentId()
  return self._componentId
end

function UIN0CookData:RequestReceiveReward(TT, reward_type, req_id)
  local res = AsyncRequestRes:New()
  local result, rewards = self._cookComp:HandleNewYearDinnerReward(TT, res, reward_type, req_id)
  return res, rewards
end

function UIN0CookData:RequestMakeFood(TT, food_id)
  local res = AsyncRequestRes:New()
  self._cookComp:HandleNewYearDinnerMakeFood(TT, res, food_id)
  return res
end

function UIN0CookData:GetCostId()
  return 3000359
end

function UIN0CookData:GetWrongTimes(tid)
  local key = UIN0CookData.GetPrefsKey(tid)
  local times = UnityEngine.PlayerPrefs.GetInt(key, 0)
  return times
end

function UIN0CookData:SetWrongTimes(tid, times)
  local key = UIN0CookData.GetPrefsKey(tid)
  local times = UnityEngine.PlayerPrefs.SetInt(key, times)
end

function UIN0CookData.GetPrefsKey(str)
  local playerPrefsKey = UIN0CookData.GetPstId() .. str
  return playerPrefsKey
end

function UIN0CookData.GetPstId()
  local mRole = GameGlobal.GetModule(RoleModule)
  return mRole:GetPstId()
end

function UIN0CookData.HasKey(k)
  local key = UIN0CookData.GetPrefsKey(k)
  return UnityEngine.PlayerPrefs.HasKey(key)
end

function UIN0CookData.SetKey(k)
  local key = UIN0CookData.GetPrefsKey(k)
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end
