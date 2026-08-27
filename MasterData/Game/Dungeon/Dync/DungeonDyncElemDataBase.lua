local DungeonDyncElemDataBase = class("DungeonDyncElemDataBase")
local DungeonDyncEnum = require("Game.Dungeon.Dync.DungeonDyncEnum")
local FormationUtil = require("Game.Formation.FormationUtil")

function DungeonDyncElemDataBase.CreateDefaultDungeonDyncElemData(class, moduleId)
  local data = class.New()
  data:_InitData(nil, true, moduleId)
  return data
end

function DungeonDyncElemDataBase:ctor()
  self._dyncType = DungeonDyncEnum.DgDyncType.None
end

function DungeonDyncElemDataBase:_GenDungeonDyncElemProtoMsgDefault(moduleId)
  local dungeonType = DungeonDyncEnum.DgDyncType2DungeonTypeDic[self._dyncType]
  local defaultFmtId = FormationUtil.GetFmtIdByDungeonType(dungeonType, 1)
  local msg = {
    moduleId = moduleId,
    idx = 0,
    selectedChipGroup = {},
    charHpPer = {},
    monsterHpPer = {},
    formId = defaultFmtId,
    lastChipGroup = {},
    astDync = nil,
    banFairyUid = nil
  }
  return msg
end

function DungeonDyncElemDataBase:_InitData(msg, isDailyDungeonNew, newModuleId)
  if isDailyDungeonNew then
    msg = self:_GenDungeonDyncElemProtoMsgDefault(newModuleId)
  end
  self.moduleId = msg.moduleId
  self.idx = msg.idx
  self.selectedChipGroup = msg.selectedChipGroup
  self.charHpPer = msg.charHpPer
  self.lastChipGroup = msg.lastChipGroup
  self._removeAstDync = self.astDync ~= nil and msg.astDync == nil
  self.astDync = msg.astDync
  self.isDailyDungeonNew = isDailyDungeonNew
  self.failed = msg.failed
  self.banFairyUid = msg.banFairyUid
  self:_ClearDeadHero()
end

function DungeonDyncElemDataBase:_CheckLastChipGroup()
end

function DungeonDyncElemDataBase:_ClearDeadHero()
  if self.isDailyDungeonNew then
    return
  end
  local dungeonType = DungeonDyncEnum.DgDyncType2DungeonTypeDic[self._dyncType]
  local fmtIdOffset = FormationUtil.GetFmtIdOffsetByDungeonType(dungeonType)
  for i = 1, ConfigData.game_config.formationCount do
    local fmtId = i + fmtIdOffset
    local formationData = PlayerDataCenter.formationDic[fmtId]
    if formationData ~= nil then
      local deadHeroDic = {}
      for heroId, hp in pairs(self.charHpPer) do
        if hp == 0 then
          deadHeroDic[heroId] = true
        end
      end
      formationData:SetFmtExcludeHeroIdDic(deadHeroDic)
      if self._removeAstDync or self:HasDgDyncLastAstHero() and self:GetDgDyncLastAstHeroHpPer() == 0 then
        formationData:CleanSupportData()
      end
      self.deadFairyDic = {}
      for _, fairyUID in ipairs(self.banFairyUid) do
        if formationData:GetFmtFairyUID() == fairyUID then
          formationData:SetFmtFairyUID(nil)
        end
        self.deadFairyDic[fairyUID] = true
      end
    end
  end
end

function DungeonDyncElemDataBase:ClearDungeonDyncElemFmtExclude()
  if self.isDailyDungeonNew then
    return
  end
  local dungeonType = DungeonDyncEnum.DgDyncType2DungeonTypeDic[self._dyncType]
  local fmtIdOffset = FormationUtil.GetFmtIdOffsetByDungeonType(dungeonType)
  for i = 1, ConfigData.game_config.formationCount do
    local fmtId = i + fmtIdOffset
    local formationData = PlayerDataCenter.formationDic[fmtId]
    if formationData ~= nil then
      formationData:ClearFmtExcludeHeroIdDic()
      formationData:CleanSupportData()
    end
  end
end

function DungeonDyncElemDataBase:UpdDungeonDyncElemData(msg)
  self:_InitData(msg)
end

function DungeonDyncElemDataBase:GetDungeonDyncHeroHpPer(heroData)
  local hpPer
  if heroData.isFriendSupport then
    if self.astDync ~= nil then
      hpPer = self.astDync.hpPer
    end
  else
    hpPer = self.charHpPer[heroData.dataId]
  end
  hpPer = hpPer or 10000
  return hpPer
end

function DungeonDyncElemDataBase:GetDungeonDyncIsFairyWased(fairyUID)
  return self.deadFairyDic ~= nil and self.deadFairyDic[fairyUID]
end

function DungeonDyncElemDataBase:HasDgDyncLastAstHero()
  return self.astDync ~= nil
end

function DungeonDyncElemDataBase:GetDgDyncLastAstHeroHpPer()
  if not self:HasDgDyncLastAstHero() then
    return 0
  end
  return self.astDync.hpPer
end

function DungeonDyncElemDataBase:GetDgDyncAscHeroData()
  if self.astDync == nil then
    error("self.astDync is nil")
    return nil
  end
  return self.astDync.brief, self.astDync.random
end

function DungeonDyncElemDataBase:IsDgDyncComplete()
end

function DungeonDyncElemDataBase:SetDgDyncElemLastChipGroup(lastChipGroup)
  self.lastChipGroup = lastChipGroup
end

function DungeonDyncElemDataBase:GetDgDyncElemName()
end

function DungeonDyncElemDataBase:DgDyncIsHaveMultReward()
end

function DungeonDyncElemDataBase:IsFailInDgBattle()
  return self.failed
end

return DungeonDyncElemDataBase
