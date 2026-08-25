local ItemType = CommonDefine.ItemType
local PvPTeamSelectItem, Super = System.NewComponent("PvPTeamSelectItem")

function PvPTeamSelectItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_FormationResource(uiNode)
  self.nameFunc = data.nameFunc
  self.mainIconFunc = data.mainIconFunc
  self.clickFunc = data.clickFunc
  self.isChooseFunc = data.isChooseFunc
  self.isMultiChooseFunc = data.isMultiChooseFunc
  self.isConflictFunc = data.isConflictFunc
  self.itemTypeFunc = data.itemTypeFunc
  self.nameFrameIconFunc = data.nameFrameIconFunc
  self.showNotOwnedIconFunc = data.showNotOwnedIconFunc
  self.isUnlockByBattlePassFunc = data.isUnlockByBattlePassFunc
end

function PvPTeamSelectItem:OnBind(binder)
  self.binder = binder
  local typeToImageUIMap = {
    [ItemType.AwakerItem] = self.ui.Image_Awaken,
    [ItemType.Weapon] = self.ui.Image_Weapon,
    [ItemType.KeeperSkill] = self.ui.Image_Resonance
  }
  for _, ui in pairs(typeToImageUIMap) do
    binder:SetActive(ui, false)
  end
  binder:SetActive(typeToImageUIMap[self.itemTypeFunc()], true)
  binder:BindToText(self.ui.Text_Name, self.nameFunc)
  binder:BindToImage(typeToImageUIMap[self.itemTypeFunc()], self.mainIconFunc)
  binder:BindToImage(self.ui.Image_Name_Frame, function()
    if self.nameFrameIconFunc then
      do return end
      return self.nameFrameIconFunc, nil
    end
  end)
  binder:BindToVisible(self.ui.Image_Name_Frame, function()
    if self.nameFrameIconFunc then
      return self.nameFrameIconFunc() ~= nil
    end
  end)
  binder:BindToVisible(self.ui.Image_Choose, self.isChooseFunc)
  binder:BindToVisible(self.ui.Group_Conflict, self.isConflictFunc)
  binder:BindToVisible(self.ui.Group_Multi_Select, function()
    return self.isMultiChooseFunc and self.isMultiChooseFunc()
  end)
  if self.showNotOwnedIconFunc then
    binder:BindToVisible(self.ui.Image_NotOwn, self.showNotOwnedIconFunc)
  else
    self.ui.Image_NotOwn:SetActive(false)
  end
  binder:BindButtonClick(self.ui.Btn_Click, self.clickFunc)
  binder:BindToVisible(self.ui.TemporaryUnLock, self.isUnlockByBattlePassFunc)
end

return PvPTeamSelectItem
