local WarChessTeamData = class("WarChessTeamData")
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local WarChessDynPlayer = require("Game.WarChess.Data.Battle.WarChessDynPlayer")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")

function WarChessTeamData:ctor()
  self.__teamUID = nil
  self.__index = 0
  self.__clientIndex = 0
  self.__AP = 0
  self.__LastAP = self.__AP
  self.__curBFId = nil
  self.logicPos = nil
  self.__IsMoving = false
  self.__MoveOverCallback = nil
  self.__dynHeroDataOrderDic = {}
  self.__dynPlayer = nil
  self.__totalHp = 1
  self.__teamLeaderHeroId = nil
  self.__isGhost = false
  self.__isDead = false
  self.__moveableGirdDic = nil
  self.__buffNumericDic = {}
  self.__limitMoveOneGrid = nil
  self.__headIconOverraidId = nil
  self.__hideHead3DUI = false
  self.__initialDeploy = true
  self.__formationRuleCfg = nil
  self._chipAdd = {}
  self._chipDel = {}
  self._waitInitFairyData = nil
  self.__earlySetPos = nil
end

function WarChessTeamData.GetNewTeamDataByDTeamData(fInfo, dTeamData, deadTeamData)
  local teamData = WarChessTeamData.New()
  teamData.__index = fInfo.teamUid & CommonUtil.UInt16Max
  teamData.__clientIndex = dTeamData:GetDTeamIndex()
  teamData.logicPos = dTeamData:GetBornPoint()
  teamData.__teamLeaderHeroId = dTeamData:GetFirstHeroData().dataId
  teamData.__teamUID = fInfo.teamUid
  teamData.__AP = fInfo.point
  teamData:UpdateTeamNumericDiff(fInfo.formationNumeric)
  teamData.__teamName = dTeamData:GetDTeamName()
  teamData.__initialDeploy = fInfo.initial
  teamData.__treeId = dTeamData:GetFmtCSTId()
  local formationCfg = teamData:GetTeamFormationRuleCfg()
  local normalNum = formationCfg.stage_num
  local benchNum = formationCfg.bench_num
  for i = 1, normalNum do
    local heroData = dTeamData:GetDTeamHeroData(i)
    if heroData ~= nil then
      local heroId = heroData.dataId
      if heroData ~= nil then
        teamData.__dynHeroDataOrderDic[i] = heroId
      end
    end
  end
  for i = normalNum + 1, normalNum + benchNum do
    local heroData = dTeamData:GetDTeamHeroData(i)
    if heroData ~= nil then
      local heroId = heroData.dataId
      if heroData ~= nil then
        teamData.__dynHeroDataOrderDic[i] = heroId
      end
    end
  end
  if deadTeamData ~= nil then
    teamData.__dynPlayer = deadTeamData:GetTeamDynPlayer()
  else
    teamData.__dynPlayer = WarChessDynPlayer.CreateDungeonPlayer(teamData.__formationRuleCfg)
    teamData.__dynPlayer:UpDateWCDynPlayerChipLimit(fInfo.algLimit)
    teamData._waitInitFairyData = fInfo.fairy
  end
  return teamData
end

function WarChessTeamData.GetNewTeamDataByMsg(data, fmtData)
  local teamData = WarChessTeamData.New()
  local fInfo = data.fInfo
  teamData.__index = data.index
  if fInfo.pos ~= nil then
    local x, y = WarChessHelper.Coordination2Pos(fInfo.pos.pos)
    teamData.logicPos = Vector2.New(x, y)
  end
  teamData.__teamLeaderHeroId = nil
  teamData.__teamUID = fInfo.teamUid
  teamData.__AP = fInfo.point
  teamData:UpdateTeamNumericDiff(fInfo.formationNumeric)
  teamData.__teamName = data.teamName
  teamData.__initialDeploy = fInfo.initial
  teamData.__treeId = fmtData.cstId
  local formationCfg = teamData:GetTeamFormationRuleCfg()
  local normalNum = formationCfg.stage_num
  local benchNum = formationCfg.bench_num
  for i = 1, normalNum + benchNum do
    local heroId = fInfo.heroForms[i]
    if heroId ~= nil then
      if teamData.__teamLeaderHeroId == nil then
        teamData.__teamLeaderHeroId = heroId
      end
      teamData.__dynHeroDataOrderDic[i] = heroId
    end
  end
  teamData.__dynPlayer = WarChessDynPlayer.CreateDungeonPlayer(teamData.__formationRuleCfg)
  teamData.__dynPlayer:UpDateWCDynPlayerChipLimit(fInfo.algLimit)
  teamData._waitInitFairyData = fInfo.fairy
  teamData.__clientIndex = fInfo.fromFormationIdx
  if fInfo.fromFormationIdx == 0 then
    teamData.__clientIndex = data.index
  end
  return teamData
end

