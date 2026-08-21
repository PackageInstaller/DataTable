_class("UICN13PuzzlePieceItem", UICustomWidget)
UICN13PuzzlePieceItem = UICN13PuzzlePieceItem

function UICN13PuzzlePieceItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN13PuzzlePieceItem:InitWidget()
  self.pieceIcon = self:GetUIComponent("RawImageLoader", "PieceIcon")
  self.select = self:GetGameObject("Select")
  self.select:SetActive(false)
  self.rootRectTf = self:GetUIComponent("RectTransform", "Root")
  self.pieceIconRectTf = self:GetUIComponent("RectTransform", "PieceIcon")
end

function UICN13PuzzlePieceItem:SetData(index, data, cb)
  self.pieceData = data
  self.pieceIcon:LoadImage(data.resName)
  self.clickCB = cb
  self.index = index
  local width = 1370
  local hight = 720
  local verCount = self.pieceData.verCount
  local hoCount = self.pieceData.hoCount
  self.singleWidth = width / hoCount
  self.singlehight = hight / verCount
  self.delta = 4.2
  if self.clickCB == nil then
    self.delta = 0
  end
  local targetPosx = (self.singleWidth + self.delta) * (self.pieceData.hoIndex - 1)
  local targetPosy = -(self.singlehight + self.delta) * (self.pieceData.verIndex - 1)
  self.pieceIconRectTf.sizeDelta = Vector2(self.singleWidth, self.singlehight)
  self.pieceIconRectTf.anchoredPosition = Vector2(targetPosx, targetPosy) + Vector2(self.singleWidth / 2 + 15, -self.singlehight / 2 - 10)
end

function UICN13PuzzlePieceItem:TransPiece(datax, datay, index)
  self.select:SetActive(false)
  self.pieceData.hoIndex = datax
  self.pieceData.verIndex = datay
  local targetPosx = (self.singleWidth + self.delta) * (self.pieceData.hoIndex - 1) + 15 + self.singleWidth / 2
  local targetPosy = -(self.singlehight + self.delta) * (self.pieceData.verIndex - 1) - 10 - self.singlehight / 2
  self.pieceIconRectTf:DOAnchorPos(Vector2(targetPosx, targetPosy), 0.5, false)
  self.index = index
end

function UICN13PuzzlePieceItem:PieceIconOnClick(go)
  if self.clickCB == nil then
    self.select:SetActive(false)
  end
  if self.clickCB then
    self.select:SetActive(true)
    self.clickCB(self)
  end
end

function UICN13PuzzlePieceItem:CancleCurPiece()
  self.select:SetActive(false)
end
