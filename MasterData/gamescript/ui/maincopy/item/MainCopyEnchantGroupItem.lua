local CS = _ENV.CS
local typeof = _ENV.typeof
local RectTransform = CS.UnityEngine.RectTransform
local MainCopyEnchantGroupItem, Super = System.NewComponent("MainCopyEnchantGroupItem")

function MainCopyEnchantGroupItem:ctor(uiNode, model, groupTid)
  Super.ctor(self)
  self.ui = UI_Chapter_Item_EnchantmentResource(uiNode)
  self.model = model
  self.groupTid = groupTid
  self.enchantItemList = {}
end

function MainCopyEnchantGroupItem:OnBind(binder)
  self.binder = binder
  self.rectTransform = self.ui.uiNode:GetComponent(typeof(RectTransform))
  binder:SetText(self.ui.Text_Overview, self.model:GetEnchantGroupName(self.groupTid))
  self:SetEnchantList()
  self.rectTransform.sizeDelta = self.binder:GetPreferredSize(self.ui.uiNode)
end

function MainCopyEnchantGroupItem:SetEnchantList()
  local list = self:_GetEnchantList()
  for i = 1, #list do
    local enchantTid = list[i]
    local item = self.enchantItemList[i]
    
    local function _OnClick()
      if self.model.currSelectEnchantTid == enchantTid then
        return
      end
      self.model:SetCurrSelectEnchantTid(enchantTid)
    end
    
    local function _OnSelect()
      return self.model.currSelectEnchantTid == enchantTid
    end
    
    if not item then
      local itemData = {
        tid = enchantTid,
        clickFunc = _OnClick,
        selectFunc = _OnSelect
      }
      item = self.binder:BindNewComponent(self.ui.Content, CommonEnchantItem, UI_Chaper_Item_Level_EnchantmentResource, itemData)
      self.enchantItemList[i] = item
    else
      item:UpdateTid(enchantTid)
      item:UpdateClickFunc(_OnClick)
      item:UpdateSelectFunc(_OnSelect)
    end
    item:SetActive(true)
  end
  if #self.enchantItemList > #list then
    for i = #list + 1, #self.enchantItemList do
      local item = self.enchantItemList[i]
      if item then
        item:SetActive(false)
      end
    end
  end
end

function MainCopyEnchantGroupItem:_GetEnchantGroupName()
  if not self.model then
    return ""
  end
  do return self.model.GetEnchantGroupName, self.model end
  return self.model.GetEnchantGroupName, self.model, self.groupTid
end

function MainCopyEnchantGroupItem:_GetEnchantList()
  if not self.model then
    return {}
  end
  do return self.model.GetEnchantListByGroup, self.model end
  return self.model.GetEnchantListByGroup, self.model, self.groupTid
end

function MainCopyEnchantGroupItem:GetItemSize()
  if not self.rectTransform then
    return 0, 0
  end
  local sizeDelta = self.rectTransform.sizeDelta
  return sizeDelta.x, sizeDelta.y
end

function MainCopyEnchantGroupItem:OnUnbind()
  if self.enchantItemList then
    for index, _ in pairs(self.enchantItemList) do
      if self.enchantItemList[index] then
        self.enchantItemList[index]:OnUnbind()
        self.enchantItemList[index] = nil
      end
    end
  end
end

return MainCopyEnchantGroupItem
