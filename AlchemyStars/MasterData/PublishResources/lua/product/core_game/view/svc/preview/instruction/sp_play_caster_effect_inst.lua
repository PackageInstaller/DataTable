require("sp_base_inst")
_class("SkillPreviewPlayCasterEffectInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayCasterEffectInstruction = SkillPreviewPlayCasterEffectInstruction

function SkillPreviewPlayCasterEffectInstruction:Constructor(params)
  self._effectID = tonumber(params.EffectID)
  self._isPet1702361 = tonumber(params.isPet1702361)
end

function SkillPreviewPlayCasterEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end

function SkillPreviewPlayCasterEffectInstruction:DoInstruction(TT, casterEntity, previewContext)
  local playEntity = casterEntity
  if self._isPet1702361 == 1 then
    local sPreviewSkill = previewContext:GetWorld():GetService("PreviewActiveSkill")
    playEntity = sPreviewSkill:GetPet1702361Entity(playEntity, previewContext)
  end
  local effectService = previewContext:GetWorld():GetService("Effect")
  effectService:CreateEffect(tonumber(self._effectID), playEntity)
end
