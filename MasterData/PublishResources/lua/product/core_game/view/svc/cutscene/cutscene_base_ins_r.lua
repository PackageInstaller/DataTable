_class("CutsceneBaseInstruction", Object)
CutsceneBaseInstruction = CutsceneBaseInstruction

function CutsceneBaseInstruction:Constructor(params)
  self._label = params.label
end

function CutsceneBaseInstruction:GetInstructionType()
end

function CutsceneBaseInstruction:GetInstructionLabel()
  return self._label
end

function CutsceneBaseInstruction:DoInstruction(TT, phaseContext)
end

function CutsceneBaseInstruction:GetCacheResource()
end

function CutsceneBaseInstruction:GetCacheAudio()
end

function CutsceneBaseInstruction:GetCacheVoice()
end

function CutsceneBaseInstruction:GetCutsceneID()
  return 0
end

function CutsceneBaseInstruction:GetEffectResCacheInfo(effectID, count)
  count = count or 1
  if not effectID then
    return nil
  end
  if not Cfg.cfg_effect[effectID] then
    Log.exception(self._className, "effectID not found: ", tostring(effectID))
    return nil
  end
  local resPath = Cfg.cfg_effect[effectID].ResPath
  if not ResourceManager:GetInstance():HasResource(resPath) then
    Log.exception(self._className, "res not found: ", tostring(resPath))
    return nil
  end
  return {resPath, count}
end
