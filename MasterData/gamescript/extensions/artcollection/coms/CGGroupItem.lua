local CGGroupItem, Super = NewViewComponent("CGGroupItem")

function CGGroupItem:ctor(uiNode, view, list)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Item_Expression_ManageResource(uiNode)
  self.list = list
end

function CGGroupItem:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:UpdateShow(self.list)
end

function CGGroupItem:RegisterEvents()
end

function CGGroupItem:UpdateShow(list)
  self.list = list
  self.comMap = self.comMap and self.comMap or {}
  local uiName = "UI_Collection_Item_Video_"
  local chilCnt = self.ui.Content.transform.childCount
  for i = chilCnt, 1, -1 do
    local cfgId = self.list[i]
    local obj = self.ui[uiName .. i]
    obj:SetActive(nil ~= cfgId)
    if cfgId then
      local com = self.comMap[obj]
      if nil == com then
        local subUI = UI_Collection_Item_VideoResource(obj)
        com = self:AddViewComponentOnce(obj, CGItem, cfgId, subUI)
        self.comMap[obj] = com
      else
        com:UpdateShow(cfgId)
      end
    end
  end
end

return CGGroupItem
