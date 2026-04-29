_class("LVRewardComponent", ICampaignComponent)
LVRewardComponent = LVRewardComponent

function LVRewardComponent:Constructor()
  self.m_component_info = LVRewardComponentInfo:New()
end

function LVRewardComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = LVRewardComponentInfo:New()
  end
  return self.m_component_info
end

function LVRewardComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function LVRewardComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_LV_REWARD
end

function LVRewardComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function LVRewardComponent:HandleReceiveLevelReward(TT, asyncRes, level, is_advanced)
  local request = LVRewardComponentReceiveRewardReq:New()
  local response = LVRewardComponentReceiveRewardRep:New()
  request.m_req_level = level
  request.m_is_advanced = is_advanced
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][LVRewardComponent] HandleReceiveLevelReward ret:", asyncRes.m_result)
    return nil
  end
  if is_advanced then
    table.insert(self.m_component_info.m_received_advanced_lv, level)
  else
    table.insert(self.m_component_info.m_received_normal_lv, level)
  end
  asyncRes:SetSucc(true)
  return response.m_reward_info
end

function LVRewardComponent:HandleOneKeyReceiveReward(TT, asyncRes)
  local request = LVRewardComponentOneKeyReceiveRewardReq:New()
  local response = LVRewardComponentOneKeyReceiveRewardRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][LVRewardComponent] HandleOneKeyReceiveReward ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.m_received_advanced_lv = response.m_received_advanced
  self.m_component_info.m_received_normal_lv = response.m_received_normal
  asyncRes:SetSucc(true)
  return response.m_rewards
end

function LVRewardComponent:CampaignComponentPushNotify(notify_data)
  if LVRewardComponentNotifyType.LVRewardComponentNotify_LevelProgressChanged == notify_data.m_notify_type then
    local ev = NotifyLVRewardComponentLevelProgressChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnLevelProgressChanged(ev)
    else
      Log.error("[CampaignCom][LVRewardComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
  if LVRewardComponentNotifyType.LVRewardComponentNotify_UnlockAdvanced == notify_data.m_notify_type then
    local ev = NotifyLVRewardComponentUnlockAdvanced:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnAdvancedRewardUnlock(ev)
    else
      Log.error("[CampaignCom][LVRewardComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function LVRewardComponent:OnLevelProgressChanged(ev)
  self.m_component_info.m_current_level = ev.m_level
  self.m_component_info.m_current_progress = ev.m_progress
end

function LVRewardComponent:OnAdvancedRewardUnlock(ev)
  self.m_component_info.m_unlock_advanced_reward = ev.m_unlock_advanced_reward
end

function LVRewardComponent:Start_HandleReceiveLevelReward(level, is_advanced, callback)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  local lockName = "LVRewardComponent:Start_HandleReceiveLevelReward"
  GameGlobal.UIStateManager():Lock(lockName)
  TaskManager:GetInstance():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local reward = self:HandleReceiveLevelReward(TT, res, level, is_advanced)
    GameGlobal.UIStateManager():UnLock(lockName)
    if callback then
      callback(res, {reward})
    end
  end)
end

function LVRewardComponent:Start_HandleOneKeyReceiveReward(callback)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  local lockName = "LVRewardComponent:Start_HandleOneKeyReceiveReward"
  GameGlobal.UIStateManager():Lock(lockName)
  TaskManager:GetInstance():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local rewards = self:HandleOneKeyReceiveReward(TT, res)
    GameGlobal.UIStateManager():UnLock(lockName)
    if callback then
      callback(res, rewards)
    end
  end)
end

function LVRewardComponent:GetRewardInfoFromConfig(begin_id, rewards, show_priority_map, begin_lv, end_lv)
  begin_lv = begin_lv or 1
  end_lv = end_lv or self.m_component_info.m_max_level
  for i = begin_lv, end_lv do
    local cur_reward_id = begin_id + i - 1
    local table_reward = GameGlobal.GetZoneCfgTable("cfg_campaign_lv_reward", cur_reward_id)
    local cur_reward = RoleAsset:New()
    cur_reward.assetid = table_reward.RewardInfo[1]
    cur_reward.count = table_reward.RewardInfo[2]
    local is_exist = false
    for index = 1, #rewards do
      if cur_reward.assetid == rewards[index].assetid then
        rewards[index].count = rewards[index].count + cur_reward.count
        is_exist = true
        break
      end
    end
    if not is_exist then
      table.insert(rewards, cur_reward)
    end
    local show_iter = show_priority_map:Find(cur_reward.assetid)
    local defaultPriority = table_reward.ShowPriority or 0
    if nil == show_iter then
      show_priority_map:Insert(cur_reward.assetid, defaultPriority)
    elseif show_iter ~= defaultPriority then
      Log.error("[LVRewardComponent] show priority cfg err! RewardID:", cur_reward_id)
    end
  end
  return rewards, show_priority_map
end

function LVRewardComponent:GetSortAdvancedRewards(begin_lv, end_lv)
  local all_reward = {}
  local show_priority_map = SortedDictionary.New()
  local normal_reward_id = self.m_component_info.m_normal_begin_reward_id
  all_reward, show_priority_map = self:GetRewardInfoFromConfig(normal_reward_id, all_reward, show_priority_map, begin_lv, end_lv)
  local advanced_reward_id = self.m_component_info.m_advanced_begin_reward_id
  all_reward, show_priority_map = self:GetRewardInfoFromConfig(advanced_reward_id, all_reward, show_priority_map, begin_lv, end_lv)
  return self:SortRoleAsset(all_reward, show_priority_map)
