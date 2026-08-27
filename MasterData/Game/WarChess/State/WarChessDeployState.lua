local base = require("Game.WarChess.State.Base.WarChessStateBase")
local WarChessDeployState = class("WarChessDeployState", base)
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_Physics = CS.PhysicsUtility
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local FormationUtil = require("Game.Formation.FormationUtil")
local FmtEnum = require("Game.Formation.FmtEnum")
local WarChessDeployTeamData = require("Game.WarChess.Data.WarChessDeployTeamData")
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local eWCInteractType = require("Game.WarChess.Interact.Base.eWCInteractType")
local OfficialSupportHeroData = require("Game.Formation.Data.OfficialSupportHeroData")
local util = require("XLua.Common.xlua_util")

function WarChessDeployState:ctor(wcCtrl)
  self.__deployTeamDic = {}
  self.__dynDeployTeamDic = {}
  self.__wantDynDeployNewDTeamDic = {}
  self.__curEntity = nil
  self.__camMain = UIManager:GetMainCamera()
  self.__isDynDeploy = nil
  self.__beforeDragEntityRot = nil
  self.__onFingerDown = BindCallback(self, self.__OnFingerDown)
  self.__onFingerUp = BindCallback(self, self.__OnFingerUp)
  self.__onFingerSet = BindCallback(self, self.__OnFingerSet)
end

function WarChessDeployState:OnEnterState(enterArgs)
  if enterArgs ~= nil then
    self.__isDynDeploy = enterArgs.isDynDeploy
  end
  self:InitDeployTeam()
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessMain, function(win)
    if win == nil then
      return
    end
    win:InitWarChessDeploy(self)
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
    local isHaveAvg = avgCtrl ~= nil
    
    local function StartGuide()
      if GuideManager:TryTriggerGuide(eGuideCondition.WCLevelEnterDeploy) then
      else
        WarChessManager:QuickExeWCGuideActions(eWarChessEnum.wcGuideMomentType.WCDeployState)
      end
    end
    
    if not isHaveAvg then
      StartGuide()
    else
      if self.__waitPlayGuideCoroutine ~= nil then
        GR.StopCoroutine(self.__waitPlayGuideCoroutine)
        self.__waitPlayGuideCoroutine = nil
      end
      self.__waitPlayGuideCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, function()
        while avgCtrl ~= nil do
          coroutine.yield()
          avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
        end
        StartGuide()
        self.__waitPlayGuideCoroutine = nil
      end)))
    end
  end)
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessInfo, function(win)
    if win ~= nil then
      win:InitWCInfo(self.wcCtrl)
    end
  end)
  CS_LeanTouch.OnFingerDown("+", self.__onFingerDown)
  CS_LeanTouch.OnFingerUp("+", self.__onFingerUp)
  CS_LeanTouch.OnFingerSet("+", self.__onFingerSet)
end

function WarChessDeployState:GetIsDynDeploy()
  return self.__isDynDeploy
end

