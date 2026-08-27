local WarChessCtrl = class("WarChessCtrl")
local cs_GameObject = CS.UnityEngine.GameObject
local cs_ResLoader = CS.ResLoader
local CS_RenderMgr_Ins = CS.RenderManager.Instance
local util = require("XLua.Common.xlua_util")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local WarChesGlobalData = require("Game.WarChess.Data.WarChesGlobalData")
local WarChessInputCtrl = require("Game.WarChess.Ctrl.WarChessInputCtrl")
local WarChessCamCtrl = require("Game.WarChess.Ctrl.WarChessCamCtrl")
local WarChessMapCtrl = require("Game.WarChess.Ctrl.WarChessMapCtrl")
local WarChessTeamCtrl = require("Game.WarChess.Ctrl.WarChessTeamCtrl")
local WarChessTurnCtrl = require("Game.WarChess.Ctrl.WarChessTurnCtrl")
local WarChessFogOfWarCtrl = require("Game.WarChess.Ctrl.WarChessFogOfWarCtrl")
local WarChessInteractDealCtrl = require("Game.WarChess.Ctrl.WarChessInteractDealCtrl")
local WarChessBackPackCtrl = require("Game.WarChess.Ctrl.WarChessBackPackCtrl")
local WarChessAnimationCtrl = require("Game.WarChess.Ctrl.WarChessAnimationCtrl")
local WarChessSequenceCtrl = require("Game.WarChess.Ctrl.WarChessSequenceCtrl")
local WarChessStrategyCtrl = require("Game.WarChess.Ctrl.WarChessStrategyCtrl")
local WarChessBattleCtrl = require("Game.WarChess.Ctrl.SubSystemCtrl.WarChessBattleCtrl")
local warChessStateClass = {
  [eWarChessEnum.eWarChessState.none] = nil,
  [eWarChessEnum.eWarChessState.init] = require("Game.WarChess.State.WarChessInitState"),
  [eWarChessEnum.eWarChessState.deploy] = require("Game.WarChess.State.WarChessDeployState"),
  [eWarChessEnum.eWarChessState.play] = require("Game.WarChess.State.WarChessPlayState"),
  [eWarChessEnum.eWarChessState.finish] = nil
}
local warChessLazyLoadSubsystemCtrl = {
  [eWarChessEnum.eSystemCat.shop] = {
    class = require("Game.WarChess.Ctrl.SubSystemCtrl.WarChessStoreCtrl"),
    name = "storeCtrl"
  },
  [eWarChessEnum.eSystemCat.treash] = {
    class = require("Game.WarChess.Ctrl.SubSystemCtrl.WarChessTreashCtrl"),
    name = "treashCtrl"
  },
  [eWarChessEnum.eSystemCat.event] = {
    class = require("Game.WarChess.Ctrl.SubSystemCtrl.WarChessEventCtrl"),
    name = "eventCtrl"
  },
  [eWarChessEnum.eSystemCat.discard] = {
    class = require("Game.WarChess.Ctrl.SubSystemCtrl.WarChessDiscardCtrl"),
    name = "WarChessDiscardCtrl"
  },
  [eWarChessEnum.eSystemCat.selectAlg] = {
    class = require("Game.WarChess.Ctrl.SubSystemCtrl.WarChessSelectChipCtrl"),
    name = "selectChipCtrl"
  },
  [eWarChessEnum.eSystemCat.cannon] = {
    class = require("Game.WarChess.Ctrl.SubSystemCtrl.WarChessCannonCtrl"),
    name = "cannonCtrl"
  },
  [eWarChessEnum.eSystemCat.rescue] = {
    class = require("Game.WarChess.Ctrl.SubSystemCtrl.WarChessRescueCtrl"),
    name = "rescueCtrl"
  },
  [eWarChessEnum.eSystemCat.strategyReward] = {
    class = require("Game.WarChess.Ctrl.SubSystemCtrl.WarChessStrategyRewardCtrl"),
    name = "strategyRewardCtrl"
  },
  [eWarChessEnum.eSystemCat.jump] = {
    class = require("Game.WarChess.Ctrl.SubSystemCtrl.WarChessJumpCtrl"),
    name = "jumpCtrl"
  }
}
local warChessDynCtrl = {
  [eWarChessEnum.eDynCtrl.cleanFloorReward] = {
    class = require("Game.WarChess.Ctrl.DynCtrl.WarChessCleanFloorSelectChipDynCtrl"),
    name = "cleanFloorDynCtrl"
  }
}

