require("ai_node_new")
_class("ActionNightKingCanTailFlick", AINewNode)
ActionNightKingCanTailFlick = ActionNightKingCanTailFlick

function ActionNightKingCanTailFlick:Constructor()
end

function ActionNightKingCanTailFlick:OnUpdate()
  local ownEntity = self.m_entityOwn
  local myPos = ownEntity:GetGridPosition()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local newDir, newBodyArea = utilScopeSvc:GetTailFlickSwitchBodyArea(ownEntity, teamEntity)
  for i = 2, #newBodyArea do
    local area = newBodyArea[i]
    local newPos = area + myPos
    if utilScopeSvc:IsPosBlock(newPos, BlockFlag.MonsterLand) then
      return AINewNodeStatus.Failure
    end
  end
  return AINewNodeStatus.Success
end
