local this = class("systemVoiceUnitruleTpl")

function this:init(config)
  self.data = config
  self.tableData = {}
  for i, v in pairs(self.data) do
    self.tableData[v.voiceKey] = v
  end
end

function this:getTplById(id)
  local res = self.data[id]
  if table.isEmpty(res) then
    errorf(string.format("%s没有配置", id))
  end
  return res
end

function this:getTplByKey(key)
  local res = self.tableData[key]
  if table.isEmpty(res) then
    errorf(string.format("%s没有配置", key))
  end
  return res
end

function this:getRuleType(tpl)
  return tpl.ruleType
end

function this:getEventType(tpl)
  return tpl.eventType
end

function this:getEventParameters(tpl)
  local parames = {}
  for i, v in pairs(tpl.eventParameter) do
    table.insert(parames, v)
  end
  return parames
end

function this:getTriggerProbability(tpl)
  return tpl.triggerProbability
end

function this:getTriggerProbability_Normalization(tpl)
  return tpl.triggerProbability / 10000.0
end

function this:getBlockTriggerDuration(tpl)
  return tpl.blockTriggerDuration
end

function this:getVoiceTagType(tpl)
  return tpl.VoiceTagType
end

function this:getVoiceTags(tpl)
  return tpl.VoiceTag
end

function this:getVoiceGroup(tpl)
  return tpl.VoiceGroup
end

function this:getVoiceIds(tpl)
  return tpl.VoiceId
end

function this:getVoiceId(tpl, index)
  return tpl.VoiceId[index]
end

function this:getVoiceTime(tpl)
  return tpl.VoiceTime
end

function this:getPriority(tpl)
  return tpl.priority
end

function this:getText(tpl)
  return tpl.text
end

function this:voiceIdProvider(voiceId, paras)
  L_Config:providerLua(voiceId, paras)
end

return this
