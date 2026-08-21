_class("UICollectCardPop", UIController)
UICollectCardPop = UICollectCardPop

function UICollectCardPop:OnShow(uiParam)
  self._desc = uiParam[1]
  self._sureCb = uiParam[2]
  self._cancelCb = uiParam[3]
  self._title = uiParam[4]
  self:GetComponents()
  self:OnValue()
end

function UICollectCardPop:GetComponents()
  self._titleTex = self:GetUIComponent("UILocalizationText", "Title")
  self._descTex = self:GetUIComponent("UILocalizationText", "Desc")
end

function UICollectCardPop:OnValue()
  if self._title then
    self._titleTex:SetText(self._title)
  end
  if self._desc then
    self._descTex:SetText(self._desc)
  end
end

function UICollectCardPop:SureBtnOnClick(go)
  if self._sureCb then
    self._sureCb()
  end
  self:CloseDialog()
end

function UICollectCardPop:CancelBtnOnClick(go)
  if self._cancelCb then
    self._cancelCb()
  end
  self:CloseDialog()
end

function UICollectCardPop:CloseBtnOnClick(go)
  self:CloseDialog()
end
