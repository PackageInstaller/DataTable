local base = require("Game.WarChess.Ctrl.Base.WarChessCtrlBase")
local WarChessTeamCtrl = class("WarChessTeamCtrl", base)
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local WCHeroEntity = require("Game.WarChess.Entity.WCHeroEntity")
local WarChessTeamData = require("Game.WarChess.Data.WarChessTeamData")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local DynHero = require("Game.Exploration.Data.DynHero")
local eWCInteractType = require("Game.WarChess.Interact.Base.eWCInteractType")
local EpMvpData = require("Game.Exploration.Data.EpMvpData")
local DeployTeamUtil = require("Game.Exploration.Util.DeployTeamUtil")
local FormationUtil = require("Game.Formation.FormationUtil")
local FmtEnum = require("Game.Formation.FmtEnum")
local util = require("XLua.Common.xlua_util")
local CS_BattleManager = CS.BattleManager.Instance
local TEAM_MOVE_SPEED_PER_SECOND = 6
local MAX_MOVE_COST_TIME = 1.5
local ACC_TIME = 0.3
local ROTATE_COST_TIME = 0.1
local FAIRY_MOVE_DELAY_TIME = 0.1

function WarChessTeamCtrl:ctor(wcCtrl)
  self.__fmtMaxNum = 3
  self.__ServerTeamInfoDic = nil
  self.__WCDeployHeroEntityDic = {}
  self.__WCHeroEntityDic = {}
  self.__TeamDic = {}
  self.__DeadTeamDic = {}
  self.__AllUsedHeroDic = {}
  self.__bornSuccess = false
  self.__bornOverCallback = nil
  self.__epMvpData = nil
  self.__startAniOk = false
  self.__startPlayCall = {}
  self.startPlayAnimaPlaying = false
  self.__onUpdateTeamStateCallback = {}
end

function WarChessTeamCtrl:OnSceneLoadOver()
  if self.__allLoadOverFunc ~= nil then
    for _, func in pairs(self.__allLoadOverFunc) do
      if func ~= nil then
        func()
      end
    end
    self.__allLoadOverFunc = nil
  end
end

function WarChessTeamCtrl:InitByMsg(forms, isReconnect)
  for teamIndex, teamData in pairs(self.__TeamDic) do
    self:DeleteHeroEntity(teamIndex)
  end
  self.__TeamDic = {}
  self.__DeadTeamDic = {}
  self.__WCHeroEntityDic = {}
  if isReconnect then
    local BattlePlayerDiff = {}
    for _, fInfo in pairs(forms) do
      local isDead = fInfo.teamState & eWarChessEnum.eWCTeamState.Die > 0
      local isGhost = 0 < fInfo.teamState & eWarChessEnum.eWCTeamState.Ghost
      if isDead or not (0 < fInfo.teamState & (eWarChessEnum.eWCTeamState.WaitDeploy | eWarChessEnum.eWCTeamState.WaitForm)) then
        local index = fInfo.teamUid & CommonUtil.UInt16Max
        local fmtId = FormationUtil.GetFmtIdOffsetByFmtFromModule(FmtEnum.eFmtFromModule.WarChess) + index
        local fmtData = PlayerDataCenter.formationDic[fmtId]
        if fmtData == nil then
          fmtData = PlayerDataCenter:CreateFormation(fmtId)
        end
        local name = fmtData.name
        if string.IsNullOrEmpty(name) then
          name = string.format(ConfigData:GetTipContent(TipContent.WarChess_TeamDefaultName), tostring(index))
        end
        local data = {
          index = fInfo.teamUid & CommonUtil.UInt16Max,
          fInfo = fInfo,
          teamName = name
        }
        local teamData = WarChessTeamData.GetNewTeamDataByMsg(data, fmtData)
        if not isDead then
          self.__TeamDic[teamData:GetWCTeamIndex()] = teamData
          BattlePlayerDiff[fInfo.teamUid] = fInfo.player
          if isGhost then
            teamData:SetWCTeamIsGhost(true)
          end
        elseif isDead then
          self.__DeadTeamDic[teamData:GetWCTeamIndex()] = teamData
          teamData:SetWCTeamIsDead(true)
        else
          self.__TeamDic[teamData:GetWCTeamIndex()] = teamData
          BattlePlayerDiff[fInfo.teamUid] = fInfo.player
        end
      end
    end
    self:UpdateWCCommander(BattlePlayerDiff)
    self.__bornSuccess = true
    if self.__bornOverCallback ~= nil then
      self.__bornOverCallback()
    end
    self.__bornOverCallback = nil
  end
  self.__fmtMaxNum = table.count(forms)
  self.__ServerTeamInfoDic = {}
  for _, fInfo in pairs(forms) do
    local index = fInfo.teamUid & CommonUtil.UInt16Max
    self.__ServerTeamInfoDic[index] = fInfo
  end
end

function WarChessTeamCtrl:ReSetTeamStandGridData()
  for teamIndex, teamData in pairs(self.__TeamDic) do
    local logicPos = teamData:GetWCTeamLogicPos()
    if logicPos ~= nil then
      local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, logicPos)
      gridData:SetWCGridIsStandTeam(true)
    else
      error("team not has pos, index:" .. tostring(teamIndex))
    end
  end
end

function WarChessTeamCtrl:WCReaddAllChipData(forms)
  for _, fInfo in pairs(forms) do
    local index = fInfo.teamUid & CommonUtil.UInt16Max
    local teamData = self:GetTeamDataByTeamIndexIgnoreDead(index)
    if teamData ~= nil then
      teamData:UpdateTeamChipDiff(fInfo.alg)
    end
  end
end

function WarChessTeamCtrl:GetOneFInfo(index)
  return self.__ServerTeamInfoDic[index]
end

function WarChessTeamCtrl:GetWCFmtNum()
  return self.__fmtMaxNum
end

function WarChessTeamCtrl:GetWCFmtShowNum()
  local wcLevelCfg = WarChessManager:GetWCLevelCfg()
  return wcLevelCfg.edit_team or self.__fmtMaxNum
end

function WarChessTeamCtrl:GetWCFmtCurNum()
  return table.count(self:GetWCTeams())
end

function WarChessTeamCtrl:GetWCFmtCurDeadNum()
  return table.count(self.__DeadTeamDic)
end

function WarChessTeamCtrl:GetDynDeployCouldUseIndex()
  local deadIndexList = {}
  local freeIndexList = {}
  for teamIndex, teamData in pairs(self.__DeadTeamDic) do
    if #teamData:GetWCTeamChipList() > 0 then
      table.insert(deadIndexList, teamIndex)
    else
      table.insert(freeIndexList, teamIndex)
    end
  end
  local maxFmtNum = self:GetWCFmtNum()
  for index = 1, maxFmtNum do
    local teamData = self:GetTeamDataByTeamIndexIgnoreDead(index)
    if teamData == nil then
      table.insert(freeIndexList, index)
    end
  end
  return deadIndexList, freeIndexList
