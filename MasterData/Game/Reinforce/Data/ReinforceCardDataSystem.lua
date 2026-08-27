local base = require("Game.Reinforce.Data.ReinforceCardDataBase")
local ReinforceCardDataSystem = class("ReinforceCardDataSystem", base)
local eReinforce = require("Game.Reinforce.Enum.eReinforce")
local DynBuff = require("Game.Exploration.Data.DynBuff")
local ChipData = require("Game.PlayerData.Item.ChipData")

function ReinforceCardDataSystem:InitRfCardDataSys(cardId, type, star)
  self.dataId = cardId
  self:SetRfCdType(type == nil and eReinforce.eRfCardType.System or type)
  self._star = star
  local itemCfg = ConfigData.item[self.dataId]
  if itemCfg == nil then
    error("item cfg is null,Id:" .. tostring(self.dataId))
    return
  end
  self.itemCfg = itemCfg
  self._rfCdMainCfg = ConfigData.reinforce_card_card_main[self.dataId]
  if self._rfCdMainCfg == nil then
    error("Cant get reinforce_card_card_main, id:" .. tostring(self.dataId))
    return
  end
  if self._star ~= nil and ConfigData.reinforce_card_card_star[self.dataId] ~= nil then
    self._cdStarCfg = ConfigData.reinforce_card_card_star[self.dataId][self._star]
    if self._cdStarCfg == nil then
      error(string.format("cant get reinforce_card_card_star, id:%s, star:%s", self.dataId, self._star))
    end
  end
  self._maxStar = ConfigData.reinforce_card_card_star.rfcdSysMaxStarDic[self.dataId]
end

function ReinforceCardDataSystem:InitRfCardDataSysByElem(rfCdElemMsg)
  self:InitRfCardDataSys(rfCdElemMsg.cardId, eReinforce.eRfCardType.System, rfCdElemMsg.star)
  self:UpdRfCardDataSys(rfCdElemMsg)
end

function ReinforceCardDataSystem:UpdRfCardDataSys(rfCdElemMsg)
  self._star = rfCdElemMsg.star
  self._curNum = rfCdElemMsg.num
  if ConfigData.reinforce_card_card_star[self.dataId] == nil or ConfigData.reinforce_card_card_star[self.dataId][self._star] == nil then
    error(string.format("cant get reinforce_card_card_star, id:%s, star:%s", self.dataId, self._star))
    return
  end
  self._cdStarCfg = ConfigData.reinforce_card_card_star[self.dataId][self._star]
  self._maxStar = ConfigData.reinforce_card_card_star.rfcdSysMaxStarDic[self.dataId]
  local buffList = {}
  for _, buffId in ipairs(self._cdStarCfg.proto_list) do
    local epBuff = DynBuff.CreateByEpBuffId(buffId)
    table.insert(buffList, epBuff)
  end
  self:SetRfCdBuffList(buffList)
  local chipList = {}
  for k, chipId in ipairs(self._cdStarCfg.startFuncId) do
    local num = self._cdStarCfg.startFuncLv[k]
    local chipData = ChipData.New(chipId, num)
    table.insert(chipList, chipData)
  end
  self:SetRfCdStartChipList(chipList)
end

function ReinforceCardDataSystem:GetRfCardStar()
  return self._star
end

function ReinforceCardDataSystem:GetRfCardStarScore(actId)
  local star = self:GetRfCardStar()
  local collectMainCfg = ConfigData.reinforce_collect_card_main[actId]
  if star == 1 then
    return collectMainCfg.star_score1
  elseif star == 2 then
    return collectMainCfg.star_score2
  elseif star == 3 then
    return collectMainCfg.star_score3
  end
  return 0
end

function ReinforceCardDataSystem:GetRfCardStarMax()
  return self._maxStar
end

function ReinforceCardDataSystem:IsRfCardStarMax()
  return self._star == self._maxStar
end

function ReinforceCardDataSystem:GetRfCardStarCfg()
  return self._cdStarCfg
end

