_class("UICreditsEffItem", UICustomWidget)
UICreditsEffItem = UICreditsEffItem

function UICreditsEffItem:OnShow()
  self.tran = self:GetGameObject():GetComponent(typeof(UnityEngine.Transform))
  self._effectLoader = self:GetUIComponent("EffectLoader", "eff")
  self.tranEff = self._effectLoader.transform
end

function UICreditsEffItem:OnHide()
  if self._effectLoader then
    self._effectLoader:DestroyCurrentEffect()
  end
end

function UICreditsEffItem:Flush(txt)
  if string.isnullorempty(txt.text) then
  elseif self._effectLoader then
    self.txtTran = txt.transform
    self._effectLoader:LoadEffect("uieff_UICredits_RTMask")
    if self.tranEff.childCount > 0 then
      local rect = self.tranEff:GetChild(0):GetComponent(typeof(UnityEngine.RectTransform))
      if rect then
        rect.sizeDelta = Vector2(txt.preferredWidth * 2 + 250, rect.sizeDelta.y)
      end
    end
  end
end

function UICreditsEffItem:OnUpdate()
  if self.txtTran then
    self.tran.position = self.txtTran.position
  end
end