end

function WarChessTeamCtrl:GetWCTeams()
  return self.__TeamDic
end

function WarChessTeamCtrl:InitTeams(deployTeamDic, callback)
  if self._InitTeamCo ~= nil then
    GR.StopCoroutine(self._InitTeamCo)
  end
  local wid = self.wcCtrl:GetWCId()
  local gameStartInfo = {
    identify = {},
    formation = {},
    deploy = {}
  }
  local msg = {wid = wid, gameStartInfo = gameStartInfo}
  local fInfoIndex = 0
  for teamIndex, dTeamData in pairs(deployTeamDic) do
    local heroDic = dTeamData:GetDTeamHeroDic()
    local isOnGround = dTeamData:GetBornPoint() ~= nil
    if isOnGround and 0 < table.count(heroDic) and not dTeamData:GetDTeamIsDead() then
      if WarChessSeasonManager:GetIsInWCSeason() then
        fInfoIndex = teamIndex
      else
        fInfoIndex = fInfoIndex + 1
      end
      local fInfo = self:GetOneFInfo(fInfoIndex)
      local wid = self.wcCtrl:GetWCId()
      local fmtId = dTeamData:GetFmtId()
      local clientIndex = dTeamData:GetDTeamIndex()
      local power = dTeamData:GetDTeamTeamPower()
      local officeAssist = dTeamData:GetOfficeAssistData()
      local fairyUid = dTeamData:GetWCFairyUID()
      local identify = {
        wid = wid,
        tid = fInfo.teamUid
      }
      table.insert(gameStartInfo.identify, identify)
      local notNeedRefresh = WarChessSeasonManager:GetIsInWCSeasonNotFirstLevel()
      if not notNeedRefresh then
        local fmtMsg = {
          formInfo = {
            formationId = fmtId,
            support = nil,
            fairyUid = fairyUid
          },
          fromFormationIdx = clientIndex,
          powerNum = power,
          assist = officeAssist
        }
        table.insert(gameStartInfo.formation, fmtMsg)
      end
      local index = fInfo.teamUid & CommonUtil.UInt16Max
      self.__WCHeroEntityDic[index] = self.__WCDeployHeroEntityDic[teamIndex]
      self.__WCDeployHeroEntityDic[teamIndex] = nil
      local teamData = WarChessTeamData.GetNewTeamDataByDTeamData(fInfo, dTeamData)
      self.__TeamDic[teamData:GetWCTeamIndex()] = teamData
      local teamLogicPos = teamData:GetWCTeamLogicPos()
      if teamLogicPos == nil then
        error("born team not have a born grid")
      end
      local bornGridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, teamLogicPos)
      bornGridData:SetWCGridIsStandTeam(true)
      local interactCfg = bornGridData:GetFirstGridInertactWithCat(eWCInteractType.born)
      local deployData = {
        wcPos = {
          gid = bornGridData:GetWCGridBFId(),
          pos = WarChessHelper.Pos2Coordination(bornGridData:GetGridLogicPos())
        },
        entityCat = bornGridData:GetGridUnit().entityCat,
        interactionId = interactCfg.id
      }
      table.insert(gameStartInfo.deploy, deployData)
      MsgCenter:Broadcast(eMsgEventId.WC_TeamInfoUpdate, teamData)
    end
  end
  self.__startAniOk = false
  self.wcCtrl.palySquCtrl:SetWCStartPlayFunc(function()
    self.__startAniOk = true
    self:_StartPlayEventsInvoke(self)
    self.startPlayAnimaPlaying = false
  end)
  self._InitTeamCo = GR.StartCoroutine(util.cs_generator(BindCallback(self, self._CoOnInitTeamComplete, msg, callback)))
end

function WarChessTeamCtrl:_CoOnInitTeamComplete(msg, callback)
  local notInFirstLobyyStart = WarChessSeasonManager:GetIsInWCSeasonNotFirstLevel()
  if notInFirstLobyyStart then
    self:UpdateHeroDataByMsg({})
  end
  
  local function Exit()
    if self._InitTeamCo ~= nil then
      GR.StopCoroutine(self._InitTeamCo)
    end
    WarChessManager:ExitWarChess()
  end
  
  local starting = true
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_GameStart(msg, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      Exit()
      return
    end
    local isSuccess = args[0]
    if isSuccess then
      self.__bornSuccess = true
      self:InitWCMvpData()
      if self.__bornOverCallback ~= nil then
        self.__bornOverCallback()
      end
      if callback ~= nil then
        callback()
      end
      self.__bornOverCallback = nil
      starting = false
    else
      error("start wc error, exit Game")
      Exit()
      return
    end
  end)
  while starting do
    coroutine.yield(nil)
  end
  while not self.__startAniOk do
    coroutine.yield(nil)
  end
  WarChessSeasonManager:TryWcSsBuffSelect()
  self._InitTeamCo = nil
end

function WarChessTeamCtrl:_StartPlayEventsInvoke()
  local invokeSet = {}
  for i, func in ipairs(self.__startPlayCall) do
    table.insert(invokeSet, func)
  end
  for _, func in ipairs(invokeSet) do
    if func then
      func()
    end
  end
end

function WarChessTeamCtrl:StartPlayEventsAdd(callback)
  if callback then
    assert(type(callback) == "function", " callback 类型必须为 function")
    local hasFlag = false
    for i, func in ipairs(self.__startPlayCall) do
      if func == callback then
        hasFlag = true
        break
      end
    end
    if not hasFlag then
      table.insert(self.__startPlayCall, 1, callback)
    end
    return true
  end
  return false
end

function WarChessTeamCtrl:StartPlayEventsRemove(callback)
  local removeIdx
  for i, func in ipairs(self.__startPlayCall) do
    if func == callback then
      removeIdx = i
      break
    end
  end
  if removeIdx then
    table.remove(self.__startPlayCall, removeIdx)
    return true
  end
  return false
end

