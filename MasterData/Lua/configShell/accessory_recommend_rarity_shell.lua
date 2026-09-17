local this = class("accessory_recommend_rarity_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryRecommendRarityTable.GetInstance()

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
  player_lv = 1,
  recommend_rarity = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPlayer_lv(offset)
  local str = core:GetVString(offset, this.indexMap.player_lv).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRecommend_rarity(offset)
  local str = core:GetVString(offset, this.indexMap.recommend_rarity).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  player_lv = this._getPlayer_lv,
  recommend_rarity = this._getRecommend_rarity
}
return this
