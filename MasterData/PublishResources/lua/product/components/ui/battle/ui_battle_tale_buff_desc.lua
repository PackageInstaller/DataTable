_class("UIBattleTaleBuffDesc", UIController)
UIBattleTaleBuffDesc = UIBattleTaleBuffDesc

function UIBattleTaleBuffDesc:OnShow()
  self._textDescTale = self:GetUIComponent("UILocalizationText", "desc_tale")
  self._textDescNormal = self:GetUIComponent("UILocalizationText", "desc_normal")
  local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
  local taleBuffCfgID = matchEnterData:GetTaleBuffCfgID()
  local cfgTaleBuff = Cfg.cfg_trail_level_buff_level[taleBuffCfgID]
  if not cfgTaleBuff then
    Log.exception(self._className, "找不到配置：Cfg.cfg_trail_level_buff_level[", tostring(taleBuffCfgID), "]")
    return
  end
  self._textDescTale:SetText(StringTable.Get(cfgTaleBuff.TalePetBuffDes))
  self._textDescNormal:SetText(StringTable.Get(cfgTaleBuff.NormalPetBuffDes1))
end

function UIBattleTaleBuffDesc:bgOnClick()
  self:CloseDialog()
end
