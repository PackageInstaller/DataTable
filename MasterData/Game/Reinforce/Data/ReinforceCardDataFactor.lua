local base = require("Game.Reinforce.Data.ReinforceCardDataBase")
local ReinforceCardDataFactor = class("ReinforceCardDataFactor", base)
local eReinforce = require("Game.Reinforce.Enum.eReinforce")
local DynBuff = require("Game.Exploration.Data.DynBuff")
local ChipData = require("Game.PlayerData.Item.ChipData")
local EpRoleHeroData = require("Game.Formation.Data.EpRoleHeroData")
local DynFairyData = require("Game.Exploration.Data.DynFairyData")

function ReinforceCardDataFactor:InitRfCardDataFac(msg)
  self:SetRfCdType(eReinforce.eRfCardType.Factor)
  self._factorOrder = msg.cardId
  self._UID = msg.uuid
  self._bgPath = msg.imgName
  local buffList = {}
  for k, biffId in ipairs(msg.buffCard) do
    local epBuff = DynBuff.CreateByEpBuffId(biffId)
    table.insert(buffList, epBuff)
  end
  self:SetRfCdBuffList(buffList)
  local chipList = {}
  for chipId, num in pairs(msg.algCard) do
    local chipData = ChipData.New(chipId, num)
    table.insert(chipList, chipData)
  end
  self:SetRfCdStartChipList(chipList)
  self._infiniteCoe = msg.specialScore
  self._roomGroupList = msg.roomIds
  self._chipLibDic = msg.algLists
  self._infiniteCoeFmt = msg.inifiniteCoe
  self._fmtScore = msg.score
  local fmtBuffList = {}
  for k, biffId in ipairs(msg.buffFmt) do
    local epBuff = DynBuff.CreateByEpBuffId(biffId)
    table.insert(fmtBuffList, epBuff)
  end
  self.__fmtBuffList = fmtBuffList
  local fmtChipList = {}
  for chipId, num in pairs(msg.algFmt) do
    local chipData = ChipData.New(chipId, num)
    table.insert(fmtChipList, chipData)
  end
  self.__fmtChipList = fmtChipList
  if msg.explorationBattleRoleStatic ~= nil then
    local epRoleStc = msg.explorationBattleRoleStatic
    local epRoleDyc = msg.explorationBattleRoleDync
    local heroList = {}
    local heroIdxMap = {}
    for fmtIdx, uid in pairs(msg.heroData) do
      local heroElem = epRoleStc.heroes[uid]
      local heroId = heroElem.dataId
      local heroData
      if epRoleDyc.role.role[uid].roleType == proto_object_EplBattleRoleType.BattleRoleNormal then
        heroData = PlayerDataCenter.heroDic[heroId]
      else
        local heroCfg = ConfigData.hero_data[heroElem.dataId]
        heroData = EpRoleHeroData.New({
          basic = {
            id = heroElem.dataId,
            level = heroElem.level,
            exp = 0,
            star = heroElem.rank,
            potentialLvl = heroElem.potential,
            ts = -1,
            career = heroCfg.career,
            company = heroCfg.camp,
            skinId = heroElem.skinId,
            cat = heroElem.cat,
            serverModel = epRoleDyc.role.role[uid].dync.texture,
            name = heroElem.name
          },
          spWeapon = heroElem.specWeapon,
          vow = {
            vowTime = heroElem.vowed and 1 or 0,
            name = heroElem.name
          }
        })
        heroData:SetEpRoleHeroData(heroElem)
      end
      table.insert(heroList, heroData)
      heroIdxMap[heroData] = fmtIdx
    end
    table.sort(heroList, function(a, b)
      return heroIdxMap[a] < heroIdxMap[b]
    end)
    self._heroDataList = heroList
    self._heroIdxMap = heroIdxMap
    local fairyData
    if epRoleStc.fairy then
      fairyData = DynFairyData.GenDynFairyData(epRoleStc.fairy)
    end
    self._fairyData = fairyData
  end
  self._leaderHeroId = msg.leaderHeroId
  self._leaderSkinId = msg.leaderSkinId
  self._isSupport = nil
  self._SupportUserInfoData = nil
end

function ReinforceCardDataFactor:SetRfCdFactorOrder(factorOrder)
  self._factorOrder = factorOrder
end

function ReinforceCardDataFactor:GetRfCdFactorOrder()
  return self._factorOrder
end

function ReinforceCardDataFactor:GetRfCdUID()
  return self._UID
end

function ReinforceCardDataFactor:GetRfCdFacFmtInfiniteCoe()
  return self._infiniteCoeFmt
end

function ReinforceCardDataFactor:GetRfCdFacFmtScore()
  return self._fmtScore
end

function ReinforceCardDataFactor:GetRfCdFacFmtBuffList(iNeedNotshow)
  if not iNeedNotshow then
    local chipList = {}
    for index, epBuff in ipairs(self.__fmtBuffList) do
      if epBuff:IsBuffNeedShowOnBuffList() then
        table.insert(chipList, epBuff)
      end
    end
    return chipList
  end
  return self.__fmtBuffList
end

function ReinforceCardDataFactor:GetRfCdFacFmtChipList()
  return self.__fmtChipList
end

function ReinforceCardDataFactor:GetRfCardLibChipList()
  local chipList = {}
  for chipId, num in pairs(self._chipLibDic) do
    local chipData = ChipData.New(chipId, num)
    table.insert(chipList, chipData)
  end
  return chipList
end

function ReinforceCardDataFactor:GetRfCdFacLeaderSkinId()
  return self._leaderHeroId, self._leaderSkinId
end

function ReinforceCardDataFactor:GetRfCdFacHeroList()
  return self._heroDataList
end

function ReinforceCardDataFactor:GetRfCdFacHeroIdexDic()
  return self._heroIdxMap
end

function ReinforceCardDataFactor:GetRfCdFacFairyUID()
  if self._fairyData == nil then
    return nil
  end
  return self._fairyData:GetFairyUID()
end

function ReinforceCardDataFactor:GetRfCardBgPath()
  return self._bgPath
end

function ReinforceCardDataFactor:GetRfCdInfiniteCoe()
  return self._infiniteCoe
end

function ReinforceCardDataFactor:GetRfCdRoomGroup()
  return self._roomGroupList
end

function ReinforceCardDataFactor:GetRfCdUID()
  return self._UID
end

function ReinforceCardDataFactor:SetSupportData(isSupport, SupportUserInfoData)
  self._isSupport = isSupport
  self._SupportUserInfoData = SupportUserInfoData
end

function ReinforceCardDataFactor:GetIsSupport()
  return self._isSupport
end

function ReinforceCardDataFactor:GetSupportCardUserInfoData()
  return self._SupportUserInfoData
end

return ReinforceCardDataFactor
