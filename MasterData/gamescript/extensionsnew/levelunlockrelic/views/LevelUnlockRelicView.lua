local LevelUnlockRelicView, Super = NewClass("LevelUnlockRelicView", BaseView)
LevelUnlockRelicView.uiResCls = UI_Dbgcopy_Panel_Unlock_CreationResource

function LevelUnlockRelicView:ctor(unlockTids, closeCb, title)
  Super.ctor(self)
  self._unlockTids = unlockTids
  self._closeCb = closeCb
  self._title = title
end

function LevelUnlockRelicView:OnBuildView()
  Super.OnBuildView(self)
  self:LoadAllLangFont(self.ui.Text_Desc)
  if not self._unlockTids then
    self._unlockTids = RelicDataUtils.GetUnlockRelics()
  end
  for i = 1, 3 do
    local relicGameObj = self.ui["UI_Dbgcopy_Item_Select_Creation_Quote" .. i]
    local relicTid = self._unlockTids[i]
    relicGameObj:SetActive(nil ~= relicTid)
    if relicTid then
      self:AddViewComponent(relicGameObj, RelicItemViewComponent, relicTid)
    end
  end
end

function LevelUnlockRelicView:RegisterNotifications()
end

function LevelUnlockRelicView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function LevelUnlockRelicView:OnEnterView()
  Super.OnEnterView(self)
  if self._title then
    self:SetText(self.ui.Text_Desc, self._title)
  end
end

function LevelUnlockRelicView:OnExitView()
  Super.OnExitView(self)
  if self._closeCb then
    self._closeCb()
    self._closeCb = nil
  end
end

return LevelUnlockRelicView
