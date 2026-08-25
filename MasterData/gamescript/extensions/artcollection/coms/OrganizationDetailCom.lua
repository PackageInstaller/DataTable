local OrganizationDetailCom, Super = NewViewComponent("OrganizationDetailCom")

function OrganizationDetailCom:ctor(uiNode, view, collectId)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Item_Organize_DetailsResource(uiNode)
  self.collectId = collectId
end

function OrganizationDetailCom:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:InitTitle()
  self:InitIcon()
  self:UpdateScroll()
end

function OrganizationDetailCom:InitIcon()
  local cfg = DT.CollectionHall[self.collectId]
  self:SetImage(self.ui.Image_Icon, cfg.Picture)
end

function OrganizationDetailCom:InitTitle()
  local cfg = DT.CollectionHall[self.collectId]
  self:SetText(self.ui.Text_Title, LT.Text(cfg.Title))
end

function OrganizationDetailCom:GetContentList()
  do return CollectionHallCfgUtils.GetContentList end
  return CollectionHallCfgUtils.GetContentList, self.collectId
end

function OrganizationDetailCom:GetCacheObj()
  local obj = GameObject.Instantiate(self.ui.UI_Collection_Image_Container, self.ui.Content.transform)
  obj:SetActive(true)
  return obj
end

function OrganizationDetailCom:UpdateScroll()
  local list = self:GetContentList()
  self.coms = {}
  for i = 1, #list do
    local obj = self:GetCacheObj()
    self:AddViewComponentOnce(obj, OrganizationDescItem, list[i])
  end
end

return OrganizationDetailCom
