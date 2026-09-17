local this = class("battle_pass_resource_shell", G_BaseConfig)
local core = G_Tables.TDBattlePassResourceTable.GetInstance()

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
  backgroundPic = 2,
  backgroundSPPic = 3,
  notselectPic = 4,
  selectPic = 5,
  optionPic = 6,
  soulessenceId = 7,
  Isdark = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getBackgroundpic(offset)
  local str = core:GetVString(offset, this.indexMap.backgroundPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getBackgroundsppic(offset)
  local str = core:GetVString(offset, this.indexMap.backgroundSPPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getNotselectpic(offset)
  local str = core:GetVString(offset, this.indexMap.notselectPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSelectpic(offset)
  local str = core:GetVString(offset, this.indexMap.selectPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getOptionpic(offset)
  local str = core:GetVString(offset, this.indexMap.optionPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSoulessenceid(offset)
  return core:GetInt(offset, this.indexMap.soulessenceId)
end

function this:_getIsdark(offset)
  return core:GetInt(offset, this.indexMap.Isdark)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  backgroundPic = this._getBackgroundpic,
  backgroundSPPic = this._getBackgroundsppic,
  notselectPic = this._getNotselectpic,
  selectPic = this._getSelectpic,
  optionPic = this._getOptionpic,
  soulessenceId = this._getSoulessenceid,
  Isdark = this._getIsdark
}
return this
