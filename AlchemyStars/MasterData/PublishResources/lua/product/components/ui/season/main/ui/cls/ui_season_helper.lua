_class("UISeasonHelper", Object)
UISeasonHelper = UISeasonHelper

function UISeasonHelper.TTTest(id)
  local assets
  if id then
    assets = {
      NewRoleAsset(id, 1)
    }
  else
    assets = {
      NewRoleAsset(7000801, 1),
      NewRoleAsset(3000002, 1),
      NewRoleAsset(3000003, 1)
    }
  end
  UISeasonHelper.ShowUIGetRewards(assets)
end

function UISeasonHelper.ShowUIGetRewards(rewards, doNotSort)
  if not rewards then
    return
  end
  local tmpItemList = {}
  local petList = {}
  local petSkinList = {}
  local collectionList = {}
  local evidenceList = {}
  local petModule = GameGlobal.GetModule(PetModule)
  for _, v in pairs(rewards) do
    if petModule:IsPetID(v.assetid) then
      table.insert(petList, v)
    elseif petModule:IsPetSkinID(v.assetid) then
      local roleAsset = RoleAsset:New()
      roleAsset.assetid = petModule:GetSkinIDFromItemID(v.assetid)
      roleAsset.count = v.count
      table.insert(petSkinList, roleAsset)
    elseif UISeasonHelper.IsSeasonCollectionItem(v.assetid) then
      table.insert(collectionList, v)
    elseif UISeasonHelper.IsSeasonEvidenceItem(v.assetid) then
      table.insert(evidenceList, v)
    else
      table.insert(tmpItemList, v)
    end
  end
  local itemList = {}
  for index, value in ipairs(tmpItemList) do
    local itemCfg = Cfg.cfg_item[value.assetid]
    if itemCfg then
      table.insert(itemList, value)
    end
  end
  UISeasonHelper.ShowUIGetRewards_Pet(petList, petSkinList, collectionList, evidenceList, itemList, doNotSort)
end

function UISeasonHelper.ShowUIGetRewards_Pet(petList, petSkinList, collectionList, evidenceList, itemList, doNotSort)
  if table.count(petList) <= 0 then
    UISeasonHelper.ShowUIGetRewards_PetSkin(petSkinList, collectionList, evidenceList, itemList, doNotSort)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIPetObtain", petList, function()
    GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
    UISeasonHelper.ShowUIGetRewards_PetSkin(petSkinList, collectionList, evidenceList, itemList, doNotSort)
  end)
  return
end

function UISeasonHelper.ShowUIGetRewards_PetSkin(petSkinList, collectionList, evidenceList, itemList, doNotSort)
  if table.count(petSkinList) <= 0 then
    UISeasonHelper.ShowUIGetRewards_Collection(collectionList, evidenceList, itemList, doNotSort)
    return
  end
  local index = 0
  
  local function showNextFunc()
    index = index + 1
    if index <= #petSkinList then
      return petSkinList[index]
    end
    return nil
  end
  
  local callBackFunc
  
  function callBackFunc()
    GameGlobal.UIStateManager():CloseDialog("UIPetSkinObtainController")
    local nextAsset = showNextFunc()
    if nextAsset then
      UISeasonHelper.ShowUIGetRewards_PetSkin_Single(nextAsset, callBackFunc)
    else
      UISeasonHelper.ShowUIGetRewards_Collection(collectionList, evidenceList, itemList, doNotSort)
    end
  end
  
  UISeasonHelper.ShowUIGetRewards_PetSkin_Single(showNextFunc(), callBackFunc)
end

function UISeasonHelper.ShowUIGetRewards_PetSkin_Single(roleAsset, callBackFunc)
  if not roleAsset then
    if callBackFunc then
      callBackFunc()
    end
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIPetSkinObtainController", roleAsset, callBackFunc)
end

