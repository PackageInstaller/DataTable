local JumpUtil = {}
local ModuleManager = require("GameCore.Module.ModuleManager")
local LocalData = require("GameCore.Data.LocalData")

function JumpUtil.JumpTo(jumpId, ...)
  if jumpId == nil then
    return
  end
  local args = {
    ...
  }
  
  local function checkCallback(bNeedOpenPanel, bNeedTransition, nTransitionId, nTransitionType)
    local sCurModule = ModuleManager.GetCurModuleName()
    if sCurModule == "DormModuleScene" then
      if not bNeedOpenPanel then
        JumpUtil.DoJump(jumpId, table.unpack(args))
        return
      end
      local nUseTransitionId = nTransitionId == 0 and 6 or nTransitionId
      
      local function transitionOpenCallback()
        PanelManager.Home()
        
        local function OnEventAfterEnterMain()
          EventManager.Remove(EventId.AfterEnterMain, JumpUtil, OnEventAfterEnterMain)
          PanelManager.IGNORE_CS_TRANS_EVENT = false
          
          local function wait()
            coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
            coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
            JumpUtil.DoJump(jumpId, table.unpack(args))
            if not bNeedTransition then
              EventManager.Hit(EventId.SetTransition)
            end
          end
          
          cs_coroutine.start(wait)
        end
        
        local function OnEventDormLevelFinish()
          EventManager.Remove("DORM_LEVEL_FINISH", JumpUtil, OnEventDormLevelFinish)
          PanelManager.IGNORE_CS_TRANS_EVENT = true
          NovaAPI.EnterModule("MainMenuModuleScene", true)
        end
        
        EventManager.Add("DORM_LEVEL_FINISH", JumpUtil, OnEventDormLevelFinish)
        EventManager.Add(EventId.AfterEnterMain, JumpUtil, OnEventAfterEnterMain)
        NovaAPI.DispatchEventWithData("DORM_LEVEL_STATE_CHANGED", nil, {true, 0})
      end
      
      EventManager.Hit(EventId.SetTransition, nUseTransitionId, transitionOpenCallback, AllEnum.MainViewCorner.Dorm)
    else
      local function transitionOpenCallback()
        JumpUtil.DoJump(jumpId, table.unpack(args))
      end
      
      if bNeedTransition then
        EventManager.Hit(EventId.SetTransition, nTransitionId, transitionOpenCallback, nTransitionType)
      else
        transitionOpenCallback()
      end
    end
  end
  
  JumpUtil.JumpCheckAndTransition(jumpId, checkCallback, ...)
end

