_class("UIActivityLineMissionHelper", Object)
UIActivityLineMissionHelper = UIActivityLineMissionHelper

function UIActivityLineMissionHelper:Constructor()
end

function UIActivityLineMissionHelper.GetMissionCfgs(component)
  local cmpID = component:GetComponentCfgId()
  local missionCfgs_temp = Cfg.cfg_component_line_mission({ComponentID = cmpID})
  local missionCfgs = {}
  for _, cfg in pairs(missionCfgs_temp) do
    missionCfgs[cfg.CampaignMissionId] = cfg
  end
  return missionCfgs
end

function UIActivityLineMissionHelper.GetNodeLineInfo(component, missionCfgs)
  local componentInfo = component:GetComponentInfo()
  local unlockInfo = {}
  local firstMissionID
  for _, cfg in pairs(missionCfgs) do
    if unlockInfo[cfg.NeedMissionId] == nil then
      unlockInfo[cfg.NeedMissionId] = {}
    end
    unlockInfo[cfg.NeedMissionId][cfg.CampaignMissionId] = cfg
    if cfg.NeedMissionId == 0 then
      firstMissionID = cfg.CampaignMissionId
    end
  end
  local showMission = {}
  local levelCount, lineCount = 0, 0
  if next(componentInfo.m_pass_mission_info) then
    for missionID, passInfo in pairs(componentInfo.m_pass_mission_info) do
      if not showMission[missionID] then
        showMission[missionID] = missionCfgs[missionID]
        levelCount = levelCount + 1
      end
      if unlockInfo[missionID] then
        for id, cfg in pairs(unlockInfo[missionID]) do
          if not showMission[id] then
            showMission[id] = missionCfgs[id]
            levelCount = levelCount + 1
          end
          if cfg.WayPointType ~= 4 and cfg.NeedMissionId ~= 0 then
            lineCount = lineCount + 1
          end
        end
      end
    end
  else
    showMission[firstMissionID] = missionCfgs[firstMissionID]
    levelCount = 1
  end
  return levelCount, lineCount, showMission
end

function UIActivityLineMissionHelper.CalcContentWidth(component, showMission, safeAreaSize_x)
  local cmpID = component:GetComponentCfgId()
  local extra_cfg = Cfg.cfg_component_line_mission_extra({ComponentID = cmpID})
  local extra_width = 200
  if extra_cfg and next(extra_cfg) then
    extra_width = extra_cfg[1].MarginRight
  end
  local right = -99999999
  for _, cfg in pairs(showMission) do
    right = math.max(right, cfg.MapPosX)
  end
  local width = math.abs(right + extra_width)
  width = math.max(safeAreaSize_x, width)
  return width
end

function UIActivityLineMissionHelper.EnterStage_Story(campaign, component, stageId, callback)
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local titleId = StringTable.Get(missionCfg.Title)
  local titleName = StringTable.Get(missionCfg.Name)
  local missionModule = GameGlobal.GameLogic():GetModule(MissionModule)
  local storyId = missionModule:GetStoryByStageIdStoryType(stageId, StoryTriggerType.Node)
  if not storyId then
    Log.exception("配置错误,找不到剧情,关卡id:", stageId)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIActivityPlotEnter", titleId, titleName, storyId, function()
    UIActivityLineMissionHelper.PlotEndCallback(campaign, component, stageId, callback)
  end)
end

function UIActivityLineMissionHelper.PlotEndCallback(campaign, component, stageId, callback)
  component:Start_HandleCompleteStoryMission(stageId, function(res, award)
    if not res:GetSucc() then
      campaign._campaign_module:CheckErrorCode(res.m_result, campaign._id, nil, nil)
    elseif table.count(award) ~= 0 then
      GameGlobal.UIStateManager():ShowDialog("UIGetItemController", award, callback)
    elseif callback then
      callback()
    end
  end)
end

function UIActivityLineMissionHelper.EnterStage_Battle(campaign, component, stageId, isReview, isNewDialog)
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local autoFightShow = UIActivityLineMissionHelper._CheckSerialAutoFightShow(missionCfg.Type, stageId)
  local pointComponent = campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_ACTION_POINT, 1)
  if not isNewDialog then
    GameGlobal.UIStateManager():ShowDialog("UIActivityLevelStageNew", stageId, component:GetComponentInfo().m_pass_mission_info[stageId], component, autoFightShow, pointComponent, isReview, isReview)
  else
    GameGlobal.UIStateManager():ShowDialog("UIActivityHardStage", stageId, component:GetComponentInfo().m_pass_mission_info[stageId], component, autoFightShow, pointComponent, isReview, isReview)
  end
end

function UIActivityLineMissionHelper._CheckSerialAutoFightShow(stageType, stageId)
  local autoFightShow = false
  if stageType == DiscoveryStageType.Plot then
    autoFightShow = false
  else
    local missionCfg = Cfg.cfg_campaign_mission[stageId]
    if missionCfg then
      local enableParam = missionCfg.EnableSerialAutoFight
      local tb = {
        [CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_DISABLE] = false,
        [CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_ENABLE] = true,
        [CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_NEED_UNLOCK] = true
      }
      autoFightShow = tb[enableParam]
    end
  end
  return autoFightShow
end

function UIActivityLineMissionHelper.GetNodeLineInfoVertical(component, missionCfgs)
  local showMission = {}
  local levelCount, lineCount = table.count(missionCfgs), 0
  for missionID, cfg in pairs(missionCfgs) do
    showMission[missionID] = cfg
    if cfg.WayPointType ~= 4 and cfg.NeedMissionId ~= 0 then
      lineCount = lineCount + 1
    end
  end
  return levelCount, lineCount, showMission
end

function UIActivityLineMissionHelper.CalcContentHeight(component, showMission, viewportSize_y)
  local extra_height = 300
  local down = math.maxinteger
  for _, cfg in pairs(showMission) do
    down = math.min(down, cfg.MapPosY)
  end
  local height = math.abs(down - extra_height)
  height = math.max(viewportSize_y, height)
  return height
end

function UIActivityLineMissionHelper.GetUnlockInfoVertical(component, missionCfgs)
  local passInfo = component:GetComponentInfo().m_pass_mission_info
  local unlockInfo = {}
  for _, cfg in pairs(missionCfgs) do
    if cfg.NeedMissionId == 0 then
      unlockInfo[cfg.CampaignMissionId] = true
    else
      unlockInfo[cfg.CampaignMissionId] = passInfo[cfg.NeedMissionId] ~= nil
    end
  end
  return unlockInfo
end