function UISeasonHelper.ShowUIGetRewards_Collection(collectionList, evidenceList, itemList, doNotSort)
  if table.count(collectionList) <= 0 then
    UISeasonHelper.ShowUIGetRewards_Evidence(evidenceList, itemList, doNotSort)
    return
  end
  local index = 0
  
  local function showNextFunc()
    index = index + 1
    if index <= #collectionList then
      return collectionList[index]
    end
    return nil
  end
  
  local callBackFunc
  
  function callBackFunc()
    GameGlobal.UIStateManager():CloseDialog(UISeasonHelper.CurCollectionPanel())
    local nextAsset = showNextFunc()
    if nextAsset then
      UISeasonHelper.ShowUIGetRewards_Collection_Single(nextAsset, callBackFunc)
    else
      UISeasonHelper.ShowUIGetRewards_Evidence(evidenceList, itemList, doNotSort)
    end
  end
  
  UISeasonHelper.ShowUIGetRewards_Collection_Single(showNextFunc(), callBackFunc)
end

function UISeasonHelper.ShowUIGetRewards_Evidence(evidenceList, itemList, doNotSort)
  if table.count(evidenceList) <= 0 then
    UISeasonHelper.ShowUIGetRewards_Item(itemList, doNotSort)
    return
  end
  local index = 0
  
  local function showNextFunc()
    index = index + 1
    if index <= #evidenceList then
      return evidenceList[index]
    end
    return nil
  end
  
  local callBackFunc
  
  function callBackFunc()
    GameGlobal.UIStateManager():CloseDialog(UISeasonHelper.CurGetEvidencePanel())
    local nextAsset = showNextFunc()
    if nextAsset then
      UISeasonHelper.ShowUIGetRewards_Evidence_Single(nextAsset, callBackFunc)
    else
      UISeasonHelper.ShowUIGetRewards_Item(itemList, doNotSort)
    end
  end
  
  UISeasonHelper.ShowUIGetRewards_Evidence_Single(showNextFunc(), callBackFunc)
end

function UISeasonHelper.ShowUIGetRewards_Collection_Single(roleAsset, callBackFunc)
  if not roleAsset then
    if callBackFunc then
      callBackFunc()
    end
    return
  end
  GameGlobal.UIStateManager():ShowDialog(UISeasonHelper.CurCollectionPanel(), roleAsset, callBackFunc)
end

function UISeasonHelper.ShowUIGetRewards_Evidence_Single(roleAsset, callBackFunc)
  if not roleAsset then
    if callBackFunc then
      callBackFunc()
    end
    return
  end
  GameGlobal.UIStateManager():ShowDialog(UISeasonHelper.CurGetEvidencePanel(), roleAsset, callBackFunc)
end

function UISeasonHelper.ShowUIGetRewards_Item(itemList, doNotSort)
  if table.count(itemList) <= 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
    return
  end
  GameGlobal.UIStateManager():ShowDialog(UISeasonHelper.CurGetItemPanel(), itemList, function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
  end, doNotSort)
end

function UISeasonHelper.IsSeasonCollectionItem(id)
  if id and 0 < id then
    local cfg = Cfg.cfg_item[id]
    if cfg then
      local isCollection = cfg.ItemSubType == ItemSubType.ItemSubType_Season_Collection
      return isCollection
    end
  end
  return false
end

function UISeasonHelper.IsSeasonEvidenceItem(id)
  if id and 0 < id then
    local cfg = Cfg.cfg_item[id]
    if cfg then
      local isEvidence = cfg.ItemSubType == ItemSubType.ItemSubType_Season_Common
      return isEvidence
    end
  end
  return false
end

function UISeasonHelper.ShowSeasonHelperBook(tabIndex)
  local ui = UISeasonHelper.CurSeasonHelperUI()
  if ui then
    GameGlobal.UIStateManager():ShowDialog(ui, tabIndex)
  else
    local seasonModule = GameGlobal.GetModule(SeasonModule)
    if seasonModule:UIModule():InSeasaonRunning() then
      seasonModule:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
      seasonModule:UIModule():ExitSeasonTo(UIStateType.UIMain)
    else
      seasonModule:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
    end
  end
