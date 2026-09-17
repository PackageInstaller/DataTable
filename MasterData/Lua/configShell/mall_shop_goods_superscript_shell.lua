local this = class("mall_shop_goods_superscript_shell", G_BaseConfig)
local core = G_Tables.TDMallShopGoodsSuperscriptTable.GetInstance()

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
  desc = 1,
  seconddesc = 2,
  boardPic = 3,
  boardColor = 4,
  fontMaterial = 5,
  animationSwitch = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_shop_goods_superscript", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getSeconddesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_shop_goods_superscript", core:GetVString(offset, this.indexMap.seconddesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "seconddesc")
end

function this:_getBoardpic(offset)
  local str = core:GetVString(offset, this.indexMap.boardPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBoardcolor(offset)
  return core:GetVString(offset, this.indexMap.boardColor).value
end

function this:_getFontmaterial(offset)
  return core:GetInt(offset, this.indexMap.fontMaterial)
end

function this:_getAnimationswitch(offset)
  return core:GetInt(offset, this.indexMap.animationSwitch)
end

this.keyToMethodsMap = {
  id = this._getId,
  desc = this._getDesc,
  seconddesc = this._getSeconddesc,
  boardPic = this._getBoardpic,
  boardColor = this._getBoardcolor,
  fontMaterial = this._getFontmaterial,
  animationSwitch = this._getAnimationswitch
}
return this