function JumpUtil.JumpCheckAndTransition(jumpId, callback, ...)
  local unLock, mapJumpTo = JumpUtil.CheckJumpUnLock(jumpId, true)
  if not unLock then
    callback(false, false, 0)
    return
  end
  if mapJumpTo == nil then
    printError("未配置此跳转Id, JumpId: " .. jumpId)
    callback(false, false, 0)
    return
  end
  local nType = mapJumpTo.Type
  if nType == GameEnum.jumpType.Shop then
    callback(true, true, 5)
  elseif nType == GameEnum.jumpType.Mall then
    if PanelManager.CheckPanelOpen(PanelId.Mall) or PanelManager.CheckPanelOpen(PanelId.MallPopup) then
      callback(false, false, 0)
    else
      local nState = ConfigTable.GetConfigNumber("IsShowComBtn")
      if nState == 1 then
        callback(true, true, 5)
      else
        callback(false, false, 0)
      end
    end
  elseif nType == GameEnum.jumpType.Gacha then
    local function getInfoCallback()
      callback(true, true, 6)
    end
    
    PlayerData.Gacha:GetGachaInfomation(getInfoCallback)
  elseif nType == GameEnum.jumpType.TravelerDuelLevel then
    local function checkCallback()
      local trekkerVersusData
      
      local tbActList = PlayerData.Activity:GetActivityList()
      for nId, v in pairs(tbActList) do
        local nActType = v:GetActType()
        if nActType == GameEnum.activityType.TrekkerVersus then
          trekkerVersusData = v
          break
        end
      end
      if trekkerVersusData ~= nil then
        local nActEndTime = trekkerVersusData:GetChallengeEndTime()
        local nCurTime = CS.ClientManager.Instance.serverTimeStamp
        if nActEndTime < nCurTime then
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Invalid_Tip_3"))
          return
        end
        callback(true, true, 30)
      end
    end
    
    PlayerData.Activity:SendActivityDetailMsg(checkCallback)
  elseif nType == GameEnum.jumpType.Crafting then
    if PanelManager.CheckPanelOpen(PanelId.CraftingTip) then
      callback(false, false, 0)
    elseif PanelManager.CheckPanelOpen(PanelId.Crafting) then
      callback(false, false, 0)
    else
      callback(true, false, 0)
    end
  elseif nType == GameEnum.jumpType.StarTower then
    local bState = PlayerData.State:CheckStarTowerState()
    if bState then
      return
    end
    local nStarTowerId = mapJumpTo.Param[1]
    local mapStarTower = ConfigTable.GetData("StarTower", nStarTowerId)
    if mapStarTower == nil then
      return
    end
    callback(true, false, 0)
  elseif nType == GameEnum.jumpType.StarTowerGroup then
    local bState = PlayerData.State:CheckStarTowerState()
    if bState then
      return
    end
    callback(true, false, 0)
  elseif nType == GameEnum.jumpType.StarTowerPanel then
    local bState = PlayerData.State:CheckStarTowerState()
    if bState then
      return
    end
    callback(true, false, 0)
  elseif nType == GameEnum.jumpType.InfinityTower then
    callback(true, true, 0)
  elseif nType == GameEnum.jumpType.Phone then
    local function openCallback()
      callback(true, false, 0)
    end
    
    PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Phone, openCallback)
  elseif nType == GameEnum.jumpType.Vampire then
    local function stateCallback(bReEnter)
      if not bReEnter then
        local function success(bSuccess)
          EventManager.Remove("GetTalentDataVampire", JumpUtil, success)
          
          if bSuccess then
            callback(true, true, 13)
          end
        end
        
        EventManager.Add("GetTalentDataVampire", JumpUtil, success)
        local ret, _, _ = PlayerData.VampireSurvivor:GetTalentData()
        if ret ~= nil then
          success(true)
        end
      end
    end
    
    local function callbackCheck()
      PlayerData.State:CheckVampireState(stateCallback)
    end
    
    PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.VampireSurvivor, callbackCheck, "ui_systerm_locked")
  elseif nType == GameEnum.jumpType.ComCYO then
    callback(false, false, 0)
  elseif nType == GameEnum.jumpType.ScoreBoss then
    local function openSC()
      callback(true, false, 0)
    end
    
    if not PlayerData.ScoreBoss:GetInitInfoState() then
      PlayerData.ScoreBoss:GetScoreBossInstanceData(openSC)
    else
      openSC()
    end
  elseif nType == GameEnum.jumpType.StorySet then
    PlayerData.StorySet:TryOpenStorySetPanel(function()
      callback(true, false, 0)
    end)
  elseif nType == GameEnum.jumpType.StarTowerGrowth then
    local function checkCallback()
      callback(true, false, 0)
    end
    
    PlayerData.StarTower:SendTowerGrowthDetailReq(checkCallback)
  elseif nType == GameEnum.jumpType.ActivityTask then
    local nActId = mapJumpTo.Param[1]
    if PlayerData.Activity:IsActivityInActivityGroup(nActId) then
      local actGroupId = ConfigTable.GetData("Activity", nActId).MidGroupId
      if actGroupId == 0 then
        return
      end
      local actGroupData = PlayerData.Activity:GetActivityGroupDataById(actGroupId)
      local taskActId = actGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task).ActivityId
      local taskActData = PlayerData.Activity:GetActivityDataById(taskActId)
      if taskActData ~= nil and taskActData:CheckActivityOpen() then
        callback(true, false, 0)
        return
      end
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_End_Notice"))
    end
  elseif nType == GameEnum.jumpType.QuestNewbie then
    if PanelManager.GetCurPanelId() == PanelId.QuestNewbie then
      callback(false, false, 0)
    else
      callback(true, false, 0)
    end
  elseif nType == GameEnum.jumpType.TraceHunt then
    local function afterReq()
      if PlayerData.TraceHunt:GetControlLeftTime() <= 0 then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TraceHunt_Tips_ControlInterrupt"))
        
        callback(false, false, 0)
        return
      end
      callback(true, true, 49)
    end
    
    PlayerData.TraceHunt:SendTraceHuntInfoReq(afterReq)
  elseif nType == GameEnum.jumpType.Dorm then
    if ModuleManager.GetCurModuleName() == "DormModuleScene" then
      return
    end
    
    local function GetRoomInfoCallback(mapDormRoomInfo, mapDormBaseInfo)
      if next(mapDormRoomInfo) == nil then
        return
      end
      callback(true, true, 6, AllEnum.MainViewCorner.Dorm)
    end
    
    local function GetBagInfoCallback()
      PlayerData.PlayerDormData:GetRoomInfo(GetRoomInfoCallback)
    end
    
    PlayerData.PlayerDormData:GetBagInfo(GetBagInfoCallback)
  else
    callback(true, false, 0)
  end