function WarChessTeamCtrl:WCDynDeployTeams(deployTeamDic, callback)
  local needUpdateTeamDatas = {}
  for _, dTeamData in pairs(deployTeamDic) do
    local heroDic = dTeamData:GetDTeamHeroDic()
    local isOnGround = dTeamData:GetBornPoint() ~= nil
    local teamData
    if isOnGround and table.count(heroDic) > 0 then
      local wid = self.wcCtrl:GetWCId()
      local fmtId = dTeamData:GetFmtId()
      local index = dTeamData:GetInheritTeamIndex()
      local teamIndex = dTeamData:GetDTeamIndex()
      local power = dTeamData:GetDTeamTeamPower()
      local officeAssist = dTeamData:GetOfficeAssistData()
      local fairyUid = dTeamData:GetWCFairyUID()
      local fInfo = self:GetOneFInfo(index)
      self.wcCtrl.wcNetworkCtrl:CS_WarChess_FreshFormation(wid, fInfo.teamUid, fmtId, teamIndex, power, officeAssist, fairyUid)
      local deadTeamData = self.__DeadTeamDic[index]
      teamData = WarChessTeamData.GetNewTeamDataByDTeamData(fInfo, dTeamData, deadTeamData)
      self.__WCHeroEntityDic[index] = self.__WCDeployHeroEntityDic[teamIndex]
      self.__WCDeployHeroEntityDic[teamIndex] = nil
      self.__TeamDic[index] = teamData
      self.__DeadTeamDic[index] = nil
      table.insert(needUpdateTeamDatas, teamData)
    end
  end
  for _, teamData in ipairs(needUpdateTeamDatas) do
    local teamLogicPos = teamData:GetWCTeamLogicPos()
    if teamLogicPos ~= nil then
      local bornGridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, teamLogicPos)
      bornGridData:SetWCGridIsStandTeam(true)
      local interactCfg = bornGridData:GetFirstGridInertactWithCat(eWCInteractType.born)
      MsgCenter:Broadcast(eMsgEventId.WC_TeamInfoUpdate, teamData)
      self.wcCtrl.interactCtrl:WCDealGridInteract(bornGridData, teamData, interactCfg, function(isSucess)
        if not isSucess then
          error("<color=red>warChess team born interact error</color>")
        else
          if isGameDev then
            print("队伍动态出生成功")
          end
          if callback ~= nil then
            callback()
          end
        end
      end)
    end
  end
end

function WarChessTeamCtrl:SetBornOverCallback(callback)
  if self.__bornSuccess then
    callback()
    return
  end
  self.__bornOverCallback = callback
end

function WarChessTeamCtrl:UpdateHeroDataByMsg(BattleRoleDic)
  if self.__AllHerosSTCDatas == nil then
    self.__AllHerosSTCDatas = {}
  end
  for heroId, battleRole in pairs(BattleRoleDic) do
    local stc = battleRole.stc
    local dyc = battleRole.dyc
    local roleType = dyc.roleType
    self.__AllHerosSTCDatas[stc.dataId] = stc
    local heroCfg = ConfigData.hero_data[stc.dataId]
    local heroData = HeroData.New({
      basic = {
        id = stc.dataId,
        level = stc.level,
        exp = 0,
        star = stc.rank,
        potentialLvl = stc.potential,
        ts = -1,
        career = heroCfg.career,
        company = heroCfg.camp,
        skinId = stc.skinId,
        cat = stc.cat,
        containSpecialModelSign = dyc.containSpecialModelSign
      },
      spWeapon = stc.specWeapon,
      vow = {
        vowTime = stc.vowed and 1 or 0,
        name = stc.name
      }
    })
    for k, v in pairs(stc.skillGroup) do
      if heroData.skillDic[k] ~= nil then
        heroData.skillDic[k]:UpdateSkill(v)
      end
    end
    local dynHeroData = DynHero.New(heroData, stc.uid, roleType)
    dynHeroData:SetCoord(dyc.coordination, ConfigData.buildinConfig.BenchX)
    dynHeroData:SetDynHeroFmtIdx(dyc.formationIdx)
    dynHeroData:UpdateHpPer(dyc.hpPer)
    dynHeroData:UpdateBaseHeroData(stc.attr, stc.skillGroup, stc.athSkillGroup, stc.additionSkillGroup, stc.rawAttr)
    dynHeroData:SetDynHeroTalentLevel(stc.talent)
    dynHeroData:SetExtraFixedPower(stc.talentEfficiency)
    self.__AllUsedHeroDic[heroId] = dynHeroData
  end
  for teamIndex, teamData in pairs(self.__TeamDic) do
    local wcDynPlayer = teamData:GetTeamDynPlayer()
    local upDateChipFunc = wcDynPlayer:WCRefillTeamDynHeros(teamData, self.__AllUsedHeroDic)
    wcDynPlayer:UpdateHeroAttr(self.__AllHerosSTCDatas)
    if upDateChipFunc ~= nil then
      upDateChipFunc()
    end
    teamData:RefreshWCTeamPower()
    teamData:GenWCTeamHP()
    if teamData:GetSetInitialDeploy() then
      local size_row, size_col, deploy_rows = WarChessManager:GetEpSceneBattleFieldSize()
      DeployTeamUtil.DeployHeroTeam(wcDynPlayer.heroList, size_row, size_col, deploy_rows)
    end
  end
  for teamIndex, teamData in pairs(self.__DeadTeamDic) do
    local wcDynPlayer = teamData:GetTeamDynPlayer()
    local upDateChipFunc = wcDynPlayer:WCRefillTeamDynHeros(teamData, self.__AllUsedHeroDic)
    wcDynPlayer:UpdateHeroAttr(self.__AllHerosSTCDatas)
    if upDateChipFunc ~= nil then
      upDateChipFunc()
    end
  end
  MsgCenter:Broadcast(eMsgEventId.WC_TeamHeroSTCUpdate)
  MsgCenter:Broadcast(eMsgEventId.WC_HeroDynUpdate)
end

function WarChessTeamCtrl:UpdateHeroDynDataByMsg(rolesDynDiff)
  for heroId, dyc in pairs(rolesDynDiff.update) do
    if self.__AllUsedHeroDic[heroId] == nil then
      error("UpdateHeroDynDataByMsg:hero not exit heroId:" .. tostring(heroId))
    else
      local dynHeroData = self.__AllUsedHeroDic[heroId]
      dynHeroData:SetCoord(dyc.coordination, ConfigData.buildinConfig.BenchX)
      dynHeroData:UpdateHpPer(dyc.hpPer)
      dynHeroData:SetDynHeroFmtIdx(dyc.formationIdx)
    end
  end
  local hpIsAdd = false
  for teamIndex, teamData in pairs(self.__TeamDic) do
    local preTeamHp = teamData:GetWCTeamHP()
    teamData:GenWCTeamHP()
    if preTeamHp < teamData:GetWCTeamHP() then
      hpIsAdd = true
    end
  end
  if hpIsAdd then
    AudioManager:PlayAudioById(1238)
  end
  if CS_BattleManager.IsInBattle then
    CS_BattleManager:UpdateBattleRoleData()
    local csBattlePlayCtrl = CS_BattleManager:GetBattlePlayerController()
    if csBattlePlayCtrl ~= nil and csBattlePlayCtrl.UltSkillHandle ~= nil then
      local battleRoleList = CS_BattleManager.CurBattleController.PlayerTeamController.battleOriginRoleList
      for i = 0, battleRoleList.Count - 1 do
        local role = battleRoleList[i]
        csBattlePlayCtrl.UltSkillHandle:RefreshSideHeadHpRate(role)
      end
      csBattlePlayCtrl.UltSkillHandle:RefreshSideHeadHpUI()
    end
  end
  MsgCenter:Broadcast(eMsgEventId.WC_HeroDynUpdate)
