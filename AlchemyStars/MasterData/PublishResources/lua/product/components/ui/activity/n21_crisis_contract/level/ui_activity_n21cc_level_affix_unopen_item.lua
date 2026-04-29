_class("UIActivityN21CCLevelAffixUnOpenItem", UICustomWidget)
UIActivityN21CCLevelAffixUnOpenItem = UIActivityN21CCLevelAffixUnOpenItem

function UIActivityN21CCLevelAffixUnOpenItem:OnShow()
  self._go = self:GetGameObject()
  self._titleLabel = self:GetUIComponent("UILocalizationText", "Title")
  self._affixGroupLoader = self:GetUIComponent("UISelectObjectPath", "AffixGroups")
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIActivityN21CCLevelAffixUnOpenItem:OnHide()
end

function UIActivityN21CCLevelAffixUnOpenItem:Refresh(affixGroupDatas, isOpen, playAnim, callback)
  if affixGroupDatas == nil or #affixGroupDatas <= 0 then
    self._go:SetActive(false)
    return
  end
  if not playAnim then
    self._anim:Play("UIActivityN21CCLevelAffixUnOpenItem")
  end
  self._go:SetActive(true)
  self._titleLabel:SetText(StringTable.Get("str_n20_crisis_contract_unopen_affix_groups_title", affixGroupDatas[1]:GetUnLockScore()))
  self._affixGroupLoader:SpawnObjects("UIActivityN21CCLevelAffixGroupItem", #affixGroupDatas)
  self._items = self._affixGroupLoader:GetAllSpawnList()
  for i = 1, #self._items do
    local item = self._items[i]
    item:Refresh(affixGroupDatas[i], isOpen, playAnim, callback)
  end
end

function UIActivityN21CCLevelAffixUnOpenItem:RefreshData(selectScore)
  if self._items then
    for i = 1, #self._items do
      local item = self._items[i]
      item:RefreshData(selectScore)
    end
  end
end

function UIActivityN21CCLevelAffixUnOpenItem:PlayAnim(TT)
  self._anim:Play("UIActivityN21CCLevelAffixUnOpenItem")
  YIELD(TT, 100)
  for i = 1, #self._items do
    self._items[i]:PlayAnim(TT)
  end
end
