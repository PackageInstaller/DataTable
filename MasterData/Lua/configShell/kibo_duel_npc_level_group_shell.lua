local this = class("kibo_duel_npc_level_group_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelNpcLevelGroupTable.GetInstance()

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
  levelGroup = 1,
  npcHeadIcon = 2,
  area = 3,
  npcTitle = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLevelgroup(offset)
  local str = core:GetVString(offset, this.indexMap.levelGroup).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNpcheadicon(offset)
  local str = core:GetVString(offset, this.indexMap.npcHeadIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getArea(offset)
  return core:GetInt(offset, this.indexMap.area)
end

function this:_getNpctitle(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("kibo_duel_npc_level_group", core:GetVString(offset, this.indexMap.npcTitle))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "kibo_duel_npc_level_group")
end

this.keyToMethodsMap = {
  id = this._getId,
  levelGroup = this._getLevelgroup,
  npcHeadIcon = this._getNpcheadicon,
  area = this._getArea,
  npcTitle = this._getNpctitle
}
return this
