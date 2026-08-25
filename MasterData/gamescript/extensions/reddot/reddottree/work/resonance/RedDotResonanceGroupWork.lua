local RedDotResonanceGroupWork, Super = System.NewPoolClass("RedDotResonanceGroupWork", RedDotOrFlow)

function RedDotResonanceGroupWork:ctor(args)
  Super.ctor(self, "共鸣组")
  self.resonanceGroupTid = args.resonanceGroupTid
end

function RedDotResonanceGroupWork:Execute()
  local resonanceGroupId = self.resonanceGroupTid
  if not resonanceGroupId then
    return false
  end
  if ResonanceDataUtils.IsResonanceGroupDataInited(resonanceGroupId) == false then
    ResonanceDataUtils.ReqResonanceData(resonanceGroupId)
    return false
  end
  do return Super.Execute end
  return Super.Execute, self
end

return RedDotResonanceGroupWork
