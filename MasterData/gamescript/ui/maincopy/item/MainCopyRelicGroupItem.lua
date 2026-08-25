local CS = _ENV.CS
local typeof = _ENV.typeof
local RectTransform = CS.UnityEngine.RectTransform
local MainCopyRelicGroupItem, Super = System.NewComponent("MainCopyRelicGroupItem")

function MainCopyRelicGroupItem:ctor(uiNode, model, groupTid)
  Super.ctor(self)
  self.ui = UI_Chapter_Item_CreationResource(uiNode)
  self.model = model
  self.groupTid = groupTid
  self.relicItemList = {}
end

function MainCopyRelicGroupItem:OnBind(binder)
  self.binder = binder
  self.rectTransform = self.ui.uiNode:GetComponent(typeof(RectTransform))
  binder:SetText(self.ui.Text_Overview, self.model:GetRelicGroupName(self.groupTid))
  self:SetRelicList()
  self.rectTransform.sizeDelta = self.binder:GetPreferredSize(self.ui.uiNode)
end

function MainCopyRelicGroupItem:SetRelicList()
  local list = self:_GetRelicList()
  for i = 1, #list do
    local relicTid = list[i]
    local item = self.relicItemList[i]
    
    local function _OnClick()
      if self.model.currSelectRelicTid == relicTid then
        return
      end
      self.model:SetCurrSelectRelicTid(relicTid)
    end
    
    local function _OnSelect()
      return self.model.currSelectRelicTid == relicTid
    end
    
    if not item then
      local itemData = {
        itemTid = relicTid,
        clickFunc = _OnClick,
        selectFunc = _OnSelect,
        isRelic = true
      }
      item = self.binder:BindNewComponent(self.ui.Content, CommonIconItemType2, UI_Common_Item_WuPin_Type2Resource, itemData)
      self.relicItemList[i] = item
    else
      item:UpdateItemTid(relicTid)
      item:UpdateClickFunc(_OnClick)
      item:UpdateSelectFunc(_OnSelect)
    end
    item:SetActive(true)
  end
  if #self.relicItemList > #list then
    for i = #list + 1, #self.relicItemList do
      local item = self.relicItemList[i]
      if item then
        item:SetActive(false)
      end
    end
  end
end

function MainCopyRelicGroupItem:_GetRelicGroupName()
  if not self.model then
    return ""
  end
  do return self.model.GetRelicGroupName, self.model end
  return self.model.GetRelicGroupName, self.model, self.groupTid
end

function MainCopyRelicGroupItem:_GetRelicList()
  if not self.model then
    return {}
  end
  do return self.model.GetRelicListByGroup, self.model end
  return self.model.GetRelicListByGroup, self.model, self.groupTid
end

function MainCopyRelicGroupItem:GetItemSize()
  local size = self.binder:GetPreferredSize(self.ui.uiNode)
  return size.x, size.y
end

function MainCopyRelicGroupItem:OnUnbind()
  if self.relicItemList then
    for index, _ in pairs(self.relicItemList) do
      if self.relicItemList[index] then
        self.relicItemList[index]:OnUnbind()
        self.relicItemList[index] = nil
      end
    end
  end
end

return MainCopyRelicGroupItem
