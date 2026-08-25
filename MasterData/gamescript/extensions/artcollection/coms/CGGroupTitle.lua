local CGGroupTitle, Super = NewViewComponent("CGGroupTitle")

function CGGroupTitle:ctor(uiNode, view, groupId)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Image_BookmarkResource(uiNode)
  self.groupId = groupId
end

function CGGroupTitle:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:InitLockState()
end

function CGGroupTitle:InitLockState()
  local unlock = ArtCollectionController.Instance:IsUnlock(self.groupId)
  local cfg = DT.CollectionHall[self.groupId]
  local str = LT.Text(cfg.Title)
  if false == unlock or nil == unlock then
    str = StrUtils.Fix2ConfuseText(str)
  end
  self:SetText(self.ui.Text_Name, str)
end

function CGGroupTitle:UpdateShow(groupId)
  self.groupId = groupId
  self:InitLockState()
end

return CGGroupTitle
