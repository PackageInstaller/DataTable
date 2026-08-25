local GuideCfgUtils = {}

function GuideCfgUtils.GetGuideCfgByTriggerState(triggerState)
  for _, tbl in pairs(DT.GuideConfig) do
    for _, guideCfg in pairs(tbl.data_list) do
      if guideCfg.TriggerState == triggerState then
        return guideCfg
      end
    end
  end
  return nil
end

return GuideCfgUtils
