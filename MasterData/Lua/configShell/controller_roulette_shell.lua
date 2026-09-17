local this = class("controller_roulette_shell", G_BaseConfig)
local core = G_Tables.TDControllerRouletteTable.GetInstance()

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
  name = 2,
  icon = 3,
  shortcut_key = 4,
  target_page = 5,
  default_wheel_slot = 6,
  system_enum = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("controller_roulette", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getShortcut_key(offset)
  return core:GetVString(offset, this.indexMap.shortcut_key).value
end

function this:_getTarget_page(offset)
  return core:GetVString(offset, this.indexMap.target_page).value
end

function this:_getDefault_wheel_slot(offset)
  return core:GetInt(offset, this.indexMap.default_wheel_slot)
end

function this:_getSystem_enum(offset)
  return core:GetInt(offset, this.indexMap.system_enum)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  name = this._getName,
  icon = this._getIcon,
  shortcut_key = this._getShortcut_key,
  target_page = this._getTarget_page,
  default_wheel_slot = this._getDefault_wheel_slot,
  system_enum = this._getSystem_enum
}
return this