end

function UISeasonHelper.TestShowUIStage(missionId)
  local ui = UISeasonHelper.CurSeasonStageUI()
  GameGlobal.UIStateManager():ShowDialog(ui, missionId)
end

function UISeasonHelper.TriggerStoryNode(stageId, seasonObj)
  local missionCfg = Cfg.cfg_season_mission[stageId]
  if not missionCfg then
    return
  end
  local titleId
  local titleName = StringTable.Get(missionCfg.Name)
  local missionModule = GameGlobal.GetModule(MissionModule)
  local storyId = missionModule:GetStoryByStageIdStoryType(stageId, StoryTriggerType.Node)
  if not storyId then
    Log.exception("配置错误,找不到剧情,关卡id:", stageId)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UISeasonPlotEnter", titleId, titleName, storyId, function()
    UISeasonHelper.PlotEndCallback(stageId, seasonObj)
  end)
  return
end

function UISeasonHelper.PlotEndCallback(stageId, seasonObj)
end

function UISeasonHelper.TriggerMissionNode(eventPointType, stageId, seasonObj, eventPoint)
  if eventPointType == SeasonEventPointType.Task then
    local missionCfg = Cfg.cfg_component_line_mission[stageId]
    if missionCfg then
      local id = seasonObj:GetSeasonID()
      local stage = UISeasonHelper.CurSeasonTaskStageUI(id)
      GameGlobal.UIStateManager():ShowDialog(stage, stageId, eventPoint)
    end
  else
    local missionCfg = Cfg.cfg_season_mission[stageId]
    if not missionCfg then
      return
    end
    local id = seasonObj:GetSeasonID()
    local stage = UISeasonHelper.CurSeasonStageUI(id)
    GameGlobal.UIStateManager():ShowDialog(stage, stageId)
  end
end

function UISeasonHelper.CalcBuffLevel(componentID)
  local cfgGroup = Cfg.cfg_component_season_wordbuff({ComponentID = componentID})
  if cfgGroup and 0 < #cfgGroup then
    local needItemID = cfgGroup[1].NeedItemID
    local needItemLevelMap = {}
    for index, cfg in ipairs(cfgGroup) do
      needItemLevelMap[cfg.Lv] = cfg.NeedItemNum
    end
    local itemModule = GameGlobal.GetModule(ItemModule)
    local itemCount = itemModule:GetItemCount(needItemID)
    local curLevel = 1
    local restProgress = 0
    local isMaxLevel = false
    local maxLevel = #needItemLevelMap
    for level, needItemNum in ipairs(needItemLevelMap) do
      if needItemNum <= itemCount then
        curLevel = level
        restProgress = itemCount - needItemNum
      end
    end
    if curLevel == #needItemLevelMap then
      isMaxLevel = true
    end
    local curLevelMaxProgress = 3
    if not isMaxLevel then
      curLevelMaxProgress = needItemLevelMap[curLevel + 1] - needItemLevelMap[curLevel]
    else
      curLevelMaxProgress = 3
    end
    return curLevel, restProgress, maxLevel, isMaxLevel, curLevelMaxProgress
  end
  return 1, 0, 1, false, 3
end

function UISeasonHelper._ShowDialog_CurSeason(tb, ...)
  local id = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  if id < 0 then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
    return
  end
  local dialogName = tb[id]
  if not string.isnullorempty(dialogName) then
    GameGlobal.UIStateManager():ShowDialog(dialogName, ...)
  end
end

function UISeasonHelper._GetSpawnInfo_CurSeason(tb)
  local id = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  local content = tb and tb[id] or {}
  return content.className, content.prefabName
end

function UISeasonHelper.ShowCurSeasonMainController(...)
  local id = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  local uiName = UISeasonHelper._GetSeasonCfg(id, "MainController")
  if not string.isnullorempty(uiName) then
    GameGlobal.UIStateManager():ShowDialog(uiName, ...)
    return true
  else
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
  end