function WarChessTeamData:UpdateWCTeamFormDiff(formDiff)
  local oldLader = self.__teamLeaderHeroId
  self.__dynHeroDataOrderDic = {}
  self.__teamLeaderHeroId = nil
  local formationCfg = self:GetTeamFormationRuleCfg()
  local normalNum = formationCfg.stage_num
  local benchNum = formationCfg.bench_num
  for heroIndex = 1, normalNum + benchNum do
    local heroId = formDiff.update[heroIndex]
    if heroId ~= nil then
      if self.__teamLeaderHeroId == nil then
        self.__teamLeaderHeroId = heroId
      end
      self.__dynHeroDataOrderDic[heroIndex] = heroId
    end
  end
  if self.__teamLeaderHeroId == nil then
    error("warchess team is empty, pls check index:" .. tostring(self:GetWCTeamIndex()))
  end
  if oldLader ~= self.__teamLeaderHeroId then
    return true
  end
end

function WarChessTeamData:GetTeamDynPlayer()
  return self.__dynPlayer
end

function WarChessTeamData:GetWCTeamIndex()
  return self.__index
end

function WarChessTeamData:GetWCTeamClientIndex()
  return self.__clientIndex
end

function WarChessTeamData:GetWCTeamLogicPos()
  return self.logicPos
end

function WarChessTeamData:SetWCTeamLogicPos(logicPos)
  self.logicPos = logicPos
end

function WarChessTeamData:GetWCTeamServerPos()
  return WarChessHelper.Pos2Coordination(self.logicPos)
end

function WarChessTeamData:GetWCTeamId()
  return self.__teamUID
end

function WarChessTeamData:GetTeamActionPoint()
  return self.__AP
end

function WarChessTeamData:GetTeamCSTreeId()
  return self.__treeId
end

function WarChessTeamData:SetTeamActionPoint(ap)
  if ap == self.__AP then
    return
  end
  self.__LastAP = self.__AP
  self.__AP = ap
  MsgCenter:Broadcast(eMsgEventId.WC_TeamAPChange, self)
end

function WarChessTeamData:GetWCTeamIsGhost()
  return self.__isGhost
end

function WarChessTeamData:SetWCTeamIsGhost(isGhost)
  self.__isGhost = isGhost
end

function WarChessTeamData:GetWCTeamIsDead()
  return self.__isDead
end

function WarChessTeamData:SetWCTeamIsDead(isDead)
  self.__isDead = isDead
end

function WarChessTeamData:UpdateTeamChipDiff(alg)
  if table.count(alg) == 0 then
    return
  end
  table.clearmap(self._chipAdd)
  table.clearmap(self._chipDel)
  for chipId, v in pairs(alg) do
    if v == 0 then
      self._chipDel[chipId] = true
    else
      self._chipAdd[chipId] = v
    end
  end
  self.__dynPlayer:__UpdateAllChip(self._chipAdd, self._chipDel)
end

function WarChessTeamData:GetWCTeamChipList()
  local dynPlayer = self:GetTeamDynPlayer()
  return dynPlayer:GetChipList()
end

function WarChessTeamData:GetWCTeamOrderDic()
  return self.__dynHeroDataOrderDic
end

function WarChessTeamData:SetWCTeamMoveableGirdDic(moveableGirdDic)
  self.__moveableGirdDic = moveableGirdDic
end

function WarChessTeamData:GetWCTeamMoveableGirdDic()
  return self.__moveableGirdDic
end

function WarChessTeamData:SetWCTeamInteractablePosDic(couldInterActPosDic)
  self.__couldInterActPosDic = couldInterActPosDic
end

function WarChessTeamData:GetWCTeamInteractablePosDic()
  return self.__couldInterActPosDic
end

function WarChessTeamData:SetWCTeamLevelNubDic(levelNubDic)
  self.__levelNubDic = levelNubDic
end

function WarChessTeamData:GetWCTeamLevelNubDic()
  return self.__levelNubDic
end

function WarChessTeamData:SetIsMoving(bool)
  self.__IsMoving = bool
end

function WarChessTeamData:GetIsMoving()
  return self.__IsMoving
end

function WarChessTeamData:SetMoveOverCallback(callback)
  self.__MoveOverCallback = callback
end

function WarChessTeamData:GetMoveOverCallback()
  return self.__MoveOverCallback
end

function WarChessTeamData:GetFirstHeroId()
  return self.__teamLeaderHeroId
end

function WarChessTeamData:GetWCTeamName()
  return self.__teamName
end

function WarChessTeamData:GetWCTeamDiffAP()
  local changeNum = self.__AP - self.__LastAP
  self:ClearWCLastAP()
  return changeNum
end

function WarChessTeamData:ClearWCLastAP()
  self.__LastAP = self.__AP
end

function WarChessTeamData:GenWCTeamHP()
  local wcDynPlayer = self:GetTeamDynPlayer()
  local count = 0
  local totalRate = 0
  for heroId, dynHero in pairs(wcDynPlayer.heroDic) do
    if not dynHero:IsBench() then
      count = count + 1
      totalRate = totalRate + dynHero.hpPer
    end
  end
  self.__totalHp = totalRate / count / 10000
end

function WarChessTeamData:GetWCTeamHP()
  return self.__totalHp
end

