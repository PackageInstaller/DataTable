local SectorHelpFuncDic = {}
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local eSectorEntrance = require("Game.Sector.UISector.UISectorEntrance.eSectorEntrance")
local SectorEnum = require("Game.Sector.SectorEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local eSectorState = require("Game.Sector.Enum.eSectorState")
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")

local function __OpenPage(index)
  while UIManager:GetWindow(UIWindowTypeID.SectorEntrance) == nil do
    coroutine.yield(nil)
  end
  UIManager:GetWindow(UIWindowTypeID.SectorEntrance):OnClickSEPageBtn(index)
end

local function __EnterSectorLevelFunc(sectorId, difficuty, stageCfg, extraCloseFunc, enterOverCallback)
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  sectorCtrl:EnterSectorLevelWin(sectorId, difficuty, stageCfg, extraCloseFunc, enterOverCallback)
end

local function CorverNotMainEntrance()
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  sectorCtrl:SetSctState(eSectorState.CorverSector)
end

local function Back2NotMainEntrance()
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  sectorCtrl:SetSctState(eSectorState.InNotMainEntrance)
end

SectorHelpFuncDic.matDunFuncDic = {
  [eDungeonEnum.eDungeonType.DailyDungeon] = function(dungeonType, lastPlayData)
    return true, function()
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      __OpenPage(SectorEnum.ePageIndex.res)
      sectorCtrl.dailyCtrl:OpenSectorPlayMode()
    end
  end,
  [eDungeonEnum.eDungeonType.fragDungeon] = function(dungeonType, lastPlayData)
    return true, function()
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      __OpenPage(SectorEnum.ePageIndex.res)
      local jumpTargetTypeId
      if lastPlayData ~= nil then
        local extraData = lastPlayData:GetLPDExtraData()
        if extraData ~= nil then
          jumpTargetTypeId = extraData.lastSelectHeroId4LPDExtra
        end
      end
      local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
      sectorCtrl.dungeonCtrl:OpenSectorPlayMode(eSectorEntrance.eEntranceType.frageDungeon, jumpTargetTypeId, function()
        if successCallback ~= nil then
          successCallback()
        end
      end)
    end
  end,
  [eDungeonEnum.eDungeonType.matDungeon] = function(dungeonType, lastPlayData)
    return true, function()
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      __OpenPage(SectorEnum.ePageIndex.res)
      local jumpTargetTypeId
      if lastPlayData ~= nil then
        local extraData = lastPlayData:GetLPDExtraData()
        if extraData ~= nil then
          jumpTargetTypeId = extraData.lastSelectMatDungeonId4LPDExtra
        end
      end
      local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
      sectorCtrl.dungeonCtrl:OpenSectorPlayMode(eSectorEntrance.eEntranceType.resDungeon, jumpTargetTypeId, function()
        if successCallback ~= nil then
          successCallback()
        end
      end)
    end
  end,
  [eDungeonEnum.eDungeonType.ATHDungeon] = function(dungeonType, lastPlayData)
    return true, function()
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      __OpenPage(SectorEnum.ePageIndex.res)
      local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
      local jumpTargetTypeId = saveUserData:GetLastAthDungeonId()
      local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
      sectorCtrl.dungeonCtrl:OpenSectorPlayMode(eSectorEntrance.eEntranceType.athDungeon, jumpTargetTypeId, function()
        if successCallback ~= nil then
          successCallback()
        end
      end)
    end
  end
}
SectorHelpFuncDic.dunFuncDic = {
  [DungeonLevelEnum.DunLevelType.Tower] = function(dungeonLevelType, lastPlayData)
    local function RealEnter()
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      
      __OpenPage(SectorEnum.ePageIndex.challenge)
      local successCallback, tmpDungeonLevelData, lastTowerId
      if lastPlayData ~= nil then
        tmpDungeonLevelData = lastPlayData:GetLPDExtraData()
        successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        if tmpDungeonLevelData ~= nil then
          lastTowerId = tmpDungeonLevelData:GetDungeonTowerType()
        end
      end
      sectorCtrl.blackHoleCtrl:OpenSectorPlayMode(nil, lastTowerId, Back2NotMainEntrance, function()
        CorverNotMainEntrance()
        if successCallback ~= nil then
          successCallback()
        end
      end)
    end
    
    return true, RealEnter
  end,
  [DungeonLevelEnum.DunLevelType.SectorII] = function(dungeonLevelType, lastPlayData)
    local function RealEnterFunc()
      local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
      
      if sectorIICtrl ~= nil then
        local actData = lastPlayData:GetLPDActData()
        local actId = actData:GetActId()
        __OpenPage(SectorEnum.ePageIndex.act)
        sectorIICtrl:TryEnterSectorIIWin(nil, actId, true)
        return
      end
      __OpenPage(SectorEnum.ePageIndex.act)
    end
    
    return true, RealEnterFunc
  end,
  [DungeonLevelEnum.DunLevelType.SixHeroTower] = function(dungeonLevelType, lastPlayData)
    local function RealEnter()
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      
      __OpenPage(SectorEnum.ePageIndex.challenge)
      local successCallback, tmpDungeonLevelData, lastTowerId
      if lastPlayData ~= nil then
        tmpDungeonLevelData = lastPlayData:GetLPDExtraData()
        successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        if tmpDungeonLevelData ~= nil then
          lastTowerId = tmpDungeonLevelData:GetDungeonTowerType()
        end
      end
      sectorCtrl.sixHeroTowerCtrl:OpenSectorPlayMode(nil, lastTowerId, Back2NotMainEntrance, function()
        CorverNotMainEntrance()
        if successCallback ~= nil then
          successCallback()
        end
      end)
    end
    
    return true, RealEnter
  end
}
SectorHelpFuncDic.actFuncDic = {
  [ActivityFrameEnum.eActivityType.HeroGrow] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow)
      
      local successCallback, sectorId
      if lastPlayData ~= nil then
        successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        sectorId = lastPlayData:GetLastSectorId()
      end
      if sectorId ~= nil and actFrameData == nil then
        UIUtil.AddOneCover("HeroGrow")
        UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
          if window == nil then
            return
          end
          CorverNotMainEntrance()
          UIUtil.CloseOneCover("HeroGrow")
          window:InitSectorLevel(sectorId, function()
            local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
            sectorCtrl:SetSctState(eSectorState.Normal)
            if successCallback ~= nil then
              successCallback()
            end
          end)
        end)
        return
      end
      if actFrameData ~= nil and heroGrowCtrl ~= nil and actFrameData:IsActivityOpen() then
        UIUtil.AddOneCover("HeroGrow")
        __OpenPage(SectorEnum.ePageIndex.act)
        local heroGrowData = heroGrowCtrl:GetHeroGrowActivity(actId)
        local lastSelectSector = lastPlayData:GetLastSectorId()
        heroGrowCtrl:OpenHeroGrowUI(heroGrowData, __EnterSectorLevelFunc, Back2NotMainEntrance, lastSelectSector, function()
          CorverNotMainEntrance()
          if successCallback ~= nil then
            successCallback()
          end
          UIUtil.CloseOneCover("HeroGrow")
        end)
        return
      end
      __OpenPage(SectorEnum.ePageIndex.act)
    end
    
    return true, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.Carnival] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      local carnivalCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival)
      
      if actFrameData ~= nil and carnivalCtrl ~= nil and actFrameData:IsActivityOpen() then
        UIUtil.AddOneCover("lastSelectSector")
        __OpenPage(SectorEnum.ePageIndex.act)
        local lastSelectSector = lastPlayData:GetLastSectorId()
        carnivalCtrl:TryCarnivalOpenUI(actId, __EnterSectorLevelFunc, Back2NotMainEntrance, function(win)
          CorverNotMainEntrance()
          win:CarnivalReEnterSector(lastSelectSector)
          UIUtil.CloseOneCover("lastSelectSector")
        end)
        return
      end
      __OpenPage(SectorEnum.ePageIndex.act)
    end
    
    return true, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.SectorII] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
      
      if sectorIICtrl ~= nil then
        __OpenPage(SectorEnum.ePageIndex.act)
        sectorIICtrl:TryEnterSectorIIWin(nil, actId)
        return
      end
      __OpenPage(SectorEnum.ePageIndex.act)
    end
    
    return true, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.WhiteDay] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local AWDCtrl = ControllerManager:GetController(ControllerTypeId.WhiteDay)
      
      if actFrameData:IsActivityRunningTimeout() then
        if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.WhiteDayAlbum) then
          UIUtil.ReturnUntil2Marker(UIWindowTypeID.WhiteDayAlbum, false)
        else
          local AWDData = AWDCtrl:GetWhiteDayDataByActId(actFrameData:GetActId())
          UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDayAlbum, function(window)
            if window == nil then
              return
            end
            window:InitWDAlbun(AWDCtrl, AWDData)
          end)
        end
        return
      end
      if UIManager:GetWindow(UIWindowTypeID.WhiteDay) ~= nil then
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.WhiteDay, false)
      end
      local successCallback
      if lastPlayData ~= nil then
        successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
      end
      AWDCtrl:TryOpenWhiteDay(actFrameData:GetActId(), successCallback)
    end
    
    return false, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.SectorIII] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      local sectorIIICtrl = ControllerManager:GetController(ControllerTypeId.ActivitySectorIII)
      
      local successCallback, stageCfg, sector
      if lastPlayData ~= nil then
        successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        stageCfg = lastPlayData:GetLPDStageCfg()
      end
      if stageCfg then
        sector = stageCfg.sector
      end
      if sectorIIICtrl ~= nil then
        __OpenPage(SectorEnum.ePageIndex.act)
        sectorIIICtrl:TryEnterSectorIII(actFrameData:GetActId(), sector, nil, successCallback)
        return
      end
      __OpenPage(SectorEnum.ePageIndex.act)
    end
    
    return true, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.Hallowmas] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      local hallowmasCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
      
      if actFrameData ~= nil and hallowmasCtrl ~= nil then
        __OpenPage(SectorEnum.ePageIndex.act)
        UIUtil.AddOneCover("lastSelectSector")
        local lastSelectSector = lastPlayData:GetLastSectorId()
        hallowmasCtrl:OpenHallowmas(actId, __EnterSectorLevelFunc, Back2NotMainEntrance, lastSelectSector, function()
          CorverNotMainEntrance()
          UIUtil.CloseOneCover("lastSelectSector")
        end)
        return
      end
      __OpenPage(SectorEnum.ePageIndex.act)
    end
    
    return true, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.SectorI] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      local sectorIData = PlayerDataCenter.allActivitySectorIData:GetSectorIData(actId)
      
      if sectorIData ~= nil then
        __OpenPage(SectorEnum.ePageIndex.act)
        local lastSelectSector = lastPlayData:GetLastSectorId()
        UIManager:ShowWindowAsync(UIWindowTypeID.ActSummer, function(window)
          if window == nil then
            return
          end
          window:InitActivitySummer(sectorIData, __EnterSectorLevelFunc, nil)
          if lastSelectSector ~= nil then
            window:OnEnterSectorISector(lastSelectSector)
          end
        end)
        return
      end
      __OpenPage(SectorEnum.ePageIndex.act)
    end
    
    return true, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.Spring] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
      
      if springCtrl ~= nil then
        local actLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
        local successCallback
        if lastPlayData ~= nil then
          successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        end
        local isEnter = lastPlayData:IsLPDIsEnterOrReturn()
        local skipStartShow = not isEnter
        if actLobbyCtrl == nil then
          springCtrl:OpenSpring(actId, skipStartShow, function()
            if successCallback then
              successCallback()
            end
            local stageCfg = lastPlayData:GetLPDStageCfg()
            springCtrl:DoReturnToSpringCallback(actId, stageCfg)
            for _, func in ipairs(asyncFuncList) do
              if func ~= nil then
                func()
              end
            end
          end)
        else
          UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
          if successCallback ~= nil then
            successCallback()
          end
        end
      end
    end
    
    return false, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.Winter23] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local winter23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
      
      if winter23Ctrl ~= nil then
        local actLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
        local successCallback
        if lastPlayData ~= nil then
          successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        end
        local isEnter = lastPlayData:IsLPDIsEnterOrReturn()
        local skipStartShow = not isEnter
        if actLobbyCtrl == nil then
          winter23Ctrl:OpenWinter23(actId, skipStartShow, function()
            if successCallback then
              successCallback()
            end
            local stageCfg = lastPlayData:GetLPDStageCfg()
            winter23Ctrl:OpenWinter23ObjByStage(stageCfg)
            for _, func in ipairs(asyncFuncList) do
              if func ~= nil then
                func()
              end
            end
          end)
        else
          UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
          if successCallback ~= nil then
            successCallback()
          end
        end
      end
    end
    
    return false, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.Season] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
      
      if seasonCtrl ~= nil then
        local actId = actFrameData:GetActId()
        local actLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
        local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        local isEnter = lastPlayData:IsLPDIsEnterOrReturn()
        local skipStartShow = not isEnter
        if successCallback == nil then
          if actLobbyCtrl == nil then
            seasonCtrl:OpenSeason(actId, skipStartShow)
          else
            UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
          end
        elseif actLobbyCtrl == nil then
          seasonCtrl:OpenSeason(actId, skipStartShow, successCallback)
        elseif successCallback ~= nil then
          successCallback()
        end
      end
    end
    
    return false, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.RefreshDun] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local refreshDunCtrl = ControllerManager:GetController(ControllerTypeId.ActRefreshDungeon)
      
      if refreshDunCtrl ~= nil then
        refreshDunCtrl:TryOpenRefreshDun(actId)
      end
    end
    
    return true, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.ActivityCarnival23] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local isInBrotato = ExplorationManager:IsInBrotatoExp()
      
      local carnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
      if carnival23Ctrl ~= nil then
        local actId = actFrameData:GetActId()
        local actLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
        local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        if actLobbyCtrl == nil then
          local isEnter = lastPlayData:IsLPDIsEnterOrReturn()
          local skipStartShow = not isEnter
          carnival23Ctrl:OpenCarnival23(actId, skipStartShow, function()
            if successCallback then
              successCallback()
            end
            local stageCfg = lastPlayData:GetLPDStageCfg()
            carnival23Ctrl:OpenCarnival23ObjByStage(stageCfg)
            for _, func in ipairs(asyncFuncList) do
              if func ~= nil then
                func()
              end
            end
          end)
        else
          UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
          if successCallback ~= nil then
            successCallback()
          end
        end
      end
    end
    
    return false, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.CardSet] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      if not actFrameData:IsActivityOpen() then
        __OpenPage(SectorEnum.ePageIndex.act)
        
        return
      end
      local cardSetActCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
      if cardSetActCtrl ~= nil then
        local actId = actFrameData:GetActId()
        local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.CardSetEntrance) then
          UIUtil.ReturnUntil2Marker(UIWindowTypeID.CardSetEntrance, false)
        else
          local isEnter = lastPlayData:IsLPDIsEnterOrReturn()
          cardSetActCtrl:OpenActCardSetUI(not isEnter)
        end
        if successCallback ~= nil then
          successCallback()
        end
        __OpenPage(SectorEnum.ePageIndex.act)
      end
    end
    
    return true, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.Divergent] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      local successCallback, sectorId
      
      if lastPlayData ~= nil then
        successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        sectorId = lastPlayData:GetLastSectorId()
      end
      local divergentCtrl = ControllerManager:GetController(ControllerTypeId.ActivityDivergent, true)
      if actFrameData ~= nil and divergentCtrl ~= nil and actFrameData:IsActivityOpen() then
        UIUtil.AddOneCover("Divergent")
        __OpenPage(SectorEnum.ePageIndex.act)
        local lastSelectSector = lastPlayData:GetLastSectorId()
        divergentCtrl:OpenDivergentMain(actId, __EnterSectorLevelFunc, Back2NotMainEntrance, lastSelectSector, function()
          CorverNotMainEntrance()
          if successCallback ~= nil then
            successCallback()
          end
          UIUtil.CloseOneCover("Divergent")
        end)
        return
      end
      __OpenPage(SectorEnum.ePageIndex.act)
    end
    
    return true, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.ShortTheatre] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      __OpenPage(SectorEnum.ePageIndex.act)
      
      local shorTheatreWin = UIManager:ShowWindow(UIWindowTypeID.EventPreciousCompany)
      shorTheatreWin:InitShortTheatre(actFrameData:GetActivityFrameId())
    end
    
    return true, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.Anniversary23] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
      
      if anniversary23Ctrl ~= nil then
        local actId = actFrameData:GetActId()
        local actLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
        local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        if actLobbyCtrl == nil then
          local isEnter = lastPlayData:IsLPDIsEnterOrReturn()
          local skipStartShow = not isEnter
          anniversary23Ctrl:OpenAnniversary23(actId, skipStartShow, function()
            if successCallback then
              successCallback()
            end
            local isHardLevel = lastPlayData:GetLPDDngeonLevelType() == DungeonLevelEnum.DunLevelType.CommonHard
            local stageCfg = lastPlayData:GetLPDStageCfg()
            anniversary23Ctrl:OpenAnniversary23ObjByStageCfg(stageCfg, isHardLevel)
          end)
        else
          anniversary23Ctrl:SetActTaskIsJump(true)
          UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
          if successCallback ~= nil then
            successCallback()
          end
        end
      end
    end
    
    return false, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.ActBlackHole] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      __OpenPage(SectorEnum.ePageIndex.act)
      
      local actBlackHoleCtrl = ControllerManager:GetController(ControllerTypeId.ActBlackHole)
      if actBlackHoleCtrl == nil then
        return
      end
      actBlackHoleCtrl:ShowBlackHoleMainByActId(actFrameData:GetActId())
      return
    end
    
    return true, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.DailyChallenge] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      CorverNotMainEntrance()
      
      __OpenPage(SectorEnum.ePageIndex.act)
      local adcCtr = ControllerManager:GetController(ControllerTypeId.ActivityDailyChallenge)
      if adcCtr ~= nil then
        adcCtr:TryADCOpenUI(actId, Back2NotMainEntrance)
      end
      return
    end
    
    return true, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.SteinsGateMiniGame] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      CorverNotMainEntrance()
      
      __OpenPage(SectorEnum.ePageIndex.act)
      local steinsGateMiniGameCtrl = ControllerManager:GetController(ControllerTypeId.ActSteinsGateMiniGame)
      if steinsGateMiniGameCtrl ~= nil then
        steinsGateMiniGameCtrl:TryOpenSteinsGateMiniGame(actFrameData:GetActId(), Back2NotMainEntrance)
      end
      return
    end
    
    return true, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.SteinsGate] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local steinsGateCtrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
      
      if steinsGateCtrl ~= nil then
        local actId = actFrameData:GetActId()
        local actLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
        local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        if actLobbyCtrl == nil then
          local isEnter = lastPlayData:IsLPDIsEnterOrReturn()
          local skipStartShow = not isEnter
          steinsGateCtrl:OpenSteinsGate23(actId, skipStartShow, function()
            if successCallback then
              successCallback()
            end
            local stageCfg = lastPlayData:GetLPDStageCfg()
            local isWin = lastPlayData:GetLPDIsWin()
            steinsGateCtrl:SteinsGateOpenByStageCfg(actId, stageCfg, isWin)
            for _, func in ipairs(asyncFuncList) do
              if func ~= nil then
                func()
              end
            end
          end)
        else
          steinsGateCtrl:SetInLobbyEnter(true)
          if successCallback ~= nil then
            successCallback()
          end
        end
      end
    end
    
    return false, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.Spring24] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local spring24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring24)
      
      if spring24Ctrl ~= nil then
        local actId = actFrameData:GetActId()
        local actLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
        local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        if actLobbyCtrl == nil then
          local isEnter = lastPlayData:IsLPDIsEnterOrReturn()
          local skipStartShow = not isEnter
          spring24Ctrl:TryOpenActLobby(actId, skipStartShow, function()
            if successCallback then
              successCallback()
            end
          end)
        else
          spring24Ctrl:SetInLobbyEnter(true)
          if successCallback ~= nil then
            successCallback()
          end
        end
      end
    end
    
    return false, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.SoundPlayMiniGame] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      local ctrl = ControllerManager:GetController(ControllerTypeId.MiniGameMusic, true)
      
      ctrl:InitTiniGameActivityData(actType, actId, actFrameData)
      UIManager:ShowWindowAsync(UIWindowTypeID.PerformanceMain, function(win)
        CorverNotMainEntrance()
        __OpenPage(SectorEnum.ePageIndex.act)
        win:InitPerformanceMain(Back2NotMainEntrance)
      end)
      return
    end
    
    return false, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.SignInLiveStream] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      CorverNotMainEntrance()
      
      __OpenPage(SectorEnum.ePageIndex.act)
      local signinLiveStreamCtrl = ControllerManager:GetController(ControllerTypeId.ActSigninLiveStreamCtrl, true)
      signinLiveStreamCtrl:TryOpenSigninLiveStreamUI(actFrameData:GetActId(), function()
        Back2NotMainEntrance()
      end)
      return
    end
    
    return false, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.HeroGrowV3] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local heroGrowV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3)
      
      if heroGrowV3Ctrl ~= nil then
        local actId = actFrameData:GetActId()
        local lastSelectSector = lastPlayData:GetLastSectorId()
        local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        UIUtil.AddOneCover("HeroGrowV3")
        __OpenPage(SectorEnum.ePageIndex.act)
        heroGrowV3Ctrl:OpenHeroGrowV3UI(actId, __EnterSectorLevelFunc, Back2NotMainEntrance, lastSelectSector, function()
          CorverNotMainEntrance()
          if successCallback ~= nil then
            successCallback()
          end
          UIUtil.CloseOneCover("HeroGrowV3")
        end)
      end
    end
    
    return true, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.Carnival24] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local carnival24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
      
      if carnival24Ctrl ~= nil then
        local actLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
        local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        if actLobbyCtrl == nil then
          local isEnter = lastPlayData:IsLPDIsEnterOrReturn()
          local skipStartShow = not isEnter
          carnival24Ctrl:TryOpenActLobby(actId, skipStartShow, function()
            if successCallback then
              successCallback()
            end
            local stageCfg = lastPlayData:GetLPDStageCfg()
            carnival24Ctrl:Carnival24OpenByStage(actId, stageCfg)
            for _, func in ipairs(asyncFuncList) do
              if func ~= nil then
                func()
              end
            end
          end)
        else
          carnival24Ctrl:SetInLobbyEnter(true)
          if successCallback ~= nil then
            successCallback()
          end
        end
      end
    end
    
    return false, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.Bond] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local bondCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBond)
      
      if bondCtrl ~= nil then
        local actId = actFrameData:GetActId()
        local lastSelectSector = lastPlayData:GetLastSectorId()
        local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        UIUtil.AddOneCover("actBond")
        __OpenPage(SectorEnum.ePageIndex.act)
        bondCtrl:OpenActBondUI(actId, Back2NotMainEntrance, function()
          CorverNotMainEntrance()
          if successCallback ~= nil then
            successCallback()
          end
          UIUtil.CloseOneCover("actBond")
        end)
      end
    end
    
    return true, RealEnter
  end,
  [ActivityFrameEnum.eActivityType.Brotato] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby, true)
      
      local endtime = actFrameData:GetActivityEndTime()
      
      local function closeGameCallback()
        Back2NotMainEntrance()
      end
      
      local function startGameCallback()
      end
      
      UIUtil.AddOneCover("Brotato")
      __OpenPage(SectorEnum.ePageIndex.act)
      ctrl:InitBrotatoLobbyCtrl(endtime, actId, closeGameCallback, startGameCallback)
      local lastSelectSector = lastPlayData:GetLastSectorId()
      local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
      ctrl:ShowBrotatoLobbyUIMain(actId, lastSelectSector ~= nil, function()
        CorverNotMainEntrance()
        if successCallback ~= nil then
          successCallback()
        end
        UIUtil.CloseOneCover("Brotato")
      end)
    end
    
    return true, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.DeliverySimulator] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnterFunc()
      if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.DeliverySimulatorEntrance) then
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.DeliverySimulatorEntrance, false)
      else
        local dsCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator)
        if dsCtrl ~= nil then
          dsCtrl:TryOpenDeliverySimulator(actFrameData:GetActId())
        end
      end
      return
    end
    
    return true, RealEnterFunc
  end,
  [ActivityFrameEnum.eActivityType.ActAnniversary24] = function(actType, actId, actFrameData, lastPlayData, asyncFuncList)
    local function RealEnter()
      local anniversary24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
      
      if anniversary24Ctrl ~= nil then
        local actId = actFrameData:GetActId()
        local actLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
        local successCallback = lastPlayData:GetLPDActSceneLoadoverCallback()
        if actLobbyCtrl == nil then
          local isEnter = lastPlayData:IsLPDIsEnterOrReturn()
          local skipStartShow = not isEnter
          anniversary24Ctrl:TryOpenActLobby(actId, skipStartShow, function()
            if successCallback then
              successCallback()
            end
            local stageCfg = lastPlayData:GetLPDStageCfg()
            anniversary24Ctrl:Anniversary24OpenByStage(actId, stageCfg)
            for _, func in ipairs(asyncFuncList) do
              if func ~= nil then
                func()
              end
            end
          end)
        else
          UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
          if successCallback ~= nil then
            successCallback()
          end
        end
      end
    end
    
    return false, RealEnter
  end
}