function WarChessCtrl:ctor()
  self.ctrls = {}
  self.bind = {}
  self.state = eWarChessEnum.eWarChessState.none
  self.curState = nil
  self.wid = nil
  self.__isReconnect = nil
  self._afterReLoadAction = nil
  self.__curSubSystemCat = nil
  self.cat2SubCtrlDic = {}
  self.wcGlobalData = WarChesGlobalData.New()
  self.__isInWarChessScene = false
  self.__wcDiffBuff = {}
  self.__wcSubSystemBuff = {}
  self.__isInAfterSettleProcess = false
  ConfigData:LoadDynCfg(eDynConfigData.warchess_des)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_entity_res)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_grid_res)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_stress)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_event)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_event_choice)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_tip)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_cam_shake)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_shop_coin)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_shop_rare)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_fx_res)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_guide)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_room_monster)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_monster_team_data)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_general)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_event_pic)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_Interact_icon)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_entity_cat)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_grid_cat)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_level_cam)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_strategy)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_strategy_effect)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_level_trigger)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_icon_res)
  self.wcNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.WarChess)
  self.inputCtrl = WarChessInputCtrl.New(self)
  self.wcCamCtrl = WarChessCamCtrl.New(self)
  self.mapCtrl = WarChessMapCtrl.New(self)
  self.teamCtrl = WarChessTeamCtrl.New(self)
  self.turnCtrl = WarChessTurnCtrl.New(self)
  self.fogOfWarCtrl = WarChessFogOfWarCtrl.New(self)
  self.interactCtrl = WarChessInteractDealCtrl.New(self)
  self.backPackCtrl = WarChessBackPackCtrl.New(self)
  self.animaCtrl = WarChessAnimationCtrl.New(self)
  self.palySquCtrl = WarChessSequenceCtrl.New(self)
  self.wcStragegyCtrl = WarChessStrategyCtrl.New(self)
  self.battleCtrl = WarChessBattleCtrl.New(self)
  self.__onReLoadSceneOver = BindCallback(self, self.__OnReLoadSceneOver)
end

function WarChessCtrl:ChangeWarChessState(eWarChessState, enterArgs)
  if self.curState ~= nil then
    self.curState:ExitState()
    self.curState = nil
  end
  self.state = eWarChessState
  local nextStateClass = warChessStateClass[self.state]
  if nextStateClass == nil then
    return
  end
  self.curState = nextStateClass.New(self)
  self.curState:EnterState(enterArgs)
end

function WarChessCtrl:EnterWarChessByMsg(warChessMsg, isReconnect)
  self.wid = warChessMsg.wid
  self.__isReconnect = isReconnect and warChessMsg.gameState == eWarChessEnum.eWarChessServerState.GameStateNormal
  if warChessMsg.result ~= nil then
    self.__reconnectResultState = warChessMsg.result.res
  end
  self.turnCtrl:InitWCTurnCtrl(warChessMsg.pressurePoint, warChessMsg.round)
  self.backPackCtrl:SetWCBakcPack(warChessMsg.warChessUser, warChessMsg.seasonItemNum, warChessMsg.haveStrength, warChessMsg.strengthWinReward)
  self.wcStragegyCtrl:InitWCStrategyCtrl()
  self.mapCtrl:SetWCMapData(warChessMsg.battleField)
  self.teamCtrl:InitByMsg(warChessMsg.forms, self.__isReconnect)
  self.teamCtrl:UpdateHeroDataByMsg(warChessMsg.warChessUser.roles)
  if warChessMsg.uniqueRewardRecordCompleted ~= nil then
    self.wcGlobalData:SetOutsideItemBoxDic(warChessMsg.uniqueRewardRecordCompleted.records)
  end
  if warChessMsg.uniqueRewardRecordCurrent ~= nil then
    self.wcGlobalData:SetOutsideItemBoxDic(warChessMsg.uniqueRewardRecordCurrent.records)
  end
  if self.__isReconnect then
    self.teamCtrl:WCReaddAllChipData(warChessMsg.forms)
    local systemState = warChessMsg.battleField[1].systemState
    if systemState ~= nil then
      function self.__afterReconnectLoadOverCallback()
        if self.__reconnectResultState ~= nil and self.__reconnectResultState ~= eWarChessEnum.eWarChessResultState.none and systemState.cat ~= eWarChessEnum.eSystemCat.discard then
          return
        end
        local identify = {
          wid = self.wid,
          tid = systemState.tid
        }
        self:OnWCSystemChange(eWarChessEnum.eSystemOpCat.open, systemState.cat, identify, systemState)
      end
    end
  end
  self.turnCtrl:SetWCRewindTimes(warChessMsg.resetRoundNumSum, warChessMsg.resetRoundNum)
  self:LoadWarChessSecne(warChessMsg)
