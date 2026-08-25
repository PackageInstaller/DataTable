local PvPBattleVictoryPanel, Super = System.NewClass("PvPBattleVictoryPanel", PvPBattleResultBasePanel)
PvPBattleVictoryPanel.uiResCls = UI_Pvp_Popup_VictoryResource

function PvPBattleVictoryPanel:ctor(closeCb)
  Super.ctor(self)
  self.closeCb = closeCb
  AudioManager.Instance:PostSoundEvent("Play_NTC_Ft_FightWin")
end

function PvPBattleVictoryPanel:OnBindDiff(binder)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.closeCb then
      self.closeCb()
      self.closeCb = nil
    end
    self:Close()
  end)
end

return PvPBattleVictoryPanel
