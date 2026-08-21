_class("UISeasonTransPoint", UICustomWidget)
UISeasonTransPoint = UISeasonTransPoint

function UISeasonTransPoint:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonTransPoint:InitWidget()
  self._rectTransform = self:GetUIComponent("RectTransform", "RectTransform")
  self._unSelectCanvasGroup = self:GetUIComponent("CanvasGroup", "unSelect")
  self._selectGo = self:GetGameObject("select")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UISeasonTransPoint:SetData(cfgEvent, pos, scale, clickCb)
  self._rectTransform.localScale = Vector3(scale, scale, scale)
  self._rectTransform.anchoredPosition = pos
  self._cfgEvent = cfgEvent
  self._clickCb = clickCb
  self._selectGo:SetActive(false)
  self._unSelectCanvasGroup.alpha = 1
end

function UISeasonTransPoint:SetSelect(bSelect)
  if bSelect then
    self._selectGo:SetActive(true)
    self._animation:Play("uianim_UISeasonTransPoint_select")
  else
    self._animation:Play("uianim_UISeasonTransPoint_unSelect")
  end
end

function UISeasonTransPoint:GetCfg()
  return self._cfgEvent
end

function UISeasonTransPoint:BtnOnClick(go)
  if self._clickCb then
    self._clickCb(self)
  end
end
