_class("HomelandFindTreasureConst", Object)
HomelandFindTreasureConst = HomelandFindTreasureConst

function HomelandFindTreasureConst:Constructor()
end

function HomelandFindTreasureConst.GetCampaignType()
  return HomelandFindTreasureConst.CAMPAIGN_TYPE
end

function HomelandFindTreasureConst.GetComponentType()
  return HomelandFindTreasureConst.COMPONENT_TYPE
end

function HomelandFindTreasureConst.InitHomelandFindTreausre(TT, homelandClient, campaignType, componentType)
  HomelandFindTreasureConst.CAMPAIGN_TYPE = campaignType
  HomelandFindTreasureConst.COMPONENT_TYPE = componentType
  if not HomelandFindTreasureConst.InitHomelandFindTreausreData(TT) then
    HomelandFindTreasureConst.ACTIVITY_CAMPAIGN = nil
    return nil
  end
  return HomelandFindTreasureManager:New(homelandClient)
end

function HomelandFindTreasureConst.Destroy()
  HomelandFindTreasureConst.ACTIVITY_CAMPAIGN = nil
end

function HomelandFindTreasureConst.InitHomelandFindTreausreData(TT, campaignType, componentType)
  HomelandFindTreasureConst.TreasureActiveRemainTime = 0
  if not HomelandFindTreasureConst.ACTIVITY_CAMPAIGN then
    HomelandFindTreasureConst.ACTIVITY_CAMPAIGN = UIActivityCampaign:New()
  end
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  if campaignType then
    HomelandFindTreasureConst.CAMPAIGN_TYPE = campaignType
  end
  if componentType then
    HomelandFindTreasureConst.COMPONENT_TYPE = componentType
  end
  HomelandFindTreasureConst.ACTIVITY_CAMPAIGN:LoadCampaignInfo(TT, res, HomelandFindTreasureConst.CAMPAIGN_TYPE, HomelandFindTreasureConst.COMPONENT_TYPE)
  HomelandFindTreasureConst.ACTIVITY_CAMPAIGN:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    return false
  end
  local localProcess = HomelandFindTreasureConst.ACTIVITY_CAMPAIGN:GetLocalProcess()
  if not localProcess then
    return false
  end
  local exploreMinigameComponent = localProcess:GetComponent(HomelandFindTreasureConst.COMPONENT_TYPE)
  local miniGameExploreComponentLoadInfo = localProcess:GetComponentInfo(HomelandFindTreasureConst.COMPONENT_TYPE)
  if not exploreMinigameComponent then
    return false
  end
  if not exploreMinigameComponent:ComponentIsOpen() then
    return false
  end
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime() / 1000
  HomelandFindTreasureConst.TreasureActiveRemainTime = math.floor(miniGameExploreComponentLoadInfo.m_close_time - nowTime)
  HomelandFindTreasureConst.ExploreMinigameComponent = exploreMinigameComponent
  HomelandFindTreasureConst.MiniGameExploreComponentLoadInfo = miniGameExploreComponentLoadInfo
  return true
end

function HomelandFindTreasureConst.GetActivityCampaign()
  return HomelandFindTreasureConst.ACTIVITY_CAMPAIGN
end

function HomelandFindTreasureConst.GetGameData()
  return UIFindTreasureGameData:New()
end

function HomelandFindTreasureConst.GetHasCostSingle()
  if not HomelandFindTreasureConst.MiniGameExploreComponentLoadInfo then
    return 0, 0
  end
  return HomelandFindTreasureConst.MiniGameExploreComponentLoadInfo.used_low_equip_num, HomelandFindTreasureConst.MiniGameExploreComponentLoadInfo.used_high_equip_num
end

function HomelandFindTreasureConst.GetSingleCount(cfg)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local cfgs = Cfg.cfg_component_minigame_explore_limit({})
  local cfg
  for _, v in pairs(cfgs) do
    cfg = v
  end
  local primaryId = cfg.PrimaryEquipID
  local seniorId = cfg.SeniorEquipID
  return itemModule:GetItemCount(primaryId), itemModule:GetItemCount(seniorId)
end

function HomelandFindTreasureConst.GetSingleCfg()
  if HomelandFindTreasureConst.ExploreMinigameComponent == nil then
    return nil
  end
  local componentId = HomelandFindTreasureConst.ExploreMinigameComponent:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_minigame_explore_limit({ComponentID = componentId})
  if cfgs == nil then
    return nil
  end
  local cfg
  for _, v in pairs(cfgs) do
    cfg = v
  end
  return cfg
