require("sp_base_inst")
_class("SkillPreviewDestroyOutlineRangeInstruction", SkillPreviewBaseInstruction)
SkillPreviewDestroyOutlineRangeInstruction = SkillPreviewDestroyOutlineRangeInstruction

function SkillPreviewDestroyOutlineRangeInstruction:Constructor(params)
end

function SkillPreviewDestroyOutlineRangeInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local g = self._world:GetGroup(self._world.BW_WEMatchers.SkillRangeOutline)
  local es = {}
  for _, e in ipairs(g:GetEntities()) do
    if e and e:HasSkillRangeOutline() and e:SkillRangeOutline():IsDestroy() then
      table.insert(es, e)
    end
  end
  for _, e in pairs(es) do
    self._world:DestroyEntity(e)
  end
end
