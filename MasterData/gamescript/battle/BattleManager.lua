local System = require("System.System")
local Manager = require("Utility.Manager")
local IUpdater = require("Ecs.IUpdater")
local bg = require("Battle.DbgRender.BattleGlobal")
local bc = require("Share.Battle.BattleConst")
local DT = require("System.DataTable")
local DataCenter = require("Data.DataCenter")
local SceneMgr = require("Managers.Scene.SceneMgr")
local Logger = require("Utility.Logger")
local EventMgr = require("Managers.EventManager.EventMgr")
local BattleRender = require("Battle.BattleRender")
local BattleScene = require("Battle.BattleScene")
local ProtoManager = require("Net.ProtoManager")
local BattleDataCenterClient = require("Battle.DbgRender.BattleData.BattleDataCenterClient")
local TimerManager = require("Managers.TimerManager")
local SettingManager = require("Managers.SettingManager")
local MobileFileDataManager = require("Managers.MobileFileDataManager")
local CommonDefine = require("World.Enums.CommonDefine")
local AvgStoryManager = require("Managers.AvgStory.AvgStoryManager")
local BattleSceneLoader = require("Battle.DbgRender.SceneLoader.BattleSceneLoader")
local BattleAssetPreloader = require("Battle.DbgRender.SceneLoader.BattleAssetPreloader")
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local JSON = require("ejoysdk_lua.libs.lunajson")
local BattleManager, Super = System.NewClass("BattleManager", Manager, IUpdater)

function BattleManager:ctor()
  Super.ctor(self)
  self.battleRender = nil
  self.battleEngine = nil
  self.battleScene = nil
  self.battleBinder = nil
  self.battleDataCenter = nil
  self.pvpBattleInfo = nil
  self.isRunInServer = nil
  self.battleTid = nil
  self.msgListOfBattleEngineUuid = {}
  self.totalMsg = {}
end

function BattleManager:Awake(binder)
  Super.Awake(self)
  self.binder = binder
  binder:BindResponse(self, "World", "OnReceiveBattleCommand", System.fn(self, self.OnReceiveBattleCommand))
  binder:BindResponse(self, "World", "LogBattle", System.fn(self, self.LogBattle))
  binder:BindResponse(self, "World", "LogBattleDetail", System.fn(self, self.LogBattleDetail))
  binder:BindEvent(EventMgr.Instance.BattleSendCommand, System.fn(self, self.OnBattleSendCommand))
  binder:BindEvent(EventMgr.Instance.OnStoryEnd, System.fn(self, self.OnStoryEnd))
  binder:BindEvent(EventMgr.Instance.DestroyBattle, System.fn(self, self.OnDestroyBattle))
  binder:BindResponse(self, "World", "OnCreatePvPBattle", System.fn(self, self.OnCreatePvPBattle))
  binder:BindResponse(self, "World", "OnReenterBattle", System.fn(self, self.OnReenterBattle))
  binder:BindEvent(EventMgr.Instance.PvPMatchEnded, System.fn(self, self.OnPvPMatchEnd))
  binder:BindEvent(EventMgr.Instance.PvPEnterBattle, System.fn(self, self.OnPvPEnterBattle))
  binder:BindEvent(EventMgr.Instance.PvpAddToPlayVoiceInfo, System.fn(self, self._OnPvpAddToPlayVoiceInfo))
  binder:BindEvent(EventMgr.Instance.PvpPlayVoiceEnd, System.fn(self, self._OnPvpPlayVoiceEnd))
  binder:BindEvent(EventMgr.Instance.ChooseRewindToBout, System.fn(self, self.OnChooseRewindToBout))
end

function BattleManager:OnDestroy()
  Super.OnDestroy(self)
  self:DisposeCurrentBattle()
  Logger.Debug("BattleManager:OnDestroy")
  DataCenter.barrierData.InBattle = false
end

function BattleManager:Update()
  local deltaTime = TimerManager.deltaTime
  if nil ~= self.battleRender then
    self.battleRender:Tick(deltaTime)
    if self.isBattleResReady then
      self:DispatchMsgToBattleRender(self.battleRender)
    end
  end
  if nil ~= self.battleScene then
    self.battleScene:Tick(deltaTime)
  end