end

function WarChessCtrl:_OnEnterWcScene()
  WarChessManager:PlayWcAuBgm()
  WarChessManager:PlayWcAuSelctRoomSelect()
  WarChessSeasonManager:OnWCSceneLoadOver()
end

function WarChessCtrl:SetExitWhenLoadSuccess()
  self._exitWhenLoadSuccess = true
end

function WarChessCtrl:LoadWarChessSecne(warChessMsg)
  self.__isInWarChessScene = false
  
  local function preLoadFunc()
    local asyncWaitList = self.mapCtrl:GenMap()
    local asyncWaitListHero = self.teamCtrl:ReloadAllTeam()
    for _, asyncWait in ipairs(asyncWaitList) do
      coroutine.yield(asyncWait)
    end
    for _, asyncWait in ipairs(asyncWaitListHero) do
      coroutine.yield(asyncWait)
    end
  end
  
  self:ChangeShaderLod(false)
  local noShowLoading = false
  if WarChessSeasonManager:GetIsInWCSeason() then
    noShowLoading = not WarChessSeasonManager:IsFirstSeasonEnter()
  end
  CS.GSceneManager.Instance:LoadSceneAsyncByABEx("Test_WarChess", true, noShowLoading, function()
    self:__OnLoadSceneOver(warChessMsg)
  end, util.cs_generator(preLoadFunc))
  self:ChangeWarChessState(eWarChessEnum.eWarChessState.init)
end

function WarChessCtrl:__OnLoadSceneOver(warChessMsg)
  if self._exitWhenLoadSuccess then
    WarChessManager:ExitWarChess()
    return
  end
  local bindHelper = cs_GameObject.Find("BindHelper").transform
  UIUtil.LuaUIBindingTable(bindHelper, self.bind)
  self.mapCtrl:OnSceneLoadOver(true)
  self.fogOfWarCtrl:GenFog()
  self.inputCtrl:OnSceneLoadOver()
  self.wcCamCtrl:OnSceneLoadOver(true, self.__isReconnect)
  self.teamCtrl:ReSetTeamStandGridData()
  self.teamCtrl:OnSceneLoadOver()
  self.animaCtrl:OnSceneLoadOver()
  if not self.__isReconnect then
    self:ChangeWarChessState(eWarChessEnum.eWarChessState.deploy)
  else
    self:ChangeWarChessState(eWarChessEnum.eWarChessState.play)
    self.teamCtrl:CalAllTeamCouldMoveGridDic()
    if self.__afterReconnectLoadOverCallback ~= nil then
      self.__afterReconnectLoadOverCallback()
    end
    self.teamCtrl:InitWCMvpData()
    if self.__reconnectResultState ~= nil and self.__reconnectResultState ~= eWarChessEnum.eWarChessResultState.none then
      local isWin = self.__reconnectResultState == eWarChessEnum.eWarChessResultState.win
      WarChessManager:WarchesFinish(isWin, warChessMsg.overData)
    end
  end
  self.__isInWarChessScene = true
  self:_OnEnterWcScene()
  self:RunAllDiff()
  self:RunAllSystemChange()
  if WarChessSeasonManager:GetIsInWCSeason() then
    UIManager:ShowWindow(UIWindowTypeID.CommonMask):InitCommonMask(Color.black):CommonMaskFadeOut(1, function()
      UIManager:HideWindow(UIWindowTypeID.CommonMask)
    end)
  end
end

