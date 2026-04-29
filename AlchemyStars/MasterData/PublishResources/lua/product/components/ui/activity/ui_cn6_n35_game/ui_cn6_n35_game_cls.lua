_class("UI_CN6_N35_Game_Process_Data", Object)
UI_CN6_N35_Game_Process_Data = UI_CN6_N35_Game_Process_Data

function UI_CN6_N35_Game_Process_Data:Constructor()
end

function UI_CN6_N35_Game_Process_Data:SetData(processInfo)
  self.itemID = processInfo.m_item_id
  self.currentFinishStep = processInfo.m_current_progress
  local gotList = processInfo.m_received_progress
  local dataMap = processInfo.m_progress_rewards
  self.processDataList = {}
  for key, value in pairs(dataMap) do
    local data = {}
    data.step = key
    data.awards = value
    if table.icontains(gotList, key) then
      data.got = true
      data.finish = true
    else
      data.got = false
      if key <= self.currentFinishStep then
        data.finish = true
      else
        data.finish = false
      end
    end
    table.insert(self.processDataList, data)
  end
  table.sort(self.processDataList, function(a, b)
    return a.step < b.step
  end)
  Log.debug("###[UI_CN6_N35_Game_Process_Data] set data end !")
end

function UI_CN6_N35_Game_Process_Data:ItemID()
  return self.itemID
end

function UI_CN6_N35_Game_Process_Data:LastStepNeedCount()
  return self.processDataList[#self.processDataList].step
end

function UI_CN6_N35_Game_Process_Data:ProcessList()
  return self.processDataList
end

function UI_CN6_N35_Game_Process_Data:CurrentShowStepAward()
  local ret
  for index, value in ipairs(self.processDataList) do
    ret = value
    if value.got then
    else
      return ret
    end
  end
  return ret
end

_class("UI_CN6_N35_Game_Smelt_Data", Object)
UI_CN6_N35_Game_Smelt_Data = UI_CN6_N35_Game_Smelt_Data
local UI_CN6_N35_SmeltState = {
  Finish = 1,
  NotItem = 2,
  NotLast = 3,
  CanFinish = 4
}
_enum("UI_CN6_N35_SmeltState", UI_CN6_N35_SmeltState)

function UI_CN6_N35_Game_Smelt_Data:Constructor()
end

function UI_CN6_N35_Game_Smelt_Data:SetData(smeltInfo, cfgid)
  self.smeltList = {}
  local finishList = smeltInfo.m_info
  local cfgs_smelt = Cfg.cfg_component_smelt_item({ComponentID = cfgid})
  table.sort(cfgs_smelt, function(a, b)
    return a.ID < b.ID
  end)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local lastData
  for index, value in ipairs(cfgs_smelt) do
    local data = {}
    data.cfg = value
    local cfg_client = Cfg.cfg_cn6_n35_game_client({
      StepID = value.ID
    })[1]
    data.number = cfg_client.ID
    if table.icontains(finishList, value.ID) then
      data.got = true
    else
      data.got = false
    end
    if data.got then
      data.state = UI_CN6_N35_SmeltState.Finish
    else
      local needItemID = value.Input[1][1]
      local haveCount = itemModule:GetItemCount(needItemID)
      if 0 < haveCount then
        if lastData and not lastData.got then
          data.state = UI_CN6_N35_SmeltState.NotLast
        else
          data.state = UI_CN6_N35_SmeltState.CanFinish
        end
      else
        data.state = UI_CN6_N35_SmeltState.NotItem
      end
    end
    table.insert(self.smeltList, data)
    lastData = data
  end
  Log.debug("###[UI_CN6_N35_Game_Smelt_Data] set data end !")
end

function UI_CN6_N35_Game_Smelt_Data:SmeltList()
  return self.smeltList
end

_class("UI_CN6_N35_Game_Quest_Data", Object)
UI_CN6_N35_Game_Quest_Data = UI_CN6_N35_Game_Quest_Data

function UI_CN6_N35_Game_Quest_Data:Constructor()
end

function UI_CN6_N35_Game_Quest_Data:SetData(questCInfo)
  local questIdList = questCInfo.m_accept_cam_quest_list
  local questModule = GameGlobal.GetModule(QuestModule)
  self._specialQuest = nil
  self._questList = {}
  for index, value in ipairs(questIdList) do
    local cfg_com_quest = Cfg.cfg_component_quest({QuestID = value})
    if cfg_com_quest and next(cfg_com_quest) then
      local quest = questModule:GetQuest(value)
      local cfg_quest = cfg_com_quest[1]
      if cfg_quest.SpecialFlag then
        self._specialQuest = quest
      else
        table.insert(self._questList, quest)
      end
    else
      Log.error("###[UI_CN6_N35_Game_Quest_Data] cfg quest is nil ! id:", value)
    end
  end
  if #self._questList ~= 3 then
    Log.error("###[UI_CN6_N35_Game_Quest_Data] _questList len ~= 3 !")
    for index, value in ipairs(questIdList) do
      Log.error("###[UI_CN6_N35_Game_Quest_Data] _questList len ~= 3 ! value:", value)
    end
  end
  Log.debug("###[UI_CN6_N35_Game_Quest_Data] set data end !")
end

function UI_CN6_N35_Game_Quest_Data:SpecialQuest()
  return self._specialQuest
end

function UI_CN6_N35_Game_Quest_Data:QuestList()
  return self._questList
end
