local this = class("guide_pic_shell", G_BaseConfig)
local core = G_Tables.TDGuidePicTable.GetInstance()

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
  title = 2,
  icon = 3,
  phoneIcon = 4,
  gameConsoleIcon = 5,
  video = 6,
  desc = 7,
  phoneDesc = 8,
  gameDesc = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getTitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("guide_pic", core:GetVString(offset, this.indexMap.title))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "title")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPhoneicon(offset)
  local str = core:GetVString(offset, this.indexMap.phoneIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getGameconsoleicon(offset)
  local str = core:GetVString(offset, this.indexMap.gameConsoleIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getVideo(offset)
  local str = core:GetVString(offset, this.indexMap.video).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("guide_pic", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getPhonedesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("guide_pic", core:GetVString(offset, this.indexMap.phoneDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "phoneDesc")
end

function this:_getGamedesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("guide_pic", core:GetVString(offset, this.indexMap.gameDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "gameDesc")
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  title = this._getTitle,
  icon = this._getIcon,
  phoneIcon = this._getPhoneicon,
  gameConsoleIcon = this._getGameconsoleicon,
  video = this._getVideo,
  desc = this._getDesc,
  phoneDesc = this._getPhonedesc,
  gameDesc = this._getGamedesc
}
return this