end

function BattleManager:DispatchMsgToBattleRender(battleRender)
  local battleEngineUuid = battleRender and battleRender.battleEngineUuid
  if not battleEngineUuid then
    return
  end
  local msgList = self.msgListOfBattleEngineUuid[battleEngineUuid] or {}
  for _, msgInfo in ipairs(msgList) do
    xpcall(function()
      battleRender:OnReceiveCommand(msgInfo.msgId, msgInfo.msgData)
    end, function(err)
      Logger.Error(err)
    end)
  end
  self.msgListOfBattleEngineUuid[battleEngineUuid] = {}
end

function BattleManager:OnCreatePvPBattle(info)
  PvPSettleDataUtils.Reset()
  self.pvpBattleInfo = info.battleInfo
end

function BattleManager:OnPvPMatchEnd()
  if not UIManager.Instance:GetWindow(Urls.PvPMatchingPanel) then
    if self.battleRender then
      self:OnDestroyBattle()
      UIManager.Instance:CloseAllExcept()
    end
    self.binder:BindTimer(1, 0, nil, function()
      if not PvPSettleDataUtils.GetSettleData() then
        EventMgr.Instance.PvPEnterBattle:Dispatch()
      end
    end)
  end
end

function BattleManager:OnPvPEnterBattle()
  if self.pvpBattleInfo and not bg.battleRender then
    self:EnterBattle(self.pvpBattleInfo)
  end
end

function BattleManager:OnReenterBattle(info)
  self:EnterBattle(info.battleInfo)
end

function BattleManager:IsInBattle()
  return self.battleRender ~= nil
end

function BattleManager:IsFinished()
  if self.battleRender then
    return self.battleRender:GetWinCamp() ~= nil
  end
  return false
end

function BattleManager:MarkRestartPending()
  self.isRestartPending = true
end

function BattleManager:IsRestartPending()
  return self.isRestartPending == true
end

function BattleManager:ClearRestartPending()
  self.isRestartPending = false
end

function BattleManager:EnterBattle(battleData, isRecoverGear, isRestart, skipStory)
  bg.SendBattleEvent(rc.BattleEvent.Start, battleData)
  if self.battleRender then
    self:_RequestStartBattleOnEnterAgained()
    Logger.Error("重复进入战斗")
    return
  end
  if self:IsRestartPending() then
    Logger.Info("[BattleManager:EnterBattle] 玩家重开战斗等待中，忽略此次进入战斗，让位给玩家路径")
    return
  end
  StageFsmBeforeBattle.isSkipRecoverBattle = false
  self.isBattleing = true
  self.battleTid = battleData.battleTid
  bg.isPVP = battleData.gameplayType == bc.BattleGameplayType.PVP or battleData.gameplayType == bc.BattleGameplayType.PVP_TRAIN
  bg.isPVP_TRAIN = battleData.gameplayType == bc.BattleGameplayType.PVP_TRAIN
  Logger.Info("EnterBattle isPVP isPVP_TRAIN gameplayType battleTid", bg.isPVP, bg.isPVP_TRAIN, battleData.gameplayType, battleData.battleTid)
  bg.isPVE = not bg.isPVP
  bg.isRestart = isRestart
  self.battleSceneLoader = BattleSceneLoader(battleData.battleTid, battleData.scendId)
  self.battleBinder = self.binder:createChild()
  bg.battleData = battleData
  BattleCameraDataUtils.OnBattleInit(battleData)
  local IntroductionDataUtils = require("Data.IntroductionDataUtils")
  battleData.isIntro = false == IntroductionDataUtils.IsFinish()
  self.isRunInServer = battleData.svrRunBattle
  assert(self.battleRender == nil, "重复初始化pve")
  self.battleDataCenter = BattleDataCenterClient()
  self.battleDataCenter:OnBind(self.battleBinder)
  bg.battleDataCenter = self.battleDataCenter
  self.battleRender = BattleRender(battleData)
  self.battleScene = BattleScene(battleData.battleTid, battleData.scendId)
  BattleVoiceModel.Instance:ClearData()
  Logger.Info("EnterBattle", self.isRunInServer)
  if self.isRunInServer or battleData.isReplay then
    self.battleEngine = self:VirtualBattleEngine()
  else
    local BattleEngine = require("Battle.DbgEngine.BattleEngine")
    self.battleEngine = BattleEngine(battleData)
    self.battleEngine.battleRender = self.battleRender
    self.battleEngine.initData.isTwoAnniversaryKeeperSkillOpen = PVPCollectionDataUtils.IsOpenedInTime(DT.GetOriginalConstant("Pvp2ndKeeperSkillCollection"))
    self:DisableBattleLog()
  end
  UIAudioManager.Instance:SetMainSceneMusicState(false)
  if not self:IsPlaytBeginBattleStory(isRecoverGear, skipStory) then
    self:LoadBattleScene()
  end