end

function WarChessTeamCtrl:UpdateWCTeamByHeroFormDiff(formDiffDic)
  local needRefreshLeadTeamList
  for tid, formDiff in pairs(formDiffDic) do
    local teamData = self:GetTeamDataByTeamUid(tid)
    if teamData ~= nil then
      local isNeedRefreshLeader = teamData:UpdateWCTeamFormDiff(formDiff)
      if isNeedRefreshLeader then
        needRefreshLeadTeamList = needRefreshLeadTeamList or {}
        table.insert(needRefreshLeadTeamList, teamData)
      end
    else
      error("want to update not exist team formDiff tid(teamUID):" .. tostring(tid))
    end
  end
  return needRefreshLeadTeamList
end

function WarChessTeamCtrl:RefreshWCTeamLeaderInList(needRefreshLeadTeamList)
  for _, teamData in ipairs(needRefreshLeadTeamList) do
    local teamIndex = teamData:GetWCTeamIndex()
    local heroEntity = self:GetWCHeroEntity(teamIndex)
    if heroEntity ~= nil then
      heroEntity:Delete()
    end
    local firstHeroId = teamData:GetFirstHeroId()
    local logicPos = teamData:GetWCTeamLogicPos()
    local dynHeroData = self:GetHeroDynDataById(firstHeroId)
    self:LoadWCHeroEntity(teamIndex, dynHeroData, logicPos, true)
  end
  MsgCenter:Broadcast(eMsgEventId.WC_TeamLeaderChange)
end

function WarChessTeamCtrl:UpdateWCCommander(battlePlayerDiff)
  for teamUid, battlePlayerDiff in pairs(battlePlayerDiff) do
    local teamData = self:GetTeamDataByTeamUid(teamUid)
    if teamData == nil then
      error("teamData is alreay not exist teamUid:" .. tostring(teamUid))
    else
      local dynPlyer = teamData:GetTeamDynPlayer()
      if battlePlayerDiff.stc ~= nil then
        dynPlyer:InitDynPlayerAttr(battlePlayerDiff.stc)
        dynPlyer:InitPlayerSkill(battlePlayerDiff.stc)
      end
      dynPlyer:UpdatePlayerDyc(battlePlayerDiff.dyc)
    end
  end
end

function WarChessTeamCtrl:UpdateTeamExtraData(formExtraDiffMsg)
  for _, formExtraDiff in pairs(formExtraDiffMsg) do
    local tid = formExtraDiff.tid
    local teamData = self:GetTeamDataByTeamUid(tid)
    if teamData ~= nil then
      local fairyUpdate = formExtraDiff.fairyUpdate
      teamData:UpdateWCDynHeroFairData(fairyUpdate)
    end
  end
end

function WarChessTeamCtrl:GetWCTeamIdentify(teamData)
  local wid = self.wcCtrl:GetWCId()
  local tid = teamData:GetWCTeamId()
  return wid, tid
end

function WarChessTeamCtrl:ReloadAllTeam(isNeedClean)
  if isNeedClean then
    for teamIndex, heroEntity in pairs(self.__WCHeroEntityDic) do
      heroEntity:Delete()
    end
  end
  self.__WCHeroEntityDic = {}
  local allAsyncWaitList = {}
  self.__allLoadOverFunc = {}
  for teamIndex, teamData in pairs(self.__TeamDic) do
    local firstHeroId = teamData:GetFirstHeroId()
    local logicPos = teamData:GetWCTeamLogicPos()
    local dynHeroData = self:GetHeroDynDataById(firstHeroId)
    local asyncWaitList, loadOverFuncList = self:LoadWCHeroEntity(teamIndex, dynHeroData, logicPos, false)
    table.insertto(allAsyncWaitList, asyncWaitList)
    table.insertto(self.__allLoadOverFunc, loadOverFuncList)
  end
  return allAsyncWaitList
end

function WarChessTeamCtrl:GetHeroDynDataById(heroId)
  return self.__AllUsedHeroDic[heroId]
end

function WarChessTeamCtrl:WCUpdateTeamState(teamStateMask)
  for tid, state in pairs(teamStateMask) do
    local teamData = self:GetTeamDataByTeamUid(tid)
    if teamData ~= nil then
      local normal = state == 0
      local isDead = 0 < state & eWarChessEnum.eWCTeamState.Die
      local isGhost = 0 < state & eWarChessEnum.eWCTeamState.Ghost
      if normal then
        self:__DealTeamState(teamData, eWarChessEnum.eWCTeamState.TeamStateNone)
      elseif isGhost then
        self:__DealTeamState(teamData, eWarChessEnum.eWCTeamState.Ghost)
      elseif isDead then
        self:__DealTeamState(teamData, eWarChessEnum.eWCTeamState.Die)
      end
      MsgCenter:Broadcast(eMsgEventId.WC_TeamInfoUpdate, teamData)
      MsgCenter:Broadcast(eMsgEventId.WC_TeamStateUpdate, teamData)
    end
  end
end

function WarChessTeamCtrl:__DealTeamState(teamData, state)
  local teamIndex = teamData:GetWCTeamIndex()
  if state == eWarChessEnum.eWCTeamState.TeamStateNone then
    local isGhost = teamData:GetWCTeamIsGhost()
    if isGhost then
      teamData:SetWCTeamIsGhost(false)
      teamData:RefreshWCTeamPower()
      local heroEntity = self:GetWCHeroEntity(teamIndex, nil)
      if heroEntity ~= nil then
        heroEntity:SetWCHeroIsGhost(false)
      end
    end
  elseif state == eWarChessEnum.eWCTeamState.Ghost then
    teamData:SetWCTeamIsGhost(true)
    local heroEntity = self:GetWCHeroEntity(teamIndex, nil)
    if heroEntity ~= nil then
      heroEntity:SetWCHeroIsGhost(true)
    end
  elseif state == eWarChessEnum.eWCTeamState.Die then
    local teamIndex = teamData:GetWCTeamIndex()
    teamData:SetWCTeamIsDead(true)
    self.__DeadTeamDic[teamIndex] = teamData
    self.__TeamDic[teamIndex] = nil
    local logicPos = teamData:GetWCTeamLogicPos()
    local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, logicPos)
    gridData:SetWCGridIsStandTeam(false)
    local heroEntity = self:GetWCHeroEntity(teamIndex)
    if heroEntity ~= nil then
      heroEntity:WCAnimatorSetTrigger("WarChess_Dead")
    end
    TimerManager:StartTimer(2, function()
      self:DeleteHeroEntity(teamIndex)
      MsgCenter:Broadcast(eMsgEventId.WC_TeamInfoUpdate, teamData)
      MsgCenter:Broadcast(eMsgEventId.WC_TeamStateUpdate, teamData)
    end, nil, true)
  end
