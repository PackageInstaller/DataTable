_class("BuffLogicConvertOnChainPosByLeftRound", BuffLogicBase)
BuffLogicConvertOnChainPosByLeftRound = BuffLogicConvertOnChainPosByLeftRound

function BuffLogicConvertOnChainPosByLeftRound:Constructor(buffInstance, logicParam)
  self._convertPieceType = tonumber(logicParam.convertPieceType)
end

function BuffLogicConvertOnChainPosByLeftRound:DoLogic(notify)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if self._entity:Pet() then
    local ownerTeamEntity = self._entity:Pet():GetOwnerTeamEntity()
    if teamEntity:GetID() ~= ownerTeamEntity:GetID() then
      return
    end
  end
  if self._world:MatchType() == MatchType.MT_Maze or self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze or self._world:MatchType() == MatchType.MT_PopStarPro then
    return
  end
  local battleStatCmpt = self._world:BattleStat()
  local convertIndex = battleStatCmpt:GetLevelLeftRoundCount() + 1
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local posList = {}
  local chainPath = logicChainPathCmpt:GetLogicChainPath()
  for i = 1, #chainPath - 1 do
    posList[#posList + 1] = Vector2(chainPath[i].x, chainPath[i].y)
  end
  if convertIndex > #posList then
    return
  end
  local pos = posList[convertIndex]
  local boardSvc = self._world:GetService("BoardLogic")
  if not boardSvc:GetCanConvertGridElement(pos) then
    return
  end
  local oldPieceType = boardSvc:GetPieceType(pos)
  boardSvc:SetPieceTypeLogic(self._convertPieceType, pos)
  local tConvertInfo = {}
  local convertInfo = NTGridConvert_ConvertInfo:New(pos, oldPieceType, self._convertPieceType)
  table.insert(tConvertInfo, convertInfo)
  local boardEntity = self._world:GetBoardEntity()
  local triggerSvc = self._world:GetService("Trigger")
  local ntGridConvert = NTGridConvert:New(boardEntity, tConvertInfo)
  triggerSvc:Notify(ntGridConvert)
  return BuffResultConvertOnChainPosByLeftRound:New(pos, oldPieceType, self._convertPieceType)
end
