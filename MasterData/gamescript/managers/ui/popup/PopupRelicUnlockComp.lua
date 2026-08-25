local PopupRelicUnlockComp = System.NewClass("PopupRelicUnlockComp", PopupBaseComp)

function PopupRelicUnlockComp:ctor()
  self.relicUnlockQueue = {}
end

function PopupRelicUnlockComp:OnBind(binder)
  self.binder = binder
end

function PopupRelicUnlockComp:Clear()
  table.clear(self.levelUpQueue)
end

function PopupRelicUnlockComp:CheckPopup()
  if #self.relicUnlockQueue > 0 then
    self._safeCheckUrl = Urls.LevelUnlockRelicView
    UIManager.Instance:Reopen(Urls.LevelUnlockRelicView, self.relicUnlockQueue, function()
      self.relicUnlockQueue = {}
      self:SetBusy(false)
    end)
    self:SetBusy(true)
  end
end

function PopupRelicUnlockComp:BindLevelUp()
  self.binder:BindToRaw(function(_, level, _)
    local unlockRelics = RelicDataUtils.GetUnlockRelics()
    for i, v in ipairs(unlockRelics) do
      table.insert(self.relicUnlockQueue, v)
    end
  end, function()
    return DataCenter.playerData.DRole.level
  end)
end

return PopupRelicUnlockComp