end

function UISeasonHelper.ShowCurSeasonCollage()
  local id = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  local uiName = UISeasonHelper._GetSeasonCfg(id, "CollageUI")
  if not string.isnullorempty(uiName) then
    GameGlobal.UIStateManager():ShowDialog(uiName)
  end
end

function UISeasonHelper.ShowCurSeasonExchange()
  local id = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  local uiName = UISeasonHelper._GetSeasonCfg(id, "ExchangeUI")
  if not string.isnullorempty(uiName) then
    GameGlobal.UIStateManager():ShowDialog(uiName)
  end
end

function UISeasonHelper.ShowCurSeasonQuest()
  GameGlobal.UIStateManager():ShowDialog("UISeasonQuestController")
end

function UISeasonHelper.GetCurSeasonQuestContent()
  local id = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  local uiName = UISeasonHelper._GetSeasonCfg(id, "QuestContent")
  if not string.isnullorempty(uiName) then
    return uiName, uiName .. ".prefab"
  end
end

function UISeasonHelper.GetCurSeasonTaskList(name)
  local id = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  local tb = UISeasonHelper._GetSeasonCfg(id, "TaskList")
  local uiName = tb[name]
  if not uiName then
    Log.exception("UISeasonCfgs 中TaskList缺少字段:", id, "TaskList", name)
  end
  return uiName, uiName .. ".prefab"
end

function UISeasonHelper.CheckEnterVideo(seasonID)
  local cfg = Cfg.cfg_season_campaign_client[seasonID]
  if not cfg then
    Log.exception("cfg_season_campaign_client中缺少配置:", seasonID)
  end
  if not cfg.EnterVideo then
    return true
  end
  local key = GameGlobal.GetModule(RoleModule):GetPstId() .. "_" .. seasonID .. "_EnterVideo"
  return LocalDB.GetInt(key, 0) == 1
end

function UISeasonHelper.AfterShowEnterVideo(seasonID)
  local key = GameGlobal.GetModule(RoleModule):GetPstId() .. "_" .. seasonID .. "_EnterVideo"
  LocalDB.SetInt(key, 1)
end

function UISeasonHelper.CheckEnterStory(seasonID)
  local cfg = Cfg.cfg_season_campaign_client[seasonID]
  if not cfg then
    Log.exception("cfg_season_campaign_client中缺少配置:", seasonID)
  end
  if not cfg.EnterStory then
    return true
  end
  local key = GameGlobal.GetModule(RoleModule):GetPstId() .. "_" .. seasonID .. "_EnterStory"
  return LocalDB.GetInt(key, 0) == 1
end

function UISeasonHelper.AfterPlayEnterStory(seasonID)
  local key = GameGlobal.GetModule(RoleModule):GetPstId() .. "_" .. seasonID .. "_EnterStory"
  LocalDB.SetInt(key, 1)
end

function UISeasonHelper.TEST_DeleteEnterStoryAndVideo(seasonID)
  local key1 = GameGlobal.GetModule(RoleModule):GetPstId() .. "_" .. seasonID .. "_EnterStory"
  LocalDB.Delete(key1)
  local key2 = GameGlobal.GetModule(RoleModule):GetPstId() .. "_" .. seasonID .. "_EnterStory"
  LocalDB.Delete(key2)
end

function UISeasonHelper.PlayStoryInSeasonScence(storyID, onFinish)
  local seasonAudio
  local uiModule = GameGlobal.GetUIModule(SeasonModule)
  if uiModule and uiModule:InSeasaonRunning() then
    seasonAudio = uiModule:SeasonManager():SeasonAudioManager():GetSeasonAudio()
  end
  if seasonAudio then
    seasonAudio:StopSeasonSounds()
  end
  GameGlobal.UIStateManager():ShowDialog("UIStoryController", storyID, function()
    if seasonAudio then
      seasonAudio:ResumeSeasonSounds()
    end
    if onFinish then
      onFinish()
    end
  end)
end