function WarChessDeployState:InitDeployTeam()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData()
  local wcLevelCfg = WarChessManager:GetWCLevelCfg()
  local maxFmtNum = self.wcCtrl.teamCtrl:GetWCFmtNum()
  local maxShowFmtNum = self.wcCtrl.teamCtrl:GetWCFmtShowNum()
  local wcsCtrl = WarChessSeasonManager:GetWCSCtrl()
  local officialCfgId
  if wcsCtrl ~= nil then
    officialCfgId = wcsCtrl:GetWCSOfficialSupportCfgId()
  end
  local fmtDatas = {}
  local forms = WarChessSeasonManager:GetWCSEnterNextFloorTeamInfo()
  WarChessSeasonManager:SetWCSEnterNextFloorTeamInfo(nil)
  if #wcLevelCfg.assist > #FormationUtil.fixedFmtIdList then
    error("fixed team not support over then " .. tostring(#FormationUtil.fixedFmtIdList))
  end
  for index = 1, maxShowFmtNum do
    local fmtId = FormationUtil.GetFmtIdOffsetByFmtFromModule(FmtEnum.eFmtFromModule.WarChess) + index
    local fixedHeroTeamId = wcLevelCfg.assist[index]
    local fixedFmtId
    if fixedHeroTeamId ~= nil then
      fixedFmtId = FormationUtil.GetFmtIdByFixedTeamId(fixedHeroTeamId)
    end
    local isFixedTeam = fixedFmtId ~= nil
    if isFixedTeam then
      local fixedTeamName = LanguageUtil.GetLocaleText(wcLevelCfg.assist_name[index])
      FormationUtil.SetFiexdFmt(fixedFmtId, fixedHeroTeamId, fixedTeamName)
      local fmtData = PlayerDataCenter.formationDic[fixedFmtId]
      if fmtData ~= nil and string.IsNullOrEmpty(fixedTeamName) then
        fmtData.name = ""
      end
    end
    if self.__isDynDeploy then
      for onboardIndex = 1, maxFmtNum do
        local teamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamIndexIgnoreDead(onboardIndex)
        if teamData ~= nil then
          local clientIndex = teamData:GetWCTeamClientIndex()
          if clientIndex == index then
            self.__dynDeployTeamDic[clientIndex] = teamData
            if teamData:GetWCTeamIsDead() then
              local fmtData = PlayerDataCenter:CreateFormation(fmtId)
              local dTeamData = WarChessDeployTeamData.New(index, fmtData)
              local power = fmtCtrl:CalculatePower(fmtData)
              dTeamData:SetDTeamTeamPower(power)
              dTeamData:SetDTeamIsFixedTeam(false)
              self.__deployTeamDic[index] = dTeamData
            end
          end
        end
      end
      if self.__deployTeamDic[index] == nil then
        local dTeamData = self:_CreateDeployTeamData(fixedFmtId, fmtId, index, fmtCtrl, forms)
        self.__deployTeamDic[index] = dTeamData
        table.insert(fmtDatas, dTeamData:GetWcDTeamFmtData())
      end
    else
      local dTeamData, isCreateNew = self:_CreateDeployTeamData(fixedFmtId, fmtId, index, fmtCtrl, forms)
      self.__deployTeamDic[index] = dTeamData
      table.insert(fmtDatas, dTeamData:GetWcDTeamFmtData())
    end
  end
  local isNeedRefresh = FormationUtil.WarChessTeamsCheck(fmtDatas, officialCfgId)
  if isNeedRefresh then
    self:RefreshAllDTeamData()
  end
end

function WarChessDeployState:_CreateDeployTeamData(fixedFmtId, fmtId, index, fmtCtrl, forms)
  local isFixedTeam = fixedFmtId ~= nil
  local fmtData
  local isCreateNew = false
  local isNeedReadFormForms = true
  if isFixedTeam then
    fmtData = PlayerDataCenter.formationDic[fixedFmtId]
    isNeedReadFormForms = false
  else
    fmtData = PlayerDataCenter.formationDic[fmtId]
    if fmtData == nil then
      fmtData = PlayerDataCenter:CreateFormation(fmtId)
      isCreateNew = true
    end
  end
  local isDead = false
  if isNeedReadFormForms and forms ~= nil then
    for teamUid, fInfo in pairs(forms) do
      local my_index = fInfo.teamUid & CommonUtil.UInt16Max
      if my_index == index then
        isDead = fInfo.teamState & eWarChessEnum.eWCTeamState.Die > 0
        fmtData = table.deepCopy(fmtData)
        local normalNum = ConfigData.formation_rule[0].stage_num
        local benchNum = ConfigData.formation_rule[0].bench_num
        local officialSupportHeroDic = {}
        fmtData:CleanFormation()
        for i = 1, normalNum + benchNum do
          local heroId = fInfo.heroForms[i]
          for _, officialSupportHeroId in ipairs(fInfo.assistHerosId) do
            if officialSupportHeroId == heroId then
              officialSupportHeroDic[i] = officialSupportHeroId
            end
          end
          fmtData:SetHero2Formation(i, heroId)
        end
        if WarChessSeasonManager:IsInWCS() then
          local wcsCtrl = WarChessSeasonManager:GetWCSCtrl()
          local officialSupportCfgId, warchessAssistCfg
          if wcsCtrl ~= nil then
            officialSupportCfgId = wcsCtrl:GetWCSOfficialSupportCfgId()
            warchessAssistCfg = ConfigData.official_assist[officialSupportCfgId]
          end
          if warchessAssistCfg ~= nil then
            for index, heroId in pairs(officialSupportHeroDic) do
              for paramIndex, paramheroId in ipairs(warchessAssistCfg.param1) do
                if paramheroId == heroId then
                  local assistCfgId = warchessAssistCfg.assist_lvs[paramIndex]
                  local power = warchessAssistCfg.effective[index]
                  local assisLvCfg = ConfigData.assist_level[assistCfgId]
                  local osHeroData = OfficialSupportHeroData.GenOfficialSupportHeroData(heroId, assisLvCfg, power)
                  osHeroData:SetOfficialSupportCfgId(officialSupportCfgId)
                  fmtData:SetOfficialSupportHeroData(osHeroData, index)
                end
              end
            end
          end
        end
        break
      end
    end
  end
  local dTeamData = WarChessDeployTeamData.New(index, fmtData)
  local power = fmtCtrl:CalculatePower(fmtData)
  dTeamData:SetDTeamTeamPower(power)
  dTeamData:SetDTeamIsFixedTeam(isFixedTeam)
  dTeamData:SetDTeamIsDead(isDead)
  return dTeamData, isCreateNew
end

function WarChessDeployState:RefreshAllDTeamData()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  for index, dTeamData in pairs(self.__deployTeamDic) do
    dTeamData:RefreshFmtData()
    if fmtCtrl ~= nil then
      local power = fmtCtrl:CalculatePower(dTeamData:GetWcDTeamFmtData())
      dTeamData:SetDTeamTeamPower(power)
    else
      error("fmtCtrl is nil")
    end
  end
end

function WarChessDeployState:GetDTeamDataByIndex(index)
  return self.__deployTeamDic[index]
end

function WarChessDeployState:GetTeamDataByIndex(index)
  return self.__dynDeployTeamDic[index]
end

function WarChessDeployState:CleanTeamDataByIndex(index)
  self.__dynDeployTeamDic[index] = nil
end

function WarChessDeployState:GetDTeamDataDic()
  return self.__deployTeamDic
end

function WarChessDeployState:__OnFingerDown(finger)
  if finger == nil or finger.StartedOverGui then
    return
  end
  local hits = CS_Physics.Raycast(self.__camMain, 1 << LayerMask.Character, true)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].transform
    if not IsNull(hitCollider) then
      local WCHeroEntity = self.wcCtrl.teamCtrl:GetDeployHeroEntityByGo(hitCollider.transform.parent.gameObject)
      if WCHeroEntity == nil then
        return
      end
      local teamIndex = WCHeroEntity:GetWCHeroEntityTeamIndex()
      self:BeginDrag2Deploy(teamIndex, true)
      return
    end
  end
end

function WarChessDeployState:__OnFingerUp(finger)
  if finger == nil or finger.StartedOverGui then
    return
  end
  if self.__curEntity ~= nil then
    local teamIndex = self.__curEntity:GetWCHeroEntityTeamIndex()
    self:FinishDrag2Deploy(teamIndex)
  end
end

function WarChessDeployState:__OnFingerSet(finger)
  if finger == nil or finger.StartedOverGui then
    return
  end
  if self.__curEntity ~= nil then
    local teamIndex = self.__curEntity:GetWCHeroEntityTeamIndex()
    self:OnDrag2Deploy(teamIndex)
  end
end

function WarChessDeployState:BeginDrag2Deploy(teamIndex, inStage)
  if self.__guideData ~= nil and self.__guideData.teamIndex ~= teamIndex then
    return
  end
  local dTeamData = self:GetDTeamDataByIndex(teamIndex)
  local firstHeroData = dTeamData:GetFirstHeroData()
  if firstHeroData == nil then
    return
  end
  self.__curEntity = self.wcCtrl.teamCtrl:GetWCDeployHeroEntity(teamIndex, dTeamData)
  self.__curEntity:WCAnimatorSetPickFloat(true)
  self.__beforeDragEntityRot = self.__curEntity:WCHeroEntityGetRotate()
  self.__curEntity:WCHeroEntitySetRotate(Vector3.New(-45, -180, 0))
  AudioManager:PlayAudioById(1229)
  MsgCenter:Broadcast(eMsgEventId.WC_DeployingTeam, true, inStage)
  self.wcCtrl.wcCamCtrl:SetIsCouldNormalMoveCamera(false)
end

function WarChessDeployState:OnDrag2Deploy()
  local pos = self.wcCtrl.inputCtrl:GetMouseCurentGroundPos()
  if pos ~= nil and self.__curEntity ~= nil then
    self.__curEntity:WCHeroEntitySetPos(pos)
  end
end

function WarChessDeployState:FinishDrag2Deploy(teamIndex, customPos)
  if self.__curEntity == nil then
    MsgCenter:Broadcast(eMsgEventId.WC_DeployingTeam, false)
    return
  end
  if self.__beforeDragEntityRot then
    self.__curEntity:WCHeroEntitySetRotate(self.__beforeDragEntityRot)
    self.__beforeDragEntityRot = nil
  end
  self.wcCtrl.wcCamCtrl:SetIsCouldNormalMoveCamera(true)
  self.__curEntity:WCAnimatorSetPickFloat(false)
  local dTeamData = self:GetDTeamDataByIndex(teamIndex)
  if self.wcCtrl.inputCtrl:GetIsOverSpecificGUI("QuitMode") then
    self.wcCtrl.teamCtrl:RecycleDeployHeroEntity(teamIndex)
    local lastBornGridData
    if dTeamData:GetIsDeploied() then
      local gridPos = dTeamData:GetBornPoint()
      lastBornGridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, gridPos)
      if lastBornGridData ~= nil then
        lastBornGridData.isHaveDTeamData = false
      end
      if self.__isDynDeploy then
        local index = dTeamData:GetDTeamIndex()
        self.__wantDynDeployNewDTeamDic[index] = nil
      end
    end
    dTeamData:SetBornPoint(nil)
    self.__curEntity = nil
    MsgCenter:Broadcast(eMsgEventId.WC_DeployTeamChange, lastBornGridData)
    MsgCenter:Broadcast(eMsgEventId.WC_DeployingTeam, false)
    return
  end
  local pos = customPos or self.wcCtrl.inputCtrl:GetMouseCurentGroundPos()
  local gridData = self.wcCtrl.mapCtrl:GetGridDataByGrounPos(nil, pos)
  if gridData ~= nil then
    local entityData = self.wcCtrl.mapCtrl:GetEntityDataByLogicPos(nil, gridData:GetGridLogicPos())
  end
  if entityData == nil and gridData ~= nil and gridData:GetIsBornPoint() then
    local bornPointLogicPos = gridData:GetGridLogicPos()
    if self.__guideData ~= nil then
      if self.__guideData.x == bornPointLogicPos.x and self.__guideData.y == bornPointLogicPos.y then
        self.__guideData.complete = true
        goto lbl_132
      end
    else
      ::lbl_132::
      if self.__isDynDeploy then
        local couldBorn = true
        for index, teamData in pairs(self.__dynDeployTeamDic) do
          local teamLogicPos = teamData:GetWCTeamLogicPos()
          if teamLogicPos == bornPointLogicPos and not teamData:GetWCTeamIsDead() then
            couldBorn = false
            break
          end
        end
        local isExchange = false
        for index, otherDTeamData in pairs(self.__wantDynDeployNewDTeamDic) do
          if otherDTeamData ~= dTeamData then
            local otherBornPoint = otherDTeamData:GetBornPoint()
            if otherBornPoint == bornPointLogicPos then
              local curBornPoint = dTeamData:GetBornPoint()
              if curBornPoint == nil then
                self.wcCtrl.teamCtrl:RecycleDeployHeroEntity(index)
                otherDTeamData:SetBornPoint(nil)
                self.__wantDynDeployNewDTeamDic[index] = nil
                isExchange = true
                break
              end
              do
                local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, curBornPoint)
                local otherEntity = self.wcCtrl.teamCtrl:GetWCDeployHeroEntity(index, otherDTeamData)
                otherEntity:WCHeroEntitySetPos(gridData:GetGridShowPos())
                otherDTeamData:SetBornPoint(curBornPoint)
                isExchange = true
              end
              break
            end
          end
        end
        if not isExchange then
          local lastBornGridData
          if dTeamData:GetIsDeploied() then
            local gridPos = dTeamData:GetBornPoint()
            lastBornGridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, gridPos)
            if lastBornGridData ~= nil then
              lastBornGridData.isHaveDTeamData = false
              MsgCenter:Broadcast(eMsgEventId.WC_DeployTeamChange, lastBornGridData)
            end
          end
          local dpItemId = ConstGlobalItem.WCDeployPoint
          local deployNum = self.wcCtrl.backPackCtrl:GetWCItemNum(dpItemId)
          for clientIndex, otherDTeamData in pairs(self.__wantDynDeployNewDTeamDic) do
            if otherDTeamData ~= dTeamData then
              local bornPoint = otherDTeamData:GetBornPoint()
              local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, bornPoint)
              local coustNum = gridData:GetGridUseItemConsume(eWCInteractType.born, dpItemId)
              deployNum = deployNum - (coustNum or 0)
            end
          end
          if couldBorn and (not gridData:GetCouldInteract(eWCInteractType.born) or deployNum < gridData:GetGridUseItemConsume(eWCInteractType.born, dpItemId)) then
            couldBorn = false
            CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.WarChess_CanNotDeploy))
          end
        end
        if couldBorn then
          AudioManager:PlayAudioById(1230)
          local clientIndex = dTeamData:GetDTeamIndex()
          self.__wantDynDeployNewDTeamDic[clientIndex] = dTeamData
          self.__curEntity:WCHeroEntitySetPos(gridData:GetGridShowPos())
          gridData.isHaveDTeamData = true
          dTeamData:SetBornPoint(bornPointLogicPos)
          self.__curEntity = nil
          MsgCenter:Broadcast(eMsgEventId.WC_DeployTeamChange, gridData)
          MsgCenter:Broadcast(eMsgEventId.WC_DeployingTeam, false)
          return
        end
      else
        local isExchange = false
        for index, otherDTeamData in pairs(self.__deployTeamDic) do
          if otherDTeamData ~= dTeamData then
            local otherBornPoint = otherDTeamData:GetBornPoint()
            if otherBornPoint == bornPointLogicPos then
              local curBornPoint = dTeamData:GetBornPoint()
              if curBornPoint == nil then
                self.wcCtrl.teamCtrl:RecycleDeployHeroEntity(index)
                otherDTeamData:SetBornPoint(nil)
                isExchange = true
                break
              end
              do
                local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, curBornPoint)
                local otherEntity = self.wcCtrl.teamCtrl:GetWCDeployHeroEntity(index, otherDTeamData)
                otherEntity:WCHeroEntitySetPos(gridData:GetGridShowPos())
                otherDTeamData:SetBornPoint(curBornPoint)
                isExchange = true
              end
              break
            end
          end
        end
        if not isExchange then
          local lastBornGridData
          if dTeamData:GetIsDeploied() then
            local gridPos = dTeamData:GetBornPoint()
            lastBornGridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, gridPos)
            if lastBornGridData ~= nil then
              lastBornGridData.isHaveDTeamData = false
              MsgCenter:Broadcast(eMsgEventId.WC_DeployTeamChange, lastBornGridData)
            end
          end
        end
        self.__curEntity:WCHeroEntitySetPos(gridData:GetGridShowPos())
        gridData.isHaveDTeamData = true
        AudioManager:PlayAudioById(1230)
        dTeamData:SetBornPoint(bornPointLogicPos)
        self.__curEntity = nil
        MsgCenter:Broadcast(eMsgEventId.WC_DeployTeamChange, gridData)
        MsgCenter:Broadcast(eMsgEventId.WC_DeployingTeam, false)
        return
      end
    end
  end
  local curBornPoint = dTeamData:GetBornPoint()
  if curBornPoint == nil then
    self.wcCtrl.teamCtrl:RecycleDeployHeroEntity(teamIndex)
  else
    local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, curBornPoint)
    self.__curEntity:WCHeroEntitySetPos(gridData:GetGridShowPos())
  end
  self.__curEntity = nil
  MsgCenter:Broadcast(eMsgEventId.WC_DeployingTeam, false)
  return