end

function WarChessTeamCtrl:DealBattleFailTeam(teamData)
  local isGhost = teamData:GetWCTeamIsGhost()
  if not isGhost then
    self:__DealTeamState(teamData, eWarChessEnum.eWCTeamState.Ghost)
    return
  end
  self:__DealTeamState(teamData, eWarChessEnum.eWCTeamState.Die)
end

function WarChessTeamCtrl:LoadWCHeroEntity(teamIndex, firstHeroData, creatLogicPos, notWait)
  local heroEntityRoot
  if notWait then
    heroEntityRoot = self.wcCtrl.bind.trans_heroRoot
  end
  local heroEntity = WCHeroEntity.New(firstHeroData, teamIndex)
  local teamData = self:GetTeamDataByTeamIndex(teamIndex)
  local fairyData = teamData:GetWCTeamFairyData()
  heroEntity:SetWCHeroTeamFairyData(fairyData)
  self.__WCHeroEntityDic[teamIndex] = heroEntity
  return heroEntity:WCLoadHeroModel(creatLogicPos, notWait, heroEntityRoot, teamData)
end

function WarChessTeamCtrl:GetWCHeroEntity(teamIndex, firstHeroData)
  local heroEntity = self.__WCHeroEntityDic[teamIndex]
  if heroEntity ~= nil then
    heroEntity:Show()
  else
    if firstHeroData == nil then
      return nil
    end
    self:LoadWCHeroEntity(teamIndex, firstHeroData, nil, true)
    heroEntity = self.__WCHeroEntityDic[teamIndex]
  end
  return heroEntity
end

function WarChessTeamCtrl:DeleteHeroEntity(teamIndex)
  local heroEntity = self.__WCHeroEntityDic[teamIndex]
  if heroEntity ~= nil then
    heroEntity:Delete()
  end
  self.__WCHeroEntityDic[teamIndex] = nil
end

function WarChessTeamCtrl:LoadWCDeployHeroEntity(teamIndex, dTeamData, creatLogicPos, notWait)
  local firstHeroData = dTeamData:GetFirstHeroData()
  local fairyData = dTeamData:GetFmtFairyData()
  local heroEntityRoot
  if notWait then
    heroEntityRoot = self.wcCtrl.bind.trans_heroRoot
  end
  local heroEntity = WCHeroEntity.New(firstHeroData, teamIndex)
  heroEntity:SetWCHeroTeamFairyData(fairyData)
  self.__WCDeployHeroEntityDic[teamIndex] = heroEntity
  return heroEntity:WCLoadHeroModel(creatLogicPos, notWait, heroEntityRoot)
end

function WarChessTeamCtrl:GetWCDeployHeroEntity(teamIndex, dTeamData)
  local heroEntityRoot = self.wcCtrl.bind.trans_heroRoot
  local heroEntity = self.__WCDeployHeroEntityDic[teamIndex]
  local firstHeroData = dTeamData:GetFirstHeroData()
  local fairyData = dTeamData:GetFmtFairyData()
  if heroEntity ~= nil then
    heroEntity:SetWCHeroTeamFairyData(fairyData)
    heroEntity:CheckFirstHeroModel(firstHeroData, true, heroEntityRoot)
    heroEntity:Show()
  else
    self:LoadWCDeployHeroEntity(teamIndex, dTeamData, nil, true)
    heroEntity = self.__WCDeployHeroEntityDic[teamIndex]
  end
  return heroEntity
end

function WarChessTeamCtrl:RefreshDeployHeroEntity(firstHeroData, teamIndex, fairyData)
  local heroEntityRoot = self.wcCtrl.bind.trans_heroRoot
  local heroEntity = self.__WCDeployHeroEntityDic[teamIndex]
  if heroEntity ~= nil and firstHeroData ~= nil then
    heroEntity:SetWCHeroTeamFairyData(fairyData)
    heroEntity:CheckFirstHeroModel(firstHeroData, true, heroEntityRoot)
  end
end

function WarChessTeamCtrl:RecycleDeployHeroEntity(teamIndex)
  local heroEntity = self.__WCDeployHeroEntityDic[teamIndex]
  if heroEntity ~= nil then
    heroEntity:Hide()
  end
end

function WarChessTeamCtrl:DeleteAllDeployHeroEntity()
  for _, heroEntity in pairs(self.__WCDeployHeroEntityDic) do
    if heroEntity ~= nil then
      heroEntity:Delete()
    end
  end
  self.__WCDeployHeroEntityDic = {}
end

function WarChessTeamCtrl:CheckAllTeamFairyEntity()
  for teamIndex, heroEntity in pairs(self.__WCHeroEntityDic) do
    local teamData = self:GetTeamDataByTeamIndex(teamIndex)
    local fairyData = teamData:GetWCTeamFairyData()
    heroEntity:ForceUpdateFairyData(fairyData)
  end
end

function WarChessTeamCtrl:GetDeployHeroEntityByGo(heroEntityGo)
  for teamIndex, heroEntity in pairs(self.__WCDeployHeroEntityDic) do
    if heroEntity:GetWCHeroEntityGo() == heroEntityGo then
      return heroEntity
    end
  end
end

function WarChessTeamCtrl:GetTeamDataByGo(heroEntityGo)
  for teamIndex, heroEntity in pairs(self.__WCHeroEntityDic) do
    if heroEntity:GetWCHeroEntityGo() == heroEntityGo and heroEntity ~= nil then
      local teamIndex = heroEntity:GetWCHeroEntityTeamIndex()
      local teamData = self:GetTeamDataByTeamIndex(teamIndex)
      return teamData
    end
  end
end

function WarChessTeamCtrl:GetTeamDataByTeamUid(teamUid)
  for teamIndex, WCTeamData in pairs(self.__TeamDic) do
    if WCTeamData:GetWCTeamId() == teamUid then
      return WCTeamData
    end
  end
end

function WarChessTeamCtrl:GetFirstAliveTeamPosV2()
  for i = 1, self.__fmtMaxNum do
    local teamData = self.__TeamDic[i]
    if teamData ~= nil then
      return teamData:GetWCTeamLogicPos()
    end
  end
  return nil
end

function WarChessTeamCtrl:GetTeamDataByTeamIndex(teamIndex)
  return self.__TeamDic[teamIndex]
end

