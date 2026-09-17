local this = class("task_item_shell", G_BaseConfig)
local core = G_Tables.TDTaskItemTable.GetInstance()

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
  desc = 2,
  specialDesc = 3,
  icon = 4,
  rarity = 5,
  inBag = 6,
  tag = 7,
  maxNum = 8,
  stackNum = 9,
  existType = 10,
  existNum = 11,
  useType = 12,
  bagType = 13,
  canUse = 14
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_item", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_item", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getSpecialdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_item", core:GetVString(offset, this.indexMap.specialDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "specialDesc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getInbag(offset)
  return core:GetInt(offset, this.indexMap.inBag)
end

function this:_getTag(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("task_item", core:GetVString(offset, this.indexMap.tag))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "task_item")
end

function this:_getMaxnum(offset)
  return core:GetInt(offset, this.indexMap.maxNum)
end

function this:_getStacknum(offset)
  return core:GetInt(offset, this.indexMap.stackNum)
end

function this:_getExisttype(offset)
  return core:GetInt(offset, this.indexMap.existType)
end

function this:_getExistnum(offset)
  return core:GetInt(offset, this.indexMap.existNum)
end

function this:_getUsetype(offset)
  return core:GetInt(offset, this.indexMap.useType)
end

function this:_getBagtype(offset)
  return core:GetInt(offset, this.indexMap.bagType)
end

function this:_getCanuse(offset)
  return core:GetInt(offset, this.indexMap.canUse)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  desc = this._getDesc,
  specialDesc = this._getSpecialdesc,
  icon = this._getIcon,
  rarity = this._getRarity,
  inBag = this._getInbag,
  tag = this._getTag,
  maxNum = this._getMaxnum,
  stackNum = this._getStacknum,
  existType = this._getExisttype,
  existNum = this._getExistnum,
  useType = this._getUsetype,
  bagType = this._getBagtype,
  canUse = this._getCanuse
}
return this
