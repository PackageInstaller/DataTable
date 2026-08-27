local DungeonLevelBase = require("Game.DungeonCenter.Data.DungeonLevelBase")
local SpringDungeonLevelData = class("CarnivalDungeonLevelData", DungeonLevelBase)
local base = DungeonLevelBase
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function SpringDungeonLevelData:ctor(stageId, levelCfg, index)
  self.levelCfg = levelCfg
  self.__index = index
end

function SpringDungeonLevelData:SetSpringLevelPic(pic)
  self._springLevelPic = pic
end

function SpringDungeonLevelData:GetDungeonLevelPic()
  return self._springLevelPic
end

function SpringDungeonLevelData:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.Spring
end

function SpringDungeonLevelData:GetDungeonInfoDesc()
  if self._carnivalLevelCfg == nil then
    self._carnivalLevelCfg = ConfigData.activity_spring_level_detail[self:GetDungeonLevelStageId()]
  end
  if self._carnivalLevelCfg == nil then
    return ""
  end
  return LanguageUtil.GetLocaleText(self._carnivalLevelCfg.level_des)
end

return SpringDungeonLevelData
