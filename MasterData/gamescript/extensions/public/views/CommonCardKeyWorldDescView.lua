local CS = _ENV.CS
local TYPEOF_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local CommonCardKeyWorldDescView, Super = NewClass("CommonCardKeyWorldDescView", BaseView)
CommonCardKeyWorldDescView.uiResCls = UI_Common_Card_KeywordResource

function CommonCardKeyWorldDescView:ctor(strList, parentNode, extraParam)
  Super.ctor(self)
  self._strList = strList
  self._parentNode = parentNode
  self._extraParam = extraParam or {}
  self._externalCloseCallback = self._extraParam.closeCallback
  self._extraParam.needMoveRootPos = true
  self._extraParam.closeCallback = System.fn(self, self._OnClose)
  self._isClosing = false
end

function CommonCardKeyWorldDescView:OnBuildView()
  self._transform = self.ui.CardKeyWordItem_New_Double.transform
  self._keywordRes = UIBaseResource(self.ui.CardKeyWordItem_New_Double)
  self._scrollRect = self._keywordRes.ScrollView:GetComponent(TYPEOF_ScrollRect)
  self:_AdjustPosition()
  self:AddViewComponent(self.ui.CardKeyWordItem_New_Double, CommonKeyWordDescGroupItem, self._strList, self._extraParam.effectDescGroupList, nil, self._extraParam)
end

function CommonCardKeyWorldDescView:RegisterNotifications()
end

function CommonCardKeyWorldDescView:RegisterEvents()
  self:SetActive(self.ui.Btn_Mask, not self._extraParam.isBanMask)
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self._OnClose))
  if self._extraParam.isBanMask then
    self:AddUICustomInputlistener(self._keywordRes.Content, function(hover)
      if not hover then
        self:_OnClose()
      end
    end)
  end
end

function CommonCardKeyWorldDescView:OnEnterView()
  Super.OnEnterView(self)
end

function CommonCardKeyWorldDescView:OnExitView()
  Super.OnExitView(self)
end

function CommonCardKeyWorldDescView:_OnClose()
  self:Close()
end

function CommonCardKeyWorldDescView:Close()
  if self._isClosing then
    return
  end
  self._isClosing = true
  if self._externalCloseCallback then
    self._externalCloseCallback()
  end
  Super.Close(self)
end

function CommonCardKeyWorldDescView:_GetContentHeight()
  local contentHeight = self._scrollRect.content.transform.sizeDelta.y
  return contentHeight
end

function CommonCardKeyWorldDescView:_AdjustPosition()
  if self._extraParam.lockParentNode then
    self._transform.position = self._extraParam.lockParentNode.transform.position
    return
  end
  local rootPosition = UIUtils.GetRootPosition(self._parentNode)
  local margin = self._extraParam.margin or 0
  local sizeDelta = self.ui.CardKeyWordItem_New_Double.transform.sizeDelta
  local parentSizeDelta = self._parentNode.transform.sizeDelta
  local parentScale = self._parentNode.transform.localScale
  local width = sizeDelta.x
  local UISize = CS.UnityEngine.GameObject.Find("UIRoot").transform.sizeDelta
  local bgWidth = UIRootMgr.GetBGImageWidth()
  local UIwidth = bgWidth < UISize.x and bgWidth or UISize.x
  local bgHeight = UIRootMgr.GetBGImageHeight()
  local UIheight = bgHeight < UISize.y and bgHeight or UISize.y
  local halfWidth = width / 2
  local halfUIwidth = UIwidth / 2
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self._scrollRect.content.gameObject)
  local contentHeight = self:_GetContentHeight()
  if UIheight > contentHeight and self._extraParam.isCenterY then
    local posY = contentHeight / 2
    rootPosition.y = posY
  end
  rootPosition.x = rootPosition.x - halfWidth - margin
  if rootPosition.x - halfWidth < -halfUIwidth or self._extraParam.isForceRight then
    local marginRight = self._extraParam.marginRight or margin
    rootPosition.x = rootPosition.x + width + parentSizeDelta.x * parentScale.x + marginRight * 2
    rootPosition.x = math.min(rootPosition.x, halfUIwidth - halfWidth)
  end
  self._transform.anchoredPosition = rootPosition
end

return CommonCardKeyWorldDescView
