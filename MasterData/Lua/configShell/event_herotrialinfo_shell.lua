local this = class("event_herotrialinfo_shell", G_BaseConfig)
local core = G_Tables.TDEventHerotrialinfoTable.GetInstance()

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
  heroId = 1,
  heroParty = 2,
  heroBattle = 3,
  heroReward = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getHeroparty(offset)
  local str = core:GetVString(offset, this.indexMap.heroParty).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHerobattle(offset)
  local str = core:GetVString(offset, this.indexMap.heroBattle).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHeroreward(offset)
  local str = core:GetVString(offset, this.indexMap.heroReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  heroId = this._getHeroid,
  heroParty = this._getHeroparty,
  heroBattle = this._getHerobattle,
  heroReward = this._getHeroreward
}
return this
