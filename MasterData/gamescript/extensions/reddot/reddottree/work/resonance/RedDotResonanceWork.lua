local RedDotResonanceWork, Super = System.NewPoolClass("RedDotResonanceWork", RedDotSingleFlow)

function RedDotResonanceWork:ctor(args)
  Super.ctor(self, "共鸣点")
  self.resonanceTid = args.resonanceTid
  self.useExtraItem = args.useExtraItem
end

function RedDotResonanceWork:Execute()
  local resonance = ResonanceDataUtils.GetResonance(self.resonanceTid)
  if not resonance or resonance.isDefaultActiveResonace then
    return false
  end
  local resonanceCfg = DT.Resonance[self.resonanceTid]
  local resonanceGroupId = resonanceCfg.BelongGroup
  if ResonanceDataUtils.IsResonanceGroupDataInited(resonanceGroupId) == false then
    ResonanceDataUtils.ReqResonanceData(resonanceGroupId)
    return false
  end
  do return ResonanceDataUtils.IsResonanceUpgradeable, self.resonanceTid end
  return ResonanceDataUtils.IsResonanceUpgradeable, self.resonanceTid, true
end

return RedDotResonanceWork
