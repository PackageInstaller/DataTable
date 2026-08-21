require("component_base")
_class("CycleQuestComponent", ICampaignComponent)
CycleQuestComponent = CycleQuestComponent

function CycleQuestComponent:Constructor()
  self.m_component_info = CycleQuestComponentInfo:New()
end

function CycleQuestComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = CycleQuestComponentInfo:New()
  end
  return self.m_component_info
end

function CycleQuestComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function CycleQuestComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_CYCLE_QUEST
end

function CycleQuestComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function CycleQuestComponent:CampaignComponentPushNotify(notify_data)
  if CamQuestComponentNotifyType.QuestListComponentNotifyScore == notify_data.m_notify_type then
    local ev = NotifyCycleQuesetComponentUpdateScore:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:_OnScoreUpdate(ev)
    else
      Log.error("[CampaignCom][CycleQuestComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function CycleQuestComponent:_OnScoreUpdate(ev)
  local id = ev.list_quest_id
  self.m_component_info.cur_score = ev.cur_score
  self.m_component_info.today_socre_max = ev.today_socre_max
  self:_OnComplateListQuest(id)
end

function CycleQuestComponent:_OnComplateListQuest(id)
  local icon = self:GetKeyRewardIcon()
  local text = self:GetCompleteTipText(id)
  local c = "#000000"
  text = UIActivityHelper.GetColorText(c, text)
  Log.info("CycleQuestComponent:_OnComplateListQuest(id) id = ", id)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomeShowUIBubble, text, icon)
end

function CycleQuestComponent:GetConditionDesc()
  local component_cfg_id = self:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_cycle_quest_list({ComponentID = component_cfg_id})
  local tb = {}
  for _, v in ipairs(cfgs) do
    table.insert(tb, {
      Desc = v.Desc,
      Reward = v.Reward
    })
  end
  return tb
end

function CycleQuestComponent:GetLimitTipCount()
  local component_cfg_id = self:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_cycle_quest_limit({ComponentID = component_cfg_id})
  local cfg = cfgs and cfgs[1]
  return cfg.LimitStepEveryDay, cfg.MaxLimitCount
end

function CycleQuestComponent:GetKeyReward()
  local component_cfg_id = self:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_cycle_quest_limit({ComponentID = component_cfg_id})
  local cfg = cfgs and cfgs[1]
  return cfg.RewardItemID
end

function CycleQuestComponent:GetKeyRewardIcon()
  local itemId = self:GetKeyReward()
  local cfg = Cfg.cfg_item[itemId]
  return cfg and cfg.Icon
end

function CycleQuestComponent:GetKeyRewardCount()
  local componentInfo = self:GetComponentInfo()
  return componentInfo.cur_score, componentInfo.today_socre_max
end

function CycleQuestComponent:GetCompleteTipText(id)
  local cfg = Cfg.cfg_component_cycle_quest_list[id]
  return cfg and StringTable.Get(cfg.BubbleText, cfg.Reward)
end