end

function BattleManager:VirtualBattleEngine()
  local obj = {}
  setmetatable(obj, {
    __index = function(_, key)
      return function(p1, ...)
        local r = "WorldRequest"
        if bg.isPVP then
          r = "PvpRequest"
        end
        if bg.isReplay then
          return
        end
        if obj == p1 then
          ProtoManager.Instance:ReqServer(r, key, nil, nil, ...)
        else
          ProtoManager.Instance:ReqServer(r, key, nil, nil, p1, ...)
        end
      end
    end
  })
  return obj
end

function BattleManager:DisableBattleLog()
  function self.battleEngine.Debug(...)
  end
  
  function self.battleEngine.DebugS(...)
  end
  
  function self.battleEngine.Error(...)
  end
  
  function self.battleEngine.Warn(...)
  end
  
  function self.battleEngine.Info(...)
  end
end

function BattleManager:ReqStartBattle(isRestart)
  if self.isRunInServer then
    local requestName = "WorldRequest"
    if bg.isPVP then
      requestName = "PvpRequest"
    end
    ProtoManager.Instance:ReqServer(requestName, "StartBattle", function(data, errcode)
    end, function(errorData, errcode)
      if errcode and 11 == errcode.code then
        print("------------------请求了已经结束的战斗-------------------")
        BattleManager.Instance:DisposeCurrentBattle()
        if 0 == WorldRecoveryManager.Instance:GetWorldTid() then
          local stageData = WorldStageManager.Instance:GetCurStageData()
          local stageTid = stageData and stageData.stageId
          if stageTid and stageTid > 0 then
            WorldRecoveryManager.Instance:SetRecoverData(stageTid, WorldRecoveryManager.RecoverType.Copies)
          end
        end
        if not WorldRecoveryManager.Instance:OnRecovery(false) then
          WorldRecoveryManager.Instance.notHandleRecover = false
          if IntroductionDataUtils.IsFinish() then
            SceneMgr.Instance:EnterTown()
          else
            SceneMgr.Instance:EnterIntroduction({
              step = IntroductionDataUtils.GetStep()
            })
          end
        else
          LoginMgr.Instance:TryReqStartBattle()
        end
      end
    end, isRestart)
  elseif self.battleEngine and self.battleEngine.StartBattle then
    self.battleEngine:StartBattle(isRestart)
  end
end

function BattleManager:_RequestStartBattleOnEnterAgained()
  if self.isRunInServer then
    self:ReqStartBattle(bg.isRestart)
  end
end

function BattleManager:OnStoryEnd(storyId)
  if self.battleTid and storyId == self:GetBeginBattleStoryId() then
    bg.SendBattleEvent(rc.BattleEvent.StartStoryDone)
    self:LoadBattleScene(storyId)
  end
end

