local UINActSum22MapSelected = class("UINActSum22MapSelected", UIBaseNode)
local base = UIBaseNode
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UINActSum22MapSelected:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._starDefaultWidth = self.ui.challenge.rect.width
end

function UINActSum22MapSelected:InitMapSelected(sectorLevelData)
  self.ui.ani_root:Rewind()
  self.ui.ani_root:Play()
  self._sectorLevelData = sectorLevelData
  if self._sectorLevelData:GetIsBattle() then
    self:__RefreshStage()
  else
    self:__RefreshAvg()
  end
end

function UINActSum22MapSelected:__RefreshStage()
  local isSideStage = self._sectorLevelData:GetSectroIILevelIsSide()
  self.ui.tex_Title.text = self._sectorLevelData:GetLevelTitle()
  local stageCfg = self._sectorLevelData:GetLevelEpStageCfg()
  if isSideStage then
    self.ui.tex_SubTitle:SetIndex(2, tostring(stageCfg.num))
  else
    self.ui.tex_SubTitle:SetIndex(0, tostring(stageCfg.num))
  end
  local total, count = self._sectorLevelData:GetSectorIILevelChallengeTaskNum()
  if 0 < (total or 0) then
    self.ui.challenge.gameObject:SetActive(true)
    local vec = self.ui.challenge.sizeDelta
    vec.x = self._starDefaultWidth * total
    self.ui.challenge.sizeDelta = vec
    vec = self.ui.img_ChallengeCur.sizeDelta
    vec.x = self._starDefaultWidth * count
    self.ui.img_ChallengeCur.sizeDelta = vec
  else
    self.ui.challenge.gameObject:SetActive(false)
  end
  local playMoudle = SectorStageDetailHelper.SectorPlayMoudle(stageCfg.sector)
  local has, unCompletestageId = SectorStageDetailHelper.HasUnCompleteStage(playMoudle)
  self.ui.unComplete:SetActive(has and unCompletestageId == self._sectorLevelData:GetLevelSageId())
end

function UINActSum22MapSelected:__RefreshAvg()
  self.ui.unComplete:SetActive(false)
  self.ui.challenge.gameObject:SetActive(false)
  local avgCfg = self._sectorLevelData:GetLevelAvgCfg()
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(avgCfg.name)
  self.ui.tex_SubTitle:SetIndex(1, tostring(avgCfg.number))
end

return UINActSum22MapSelected
