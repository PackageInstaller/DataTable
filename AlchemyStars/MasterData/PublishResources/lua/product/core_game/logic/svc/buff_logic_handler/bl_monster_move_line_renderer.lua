_class("BuffLogicInitMonsterMoveGroupLineRenderer", BuffLogicBase)
BuffLogicInitMonsterMoveGroupLineRenderer = BuffLogicInitMonsterMoveGroupLineRenderer

function BuffLogicInitMonsterMoveGroupLineRenderer:Constructor(buffInstance, logicParam)
  self._effectID = logicParam.effectID
end

function BuffLogicInitMonsterMoveGroupLineRenderer:DoLogic(notify)
  local utilCalcServiceShare = self._world:GetService("UtilCalc")
  local ownerMonsterIDCmpt = self._entity:MonsterID()
  local myGroupMonsterList = utilCalcServiceShare:FindMonsterByMoveGroupID(ownerMonsterIDCmpt:GetMoveGroupID())
  if 1 < #myGroupMonsterList then
    local hasLineFlag = false
    for i, monsterEntity in ipairs(myGroupMonsterList) do
      local monsterIDCmpt = monsterEntity:MonsterID()
      if monsterIDCmpt:HasMoveGroupLine() then
        hasLineFlag = true
      end
    end
    if not hasLineFlag then
      ownerMonsterIDCmpt:SetMoveGroupLineState(true)
      Log.info("LineHolder:", self._entity:GetID())
      return {
        self._effectID,
        ownerMonsterIDCmpt:GetMoveGroupID()
      }
    end
  end
end

_class("BuffLogicUpdateMonsterMoveGroupLineRenderer", BuffLogicBase)
BuffLogicUpdateMonsterMoveGroupLineRenderer = BuffLogicUpdateMonsterMoveGroupLineRenderer

function BuffLogicUpdateMonsterMoveGroupLineRenderer:Constructor(buffInstance, logicParam)
end

function BuffLogicUpdateMonsterMoveGroupLineRenderer:DoLogic(notify)
end

_class("BuffLogicDeleteMonsterMoveGroupLineRenderer", BuffLogicBase)
BuffLogicDeleteMonsterMoveGroupLineRenderer = BuffLogicDeleteMonsterMoveGroupLineRenderer

function BuffLogicDeleteMonsterMoveGroupLineRenderer:Constructor(buffInstance, logicParam)
  self._effectID = logicParam.effectID
end

function BuffLogicDeleteMonsterMoveGroupLineRenderer:DoLogic(notify)
  local monsterIDCmpt = self._entity:MonsterID()
  if monsterIDCmpt:HasMoveGroupLine() then
    return self._effectID
  end
end
