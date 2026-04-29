_class("UIN28GronruGameFlash", UIController)
UIN28GronruGameFlash = UIN28GronruGameFlash

function UIN28GronruGameFlash:Constructor()
end

function UIN28GronruGameFlash:OnShow(uiParams)
  self:InitWidget()
  self:Flush()
  AudioHelperController.StopBGM()
end

function UIN28GronruGameFlash:OnHide()
end

function UIN28GronruGameFlash:InitWidget()
  self._uilogo = self:GetGameObject("Logo")
  self._uiflash = self:GetGameObject("Flash")
end

function UIN28GronruGameFlash:Flush()
  self:StartTask(self.ShowGameEnter, self)
end

function UIN28GronruGameFlash:ShowGameEnter(TT)
  self:Lock("UIN28GronruGameFlash:ShowGameEnter")
  YIELD(TT, 4000)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BounceLogo)
  YIELD(TT, 3167)
  self:UnLock("UIN28GronruGameFlash:ShowGameEnter")
  self:ShowDialog(UIStateType.UIN28GronruGameSelectPlayer)
  self:CloseDialog()
end
