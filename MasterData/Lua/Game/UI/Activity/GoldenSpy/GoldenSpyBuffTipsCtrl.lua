local GoldenSpyBuffTipsCtrl = class("GoldenSpyBuffTipsCtrl", BaseCtrl)
local nOffsetBottom = -85
local nContentEdge = -20
local nArrowOffect = 17
local leftSafeEdge = 30
GoldenSpyBuffTipsCtrl.minTipHeight = 87
GoldenSpyBuffTipsCtrl.maxTipHeight = 557
local titleHeight = 240
local MoveUpHeight = 45
GoldenSpyBuffTipsCtrl._mapNodeConfig = {
  btnCloseTips = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePanel"
  },
  TMPBuffName = {sComponentName = "TMP_Text"},
  TMPBuffDes = {sComponentName = "TMP_Text"},
  imgArrow = {
    sComponentName = "RectTransform"
  },
  rtContent = {
    sComponentName = "RectTransform"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot---",
    sComponentName = "RectTransform"
  }
}
GoldenSpyBuffTipsCtrl._mapEventConfig = {}
GoldenSpyBuffTipsCtrl._mapRedDotConfig = {}

function GoldenSpyBuffTipsCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.rtTarget = tbParam[1]
    self.buffId = tbParam[2]
  end
end

function GoldenSpyBuffTipsCtrl:OnEnable()
  self:SetTipsContent()
end

function GoldenSpyBuffTipsCtrl:OnDisable()
end

function GoldenSpyBuffTipsCtrl:OnDestroy()
end

function GoldenSpyBuffTipsCtrl:SetTipsContent()
  NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", true)
  self.sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  NovaAPI.SetTopGridCanvasSorting(self.rtTarget.gameObject, self.sortingOrder)
  local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", self.buffId)
  if buffCfg == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPBuffName, buffCfg.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPBuffDes, buffCfg.Desc)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent, self._mapNode.safeAreaRoot)
  end
  
  cs_coroutine.start(wait)
end

function GoldenSpyBuffTipsCtrl:SetTipsPosition(rtTarget, rtContent, safeAreaRoot)
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
  rtArrow.localScale = Vector3(nFactor, 1, 1)
  local cg = rtContent:GetComponent("CanvasGroup")
  NovaAPI.SetCanvasGroupAlpha(cg, 1)
end

function GoldenSpyBuffTipsCtrl:OnBtnClick_ClosePanel()
  NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", false)
  EventManager.Hit(EventId.ClosePanel, self._panel._nPanelId)
  EventManager.Hit("GoldenSpyBuffTipsClose")
end

return GoldenSpyBuffTipsCtrl
