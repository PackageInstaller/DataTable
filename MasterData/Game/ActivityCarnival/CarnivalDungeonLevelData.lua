local DungeonLevelBase = require("Game.DungeonCenter.Data.DungeonLevelBase")
local CarnivalDungeonLevelData = class("CarnivalDungeonLevelData", DungeonLevelBase)
local base = DungeonLevelBase
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function CarnivalDungeonLevelData:SetCarnivalLevelPic(pic)
  self._carnivalLevelPic = pic
end

function CarnivalDungeonLevelData:GetDungeonLevelPic()
  return self._carnivalLevelPic
end

function CarnivalDungeonLevelData:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.Carnival
end

function CarnivalDungeonLevelData:GetDungeonInfoDesc()
  if self._carnivalLevelCfg == nil then
    self._carnivalLevelCfg = ConfigData.activity_carnival_level_detail[self:GetDungeonLevelStageId()]
  end
  if self._carnivalLevelCfg == nil then
    return ""
  end
  return LanguageUtil.GetLocaleText(self._carnivalLevelCfg.level_des)
end

return CarnivalDungeonLevelData