end

function JumpUtil.DoJump(jumpId, ...)
  local unLock, mapJumpTo = JumpUtil.CheckJumpUnLock(jumpId, true)
  if not unLock then
    return false
  end
  if mapJumpTo == nil then
    printError("未配置此跳转Id, JumpId: " .. jumpId)
    return false
  end
  PanelManager.CloseAllDisposablePanel()
  local nType = mapJumpTo.Type
  EventManager.Hit(EventId.JumpToSuccess, nType)
  if nType == GameEnum.jumpType.Mainline then
    local nMainlineId = mapJumpTo.Param[1]
    EventManager.Hit(EventId.OpenPanel, PanelId.MainlineEx, nMainlineId)
  elseif nType == GameEnum.jumpType.Rogue then
    printError("不再支持老遗迹跳转")
  elseif nType == GameEnum.jumpType.RogueGroup then
    printError("不再支持老遗迹跳转")
  elseif nType == GameEnum.jumpType.RoguePanel then
    EventManager.Hit(EventId.OpenPanel, PanelId.RoguelikeLevel, 0, 0, true)
  elseif nType == GameEnum.jumpType.RegionBoss then
    local nRegionBossGroupId = mapJumpTo.Param[1]
    local nHard = mapJumpTo.Param[2]
    EventManager.Hit(EventId.OpenPanel, PanelId.RogueBossLevel, nHard, nRegionBossGroupId, true)
  elseif nType == GameEnum.jumpType.RegionBossGroup then
    local nRegionBossGroupId = mapJumpTo.Param[1]
    EventManager.Hit(EventId.OpenPanel, PanelId.RogueBossLevel, 0, nRegionBossGroupId, true)
  elseif nType == GameEnum.jumpType.RegionBossPanel then
    EventManager.Hit(EventId.OpenPanel, PanelId.RogueBossLevel, 0, 0, true)
  elseif nType == GameEnum.jumpType.Map then
    EventManager.Hit(EventId.OpenPanel, PanelId.LevelMenu)
  elseif nType == GameEnum.jumpType.Shop then
    local nTabIndex = mapJumpTo.Param[1]
    EventManager.Hit(EventId.OpenPanel, PanelId.ShopPanel, nTabIndex)
  elseif nType == GameEnum.jumpType.Mall then
    local nTabIndex1 = mapJumpTo.Param[1]
    local nTabIndex2 = mapJumpTo.Param[2]
    if PanelManager.CheckPanelOpen(PanelId.Mall) then
      EventManager.Hit("OpenMallTog", nTabIndex1)
    elseif PanelManager.CheckPanelOpen(PanelId.MallPopup) then
      EventManager.Hit(EventId.ClosePanel, PanelId.MallPopup)
      EventManager.Hit("OpenMallTog", nTabIndex1)
    else
      local nState = ConfigTable.GetConfigNumber("IsShowComBtn")
      if nState == 1 then
        EventManager.Hit(EventId.OpenPanel, PanelId.Mall, nTabIndex1, nTabIndex2)
      else
        local sContent = ConfigTable.GetUIText("Function_NotAvailable")
        EventManager.Hit(EventId.OpenMessageBox, sContent)
      end
    end
  elseif nType == GameEnum.jumpType.Gacha then
    local nPoolId = mapJumpTo.Param[1]
    EventManager.Hit(EventId.OpenPanel, PanelId.GachaSpin, nPoolId)
  elseif nType == GameEnum.jumpType.DailyInstanceLevel then
    local nHard = mapJumpTo.Param[1]
    local nDailyType = mapJumpTo.Param[2]
    if nDailyType == nil then
      EventManager.Hit(EventId.OpenPanel, PanelId.LevelMenu, 3)
    else
      EventManager.Hit(EventId.OpenPanel, PanelId.DailyInstanceLevelSelect, nHard, nDailyType, true)
    end
  elseif nType == GameEnum.jumpType.TravelerDuelLevel then
    local function callback()
      local trekkerVersusData
      
      local tbActList = PlayerData.Activity:GetActivityList()
      for nId, v in pairs(tbActList) do
        local nActType = v:GetActType()
        if nActType == GameEnum.activityType.TrekkerVersus then
          trekkerVersusData = v
          break
        end
      end
      if trekkerVersusData ~= nil then
        local nActEndTime = trekkerVersusData:GetChallengeEndTime()
        local nCurTime = CS.ClientManager.Instance.serverTimeStamp
        if nActEndTime < nCurTime then
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Invalid_Tip_3"))
          return
        end
        
        local function func()
          EventManager.Hit(EventId.OpenPanel, PanelId.TrekkerVersus, trekkerVersusData.nActId)
        end
        
        EventManager.Hit(EventId.SetTransition, 30, func)
      end
    end
    
    PlayerData.Activity:SendActivityDetailMsg(callback)
  elseif nType == GameEnum.jumpType.Depot then
    local nItemMark = mapJumpTo.Param[1]
    EventManager.Hit(EventId.OpenPanel, PanelId.DepotPanel, nItemMark)
  elseif nType == GameEnum.jumpType.CharacterList then
    PlayerData.Char:TempClearCharInfoData()
    EventManager.Hit(EventId.OpenPanel, PanelId.CharList)
  elseif nType == GameEnum.jumpType.Crafting then
    local nProductionId = mapJumpTo.Param[1]
    if PanelManager.CheckPanelOpen(PanelId.CraftingTip) then
      local function callback()
        EventManager.Hit(EventId.TemporaryBlockInput, 0.1)
        
        local function wait()
          coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
          EventManager.Hit(EventId.OpenPanel, PanelId.CraftingTip, nProductionId)
        end
        
        cs_coroutine.start(wait)
      end
      
      EventManager.Hit("CloseCraftingTipPanel", callback)
    elseif PanelManager.CheckPanelOpen(PanelId.Crafting) then
      EventManager.Hit("JumpToProduction", nProductionId)
    else
      EventManager.Hit(EventId.OpenPanel, PanelId.CraftingTip, nProductionId)
    end
  elseif nType == GameEnum.jumpType.StarTower then
    local bState = PlayerData.State:CheckStarTowerState()
    if bState then
      return
    end
    local nStarTowerId = mapJumpTo.Param[1]
    local mapStarTower = ConfigTable.GetData("StarTower", nStarTowerId)
    if mapStarTower == nil then
      return
    end
    EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerLevelSelect, mapStarTower.Difficulty, mapStarTower.GroupId, true)
  elseif nType == GameEnum.jumpType.StarTowerGroup then
    local bState = PlayerData.State:CheckStarTowerState()
    if bState then
      return
    end
    local nStarTowerGroupId = mapJumpTo.Param[1]
    EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerLevelSelect, 0, nStarTowerGroupId, true)
  elseif nType == GameEnum.jumpType.StarTowerPanel then
    local bState = PlayerData.State:CheckStarTowerState()
    if bState then
      return
    end
    EventManager.Hit(EventId.OpenPanel, PanelId.LevelMenu, 2)
  elseif nType == GameEnum.jumpType.Disc then
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscList)
  elseif nType == GameEnum.jumpType.EquipmentPanel then
    EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentInstanceLevelSelect)
  elseif nType == GameEnum.jumpType.EquipmentGroup then
    local nGroup = mapJumpTo.Param[1]
    local nRewardType = mapJumpTo.Param[2]
    EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentInstanceLevelSelect, 0, nGroup, true, nRewardType)
  elseif nType == GameEnum.jumpType.MainlineStory then
    EventManager.Hit(EventId.OpenPanel, PanelId.StoryChapter)
  elseif nType == GameEnum.jumpType.InfinityTower then
    CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
    EventManager.Hit(EventId.OpenPanel, PanelId.InfinityTowerSelectTower)
  elseif nType == GameEnum.jumpType.InfinityTowerGroup then
    local nStarTowerId = mapJumpTo.Param[1]
    EventManager.Hit(EventId.OpenPanel, PanelId.InfinityTowerSelectTower, nStarTowerId)
    CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
  elseif nType == GameEnum.jumpType.Agent then
    EventManager.Hit(EventId.OpenPanel, PanelId.DispatchPanel)
    CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
  elseif nType == GameEnum.jumpType.Phone then
    local nTog = mapJumpTo.Param[1]
    PlayerData.Phone:OpenPhonePanel(nil, nTog)
  elseif nType == GameEnum.jumpType.Vampire then
    EventManager.Hit(EventId.OpenPanel, PanelId.VampireSurvivorLevelSelectPanel)
  elseif nType == GameEnum.jumpType.ComCYO then
    EventManager.Hit(EventId.OpenPanel, PanelId.Consumable, select(1, ...), select(2, ...), select(3, ...))
  elseif nType == GameEnum.jumpType.Quest then
    local nTog = mapJumpTo.Param[1]
    EventManager.Hit(EventId.OpenPanel, PanelId.Quest, nTog)
  elseif nType == GameEnum.jumpType.SkillInstancePanel then
    EventManager.Hit(EventId.OpenPanel, PanelId.SkillInstanceLevelSelect)
  elseif nType == GameEnum.jumpType.SkillInstanceGroup then
    local nGroup = mapJumpTo.Param[1]
    EventManager.Hit(EventId.OpenPanel, PanelId.SkillInstanceLevelSelect, 0, nGroup, true)
  elseif nType == GameEnum.jumpType.ScoreBoss then
    EventManager.Hit(EventId.OpenPanel, PanelId.ScoreBossSelectPanel)
  elseif nType == GameEnum.jumpType.WeeklyCopies then
    EventManager.Hit(EventId.OpenPanel, PanelId.WeeklyCopiesPanel, mapJumpTo.Param[1])
  elseif nType == GameEnum.jumpType.StorySet then
    EventManager.Hit(EventId.OpenPanel, PanelId.StorySet, true)
  elseif nType == GameEnum.jumpType.StarTowerGrowth then
    EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerGrowth)
  elseif nType == GameEnum.jumpType.ActivityTask then
    local nActId = mapJumpTo.Param[1]
    local panelId = mapJumpTo.Param[2]
    local tabId = mapJumpTo.Param[3]
    if PlayerData.Activity:IsActivityInActivityGroup(nActId) then
      local actGroupId = ConfigTable.GetData("Activity", nActId).MidGroupId
      if actGroupId == 0 then
        return
      end
      local actGroupData = PlayerData.Activity:GetActivityGroupDataById(actGroupId)
      local taskActId = actGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task).ActivityId
      EventManager.Hit(EventId.OpenPanel, panelId, taskActId, tabId)
    end
  elseif nType == GameEnum.jumpType.MainLineStoryChapter then
    local chapterIndex = mapJumpTo.Param[1]
    local isUnlock = PlayerData.Avg:IsStoryChapterUnlock(chapterIndex)
    if not isUnlock then
      EventManager.Hit(EventId.OpenPanel, PanelId.StoryChapter)
    else
      EventManager.Hit(EventId.OpenPanel, PanelId.MainlineEx, chapterIndex)
    end
  elseif nType == GameEnum.jumpType.QuestNewbie then
    local nJumpTab = mapJumpTo.Param[1]
    if PanelManager.GetCurPanelId() == PanelId.QuestNewbie then
      EventManager.Hit("QuestNewbiePanelChangeTab", nJumpTab)
    else
      EventManager.Hit(EventId.OpenPanel, PanelId.QuestNewbie, nJumpTab)
    end
  elseif nType == GameEnum.jumpType.CharInfo then
    local nCharId = mapJumpTo.Param[1]
    local nModuleType = mapJumpTo.Param[2]
    local tbCharInfoPanelId = {
      [1] = PanelId.CharInfo,
      [2] = PanelId.CharSkill,
      [3] = PanelId.CharPotential,
      [4] = PanelId.CharEquipment,
      [5] = PanelId.CharTalent,
      [6] = PanelId.CharacterRelation
    }
    local nCharInfoPanelId = tbCharInfoPanelId[nModuleType] or PanelId.CharInfo
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgPanel, nCharInfoPanelId, nCharId, {nCharId})
  elseif nType == GameEnum.jumpType.TraceHunt then
    EventManager.Hit(EventId.OpenPanel, PanelId.TraceHunt)
  elseif nType == GameEnum.jumpType.Soldier then
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierMainViewPanel)
  elseif nType == GameEnum.jumpType.Dorm then
    EventManager.Hit(EventId.OpenPanel, PanelId.DormPanel)
  end
