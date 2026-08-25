local BattleReplayWaitPanel, Super = System.NewClass("BattleReplayWaitPanel", UIBasePanel)
BattleReplayWaitPanel.uiResCls = UI_Social_Popup_MatchResource

function BattleReplayWaitPanel:ctor(title, content, cancelCallback)
  Super.ctor(self)
  self.title = title
  self.content = content
  self.cancalCallback = cancelCallback
end

function BattleReplayWaitPanel:OnBind(binder)
  self.binder = binder
  binder:SetActive(self.ui.Text_Info, false)
  binder:SetActive(self.ui.Text_C_Waiting, false)
  binder:SetText(self.ui.Text_Title, self.title)
  binder:SetText(self.ui.Text_PlayerName, self.content)
  binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.OnBtnCancel))
  self:BindTimer()
end

function BattleReplayWaitPanel:BindTimer()
  self._tickTime = 0
  self.binder:BindTimer(1, -1, function()
    self._tickTime = self._tickTime + 1
    self.binder:SetText(self.ui.Text_Time, self._tickTime .. " s")
  end)
  self.binder:SetText(self.ui.Text_Time, self._tickTime .. " s")
end

function BattleReplayWaitPanel:OnBtnCancel()
  self:Close()
  if self.cancalCallback then
    self.cancalCallback()
  end
end

return BattleReplayWaitPanel
