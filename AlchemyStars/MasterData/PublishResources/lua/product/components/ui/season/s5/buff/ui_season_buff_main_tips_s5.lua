_class("UISeasonBuffMainTipsS5", UIController)
UISeasonBuffMainTipsS5 = UISeasonBuffMainTipsS5

function UISeasonBuffMainTipsS5:OnShow(uiParams)
  self._offset = self:GetUIComponent("RectTransform", "offset")
  self.contentText = self:GetUIComponent("UILocalizationText", "Content")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonBuffMainTipsS5:CloseOnClick()
  self:StartTask(function(TT)
    self._anim:Play("uieff_UISeasonBuffMainTipsS5_out")
    YIELD(TT, 200)
    if self.view then
      self:CloseDialog()
    end
  end)
end
