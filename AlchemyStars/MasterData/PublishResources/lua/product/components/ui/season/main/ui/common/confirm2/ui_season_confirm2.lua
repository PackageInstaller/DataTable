_class("UISeasonConfirm2", UIController)
UISeasonConfirm2 = UISeasonConfirm2

function UISeasonConfirm2:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonConfirm2:OnShow(uiParams)
  self._txtTitle = uiParams[1]
  self._txtContent = uiParams[2]
  self._confirmCb = uiParams[3]
  self._cancleCb = uiParams[4]
  self:InitWidget()
  self.title:SetText(self._txtTitle)
  self.titleShodow:SetText(self._txtTitle)
  self.content:SetText(self._txtContent)
end

function UISeasonConfirm2:InitWidget()
  self.offset = self:GetGameObject("offset")
  self.content = self:GetUIComponent("UILocalizationText", "Content")
  self.title = self:GetUIComponent("UILocalizationText", "Title")
  self.titleShodow = self:GetUIComponent("UILocalizationText", "TitleShodow")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UISeasonConfirm2:CloseOnClick(go)
  self:PlayoutAni(function()
    if self._cancleCb then
      self._cancleCb()
    end
  end)
end

function UISeasonConfirm2:ConfirmOnClick(go)
  self:PlayoutAni(function()
    if self._confirmCb then
      self._confirmCb()
    end
  end)
end

function UISeasonConfirm2:PlayoutAni(cb)
  self:Lock("UISeasonConfirm2_PlayoutAni")
  self._animation:Play("uieff_UISeasonConfirm2_out")
  self:StartTask(function(TT)
    YIELD(TT, 168)
    self:UnLock("UISeasonConfirm2_PlayoutAni")
    self:CloseDialog()
    if cb then
      cb()
    end
  end)
end
