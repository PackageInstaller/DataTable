local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local OrganizaListCom, Super = NewViewComponent("OrganizaListCom")

function OrganizaListCom:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Item_OrganizeResource(uiNode)
end

function OrganizaListCom:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:UpdateScroll()
end

function OrganizaListCom:UpdateScroll()
  if self.tableView == nil then
    local feature = CommonDefine.FeatureId.CollectionStory
    local key = CommonDefine.WorldStorySubFeature.Organization
    local list = ArtCollectionController.Instance:GetDataSortListByFeature(feature, key)
    local cellRT = self.ui.UI_Collection_Item_Level:GetComponent(TYPEOF_RectTransform)
    local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
    self.tableView = self:CreateTableview(self.ui.ScrollView, function()
      return #list
    end, function(view, index)
      local cell = view:DequeueCell()
      cell = cell or view:AddChild(self.ui.UI_Collection_Item_Level)
      local data = list[index]
      self:AddViewComponentOnce(cell.gameObject, OrganizationItem, data, index)
      return cell
    end, function()
      return width, height
    end)
    self.tableView:ReloadData()
  else
    self.tableView:Refresh()
  end
end

return OrganizaListCom
