local this = class("chat_emoji_shell", G_BaseConfig)
local core = G_Tables.TDChatEmojiTable.GetInstance()

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
  groupId = 1,
  frame = 2,
  resource = 3,
  name = 4,
  resourceParam = 5,
  way = 6,
  wayDesc = 7,
  isDefault = 8,
  desc = 9,
  specialDesc = 10,
  icon = 11,
  rarity = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getFrame(offset)
  return core:GetInt(offset, this.indexMap.frame)
end

function this:_getResource(offset)
  local str = core:GetVString(offset, this.indexMap.resource).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("chat_emoji", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getResourceparam(offset)
  local str = core:GetVString(offset, this.indexMap.resourceParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWay(offset)
  local str = core:GetVString(offset, this.indexMap.way).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWaydesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("chat_emoji", core:GetVString(offset, this.indexMap.wayDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "chat_emoji")
end

function this:_getIsdefault(offset)
  return core:GetInt(offset, this.indexMap.isDefault)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("chat_emoji", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getSpecialdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("chat_emoji", core:GetVString(offset, this.indexMap.specialDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "specialDesc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  frame = this._getFrame,
  resource = this._getResource,
  name = this._getName,
  resourceParam = this._getResourceparam,
  way = this._getWay,
  wayDesc = this._getWaydesc,
  isDefault = this._getIsdefault,
  desc = this._getDesc,
  specialDesc = this._getSpecialdesc,
  icon = this._getIcon,
  rarity = this._getRarity
}
return this
