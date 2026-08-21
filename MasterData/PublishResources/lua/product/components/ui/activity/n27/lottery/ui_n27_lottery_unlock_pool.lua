_class("UIN27LotteryUnlockPool", UIController)
UIN27LotteryUnlockPool = UIN27LotteryUnlockPool

function UIN27LotteryUnlockPool:Constructor()
end

function UIN27LotteryUnlockPool:OnShow(uiParams)
  self._txtAnywhereGoto = self:GetUIComponent("UILocalizationText", "txtAnywhereGoto")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._imgLanguageShadowAnimation = self:GetUIComponent("Animation", "imgLanguageShadowAnimation")
  self:StartTask(self.StationPerformanceTask, self)
end

function UIN27LotteryUnlockPool:BtnAnywhereOnClick(go)
  self:StartTask(self.CloseDialogTask, self)
end

function UIN27LotteryUnlockPool:StationPerformanceTask(TT)
  self:Lock("UIN27LotteryUnlockPool:StationPerformance")
  self._txtAnywhereGoto.gameObject:SetActive(false)
  self._animation:Play("uieffanim_UIN27LotteryUnlockPool_in")
  YIELD(TT, 400)
  self._imgLanguageShadowAnimation:Play("uieffanim_UIN27LotteryUnlockPool_imgLanguageShadow_loop")
  YIELD(TT, 100)
  self._txtAnywhereGoto.gameObject:SetActive(true)
  self:UnLock("UIN27LotteryUnlockPool:StationPerformance")
end

function UIN27LotteryUnlockPool:CloseDialogTask(TT)
  self:Lock("UIN27LotteryUnlockPool:CloseDialog")
  self._animation:Play("uieffanim_UIN27LotteryUnlockPool_out")
  YIELD(TT, 367)
  self:CloseDialog()
  YIELD(TT, 200)
  self:CallUIMethod("UIN27LotteryMain", "BtnAnywhereOnClick", go)
  self:UnLock("UIN27LotteryUnlockPool:CloseDialog")
end
