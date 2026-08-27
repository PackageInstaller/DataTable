local UINUnlockedTechLine = class("UINUnlockedTechLine", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINUnlockedTechLine:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_AvgItem, self, self.OnClickTechAvgBtn)
end

function UINUnlockedTechLine:RefreshRowItem(SectorIIData, lineData, resLoader)
  self.sectorIIData = SectorIIData
  self.lineData = lineData
  self.ui.text_name.text = lineData:GetRowName()
  self:RefreshRowTechAvg()
end

function UINUnlockedTechLine:RefreshRowTechAvg()
  local isHaveAvg = self.lineData:GetIsHaveTechAvg()
  self.ui.btn_AvgItem.gameObject:SetActive(isHaveAvg)
  self.ui.obj_lineAvg2Tech:SetActive(isHaveAvg)
  if not isHaveAvg then
    return
  end
  self.ui.tex_chapter.text = self.lineData:GetIsTechAvgName()
  local isUnlock = self.lineData:GetIsTechAvgUnlock()
  local isComplete = self.lineData:GetIsTechAvgCompleted()
  self.ui.obj_AvgLock:SetActive(not isUnlock)
  self.ui.obj_AvgComplete:SetActive(isComplete)
  self.ui.Obj_AvgBlueDot:SetActive(isUnlock and not isComplete)
end

function UINUnlockedTechLine:OnClickTechAvgBtn()
  if not self.lineData:GetIsTechAvgUnlock() then
    local unlockCondition = self.lineData:GetTechAvgUnlockInfo()
    cs_MessageCommon.ShowMessageTipsWithErrorSound(unlockCondition)
    return
  end
  local avgCfg = self.lineData:GetIsTechAvgCfg()
  ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(avgCfg.script_id, avgCfg.id, function()
    AvgUtil.ShowMainCamera(true)
    self.lineData:RefreshTechAvgState()
    self:RefreshRowTechAvg()
    self.sectorIIData:RefreshSectorIIReddot4TechAvg()
  end)
  AvgUtil.ShowMainCamera(false)
end

function UINUnlockedTechLine:OnDelete()
  base.OnDelete(self)
end

return UINUnlockedTechLine