end

function WarChessDeployState:WCStartPlay()
  local onBoardTeamNum = 0
  for _, dTeamData in pairs(self.__deployTeamDic) do
    if dTeamData:GetIsDeploied() then
      onBoardTeamNum = onBoardTeamNum + 1
    end
  end
  local minTeamNum = WarChessManager:GetWCLevelCfg().min_team or 1
  if onBoardTeamNum == 0 or onBoardTeamNum < minTeamNum then
    local str = string.format(ConfigData:GetTipContent(TipContent.WarChess_TeamNumLessThen), tostring(minTeamNum))
    CS.MessageCommon.ShowMessageTips(str)
    return
  end
  local maxFmtNum = self.wcCtrl.teamCtrl:GetWCFmtNum()
  if onBoardTeamNum > maxFmtNum then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8527))
    return
  end
  local wcLevelCfg = WarChessManager:GetWCLevelCfg()
  if wcLevelCfg ~= nil and onBoardTeamNum < wcLevelCfg.recomme_team then
    CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(8524), function()
      self:__StartPlayInternal()
    end, nil)
  else
    self:__StartPlayInternal()
  end
end

function WarChessDeployState:__StartPlayInternal()
  self.wcCtrl:ChangeWarChessState(eWarChessEnum.eWarChessState.play)
  if not self.__isDynDeploy then
    for _, dTeamData in pairs(self.__deployTeamDic) do
      if dTeamData:GetIsDeploied() then
        local gridPos = dTeamData:GetBornPoint()
        local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, gridPos)
        if gridData ~= nil then
          gridData.isHaveDTeamData = false
        end
      end
    end
    self.wcCtrl.teamCtrl:InitTeams(self.__deployTeamDic, function()
      self.wcCtrl.teamCtrl:DeleteAllDeployHeroEntity()
      self.wcCtrl.teamCtrl:CheckAllTeamFairyEntity()
    end)
  end
  AudioManager:PlayAudioById(1231)
