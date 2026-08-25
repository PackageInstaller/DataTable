local LevelUnlockRelicPanel, Super = System.NewClass("LevelUnlockRelicPanel", UIBasePanel)
LevelUnlockRelicPanel.uiResCls = UI_Dbgcopy_Panel_Unlock_CreationResource

function LevelUnlockRelicPanel:ctor(unlockTids, closeCb, title)
  Super.ctor(self)
  self.unlockTids = unlockTids
  self.closeCb = closeCb
  self.title = title
end

function LevelUnlockRelicPanel:OnBind(binder)
  Super.OnBind(self, binder)
  if self.closeCb then
    binder:onDestroy(self.closeCb)
  end
  if not self.unlockTids then
    self.unlockTids = RelicDataUtils.GetUnlockRelics()
  end
  for i = 1, 3 do
    local relicGameObj = self.ui["UI_Dbgcopy_Item_Select_Creation_Quote" .. i]
    local relicTid = self.unlockTids[i]
    relicGameObj:SetActive(nil ~= relicTid)
    if relicTid then
      binder:BindComponent(WorldStageBigRelicItem(relicGameObj, {tid = relicTid}, nil, true))
    end
  end
  if self.title then
    self:SetTitle(self.title)
  end
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function LevelUnlockRelicPanel:SetTitle(title)
  self.binder:SetText(self.ui.Text_Desc, title)
end

return LevelUnlockRelicPanel
