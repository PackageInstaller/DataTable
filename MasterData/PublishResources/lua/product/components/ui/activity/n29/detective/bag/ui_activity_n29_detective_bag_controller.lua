_class("UIActivityN29DetectiveBagController", UIController)
UIActivityN29DetectiveBagController = UIActivityN29DetectiveBagController

function UIActivityN29DetectiveBagController:Constructor()
  self._isShowClueTab = false
  self._pieceTab = nil
  self._clueTab = nil
end

function UIActivityN29DetectiveBagController:LoadDataOnEnter(TT, res, uiParams)
end

function UIActivityN29DetectiveBagController:OnShow(uiParams)
  self._isShowClueTab = uiParams[1]
  self._compInfo = uiParams[2]
  self._onlyClue = uiParams[3]
  self:_GetComponent()
end

function UIActivityN29DetectiveBagController:OnHide()
end

function UIActivityN29DetectiveBagController:_GetComponent()
  self._pieceContent = self:GetUIComponent("UISelectObjectPath", "piece")
  self._clueContent = self:GetUIComponent("UISelectObjectPath", "clue")
  self._clueMaskObj = self:GetGameObject("clueMask")
  self._pieceMaskObj = self:GetGameObject("pieceMask")
  self._pieceBtnObj = self:GetGameObject("PieceBtn")
  self._clueBtnObj = self:GetGameObject("ClueBtn")
  self._anim = self:GetUIComponent("Animation", "anim")
  if self._isShowClueTab then
    self._clueTab = self._clueContent:SpawnObject("UIActivityN29DetectiveClueTab")
    self._clueTab:SetData(self._compInfo)
    self._clueTab:SetActive(true)
    self._pieceMaskObj:SetActive(true)
  else
    self._pieceTab = self._pieceContent:SpawnObject("UIActivityN29DetectivePieceTab")
    self._pieceTab:SetData(self._compInfo)
    self._pieceTab:SetActive(true)
    self._clueMaskObj:SetActive(true)
  end
  if self._onlyClue then
    self._pieceBtnObj:SetActive(false)
    self._clueBtnObj:SetActive(false)
  end
end

function UIActivityN29DetectiveBagController:Close()
  self:StartTask(self._Close, self)
end

function UIActivityN29DetectiveBagController:_Close(TT)
  self._anim:Play("uieff_UIActivityN29DetectiveBagController_out")
  YIELD(TT, 200)
  self:CloseDialog()
end

function UIActivityN29DetectiveBagController:ClueBtnOnClick()
  if self._isShowClueTab then
    return
  end
  self._isShowClueTab = true
  self:StartTask(self._ClueBtnOnClick, self)
end

function UIActivityN29DetectiveBagController:_ClueBtnOnClick(TT)
  self._pieceTab:SetActive(false, true)
  self._clueMaskObj:SetActive(false)
  YIELD(TT, 200)
  if not self._clueTab then
    self._clueTab = self._clueContent:SpawnObject("UIActivityN29DetectiveClueTab")
    self._clueTab:SetData(self._compInfo)
  end
  self._clueTab:SetActive(true)
  self._pieceMaskObj:SetActive(true)
end

function UIActivityN29DetectiveBagController:PieceBtnOnClick()
  if not self._isShowClueTab then
    return
  end
  self._isShowClueTab = false
  self:StartTask(self._PieceBtnOnClick, self)
end

function UIActivityN29DetectiveBagController:_PieceBtnOnClick(TT)
  self._clueTab:SetActive(false, true)
  self._pieceMaskObj:SetActive(false)
  YIELD(TT, 200)
  if not self._pieceTab then
    self._pieceTab = self._pieceContent:SpawnObject("UIActivityN29DetectivePieceTab")
    self._pieceTab:SetData(self._compInfo)
  end
  self._pieceTab:SetActive(true)
  self._clueMaskObj:SetActive(true)
end
