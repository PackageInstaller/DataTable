local PvPTeamBuildBaseItem, Super = System.NewComponent("PvPTeamBuildBaseItem")

function PvPTeamBuildBaseItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_InformationResource(uiNode)
  self.data = data
  self.mainIconFunc = data.mainIconFunc
  self.nameFunc = data.nameFunc
  self.clickFunc = data.clickFunc
  self.awakenIconFunc = data.awakenIconFunc
  self.isEmptyFunc = data.isEmptyFunc
  self.nameFrameIconFunc = data.nameFrameIconFunc
end

function PvPTeamBuildBaseItem:OnBind(binder)
  self.binder = binder
  self:OnBindBasePart()
  self:OnBindExpandPart()
end

function PvPTeamBuildBaseItem:OnBindBasePart()
  local binder = self.binder
  binder:BindToText(self.ui.Text_Name, self.nameFunc)
  binder:BindButtonClick(self.ui.Btn_Click, self.clickFunc)
  binder:BindToVisible(self.ui.Image_Thing, function()
    return not self.isEmptyFunc()
  end)
  binder:BindToVisible(self.ui.Image_Empty, function()
    do return end
    return self.isEmptyFunc, nil
  end)
  binder:SetActive(self.ui.Image_Weapon, false)
  binder:SetActive(self.ui.Image_Resonance, false)
  binder:SetActive(self.ui.Image_Awaken, false)
  binder:SetActive(self.ui.Image_Name_Frame, false)
  binder:BindToVisible(self.ui.TemporaryUnLock, function()
    local tid = self.data.tidFunc()
    do return PVPCollectionDataUtils.IsUnlockByBattlePass end
    return PVPCollectionDataUtils.IsUnlockByBattlePass, tid
  end)
  binder:BindToVisible(self.ui.Image_NotAvail, function()
    local tid = self.data.tidFunc()
    return not PVPCollectionDataUtils.IsAvailable(tid)
  end)
end

function PvPTeamBuildBaseItem:OnBindExpandPart()
  local binder = self.binder
  binder:BindToVisible(self.ui.Enlightenment_Bg, function()
    return false
  end)
end

return PvPTeamBuildBaseItem
