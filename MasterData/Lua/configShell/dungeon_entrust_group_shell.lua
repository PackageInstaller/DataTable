local this = class("dungeon_entrust_group_shell", G_BaseConfig)
local core = G_Tables.TDDungeonEntrustGroupTable.GetInstance()

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
  chpname = 1,
  name = 2,
  unlock = 3,
  taskShow = 4,
  sortId = 5,
  prefeb = 6,
  dungeonPic = 7,
  titlePic = 8,
  textColor = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getChpname(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_entrust_group", core:GetVString(offset, this.indexMap.chpname))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "chpname")
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_entrust_group", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getUnlock(offset)
  local str = core:GetVString(offset, this.indexMap.unlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTaskshow(offset)
  local str = core:GetVString(offset, this.indexMap.taskShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSortid(offset)
  return core:GetInt(offset, this.indexMap.sortId)
end

function this:_getPrefeb(offset)
  return core:GetVString(offset, this.indexMap.prefeb).value
end

function this:_getDungeonpic(offset)
  local str = core:GetVString(offset, this.indexMap.dungeonPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTitlepic(offset)
  local str = core:GetVString(offset, this.indexMap.titlePic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTextcolor(offset)
  return core:GetVString(offset, this.indexMap.textColor).value
end

this.keyToMethodsMap = {
  id = this._getId,
  chpname = this._getChpname,
  name = this._getName,
  unlock = this._getUnlock,
  taskShow = this._getTaskshow,
  sortId = this._getSortid,
  prefeb = this._getPrefeb,
  dungeonPic = this._getDungeonpic,
  titlePic = this._getTitlepic,
  textColor = this._getTextcolor
}
return this
