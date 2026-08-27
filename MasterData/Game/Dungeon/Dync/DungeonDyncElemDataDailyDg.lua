local base = require("Game.Dungeon.Dync.DungeonDyncElemDataBase")
local DungeonDyncElemDataDailyDg = class("DungeonDyncElemDataDailyDg", base)
local DungeonDyncEnum = require("Game.Dungeon.Dync.DungeonDyncEnum")

function DungeonDyncElemDataDailyDg:ctor()
  self._dyncType = DungeonDyncEnum.DgDyncType.DailyDungeon
end

function DungeonDyncElemDataDailyDg:_InitData(msg, isDailyDungeonNew, newModuleId)
  base._InitData(self, msg, isDailyDungeonNew, newModuleId)
  local matDungeonCfg = ConfigData.material_dungeon[self.moduleId]
  if matDungeonCfg == nil then
    error("Cant get ConfigData.material_dungeon, id = " .. tostring(self.moduleId))
  end
  self.matDungeonCfg = matDungeonCfg
  self:_CheckLastChipGroup()
  if not isDailyDungeonNew then
    NoticeManager:DeleteNoticeByType(NoticeManager.eNoticeType.DailyDungeon)
  end
end

function DungeonDyncElemDataDailyDg:_CheckLastChipGroup()
  local waitRemoveSuitIdDic = {}
  for suitId, v in pairs(self.lastChipGroup) do
    local curNum = self.selectedChipGroup[suitId] or 0
    local maxNum = self.matDungeonCfg.chipSuitNumMaxDic[suitId]
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

function DungeonDyncElemDataDailyDg:IsDgDyncComplete()
  local allNum = #self.matDungeonCfg.stage_id
  local completeAll = allNum == self.idx
  return completeAll
end

function DungeonDyncElemDataDailyDg:GetDgDyncElemName()
  local name = LanguageUtil.GetLocaleText(self.matDungeonCfg.name)
  return name
end

function DungeonDyncElemDataDailyDg:GetDailyDgNextLvDungeonId()
  local nextLvDungeonId = self.matDungeonCfg.stage_id[self.idx + 1]
  if nextLvDungeonId == nil then
    error("nextLvDungeonId is nil")
  end
  return nextLvDungeonId
end

function DungeonDyncElemDataDailyDg:DgDyncIsHaveMultReward()
  return PlayerDataCenter.playerBonus:IsDungeonHasMultReward(proto_csmsg_DungeonType.DungeonType_Daily)
end

function DungeonDyncElemDataDailyDg:IsDailyModuleCanQuick(moduleId)
  if not PlayerDataCenter:IsDungeonModuleOpenQuick(moduleId) then
    return false
  end
  if self:IsDgDyncComplete() then
    return false
  end
  return self.isDailyDungeonNew or self.moduleId == moduleId
end

return DungeonDyncElemDataDailyDg
