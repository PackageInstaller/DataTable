local WorldStageBattleWinTip, Super = System.NewClass("WorldStageBattleWinTip", UIBasePanel)
WorldStageBattleWinTip.uiResCls = UI_Pvp_Popup_SettleResource

function WorldStageBattleWinTip:ctor(callback)
  Super.ctor(self)
  self.callback = callback
  AudioManager.Instance:PostSoundEvent("FIGHT_WIN_MUSIC")
  if bg.isPVP then
    AudioManager.Instance:PostSoundEvent("Set_State_E_Succeed")
  end
end

function WorldStageBattleWinTip:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.callback then
      self.callback()
    end
    self:Close()
  end)
  UIManager.Instance:CloseByUrl(Urls.CopiesAwakerInfoPanelNew)
end

return WorldStageBattleWinTip
