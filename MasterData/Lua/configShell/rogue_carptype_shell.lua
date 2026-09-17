local this = class("rogue_carptype_shell", G_BaseConfig)
local core = G_Tables.TDRogueCarptypeTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, littleicon = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLittleicon(offset)
  local str = core:GetVString(offset, this.indexMap.littleicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  littleicon = this._getLittleicon
}
return this
