local this = class("pet_rank_shell", G_BaseConfig)
local core = G_Tables.TDPetRankTable.GetInstance()

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
  petId = 0,
  petGroup = 1,
  petGroupName = 2,
  nextPetId = 3,
  rankBreakthroughItem = 4,
  rankBreakthroughCoin = 5,
  levelNeed = 6,
  evoPerform = 7,
  loopFrame = 8,
  evolutionPre = 9,
  evolutionAfterStart = 10,
  pet1Scale = 11,
  pet1Rotation = 12,
  pet2Scale = 13,
  pet2Rotation = 14,
  color1 = 15
}

function this:_getPetid(offset)
  return core:GetInt(offset, this.indexMap.petId)
end

function this:_getPetgroup(offset)
  return core:GetInt(offset, this.indexMap.petGroup)
end

function this:_getPetgroupname(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_rank", core:GetVString(offset, this.indexMap.petGroupName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "petGroupName")
end

function this:_getNextpetid(offset)
  return core:GetInt(offset, this.indexMap.nextPetId)
end

function this:_getRankbreakthroughitem(offset)
  local str = core:GetVString(offset, this.indexMap.rankBreakthroughItem).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRankbreakthroughcoin(offset)
  return core:GetInt(offset, this.indexMap.rankBreakthroughCoin)
end

function this:_getLevelneed(offset)
  return core:GetInt(offset, this.indexMap.levelNeed)
end

function this:_getEvoperform(offset)
  local str = core:GetVString(offset, this.indexMap.evoPerform).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getLoopframe(offset)
  return core:GetInt(offset, this.indexMap.loopFrame)
end

function this:_getEvolutionpre(offset)
  return core:GetVString(offset, this.indexMap.evolutionPre).value
end

function this:_getEvolutionafterstart(offset)
  return core:GetVString(offset, this.indexMap.evolutionAfterStart).value
end

function this:_getPet1scale(offset)
  return core:GetInt(offset, this.indexMap.pet1Scale)
end

function this:_getPet1rotation(offset)
  local str = core:GetVString(offset, this.indexMap.pet1Rotation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPet2scale(offset)
  return core:GetInt(offset, this.indexMap.pet2Scale)
end

function this:_getPet2rotation(offset)
  local str = core:GetVString(offset, this.indexMap.pet2Rotation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getColor1(offset)
  return core:GetVString(offset, this.indexMap.color1).value
end

this.keyToMethodsMap = {
  petId = this._getPetid,
  petGroup = this._getPetgroup,
  petGroupName = this._getPetgroupname,
  nextPetId = this._getNextpetid,
  rankBreakthroughItem = this._getRankbreakthroughitem,
  rankBreakthroughCoin = this._getRankbreakthroughcoin,
  levelNeed = this._getLevelneed,
  evoPerform = this._getEvoperform,
  loopFrame = this._getLoopframe,
  evolutionPre = this._getEvolutionpre,
  evolutionAfterStart = this._getEvolutionafterstart,
  pet1Scale = this._getPet1scale,
  pet1Rotation = this._getPet1rotation,
  pet2Scale = this._getPet2scale,
  pet2Rotation = this._getPet2rotation,
  color1 = this._getColor1
}
return this
