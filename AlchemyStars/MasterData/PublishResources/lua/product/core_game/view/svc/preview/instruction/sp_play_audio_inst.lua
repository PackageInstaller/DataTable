require("sp_base_inst")
_class("SkillPreviewPlayAudioInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayAudioInstruction = SkillPreviewPlayAudioInstruction

function SkillPreviewPlayAudioInstruction:Constructor(params)
  self._audioID = tonumber(params.audioID)
  local audioType = params.audioType
  if audioType == nil then
    self._audioType = SkillAudioType.Cast
  else
    self._audioType = tonumber(audioType)
  end
end

function SkillPreviewPlayAudioInstruction:DoInstruction(TT, casterEntity, previewContext)
  if GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    return
  end
  if self._audioType == SkillAudioType.Cast then
    local playingID = AudioHelperController.PlayInnerGameSfx(self._audioID)
    local effectCpmt = casterEntity:EffectHolder()
    if not effectCpmt then
      casterEntity:AddEffectHolder()
      effectCpmt = casterEntity:EffectHolder()
    end
    effectCpmt:AttachAudioID(self._audioID, playingID)
  elseif self._audioType == SkillAudioType.Voice then
    InnerGameHelperRender.InnerGamePlayPetVoid(self._audioID, casterEntity)
  end
end