function UISeasonHelper.PlayStory3DInSeasonScence(storyID, onFinish)
  local seasonAudio
  local uiModule = GameGlobal.GetUIModule(SeasonModule)
  if uiModule and uiModule:InSeasaonRunning() then
    seasonAudio = uiModule:SeasonManager():SeasonAudioManager():GetSeasonAudio()
  end
  if seasonAudio then
    seasonAudio:StopSeasonSounds()
  end
  GameGlobal.UIStateManager():ShowDialog(UISeasonHelper.CurSeasonStoryUI(), storyID, function()
    if seasonAudio then
      seasonAudio:ResumeSeasonSounds()
    end
    if onFinish then
      onFinish()
    end
  end)
end

function UISeasonHelper.CurSeasonSceneUI()
  local id = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(id, "SceneUI")
end

function UISeasonHelper.CurSeasonSceneState()
  local id = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(id, "SceneState")
end

function UISeasonHelper.CurSeasonStageUI(id)
  local seasonID = id or GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "StageUI")
end

function UISeasonHelper.CurSeasonTaskStageUI(id)
  local seasonID = GameGlobal.GetUIModule(SeasonModule):GetSeasonID() or id
  return UISeasonHelper._GetSeasonCfg(seasonID, "TaskStageUI")
end

function UISeasonHelper.CurSeasonHelperUI()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "HelperUI")
end

function UISeasonHelper.OpenBuffTipInnerGame()
  GameGlobal.UIStateManager():ShowDialog("UISeasonBuffInnerGameInfo")
end

function UISeasonHelper.CurCollectionPanel()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "CollectionPanel")
end

function UISeasonHelper.CurGetItemPanel()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "GetItemPanel")
end

function UISeasonHelper.CurGetEvidencePanel()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "EvidencePanel")
end

function UISeasonHelper.CurSeasonBuffIconInBattle()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "BuffIconInBattle")
end

function UISeasonHelper.CurSeasonBuffTitleInBattle()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  if seasonID == UISeasonID.S1 then
    return "str_season_buff_title"
  elseif seasonID == UISeasonID.S2 then
    return "str_season_buff_title_S2"
  elseif seasonID == UISeasonID.S3 then
    return "str_season_s3_buff_title"
  elseif seasonID == UISeasonID.S4 then
    return "str_season_s4_buff_title"
  elseif seasonID == UISeasonID.S5 then
    return "str_season_s5_buff_title"
  end
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "BuffTitleInBattle")
end

function UISeasonHelper.CurSeasonBattleResultAwardList()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "BattleResultAwardList")
end

function UISeasonHelper.IsMissionCptClosed(sample)
  local cfg = Cfg.cfg_season_campaign_client[sample.id]
  if cfg and cfg.MissionCptCloseTime then
    local closeTime = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(cfg.MissionCptCloseTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local now = GetSvrTimeNow()
    return closeTime < now
  end
  return false
end

function UISeasonHelper.GetCurSeasonAutoFightStyle()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonAutoFightHelper.GetSeasonStyleByID(seasonID)
end

function UISeasonHelper.GetPlayIconSprite()
  local uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  local seasonID = uiSeasonModule:GetSeasonID()
  local player = uiSeasonModule:SeasonManager():SeasonPlayerManager():GetPlayer()
  if player then
    local cfg = player:CurModule():Cfg()
    local altas = UISeasonHelper._GetSeasonCfg(seasonID, "PlayIconAtlas")
    return altas, cfg.PlayIcon
  end
end

function UISeasonHelper.CurSeasonStoryUI()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "StoryUI")
end

function UISeasonHelper.TalentTreeRed(sampleInfo, comLine, comTree)
  local lineRed = UISeasonHelper.TalentTreeLineRed(sampleInfo, comLine)
  local skillRed = UISeasonHelper.TalentTreeSkillRed(sampleInfo, comTree)
  return lineRed or skillRed
end

