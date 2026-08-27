local UINTipsGuide = class("UINTipsGuide", UIBaseNode)

function UINTipsGuide:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self:_DefaultUI()
end

function UINTipsGuide:_DefaultUI()
  self.ui.tween_TipsGuide.gameObject:SetActive(false)
  self.ui.tween_TargetArea.gameObject:SetActive(false)
  self.ui.fXP_UI_Guide3.gameObject:SetActive(false)
end

function UINTipsGuide:ShowUITipsGuideArrow(curTargetTransform, showDir)
  if not self.ui.tween_TipsGuide.gameObject.avtive then
    self.ui.tween_TipsGuide.gameObject:SetActive(true)
  end
  local sizeDelta = curTargetTransform.sizeDelta
  local guideSizeX = self.transform.sizeDelta.x
  local offsetPos
  if showDir == 1 then
    offsetPos = Vector3.New(-(guideSizeX + sizeDelta.y) / 2, 0)
  elseif showDir == 2 then
    offsetPos = Vector3.New((guideSizeX + sizeDelta.x) / 2, 0)
  elseif showDir == 3 then
    offsetPos = Vector3.New((guideSizeX + sizeDelta.y) / 2, 0)
  else
    offsetPos = Vector3.New(-(guideSizeX + sizeDelta.x) / 2, 0)
  end
  local rotZ = showDir * 90
  self.transform.localEulerAngles = Vector3.New(0, 0, rotZ)
  self.transform.anchoredPosition = offsetPos
  self.ui.tween_TipsGuide:DOPlay()
end

function UINTipsGuide:ShowUITipsGuideArea(curTargetTransform)
  local targetPos = curTargetTransform.localPosition
  if not self.ui.tween_TargetArea.gameObject.avtive then
    self.ui.tween_TargetArea.gameObject:SetActive(true)
  end
  self.transform.localPosition = curTargetTransform.localPosition
  self.transform.anchoredPosition = Vector2.zero
  self.ui.tween_TargetArea:DOPlay()
end

function UINTipsGuide:ShowUITipsGuideFX(curTargetTransform)
  local targetPos = curTargetTransform.localPosition
  if not self.ui.fXP_UI_Guide3.gameObject.avtive then
    self.ui.fXP_UI_Guide3.gameObject:SetActive(true)
  end
  self.transform.localPosition = curTargetTransform.localPosition
  self.transform.anchoredPosition = Vector2.zero
  self.ui.fXP_UI_Guide3:Stop()
  self.ui.fXP_UI_Guide3:Play()
end

return UINTipsGuide
