local this = class("pet_feed_shell", G_BaseConfig)
local core = G_Tables.TDPetFeedTable.GetInstance()

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
  intimity = 1,
  vigilant = 2,
  favorite = 3,
  dislike = 4,
  keyPoint = 5,
  dropId = 6,
  favoriteAnswer = 7,
  normalAnswer = 8,
  dislikeAnswer = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getIntimity(offset)
  return core:GetInt(offset, this.indexMap.intimity)
end

function this:_getVigilant(offset)
  return core:GetInt(offset, this.indexMap.vigilant)
end

function this:_getFavorite(offset)
  local str = core:GetVString(offset, this.indexMap.favorite).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDislike(offset)
  local str = core:GetVString(offset, this.indexMap.dislike).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getKeypoint(offset)
  local str = core:GetVString(offset, this.indexMap.keyPoint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDropid(offset)
  return core:GetInt(offset, this.indexMap.dropId)
end

function this:_getFavoriteanswer(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_feed", core:GetVString(offset, this.indexMap.favoriteAnswer))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "favoriteAnswer")
end

function this:_getNormalanswer(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_feed", core:GetVString(offset, this.indexMap.normalAnswer))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "normalAnswer")
end

function this:_getDislikeanswer(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_feed", core:GetVString(offset, this.indexMap.dislikeAnswer))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "dislikeAnswer")
end

this.keyToMethodsMap = {
  id = this._getId,
  intimity = this._getIntimity,
  vigilant = this._getVigilant,
  favorite = this._getFavorite,
  dislike = this._getDislike,
  keyPoint = this._getKeypoint,
  dropId = this._getDropid,
  favoriteAnswer = this._getFavoriteanswer,
  normalAnswer = this._getNormalanswer,
  dislikeAnswer = this._getDislikeanswer
}
return this
