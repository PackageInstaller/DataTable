local this = class("fight_lose_buttons_shell", G_BaseConfig)
local core = G_Tables.TDFightLoseButtonsTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, common_jump = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCommon_jump(offset)
  local str = core:GetVString(offset, this.indexMap.common_jump).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  common_jump = this._getCommon_jump
}
return this
