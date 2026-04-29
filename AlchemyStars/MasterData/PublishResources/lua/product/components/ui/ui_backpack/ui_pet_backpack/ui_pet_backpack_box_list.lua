_class("UIPetBackPackBoxList", UICustomWidget)
UIPetBackPackBoxList = UIPetBackPackBoxList

function UIPetBackPackBoxList:OnShow(uiParams)
  self._petItemLoader = self:GetUIComponent("UISelectObjectPath", "Pet")
  self._title = self:GetUIComponent("UILocalizationText", "txt")
  self._titleObj = self:GetGameObject("Title")
end

function UIPetBackPackBoxList:OnHide()
end

function UIPetBackPackBoxList:SetData(petList, packBox, scrollRect, previewMode)
  local pet = petList[1]
  local type = petList[2]
  if #pet == 0 then
    self._titleObj:SetActive(false)
    return
  end
  if type then
    self._title:SetText(StringTable.Get("str_item_select_pet_have"))
  else
    self._title:SetText(StringTable.Get("str_item_select_pet_not_have"))
  end
  local items = self._petItemLoader:SpawnObjects("UIPetBackPackBoxItem", #pet)
  for i = 1, #items do
    items[i]:Refresh(packBox, pet[i], scrollRect, previewMode)
  end
end
