_class("UIHelpController", UIController)
UIHelpController = UIHelpController

function UIHelpController:Constructor()
  self._dataCount = 0
  self._currentIndex = 0
  self._items = {}
end

function UIHelpController:OnShow(uiParams)
  self._cfg = Cfg.cfg_help[uiParams[1]]
  if self._cfg == nil then
    Log.fatal("[error] self._cfg is nil !")
    return
  end
  self.atlas = self:GetAsset("UIHelpIntr.spriteatlas", LoadType.SpriteAtlas)
  self._TT = self._cfg.TitleBig
  local count = table.count(self._cfg.TitleSmall)
  self._dataTable = {}
  for i = 1, count do
    self._dataTable[i] = {}
    self._dataTable[i].icon = self._cfg.Icon[i]
    self._dataTable[i].title = self._cfg.TitleSmall[i]
    self._dataTable[i].msg = self._cfg.Intr[i]
  end
  if uiParams[2] then
    self._currentIndex = uiParams[2]
  else
    self._currentIndex = 1
  end
  self._lBtnGo = self:GetGameObject("lBtn")
  self._rBtnGo = self:GetGameObject("rBtn")
  self._dataCount = table.count(self._dataTable)
  self._safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self._canvas = self._safeArea.parent:GetComponent("RectTransform")
  local safesize = self._canvas.rect.size
  safesize.x = safesize.x + 1
  safesize.y = safesize.y + 1
  self.pointParentGO = self:GetGameObject("point")
  self.points = {}
  for index = 1, 10 do
    local trans = GameObjectHelper.FindChild(self.pointParentGO.transform, "p" .. index)
    trans.gameObject:SetActive(false)
    self.points[index] = {}
    self.points[index].trans = trans
    self.points[index].rect = trans:GetComponent("RectTransform")
    self.points[index].image = trans:GetComponent("Image")
  end
  self._scrollViewHelper = H3DScrollViewHelper:New(self, "HelpScrollView", "UIHelpItem", function(index, uiwidget, currentIndex)
    return self:OnShowItem(index, self._TT, uiwidget, currentIndex)
  end)
  self._scrollViewHelper:SetGroupChangedCallback(function(index, item)
    if index + 1 > self._dataCount then
      return
    end
    self:ShowItemData(index + 1)
  end)
  for index = 1, 10 do
    if index <= self._dataCount then
      self.points[index].trans.gameObject:SetActive(true)
    else
      self.points[index].trans.gameObject:SetActive(false)
    end
  end
  self._scrollViewHelper:Init(self._dataCount, self._currentIndex, safesize)
  self._isMoving = false
end

function UIHelpController:ShowItemData(index)
  self:SetPointSelect(self._currentIndex, false)
  self._currentIndex = index
  self:SetPointSelect(self._currentIndex, true)
  if self._items[self._currentIndex] then
    self._items[self._currentIndex]:ResetPos()
  end
  if index - 1 <= 0 then
    self._lBtnGo:SetActive(false)
  else
    self._lBtnGo:SetActive(true)
  end
  if index + 1 > self._dataCount then
    self._rBtnGo:SetActive(false)
  else
    self._rBtnGo:SetActive(true)
  end
end

function UIHelpController:OnHide()
  self._currentIndex = 0
  self._petInfos = nil
  self._dataCount = 0
  self._safeArea = nil
  self._isMoving = false
  self._backBtns = nil
  if self._scrollViewHelper then
    self._scrollViewHelper:Dispose()
  end
end

function UIHelpController:OnShowItem(index, titleBig, uiwidget, currentIndex)
  local title = self._dataTable[index].title
  local icon = self._dataTable[index].icon
  local msg = self._dataTable[index].msg
  uiwidget:SetData(index, titleBig, title, icon, msg)
  self._items[index] = uiwidget
end

function UIHelpController:cgLeftOnClick()
  if self._isMoving then
    return
  end
  if self._currentIndex > 1 then
    self._isMoving = true
    local tempIndex = self._currentIndex - 1
    self._scrollViewHelper:MovePanelToIndex(tempIndex, function()
      self._isMoving = false
      if self._currentIndex ~= tempIndex then
        self:ShowItemData(tempIndex)
      end
    end)
  end
end

function UIHelpController:cgRightOnClick()
  if self._isMoving then
    return
  end
  if self._currentIndex < self._dataCount then
    self._isMoving = true
    local tempIndex = self._currentIndex + 1
    self._scrollViewHelper:MovePanelToIndex(tempIndex, function()
      self._isMoving = false
      if self._currentIndex ~= tempIndex then
        self:ShowItemData(tempIndex)
      end
    end)
  end
end

function UIHelpController:bgOnClick()
  self:CloseDialog()
end

function UIHelpController:SetPointSelect(index, select)
  if select then
    if self.points[index] then
      self.points[index].image.sprite = self.atlas:GetSprite("shop_tuijian_di7")
      self.points[index].rect.sizeDelta = Vector2(74, 39)
    end
  elseif self.points[index] then
    self.points[index].image.sprite = self.atlas:GetSprite("shop_tuijian_di6")
    self.points[index].rect.sizeDelta = Vector2(30, 39)
  end
end
