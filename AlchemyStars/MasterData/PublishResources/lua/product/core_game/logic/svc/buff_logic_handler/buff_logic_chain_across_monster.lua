_class("BuffLogicChainAcrossMonster", BuffLogicBase)
BuffLogicChainAcrossMonster = BuffLogicChainAcrossMonster

function BuffLogicChainAcrossMonster:Constructor(buffInstance, logicParam)
  self._remove = logicParam.remove or 0
  self._moveEffect = logicParam.moveEffect
end

function BuffLogicChainAcrossMonster:DoLogic(notify)
  local notifyType = notify:GetNotifyType()
  if notifyType ~= NotifyType.PlayerEachMoveStart and notifyType ~= NotifyType.PlayerEachMoveEnd then
    return
  end
  local chainIndex = notify:GetChainIndex()
  if chainIndex == 1 then
    return
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainAcrossMonster = logicChainPathCmpt:GetChainAcrossMonster()
  if not chainAcrossMonster then
    return
  end
  local chainPosList = logicChainPathCmpt:GetLogicChainPath()
  local monsterPosList = logicChainPathCmpt:GetChainMonsterPosList()
  local entity = notify:GetNotifyEntity()
  local buffResult
  if notifyType == NotifyType.PlayerEachMoveStart then
    local nextPos = notify:GetPos()
    local curChainIndex = math.max(1, chainIndex - 1)
    local curPos = chainPosList[curChainIndex]
    if not table.intable(monsterPosList, curPos) and table.intable(monsterPosList, nextPos) then
      buffResult = BuffResultChainAcrossMonster:New(entity:GetID(), notifyType, chainIndex, curPos, false)
    end
  elseif notifyType == NotifyType.PlayerEachMoveEnd then
    local curPos = notify:GetPos()
    local lastPos = notify:GetOldPos()
    if not table.intable(monsterPosList, curPos) and table.intable(monsterPosList, lastPos) then
      buffResult = BuffResultChainAcrossMonster:New(entity:GetID(), notifyType, chainIndex, curPos, true)
    end
  end
  if not buffResult then
    return
  end
  return buffResult
end
