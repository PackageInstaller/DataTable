_class("UIWorldBossDanDetailTipsController", UIController)
UIWorldBossDanDetailTipsController = UIWorldBossDanDetailTipsController

function UIWorldBossDanDetailTipsController:OnShow(uiParams)
  self:UnLock("UIWorldBossDanDetailTipsController")
  local offset = {}
  offset.x = 121
  offset.y = -30
  local strToShow = uiParams[1]
  local anchorPos = uiParams[2]
  self._safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._rectLayoutElement = self:GetUIComponent("LayoutElement", "rect")
  self._intrTex = self:GetUIComponent("UILocalizationText", "intr")
  self._intrTex:SetText(strToShow)
  local safeOffset = {}
  safeOffset.x = 0
  safeOffset.y = 0
  local v2 = Vector2(anchorPos.x + offset.x, offset.y + anchorPos.y)
  local safeRect = self._safeArea.rect
  local layoutElementWidth = self._rectLayoutElement.preferredWidth
  if v2.x > 0 then
    if v2.x + layoutElementWidth * 0.5 > safeRect.width * 0.5 then
      safeOffset.x = safeRect.width * 0.5 - (v2.x + layoutElementWidth * 0.5)
    end
  elseif math.abs(v2.x) + layoutElementWidth * 0.5 > safeRect.width * 0.5 then
    safeOffset.x = math.abs(v2.x) + layoutElementWidth * 0.5 - safeRect.width * 0.5
  end
  if v2.y > 0 then
    if v2.y + self._rect.sizeDelta.y * 0.5 > safeRect.height * 0.5 then
      safeOffset.y = safeRect.height * 0.5 - (v2.y + self._rect.sizeDelta.y * 0.5)
    end
  elseif math.abs(v2.y) + self._rect.sizeDelta.y * 0.5 > safeRect.height * 0.5 then
    safeOffset.y = math.abs(v2.y) + self._rect.sizeDelta.y * 0.5 - safeRect.height * 0.5
  end
  self._rect.anchoredPosition = Vector2(v2.x + safeOffset.x, safeOffset.y + v2.y)
end

function UIWorldBossDanDetailTipsController:OnHide()
  self._intrTex = nil
  self._rect = nil
end

function UIWorldBossDanDetailTipsController:bgOnClick()
  self:CloseDialog()
end

function UIWorldBossDanDetailTipsController:Update()
  local mouse = GameGlobal.EngineInput().mousePresent
  if mouse then
    if GameGlobal.EngineInput().GetMouseButtonDown(0) then
      self:CloseDialog()
    end
  else
    local touchCount = GameGlobal.EngineInput().touchCount
    if 0 < touchCount then
      local touch0 = GameGlobal.EngineInput().GetTouch(0)
      if touch0 and touch0.phase == TouchPhase.Began then
        self:CloseDialog()
      end
    end
  end
end