end

function JumpUtil.CheckJumpUnLock(jumpId, showTips)
  local mapJumpTo = ConfigTable.GetData("JumpTo", jumpId)
  if mapJumpTo == nil then
    printError("未配置此跳转Id, JumpId: " .. jumpId)
    return false
  end
  local nType = mapJumpTo.Type
  local bOpen = true
  local bFuncUnlock = true
  local sLockTip = ConfigTable.GetUIText("JumpTo_LevelUnlock")
  if nType == GameEnum.jumpType.Mainline then
    local nMainlineId = mapJumpTo.Param[1]
    bOpen = PlayerData.Mainline:IsMainlineLevelUnlock(nMainlineId)
  elseif nType == GameEnum.jumpType.Rogue then
    printError("不再支持老遗迹跳转")
  elseif nType == GameEnum.jumpType.RogueGroup then
    printError("不再支持老遗迹跳转")
  elseif nType == GameEnum.jumpType.RegionBossGroup then
    local nRegionBossGroupId = mapJumpTo.Param[1]
    bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.RegionBoss, true)
    bOpen = PlayerData.RogueBoss:CheckLevelOpen(nRegionBossGroupId, nil, showTips)
    showTips = false
  elseif nType == GameEnum.jumpType.RegionBossPanel then
    bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.RegionBoss, true)
    showTips = false
  elseif nType == GameEnum.jumpType.RegionBoss then
    local nRegionBossGroupId = mapJumpTo.Param[1]
    local nHard = mapJumpTo.Param[2]
    bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.RegionBoss, true)
    bOpen = PlayerData.RogueBoss:CheckLevelOpen(nRegionBossGroupId, nHard, showTips)
    showTips = false
  elseif nType == GameEnum.jumpType.DailyInstanceLevel then
    local nHard = mapJumpTo.Param[1]
    local nDailyType = mapJumpTo.Param[2]
    bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.DailyInstance, true)
    bOpen = PlayerData.DailyInstance:CheckLevelOpen(nDailyType, nHard, showTips)
    showTips = false
  elseif nType == GameEnum.jumpType.Crafting then
    local nProductionId = mapJumpTo.Param[1]
    bOpen = PlayerData.Crafting:CheckProductionUnlock(nProductionId)
    sLockTip = ConfigTable.GetUIText("Crafting_Lock_Tip")
  elseif nType == GameEnum.jumpType.Shop then
    local nShopId = mapJumpTo.Param[1]
    bOpen, sLockTip = PlayerData.Shop:CheckShopJumpAble(nShopId)
  elseif nType == GameEnum.jumpType.StarTower then
    local nStarTowerId = mapJumpTo.Param[1]
    bOpen = PlayerData.StarTower:IsStarTowerUnlock(nStarTowerId)
  elseif nType == GameEnum.jumpType.StarTowerGroup then
    local nStarTowerGroupId = mapJumpTo.Param[1]
    bOpen = PlayerData.StarTower:IsStarTowerGroupUnlock(nStarTowerGroupId)
  elseif nType == GameEnum.jumpType.EquipmentPanel then
    bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.CharGemInstance, true)
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.CharGemInstance) or {}
    sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  elseif nType == GameEnum.jumpType.EquipmentGroup then
    bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.CharGemInstance, true)
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.CharGemInstance) or {}
    sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  elseif nType == GameEnum.jumpType.InfinityTower then
    bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.InfinityTower, true)
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.InfinityTower) or {}
    sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  elseif nType == GameEnum.jumpType.InfinityTowerGroup then
    bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.InfinityTower, true)
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.InfinityTower) or {}
    sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  elseif nType == GameEnum.jumpType.TravelerDuelLevel then
    bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.TravelerDuel, true)
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.TravelerDuel) or {}
    sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  elseif nType == GameEnum.jumpType.Agent then
    bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Agent, true)
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.Agent) or {}
    sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  elseif nType == GameEnum.jumpType.Phone then
    bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Phone, true)
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.Phone) or {}
    sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  elseif nType == GameEnum.jumpType.Quest then
    bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Quest, true)
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.Quest) or {}
    local nTog = mapJumpTo.Param[1]
    if nTog == AllEnum.QuestPanelTab.DailyQuest and bOpen then
      bOpen = bOpen and PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.DailyQuest, true)
      mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.DailyQuest) or {}
    end
    sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  elseif nType == GameEnum.jumpType.SkillInstancePanel then
    bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.SkillInstance, true)
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.SkillInstance) or {}
    sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  elseif nType == GameEnum.jumpType.SkillInstanceGroup then
    bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.SkillInstance, true)
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.SkillInstance) or {}
    sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  elseif nType == GameEnum.jumpType.ScoreBoss then
    bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.ScoreBoss, true)
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.ScoreBoss) or {}
    sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  elseif nType == GameEnum.jumpType.WeeklyCopies then
    bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.WeeklyCopies, true)
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.WeeklyCopies) or {}
    sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  elseif nType == GameEnum.jumpType.QuestNewbie then
    bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.QuestNewbie, true)
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.QuestNewbie) or {}
    sLockTip = UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData)
  elseif nType == GameEnum.jumpType.CharInfo then
    local mapChar = PlayerData.Char:GetCharDataByTid(mapJumpTo.Param[1])
    if mapChar == nil then
      mapChar = ConfigTable.GetData_Character(mapJumpTo.Param[1])
      sLockTip = orderedFormat(ConfigTable.GetUIText("CharacterInfo_NotHave"), mapChar.Name)
      bOpen = false
    else
      bOpen = true
    end
  elseif nType == GameEnum.jumpType.TraceHunt then
    bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.TraceHunt, true)
    showTips = false
  elseif nType == GameEnum.jumpType.Soldier then
    bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Soldier, true)
    showTips = false
  elseif nType == GameEnum.jumpType.Dorm then
    bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Dorm, true)
    showTips = false
  end
  bOpen = bFuncUnlock and bOpen
  if not bOpen and showTips then
    EventManager.Hit(EventId.OpenMessageBox, sLockTip or "")
  end
  return bOpen, mapJumpTo
