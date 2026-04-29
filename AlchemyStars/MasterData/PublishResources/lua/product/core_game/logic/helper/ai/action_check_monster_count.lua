require("ai_node_new")
_class("ActionCheckMonsterCount", AINewNode)
ActionCheckMonsterCount = ActionCheckMonsterCount

function ActionCheckMonsterCount:OnUpdate()
  local str = self:GetLogicData(-1)
  local ss = string.split(str, ",")
  local nSummonIDs = {}
  for i, s in ipairs(ss) do
    nSummonIDs[#nSummonIDs + 1] = tonumber(s)
  end
  local nLimitCount = self:GetLogicData(-2)
  local hadCount = 0
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  if monsterGroup then
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if not monsterEntity:HasDeadMark() then
        local monsterClassID = monsterEntity:MonsterID():GetMonsterClassID()
        if table.icontains(nSummonIDs, monsterClassID) then
          hadCount = hadCount + 1
        end
        if nLimitCount <= hadCount then
          return AINewNodeStatus.Failure
        end
      end
    end
  end
  return AINewNodeStatus.Success
end
