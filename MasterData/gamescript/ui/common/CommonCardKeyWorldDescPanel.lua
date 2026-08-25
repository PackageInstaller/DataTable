local CS = _ENV.CS
local TYPEOF_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local CommonCardKeyWorldDescPanel, Super = System.NewClass("CommonCardKeyWorldDescPanel", UIBasePanel)
CommonCardKeyWorldDescPanel.uiResCls = UI_Common_Card_KeywordResource

function CommonCardKeyWorldDescPanel:ctor(strList, parentNode, extraParam)
  Super.ctor(self)
  self.strList = strList
  self.parentNode = parentNode
  if extraParam and type(extraParam) == "table" then
    self.lockParentNode = extraParam.lockParentNode
    self.margin = extraParam.margin
    self.effectDescGroupList = extraParam.effectDescGroupList
    self.closeCallback = extraParam.closeCallback
  end
  self.extraParam = extraParam or {}
  self.extraParam.needMoveRootPos = true
  self.extraParam.closeCallback = System.fn(self, self.OnClose)
end

function CommonCardKeyWorldDescPanel:OnBind(binder)
  self.transform = self.ui.CardKeyWordItem_New_Double.transform
  local uiRes = UIBaseResource(self.ui.CardKeyWordItem_New_Double)
  self.scrollRect = uiRes.ScrollView:GetComponent(TYPEOF_ScrollRect)
  binder:SetActive(self.ui.Btn_Mask, not self.extraParam.isBanMask)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnClose))
  self:_BindStateList(binder)
  self:_AdjustPosition()
  if self.extraParam.isBanMask then
    self:_BindTouchOutside(binder)
  end
end

function CommonCardKeyWorldDescPanel:_BindStateList(binder)
  binder:BindComponent(require("UI.Common.CommonKeyWordDescGroup")(self.ui.CardKeyWordItem_New_Double, self.strList, self.effectDescGroupList, nil, self.extraParam))
end

function CommonCardKeyWorldDescPanel:_BindTouchOutside(binder)
  local keywordRes = UIBaseResource(self.ui.CardKeyWordItem_New_Double)
  binder:BindUICustomInput(keywordRes.Content, function(hover)
    if not hover then
      self:OnClose()
    end
  end)
end

function CommonCardKeyWorldDescPanel:GetContentHeight()
  local contentHeight = self.scrollRect.content.transform.sizeDelta.y
  return contentHeight
end

function CommonCardKeyWorldDescPanel:_AdjustPosition()
  if not self.lockParentNode then
    local rootPosition = UIUtils.GetRootPosition(self.parentNode)
    local margin = self.margin or 0
    local sizeDelta = self.ui.CardKeyWordItem_New_Double.transform.sizeDelta
    local parentSizeDelta = self.parentNode.transform.sizeDelta
    local parentScale = self.parentNode.transform.localScale
    local width = sizeDelta.x
    local UISize = CS.UnityEngine.GameObject.Find("UIRoot").transform.sizeDelta
    local bgWidth = UIRootMgr.GetBGImageWidth()
    local UIwidth = bgWidth < UISize.x and bgWidth or UISize.x
    local bgHeight = UIRootMgr.GetBGImageHeight()
    local UIheight = bgHeight < UISize.y and bgHeight or UISize.y
    local halfWidth = width / 2
    local halfUIwidth = UIwidth / 2
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.scrollRect.content.gameObject)
    local contentHeight = self:GetContentHeight()
    if UIheight > contentHeight and self.extraParam.isCenterY then
      local posY = contentHeight / 2
      rootPosition.y = posY
    end
    rootPosition.x = rootPosition.x - halfWidth - margin
    if rootPosition.x - halfWidth < -halfUIwidth or self.extraParam.isForceRight then
      local marginRight = self.extraParam.marginRight or margin
      rootPosition.x = rootPosition.x + width + parentSizeDelta.x * parentScale.x + marginRight * 2
      rootPosition.x = math.min(rootPosition.x, halfUIwidth - halfWidth)
    end
    self.transform.anchoredPosition = rootPosition
  else
    self.transform.position = self.lockParentNode.transform.position
  end
end

function CommonCardKeyWorldDescPanel:OnClose()
  if self.closeCallback then
    self.closeCallback()
  end
  self:Close()
end

return CommonCardKeyWorldDescPanel
