require("ai_node_new")
_class("ActionCheckTargetMonsterInScope", AINewNode)
ActionCheckTargetMonsterInScope = ActionCheckTargetMonsterInScope

function ActionCheckTargetMonsterInScope:OnUpdate()
  local skill = self:GetLogicData(-1)
  local targetMonsterAI = self:GetLogicData(-2)
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  if nil == aiComponent then
    return false
  end
  local selfPos = entityCaster:GetGridPosition()
  local dir = entityCaster:GridLocation().Direction
  local selfBodyArea = entityCaster:BodyArea():GetArea()
  local skillRangeData = self:CalculateSkillRange(skill, selfPos, dir, selfBodyArea)
  local targetPos = skillRangeData[1]
  local skillScope = {}
  local cfgService = self._world:GetService("Config")
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, entity in ipairs(monsterGroup:GetEntities()) do
    local monsterID = entity:MonsterID()
    local monsterAIIDList = monsterConfigData:GetMonsterAIID(monsterID:GetMonsterID())
    if monsterAIIDList[1][1] == targetMonsterAI then
      local bodyAreaList = entity:BodyArea():GetArea()
      local gridPos = entity:GridLocation():GetGridPos()
      for _, bodyArea in ipairs(bodyAreaList) do
        local workPos = gridPos + bodyArea
        table.insert(skillScope, workPos)
      end
    end
  end
  if table.intable(skillScope, targetPos) then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end
