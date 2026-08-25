local PopupLevelUpComp = System.NewClass("PopupLevelUpComp", PopupBaseComp)

function PopupLevelUpComp:ctor()
  self.levelUpQueue = {}
end

function PopupLevelUpComp:OnBind(binder)
  self.binder = binder
  self:BindLevelUp()
end

function PopupLevelUpComp:Clear()
  table.clear(self.levelUpQueue)
end

function PopupLevelUpComp:CheckPopup()
  if #self.levelUpQueue > 0 then
    local oldLevel = self.levelUpQueue[1]
    PlayerDataUtils.ShowInvestigatorLevelUpPanel(function()
      table.remove(self.levelUpQueue, 1)
      self:SetBusy(false)
    end, oldLevel)
    self:SetBusy(true)
  end
end

function PopupLevelUpComp:BindLevelUp()
  self.binder:BindToRaw(function(_, level, _)
    local oldLevel = DataCenter.playerData.DRole.oldLevel or 0
    if 0 ~= oldLevel and oldLevel ~= level then
      self.levelUpQueue[1] = oldLevel
      DataCenter.playerData.DRole.oldLevel = level
    end
  end, function()
    return DataCenter.playerData.DRole.level
  end)
end

return PopupLevelUpComp
