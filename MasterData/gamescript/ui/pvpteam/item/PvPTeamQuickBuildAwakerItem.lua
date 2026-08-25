local PvPTeamQuickBuildAwakerItem, Super = System.NewComponent("PvPTeamQuickBuildAwakerItem")

function PvPTeamQuickBuildAwakerItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_TeamResource(uiNode)
  self.mainIconFunc = data.mainIconFunc
  self.isEmptyFunc = data.isEmptyFunc
  self.textIdFunc = data.textIdFunc
  self.clickFunc = data.clickFunc
  self.nameFrameFunc = data.nameFrameFunc
  self.tidFunc = data.tidFunc
end

function PvPTeamQuickBuildAwakerItem:OnBind(binder)
  self.binder = binder
  binder:BindToVisible(self.ui.Group_Awaken, function()
    return false
  end)
  binder:BindToVisible(self.ui.Image_Thing, function()
    return self.isEmptyFunc() == false
  end)
  binder:BindToVisible(self.ui.Image_Position_Frame, function()
    if self.nameFrameFunc then
      return self.nameFrameFunc() ~= nil
    end
  end)
  binder:BindToImage(self.ui.Image_Awaker, self.mainIconFunc)
  binder:BindToImage(self.ui.Image_Position_Frame, function()
    if self.nameFrameFunc then
      do return end
      return self.nameFrameFunc, nil
    end
  end)
  binder:BindToText(self.ui.Text_Location, self.textIdFunc)
  binder:BindButtonClick(self.ui.Btn_Click, self.clickFunc)
  binder:BindToVisible(self.ui.TemporaryUnLock, function()
    local tid = self.tidFunc()
    do return PVPCollectionDataUtils.IsUnlockByBattlePass end
    return PVPCollectionDataUtils.IsUnlockByBattlePass, tid
  end)
end

return PvPTeamQuickBuildAwakerItem