function UISeasonHelper.TalentTreeLineRed(sampleInfo, com)
  local lineRed
  if sampleInfo then
    lineRed = sampleInfo.m_components_step >> ECCampaignSeasonComponentID.LINE_MISSION & 1 == 1
  else
    lineRed = com:HaveRedPoint()
  end
  local lineCLientVal = GameGlobal.GetUIModule(SeasonModule):GetTalentTreeTreeClientTag()
  if lineCLientVal then
    return false
  end
  local hideLineRed = false
  if GameGlobal.GetUIModule(SeasonModule):GetTalentTreeTreeClientTag() then
    hideLineRed = true
  end
  return lineRed and not hideLineRed
end

function UISeasonHelper.TalentTreeSkillRed(sampleInfo, com)
  local clickTalentTreeSkill = GameGlobal.GetUIModule(SeasonModule):GetTalentTreeSkillClientTag()
  local skillRed
  if sampleInfo then
    skillRed = sampleInfo.m_components_step >> ECCampaignSeasonComponentID.TALENT_TREE & 1 == 1
  else
    skillRed = com:HaveRedPoint()
  end
  if clickTalentTreeSkill then
    return false
  end
  local hideSkillRed = false
  if GameGlobal.GetUIModule(SeasonModule):GetTalentTreeSkillClientTag() then
    hideSkillRed = true
  end
  return skillRed and not hideSkillRed
end

function UISeasonHelper.TalentTreeNew(sampleInfo, com)
  return UISeasonHelper.TalentTreeLineNew(sampleInfo, com)
end

