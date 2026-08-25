local ItemType = CommonDefine.ItemType
local PvPTeamQuickBuildWeaponKeeperSkillItem, Super = System.NewComponent("PvPTeamQuickBuildWeaponKeeperSkillItem")

function PvPTeamQuickBuildWeaponKeeperSkillItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_KeyResource(uiNode)
  self.mainIconFunc = data.mainIconFunc
  self.isEmptyFunc = data.isEmptyFunc
  self.clickFunc = data.clickFunc
  self.itemTypeFunc = data.itemTypeFunc
  self.tidFunc = data.tidFunc
end

function PvPTeamQuickBuildWeaponKeeperSkillItem:OnBind(binder)
  self.binder = binder
  local typeToImageUIMap = {
    [ItemType.Weapon] = self.ui.Image_Weapon_Mask,
    [ItemType.KeeperSkill] = self.ui.Image_Key
  }
  binder:BindToRaw(function(cBinder, nVal)
    if nVal and typeToImageUIMap[nVal] then
      cBinder:SetActive(typeToImageUIMap[nVal], true)
    end
  end, function()
    do return end
    return self.itemTypeFunc, nil
  end)
  binder:BindButtonClick(self.ui.Btn_Click, self.clickFunc)
  binder:BindToImage(self.ui.Image_Key, self.mainIconFunc)
  binder:BindToImage(self.ui.Image_Weapon, self.mainIconFunc)
  binder:BindToVisible(self.ui.Image_Thing, function()
    return self.isEmptyFunc and self.isEmptyFunc() == false
  end)
  binder:BindToVisible(self.ui.TemporaryUnLock, function()
    local tid = self.tidFunc()
    do return PVPCollectionDataUtils.IsUnlockByBattlePass end
    return PVPCollectionDataUtils.IsUnlockByBattlePass, tid
  end)
end

return PvPTeamQuickBuildWeaponKeeperSkillItem