function WarChessCtrl:ReLoadWarChessSecne(action)
  self.__isInWarChessScene = false
  self._afterReLoadAction = action
  
  local function preLoadFunc()
    local asyncWaitList = self.mapCtrl:ReLoadArea()
    local asyncWaitListHero = self.teamCtrl:ReloadAllTeam()
    for _, asyncWait in ipairs(asyncWaitList) do
      coroutine.yield(asyncWait)
    end
    for _, asyncWait in ipairs(asyncWaitListHero) do
      coroutine.yield(asyncWait)
    end
    local warChessLoadingWindow = UIManager:GetWindow(UIWindowTypeID.WarChessLoading)
    if warChessLoadingWindow ~= nil then
      warChessLoadingWindow:PlayHideEffect()
    end
  end
  
  self:ChangeShaderLod(false)
  CS.GSceneManager.Instance:LoadSceneAsyncByABEx("Test_WarChess", true, true, self.__onReLoadSceneOver, util.cs_generator(preLoadFunc))
end

function WarChessCtrl:__OnReLoadSceneOver()
  if self._exitWhenLoadSuccess then
    WarChessManager:ExitWarChess()
    return
  end
  local bindHelper = cs_GameObject.Find("BindHelper").transform
  UIUtil.LuaUIBindingTable(bindHelper, self.bind)
  self.mapCtrl:ReLoadEntitys()
  self.mapCtrl:OnSceneLoadOver()
  self.inputCtrl:OnSceneLoadOver()
  self.teamCtrl:OnSceneLoadOver()
  self.wcCamCtrl:OnSceneLoadOver()
  self.animaCtrl:OnSceneLoadOver()
  self.curState:OnEnterState()
  self.fogOfWarCtrl:GenFog()
  if self._afterReLoadAction ~= nil then
    local action = self._afterReLoadAction
    self._afterReLoadAction = nil
    action()
  end
  self.__isInWarChessScene = true
  self:_OnEnterWcScene()
  self:RunAllDiff()
  self:RunAllSystemChange()
  self.palySquCtrl:ApplayReLoadSceneOver()
end

function WarChessCtrl:LeaveWarChessSecne()
  self.curState:OnExitState()
  self.wcCamCtrl:OnSceneUnload()
  self.fogOfWarCtrl:OnSceneUnload()
  self.teamCtrl:OnSceneUnload()
  self.mapCtrl:OnSceneUnload()
  self.animaCtrl:OnSceneUnload()
  self:ChangeShaderLod(true)
  self.__isInWarChessScene = false
  local monsterDetailWin = UIManager:GetWindow(UIWindowTypeID.WarChessMonsterDetail)
  if monsterDetailWin then
    monsterDetailWin:Delete()
  end
  local objDetailWin = UIManager:GetWindow(UIWindowTypeID.WarChessObjDetail)
  if objDetailWin then
    objDetailWin:Delete()
  end
end

