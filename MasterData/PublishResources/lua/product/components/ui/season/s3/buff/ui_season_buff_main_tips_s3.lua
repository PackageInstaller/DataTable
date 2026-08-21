_class("UISeasonBuffMainTipsS3", UIController)
UISeasonBuffMainTipsS3 = UISeasonBuffMainTipsS3

function UISeasonBuffMainTipsS3:OnShow(uiParams)
  self._offset = self:GetUIComponent("RectTransform", "offset")
  self.contentText = self:GetUIComponent("UILocalizationText", "Content")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonBuffMainTipsS3:CloseOnClick()
  self:StartTask(function(TT)
    self._anim:Play("uieff_UISeasonBuffMainTipsS3_out")
    YIELD(TT, 200)
    if self.view then
      self:CloseDialog()
    end
  end)
end
