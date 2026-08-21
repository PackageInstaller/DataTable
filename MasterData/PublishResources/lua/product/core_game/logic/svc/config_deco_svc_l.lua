_class("ConfigDecorationRecord", Object)
ConfigDecorationRecord = ConfigDecorationRecord

function ConfigDecorationRecord:Constructor(buffSeqID, entityID, skillID, effectIndex)
  self._buffSeqID = buffSeqID
  self._entityID = entityID
  self._skillID = skillID
  self._effectIndex = effectIndex
  self._decorationSequence = {}
  self._skillDic = {}
end

function ConfigDecorationRecord:GetBuffSeqID()
  return self._buffSeqID
end

function ConfigDecorationRecord:NoteDecoration(key, old, new)
  table.insert(self._decorationSequence, {
    key = key,
    old = old,
    new = new
  })
end

function ConfigDecorationRecord:Do(effectTable)
  for i = 1, #self._decorationSequence do
    local t = self._decorationSequence[i]
    local key = t.key
    local new = t.new
    effectTable[key] = new
  end
end

function ConfigDecorationRecord:Undo(effectTable)
  for i = #self._decorationSequence, 1, -1 do
    local t = self._decorationSequence[i]
    local key = t.key
    local old = t.old
    effectTable[key] = old
  end
end

_class("ConfigDecorationService", BaseService)
ConfigDecorationService = ConfigDecorationService

function ConfigDecorationService:Constructor()
  self._effectTableCache = {}
  self._effectParamParser = SkillEffectParamParser:New()
end

function ConfigDecorationService:Error(...)
  Log.error(self._className, ...)
end

function ConfigDecorationService:Exception(...)
  Log.exception(self._className, ...)
end

function ConfigDecorationService:DecorateSkillEffect(buffSeqID, entity, skillID, effectIndex, append, set, remove, appendArray)
  local casterEntityID = entity:GetID()
  local effectTable = self:FindDecoratedEffectTable(casterEntityID, skillID, effectIndex)
  if not effectTable then
    local configsvc = self._world:GetService("Config")
    local cfgSkill = configsvc:GetSkillConfigData(skillID)
    local metaArray = cfgSkill:GetMetaEffectTableArray()
    effectTable = table.cloneconf(metaArray[effectIndex])
  end
  if not effectTable then
    self:Error("No base EffectTable found: ", skillID, effectIndex)
    return
  end
  local record = ConfigDecorationRecord:New(buffSeqID, casterEntityID, skillID, effectIndex)
  for key, value in pairs(append) do
    if not effectTable[key] then
      self:Exception("append only works when there is a base value: ", skillID, effectIndex, key)
    else
      record:NoteDecoration(key, effectTable[key], effectTable[key] + value)
    end
  end
  for key, value in pairs(set) do
    record:NoteDecoration(key, effectTable[key], value)
  end
  for _, key in ipairs(remove) do
    record:NoteDecoration(key, effectTable[key], nil)
  end
  for key, appender in pairs(appendArray) do
    if not effectTable[key] then
      self:Exception("appendArray only works when there is a base value: ", skillID, effectIndex, key)
    else
      local cloned = {}
      for k, v in pairs(effectTable[key]) do
        cloned[k] = v
      end
      for index, val in ipairs(appender) do
        cloned[index] = cloned[index] + val
      end
      record:NoteDecoration(key, effectTable[key], cloned)
    end
  end
  record:Do(effectTable)
  self:_SaveDecoratedEffectTable(casterEntityID, skillID, effectIndex, effectTable, record)
end

function ConfigDecorationService:_SaveDecoratedEffectTable(casterEntityID, skillID, effectIndex, effectTable, record)
  if not self._effectTableCache[casterEntityID] then
    self._effectTableCache[casterEntityID] = {}
  end
  if not self._effectTableCache[casterEntityID][skillID] then
    self._effectTableCache[casterEntityID][skillID] = {}
  end
  if not self._effectTableCache[casterEntityID][skillID][effectIndex] then
    self._effectTableCache[casterEntityID][skillID][effectIndex] = {
      record = {}
    }
  end
  local cache = self._effectTableCache[casterEntityID][skillID][effectIndex]
  cache.effectTable = effectTable
  table.insert(cache.record, record)
