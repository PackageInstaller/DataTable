local CommonTipsBaseCtrl = class("CommonTipsBaseCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local nOffsetBottom = -148
local nContentEdge = 4
local nArrowOffect = 9.5
local leftSafeEdge = 30
CommonTipsBaseCtrl.minTipHeight = 300
CommonTipsBaseCtrl.maxTipHeight = 770

function CommonTipsBaseCtrl:EnableGamepadUI(btn, bEnableVirtualMouse)
  if GamepadUIManager.GetInputState() then
    btn.gameObject:SetActive(true)
    GamepadUIManager.EnableGamepadUI("CommonTipsBaseCtrl", self:GetGamepadUINode(), nil, bEnableVirtualMouse, nil, AllEnum.UI_SORTING_ORDER.Tips)
  end
end

function CommonTipsBaseCtrl:DisableGamepadUI()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("CommonTipsBaseCtrl")
  end
end

function CommonTipsBaseCtrl:SetTipsPosition(rtTarget, rtContent, safeAreaRoot)
  local rtTargetRect = rtTarget:GetComponent("RectTransform")
  local rtTipsContent = rtContent:Find("rtTipsPoint/imgTipsBg"):GetComponent("RectTransform")
  local rtArrow = rtContent:Find("rtTipsPoint/imgArrow"):GetComponent("RectTransform")
  local rtTipsPoint = rtContent:Find("rtTipsPoint"):GetComponent("RectTransform")
  local screenHeight = safeAreaRoot.rect.size.y
  local screenWidth = safeAreaRoot.rect.size.x
  local nTipHeight = rtTipsContent.sizeDelta.y
  local nTipWidth = rtTipsContent.sizeDelta.x
  local niconSize = rtTargetRect.sizeDelta.x
  local nIconScale = rtTargetRect.localScale.x
  local nFinalSize = niconSize * nIconScale
  rtContent.sizeDelta = Vector2(nFinalSize, nFinalSize)
  rtContent.position = rtTarget.transform.position
  local nFactor = -1
  if rtContent.anchoredPosition.x + nContentEdge - 0.5 * nFinalSize - nTipWidth - nArrowOffect - leftSafeEdge < -(0.5 * screenWidth) then
    nFactor = 1
  end
  local xPoint = 0.5 * nFinalSize * nFactor
  local xArrow = nArrowOffect * nFactor
  local xTip = 0.5 * nTipWidth * nFactor - nContentEdge * nFactor
  local nTipsContentYOffest = 0
  if rtContent.anchoredPosition.y + nOffsetBottom + nTipHeight > 0.5 * screenHeight - 30 then
    nTipsContentYOffest = rtContent.anchoredPosition.y + nOffsetBottom + nTipHeight - (0.5 * screenHeight - 30)
  elseif rtContent.anchoredPosition.y + nOffsetBottom < -0.5 * screenHeight + 30 then
    nTipsContentYOffest = rtContent.anchoredPosition.y + nOffsetBottom - (-0.5 * screenHeight + 30)
  end
  local yTip = nOffsetBottom - nTipsContentYOffest
  rtTipsPoint.anchoredPosition = Vector2(xPoint, 0)
  rtArrow.anchoredPosition = Vector2(xArrow, 0)
  rtTipsContent.anchoredPosition = Vector2(xTip, yTip)
  rtArrow.localScale = Vector3(-nFactor, 1, 1)
  local cg = rtContent:GetComponent("CanvasGroup")
  NovaAPI.SetCanvasGroupAlpha(cg, 1)
end

return CommonTipsBaseCtrl