end

function JumpUtil.IsActivityJumpType(nJumpType)
  if nJumpType == nil then
    return false
  end
  return nJumpType == GameEnum.jumpType.ActivityStory or nJumpType == GameEnum.jumpType.ActivityLevel or nJumpType == GameEnum.jumpType.ActivityGame1 or nJumpType == GameEnum.jumpType.ActivityGame2
end

function JumpUtil.CheckJumpActivityOpen(tbJumpData, bShowTips)
  if tbJumpData == nil or #tbJumpData == 0 then
    return false
  end
  local nJumpType = tbJumpData[1]
  local nActivityId = tbJumpData[2]
  local nPanelId = tbJumpData[3]
  if not JumpUtil.IsActivityJumpType(nJumpType) or nActivityId == nil or nPanelId == nil then
    if bShowTips then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Not_Open"))
    end
    return false
  end
  local actGroupData = PlayerData.Activity:GetActivityGroupDataByActivityId(nActivityId)
  if actGroupData == nil then
    if bShowTips then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Not_Open"))
    end
    return false
  end
  local bOpen, _state, _sTips, bNeedRefreshData = actGroupData:CheckActivityEntranceOpen(nActivityId, nPanelId, bShowTips)
  return bOpen, actGroupData, bNeedRefreshData
end