end

function HomelandFindTreasureConst.GetNPCAsset()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.NPCModel
end

function HomelandFindTreasureConst.GetNPCRotateTime()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.NPCRotateTime / 1000
end

function HomelandFindTreasureConst.GetNPCHeadImage()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.NPCHeadImage
end

function HomelandFindTreasureConst.GetNPCPosition()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return Vector3(cfg.NPCPosition[1] / 1000, cfg.NPCPosition[2] / 1000, cfg.NPCPosition[3] / 1000)
end

function HomelandFindTreasureConst.GetNPCBackpackModel()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.BackpackModel
end

function HomelandFindTreasureConst.GetNPCBackpackModelAttachPath()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.BackpackAttachPath
end

function HomelandFindTreasureConst.GetNPCMinimapIcon()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.NPCMinimapIcon
end

function HomelandFindTreasureConst.GetNPCIcon()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.NPCIcon
end

function HomelandFindTreasureConst.GetNPCName()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.NPCName
end

function HomelandFindTreasureConst.GetNPCDes()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.NPCDes
end

function HomelandFindTreasureConst.GetStartPosition()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return Vector3(cfg.StartPosition[1] / 1000, cfg.StartPosition[2] / 1000, cfg.StartPosition[3] / 1000)
end

function HomelandFindTreasureConst.GetStartDirection()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return Vector3(cfg.StartDirection[1] / 1000, cfg.StartDirection[2] / 1000, cfg.StartDirection[3] / 1000)
end

function HomelandFindTreasureConst.GetStartCamera()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.StartCameraAngleX / 1000, cfg.StartCameraAngleY / 1000, cfg.StartCameraScale / 1000
end

function HomelandFindTreasureConst.GetSpecialEffectPrefabAndPath()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.SpecialEffectPrefab, cfg.SpecialEffectAttachPath
end

function HomelandFindTreasureConst.GetNormalEffectPrefabAndPath()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.NormalEffectPrefab, cfg.NormalEffectAttachPath
end

function HomelandFindTreasureConst.GetToolPrefabAndPath()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.ToolPrefab, cfg.ToolAttachPath
end

function HomelandFindTreasureConst.GetTreasureShowDis()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  return cfg.TreasureShowDis / 1000
end

function HomelandFindTreasureConst.GetOriginalPosition()
  return HomelandFindTreasureConst.ORIGINAL_POSITION
end

function HomelandFindTreasureConst.SetOriginalPosition(position)
  HomelandFindTreasureConst.ORIGINAL_POSITION = position
end

function HomelandFindTreasureConst.GetOriginalRotation()
  return HomelandFindTreasureConst.ORIGINAL_DIRECTION
end

function HomelandFindTreasureConst.SetOriginalRotation(rotation)
  HomelandFindTreasureConst.ORIGINAL_DIRECTION = rotation
end

function HomelandFindTreasureConst.GetFindTreasureActiveRemainTime()
  if not HomelandFindTreasureConst.TreasureActiveRemainTime then
    return 0
  end
  return HomelandFindTreasureConst.TreasureActiveRemainTime
end

function HomelandFindTreasureConst.IsGameActivityEnd()
  if not HomelandFindTreasureConst.ExploreMinigameComponent then
    return true
  end
  return not HomelandFindTreasureConst.ExploreMinigameComponent:ComponentIsOpen()
end

