local UIRecommeFormation = class("UIRecommeFormation", UIBaseWindow)
local base = UIBaseWindow
local UINRecommeFormationItem = require("Game.Formation.UI.RecommeFormation.UINRecommeFormationItem")
local CS_ResLoader = CS.ResLoader

function UIRecommeFormation:OnInit()
  self.ui.recommeTeamItem:SetActive(false)
  self.itemPool = UIItemPool.New(UINRecommeFormationItem, self.ui.recommeTeamItem)
  UIUtil.SetTopStatus(self, self.OnCloseUI)
  UIUtil.AddValueChangedListener(self.ui.tog_Filter, self, self.OnToggleFiler)
  self.resloader = CS_ResLoader.Create()
end

function UIRecommeFormation:InitRecommeFormation(isOpenCopy, recordInfo, recommeCtr)
  self.recommeCtr = recommeCtr
  self.recordInfo = recordInfo
  self.isOpenCopy = isOpenCopy
  local msg
  if recordInfo.isDungeon then
    local dungeonStageCfg = ConfigData.battle_dungeon[self.recordInfo.stageId]
    if dungeonStageCfg ~= nil then
      msg = LanguageUtil.GetLocaleText(dungeonStageCfg.name)
    end
  elseif ConfigData.sector_stage[self.recordInfo.stageId] ~= nil then
    local difficultyId, sectorId, stageIndex = self:GetNormalStageData(self.recordInfo.stageId)
    msg = ConfigData:GetSectorInfoMsg(sectorId, stageIndex, difficultyId)
  elseif ConfigData.endless ~= nil and ConfigData.endless.levelDic ~= nil and ConfigData.endless.levelDic[self.recordInfo.stageId] ~= nil then
    local stageCfg = ConfigData.endless.levelDic[self.recordInfo.stageId]
    local sectorId = stageCfg.sectorId
    local depth = stageCfg.index * 10
    local sectorCfg = ConfigData.sector[sectorId]
    if stageCfg ~= nil then
      msg = ConfigData:GetEndlessInfoMsg(sectorCfg, depth)
    end
  end
  self.ui.tex_LevelInfo.text = msg
  if self.ui.tog_Filter.isOn == self.recommeCtr.isRecommeSortForCount then
    self:OnToggleFiler(self.recommeCtr.isRecommeSortForCount)
  else
    self.ui.tog_Filter.isOn = self.recommeCtr.isRecommeSortForCount
  end
end

function UIRecommeFormation:OnToggleFiler(isSelected)
  self.recommeCtr.isRecommeSortForCount = isSelected
  if isSelected then
    self.recordInfo:SortByHeroCount()
  else
    self.recordInfo:SortByPower()
  end
  self.itemPool:HideAll()
  self:__ShowList()
end

function UIRecommeFormation:__ShowList()
  for i = 1, #self.recordInfo.list do
    local item = self.itemPool:GetOne()
    item:InitRecommeItem(self.recommeCtr, self.recordInfo.list[i], self.isOpenCopy, self.recordInfo, self.resloader)
  end
end

function UIRecommeFormation:GetNormalStageData(stageId)
  local stageCfg = ConfigData.sector_stage[stageId]
  local sectorId = stageCfg.sector
  local difficultyId = stageCfg.difficulty
  local stageIndex = 0
  local difflist = ConfigData.sector_stage.sectorDiffDic[sectorId][difficultyId]
  for index, id in ipairs(difflist) do
    if id == stageId then
      stageIndex = index
    end
  end
  return difficultyId, sectorId, stageIndex
end

function UIRecommeFormation:OnCloseUI()
  self:Delete()
end

function UIRecommeFormation:OnDelete()
  self.resloader:Put2Pool()
  self.resloader = nil
  base.OnDelete(self)
end

return UIRecommeFormation