function WarChessTeamCtrl:GetDeadTeamDataByTeamIndex(teamIndex)
  return self.__DeadTeamDic[teamIndex]
end

function WarChessTeamCtrl:GetTeamDataByTeamIndexIgnoreDead(teamIndex)
  local teamData = self:GetTeamDataByTeamIndex(teamIndex)
  if teamData == nil then
    teamData = self:GetDeadTeamDataByTeamIndex(teamIndex)
  end
  return teamData
end

function WarChessTeamCtrl:GetTeamDataByLogicPos(logicPos)
  for teamIndex, WCTeamData in pairs(self.__TeamDic) do
    if WCTeamData:GetWCTeamLogicPos() == logicPos then
      return WCTeamData
    end
  end
end

function WarChessTeamCtrl:GetDynHeroDicByTeamData(teamData)
  local dynHeroDic = {}
  local heroIdDic = teamData:GetWCTeamOrderDic()
  for index, heroId in pairs(heroIdDic) do
    local dynHero = self:GetHeroDynDataById(heroId)
    dynHeroDic[heroId] = dynHero
  end
  return dynHeroDic
end

function WarChessTeamCtrl:SetTeamFace2Grid(teamIndex, gridData)
  local teamData = self:GetTeamDataByTeamIndex(teamIndex)
  local heroEntity = self:GetWCHeroEntity(teamIndex, nil, nil)
  local targeShowPos = gridData:GetGridShowPos()
  local entityCurPos = heroEntity:WCHeroEntityGetShowPos()
  local moveToward = Vector3.Normalize(targeShowPos - entityCurPos)
  local targetRotate
  local rotatePassedTime = 0
  local curRotate
  if Vector3.Normalize(heroEntity:WCHeroEntityGetForward()) ~= moveToward then
    local newRotate = Quaternion.LookRotation(moveToward, Vector3.up)
    if newRotate == nil then
      return false
    end
    targetRotate = newRotate
    rotatePassedTime = 0
    curRotate = heroEntity:WCHeroEntityGetRotate()
    heroEntity:WCAnimatorSetWalk(true)
  else
    return false
  end
  
  local function RotateEntity_Update()
    local deltaTime = Time.deltaTime
    rotatePassedTime = rotatePassedTime + deltaTime
    local rate = rotatePassedTime / ROTATE_COST_TIME
    local rotate = Quaternion.Slerp(curRotate, targetRotate, rate)
    heroEntity:WCHeroEntitySetRotate(rotate)
    if 1 <= rate then
      targetRotate = nil
      heroEntity:WCAnimatorSetWalk(false)
      return true
    end
    return false
  end
  
  return true, RotateEntity_Update
end

function WarChessTeamCtrl:CalAllTeamCouldMoveGridDic()
  for teamIndex, WCTeamData in pairs(self.__TeamDic) do
    self:CalTeamCouldMoveGridDic(WCTeamData)
  end
end

function WarChessTeamCtrl:CalTeamCouldMoveGridDic(teamData)
  local teamLogicPos = teamData:GetWCTeamLogicPos()
  local startGrid = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, teamLogicPos)
  if startGrid == nil then
    return
  end
  local couldReachGridDic, couldInetactDic, levelNubDic = WarChessHelper.BSFAllCouldReachGrid(self.wcCtrl.mapCtrl, startGrid, teamData)
  teamData:SetWCTeamMoveableGirdDic(couldReachGridDic)
  teamData:SetWCTeamLevelNubDic(levelNubDic)
  teamData:SetWCTeamInteractablePosDic(couldInetactDic)
  MsgCenter:Broadcast(eMsgEventId.WC_TeamCouldMoveGridChange, teamData)
end

