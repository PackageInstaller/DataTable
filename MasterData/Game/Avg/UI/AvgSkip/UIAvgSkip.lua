local UIAvgSkip = class("UIAvgSkip", UIBaseWindow)
local base = UIBaseWindow
local HasSectorStageDic = {
  [eAvgTriggerType.None] = false,
  [eAvgTriggerType.MainAvg] = true,
  [eAvgTriggerType.MainAvgEp] = true,
  [eAvgTriggerType.AvgDungeon] = false,
  [eAvgTriggerType.AvgTask] = false,
  [eAvgTriggerType.SubAvg] = true,
  [eAvgTriggerType.AvgSector] = false,
  [eAvgTriggerType.ExplorationRoom] = true
}

function UIAvgSkip:OnInit()
  self._OnClickConfirm = BindCallback(self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirm)
end

function UIAvgSkip:InitAvgSkipInfo(skipStr, storyAvgId)
  self.ui.tex_Content.text = skipStr
  self.ui.tex_Title.text = nil
  self.ui.tex_SectorEnName.text = nil
  self.ui.tex_SectorName.text.text = nil
  local storyCfg = ConfigData.story_avg[storyAvgId]
  if storyCfg == nil then
    warn("Cant storyCfg, storyAvgId = " .. tostring(storyAvgId))
    return
  end
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(storyCfg.name)
  local sectorCfg
  if HasSectorStageDic[storyCfg.type] == nil then
    warn("Unsurpported storyCfg.type : " .. tostring(storyCfg.type))
  end
  if HasSectorStageDic[storyCfg.type] then
    local sectorStageId = storyCfg.set_place
    local sectorstagecfg = ConfigData.sector_stage[storyCfg.set_place]
    if sectorstagecfg == nil then
      error("Cant get sector_stage, storyCfg.set_place = " .. tostring(storyCfg.set_place))
    else
      sectorCfg = ConfigData.sector[sectorstagecfg.sector]
      if sectorCfg == nil then
        error("Cant get sectorCfg, sectorstagecfg.sector = " .. tostring(sectorstagecfg.sector))
      end
    end
  end
  if sectorCfg == nil then
    return
  end
  local sectorName = sectorCfg.name
  local sectorNameEn = sectorCfg.name_en
  local sectorActCoverCfg = ConfigData.sector_act_des_cover[sectorCfg.id]
  if sectorActCoverCfg then
    local actType, actId, actData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(sectorCfg.id)
    if actData and not actData:IsActivityRunningTimeout() then
      sectorName = sectorActCoverCfg.act_name
      sectorNameEn = sectorActCoverCfg.act_name_en
    end
  end
  self.ui.tex_SectorEnName.text = LanguageUtil.GetLocaleText(sectorNameEn)
  self.ui.tex_SectorName:SetIndex(0, LanguageUtil.GetLocaleText(sectorName), tostring(storyCfg.number))
end

function UIAvgSkip:OnClickConfirm()
  local avgctrl = ControllerManager:GetController(ControllerTypeId.Avg)
  if avgctrl ~= nil then
    avgctrl:SkipAvg()
  else
    error("avgctrl nil")
  end
  self:Delete()
end

function UIAvgSkip:OnClickClose()
  self:Delete()
end

function UIAvgSkip:OnDelete()
  base.OnDelete(self)
end

return UIAvgSkip