function SectorHelpFuncDic.TryEnterWeeklyOrDailyChallengeFunc(lastPlayData)
  local stageCfg = lastPlayData:GetLPDStageCfg()
  local isWin = lastPlayData:GetLPDIsWin()
  if stageCfg.difficulty == SectorLevelDetailEnum.eDifficulty.weekly_challenge or stageCfg.sector == ConfigData.buildinConfig.WeeklyChallengeSectorId then
    return true, function()
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      sectorCtrl.weeklyCtrl:OpenSectorPlayMode()
    end
  elseif stageCfg.difficulty == SectorLevelDetailEnum.eDifficulty.daily_challenge then
    return true, function()
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      sectorCtrl.dailyCtrl:OpenSectorPlayMode(nil, true, isWin)
    end
  end
  return false
end

SectorHelpFuncDic.EnterChapterFuncDic = {
  [SectorEnum.SctRelevancyNormalSector] = function(sectorId, difficuty, stageCfg)
    local sctCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    if sctCtrl == nil then
      return
    end
    sctCtrl:SetSctState(eSectorState.SelectMainSectorLevel)
    sctCtrl:EnterSectorLevelWin(sectorId, difficuty, stageCfg)
  end,
  [ActivityFrameEnum.eActivityType.SectorII] = function(param, difficuty, stageCfg)
    local ActivitySectorIIResidentData = require("Game.ActivitySectorII.ActivitySectorIIResidentData")
    local sectorIIData = ActivitySectorIIResidentData.New()
    sectorIIData:InitActSctIIResidentData(param, stageCfg)
    UIManager:ShowWindowAsync(UIWindowTypeID.ActivityWinterMainMap, function(win)
      if win ~= nil then
        win:InitWinActMainMapResident(sectorIIData)
      end
      PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):RecordLastSectorSelected(param * 10)
    end)
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    sectorCtrl:SetSctState(eSectorState.SelectMainSectorLevel)
  end,
  [ActivityFrameEnum.eActivityType.Carnival] = function(sectorId, difficuty, stageCfg)
    local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
    if SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      if sectorCtrl then
        sectorCtrl:EnterSectorLevelWin(sectorId, difficuty, stageCfg, nil, function()
          local lvWin = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
          lvWin:SctLVShowSectorName()
        end)
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.SectorIII] = function(param, difficuty, stageCfg)
    local function closeFunc(toHome)
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      
      if sectorCtrl ~= nil then
        sectorCtrl:ResetToNormalState(toHome, true)
        sectorCtrl:PlaySectorBgm()
      end
    end
    
    UIManager:ShowWindowAsync(UIWindowTypeID.ActSum22Map, function(win)
      if win == nil then
        return
      end
      win:InitSum22MapResident(param, stageCfg, closeFunc)
      PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):RecordLastSectorSelected(param * 10)
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      sectorCtrl:SetSctState(eSectorState.SelectMainSectorLevel)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Winter23] = function(sectorId, difficuty, stageCfg)
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
    sectorLevelChapterCtrl:ChangeChapterDataType(SectorChapterEnum.chapterDataType.actWinter23Resident)
    sectorLevelChapterCtrl:SetCloseRepeatShow(true)
    sectorLevelChapterCtrl:SetSectorList({sectorId})
    sectorLevelChapterCtrl:EnterChapterMainEpResident(sectorId, difficuty, stageCfg, function()
      PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):RecordLastSectorSelected(sectorId * 10)
    end, function()
      sectorCtrl:ResetToNormalState(nil, true)
    end)
    sectorCtrl:SetSctState(eSectorState.SelectMainSectorLevel)
  end,
  [ActivityFrameEnum.eActivityType.ActivityCarnival23] = function(sectorId, difficuty, stageCfg)
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
    local changeType = SectorChapterEnum.actSectorToChapterDataType[sectorId] or SectorChapterEnum.chapterDataType.default
    local showChangeDiff = changeType == SectorChapterEnum.chapterDataType.actCarnival23Resident
    sectorLevelChapterCtrl:ChangeChapterDataType(changeType)
    sectorLevelChapterCtrl:SetCloseRepeatShow(true)
    sectorLevelChapterCtrl:SetSectorList({sectorId})
    sectorLevelChapterCtrl:EnterChapterMainEpResident(sectorId, difficuty, stageCfg, function()
      PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):RecordLastSectorSelected(sectorId * 10)
    end, function()
      sectorCtrl:ResetToNormalState(nil, true)
    end, showChangeDiff)
    sectorCtrl:SetSctState(eSectorState.SelectMainSectorLevel)
  end,
  [ActivityFrameEnum.eActivityType.ActAnniversary24] = function(sectorId, difficuty, stageCfg)
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
    sectorLevelChapterCtrl:ChangeChapterDataType(SectorChapterEnum.chapterDataType.actAnniversary24Resident)
    sectorLevelChapterCtrl:SetCloseRepeatShow(true)
    sectorLevelChapterCtrl:SetSectorList({sectorId})
    sectorLevelChapterCtrl:EnterChapterMainEpResident(sectorId, difficuty, stageCfg, function()
      PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):RecordLastSectorSelected(sectorId * 10)
    end, function()
      sectorCtrl:ResetToNormalState(nil, true)
    end)
    sectorCtrl:SetSctState(eSectorState.SelectMainSectorLevel)
  end,
  [ActivityFrameEnum.eActivityType.Anniversary23] = function(sectorId, difficuty, stageCfg)
    local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
    if SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      if sectorCtrl then
        sectorCtrl:EnterSectorLevelWin(sectorId, difficuty, stageCfg, nil, function()
          local lvWin = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
          lvWin:SctLVShowSectorName()
        end)
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.Carnival24] = function(sectorId, difficuty, stageCfg)
    local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
    if SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      if sectorCtrl then
        sectorCtrl:EnterSectorLevelWin(sectorId, difficuty, stageCfg, nil, function()
          local lvWin = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
          lvWin:SctLVShowSectorName()
        end)
      end
    end
  end
}
return SectorHelpFuncDic
