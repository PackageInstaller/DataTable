_class("UIHomeCommonCloseBtn", UICustomWidget)
UIHomeCommonCloseBtn = UIHomeCommonCloseBtn

function UIHomeCommonCloseBtn:Constructor()
end

function UIHomeCommonCloseBtn:OnShow(uiParams)
  self._square = self:GetGameObject("square")
  self._circle = self:GetGameObject("circle")
  self._help = self:GetGameObject("help")
end

function UIHomeCommonCloseBtn:SetData(_backCB, _helpCB, _circleBtn)
  local showBackBtn = false
  local useCircle = false
  if _backCB then
    showBackBtn = true
  end
  if _circleBtn then
    useCircle = true
  end
  if showBackBtn then
    if useCircle then
      self._circle:SetActive(true)
      self._square:SetActive(false)
    else
      self._square:SetActive(true)
      self._circle:SetActive(false)
    end
  else
    self._square:SetActive(false)
    self._circle:SetActive(false)
  end
  local showHelp = false
  if _helpCB then
    showHelp = true
  end
  self._help:SetActive(showHelp)
  self._backCb = _backCB
  self._helpCb = _helpCB
end

function UIHomeCommonCloseBtn:SquareBtnOnClick(go)
  if self._backCb then
    self._backCb()
  end
end

function UIHomeCommonCloseBtn:CircleBtnOnClick(go)
  if self._backCb then
    self._backCb()
  end
end

function UIHomeCommonCloseBtn:HelpBtnOnClick(go)
  if self._helpCb then
    self._helpCb(go)
  end
end

function UIHomeCommonCloseBtn:OnHide()
  self._backCb = nil
  self._helpCb = nil
end
