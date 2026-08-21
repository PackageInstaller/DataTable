_class("UISeasonBuffMainTipsS6", UIController)
UISeasonBuffMainTipsS6 = UISeasonBuffMainTipsS6

function UISeasonBuffMainTipsS6:OnShow(uiParams)
  self._offset = self:GetUIComponent("RectTransform", "offset")
  self.contentText = self:GetUIComponent("UILocalizationText", "Content")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonBuffMainTipsS6:CloseOnClick()
  self:StartTask(function(TT)
    self._anim:Play("uieff_UISeasonBuffMainTipsS5_out")
    YIELD(TT, 200)
    if self.view then
      self:CloseDialog()
    end
  end)
end
