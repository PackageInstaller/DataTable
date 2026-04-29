local ChangeMonsterPreviewSkillType = {Notify = 1}
_enum("ChangeMonsterPreviewSkillType", ChangeMonsterPreviewSkillType)
_class("BuffLogicChangeMonsterPreviewSkill", BuffLogicBase)
BuffLogicChangeMonsterPreviewSkill = BuffLogicChangeMonsterPreviewSkill

function BuffLogicChangeMonsterPreviewSkill:Constructor(buffInstance, logicParam)
  self._targetSkillID = logicParam.targetSkillID
  self._type = logicParam.type
end

function BuffLogicChangeMonsterPreviewSkill:DoLogic()
  local e = self._buffInstance:Entity()
  if e:HasMonsterID() then
    local aiCpmt = e:AI()
    local needReplace = false
    if self._type == ChangeMonsterPreviewSkillType.Notify then
      needReplace = true
    end
    if needReplace then
      aiCpmt:SetReplacePreviewSkillID(self._targetSkillID)
    end
  end
end

_class("BuffLogicResetChangePreviewSkill", BuffLogicBase)
BuffLogicResetChangePreviewSkill = BuffLogicResetChangePreviewSkill

function BuffLogicResetChangePreviewSkill:DoLogic()
  local e = self._buffInstance:Entity()
  if e:HasMonsterID() then
    local aiCpmt = e:AI()
    aiCpmt:ResetReplacePreviewSkillID()
  end
end
