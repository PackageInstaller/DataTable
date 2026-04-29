_class("UISeasonBuffMainTipsS8", UIController)
UISeasonBuffMainTipsS8 = UISeasonBuffMainTipsS8

function UISeasonBuffMainTipsS8:OnShow(uiParams)
  self._offset = self:GetUIComponent("RectTransform", "offset")
  self.contentText = self:GetUIComponent("UILocalizationText", "Content")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonBuffMainTipsS8:CloseOnClick()
  self:StartTask(function(TT)
    self._anim:Play("uieff_UISeasonBuffMainTipsS5_out")
    YIELD(TT, 200)
    if self.view then
      self:CloseDialog()
    end
  end)
end