function UISeasonHelper.TalentTreeLineNew(sampleInfo, com)
  local lineRed
  if sampleInfo then
    lineRed = sampleInfo.m_components_step >> ECCampaignSeasonComponentID.LINE_MISSION & 1 == 1
  else
    lineRed = com:HaveRedPoint()
  end
  if lineRed then
    local saveList = GameGlobal.GetUIModule(SeasonModule):GetSaveFinishLineMissionList()
    local savePassList = GameGlobal.GetUIModule(SeasonModule):GetSavePassLineMissionList()
    if saveList then
      if saveList and savePassList and table.count(saveList) == table.count(savePassList) then
        local missionid = tonumber(saveList[#saveList])
        local cfgs = Cfg.cfg_season_talent_line_ware({})
        local wares = {}
        for key, value in pairs(cfgs) do
          table.insert(wares, value)
        end
        table.sort(wares, function(a, b)
          return a.Sorted < b.Sorted
        end)
        local missionList = {}
        local saveIdx = 0
        local currIdx = 0
        for i = 1, #wares do
          local mList = wares[i].MissionList
          for j = 1, #mList do
            saveIdx = saveIdx + 1
            table.insert(missionList, mList[j])
            if mList[j] == missionid then
              currIdx = saveIdx
            end
          end
        end
        if currIdx == #missionList then
          return false
        end
        local nextidx = currIdx + 1
        local nextid = missionList[nextidx]
        local isUnLock = UISeasonHelper.GetMissionUnLock(nextid)
        if isUnLock then
          for i = 1, #wares do
            local mList = wares[i].MissionList
            if mList[1] == nextid then
              return true
            end
          end
        end
        return false
      else
        return false
      end
    else
      return true
    end
  end
  return lineRed
end

function UISeasonHelper.GetMissionUnLock(id)
  local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  local cfg_com_line_mission = Cfg.cfg_component_line_mission({CampaignMissionId = id})
  if cfg_com_line_mission and next(cfg_com_line_mission) then
    local cfg = cfg_com_line_mission[1]
    local openTime = cfg.OpenTime
    if openTime then
      local open = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(openTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      if svrTime >= open then
        return true
      end
    end
  end
  return false
end

function UISeasonHelper.TradeGameNew(sampleInfo)
  local open = sampleInfo.m_is_component_open >> ECCampaignSeasonComponentID.BUSINESS & 1 == 1
  if not open then
    return false
  end
  local key = GameGlobal.GetModule(RoleModule):GetPstId() .. "_" .. "S4TradeGameNew"
  return LocalDB.GetInt(key, 0) == 0
end

function UISeasonHelper.TradeGameRed(sampleInfo)
  local open = sampleInfo.m_is_component_open >> ECCampaignSeasonComponentID.BUSINESS & 1 == 1
  if not open then
    return false
  end
  local tradeRed = sampleInfo.m_components_step >> ECCampaignSeasonComponentID.BUSINESS & 1 == 1
  local totalRed = sampleInfo.m_components_step >> ECCampaignSeasonComponentID.TOTAL_PROCESS & 1 == 1
  local rewardRed = sampleInfo.m_components_step >> ECCampaignSeasonComponentID.REWARD_PROCESS & 1 == 1
  return tradeRed or totalRed or rewardRed
end

function UISeasonHelper.SeasonOnceMissonNew(sampleInfo)
  local isNew = false
  local openPopstar = sampleInfo.m_is_component_open >> ECCampaignSeasonComponentID.LINE_MISSION_POPSTAR & 1 == 1
  if openPopstar then
    isNew = UISeasonHelper.HasSeasonOnceMissonReadNew(sampleInfo.id .. ECCampaignSeasonComponentID.LINE_MISSION_POPSTAR)
    if isNew == true then
      return isNew
    end
  end
  local openBlackFirst = sampleInfo.m_is_component_open >> ECCampaignSeasonComponentID.LINE_MISSION_BLACKFIST & 1 == 1
  if openBlackFirst then
    isNew = UISeasonHelper.HasSeasonOnceMissonReadNew(sampleInfo.id .. ECCampaignSeasonComponentID.LINE_MISSION_BLACKFIST)
    if isNew == true then
      return isNew
    end
  end
  local openTalen = sampleInfo.m_is_component_open >> ECCampaignSeasonComponentID.LINE_MISSION_TALEN & 1 == 1
  if openTalen then
    isNew = UISeasonHelper.HasSeasonOnceMissonReadNew(sampleInfo.id .. ECCampaignSeasonComponentID.LINE_MISSION_TALEN)
    if isNew == true then
      return isNew
    end
  end
  return isNew
end

function UISeasonHelper.SeasonMazeNew()
  local isNew = false
  local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  if seasonMazeModule == nil then
    return false
  end
  local sampleInfo = seasonMazeModule:GetCurSample()
  if sampleInfo == nil then
    return false
  end
  if not sampleInfo.is_open then
    return false
  end
  if not UIActivityHelper.HasLocalDB("UISeasonMazeEnterController_Processs_New") then
    isNew = true
  end
  if not UIActivityHelper.HasLocalDB("UISeasonMazeEnterController_HandBook_New") then
    isNew = true
  end
  if LocalDB.HasKey("UISeasonMazeEnterController_Boss_New") and LocalDB.GetInt("UISeasonMazeEnterController_Boss_New") == 1 then
    isNew = true
  end
  if not LocalDB.HasKey("UISeasonMazeEnterController_Enter_Game_New") and sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) then
    isNew = true
  end
  return isNew
end

function UISeasonHelper.SeasonMazeRed()
  local isRed = false
  local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  if seasonMazeModule == nil then
    return false
  end
  local sampleInfo = seasonMazeModule:GetCurSample()
  if sampleInfo == nil then
    return false
  end
  if not sampleInfo.is_open then
    return false
  end
  if sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD) then
    isRed = true
  end
  return isRed
end

function UISeasonHelper.HasSeasonOnceMissonReadNew(componentId)
  local key = UISeasonHelper.GetEntryNewKey(componentId)
  local hasRead = UnityEngine.PlayerPrefs.HasKey(key)
  return not hasRead
end

function UISeasonHelper.GetEntryNewKey(componentId)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = "season_once_entry_" .. pstId .. componentId
  return key
end

function UISeasonHelper._GetSeasonCfg(seasonID, name)
  local curCfg = UISeasonCfgs[seasonID]
  if not curCfg then
    Log.error("UISeasonCfgs 中不包含赛季 可能是没注册:", seasonID)
    return nil
  end
  local target = curCfg[name]
  if not target then
    Log.exception("UISeasonCfgs 中不包含字段:", seasonID, name)
    return nil
  end
  return target
end

function UISeasonHelper.GetCurMainAtlas()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "MainAtlas")
end

