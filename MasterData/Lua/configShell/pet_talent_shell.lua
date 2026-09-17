local this = class("pet_talent_shell", G_BaseConfig)
local core = G_Tables.TDPetTalentTable.GetInstance()

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
  grade = 1,
  pixelIcon = 2,
  icon = 3,
  nameBg = 4,
  petPixelBase = 5,
  filterContentId = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGrade(offset)
  local str = core:GetVString(offset, this.indexMap.grade).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPixelicon(offset)
  local str = core:GetVString(offset, this.indexMap.pixelIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getNamebg(offset)
  local str = core:GetVString(offset, this.indexMap.nameBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPetpixelbase(offset)
  local str = core:GetVString(offset, this.indexMap.petPixelBase).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getFiltercontentid(offset)
  return core:GetInt(offset, this.indexMap.filterContentId)
end

this.keyToMethodsMap = {
  id = this._getId,
  grade = this._getGrade,
  pixelIcon = this._getPixelicon,
  icon = this._getIcon,
  nameBg = this._getNamebg,
  petPixelBase = this._getPetpixelbase,
  filterContentId = this._getFiltercontentid
}
return this