end

function WarChessDeployState:ApplyDynDeploy()
  local waitOnBardNum = table.count(self.__wantDynDeployNewDTeamDic)
  local maxFmtNum = self.wcCtrl.teamCtrl:GetWCFmtNum()
  local curOnbardTeamNum = self.wcCtrl.teamCtrl:GetWCFmtCurNum()
  local deadIndexList, freeIndexList = self.wcCtrl.teamCtrl:GetDynDeployCouldUseIndex()
  if waitOnBardNum <= 0 then
    return
  end
  if maxFmtNum < waitOnBardNum + curOnbardTeamNum then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8527))
    return
  end
  if 0 < #deadIndexList then
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessInheritChip, function(win)
      if win ~= nil then
        win:InitSelectCouldInheritChip(self.__wantDynDeployNewDTeamDic, deadIndexList, function()
          for _, dTeamData in pairs(self.__wantDynDeployNewDTeamDic) do
            if dTeamData:GetInheritTeamIndex() == nil then
              local index = table.remove(freeIndexList, 1)
              dTeamData:SetInheritTeamIndex(index)
            end
          end
          self.wcCtrl.teamCtrl:WCDynDeployTeams(self.__wantDynDeployNewDTeamDic, function()
            self.wcCtrl:ChangeWarChessState(eWarChessEnum.eWarChessState.play)
            self.wcCtrl.teamCtrl:DeleteAllDeployHeroEntity()
          end)
        end)
      end
    end)
  else
    for _, dTeamData in pairs(self.__wantDynDeployNewDTeamDic) do
      local index = table.remove(freeIndexList, 1)
      dTeamData:SetInheritTeamIndex(index)
      self.wcCtrl.teamCtrl:WCDynDeployTeams(self.__wantDynDeployNewDTeamDic, function()
        self.wcCtrl:ChangeWarChessState(eWarChessEnum.eWarChessState.play)
        self.wcCtrl.teamCtrl:DeleteAllDeployHeroEntity()
      end)
    end
  end
