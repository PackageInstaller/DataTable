local this = class("world_difficulty_shell", G_BaseConfig)
local core = G_Tables.TDWorldDifficultyTable.GetInstance()

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
  id = 0,
  name = 1,
  modifierName = 2,
  modifierTitle = 3,
  taskId = 4,
  note = 5,
  imgForeground = 6,
  imgBackground = 7,
  lockstargift = 8,
  lockskill = 9,
  lockSoulEssence = 10,
  lockpet = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_difficulty", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getModifiername(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_difficulty", core:GetVString(offset, this.indexMap.modifierName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "modifierName")
end

function this:_getModifiertitle(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("world_difficulty", core:GetVString(offset, this.indexMap.modifierTitle))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "world_difficulty")
end

function this:_getTaskid(offset)
  return core:GetInt(offset, this.indexMap.taskId)
end

function this:_getNote(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_difficulty", core:GetVString(offset, this.indexMap.note))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "note")
end

function this:_getImgforeground(offset)
  local str = core:GetVString(offset, this.indexMap.imgForeground).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getImgbackground(offset)
  local str = core:GetVString(offset, this.indexMap.imgBackground).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getLockstargift(offset)
  return core:GetInt(offset, this.indexMap.lockstargift)
end

function this:_getLockskill(offset)
  return core:GetInt(offset, this.indexMap.lockskill)
end

function this:_getLocksoulessence(offset)
  return core:GetInt(offset, this.indexMap.lockSoulEssence)
end

function this:_getLockpet(offset)
  return core:GetInt(offset, this.indexMap.lockpet)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  modifierName = this._getModifiername,
  modifierTitle = this._getModifiertitle,
  taskId = this._getTaskid,
  note = this._getNote,
  imgForeground = this._getImgforeground,
  imgBackground = this._getImgbackground,
  lockstargift = this._getLockstargift,
  lockskill = this._getLockskill,
  lockSoulEssence = this._getLocksoulessence,
  lockpet = this._getLockpet
}
return this