function WarChessTeamCtrl:MoveWCTeam2Grid(teamIndex, gridData)
  local teamData = self:GetTeamDataByTeamIndex(teamIndex)
  local heroEntity = self:GetWCHeroEntity(teamIndex, nil, nil)
  if teamData == nil or heroEntity == nil or gridData == nil then
    return
  end
  if not gridData:GetCouldStand() then
    return
  end
  local logicPos = gridData:GetGridLogicPos()
  local targetGridTeamData = self:GetTeamDataByLogicPos(logicPos)
  if targetGridTeamData ~= nil then
    CS.MessageCommon.ShowMessageTips("格子已有友方")
    return
  end
  local teamLogicPos = teamData:GetWCTeamLogicPos()
  local startGrid = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, teamLogicPos)
  local isOK, pathList = WarChessHelper.AStrarPathFind(self.wcCtrl.mapCtrl, startGrid, gridData, false, teamData)
  if isOK then
    local logicPos = gridData:GetGridLogicPos()
    startGrid:SetWCGridIsStandTeam(false)
    gridData:SetWCGridIsStandTeam(true)
    teamData:SetWCTeamLogicPos(logicPos)
    heroEntity:WCAnimatorSetWalk(true)
    teamData:SetIsMoving(true)
    self:_StopTeamMoveAudio()
    self._moveAuBack = AudioManager:PlayAudioById(1254, function()
      self._moveAuBack = nil
    end)
    self.wcCtrl.wcCamCtrl:WcCamCustomFollow(heroEntity:GetWCHeroEntityGo().transform, true)
    self.wcCtrl.wcCamCtrl:SetWcCamCanDragStopFollow(true)
    self.wcCtrl.animaCtrl:WCSetMoveableFXVisiabel(nil)
    local index = #pathList
    local targetRotate
    local rotatePassedTime = 0
    local needCalRotate = true
    local wayLength = #pathList
    local isNeedAccMove = wayLength / TEAM_MOVE_SPEED_PER_SECOND > MAX_MOVE_COST_TIME
    local vMax = wayLength / (MAX_MOVE_COST_TIME - ACC_TIME)
    local totalPassedTime = 0
    
    local function MoveEntity_Update()
      if index == 0 then
        warn("0 step move, pls check")
        return true
      end
      local moveHeroEntity = self:GetWCHeroEntity(teamIndex, nil, nil)
      
      local function StopMoveFun(isSuccess)
        self:_StopTeamMoveAudio()
        self.wcCtrl.wcCamCtrl:WcCamCustomFollow(nil)
        self.wcCtrl.wcCamCtrl:SetWcCamCanDragStopFollow(false)
        if not isSuccess then
          return
        end
        moveHeroEntity:WCAnimatorSetWalk(false)
        moveHeroEntity:WCAnimatorSetFloat("WarChess_WalkSpeed", 1)
        teamData:SetIsMoving(false)
        local moveOverCallback = teamData:GetMoveOverCallback()
        teamData:SetMoveOverCallback()
        if moveOverCallback ~= nil then
          moveOverCallback()
        end
        self.wcCtrl.animaCtrl:WCSetMoveableFXVisiabel(teamData)
        MsgCenter:Broadcast(eMsgEventId.WC_SelectTeam, teamData)
        local logicPos = teamData:GetWCTeamServerPos()
        WarChessManager:QuickExeWCGuideActions(eWarChessEnum.wcGuideMomentType.EnterWCGrid, logicPos)
      end
      
      if moveHeroEntity == nil then
        StopMoveFun()
        return true
      end
      if CommonUtil.GetIsWarChessQuickMove() then
        local targeShowPos = pathList[1]:GetGridShowPos()
        local entityCurPos = moveHeroEntity:WCHeroEntityGetShowPos()
        local lastShowPos = pathList[2] and pathList[2]:GetGridShowPos() or entityCurPos
        local newRotate = Quaternion.LookRotation(targeShowPos - lastShowPos, Vector3.up)
        moveHeroEntity:WCHeroEntitySetRotate(newRotate)
        moveHeroEntity:WCHeroEntitySetPos(targeShowPos)
        self.wcCtrl.animaCtrl:PlayWcHeroQuickMoveFx(entityCurPos, targeShowPos)
        MsgCenter:Broadcast(eMsgEventId.WC_TeamInfoUpdate, teamData)
        StopMoveFun(true)
        return true
      end
      local heroGo = moveHeroEntity:GetWCHeroEntityGo()
      if IsNull(heroGo) then
        return false
      end
      local deltaTime = Time.deltaTime
      totalPassedTime = totalPassedTime + deltaTime
      local maxMoveDis = TEAM_MOVE_SPEED_PER_SECOND * deltaTime
      if isNeedAccMove then
        local speed = TEAM_MOVE_SPEED_PER_SECOND
        if totalPassedTime <= MAX_MOVE_COST_TIME then
          speed = vMax * (totalPassedTime / MAX_MOVE_COST_TIME)
          speed = math.max(speed, TEAM_MOVE_SPEED_PER_SECOND)
        elseif totalPassedTime > MAX_MOVE_COST_TIME - ACC_TIME then
          speed = vMax * ((MAX_MOVE_COST_TIME - totalPassedTime) / ACC_TIME)
          speed = math.max(speed, TEAM_MOVE_SPEED_PER_SECOND)
        else
          speed = vMax
        end
        maxMoveDis = speed * deltaTime
        moveHeroEntity:WCAnimatorSetFloat("WarChess_WalkSpeed", speed / TEAM_MOVE_SPEED_PER_SECOND)
      end
      local targeGrid = pathList[index]
      local targeShowPos = targeGrid:GetGridShowPos()
      local entityCurPos = moveHeroEntity:WCHeroEntityGetShowPos()
      local pos = WarChessHelper.Vector3MoveToward(entityCurPos, targeShowPos, maxMoveDis)
      moveHeroEntity:WCHeroEntitySetPos(pos, true)
      MsgCenter:Broadcast(eMsgEventId.WC_TeamInfoUpdate, teamData)
      if needCalRotate then
        local moveToward = Vector3.Normalize(targeShowPos - entityCurPos)
        if moveToward:SqrMagnitude() > 0.001 and moveHeroEntity:WCHeroEntityGetForward() ~= moveToward then
          local newRotate = Quaternion.LookRotation(moveToward, Vector3.up)
          targetRotate = newRotate
          rotatePassedTime = 0
        end
        needCalRotate = false
      end
      if targetRotate ~= nil then
        rotatePassedTime = rotatePassedTime + deltaTime
        local rate = rotatePassedTime / ROTATE_COST_TIME
        local curRotate = moveHeroEntity:WCHeroEntityGetRotate()
        local rotate = Quaternion.Slerp(curRotate, targetRotate, rate)
        moveHeroEntity:WCHeroEntitySetRotate(rotate)
        if 1 <= rate then
          targetRotate = nil
        end
      end
      if pos == targeShowPos then
        index = index - 1
        needCalRotate = true
      end
      if index == 0 then
        StopMoveFun(true)
        return true
      end
      return false
    end
    
    return true, BindCallback(self, MoveEntity_Update)
  end
end

function WarChessTeamCtrl:UpdateAllFairyFollowMove()
  local totalPassedTime = 0
  local isAllTouched = false
  
  local function FollowHeroTeam()
    local deltaTime = Time.deltaTime
    totalPassedTime = totalPassedTime + deltaTime
    if totalPassedTime < FAIRY_MOVE_DELAY_TIME then
      return false
    end
    isAllTouched = true
    for _, teamData in pairs(self.__TeamDic) do
      local teamIndex = teamData:GetWCTeamIndex()
      local heroEntity = self:GetWCHeroEntity(teamIndex)
      if heroEntity ~= nil then
        local fairyEntity = heroEntity:GetWCHeroFairyEntity()
        if fairyEntity ~= nil then
          local targetPos, finalRotate = fairyEntity:GetFairyEntityTargetPosAndRotate(heroEntity)
          local curpos = fairyEntity:WCFairyEntityGetPos()
          local curRotate = fairyEntity:WCFairyntityGetRotate()
          if (curpos - targetPos):SqrMagnitude() < 0.01 and finalRotate == curRotate then
            fairyEntity:WCFairyAnimatorSetWalk(false)
          else
            local speed = TEAM_MOVE_SPEED_PER_SECOND * (totalPassedTime / MAX_MOVE_COST_TIME) + 2
            speed = math.min(speed, TEAM_MOVE_SPEED_PER_SECOND)
            local maxMoveDis = speed * deltaTime
            local pos = WarChessHelper.Vector3MoveToward(curpos, targetPos, maxMoveDis)
            fairyEntity:WCFairyEntitySetPos(pos)
            fairyEntity:WCFairyAnimatorSetWalk(true, speed / TEAM_MOVE_SPEED_PER_SECOND)
            local moveToward = Vector3.Normalize(targetPos - curpos)
            local targetRotate
            if moveToward:SqrMagnitude() > 0.001 then
              targetRotate = Quaternion.LookRotation(moveToward, Vector3.up)
              if targetRotate ~= curRotate then
                local rotate = Quaternion.RotateTowards(curRotate, targetRotate, 15)
                fairyEntity:WCFairyntitySetRotate(rotate)
              end
            end
            if pos ~= targetPos or targetRotate ~= nil and targetRotate ~= curRotate or teamData:GetIsMoving() then
              isAllTouched = false
            elseif math.abs(Quaternion.Dot(finalRotate, curRotate)) <= 0.999 then
              local rotate = Quaternion.RotateTowards(curRotate, finalRotate, 30)
              fairyEntity:WCFairyntitySetRotate(rotate)
              isAllTouched = false
            else
              fairyEntity:WCFairyAnimatorSetWalk(false)
            end
          end
        end
      end
    end
    return isAllTouched
  end
  
  return BindCallback(self, FollowHeroTeam)
