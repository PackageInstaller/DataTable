_class("BuffViewPSPCastCampSkill", BuffViewBase)
BuffViewPSPCastCampSkill = BuffViewPSPCastCampSkill

function BuffViewPSPCastCampSkill:PlayView(TT, notify)
  local result = self._buffResult
  local deadMonsterEntityIdList = result:GetSkillDeadMonsterEntityIDList()
  if deadMonsterEntityIdList then
    for _, eid in ipairs(deadMonsterEntityIdList) do
      local e = self._world:GetEntityByID(eid)
      e:AddDeadFlag()
    end
  end
  local skillID = result:GetSkillID()
  local skillHolder = self._world:GetEntityByID(result:GetSkillHolderID())
  local skillResult = result:GetSkillResult()
  skillHolder:SkillRoutine():SetResultContainer(skillResult)
  if not skillHolder:HasEffectController() and result:GetNotSetLocationState() == 0 then
    skillHolder:SetPosition(skillHolder:GetGridPosition() + skillHolder:GetGridOffset())
  end
  local playSkillSvc = self._world:GetService("PlaySkill")
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(skillID, skillHolder)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
  playSkillSvc:_SkillRoutineTask(TT, skillHolder, skillPhaseArray, skillID)
  if deadMonsterEntityIdList and 0 < #deadMonsterEntityIdList then
    local sMonsterShowRender = self._world:GetService("MonsterShowRender")
    sMonsterShowRender:DoAllMonsterDeadRender(TT)
  end
end