function HomelandFindTreasureConst.GetFindTreasureSingleDatas(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  HomelandFindTreasureConst.ACTIVITY_CAMPAIGN:LoadCampaignInfo(TT, res, HomelandFindTreasureConst.CAMPAIGN_TYPE, HomelandFindTreasureConst.COMPONENT_TYPE)
  HomelandFindTreasureConst.ACTIVITY_CAMPAIGN:ReLoadCampaignInfo_Force(TT, res)
  return UIFindTreasureSingleDatas:New()
end

function HomelandFindTreasureConst.GetNextSingleTime()
  if HomelandFindTreasureConst.IsGameActivityEnd() then
    return 0
  end
  if not HomelandFindTreasureConst.MiniGameExploreComponentLoadInfo then
    return 0
  end
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime() / 1000
  local closeTime = HomelandFindTreasureConst.MiniGameExploreComponentLoadInfo.m_close_time
  local lessTime = closeTime - nowTime
  local moreThanDay = false
  if 86400 < lessTime then
    moreThanDay = true
  end
  local seconds = math.floor(HomelandFindTreasureConst.MiniGameExploreComponentLoadInfo.next_refresh_time - nowTime)
  if seconds < 0 then
    seconds = 0
  end
  if not moreThanDay then
    seconds = lessTime
  end
  return seconds, moreThanDay
end

function HomelandFindTreasureConst.StartGame(TT, singleDatas, callback, reStart)
  GameGlobal.UIStateManager():Lock("HomelandFindTreasureConst_StartGame")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  HomelandFindTreasureConst.ACTIVITY_CAMPAIGN:LoadCampaignInfo(TT, res, HomelandFindTreasureConst.CAMPAIGN_TYPE, HomelandFindTreasureConst.COMPONENT_TYPE)
  HomelandFindTreasureConst.ACTIVITY_CAMPAIGN:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_find_treasure_game_active_end"))
    GameGlobal.UIStateManager():UnLock("HomelandFindTreasureConst_StartGame")
    return
  end
  local localProcess = HomelandFindTreasureConst.ACTIVITY_CAMPAIGN:GetLocalProcess()
  if not localProcess then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_find_treasure_game_active_end"))
    GameGlobal.UIStateManager():UnLock("HomelandFindTreasureConst_StartGame")
    return nil
  end
  local exploreMinigameComponent = localProcess:GetComponent(HomelandFindTreasureConst.COMPONENT_TYPE)
  if not exploreMinigameComponent:ComponentIsOpen() then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_find_treasure_game_active_end"))
    GameGlobal.UIStateManager():UnLock("HomelandFindTreasureConst_StartGame")
    return
  end
  local posId = exploreMinigameComponent:HandleRandomRewardPostion(TT, res)
  if not res:GetSucc() then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_find_treasure_server_error", res:GetResult()))
    GameGlobal.UIStateManager():UnLock("HomelandFindTreasureConst_StartGame")
    return
  end
  if not singleDatas:GetCanUseSingleData() then
    local btn1Data = {
      StringTable.Get("str_homeland_find_treasure_cancel_btn"),
      function(param)
      end
    }
    local btn2Data = {
      StringTable.Get("str_homeland_find_treasure_confirm_btn"),
      function(param)
        if callback then
          local waitTime = callback()
          GameGlobal.TaskManager():StartTask(function(TT)
            GameGlobal.UIStateManager():Lock("HomelandFindTreasureConst_StartGameCoro")
            if waitTime then
              YIELD(TT, waitTime)
            end
            GameGlobal.UIStateManager():ShowDialog("UIFindTreasureStartGame", posId, reStart)
            GameGlobal.UIStateManager():UnLock("HomelandFindTreasureConst_StartGameCoro")
          end)
        else
          GameGlobal.UIStateManager():ShowDialog("UIFindTreasureStartGame", posId, reStart)
        end
      end
    }
    GameGlobal.UIStateManager():ShowDialog("UIHomelandMessageBox", nil, StringTable.Get("str_homeland_find_treasure_no_single_tips"), btn1Data, btn2Data, true)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCharacterStartMove)
    GameGlobal.GetUIModule(HomelandModule):GetClient():CharacterManager():MainCharacterController():ResetStateAndAnim()
    if callback then
      local waitTime = callback()
      if waitTime then
        YIELD(TT, waitTime)
      end
    end
    GameGlobal.UIStateManager():ShowDialog("UIFindTreasureStartGame", posId, reStart)
  end
  GameGlobal.UIStateManager():UnLock("HomelandFindTreasureConst_StartGame")
end

function HomelandFindTreasureConst.GetPlotId()
  if not HomelandFindTreasureConst.MiniGameExploreComponentLoadInfo then
    return 0
  end
  return HomelandFindTreasureConst.MiniGameExploreComponentLoadInfo.m_first_story_id
end

function HomelandFindTreasureConst.NeedPlayPlot()
  local key = HomelandFindTreasureConst.GetFirstEnterKey()
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function HomelandFindTreasureConst.PlayPlot()
  local key = HomelandFindTreasureConst.GetFirstEnterKey()
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function HomelandFindTreasureConst.GetFirstEnterKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "HOMELAND_FIND_TREASURE_PLOT"
  return key
end
