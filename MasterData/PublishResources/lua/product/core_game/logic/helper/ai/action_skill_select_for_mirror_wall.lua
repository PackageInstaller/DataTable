require("ai_node_new")
_class("ActionSkillSelectForMirrorWall", AINewNode)
ActionSkillSelectForMirrorWall = ActionSkillSelectForMirrorWall

function ActionSkillSelectForMirrorWall:Constructor()
  self._skillListIndex = 1
  self._skillID = 0
  self.m_nDefaultSkillIndex = 0
  self.m_nSkillListCount = 0
end

function ActionSkillSelectForMirrorWall:InitializeNode(cfg, context, parentNode, configData)
  ActionSkillSelectForMirrorWall.super.InitializeNode(self, cfg, context, parentNode, configData)
  self._buffID = configData[1]
  self._targetAI = configData[2]
  self._targetPos = configData[3]
end

function ActionSkillSelectForMirrorWall:Update()
  local vecSkillList = self:GetConfigSkillList()
  local buffCmp = self.m_entityOwn:BuffComponent()
  local buffInstance = buffCmp:GetBuffById(self._buffID)
  if buffInstance then
    local cfgService = self._world:GetService("Config")
    local monsterConfigData = cfgService:GetMonsterConfigData()
    local targetGroupEntities = {}
    local targetMonsterPos = {}
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, e in ipairs(monsterGroup:GetEntities()) do
      local monsterID = e:MonsterID():GetMonsterID()
      local monsterAIIDList = monsterConfigData:GetMonsterAIID(monsterID)
      if monsterAIIDList[1][1] == self._targetAI and not e:HasDeadMark() and not e:HasDeadMark() then
        table.insert(targetGroupEntities, e)
        table.insert(targetMonsterPos, e:GetGridPosition())
      end
    end
    if #targetGroupEntities == 4 then
      self._skillID = vecSkillList[1][1]
    else
      local deadMonsterIndex = 0
      for i = 1, #self._targetPos do
        local pos = self._targetPos[i]
        local hadThisPos = false
        for _, monsterPos in ipairs(targetMonsterPos) do
          if monsterPos.x == pos.x and monsterPos.y == pos.y then
            hadThisPos = true
            break
          end
        end
        if hadThisPos == false then
          deadMonsterIndex = i
          break
        end
      end
      self._skillID = vecSkillList[2][deadMonsterIndex]
    end
  else
    self._skillID = vecSkillList[3][1]
  end
  return AINewNodeStatus.Success
end

function ActionSkillSelectForMirrorWall:GetActionSkillID()
  return self._skillID
end
