require("ai_node_new")
_class("ActionIsNeedMoveGroup", AINewNode)
ActionIsNeedMoveGroup = ActionIsNeedMoveGroup

function ActionIsNeedMoveGroup:OnBegin()
end

function ActionIsNeedMoveGroup:Reset()
  ActionIsNeedMoveGroup.super.Reset(self)
  self:GetAllGroupMonster()
end

function ActionIsNeedMoveGroup:FindGroupMoveEntity()
  local maxGroupMoveMonsterEntity
  local maxGroupMoveCount = 0
  local aiRecorderCmpt = self._world:GetBoardEntity():AIRecorder()
  local isSameStep = true
  local firstStep = -1
  local noMoveCount = 0
  for _, monster in ipairs(self._sameGroupMonsterList) do
    local collection = aiRecorderCmpt:FindWalkResultByCasterID(monster:GetID())
    if collection then
      if maxGroupMoveCount < #collection:GetWalkResultList() then
        maxGroupMoveCount = #collection:GetWalkResultList()
        maxGroupMoveMonsterEntity = monster
      end
      if firstStep == -1 then
        firstStep = #collection:GetWalkResultList()
      elseif firstStep ~= #collection:GetWalkResultList() then
        Log.fatal("全都动过,有一个多走一格")
        isSameStep = false
      end
    else
      noMoveCount = noMoveCount + 1
    end
  end
  if isSameStep and noMoveCount ~= 0 and noMoveCount ~= #self._sameGroupMonsterList then
    Log.fatal("有动过有没动")
    isSameStep = false
  end
  if isSameStep then
    return
  end
  return maxGroupMoveMonsterEntity
end

function ActionIsNeedMoveGroup:OnUpdate()
  local sameMoveEntity = self:FindGroupMoveEntity()
  if sameMoveEntity and sameMoveEntity:GetID() ~= self.m_entityOwn:GetID() then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end