function WarChessCtrl:WarChessApplyTimeRewind(warChessMsg)
  local function rewindFunc()
    if self.state == eWarChessEnum.eWarChessState.play then
      self.curState:WCPlayDeselectTeam()
      
      self.curState:WCHideInteract()
    end
    if self.wid ~= warChessMsg.wid then
      error("not same warchess, wid not same")
      return
    end
    self.turnCtrl:InitWCTurnCtrl(warChessMsg.pressurePoint, warChessMsg.round)
    self.turnCtrl:SetWCRewindTimes(warChessMsg.resetRoundNumSum, warChessMsg.resetRoundNum)
    self.backPackCtrl:SetWCBakcPack(warChessMsg.warChessUser, warChessMsg.seasonItemNum, warChessMsg.haveStrength, warChessMsg.strengthWinReward)
    self.wcStragegyCtrl:InitWCStrategyCtrl()
    if warChessMsg.uniqueRewardRecordCompleted ~= nil then
      self.wcGlobalData:SetOutsideItemBoxDic(warChessMsg.uniqueRewardRecordCompleted.records)
    end
    if warChessMsg.uniqueRewardRecordCurrent ~= nil then
      self.wcGlobalData:SetOutsideItemBoxDic(warChessMsg.uniqueRewardRecordCurrent.records)
    end
    self.mapCtrl:ReSetEveryAnimation2DefaultState()
    self.mapCtrl:CleanCachedLinkedGroupListDic()
    self.mapCtrl:SetWCMapData(warChessMsg.battleField)
    local asyncWaitListEntity = self.mapCtrl:RewindMap()
    for _, asyncWait in ipairs(asyncWaitListEntity) do
      coroutine.yield(asyncWait)
    end
    self.mapCtrl:OnSceneLoadOver(true)
    self.fogOfWarCtrl:DisposeAllTween()
    self.fogOfWarCtrl:UpdateAllFog()
    self.teamCtrl:InitByMsg(warChessMsg.forms, true)
    self.teamCtrl:UpdateHeroDataByMsg(warChessMsg.warChessUser.roles)
    local asyncWaitListHero = self.teamCtrl:ReloadAllTeam(true)
    for _, asyncWait in ipairs(asyncWaitListHero) do
      coroutine.yield(asyncWait)
    end
    self.teamCtrl:OnSceneLoadOver()
    self.teamCtrl:WCReaddAllChipData(warChessMsg.forms)
    self.teamCtrl:InitWCMvpData()
    self.teamCtrl:ReSetTeamStandGridData()
    self.teamCtrl:CalAllTeamCouldMoveGridDic()
    self.animaCtrl:CleanAllFx()
    self.animaCtrl:OnSceneLoadOver()
    self.animaCtrl:PlayWCAllShow()
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessInfo, function(win)
      if win ~= nil then
        win:InitWCInfo(self)
      end
    end)
    MsgCenter:Broadcast(eMsgEventId.WC_TimeRewind)
    local systemState = warChessMsg.battleField[1].systemState
    if systemState ~= nil then
      local identify = {
        wid = self.wid,
        tid = systemState.tid
      }
      self:OnWCSystemChange(eWarChessEnum.eSystemOpCat.open, systemState.cat, identify, systemState)
    end
    self.__rewindFunc = nil
  end
  
  self.__rewindFunc = GR.StartCoroutine(util.cs_generator(rewindFunc))
end

function WarChessCtrl:RunAllDiff()
  for _, warChessSync in ipairs(self.__wcDiffBuff) do
    self:OnWCSync(warChessSync)
  end
  self.__wcDiffBuff = {}
end

function WarChessCtrl:GetWcDiffBuff()
  return self.__wcDiffBuff
end

