local RoleGroupCom, Super = NewViewComponent("RoleGroupCom")

function RoleGroupCom:ctor(uiNode, view, feature, key)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Item_RoleResource(uiNode)
  self.feature = feature
  self.key = key
  self.list = ArtCollectionController.Instance:GetDataSortListByFeature(feature, key)
end

function RoleGroupCom:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:UpdateList()
end

function RoleGroupCom:RegisterEvents()
end

function RoleGroupCom:UpdateList()
  for _, data in ipairs(self.list) do
    local obj = self:GetCacheObj()
    self:AddViewComponentOnce(obj, RoleItem, self.feature, self.key, data)
  end
end

function RoleGroupCom:GetCacheObj()
  if self.itemUINode == nil then
    self.itemUINode = self:LoadAsset(UI_Collection_Panel_Role_ItemResource.assetPath)
  end
  local obj = GameObject.Instantiate(self.itemUINode, self.ui.Image_Container.transform)
  obj:SetActive(true)
  return obj
end

function RoleGroupCom:OnExitComponent()
  Super.OnExitComponent(self)
  self.itemUINode = nil
end

return RoleGroupCom
