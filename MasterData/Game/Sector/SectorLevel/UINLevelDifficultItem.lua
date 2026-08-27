local UINLevelDifficultItem = class("UINLevelDifficultItem", UIBaseNode)
local base = UIBaseNode
local eDifficulty = require("Game.Sector.Enum.SectorLevelDetailEnum").eDifficulty
local eDifficultyName = require("Game.Sector.Enum.SectorLevelDetailEnum").eDifficultyName

function UINLevelDifficultItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rootBtn, self, self.__OnClickRootBtn)
end

function UINLevelDifficultItem:InitLevelDiffItem(sectorId, difficulty, clickEvent)
  self:BindLevelDiffItemCallback(clickEvent)
  self:RefreshLevelDiffItem(sectorId, difficulty)
end

function UINLevelDifficultItem:BindLevelDiffItemCallback(clickEvent)
  self.clickEvent = clickEvent
end

function UINLevelDifficultItem:RefreshLevelDiffItem(sectorId, difficulty)
  self.difficulty = difficulty
  self.gameObject.name = "DiffBtn_" .. eDifficultyName[difficulty]
  self.diffColor = difficulty == eDifficulty.normal and Color.black or Color.white
  self.ui.tex_Diffi.color = self.diffColor
  self.ui.tex_LevelCount.text.color = self.diffColor
  self.ui.texInfo_Diffi:SetIndex(difficulty - 1)
  self.ui.img_Diffi:SetIndex(difficulty - 1)
  if difficulty == ConfigData.sector_stage.difficultyCount + 1 then
    self.ui.tex_LevelCount.gameObject:SetActive(false)
    return
  end
  local sectorTotalCount = ConfigData.sector_stage.sectorTotalCountDic[sectorId][difficulty]
  local sectorLevelList = ConfigData.sector_stage.sectorDiffDic[sectorId][difficulty]
  local passCount = 0
  if sectorLevelList ~= nil then
    for index, sectorId in ipairs(sectorLevelList) do
      if PlayerDataCenter.sectorStage:IsStageComplete(sectorId) then
        passCount = passCount + 1
      end
    end
  end
  self.ui.tex_LevelCount.gameObject:SetActive(true)
  self.ui.tex_LevelCount:SetIndex(0, tostring(passCount), tostring(sectorTotalCount))
end

function UINLevelDifficultItem:__OnClickRootBtn()
  if self.clickEvent ~= nil then
    self.clickEvent(self.difficulty)
  end
end

function UINLevelDifficultItem:GetDifficultyColor()
  return self.diffColor
end

function UINLevelDifficultItem:OnDelete()
  base.OnDelete(self)
end

return UINLevelDifficultItem
