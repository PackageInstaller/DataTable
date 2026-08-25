local PvPTeamBuildAwakerItem, Super = System.NewComponent("PvPTeamBuildAwakerItem", PvPTeamBuildBaseItem)

function PvPTeamBuildAwakerItem:ctor(uiNode, data)
  Super.ctor(self, uiNode, data)
end

function PvPTeamBuildAwakerItem:OnBindExpandPart()
  local binder = self.binder
  binder:BindToVisible(self.ui.Enlightenment_Bg, function()
    return false
  end)
  binder:BindToVisible(self.ui.Image_Awaken, function()
    return true
  end)
  binder:BindToImage(self.ui.Image_Enlightenment, self.awakenIconFunc)
  binder:BindToImage(self.ui.Image_Awaken, self.mainIconFunc)
  binder:BindToVisible(self.ui.Image_Name_Frame, function()
    if self.nameFrameIconFunc then
      return self.nameFrameIconFunc() ~= nil
    end
  end)
  binder:BindToImage(self.ui.Image_Name_Frame, function()
    if self.nameFrameIconFunc then
      do return end
      return self.nameFrameIconFunc, nil
    end
  end)
end

return PvPTeamBuildAwakerItem
