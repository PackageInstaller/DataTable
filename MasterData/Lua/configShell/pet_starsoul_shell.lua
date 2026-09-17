local this = class("pet_starsoul_shell", G_BaseConfig)
local core = G_Tables.TDPetStarsoulTable.GetInstance()

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
  templateId = 1,
  group = 2,
  node = 3,
  type = 4,
  unlockCondition = 5,
  item = 6,
  kiboItemNum = 7,
  attrParam = 8,
  attrSumParam = 9,
  skillParam = 10,
  skillSumParam = 11,
  itemReturn = 12,
  kiboItemReturn = 13
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTemplateid(offset)
  return core:GetInt(offset, this.indexMap.templateId)
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getNode(offset)
  return core:GetInt(offset, this.indexMap.node)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getItem(offset)
  local str = core:GetVString(offset, this.indexMap.item).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getKiboitemnum(offset)
  return core:GetInt(offset, this.indexMap.kiboItemNum)
end

function this:_getAttrparam(offset)
  local str = core:GetVString(offset, this.indexMap.attrParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getAttrsumparam(offset)
  local str = core:GetVString(offset, this.indexMap.attrSumParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getSkillparam(offset)
  return core:GetInt(offset, this.indexMap.skillParam)
end

function this:_getSkillsumparam(offset)
  return core:GetInt(offset, this.indexMap.skillSumParam)
end

function this:_getItemreturn(offset)
  local str = core:GetVString(offset, this.indexMap.itemReturn).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getKiboitemreturn(offset)
  return core:GetInt(offset, this.indexMap.kiboItemReturn)
end

this.keyToMethodsMap = {
  id = this._getId,
  templateId = this._getTemplateid,
  group = this._getGroup,
  node = this._getNode,
  type = this._getType,
  unlockCondition = this._getUnlockcondition,
  item = this._getItem,
  kiboItemNum = this._getKiboitemnum,
  attrParam = this._getAttrparam,
  attrSumParam = this._getAttrsumparam,
  skillParam = this._getSkillparam,
  skillSumParam = this._getSkillsumparam,
  itemReturn = this._getItemreturn,
  kiboItemReturn = this._getKiboitemreturn
}
return this
