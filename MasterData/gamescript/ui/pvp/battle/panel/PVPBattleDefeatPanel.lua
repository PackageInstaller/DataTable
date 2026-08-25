local PvPBattleDefeatPanel, Super = System.NewClass("PvPBattleDefeatPanel", PvPBattleResultBasePanel)
PvPBattleDefeatPanel.uiResCls = UI_Pvp_Popup_FailResource

function PvPBattleDefeatPanel:ctor(closeCb)
  Super.ctor(self)
  self.closeCb = closeCb
  AudioManager.Instance:PostSoundEvent("Play_NTC_Ft_FightLose")
end

function PvPBattleDefeatPanel:OnBindDiff(binder)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.closeCb then
      self.closeCb()
      self.closeCb = nil
    end
    self:Close()
  end)
end

return PvPBattleDefeatPanel
