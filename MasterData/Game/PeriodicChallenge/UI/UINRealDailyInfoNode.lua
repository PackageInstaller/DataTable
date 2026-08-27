local UINRealDailyInfoNode = class("UINRealDailyInfoNode", UIBaseNode)
local base = UIBaseNode
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UINRealDailyInfoNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINRealDailyInfoNode:InitRealDailyInfoNode(realDailySectorId, dungeonId)
  self.dungeonId = dungeonId
  local sectorCfg = ConfigData.sector[realDailySectorId]
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(sectorCfg.name)
  self.ui.tex_Info.text = LanguageUtil.GetLocaleText(sectorCfg.description)
  self.ui.tex_Tip.text = ConfigData:GetTipContent(TipContent.WeeklyChallenge_DailyChallengeTip)
  self:RefreshPeriodicInfoItem()
end

function UINRealDailyInfoNode:RefreshPeriodicInfoItem()
  local _, dungeonId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
  local isInEp = self.dungeonId == dungeonId
  self.ui.obj_Continue:SetActive(isInEp)
end

return UINRealDailyInfoNode
