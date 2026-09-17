local this = class("pet_catchitem_shell", G_BaseConfig)
local core = G_Tables.TDPetCatchitemTable.GetInstance()

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
  type = 0,
  rarityOrder = 1,
  catchModulus = 2,
  cardBgImg = 3,
  StarColorProb = 4,
  StarColorParam = 5,
  FlashProb = 6,
  FlashDna = 7,
  normalStartNum = 8,
  eliteStartNum = 9,
  bossStartNum = 10,
  normalUpRate = 11,
  eliteUpRate = 12,
  bossUpRate = 13,
  normalGuaranteeNum = 14,
  eliteGuaranteeNum = 15,
  bossGuaranteeNum = 16,
  catchCardEffectMediaPackName = 17,
  catchBulletEffectMediaPackName = 18,
  catchBulletEffectAudioPackName = 19,
  catchBulletHitEffectMediaPackName = 20,
  catchBulletHitEffectAudioPackName = 21,
  catchBulletEffectBackMediaPackName = 22,
  catchStarlinkCatchMediaPackName = 23,
  catchStarlinkWaitingMediaPackName = 24,
  catchStarlinkVictoryMediaPackName = 25,
  catchStarlinkDefeatMediaPackName = 26,
  catchStarlinkVictoryFadeMediaPackName = 27
}

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getRarityorder(offset)
  return core:GetInt(offset, this.indexMap.rarityOrder)
end

function this:_getCatchmodulus(offset)
  return core:GetInt(offset, this.indexMap.catchModulus)
end

function this:_getCardbgimg(offset)
  local str = core:GetVString(offset, this.indexMap.cardBgImg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getStarcolorprob(offset)
  return core:GetInt(offset, this.indexMap.StarColorProb)
end

function this:_getStarcolorparam(offset)
  local str = core:GetVString(offset, this.indexMap.StarColorParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getFlashprob(offset)
  return core:GetInt(offset, this.indexMap.FlashProb)
end

function this:_getFlashdna(offset)
  local str = core:GetVString(offset, this.indexMap.FlashDna).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getNormalstartnum(offset)
  local str = core:GetVString(offset, this.indexMap.normalStartNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getElitestartnum(offset)
  local str = core:GetVString(offset, this.indexMap.eliteStartNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBossstartnum(offset)
  local str = core:GetVString(offset, this.indexMap.bossStartNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNormaluprate(offset)
  local str = core:GetVString(offset, this.indexMap.normalUpRate).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEliteuprate(offset)
  local str = core:GetVString(offset, this.indexMap.eliteUpRate).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBossuprate(offset)
  local str = core:GetVString(offset, this.indexMap.bossUpRate).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNormalguaranteenum(offset)
  local str = core:GetVString(offset, this.indexMap.normalGuaranteeNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEliteguaranteenum(offset)
  local str = core:GetVString(offset, this.indexMap.eliteGuaranteeNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBossguaranteenum(offset)
  local str = core:GetVString(offset, this.indexMap.bossGuaranteeNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCatchcardeffectmediapackname(offset)
  return core:GetVString(offset, this.indexMap.catchCardEffectMediaPackName).value
end

function this:_getCatchbulleteffectmediapackname(offset)
  return core:GetVString(offset, this.indexMap.catchBulletEffectMediaPackName).value
end

function this:_getCatchbulleteffectaudiopackname(offset)
  return core:GetVString(offset, this.indexMap.catchBulletEffectAudioPackName).value
end

function this:_getCatchbullethiteffectmediapackname(offset)
  return core:GetVString(offset, this.indexMap.catchBulletHitEffectMediaPackName).value
end

function this:_getCatchbullethiteffectaudiopackname(offset)
  return core:GetVString(offset, this.indexMap.catchBulletHitEffectAudioPackName).value
end

function this:_getCatchbulleteffectbackmediapackname(offset)
  return core:GetVString(offset, this.indexMap.catchBulletEffectBackMediaPackName).value
end

function this:_getCatchstarlinkcatchmediapackname(offset)
  return core:GetVString(offset, this.indexMap.catchStarlinkCatchMediaPackName).value
end

function this:_getCatchstarlinkwaitingmediapackname(offset)
  return core:GetVString(offset, this.indexMap.catchStarlinkWaitingMediaPackName).value
end

function this:_getCatchstarlinkvictorymediapackname(offset)
  return core:GetVString(offset, this.indexMap.catchStarlinkVictoryMediaPackName).value
end

function this:_getCatchstarlinkdefeatmediapackname(offset)
  return core:GetVString(offset, this.indexMap.catchStarlinkDefeatMediaPackName).value
end

function this:_getCatchstarlinkvictoryfademediapackname(offset)
  return core:GetVString(offset, this.indexMap.catchStarlinkVictoryFadeMediaPackName).value
end

this.keyToMethodsMap = {
  type = this._getType,
  rarityOrder = this._getRarityorder,
  catchModulus = this._getCatchmodulus,
  cardBgImg = this._getCardbgimg,
  StarColorProb = this._getStarcolorprob,
  StarColorParam = this._getStarcolorparam,
  FlashProb = this._getFlashprob,
  FlashDna = this._getFlashdna,
  normalStartNum = this._getNormalstartnum,
  eliteStartNum = this._getElitestartnum,
  bossStartNum = this._getBossstartnum,
  normalUpRate = this._getNormaluprate,
  eliteUpRate = this._getEliteuprate,
  bossUpRate = this._getBossuprate,
  normalGuaranteeNum = this._getNormalguaranteenum,
  eliteGuaranteeNum = this._getEliteguaranteenum,
  bossGuaranteeNum = this._getBossguaranteenum,
  catchCardEffectMediaPackName = this._getCatchcardeffectmediapackname,
  catchBulletEffectMediaPackName = this._getCatchbulleteffectmediapackname,
  catchBulletEffectAudioPackName = this._getCatchbulleteffectaudiopackname,
  catchBulletHitEffectMediaPackName = this._getCatchbullethiteffectmediapackname,
  catchBulletHitEffectAudioPackName = this._getCatchbullethiteffectaudiopackname,
  catchBulletEffectBackMediaPackName = this._getCatchbulleteffectbackmediapackname,
  catchStarlinkCatchMediaPackName = this._getCatchstarlinkcatchmediapackname,
  catchStarlinkWaitingMediaPackName = this._getCatchstarlinkwaitingmediapackname,
  catchStarlinkVictoryMediaPackName = this._getCatchstarlinkvictorymediapackname,
  catchStarlinkDefeatMediaPackName = this._getCatchstarlinkdefeatmediapackname,
  catchStarlinkVictoryFadeMediaPackName = this._getCatchstarlinkvictoryfademediapackname
}
return this
