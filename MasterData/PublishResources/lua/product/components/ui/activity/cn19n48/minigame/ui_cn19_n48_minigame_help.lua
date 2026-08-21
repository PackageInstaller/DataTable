_class("UICN19N48MiniGameHelp", UIController)
UICN19N48MiniGameHelp = UICN19N48MiniGameHelp

function UICN19N48MiniGameHelp:Constructor()
  self._dataCount = 0
  self._curIndex = 0
  self._isMoving = false
  self._duration = 0.5
end

function UICN19N48MiniGameHelp:OnShow(uiParams)
  self._cfg = Cfg.cfg_help[uiParams[1]]
  if self._cfg == nil then
    Log.fatal("[error] self._cfg is nil !")
    return
  end
  self._TT = self._cfg.TitleBig
  local count = table.count(self._cfg.TitleSmall)
  self._dataTable = {}
  for i = 1, count do
    self._dataTable[i] = {}
    self._dataTable[i].icon = self._cfg.Icon[i]
    self._dataTable[i].title = self._cfg.TitleSmall[i]
    self._dataTable[i].msg = self._cfg.Intr[i]
  end
  self._lBtnGo = self:GetGameObject("lBtn")
  self._rBtnGo = self:GetGameObject("rBtn")
  self._dataCount = table.count(self._dataTable)
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._contentWidgets = self._content:SpawnObjects("UICN19N48MiniGameHelpItem", self._dataCount)
  for key, widget in pairs(self._contentWidgets) do
    widget:SetData(self._dataTable[key].title, self._dataTable[key].icon, self._dataTable[key].msg, function(drag)
    end)
  end
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self._curIndexText = self:GetUIComponent("UILocalizationText", "Current")
  self._totalIndexText = self:GetUIComponent("UILocalizationText", "Total")
  self._totalIndexText:SetText(self._dataCount)
  self:SetCurIndex(1)
  self._lBtnGo:SetActive(false)
end

function UICN19N48MiniGameHelp:SetCurIndex(index)
  self._curIndex = index
  self._curIndexText:SetText(index)
end

function UICN19N48MiniGameHelp:OnHide()
end

function UICN19N48MiniGameHelp:cgLeftOnClick()
  if self._curIndex <= 1 or self._isMoving then
    return
  end
  self._isMoving = true
  self:SetCurIndex(self._curIndex - 1)
  self._lBtnGo:SetActive(self._curIndex > 1)
  self._rBtnGo:SetActive(true)
  self._contentRect:DOAnchorPosX(-1430 * (self._curIndex - 1), self._duration, false):OnUpdate(function()
    self._isMoving = true
  end):OnComplete(function()
    self._isMoving = false
  end)
end

function UICN19N48MiniGameHelp:cgRightOnClick()
  if self._curIndex >= self._dataCount or self._isMoving then
    return
  end
  self._isMoving = true
  self:SetCurIndex(self._curIndex + 1)
  self._lBtnGo:SetActive(true)
  self._rBtnGo:SetActive(self._curIndex < self._dataCount)
  self._contentRect:DOAnchorPosX(-1430 * (self._curIndex - 1), self._duration, false):OnUpdate(function()
    self._isMoving = true
  end):OnComplete(function()
    self._isMoving = false
  end)
end

function UICN19N48MiniGameHelp:CloseBtnOnClick()
  self:CloseDialog()
end

function UICN19N48MiniGameHelp:_OnDrag(drag)
  if self._isMoving then
    return
  end
  if not drag then
    local index = math.floor(self._contentRect.anchoredPosition.x / -1430) + 1
    if 0 < index and index <= self._dataCount then
      self:SetCurIndex(index)
      self._isMoving = true
      self._scrollRect.horizontal = false
      self._contentRect:DOAnchorPosX(-1430 * (self._curIndex - 1), self._duration, false):OnUpdate(function()
        self._isMoving = true
      end):OnComplete(function()
        self._scrollRect.horizontal = true
        self._isMoving = false
      end)
    end
  end
end
