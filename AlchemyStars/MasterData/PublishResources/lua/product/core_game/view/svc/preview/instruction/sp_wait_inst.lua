require("sp_base_inst")
_class("SkillPreviewWaitInstruction", SkillPreviewBaseInstruction)
SkillPreviewWaitInstruction = SkillPreviewWaitInstruction

function SkillPreviewWaitInstruction:Constructor(params)
  self._timeLen = params.TimeMs
  local dontBreak = params.DontBreak
  if dontBreak then
    self._dontBreak = tonumber(params.DontBreak) == 1
  end
end

function SkillPreviewWaitInstruction:DoInstruction(TT, casterEntity, previewContext)
  if self._timeLen then
    YIELD(TT, tonumber(self._timeLen))
  else
    YIELD(TT)
  end
  local needBreak = previewContext:IsNeedBreak()
  if self._dontBreak then
    needBreak = false
  end
  return needBreak
end
