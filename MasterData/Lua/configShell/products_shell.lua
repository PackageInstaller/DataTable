local this = class("products_shell", G_BaseConfig)
local core = G_Tables.TDProductsTable.GetInstance()

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
  rewardDesc = 1,
  rewardId = 2,
  type = 3,
  group = 4,
  isQuickProduct = 5,
  maxLimit = 6,
  unlockCondition = 7,
  material = 8,
  materialSelect = 9,
  tabId = 10,
  technologyExp = 11,
  numberLimit = 12,
  time = 13,
  satietyScore = 14,
  reduceSatietyScoreBefore = 15,
  isNeedPet = 16,
  postIdAccessory = 17,
  sequenceAccessory = 18,
  sequenceSortAccessory = 19,
  sequenceQuickProduct = 20,
  elementTypeId = 21,
  notReleased = 22,
  wishlistLimit = 23
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRewarddesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("products", core:GetVString(offset, this.indexMap.rewardDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "rewardDesc")
end

function this:_getRewardid(offset)
  local str = core:GetVString(offset, this.indexMap.rewardId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getGroup(offset)
  local str = core:GetVString(offset, this.indexMap.group).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIsquickproduct(offset)
  return core:GetBool(offset, this.indexMap.isQuickProduct)
end

function this:_getMaxlimit(offset)
  return core:GetInt(offset, this.indexMap.maxLimit)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getMaterial(offset)
  local str = core:GetVString(offset, this.indexMap.material).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getMaterialselect(offset)
  local str = core:GetVString(offset, this.indexMap.materialSelect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTabid(offset)
  return core:GetInt(offset, this.indexMap.tabId)
end

function this:_getTechnologyexp(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getNumberlimit(offset)
  return core:GetInt(offset, this.indexMap.numberLimit)
end

function this:_getTime(offset)
  return core:GetInt(offset, this.indexMap.time)
end

function this:_getSatietyscore(offset)
  return core:GetInt(offset, this.indexMap.satietyScore)
end

function this:_getReducesatietyscorebefore(offset)
  return core:GetBool(offset, this.indexMap.reduceSatietyScoreBefore)
end

function this:_getIsneedpet(offset)
  return core:GetBool(offset, this.indexMap.isNeedPet)
end

function this:_getPostidaccessory(offset)
  return core:GetInt(offset, this.indexMap.postIdAccessory)
end

function this:_getSequenceaccessory(offset)
  return core:GetInt(offset, this.indexMap.sequenceAccessory)
end

function this:_getSequencesortaccessory(offset)
  return core:GetInt(offset, this.indexMap.sequenceSortAccessory)
end

function this:_getSequencequickproduct(offset)
  return core:GetInt(offset, this.indexMap.sequenceQuickProduct)
end

function this:_getElementtypeid(offset)
  return core:GetInt(offset, this.indexMap.elementTypeId)
end

function this:_getNotreleased(offset)
  return core:GetInt(offset, this.indexMap.notReleased)
end

function this:_getWishlistlimit(offset)
  return core:GetInt(offset, this.indexMap.wishlistLimit)
end

this.keyToMethodsMap = {
  id = this._getId,
  rewardDesc = this._getRewarddesc,
  rewardId = this._getRewardid,
  type = this._getType,
  group = this._getGroup,
  isQuickProduct = this._getIsquickproduct,
  maxLimit = this._getMaxlimit,
  unlockCondition = this._getUnlockcondition,
  material = this._getMaterial,
  materialSelect = this._getMaterialselect,
  tabId = this._getTabid,
  technologyExp = this._getTechnologyexp,
  numberLimit = this._getNumberlimit,
  time = this._getTime,
  satietyScore = this._getSatietyscore,
  reduceSatietyScoreBefore = this._getReducesatietyscorebefore,
  isNeedPet = this._getIsneedpet,
  postIdAccessory = this._getPostidaccessory,
  sequenceAccessory = this._getSequenceaccessory,
  sequenceSortAccessory = this._getSequencesortaccessory,
  sequenceQuickProduct = this._getSequencequickproduct,
  elementTypeId = this._getElementtypeid,
  notReleased = this._getNotreleased,
  wishlistLimit = this._getWishlistlimit
}
return this
