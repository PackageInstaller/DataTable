_class("UISeasonTaskListHelper", Object)
UISeasonTaskListHelper = UISeasonTaskListHelper

function UISeasonTaskListHelper.GetNodeCfg(node)
  local nodeId = node and node.node_id or 0
  local cfg = Cfg.cfg_season_task_node[nodeId]
  return cfg
end

function UISeasonTaskListHelper.GetNodeTitle(nodes)
  local tb = {}
  for i, v in ipairs(nodes) do
    local cfg = UISeasonTaskListHelper.GetNodeCfg(v)
    local strId = (cfg or {}).Title
    local text = strId and StringTable.Get(strId) or ""
    table.insert(tb, text)
  end
  return tb
end

function UISeasonTaskListHelper.GetNodeProgress(node)
  local list = UISeasonTaskListHelper.GetAllQuestId(node)
  local curIdx = UISeasonTaskListHelper.GetCurQuestIndex(node)
  return curIdx - 1, #list
end

function UISeasonTaskListHelper.GetAllQuestId(node)
  local cfg = UISeasonTaskListHelper.GetNodeCfg(node)
  return cfg and cfg.Questlist or {}
end

function UISeasonTaskListHelper.GetCurQuestIndex(node)
  local list = UISeasonTaskListHelper.GetAllQuestId(node)
  for i, v in ipairs(list) do
    if UISeasonTaskListHelper.CheckQuestFin(v) == false then
      return i
    end
  end
  return #list + 1
end

function UISeasonTaskListHelper.GetCurQuestId(node)
  local list = UISeasonTaskListHelper.GetAllQuestId(node)
  local curIdx = UISeasonTaskListHelper.GetCurQuestIndex(node)
  return list[curIdx] or 0
end

function UISeasonTaskListHelper.CheckLastQuestFin(node)
  local questList = UISeasonTaskListHelper.GetAllQuestId(node)
  local lastQuest = questList[#questList]
  local isFin = UISeasonTaskListHelper.CheckQuestFin(lastQuest)
  return lastQuest, isFin
end

function UISeasonTaskListHelper.CheckQuestFin(questId)
  local questModule = GameGlobal.GameLogic():GetModule(QuestModule)
  return questModule:IsTakeQuest(questId)
end

function UISeasonTaskListHelper.GetQuestInfo(questId, key)
  local questModule = GameGlobal.GameLogic():GetModule(QuestModule)
  local quest = questModule:GetQuest(questId)
  local questInfo = quest and quest:QuestInfo() or {}
  if key then
    return questInfo[key]
  end
  return questInfo
end

function UISeasonTaskListHelper.GetQuestText(questId, key)
  local strId = UISeasonTaskListHelper.GetQuestInfo(questId, key)
  local text = strId and StringTable.Get(strId) or ""
  return text
end

function UISeasonTaskListHelper.CheckModeValid(mode)
  local seasonObj = GameGlobal.GetModule(SeasonModule):GetCurSeasonObj()
  local cfg = Cfg.cfg_season_map[seasonObj:GetSeasonID()]
  if not cfg then
    Log.exception("cfg_season_map 中找不到配置:", seasonObj:GetSeasonID())
    return false
  end
  if cfg.ModeUnlock == nil or next(cfg.ModeUnlock) == nil then
    return false
  end
  local condition = cfg.ModeUnlock[mode]
  if string.isnullorempty(condition) then
    return true
  end
  local componentInfo = seasonObj:GetComponentInfo(ECCampaignSeasonComponentID.SEASON_MISSION)
  local valid = GameGlobal.GetModule(SeasonModule):CheckCondition(condition, componentInfo.m_stage_info)
  return valid
end

function UISeasonTaskListHelper.CheckModeTravel(setConfirmCallback, closeCallback)
  local mode = GameGlobal.GetUIModule(SeasonModule):SeasonManager():SeasonMapManager():Mode()
  local isTravel = mode == SeasonMapMode.Mode2
  if isTravel then
    UISeasonTaskListHelper.GoToTask(closeCallback)
  elseif setConfirmCallback then
    setConfirmCallback()
  end
end

function UISeasonTaskListHelper.SwitchModeTravel(closeCallback)
  local mode = SeasonMapMode.Mode2
  local isValid = UISeasonTaskListHelper.CheckModeValid(mode)
  if isValid then
    local seasonMapManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager():SeasonMapManager()
    seasonMapManager:SwitchMapMode(mode, function()
      UISeasonTaskListHelper.GoToTask(closeCallback)
    end)
    return
  end
  Log.error("UIS2TaskListContent:_SwitchMode() 无法切换到对应赛季模式 mode = ", mode)
  if closeCallback then
    closeCallback()
  end
end

function UISeasonTaskListHelper.GoToTask(closeCallback)
  GameGlobal.GetUIModule(SeasonModule):SeasonManager():SeasonMapManager():BrowseTask()
  if closeCallback then
    closeCallback()
  end
end

function UISeasonTaskListHelper.CheckModeValid(mode)
  local seasonObj = GameGlobal.GetModule(SeasonModule):GetCurSeasonObj()
  local cfg = Cfg.cfg_season_map[seasonObj:GetSeasonID()]
  if not cfg then
    Log.exception("cfg_season_map 中找不到配置:", seasonObj:GetSeasonID())
    return false
  end
  if cfg.ModeUnlock == nil or next(cfg.ModeUnlock) == nil then
    return false
  end
  local condition = cfg.ModeUnlock[mode]
  if string.isnullorempty(condition) then
    return true
  end
  local componentInfo = seasonObj:GetComponentInfo(ECCampaignSeasonComponentID.SEASON_MISSION)
  local valid = GameGlobal.GetModule(SeasonModule):CheckCondition(condition, componentInfo.m_stage_info)
  return valid
end

function UISeasonTaskListHelper.CheckModeTravel(setConfirmCallback, closeCallback)
  local mode = GameGlobal.GetUIModule(SeasonModule):SeasonManager():SeasonMapManager():Mode()
  local isTravel = mode == SeasonMapMode.Mode2
  if isTravel then
    UISeasonTaskListHelper.GoToTask(closeCallback)
  elseif setConfirmCallback then
    setConfirmCallback()
  end
end

function UISeasonTaskListHelper.SwitchModeTravel(closeCallback)
  local mode = SeasonMapMode.Mode2
  local isValid = UISeasonTaskListHelper.CheckModeValid(mode)
  if isValid then
    local seasonMapManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager():SeasonMapManager()
    seasonMapManager:SwitchMapMode(mode, function()
      UISeasonTaskListHelper.GoToTask(closeCallback)
    end)
    return
  end
  Log.error("UIS2TaskListContent:_SwitchMode() 无法切换到对应赛季模式 mode = ", mode)
  if closeCallback then
    closeCallback()
  end
end

function UISeasonTaskListHelper.GoToTask(closeCallback)
  GameGlobal.GetUIModule(SeasonModule):SeasonManager():SeasonMapManager():BrowseTask()
  if closeCallback then
    closeCallback()
  end
end
