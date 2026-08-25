local UIBattleKeeperRoleAwakeItem, Super = System.NewComponent("UIBattleKeeperRoleAwakeItem", UIBattleKeeperRoleItem)

function UIBattleKeeperRoleAwakeItem:ctor(go, roleInfo, clickFunc)
  Super.ctor(self, go, roleInfo, clickFunc)
end

function UIBattleKeeperRoleAwakeItem:_OnBtnShortPress()
  if self:_CheckInCD() then
    Alert.Show(10615)
    return
  end
  local energyLevel = self:_GetCurKeeperSkillEnergyLevel()
  if energyLevel >= CommonDefine.KeeperSkillEnergyLevel.Pos1 then
    UIManager.Instance:Reopen(Urls.BattleKeeperSkillAwakeTips, self.roleInfo)
  else
    self:_OpenUIBattlePopupKeeperSkillTip()
  end
end

function UIBattleKeeperRoleAwakeItem:_CheckInCD()
  do return bg.battleDataCenter.CheckKeeperSkillAwakeInCD end
  return bg.battleDataCenter.CheckKeeperSkillAwakeInCD, bg.battleDataCenter
end

return UIBattleKeeperRoleAwakeItem