function BattleManager:LoadBattleScene(playStoryId)
  bg.SendBattleEvent(rc.BattleEvent.LoadScene)
  self:ProcessInitMsgData()
  self.isBattleResReady = false
  self.battleMsgTempList = self.battleMsgTempList or {}
  local loadSceneStartTime = os.clock()
  self.battleSceneLoader:LoadBattleScene(playStoryId, function()
    Logger.Info("加载战斗场景时间", os.clock() - loadSceneStartTime)
    bg.SendBattleEvent(rc.BattleEvent.LoadSceneDone, self.battleRender ~= nil)
    if not self.battleRender then
      return
    end
    self.isBattleResReady = true
    if self.isRunInServer or bg.isReplay then
      self.battleScene:OnSceneLoaded()
    end
    EventMgr.Instance.BattleStart:Dispatch()
    EventMgr.Instance.ConnectYeld:Dispatch(true)
    self:ResetBattleQualitySetting()
    self:RecorverBattleMsg()
    self.battleScene:InitAudio()
    
    local function afterCall()
    end
    
    EventMgr.Instance.BattleAssetsLoaded:Dispatch()
    self.battleScene:PlayBattleBGM()
    self:DispatchMsgToBattleRender(self.battleRender)
    self.battleRender:StartEntranceAnimation(function()
      self.battleScene.cameraComp:OnBattleStart()
      self.battleScene:PlayRandomStartVoice()
    end)
    BattleAssetPreloader.Instance:StartPreLoadAssets(afterCall)
  end)
  SceneMgr.Instance:EnterBattleScene()
  if self.isRunInServer and self.battleEngine.StartBattle then
    self:ReqStartBattle(bg.isRestart)
  end
end

function BattleManager:IsPlaytBeginBattleStory(isRecoverGear, skipStory)
  if skipStory then
    return false
  end
  if bg.isReplay then
    return
  end
  local beginStoryId = self:GetBeginBattleStoryId()
  if beginStoryId then
    if isRecoverGear then
      local recoverStoryId = AvgStoryManager.Instance:GetRecoverStoryId()
      if recoverStoryId ~= beginStoryId then
        return false
      end
    end
    EventMgr.Instance.StartStory:Dispatch(beginStoryId)
    bg.SendBattleEvent(rc.BattleEvent.StartStory)
    return true
  else
    return false
  end
end

function BattleManager:GetBeginBattleStoryId()
  local battleCfg = DT.BattleConfig[self.battleTid]
  return battleCfg and battleCfg.BattleBeginDialogueId
end

function BattleManager:GetVictoryStoryId()
  local battleCfg = DT.BattleConfig[self.battleTid]
  return battleCfg and battleCfg.VictoryDialogueId
end

function BattleManager:GetFailStoryId()
  local battleCfg = DT.BattleConfig[self.battleTid]
  return battleCfg and battleCfg.FailDialogueId
end

function BattleManager:EnterSimulateBattle(battleData, mockData)
  self:EnterBattle(battleData or mockData)
end

function BattleManager:ResetBattleQualitySetting()
  local bloomSetVal = SettingManager.Instance:GetBoolSettingData(CommonDefine.SettingUniqueName.Bloom)
  SettingManager.Instance:SetBloom(nil, bloomSetVal)
  local outlineSetVal = SettingManager.Instance:GetBoolSettingData(CommonDefine.SettingUniqueName.Outline)
  ApplicationUtils.SetOutlineEnable(outlineSetVal)
  local chromaticSetVal = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.SystemSetting .. CommonDefine.SettingUniqueName.ChromaticAberration .. "_val")
  SettingManager.Instance:SetChromaticAberration(nil, chromaticSetVal)
  SettingManager.Instance:ResetSceneEffects()
  local stageComp = WorldStageManager.Instance:GetCurStageComp()
  if stageComp then
    stageComp:ShowSceneEffect(false)
  end
end

function BattleManager:OnBattleSendCommand(msgId, msgData, returnObj)
  if bg.isReplay then
    return
  end
  if self.battleEngine then
    local ret = {
      self.battleEngine:OnReceiveCommand(msgId, msgData)
    }
    for i, v in ipairs(ret) do
      returnObj[i] = v
    end
  end
end

