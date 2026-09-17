local this = class("mall_shop_giftpack_login_shell", G_BaseConfig)
local core = G_Tables.TDMallShopGiftpackLoginTable.GetInstance()

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
  day = 2,
  reward = 3,
  showItem = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getDay(offset)
  return core:GetInt(offset, this.indexMap.day)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getShowitem(offset)
  local str = core:GetVString(offset, this.indexMap.showItem).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  day = this._getDay,
  reward = this._getReward,
  showItem = this._getShowitem
}
return this
