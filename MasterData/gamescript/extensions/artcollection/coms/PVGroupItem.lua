local T_GridLayoutGroup = typeof(CS.UnityEngine.UI.GridLayoutGroup)
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local PVGroupItem, Super = NewViewComponent("PVGroupItem")

function PVGroupItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Item_PVGroupResource(uiNode)
  self.list = data
end

function PVGroupItem:OnBuildComponent()
  Super.OnBuildComponent(self)
  local gridCom = self.ui.Content:GetComponent(T_GridLayoutGroup)
  if ArtCollectionController.Instance:HasUnlockItemInThisLine(1, self.list, #self.list) then
    local subCellRt = self.ui.Image_Bookmark:GetComponent(TYPEOF_RectTransform)
    local sub_UnlockH = subCellRt.sizeDelta.y
    local size = gridCom.cellSize
    size.y = gridCom.cellSize.y + sub_UnlockH
    gridCom.cellSize = size
  end
  self:UpdateList()
end

function PVGroupItem:RegisterEvents()
end

function PVGroupItem:UpdateList()
  self:InitObj()
  local list = self.list
  for i = 1, #list do
    local data = list[i]
    local obj = self:GetCacheObj()
    self:AddViewComponentOnce(obj, PVItem, data)
  end
end

function PVGroupItem:InitObj()
  self.cacheObj = {}
  local tempTrans = self.ui.Content.transform
  for i = 0, tempTrans.childCount - 1 do
    local go = tempTrans:GetChild(i).gameObject
    go:SetActive(false)
    table.insert(self.cacheObj, go)
  end
end

function PVGroupItem:GetCacheObj()
  local obj = table.remove(self.cacheObj, 1)
  if nil == obj then
    if nil == self.itemUINode then
      self.itemUINode = self:LoadAsset(UI_Collection_Item_PV_SubItemResource.assetPath)
    end
    obj = GameObject.Instantiate(self.itemUINode, self.ui.Content.transform)
  end
  obj:SetActive(true)
  return obj
end

function PVGroupItem:OnExitComponent()
  Super.OnExitComponent(self)
  self.itemUINode = nil
end

return PVGroupItem