end

function LVRewardComponent:GetSortNormalRewards(begin_lv, end_lv)
  local all_reward = {}
  local show_priority_map = SortedDictionary.New()
  local normal_reward_id = self.m_component_info.m_normal_begin_reward_id
  all_reward, show_priority_map = self:GetRewardInfoFromConfig(normal_reward_id, all_reward, show_priority_map, begin_lv, end_lv)
  return self:SortRoleAsset(all_reward, show_priority_map)
end

function LVRewardComponent:SortRoleAsset(assets, show_priority_map)
  table.sort(assets, function(a, b)
    local pa = show_priority_map:Find(a.assetid)
    local pb = show_priority_map:Find(b.assetid)
    if pa == pb then
      local ta = Cfg.cfg_item[a.assetid]
      local tb = Cfg.cfg_item[b.assetid]
      if ta.BagSortIndex == tb.BagSortIndex then
        if ta.Color == tb.Color then
          return ta.ID < tb.ID
        end
        return ta.Color > tb.Color
      end
      return ta.BagSortIndex > tb.BagSortIndex
    end
    return pa > pb
  end)
  return assets
end

function LVRewardComponent:GetAllLevelRewardInfoFromConfig(begin_id)
  local rewards = {}
  for i = 1, self.m_component_info.m_max_level do
    local cur_reward_id = begin_id + i - 1
    local table_reward = GameGlobal.GetZoneCfgTable("cfg_campaign_lv_reward", cur_reward_id)
    local cur_reward = RoleAsset:New()
    cur_reward.assetid = table_reward.RewardInfo[1]
    cur_reward.count = table_reward.RewardInfo[2]
    table.insert(rewards, cur_reward)
  end
  return rewards
end

function LVRewardComponent:GetAdvancedRewards()
  local advanced_reward_id = self.m_component_info.m_advanced_begin_reward_id
  return self:GetAllLevelRewardInfoFromConfig(advanced_reward_id)
end

function LVRewardComponent:GetNormalRewards()
  local normal_reward_id = self.m_component_info.m_normal_begin_reward_id
  return self:GetAllLevelRewardInfoFromConfig(normal_reward_id)
end

function LVRewardComponent:GetSpecialRewardCfg()
  local advanced_reward_id = self.m_component_info.m_advanced_begin_reward_id
  local normal_reward_id = self.m_component_info.m_normal_begin_reward_id
  local cfg1 = self:GetSpecialRewardCfgFromConfig(advanced_reward_id)
  local cfg2 = self:GetSpecialRewardCfgFromConfig(normal_reward_id)
  return cfg1, cfg2
end

function LVRewardComponent:GetSpecialRewardCfgFromConfig(begin_id)
  for i = 1, self.m_component_info.m_max_level do
    local cur_reward_id = begin_id + i - 1
    local table_reward = GameGlobal.GetZoneCfgTable("cfg_campaign_lv_reward", cur_reward_id)
    if table_reward.IsSpecial then
      return table_reward
    end
  end
  return nil
end

function LVRewardComponent:IsPreviewLvFromConfig(begin_lv)
  local begin_id = self.m_component_info.m_normal_begin_reward_id
  local end_lv = self.m_component_info.m_max_level
  if begin_lv > end_lv then
    return false
  end
  local cur_reward_id = begin_id + begin_lv - 1
  local table_reward = GameGlobal.GetZoneCfgTable("cfg_campaign_lv_reward", cur_reward_id)
  return table_reward.IsPreview ~= nil
end

function LVRewardComponent:GetNextPreviewLvFromConfig(begin_lv)
  local begin_id = self.m_component_info.m_normal_begin_reward_id
  local end_lv = self.m_component_info.m_max_level
  if begin_lv == end_lv then
    return nil
  end
  for i = begin_lv, end_lv do
    local cur_reward_id = begin_id + i - 1
    local table_reward = GameGlobal.GetZoneCfgTable("cfg_campaign_lv_reward", cur_reward_id)
    if table_reward.IsPreview then
      return i
    end
  end
  return nil
end

function LVRewardComponent:GetShowLvOnEnter()
  local info = self:ComponentInfo()
  if info then
    local curLv = info.m_current_level
    
    function GetShowLv(curLv, received)
      local tb = {}
      local lv = 1
      for _, v in ipairs(received) do
        tb[v] = true
      end
      for i = 1, curLv do
        if not tb[i] then
          return i
        end
      end
      return curLv
    end
    
    local normal = GetShowLv(curLv, info.m_received_normal_lv)
    local advanced = info.m_unlock_advanced_reward and GetShowLv(curLv, info.m_received_advanced_lv) or curLv
    return math.min(normal, advanced)
  end
  return 1
end

function LVRewardComponent:CheckIsLevelMax()
  local componentInfo = self:GetComponentInfo()
  return componentInfo.m_current_level == componentInfo.m_max_level and componentInfo.m_current_progress == componentInfo.m_level_max_progress
end

function LVRewardComponent:IsExtraLevelReward(roleAsset)
  local componentInfo = self:GetComponentInfo()
  if roleAsset.assetid == componentInfo.m_item_id then
    local lv = roleAsset.count / componentInfo.m_level_max_progress
    if not lv or lv ~= math.floor(lv) then
      Log.fatal("LVRewardComponent:IsExpReward() roleAsset.count Error! cfg_component_buy_gift [ExtraAward]")
    end
    return math.floor(lv)
  end
end