function WarChessCtrl:OnWCSync(warChessSync)
  local isNeedUpdateMoveable = false
  local isNeedPlayAnimationFXTip = false
  local isAddAp = false
  local needRefreshLeadTeamList
  if warChessSync.roleItemDiff ~= nil and table.count(warChessSync.roleItemDiff) > 0 then
    self.backPackCtrl:UpdateBackPack(warChessSync.roleItemDiff)
    warChessSync.roleItemDiff = nil
  end
  if warChessSync.formDiff ~= nil and 0 < table.count(warChessSync.formDiff) then
    needRefreshLeadTeamList = self.teamCtrl:UpdateWCTeamByHeroFormDiff(warChessSync.formDiff)
  end
  if warChessSync.rolesDiff ~= nil and 0 < table.count(warChessSync.rolesDiff) then
    self.teamCtrl:UpdateHeroDataByMsg(warChessSync.rolesDiff.update)
  end
  if warChessSync.rolesDynDiff ~= nil and 0 < table.count(warChessSync.rolesDynDiff) then
    self.teamCtrl:UpdateHeroDynDataByMsg(warChessSync.rolesDynDiff)
  end
  if warChessSync.battlePlayerDiff ~= nil and 0 < table.count(warChessSync.battlePlayerDiff) then
    self.teamCtrl:UpdateWCCommander(warChessSync.battlePlayerDiff)
  end
  if warChessSync.battlePlayerDiff ~= nil and 0 < table.count(warChessSync.formExtraDiff) then
    self.teamCtrl:UpdateTeamExtraData(warChessSync.formExtraDiff)
  end
  if not self.__isInWarChessScene then
    table.insert(self.__wcDiffBuff, warChessSync)
    return
  end
  if warChessSync.sightDiff ~= nil and 0 < table.count(warChessSync.sightDiff) then
    self.mapCtrl:UpdateWCFogData(warChessSync.sightDiff)
    self.fogOfWarCtrl:UpdateFog(warChessSync.sightDiff)
    isNeedUpdateMoveable = true
  end
  if warChessSync.unitUpdate ~= nil and 0 < table.count(warChessSync.unitUpdate) then
    self.mapCtrl:UpdateMapUnits(warChessSync.unitUpdate)
    isNeedUpdateMoveable = true
    isNeedPlayAnimationFXTip = true
  end
  if warChessSync.unitFx ~= nil and 0 < #warChessSync.unitFx then
    self.animaCtrl:UpdateWCFXs(warChessSync.unitFx)
    isNeedPlayAnimationFXTip = true
  end
  if warChessSync.unitUpdate ~= nil and 0 < table.count(warChessSync.unitUpdate) then
    self.mapCtrl:UpdateMapUnitsDelete(warChessSync.unitUpdate)
    isNeedUpdateMoveable = true
  end
  if warChessSync.formDiffPos ~= nil and 0 < table.count(warChessSync.formDiffPos) then
    isAddAp = self.teamCtrl:UpdateTeamPosByMsg(warChessSync.formDiffPos)
    isNeedUpdateMoveable = true
  end
  if warChessSync.unitAnimationClip ~= nil and 0 < #warChessSync.unitAnimationClip then
    self.animaCtrl:UpdateAnimations(warChessSync.unitAnimationClip)
    isNeedPlayAnimationFXTip = true
  end
  if warChessSync.tipsDiff ~= nil and 0 < #warChessSync.tipsDiff then
    self.animaCtrl:UpdateWCTip(warChessSync.tipsDiff)
  end
  if warChessSync.pressurePointDiff ~= nil then
    self.turnCtrl:WCStressUpdata(warChessSync.pressurePointDiff)
  end
  if warChessSync.teamStateMask ~= nil then
    self.teamCtrl:WCUpdateTeamState(warChessSync.teamStateMask)
  end
  if needRefreshLeadTeamList ~= nil then
    self.teamCtrl:RefreshWCTeamLeaderInList(needRefreshLeadTeamList)
  end
  if isNeedUpdateMoveable then
    self.teamCtrl:CalAllTeamCouldMoveGridDic()
    if self.state == eWarChessEnum.eWarChessState.play then
      local teamData = self.curState:GetCurSelectedTeamData()
      if teamData ~= nil and not teamData:GetIsMoving() then
        self.animaCtrl:WCSetMoveableFXVisiabel(teamData)
      end
    end
  end
  if isNeedPlayAnimationFXTip then
    self.animaCtrl:PlayWCAllShow()
  end
  if warChessSync.fromCmdId ~= nil and warChessSync.fromCmdId == proto_csmsg_MSG_ID.MSG_CS_WarChess_RoundStartSingle and isAddAp then
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessNotice, function(window)
      if window ~= nil then
        window:OnWCApIncrease()
      end
    end)
  end
end

function WarChessCtrl:IsWCCouldChangeSubSystem(cat)
  if self.state == eWarChessEnum.eWarChessState.play then
    if self.curState:IsMovingMonster() or self.curState:IsMovingTeam() or self.curState:GetIsWaitingEntityAnimation() or self.curState:GetIsWaitingAPReduceAnimation() and (cat == eWarChessEnum.eSystemCat.event or cat == eWarChessEnum.eSystemCat.shop) then
      return false
    end
    if not self.__isInWarChessScene then
      return false
    end
    if WarChessManager.isWCFinish then
      return false
    end
  end
  return true
end

function WarChessCtrl:RunAllSystemChange()
  local wcSubSystemBuff = self.__wcSubSystemBuff
  self.__wcSubSystemBuff = {}
  for _, subSystemOP in ipairs(wcSubSystemBuff) do
    self:OnWCSystemChange(subSystemOP.eSystemOpCat, subSystemOP.cat, subSystemOP.identify, subSystemOP.systemState)
  end
end

function WarChessCtrl:LazyLoadSubSystemCtrl(cat)
  if self.cat2SubCtrlDic[cat] ~= nil then
    return
  end
  local lazyLoadCfg = warChessLazyLoadSubsystemCtrl[cat]
  if lazyLoadCfg == nil then
    error("subSystem lazyLoadCfg not exist, cat:" .. tostring(cat))
    return
  end
  local subCtrlClass = lazyLoadCfg.class
  local subCtrlName = lazyLoadCfg.name
  self[subCtrlName] = subCtrlClass.New(self)
end

