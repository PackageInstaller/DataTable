local this = class("item_reward_form_shell", G_BaseConfig)
local core = G_Tables.TDItemRewardFormTable.GetInstance()

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
  type = 1,
  subtype = 2,
  form = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getSubtype(offset)
  local str = core:GetVString(offset, this.indexMap.subtype).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getForm(offset)
  return core:GetInt(offset, this.indexMap.form)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  subtype = this._getSubtype,
  form = this._getForm
}
return this
