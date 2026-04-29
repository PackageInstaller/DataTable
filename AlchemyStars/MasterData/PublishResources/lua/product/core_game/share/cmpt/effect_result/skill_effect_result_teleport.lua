require("skill_effect_result_base")
_class("SkillEffectResult_Teleport", SkillEffectResultBase)
SkillEffectResult_Teleport = SkillEffectResult_Teleport

function SkillEffectResult_Teleport:Constructor(nTargetID, posOld, colorOld, posNew, dirNew, stageIndex, onlyDeleteBlock)
  self.m_nCasterID = nTargetID
  self.m_nTargetID = nTargetID
  self.m_posOld = posOld
  self.m_colorOld = colorOld
  self.m_posNew = posNew
  self.m_dirNew = dirNew
  self.m_stageIndex = stageIndex
  self.m_bTriggerEddy = true
  self._triggerTrapIDList = {}
  self._onlyDeleteBlock = onlyDeleteBlock
  self._needDelTrapEntityID = 0
  self._extraTeleportPos = Vector2.zero
  self._needDelTrapEntityIDs = {}
  self._isPetActiveSkill = false
  self._renderTeleportPath = {}
  self._posCalcState = nil
end

function SkillEffectResult_Teleport:IsSame(otherResult)
  return true
end

function SkillEffectResult_Teleport:GetEffectType()
  return SkillEffectType.Teleport
end

function SkillEffectResult_Teleport:GetTargetID()
  return self.m_nTargetID
end

function SkillEffectResult_Teleport:GetPosOld()
  return self.m_posOld:Clone()
end

function SkillEffectResult_Teleport:GetPosNew()
  if self.m_posNew then
    return self.m_posNew:Clone()
  end
end

function SkillEffectResult_Teleport:GetDirNew()
  return self.m_dirNew
end

function SkillEffectResult_Teleport:GetColorOld()
  return self.m_colorOld
end

function SkillEffectResult_Teleport:SetColorNew(color)
  self.m_colorNew = color
end

function SkillEffectResult_Teleport:GetColorNew()
  return self.m_colorNew
end

function SkillEffectResult_Teleport:GetGridPos()
  return self.m_posOld
end

function SkillEffectResult_Teleport:GetStageIndex()
  return self.m_stageIndex
end

function SkillEffectResult_Teleport:GetDamageStageIndex()
  return self.m_stageIndex
end

function SkillEffectResult_Teleport:SetEddyData(nCasterID, bTriggerEddy)
  self.m_nCasterID = nCasterID
  self.m_bTriggerEddy = bTriggerEddy
end

function SkillEffectResult_Teleport:GetCasterID()
  return self.m_nCasterID
end

function SkillEffectResult_Teleport:IsEnableTriggerEddy()
  return self.m_bTriggerEddy
end

function SkillEffectResult_Teleport:SetOnlyDeleteBlock(state)
  self._onlyDeleteBlock = state
end

function SkillEffectResult_Teleport:IsOnlyDeleteBlock()
  return self._onlyDeleteBlock
end

function SkillEffectResult_Teleport:GetTriggerTrapIDList()
  return self._triggerTrapIDList
end

function SkillEffectResult_Teleport:SetTriggerTrapList(idList)
  self._triggerTrapIDList = idList
end

function SkillEffectResult_Teleport:SetNeedDelTrapEntityID(id)
  self._needDelTrapEntityID = id
end

function SkillEffectResult_Teleport:GetNeedDelTrapEntityID()
  return self._needDelTrapEntityID
end

function SkillEffectResult_Teleport:SetExtraTeleportPos(pos)
  self._extraTeleportPos = pos
end

function SkillEffectResult_Teleport:GetExtraTeleportPos()
  return self._extraTeleportPos
end

function SkillEffectResult_Teleport:SetNeedDelTrapEntityIDs(ids)
  self._needDelTrapEntityIDs = ids
end

function SkillEffectResult_Teleport:GetNeedDelTrapEntityIDs()
  return self._needDelTrapEntityIDs
end

function SkillEffectResult_Teleport:SetTeleportResult_IsPetActiveSkill(param)
  self._isPetActiveSkill = param
end

function SkillEffectResult_Teleport:GetTeleportResult_IsPetActiveSkill()
  return self._isPetActiveSkill
end

function SkillEffectResult_Teleport:SetRenderTeleportPath(param)
  self._renderTeleportPath = param
end

function SkillEffectResult_Teleport:GetRenderTeleportPath()
  return self._renderTeleportPath
end

function SkillEffectResult_Teleport:SetTeleportPosCalcState(calcState)
  self._posCalcState = calcState
end

function SkillEffectResult_Teleport:GetTeleportPosCalcState()
  return self._posCalcState
end
