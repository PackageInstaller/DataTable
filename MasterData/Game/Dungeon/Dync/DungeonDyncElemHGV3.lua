local base = require("Game.Dungeon.Dync.DungeonDyncElemDataBase")
local DungeonDyncElemHGV3 = class("DungeonDyncElemHGV3", base)
local DungeonDyncEnum = require("Game.Dungeon.Dync.DungeonDyncEnum")
local HeroGrowV3Enum = require("Game.ActivityHeroGrowV3.Data.HeroGrowV3Enum")

function DungeonDyncElemHGV3:ctor()
  self._dyncType = DungeonDyncEnum.DgDyncType.HeroLite
  self.__hgv3SubType = HeroGrowV3Enum.HGV3NormalQuestType.officialTeam
end

function DungeonDyncElemHGV3:_InitData(msg, isDailyDungeonNew, newModuleId)
  base._InitData(self, msg, isDailyDungeonNew, newModuleId)
  local HGV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3, true)
  local heroGrowV3Data = HGV3Ctrl:GetHeroGrowV3Data()
  if heroGrowV3Data == nil then
    return
  end
  self.normalData = heroGrowV3Data:GetGetHGV3NormalDataDic()[self.__hgv3SubType]
  self:_CheckLastChipGroup()
end

function DungeonDyncElemHGV3:_CheckLastChipGroup()
  local maxNumDic = self.normalData:GetHGV3SuitNumDic()
  local waitRemoveSuitIdDic = {}
  for suitId, v in pairs(self.lastChipGroup) do
    local curNum = self.selectedChipGroup[suitId] or 0
    local maxNum = maxNumDic[suitId]
    if maxNum == nil then
      error("Cant find chip suit, id:" .. tostring(suitId))
      waitRemoveSuitIdDic[suitId] = true
    elseif curNum >= maxNum then
      waitRemoveSuitIdDic[suitId] = true
    end
  end
  for suitId, v in pairs(waitRemoveSuitIdDic) do
    self.lastChipGroup[suitId] = nil
  end
end

function DungeonDyncElemHGV3:IsHGV3DynDunHasBattledHero()
  for _, value in pairs(self.charHpPer) do
    if value ~= 10000 then
      return true
    end
  end
  return false
end

return DungeonDyncElemHGV3
