local base = require("Game.Dungeon.Dync.DungeonDyncElemDataBase")
local DungeonDyncElemDataWinterChallengeDg = class("DungeonDyncElemDataWinterChallengeDg", base)
local DungeonDyncEnum = require("Game.Dungeon.Dync.DungeonDyncEnum")

function DungeonDyncElemDataWinterChallengeDg:ctor()
  self._dyncType = DungeonDyncEnum.DgDyncType.WinterChallenge
end

function DungeonDyncElemDataWinterChallengeDg:_InitData(msg, isDailyDungeonNew, newModuleId)
  base._InitData(self, msg, isDailyDungeonNew, newModuleId)
  self:_CheckLastChipGroup()
end

function DungeonDyncElemDataWinterChallengeDg:_CheckLastChipGroup()
  local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
  if sectorIICtrl == nil then
    error("Cant get sectorIICtrl")
    return
  end
  local sectorIIData = sectorIICtrl:GetSectorIIFirstData()
  if sectorIIData == nil then
    error("Cant get sectorIIData")
    return
  end
  local actWinClgData = sectorIIData:GetActvWinChallengeDgData()
  local maxSuiNumDic = actWinClgData:GetSctIIChallengeDgSuitNumDic()
  local waitRemoveSuitIdDic = {}
  for suitId, v in pairs(self.lastChipGroup) do
    local curNum = self.selectedChipGroup[suitId] or 0
    local maxNum = maxSuiNumDic[suitId]
    if curNum >= maxNum then
      waitRemoveSuitIdDic[suitId] = true
    end
  end
  for suitId, v in pairs(waitRemoveSuitIdDic) do
    self.lastChipGroup[suitId] = nil
  end
end

function DungeonDyncElemDataWinterChallengeDg:IsDgDyncComplete()
end

return DungeonDyncElemDataWinterChallengeDg