end

function WarChessDeployState:ExitDynDeploy()
  for clientIndex, dTeamData in pairs(self.__wantDynDeployNewDTeamDic) do
    local gridPos = dTeamData:GetBornPoint()
    local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, gridPos)
    if gridData ~= nil then
      gridData.isHaveDTeamData = false
      MsgCenter:Broadcast(eMsgEventId.WC_DeployTeamChange, gridData)
    end
  end
  self.wcCtrl.teamCtrl:DeleteAllDeployHeroEntity()
  self.wcCtrl:ChangeWarChessState(eWarChessEnum.eWarChessState.play)
end

function WarChessDeployState:SetWCDeployGuide(teamIndex, x, y)
  self.__guideData = {
    teamIndex = teamIndex,
    x = x,
    y = y,
    complete = false
  }
end

function WarChessDeployState:IsWCDeployGuideComplete()
  if self.__guideData == nil then
    return true
  end
  return self.__guideData.complete
end

function WarChessDeployState:ClearWCDeployGuideData()
  self.__guideData = nil
end

function WarChessDeployState:WCAutoDeploy()
  local waitDeployIndexList = {}
  for index, dTeamData in ipairs(self.__deployTeamDic) do
    table.insert(waitDeployIndexList, index)
  end
  if #waitDeployIndexList <= 0 then
    return
  end
  local bornGridDic = self.wcCtrl.mapCtrl:GetAllCouldBornGrid()
  if bornGridDic ~= nil then
    for gridData, _ in pairs(bornGridDic) do
      if not gridData.isHaveDTeamData then
        local index = table.remove(waitDeployIndexList, 1)
        local showPos = gridData:GetGridShowPos()
        self:BeginDrag2Deploy(index)
        self:FinishDrag2Deploy(index, showPos)
        if #waitDeployIndexList <= 0 then
          return
        end
      end
    end
  end
end

function WarChessDeployState:OnExitState()
  ControllerManager:DeleteController(ControllerTypeId.Formation)
  if self.__waitPlayGuideCoroutine ~= nil then
    GR.StopCoroutine(self.__waitPlayGuideCoroutine)
    self.__waitPlayGuideCoroutine = nil
  end
  CS_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  CS_LeanTouch.OnFingerUp("-", self.__onFingerUp)
  CS_LeanTouch.OnFingerSet("-", self.__onFingerSet)
end

return WarChessDeployState
