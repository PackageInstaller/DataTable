local base = require("Game.PlayerData.Item.ItemData")
local ChipData = class("ChipData", base)
local ChipBattleData = require("Game.PlayerData.Item.ChipBattleData")
local EpStoreRoomUtil = require("Game.Exploration.Util.EpStoreRoomUtil")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local cs_FormulaUtility = CS.FormulaUtility

function ChipData.NewChipForServer(chipKey)
  local chipId, level = ExplorationManager.ChipServerIdConvert(chipKey)
  return ChipData.New(chipId, level)
end

function ChipData.NewChipForLocal(chipId, level)
  local chipData = ChipData.New(chipId, 1)
  if level == nil then
    level = chipData.itemCfg.quality - 2
  end
  chipData:SetCount(level)
  return chipData
end

function ChipData:ctor(dataId, count)
  local chipCfg = ConfigData.chip[self.dataId]
  if chipCfg == nil then
    error("Can't find chip cfg, id = " .. tostring(self.dataId))
    return
  end
  self.chipCfg = chipCfg
  self.isShowTemp = false
  self.chipBattleData = ChipBattleData.New(self.chipCfg, self:GetChipRealLevel())
end

function ChipData:OnCountChanged()
  base.OnCountChanged(self)
  if self.chipBattleData ~= nil then
    self.chipBattleData:UpdateChipBattleLevel(self:GetChipRealLevel())
  end
end

function ChipData:GetValidRoleList(dynBattleRoleList, belong, chipEffector)
  return self.chipBattleData:GetValidRoleList(dynBattleRoleList, belong, chipEffector)
end

function ChipData:IsValidDynPlayer()
  return self.chipBattleData:IsValidDynPlayer()
end

function ChipData:IsConsumeSkillChip()
  return self.chipBattleData:IsConsumeChipBattle()
end

function ChipData:IsForEnemyChip()
  return self.chipBattleData:IsForEnemyChipBattle()
end

function ChipData:IsForDynEnemyChip()
  return self.chipBattleData:IsForDynEnemyChipBattle()
end

function ChipData:IsForHeroIDChipBattle()
  return self.chipBattleData:IsForHeroIDChipBattle()
end

function ChipData:ExecuteChipData(chipHolder)
  if self.chipBattleData:ExecuteChipBattle(chipHolder) then
    chipHolder:AddChip(self)
  end
end

function ChipData:RollbackChipData(chipHolder)
  if self.chipBattleData:RollbackChipBattle(chipHolder) then
    chipHolder:RemoveChip(self)
  end
end

function ChipData:GetChipCfg()
  return self.chipCfg
end

function ChipData:GetChipSpecQuality()
  return self.chipCfg.chip_quality
end

function ChipData:GetChipIconSprite()
  if self:IsConsumeSkillChip() then
    return CRH:GetSprite(self:GetIcon(), CommonAtlasType.SkillIcon)
  else
    return CRH:GetSprite(self:GetIcon())
  end
end

function ChipData:GetChipMarkId()
  return self.chipCfg.markid
end

function ChipData:GetChipMarkIcon()
  return ConfigData.chip_mark[self.chipCfg.markid].icon
end

function ChipData:GetChipMaxLevel()
  return self:GetItemTopLimit()
end

function ChipData:GetChipCount()
  return math.min(self.__count, self:GetChipMaxLevel())
end

function ChipData:IsChipFullLevel()
  return self:GetCount() >= self:GetChipMaxLevel()
end

function ChipData:GetChipRealLevel()
  return math.min(self:GetCount(), self:GetChipMaxLevel())
end

function ChipData:GetChipInfo()
  return LanguageUtil.GetLocaleText(self.chipCfg.info)
end

function ChipData:GetName()
  local name = base.GetName(self)
  if self:IsCopyItem() then
    name = name .. "-" .. self.heroName
  end
  return name
end

function ChipData:IsCopyItem()
  return false
end

function ChipData:SetIsShowTemp(bool)
  self.isShowTemp = bool
end

function ChipData:IsShowTemp()
  return self.isShowTemp
end

function ChipData:GetHeroName()
  return self.heroName
end

function ChipData:GetHeroID()
  return self.heroId
end

function ChipData:GetQuality()
  if self:IsConsumeSkillChip() then
    return base.GetQuality(self)
  end
  return ConfigData:GetChipQuality(self.__count)
end

