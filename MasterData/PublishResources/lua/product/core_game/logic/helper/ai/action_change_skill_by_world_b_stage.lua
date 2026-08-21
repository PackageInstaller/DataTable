require("action_is_base")
_class("ActionChangeSkillByWorldBossStage", ActionIsBase)
ActionChangeSkillByWorldBossStage = ActionChangeSkillByWorldBossStage

function ActionChangeSkillByWorldBossStage:Constructor()
end

function ActionChangeSkillByWorldBossStage:OnUpdate()
  if AINewNode.IsEntityDead(self.m_entityOwn) then
    return AINewNodeStatus.Failure
  end
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  local monsterIDCmpt = entityCaster:MonsterID()
  if nil == aiComponent or not monsterIDCmpt then
    Log.exception("Caster Need Ai and MonsterID")
    return AINewNodeStatus.Success
  end
  local stage = monsterIDCmpt:GetCurStage()
  local nSkillID = self:GetLogicData(1)
  local dataConfig = self:GetConfigData()
  local curStageConfig = dataConfig[stage]
  if curStageConfig then
    if curStageConfig[nSkillID] then
      self._skillID = curStageConfig[nSkillID][1]
      self:PrintLog("世界Boss按阶段替换技能成功<强行修改>, TargetSkillID = ", self._skillID, "SourceSkillID:", nSkillID, "Stage:", stage)
      aiComponent:SetSelectSkillID(self._skillID)
    else
      self:PrintLog("世界Boss按阶段替换技能失败<强行修改> 无技能替换配置 , SourceSkillID:", nSkillID, "Stage:", stage)
    end
  end
  return AINewNodeStatus.Success
end
