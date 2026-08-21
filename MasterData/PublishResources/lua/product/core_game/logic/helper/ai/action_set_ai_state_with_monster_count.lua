require("ai_node_new")
_class("ActionSetAIStateWithMonsterCount", AINewNode)
ActionSetAIStateWithMonsterCount = ActionSetAIStateWithMonsterCount

function ActionSetAIStateWithMonsterCount:OnBegin()
  local str = self:GetLogicData(-1)
  local ss = string.split(str, ",")
  local nSummonIDs = {}
  for i, s in ipairs(ss) do
    nSummonIDs[#nSummonIDs + 1] = tonumber(s)
  end
  local hadCount = 1
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  if monsterGroup then
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if not monsterEntity:HasDeadMark() then
        local monsterClassID = monsterEntity:MonsterID():GetMonsterClassID()
        if table.icontains(nSummonIDs, monsterClassID) then
          hadCount = hadCount + 1
        end
      end
    end
  end
  local aiCmpt = self.m_entityOwn:AI()
  aiCmpt:SetAITreeState(hadCount)
  self:PrintLog("state=", hadCount)
end