function ChipData:GetChipBuyPrice(epModuleId, isFromSell)
  local resultPrice = 0
  local epTypeCfg = ConfigData.exploration_type[epModuleId]
  if epTypeCfg == nil then
    error("Cant get exploration_type cfg, epModuleId = " .. tostring(epModuleId))
    return 0
  end
  local level = math.min(self.__count, self:GetChipMaxLevel())
  if self:IsConsumeSkillChip() then
    resultPrice = epTypeCfg.chip_act_level_price[level] or 0
  else
    resultPrice = epTypeCfg.chip_level_price[level] or 0
  end
  if ExplorationManager:IsInExploration() then
    local curStep = ExplorationManager.epCtrl.mapData:GetTotalStep()
    local refreshTime = 0
    local curRoomData = ExplorationManager.epCtrl:GetCurrentRoomData(true)
    if curRoomData ~= nil and curRoomData.storeRoomData ~= nil then
      refreshTime = curRoomData:GetEpStoreRoomRefreshTimes()
    end
    if not isFromSell and 0 < curStep then
      local needAddPrice = 0
      local addPriceTable = epTypeCfg.step_add_function_price
      for k, v in pairs(addPriceTable) do
        if k <= curStep and v > needAddPrice then
          needAddPrice = v
        end
      end
      resultPrice = resultPrice + needAddPrice
    end
    if 0 < refreshTime then
      local needAddPrice = 0
      local addPriceTable = epTypeCfg.refresh_add_func_price
      for k, v in pairs(addPriceTable) do
        if k <= refreshTime and v > needAddPrice then
          needAddPrice = v
        end
      end
      resultPrice = resultPrice + needAddPrice
    end
  end
  if isFromSell then
    return resultPrice
  end
  resultPrice = EpStoreRoomUtil.GetFinalChipItemBuyPriceWithOriginPrice(resultPrice)
  return resultPrice
end

function ChipData:GetChipBuyPriceForWarChess()
  local resultPrice = 0
  local shopId = WarChessManager:GetWCLevelShopId()
  local epTypeCfg = ConfigData.warchess_shop_coin[shopId]
  if epTypeCfg == nil then
    return 0
  end
  local level = math.min(self.__count, self:GetChipMaxLevel())
  resultPrice = epTypeCfg.function_price[level] or 0
  resultPrice = resultPrice + (self.wcBuffServerBuyPriceAdd or 0)
  return math.floor(resultPrice * (self.wcChipServerBuyRate or 1))
end

function ChipData:GetChipSellPriceForWarChess()
  local resultPrice = 0
  local shopId = WarChessManager:GetWCLevelShopId()
  local epTypeCfg = ConfigData.warchess_shop_coin[shopId]
  if epTypeCfg == nil then
    return 0
  end
  local level = math.min(self.__count, self:GetChipMaxLevel())
  resultPrice = epTypeCfg.function_over_payback[level] or 0
  return resultPrice
end

function ChipData:GetChipFuncTag()
  return self.chipCfg.fun_tag
end

function ChipData:GetChipDescription(isShowDetail)
  return ConfigData:GetChipDescriptionById(self.chipCfg.id, self:GetCount(), isShowDetail)
end

function ChipData:GetChipType()
  return self.chipCfg.type
end

function ChipData:GetSkillCfg()
  local skillId = self:GetSkillID()
  local skillCfg = CS.GameData.instance.listBattleSkillDatas:GetDataById(skillId)
  if skillCfg == nil then
    error("Can't find skillCfg, id = " .. tostring(skillId))
    return
  end
  return skillCfg
end

function ChipData:GetSkillID()
  return self.chipCfg.skill_list[1]
end

function ChipData:TryGetSkillCD(curLevel, digits)
  local hasCD = false
  local cd = ""
  local skillId = self:GetSkillID()
  local skillCfg = self:GetSkillCfg()
  if skillCfg ~= nil and skillId ~= nil then
    local skillCD = cs_FormulaUtility.CalculateSkillCd(skillId, curLevel)
    if skillCD ~= 0 then
      hasCD = true
      cd = GetPreciseDecimalStr(skillCD, digits)
    end
  end
  return hasCD, cd
end

function ChipData:TryGetSuitCfg()
  if self.chipCfg == nil then
    return
  end
  local tagId = self.chipCfg.fun_tag
  return ConfigData.chip_tag[tagId]
end

function ChipData:IsRainChip()
  return self:GetChipType() == ChipEnum.eChipType.Rain
end

function ChipData:GetVaildRoleCountWithOutBench()
  return self.chipBattleData:GetVaildRoleCountWithOutBench()
end

return ChipData