end

function ConfigDecorationService:GetSkillDecoration(casterEntityID, skillID)
  local eCaster = self._world:GetEntityByID(casterEntityID)
  if not eCaster then
    return nil
  end
  local entityEffectCache = self._effectTableCache[casterEntityID]
  if not entityEffectCache and eCaster:HasSuperEntity() and eCaster:EntityType():IsSkillHolder() then
    local superEntityID = eCaster:GetSuperEntity():GetID()
    entityEffectCache = self._effectTableCache[superEntityID]
  end
  if not entityEffectCache then
    return nil
  end
  local skillCache = entityEffectCache[skillID]
  return skillCache
end

function ConfigDecorationService:FindDecoratedCacheTable(casterEntityID, skillID, effectIndex)
  local skillCache = self:GetSkillDecoration(casterEntityID, skillID)
  if not skillCache then
    return nil
  end
  local effectCache = skillCache[effectIndex]
  if not effectCache then
    return nil
  end
  return effectCache
end

function ConfigDecorationService:FindDecoratedEffectTable(casterEntityID, skillID, effectIndex)
  local cacheTable = self:FindDecoratedCacheTable(casterEntityID, skillID, effectIndex)
  if not cacheTable then
    return nil
  end
  return cacheTable.effectTable
end

function ConfigDecorationService:GetLatestEffectParamArray(casterEntityID, skillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local cfgEffectArray = skillConfigData:GetSkillEffect()
  local skillDecoration = self:GetSkillDecoration(casterEntityID, skillID)
  if not skillDecoration then
    return cfgEffectArray
  end
  local skillType = skillConfigData:GetSkillType()
  local petId, grade, awakening
  local caster = self._world:GetEntityByID(casterEntityID)
  if caster:HasMatchPet() then
    local petData = caster:MatchPet():GetMatchPet()
    petId = petData:GetTemplateID()
    grade = petData:GetPetGrade()
    awakening = petData:GetPetAwakening()
  end
  local effectParamArray = {}
  for index, cfgEffectParam in ipairs(cfgEffectArray) do
    local effectDecoration = skillDecoration[index]
    if not effectDecoration then
      table.insert(effectParamArray, cfgEffectParam)
    else
      local latest = effectDecoration.effectTable
      local effectParam = self._effectParamParser:ParseSkillEffectParam(latest.effectType, latest, petId, index, skillType, grade, awakening)
      table.insert(effectParamArray, effectParam)
    end
  end
  return effectParamArray
end

function ConfigDecorationService:RevertSkillEffectDecoration(buffSeqID, casterID, skillID, effectIndex)
  local effectDecoration = self:FindDecoratedCacheTable(casterID, skillID, effectIndex)
  if not effectDecoration then
    return
  end
  local index, newEffectTable
  local count = #effectDecoration.record
  for i = count, 1, -1 do
    local record = effectDecoration.record[i]
    if record:GetBuffSeqID() == buffSeqID then
      record:Undo(effectDecoration.effectTable)
      index = i
      break
    end
  end
  if index then
    table.remove(effectDecoration.record, index)
  end
end

function ConfigDecorationService:RevertAllSkillEffectDecoration(casterID, skillID, effectIndex)
  local effectDecoration = self:FindDecoratedCacheTable(casterID, skillID, effectIndex)
  if not effectDecoration then
    return
  end
  for i = #effectDecoration.record, 1, -1 do
    local record = effectDecoration.record[i]
    record:Undo(effectDecoration.effectTable)
  end
  effectDecoration.record = {}
end

function ConfigDecorationService:GenerateSkillConfigData(skillID, replaceKeyValuePairs)
  local skillConfigHelper = self._world:GetService("Config")._skillConfigHelper
  local data = SkillConfigData:New(skillConfigHelper._scopeParamParser, skillConfigHelper._skillEffectParamParser, skillConfigHelper._skillViewParamParser, skillConfigHelper._skillPreviewParamParser)
  data:ParseSkillConfig(skillID)
  for k, v in pairs(replaceKeyValuePairs) do
    data[k] = v
  end
  return data
end