function JumpUtil.JumpToActivity(tbJumpData)
  if tbJumpData[1] == GameEnum.jumpType.MainLineStoryChapter then
    local chapterIndex = tbJumpData[2]
    local panelId = PanelId.MainlineEx
    if chapterIndex == 11 then
      panelId = PanelId.DustDawnStory
    end
    local isUnlock = PlayerData.Avg:IsStoryChapterUnlock(chapterIndex)
    if isUnlock then
      EventManager.Hit(EventId.OpenPanel, panelId, chapterIndex)
    else
      local sLockReadTipsKey = "Mainline_Preview_Lock_Read_" .. chapterIndex
      if LocalData.GetPlayerLocalData(sLockReadTipsKey) then
        EventManager.Hit(EventId.OpenPanel, panelId, chapterIndex)
        return
      end
      local sTip = ConfigTable.GetUIText("Mainline_Preview_Lock_Read")
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = sTip,
        callbackConfirm = function()
          LocalData.SetPlayerLocalData(sLockReadTipsKey, true)
          EventManager.Hit(EventId.OpenPanel, panelId, chapterIndex)
        end
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
    return
  end
  local bOpen, actGroupData, bNeedRefreshData = JumpUtil.CheckJumpActivityOpen(tbJumpData, true)
  if not bOpen or actGroupData == nil then
    if bNeedRefreshData then
      PlayerData.Activity:SendActivityDetailMsg(nil, true)
    end
    return
  end
  local nJumpType = tbJumpData[1]
  local nActivityId = tbJumpData[2]
  local nPanelId = tbJumpData[3]
  PanelManager.CloseAllDisposablePanel()
  EventManager.Hit(EventId.JumpToSuccess, nJumpType)
  actGroupData:OpenActivityEntrance(nActivityId, nPanelId)
end

return JumpUtil
