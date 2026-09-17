local this = class("game_events_cul_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {
  Id = 0,
  trainingDayNum1 = 1,
  trial1 = 2,
  trainingDayNum2 = 3,
  trial2 = 4,
  trainingDayNum3 = 5,
  trial3 = 6,
  actionCount = 7,
  expeditionCount = 8,
  defaultStamina = 9,
  maxStamina = 10,
  defaultMood = 11,
  maxAttr = 12,
  failModifier = 13,
  successModifier = 14,
  greatSuccessModifier = 15,
  timeline = 16,
  scene = 17,
  endless = 18,
  defaulthero = 19,
  herointerimid = 20,
  petinterimid = 21
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getTrainingdaynum1(offset)
  return core:GetInt(offset, this.indexMap.trainingDayNum1)
end

function this:_getTrial1(offset)
  local str = core:GetVString(offset, this.indexMap.trial1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTrainingdaynum2(offset)
  return core:GetInt(offset, this.indexMap.trainingDayNum2)
end

function this:_getTrial2(offset)
  local str = core:GetVString(offset, this.indexMap.trial2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTrainingdaynum3(offset)
  return core:GetInt(offset, this.indexMap.trainingDayNum3)
end

function this:_getTrial3(offset)
  local str = core:GetVString(offset, this.indexMap.trial3).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getActioncount(offset)
  return core:GetInt(offset, this.indexMap.actionCount)
end

function this:_getExpeditioncount(offset)
  return core:GetInt(offset, this.indexMap.expeditionCount)
end

function this:_getDefaultstamina(offset)
  return core:GetInt(offset, this.indexMap.defaultStamina)
end

function this:_getMaxstamina(offset)
  return core:GetInt(offset, this.indexMap.maxStamina)
end

function this:_getDefaultmood(offset)
  return core:GetInt(offset, this.indexMap.defaultMood)
end

function this:_getMaxattr(offset)
  return core:GetInt(offset, this.indexMap.maxAttr)
end

function this:_getFailmodifier(offset)
  return core:GetInt(offset, this.indexMap.failModifier)
end

function this:_getSuccessmodifier(offset)
  return core:GetInt(offset, this.indexMap.successModifier)
end

function this:_getGreatsuccessmodifier(offset)
  return core:GetInt(offset, this.indexMap.greatSuccessModifier)
end

function this:_getTimeline(offset)
  return core:GetVString(offset, this.indexMap.timeline).value
end

function this:_getScene(offset)
  return core:GetVString(offset, this.indexMap.scene).value
end

function this:_getEndless(offset)
  return core:GetInt(offset, this.indexMap.endless)
end

function this:_getDefaulthero(offset)
  return core:GetInt(offset, this.indexMap.defaulthero)
end

function this:_getHerointerimid(offset)
  local str = core:GetVString(offset, this.indexMap.herointerimid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetinterimid(offset)
  local str = core:GetVString(offset, this.indexMap.petinterimid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  Id = this._getId,
  trainingDayNum1 = this._getTrainingdaynum1,
  trial1 = this._getTrial1,
  trainingDayNum2 = this._getTrainingdaynum2,
  trial2 = this._getTrial2,
  trainingDayNum3 = this._getTrainingdaynum3,
  trial3 = this._getTrial3,
  actionCount = this._getActioncount,
  expeditionCount = this._getExpeditioncount,
  defaultStamina = this._getDefaultstamina,
  maxStamina = this._getMaxstamina,
  defaultMood = this._getDefaultmood,
  maxAttr = this._getMaxattr,
  failModifier = this._getFailmodifier,
  successModifier = this._getSuccessmodifier,
  greatSuccessModifier = this._getGreatsuccessmodifier,
  timeline = this._getTimeline,
  scene = this._getScene,
  endless = this._getEndless,
  defaulthero = this._getDefaulthero,
  herointerimid = this._getHerointerimid,
  petinterimid = this._getPetinterimid
}
return this
