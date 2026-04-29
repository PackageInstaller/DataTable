_class("UISignInShare", UIController)
UISignInShare = UISignInShare

function UISignInShare:Constructor()
  self._scale = 2.0526
  self._canShare = self:GetModule(ShareModule):CanShare()
end

function UISignInShare:OnShow(uiParams)
  self._day = uiParams[1]
  self:_GetComponents()
  self:_OnValue()
end

function UISignInShare:_GetComponents()
  self._text = self:GetUIComponent("UILocalizationText", "Text")
  self._shareText = self:GetUIComponent("UILocalizationText", "ShareText")
  self._shareBtnGo = self:GetGameObject("ShareBtn")
  self._centerGo = self:GetGameObject("Center")
  self._centerShareGo = self:GetGameObject("CenterShare")
  self._shareImageRect = self:GetUIComponent("RectTransform", "ShareImage")
  self._shareBtnGo:SetActive(self._canShare)
end

function UISignInShare:_OnValue()
  local str = StringTable.Get("str_share_congratulation2", self._day)
  self._text:SetText(str)
  self._shareText:SetText(str)
  self._shareImageRect.sizeDelta = Vector2(self._shareImageRect.sizeDelta.y * self._scale, self._shareImageRect.sizeDelta.y)
  self:_SetShareInfo(true)
end

function UISignInShare:ShareBtnOnClick(go)
  self:Lock("UISignInShare")
  self:StartTask(function(TT)
    self:_SetShareInfo(false)
    YIELD(TT)
    self:ShowDialog("UIShare", self:GetName(), ShareAnchorType.BottomRight, function()
      self:_SetShareInfo(true)
    end, nil, nil, nil, ShareSceneType.SignIn)
    self:UnLock("UISignInShare")
  end, self)
end

function UISignInShare:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UISignInShare:_SetShareInfo(show)
  self._shareBtnGo:SetActive(show and self._canShare)
  self._centerGo:SetActive(show)
  self._centerShareGo:SetActive(not show)
end