function ReinforceCardDataSystem:GetRfCardMaxStarCfg()
  return ConfigData.reinforce_card_card_star[self.dataId][self._maxStar]
end

function ReinforceCardDataSystem:GetRfCardLabelIdList()
  return self._rfCdMainCfg.label_id
end

function ReinforceCardDataSystem:GetRfCdActName()
  return LanguageUtil.GetLocaleText(self._rfCdMainCfg.activity_name)
end

function ReinforceCardDataSystem:GetRfCdActTimeStr()
  return LanguageUtil.GetLocaleText(self._rfCdMainCfg.activity_time)
end

function ReinforceCardDataSystem:GetRfCdNextNeed()
  return self._cdStarCfg.next_need
end

function ReinforceCardDataSystem:IsCanLvUp()
  if self:IsRfCardStarMax() then
    return false
  end
  if self:GetRfCardSysNum() == nil then
    return
  end
  local curNum = self:GetRfCardSysNumShow()
  local needNum = self:GetRfCdNextNeed()
  return curNum >= needNum
end

function ReinforceCardDataSystem:GetRfCdRoomGroupMax()
  local cfg = ConfigData.reinforce_card_card_star[self.dataId][self._maxStar]
  return cfg.room_group
end

function ReinforceCardDataSystem:GetRfCdRoomUnlockStar(roomIdx)
  for i = 1, self._maxStar do
    local cfg = ConfigData.reinforce_card_card_star[self.dataId][i]
    if cfg ~= nil and cfg.room_group[roomIdx] ~= nil then
      return i
    end
  end
end

function ReinforceCardDataSystem:GetRfCdBuffUnlockStar(buffId)
  for i = 1, self._maxStar do
    local cfg = ConfigData.reinforce_card_card_star[self.dataId][i]
    if cfg ~= nil and table.contain(cfg.proto_list, buffId) then
      return i
    end
  end
end

function ReinforceCardDataSystem:GetRfCdChipUnlockStar(chipId)
  for i = 1, self._maxStar do
    local cfg = ConfigData.reinforce_card_card_star[self.dataId][i]
    if cfg ~= nil and table.contain(cfg.startFuncId, chipId) then
      return i
    end
  end
end

function ReinforceCardDataSystem:GetRfCdSysName()
  return LanguageUtil.GetLocaleText(self.itemCfg.name)
end

function ReinforceCardDataSystem:GetRfCdSysDes()
  return LanguageUtil.GetLocaleText(self.itemCfg.describe)
end

function ReinforceCardDataSystem:GetRfCardSysNum()
  return self._curNum
end

function ReinforceCardDataSystem:GetRfCardSysNumShow()
  local exp = self._curNum - 1
  for i = 1, self._star - 1 do
    local starCfg = ConfigData.reinforce_card_card_star[self.dataId][i]
    if starCfg ~= nil then
      exp = exp - starCfg.next_need
    end
  end
  return math.max(0, exp)
end

function ReinforceCardDataSystem:GetRfCardBgPath()
  return self._rfCdMainCfg.image
end

function ReinforceCardDataSystem:GetRfCdInfiniteCoe()
  return self._cdStarCfg.infinite_coe
end

function ReinforceCardDataSystem:GetRfCdRoomGroup()
  return self._cdStarCfg.room_group
end

function ReinforceCardDataSystem:GetRfCdFuncGroupId()
  return self._cdStarCfg.func_group
end

function ReinforceCardDataSystem:GetRfCardLibChipList()
  local funcGroupId = self:GetRfCdFuncGroupId()
  local groupCfg = ConfigData.reinforce_card_func_group[funcGroupId]
  if groupCfg == nil then
    error("Cant get reinforce_card_func_group, id:" .. tostring(funcGroupId))
    return
  end
  local chipDataList = {}
  for k, cfg in pairs(groupCfg) do
    local chipData = ChipData.New(cfg.func_id, cfg.func_level)
    table.insert(chipDataList, chipData)
  end
  return chipDataList
end

return ReinforceCardDataSystem
