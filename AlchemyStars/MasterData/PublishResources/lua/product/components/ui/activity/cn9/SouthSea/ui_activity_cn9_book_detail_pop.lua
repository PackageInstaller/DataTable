_class("UIActivityCN9BookDetailPop", UIController)
UIActivityCN9BookDetailPop = UIActivityCN9BookDetailPop

function UIActivityCN9BookDetailPop:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIActivityCN9BookDetailPop:OnShow(uiParams)
  self._Name = uiParams[1]
  self._Icon = uiParams[2]
  self._Intro = uiParams[3]
  self:InitWidget()
  self:LoadDetail()
end

function UIActivityCN9BookDetailPop:InitWidget()
  self._RawImage = self:GetUIComponent("RawImageLoader", "Icon")
  self._TitleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self._TipsText = self:GetUIComponent("UILocalizationText", "TipsText")
end

function UIActivityCN9BookDetailPop:LoadDetail()
  self._TitleText:SetText(StringTable.Get(self._Name))
  self._TipsText:SetText(StringTable.Get(self._Intro))
  self._RawImage:LoadImage(self._Icon)
end

function UIActivityCN9BookDetailPop:CloseBtnOnClick(go)
  self:CloseDialog()
end
