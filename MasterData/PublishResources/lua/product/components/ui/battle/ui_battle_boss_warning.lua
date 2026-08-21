_class("UIBattleBossWarning", UIController)
UIBattleBossWarning = UIBattleBossWarning

function UIBattleBossWarning:OnShow(uiParams)
  local monsterId = uiParams[1]
  local monsterCfg = Cfg.cfg_monster[monsterId]
  if not monsterCfg then
    Log.fatal("can not find monster config, monster id: " .. monsterId)
    self:CloseDialog()
    return
  end
  local monsterClassCfg = Cfg.cfg_monster_class[monsterCfg.ClassID]
  if not monsterClassCfg then
    Log.fatal("can not find monster class config, monster class id: " .. monsterCfg.ClassID)
    self:CloseDialog()
    return
  end
  local monsterName = StringTable.Get(monsterClassCfg.Name)
  local monsterEngName = StringTable.Get(monsterClassCfg.Name .. "_en")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.txtName1 = self:GetUIComponent("UILocalizationText", "txtName1")
  self.txtName2 = self:GetUIComponent("UILocalizationText", "txtName2")
  self.txtName3 = self:GetUIComponent("UILocalizationText", "txtName3")
  self.txtName4 = self:GetUIComponent("UILocalizationText", "txtName4")
  self.txtNameEn = self:GetUIComponent("UILocalizationText", "txtNameEn")
  self.txtName:SetText(monsterName)
  self.txtName1:SetText(monsterName)
  self.txtName2:SetText(monsterName)
  self.txtName3:SetText(monsterName)
  self.txtName4:SetText(monsterName)
  self.txtNameEn:SetText(monsterEngName)
end
