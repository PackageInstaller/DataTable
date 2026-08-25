local WorldStageBattleFailTip, Super = System.NewClass("WorldStageBattleFailTip", UIBasePanel)
WorldStageBattleFailTip.uiResCls = UI_Pvp_Popup_FailResource

function WorldStageBattleFailTip:ctor(callback)
  Super.ctor(self)
  self.callback = callback
  AudioManager.Instance:PostSoundEvent("Play_NTC_Ft_FightLose")
  if bg.isPVP then
    AudioManager.Instance:PostSoundEvent("Set_State_E_Fail")
  end
end

function WorldStageBattleFailTip:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.callback then
      self.callback()
    end
    self:Close()
  end)
  UIManager.Instance:CloseByUrl(Urls.CopiesAwakerInfoPanelNew)
end

return WorldStageBattleFailTip