function BattleManager:DisposeCurrentBattle()
  if not self.battleRender then
    return
  end
  self:SaveBattleFile()
  Logger.ReportApusInfo("DisposeBattle {traceback}", debug.traceback())
  self.initMsgId = nil
  self.initMsgData = nil
  xpcall(function()
    self:_DoDisposeBCurrentBattle()
  end, function(err)
    xpcall(function()
      self:_ReDisposeBattleScene()
    end, debug.traceback)
    self:_ResetBattleStatus()
    local stack_trace = debug.traceback(err, 2)
    Logger.ReportApusInfo("DisposeBattleError {detail}", stack_trace)
  end)
  bg.SendBattleEvent(rc.BattleEvent.BattleEnd)
end

function BattleManager:_DoDisposeBCurrentBattle()
  BattleAssetPreloader.Instance:Clear()
  BattleKeeperSkillAssetCache.Instance:Dispose()
  if self.battleEngine and not self.isRunInServer then
    self.battleEngine:Dispose()
  end
  if self.battleScene then
    self.battleScene:Dispose()
    self.battleScene = nil
  end
  if self.battleSceneLoader then
    self.battleSceneLoader:Clear()
    self.battleSceneLoader = nil
  end
  if self.battleBinder then
    self.battleBinder:teardown()
    self.battleBinder = nil
  end
  if self.battleRender then
    self.battleRender:Dispose()
    self.battleRender = nil
  end
  self:_ResetBattleStatus()
  local stageComp = WorldStageManager.Instance:GetCurStageComp()
  if stageComp then
    stageComp:ShowSceneEffect(true)
  end
end

function BattleManager:_ReDisposeBattleScene()
  if self.battleScene then
    self.battleScene:SafeDispose()
    self.battleScene = nil
  end
  if self.battleSceneLoader then
    self.battleSceneLoader:Clear()
    self.battleSceneLoader = nil
  end
end

function BattleManager:_ResetBattleStatus()
  self.isBattleing = false
  self.isBattleResReady = nil
  self.battleMsgTempList = nil
  self.battleTid = nil
  self.battleRender = nil
  self.battleEngine = nil
  self.battleScene = nil
  self.battleSceneLoader = nil
  self.battleBinder = nil
  self.pvpBattleInfo = nil
  self.keeperSkillIds = nil
  bg.battleRender = nil
  bg.battlePanel = nil
  bg.battleScene = nil
  bg.battleDataCenter = nil
  bg.isPVE = nil
  bg.isPVP = nil
  bg.isReplay = nil
  bg.isPVP_TRAIN = nil
  bg.BanSpeedCount = 0
  DataCenter.barrierData.InBattle = false
  BattleCameraDataUtils.OnLeaveBattle()
  local stageComp = WorldStageManager.Instance:GetCurStageComp()
  if stageComp then
    stageComp:ShowSceneEffect(true)
  end
end

function BattleManager:OnBattleFinish(battleResult, battleFinishData)
  self.isBattleing = false
  if self.battleFinishCallback then
    local finishCallback = self.battleFinishCallback
    self.battleFinishCallback = nil
    finishCallback()
  end
  if not bg.battleData then
    return
  end
  if bg.battleData.isMock and bg.battleData.mockScene then
    SceneMgr.Instance:EnterSceneType(bg.battleData.mockScene)
  end
  EventMgr.Instance.BattleFinish:Dispatch(battleResult, battleFinishData)
end

function BattleManager:OnDestroyBattle()
  self:CloseBattle()
end

function BattleManager:CloseBattle()
  self:DisposeCurrentBattle()
end

function BattleManager:WaitBattleFinish(callback)
  if not self.isBattleing then
    if callback then
      callback()
    end
  else
    self.battleFinishCallback = callback
  end
end

function BattleManager:ProcessInitMsgData()
  if self.initMsgId and self.initMsgData then
    local msgid = self.initMsgId
    local msgData = self.initMsgData
    if msgid == BattleCommand.rd_RecoverBattle then
      if not bg.isReplay then
        bg.battleDataCenter:InitData(msgData, true)
      end
    elseif msgid == BattleCommand.rd_InitBattle then
      bg.battleDataCenter:InitData(msgData, false)
    end
    self.initMsgId = nil
    self.initMsgData = nil
  end
