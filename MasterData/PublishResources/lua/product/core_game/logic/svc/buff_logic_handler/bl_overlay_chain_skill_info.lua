_class("BuffLogicOverlayChainSkillInfo", BuffLogicBase)
BuffLogicOverlayChainSkillInfo = BuffLogicOverlayChainSkillInfo

function BuffLogicOverlayChainSkillInfo:Constructor(buffInstance, logicParam)
  self._overlayInfo = logicParam.overlayInfo
end

function BuffLogicOverlayChainSkillInfo:DoLogic()
  local e = self:GetEntity()
  if not e:HasSkillInfo() then
    return
  end
  local cSkillInfo = e:SkillInfo()
  cSkillInfo:BuffOverlayChainSkillByStepAndOriIndexSkill(self._overlayInfo)
  return {}
end

_class("BuffLogicClearOverlayChainSkillInfo", BuffLogicBase)
BuffLogicClearOverlayChainSkillInfo = BuffLogicClearOverlayChainSkillInfo

function BuffLogicClearOverlayChainSkillInfo:Constructor(buffInstance, logicParam)
end

function BuffLogicClearOverlayChainSkillInfo:DoLogic()
  local e = self:GetEntity()
  if not e:HasSkillInfo() then
    return
  end
  local cSkillInfo = e:SkillInfo()
  cSkillInfo:ClearBuffOverlayChainSkillInfo()
  return {}
end