function WarChessTeamData:RefreshWCTeamPower()
  self.__dynPlayer:RefreshCacheFightPower()
  local curPower = self.__dynPlayer:GetCacheFightPower()
  MsgCenter:Broadcast(eMsgEventId.WC_TeamPowerChange, self, curPower)
end

function WarChessTeamData:GetWCTeamPower()
  local curPower = self.__dynPlayer:GetCacheFightPower()
  return curPower
end

function WarChessTeamData:GetWCTeamHeroList()
  return self.__dynPlayer.heroList
end

function WarChessTeamData:GetWCTeamWaidInitFairyData()
  local data = self._waitInitFairyData
  self._waitInitFairyData = nil
  return data
end

function WarChessTeamData:UpdateTeamNumericDiff(numericUpdate)
  if numericUpdate ~= nil then
    for type, value in pairs(numericUpdate) do
      if value == 0 then
        self.__buffNumericDic[type] = nil
      else
        self.__buffNumericDic[type] = value
      end
    end
  end
  local curLimitMoveOneGrid
  if self.__buffNumericDic[proto_object_WarChessNumeric.WarChessNumericLimitMoveOneGrid] ~= nil then
    curLimitMoveOneGrid = true
  else
    curLimitMoveOneGrid = false
  end
  if self.__limitMoveOneGrid ~= curLimitMoveOneGrid then
    self.__limitMoveOneGrid = curLimitMoveOneGrid
  end
  if self.__buffNumericDic[proto_object_WarChessNumeric.WarChessBuffCatAddLimitCombatHeroNumPoint] ~= nil then
    self:UpdateTeamFormationRule(self.__buffNumericDic[proto_object_WarChessNumeric.WarChessBuffCatAddLimitCombatHeroNumPoint])
  end
  if numericUpdate[proto_object_WarChessNumeric.WarChessBuffCatAddChessMovePoint] ~= nil then
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    local value = numericUpdate[proto_object_WarChessNumeric.WarChessBuffCatAddChessMovePoint]
    if value == 0 then
      self:SetTeamHeadIcon(nil)
    else
      local iconResId = WarChessHelper.WCJumpChessType2HeadIconId(value)
      self:SetTeamHeadIcon(iconResId)
    end
  end
end

function WarChessTeamData:GetTeamNumeric(type)
  return self.__buffNumericDic[type]
end

function WarChessTeamData:UpdateTeamFormationRule(extraCombatHeroNum)
  if self.__extraCombatHeroNum == extraCombatHeroNum then
    return
  end
  local wcLevelCfg = WarChessManager:GetWCLevelCfg()
  local originalFormationRuleId = wcLevelCfg.start_formation
  self.__extraCombatHeroNum = extraCombatHeroNum
  local fmtRuleCfg = ConfigData.formation_rule[originalFormationRuleId]
  self.__formationRuleCfg = fmtRuleCfg
  local totalNum = fmtRuleCfg.stage_num + fmtRuleCfg.bench_num
  local newStageNum = fmtRuleCfg.stage_num + extraCombatHeroNum
  for k, v in pairs(ConfigData.formation_rule) do
    if v.stage_num == newStageNum and v.stage_num + v.bench_num == totalNum then
      self.__formationRuleCfg = v
      self:UpdateDynHeroByFromationRuleChange()
      return
    end
  end
end

function WarChessTeamData:UpdateDynHeroByFromationRuleChange()
  if self.__dynPlayer ~= nil then
    self.__dynPlayer:SetPlayerFormationRuleCfg(self.__formationRuleCfg)
    self.__dynPlayer:UpdateDynHerosDeployPos()
  end
end

function WarChessTeamData:UpdateWCDynHeroFairData(fairy)
  if self.__dynPlayer ~= nil then
    self.__dynPlayer:UpdataDynFairyData(fairy)
  end
end

function WarChessTeamData:GetIsLimitMoveOneGrid()
  return self.__limitMoveOneGrid
end

function WarChessTeamData:GetCouldWalkLength()
  if self.__limitMoveOneGrid then
    return 1
  end
  return nil
end

function WarChessTeamData:GetSetInitialDeploy()
  if self.__initialDeploy then
    self.__initialDeploy = false
    return true
  end
  return false
end

function WarChessTeamData:SetTeamHeadIcon(headId)
  self.__headIconOverraidId = headId
end

function WarChessTeamData:GetTeamHeadIcon()
  return self.__headIconOverraidId
end

function WarChessTeamData:GetTeamFormationRuleCfg()
  if self.__formationRuleCfg == nil then
    self:UpdateTeamFormationRule(0)
  end
  return self.__formationRuleCfg
end

function WarChessTeamData:SetEarlySettedPos(pos)
  self.__earlySetPos = pos
end

function WarChessTeamData:GetEarlySettedPos()
  return self.__earlySetPos
end

function WarChessTeamData:GetWCTeamFairyData()
  return self.__dynPlayer:GetDynFairyData()
end

function WarChessTeamData:SetIsShowHead3DUI(bool)
  self.__hideHead3DUI = not bool
end

function WarChessTeamData:GetIsShowHead3DUI()
  return not self.__hideHead3DUI
end

return WarChessTeamData