end

function BattleManager:SetInitMsgData(msgid, msgData)
  self.initMsgId = msgid
  self.initMsgData = msgData
end

function BattleManager:OnReceiveBattleCommand(msgId, msgData)
  local battleEngineUuid = msgData.battleEngineUuid
  if not self.battleRender then
    Logger.Warn("没有BattleRender却收到战斗消息 msgid = %s battleEngineUuid = %s", msgId, battleEngineUuid)
    return
  end
  if msgId == BattleCommand.rd_InitBattle or msgId == BattleCommand.rd_RecoverBattle then
    local curUuid = bg.battleRender.battleEngineUuid
    if not curUuid then
      bg.battleRender.battleEngineUuid = battleEngineUuid
    elseif curUuid ~= battleEngineUuid then
      Logger.Error("收到了不同的battleEngineUuid cur = %s new = %s", curUuid, battleEngineUuid)
    end
    self:SetInitMsgData(msgId, msgData)
    self:ProcessInitMsgData()
    self.msgListOfBattleEngineUuid[battleEngineUuid] = {}
  end
  local msgList = self.msgListOfBattleEngineUuid[battleEngineUuid]
  if msgList then
    table.insert(msgList, {msgId = msgId, msgData = msgData})
  end
  if GmClientUtils.isSaveRecord then
    local totalMsgList = self.totalMsg[battleEngineUuid] or {}
    self.totalMsg[battleEngineUuid] = totalMsgList
    table.insert(totalMsgList, {
      msgId = msgId,
      msgData = table.deepclone(msgData)
    })
  end
  if msgId == BattleCommand.rd_InitBattle then
    self:ClearStatsDetailCsv()
  end
end

function BattleManager:RecorverBattleMsg()
  if self.battleRender and self.isBattleResReady and self.battleMsgTempList then
    for i = 1, #self.battleMsgTempList do
      self.battleRender:OnReceiveCommand(self.battleMsgTempList[i].msgid, self.battleMsgTempList[i].msgData)
    end
  end
end

function BattleManager:LogBattle(msg)
  local csLogInstance = CS.Z1Client.Z1BattleLog.Instance
  if not csLogInstance then
    return
  end
  csLogInstance:LogBattle(msg)
end

function BattleManager:LogBattleDetail(data)
  BattleStatsDetailUtil.LogBattleDetail(data)
end

function BattleManager:ClearStatsDetailCsv()
  BattleStatsDetailUtil.ClearStatsDetailCsv()
end

function BattleManager:TrimStatsDetailFromBout(boutNumber)
  BattleStatsDetailUtil.TrimStatsDetailFromBout(boutNumber)
end

function BattleManager:OnChooseRewindToBout(boutNumber)
  BattleStatsDetailUtil.OnChooseRewindToBout(boutNumber)
end

function BattleManager:_OnPvpAddToPlayVoiceInfo(voiceTid)
  local needInterrupt = BattleVoiceModel.Instance:IsNeedInterrupt(voiceTid)
  BattleVoiceController.Instance:PlayPvpVoice(needInterrupt)
end

function BattleManager:_OnPvpPlayVoiceEnd()
  BattleVoiceModel.Instance:SetPlayingPvpVoice(nil)
  BattleVoiceController.Instance:PlayPvpVoice()
end

function BattleManager:SaveBattleFile()
  if not GmClientUtils.isSaveRecord then
    return
  end
  local engineUid = bg.battleRender.battleEngineUuid
  if not engineUid then
    return
  end
  local battle = {}
  battle.isReplay = true
  battle.battleData = bg.battleData
  battle.msgList = self.totalMsg[engineUid] or {}
  self.totalMsg[engineUid] = nil
  local jsonTable = MobileFileDataManager.Instance:TranslateToJsonTable(battle)
  local json_str = JSON.encode(jsonTable)
  CS.Framework.AssetLoadUtil.OnWriteGameFile("battle_record.json", json_str)
end

return BattleManager