function WarChessCtrl:LazyLoadDynCtrl(cat)
  local lazyLoadCfg = warChessDynCtrl[cat]
  if lazyLoadCfg == nil then
    error("dynCtrl lazyLoadCfg not exist, cat:" .. tostring(cat))
    return
  end
  local dynCtrlClass = lazyLoadCfg.class
  local dynCtrlName = lazyLoadCfg.name
  if self[dynCtrlName] ~= nil then
    return self[dynCtrlName]
  end
  local dynCtrl = dynCtrlClass.New(self)
  self[dynCtrlName] = dynCtrl
  return dynCtrl
end

function WarChessCtrl:OnWCSystemChange(eSystemOpCat, cat, identify, systemState)
  if not self:IsWCCouldChangeSubSystem(cat) then
    table.insert(self.__wcSubSystemBuff, {
      eSystemOpCat = eSystemOpCat,
      cat = cat,
      identify = identify,
      systemState = systemState
    })
    return
  end
  local subSystemCtrl = self.cat2SubCtrlDic[cat]
  if subSystemCtrl == nil then
    self:LazyLoadSubSystemCtrl(cat)
    subSystemCtrl = self.cat2SubCtrlDic[cat]
    if subSystemCtrl == nil then
      error("subSystemCtrl not exist, cat:" .. tostring(cat))
      return
    end
  end
  if eSystemOpCat == eWarChessEnum.eSystemOpCat.open then
    if self.__curSubSystemCat ~= nil then
      error("warChess has not quit or switch subSystem:" .. tostring(self.__curSubSystemCat))
      return
    end
    subSystemCtrl:OpenWCSubSystem(systemState, identify)
    self.__curSubSystemCat = cat
  elseif eSystemOpCat == eWarChessEnum.eSystemOpCat.switch then
    local last_subSystemCtrl = self.cat2SubCtrlDic[self.__curSubSystemCat]
    if last_subSystemCtrl ~= nil then
      last_subSystemCtrl:CloseWCSubSystem(true)
      return
    end
    subSystemCtrl:OpenWCSubSystem(systemState, identify)
    self.__curSubSystemCat = cat
  elseif eSystemOpCat == eWarChessEnum.eSystemOpCat.close then
    subSystemCtrl:CloseWCSubSystem()
    self.__curSubSystemCat = nil
  end
end

function WarChessCtrl:IsWCInSubSystem()
  return self.__curSubSystemCat ~= nil or table.count(self.__wcSubSystemBuff) > 0 or self:GetIsWCInAfterSettleProcess()
end

function WarChessCtrl:GetWCSurSubSystemCat()
  return self.__curSubSystemCat
end

function WarChessCtrl:GetWCId()
  return self.wid
end

function WarChessCtrl:GetIsInWarChessScene()
  return self.__isInWarChessScene
end

function WarChessCtrl:ChangeShaderLod(isResetLod)
  if self.isCloseShadow == nil then
    local systemData = PersistentManager:GetDataModel(PersistentConfig.ePackage.SystemData)
    self.isCloseShadow = systemData:GetDisplaySettingValue("dyn_shadow") == 0
  end
  if self.isCloseShadow then
    if isResetLod then
      CS_RenderMgr_Ins:ResetShaderLODGlobal()
    else
      CS_RenderMgr_Ins:SetShaderLODGlobal(300)
    end
  end
end

function WarChessCtrl:IsWCReconnected()
  return self.__isReconnect
end

function WarChessCtrl:IsCouldMainMapInteract()
  return not self:IsWCInSubSystem() and not WarChessManager.isWCWaitingFinish
end

function WarChessCtrl:SetIsWCInAfterSettleProcess(bool)
  self.__isInAfterSettleProcess = bool
end

function WarChessCtrl:GetIsWCInAfterSettleProcess()
  return self.__isInAfterSettleProcess
end

function WarChessCtrl:Delete()
  if self.__rewindFunc ~= nil then
    GR.StopCoroutine(self.__rewindFunc)
    self.__rewindFunc = nil
  end
  self.curState:ExitState()
  for _, ctrl in pairs(self.ctrls) do
    ctrl:Delete()
  end
  self:LeaveWarChessSecne()
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_des)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_entity_res)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_grid_res)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_stress)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_event)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_event_choice)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_tip)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_cam_shake)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_shop_coin)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_fx_res)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_general)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_event_pic)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_Interact_icon)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_entity_cat)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_grid_cat)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_level_cam)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_strategy)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_strategy_effect)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_level_trigger)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_icon_res)
end

return WarChessCtrl