end

function WarChessTeamCtrl:_StopTeamMoveAudio()
  if self._moveAuBack ~= nil then
    AudioManager:StopAudioByBack(self._moveAuBack)
    self._moveAuBack = nil
  end
end

function WarChessTeamCtrl:UpdateTeamPosByMsg(formDiffPos)
  local isApAdded = false
  for _, teamDiffData in pairs(formDiffPos) do
    local tid = teamDiffData.tid
    local curAP = teamDiffData.point
    local moveAnima = teamDiffData.moveAnima
    local BFId, coordination
    if teamDiffData.update ~= nil then
      BFId = teamDiffData.update.gid
      coordination = teamDiffData.update.pos
    end
    local alg = teamDiffData.alg
    local numericUpdate = teamDiffData.numericUpdate
    
    local function ForceSetTeamPos(teamData, coordination)
      local earlySetPos = teamData:GetEarlySettedPos()
      if earlySetPos ~= nil then
        if coordination == earlySetPos then
          teamData:SetEarlySettedPos(nil)
          local curGridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, teamData:GetWCTeamLogicPos())
          curGridData:SetWCGridIsStandTeam(true)
        end
        return
      end
      local x, y = WarChessHelper.Coordination2Pos(coordination)
      local logicPos = Vector2.New(x, y)
      local startGrid = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, teamData:GetWCTeamLogicPos())
      local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, logicPos)
      startGrid:SetWCGridIsStandTeam(false)
      gridData:SetWCGridIsStandTeam(true)
      teamData:SetWCTeamLogicPos(logicPos)
      local heroEntity = self:GetWCHeroEntity(teamData:GetWCTeamIndex(), nil, nil)
      local targeShowPos = Vector3.New(logicPos.x, 0, logicPos.y)
      heroEntity:WCHeroEntitySetPos(targeShowPos)
      self.wcCtrl.wcCamCtrl:SetWcCamFollowPos(targeShowPos)
      self:CalTeamCouldMoveGridDic(teamData)
      MsgCenter:Broadcast(eMsgEventId.WC_TeamInfoUpdate, teamData)
    end
    
    local isApAdd = false
    for teamIndex, teamData in pairs(self.__TeamDic) do
      if teamData:GetWCTeamId() == tid then
        isApAdd = curAP > teamData:GetTeamActionPoint()
        teamData:SetTeamActionPoint(curAP)
        teamData:UpdateTeamChipDiff(alg)
        if numericUpdate ~= nil and table.count(numericUpdate) > 0 then
          teamData:UpdateTeamNumericDiff(numericUpdate)
          MsgCenter:Broadcast(eMsgEventId.WC_TeamNumericChange, teamData, numericUpdate)
        end
        local curCoordination = WarChessHelper.Pos2Coordination(teamData:GetWCTeamLogicPos())
        if coordination ~= nil and curCoordination ~= coordination then
          if moveAnima then
            local x, y = WarChessHelper.Coordination2Pos(coordination)
            local targetGrid = self.wcCtrl.mapCtrl:GetGridDataByLogicXY(nil, x, y)
            self.wcCtrl.curState:WCPlayStateSelectTeam(teamData, true, true)
            if teamData:GetIsMoving() then
              self.wcCtrl.curState:SeTryAutoMoveMoverOverCallback(function()
                self.wcCtrl.curState:Walk2Grid(targetGrid, nil, true)
                teamData:SetMoveOverCallback(function()
                  ForceSetTeamPos(teamData, coordination)
                end)
              end)
            else
              self.wcCtrl.curState:Walk2Grid(targetGrid, nil, true)
              teamData:SetMoveOverCallback(function()
                ForceSetTeamPos(teamData, coordination)
              end)
            end
          elseif teamData:GetIsMoving() then
            teamData:SetMoveOverCallback(function()
              ForceSetTeamPos(teamData, coordination)
            end)
          else
            ForceSetTeamPos(teamData, coordination)
          end
        end
        local isChangeAlgLimit = 0 < teamDiffData.algLimitMask & 1
        if isChangeAlgLimit then
          local algLimit = teamDiffData.algLimitMask >> 1
          local dynPlyer = teamData:GetTeamDynPlayer()
          dynPlyer:UpDateWCDynPlayerChipLimit(algLimit)
        end
      end
    end
    if not isApAdded and isApAdd then
      AudioManager:PlayAudioById(1241)
      isApAdded = isApAdd
    end
  end
  return isApAdded
end

function WarChessTeamCtrl:GetWcTeamHeroHpPer(heroId)
  local dynHeroData = self.__AllUsedHeroDic[heroId]
  return dynHeroData and dynHeroData.hpPer or 10000
end

function WarChessTeamCtrl:InitWCMvpData()
  self.__epMvpData = EpMvpData.New(self.__AllUsedHeroDic)
  for heroId, dynHeroData in pairs(self.__AllUsedHeroDic) do
    self.__epMvpData.defaultMVPHeroId = dynHeroData.dataId
    break
  end
end

function WarChessTeamCtrl:GetWCMvpData()
  return self.__epMvpData
end

function WarChessTeamCtrl:GetWCAPMaxNum()
  return ConfigData.warchess_general.defaultAPLimit + self.wcCtrl.backPackCtrl:GetWCUserNumericNum(proto_object_WarChessNumeric.WarChessNumericModifyBehaviorPointLimit)
end

function WarChessTeamCtrl:WcAllTeamHasAp()
  for k, teamData in pairs(self.__TeamDic) do
    if teamData:GetTeamActionPoint() > 0 then
      return true
    end
  end
  return false
end

function WarChessTeamCtrl:GetAllTeamChip()
  local chipList = {}
  for k, v in pairs(self.__TeamDic) do
    local tempDynPlayer = v:GetTeamDynPlayer()
    if tempDynPlayer ~= nil then
      local tempList = tempDynPlayer:GetChipList()
      for _, v2 in pairs(tempList) do
        table.insert(chipList, v2)
      end
    end
  end
  return chipList
end

function WarChessTeamCtrl:ResposeHeroEntity()
  if self.__WCHeroEntityDic ~= nil then
    for key, heroEntity in pairs(self.__WCHeroEntityDic) do
      if heroEntity ~= nil then
        heroEntity:Delete()
      end
    end
    self.__WCHeroEntityDic = {}
  end
end

function WarChessTeamCtrl:OnSceneUnload()
  self:ResposeHeroEntity()
end

function WarChessTeamCtrl:Delete()
  self:_StopTeamMoveAudio()
  if self._InitTeamCo ~= nil then
    GR.StopCoroutine(self._InitTeamCo)
    self._InitTeamCo = nil
  end
  self:ResposeHeroEntity()
end

return WarChessTeamCtrl