function UISeasonHelper.GetCurLevelInfo()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "Level")
end

function UISeasonHelper.GetCurFuncAtlas()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "FuncAtlas")
end

function UISeasonHelper.GetCurExchangeCfg()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "ExchangeUI_Cfg")
end

function UISeasonHelper.GetCurCollectionCfg()
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  return UISeasonHelper._GetSeasonCfg(seasonID, "CollageUI_Cfg")
end

function UISeasonHelper.TrySeasonBattleExit(matchType, isWin)
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  local isSeason = false
  local missionCreateInfo
  if MatchType.MT_Season == matchType then
    isSeason = true
    local matchModule = GameGlobal.GetModule(MatchModule)
    local enterData = matchModule:GetMatchEnterData()
    missionCreateInfo = enterData:GetSeasonMissionInfo()
  elseif MatchType.MT_Campaign == matchType then
    local matchModule = GameGlobal.GetModule(MatchModule)
    local enterData = matchModule:GetMatchEnterData()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    local createInfo = enterData:GetMissionCreateInfo()
    if createInfo then
      local campId, comId, comType = campaignModule:ParseCampaignMissionParams(createInfo.CampaignMissionParams)
      local comCfgId = createInfo.CampaignMissionParams[ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId]
      local campConfig = Cfg.cfg_campaign[campId]
      local campType = campConfig and campConfig.CampaignType
      if campType == ECampaignType.CAMPAIGN_TYPE_SEASON_TASK_MISSION then
        missionCreateInfo = enterData:GetCampaignMissionInfo()
        isSeason = true
      elseif campType == ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON and comId == ECCampaignSeasonComponentID.LINE_MISSION then
        GameGlobal.GetModule(SeasonModule):UIModule():SetTalentTreeBattleOut(true)
        missionCreateInfo = enterData:GetCampaignMissionInfo()
        isSeason = true
      elseif campType == ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON and comId == ECCampaignSeasonComponentID.LINE_MISSION_POPSTAR then
        missionCreateInfo = enterData:GetCampaignMissionInfo()
        isSeason = true
        local uiName = seasonModule:UIModule():GetCurOnceMissionUI()
        seasonModule:UIModule():SetDefaultDialog(uiName, nil, nil, comCfgId)
      elseif campType == ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON and comId == ECCampaignSeasonComponentID.LINE_MISSION_BLACKFIST then
        missionCreateInfo = enterData:GetCampaignMissionInfo()
        isSeason = true
        local uiName = seasonModule:UIModule():GetCurOnceMissionUI()
        seasonModule:UIModule():SetDefaultDialog(uiName, nil, nil, comCfgId)
      elseif campType == ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON and comId == ECCampaignSeasonComponentID.LINE_MISSION_TALEN then
        missionCreateInfo = enterData:GetCampaignMissionInfo()
        isSeason = true
        local uiName = seasonModule:UIModule():GetCurOnceMissionUI()
        seasonModule:UIModule():SetDefaultDialog(uiName, nil, nil, comCfgId)
      end
    end
  end
  if isSeason then
    if UISeasonHelper.OnceMissionBattleFromSeasonMain then
      UISeasonHelper.OnceMissionBattleFromSeasonMain = false
      seasonModule:UIModule():SetDefaultDialog()
      GameGlobal:GetInstance():ExitCoreGame()
      GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.SeasonMain_OnceMission_Enter, nil, nil)
      return true
    end
    GameGlobal:GetInstance():ExitCoreGame()
    GameGlobal.GetModule(SeasonModule):ExitBattle(missionCreateInfo, isWin)
    return true
  end
  return false
end
