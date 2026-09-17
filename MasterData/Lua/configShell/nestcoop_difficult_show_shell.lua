local this = class("nestcoop_difficult_show_shell", G_BaseConfig)
local core = G_Tables.TDNestcoopDifficultShowTable.GetInstance()

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
  color = 2,
  bgIcon = 3,
  rewardwords = 4,
  name2 = 5,
  bossfilter = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("nestcoop_difficult_show", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getColor(offset)
  return core:GetVString(offset, this.indexMap.color).value
end

function this:_getBgicon(offset)
  local str = core:GetVString(offset, this.indexMap.bgIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRewardwords(offset)
  local langStr = G_TableMgrIns:GetLangStr("nestcoop_difficult_show", core:GetVString(offset, this.indexMap.rewardwords))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "rewardwords")
end

function this:_getName2(offset)
  local langStr = G_TableMgrIns:GetLangStr("nestcoop_difficult_show", core:GetVString(offset, this.indexMap.name2))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name2")
end

function this:_getBossfilter(offset)
  local str = core:GetVString(offset, this.indexMap.bossfilter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  color = this._getColor,
  bgIcon = this._getBgicon,
  rewardwords = this._getRewardwords,
  name2 = this._getName2,
  bossfilter = this._getBossfilter
}
return this
