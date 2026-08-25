local FreeTrialGroup, Super = NewViewComponent("FreeTrialGroup")

function FreeTrialGroup:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeous_Item_TryResource(uiNode)
  self.schoolType = data.schoolType
  self.list = data.list
end

function FreeTrialGroup:OnEnterComponent()
  self:InitObj()
  self:InitCell()
  self:SchoolDesc()
end

function FreeTrialGroup:InitCell()
  local list = self.list
  for i = 1, #list do
    local stageId = list[i]
    local obj = self:GetCacheObj()
    self:AddViewComponentOnce(obj, FreeTrialAwakerItem, stageId)
  end
end

function FreeTrialGroup:InitObj()
  self.cacheObj = {}
  local tempTrans = self.ui.Content.transform
  for i = 0, tempTrans.childCount - 1 do
    local go = tempTrans:GetChild(i).gameObject
    go:SetActive(false)
    table.insert(self.cacheObj, go)
  end
end

function FreeTrialGroup:GetCacheObj()
  local obj = table.remove(self.cacheObj, 1)
  if nil == obj then
    if nil == self.itemUINode then
      self.itemUINode = self:LoadAsset(UI_Dungeous_Item_ExpressionResource.assetPath)
    end
    obj = GameObject.Instantiate(self.itemUINode, self.ui.Content.transform)
  end
  obj:SetActive(true)
  return obj
end

function FreeTrialGroup:SchoolDesc()
  self:SetText(self.ui.Text_Name, AwakerDataUtils.GetSchoolName(self.schoolType))
  self:SetImage(self.ui.Image_Icon, AwakerDataUtils.GetSchoolIcon(self.schoolType))
  local schoolConfig = DT.SchoolConfig[self.schoolType]
  local bgImgPath = CommonDefine.FreeTrialSchoolBgIcon[schoolConfig.NameEn]
  self:SetImage(self.ui.Image_Bookmark, bgImgPath)
end

return FreeTrialGroup
