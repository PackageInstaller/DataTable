local this = class("explore_type_shell", G_BaseConfig)
local core = G_Tables.TDExploreTypeTable.GetInstance()

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
  introducetext = 1,
  Exploreimage = 2,
  desctext = 3,
  ExploreIcon = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getIntroducetext(offset)
  local langStr = G_TableMgrIns:GetLangStr("explore_type", core:GetVString(offset, this.indexMap.introducetext))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "introducetext")
end

function this:_getExploreimage(offset)
  return core:GetVString(offset, this.indexMap.Exploreimage).value
end

function this:_getDesctext(offset)
  local langStr = G_TableMgrIns:GetLangStr("explore_type", core:GetVString(offset, this.indexMap.desctext))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desctext")
end

function this:_getExploreicon(offset)
  return core:GetVString(offset, this.indexMap.ExploreIcon).value
end

this.keyToMethodsMap = {
  id = this._getId,
  introducetext = this._getIntroducetext,
  Exploreimage = this._getExploreimage,
  desctext = this._getDesctext,
  ExploreIcon = this._getExploreicon
}
return this
