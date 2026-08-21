_class("UIActivityN21CCLevelAffixGroupItem", UICustomWidget)
UIActivityN21CCLevelAffixGroupItem = UIActivityN21CCLevelAffixGroupItem

function UIActivityN21CCLevelAffixGroupItem:OnShow()
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._itemLoader = self:GetUIComponent("UISelectObjectPath", "Items")
  self._go = self:GetGameObject()
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIActivityN21CCLevelAffixGroupItem:OnHide()
end

function UIActivityN21CCLevelAffixGroupItem:Refresh(affixGroupData, isOpen, playAnim, callback)
  if affixGroupData == nil then
    self._go:SetActive(false)
    return
  end
  if not playAnim then
    self._anim:Play("UIActivityN21CCLevelAffixGroupItem")
  end
  self._affixGroupData = affixGroupData
  self._go:SetActive(true)
  self._iconLoader:LoadImage(UIActivityN21CCConst.GetAffixCategoryIcon(affixGroupData:GetType()))
  self._affixDatas = affixGroupData:GetAffixDatas()
  self._itemLoader:SpawnObjects("UIActivityN21CCLevelAffixItem", #self._affixDatas)
  self._items = self._itemLoader:GetAllSpawnList()
  for i = 1, #self._items do
    local item = self._items[i]
    item:Refresh(self._affixDatas[i], isOpen, playAnim, function(affixData)
      if affixData:IsSelected() then
        affixData:SetSelectStatus(false)
      else
        for j = 1, #self._affixDatas do
          self._affixDatas[j]:SetSelectStatus(false)
        end
        affixData:SetSelectStatus(true)
      end
      for j = 1, #self._items do
        self._items[j]:RefreshSelectStatus()
      end
      if callback then
        callback()
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.N21CCRefreshItemList)
    end)
  end
end

function UIActivityN21CCLevelAffixGroupItem:RefreshData(selectScore)
  if not self._affixGroupData then
    return
  end
  local isOpen = false
  if selectScore >= self._affixGroupData:GetUnLockScore() then
    isOpen = true
  end
  if self._items then
    for i = 1, #self._items do
      local item = self._items[i]
      item:RefreshData(isOpen)
    end
  end
end

function UIActivityN21CCLevelAffixGroupItem:PlayAnim(TT)
  self._anim:Play("UIActivityN21CCLevelAffixGroupItem")
  for i = 1, #self._items do
    self._items[i]:PlayAnim()
    YIELD(TT, 100)
  end
end
