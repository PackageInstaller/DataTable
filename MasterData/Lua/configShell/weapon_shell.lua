local this = class("weapon_shell", G_BaseConfig)
local core = G_Tables.TDWeaponTable.GetInstance()

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
  desc = 2,
  type = 3,
  rarity = 4,
  attribute = 5,
  weaponSkill = 6,
  weaponDefault = 7,
  weaponExp = 8,
  avatarCount = 9,
  avatar = 10,
  avatarTexture = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("weapon", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("weapon", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getAttribute(offset)
  return core:GetInt(offset, this.indexMap.attribute)
end

function this:_getWeaponskill(offset)
  return core:GetInt(offset, this.indexMap.weaponSkill)
end

function this:_getWeapondefault(offset)
  return core:GetInt(offset, this.indexMap.weaponDefault)
end

function this:_getWeaponexp(offset)
  return core:GetInt(offset, this.indexMap.weaponExp)
end

function this:_getAvatarcount(offset)
  return core:GetInt(offset, this.indexMap.avatarCount)
end

function this:_getAvatar(offset)
  local str = core:GetVString(offset, this.indexMap.avatar).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getAvatartexture(offset)
  local str = core:GetVString(offset, this.indexMap.avatarTexture).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 3)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  desc = this._getDesc,
  type = this._getType,
  rarity = this._getRarity,
  attribute = this._getAttribute,
  weaponSkill = this._getWeaponskill,
  weaponDefault = this._getWeapondefault,
  weaponExp = this._getWeaponexp,
  avatarCount = this._getAvatarcount,
  avatar = this._getAvatar,
  avatarTexture = this._getAvatartexture
}
return this
