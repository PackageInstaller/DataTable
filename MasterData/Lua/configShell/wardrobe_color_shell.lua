local this = class("wardrobe_color_shell", G_BaseConfig)
local core = G_Tables.TDWardrobeColorTable.GetInstance()

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
  wardrobe_color = 2,
  icon_color = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  return core:GetVString(offset, this.indexMap.name).value
end

function this:_getWardrobe_color(offset)
  return core:GetVString(offset, this.indexMap.wardrobe_color).value
end

function this:_getIcon_color(offset)
  return core:GetVString(offset, this.indexMap.icon_color).value
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  wardrobe_color = this._getWardrobe_color,
  icon_color = this._getIcon_color
}
return this
