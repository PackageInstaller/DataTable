local OrganizationItem, Super = NewViewComponent("OrganizationItem")

function OrganizationItem:ctor(uiNode, view, collectId, index)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Item_LevelResource(uiNode)
  self.collectId = collectId
  self.index = index
  self.unLock = ArtCollectionController.Instance:IsUnlock(collectId)
end

function OrganizationItem:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:InitShow()
end

function OrganizationItem:InitShow()
  local cfg = DT.CollectionHall[self.collectId]
  local showTop = 1 == self.index % 2
  self.ui.UI_Collection_Item_Level_Content_1:SetActive(showTop)
  self.ui.UI_Collection_Item_Level_Content_2:SetActive(not showTop)
  local needUi = showTop and self.ui.UI_Collection_Item_Level_Content_1 or self.ui.UI_Collection_Item_Level_Content_2
  self.contentUI = UI_Collection_Item_Level_ContentResource(needUi)
  self:SetImage(self.contentUI.Image_Icon, cfg.ListPicture)
  self.contentUI.Image_Icon:SetActive(self.unLock)
  local str = LT.Text(cfg.Title)
  if self.unLock == false then
    str = StrUtils.Fix2ConfuseText(str)
  end
  self:SetText(self.contentUI.Text_Name, str)
  self:AddViewComponentOnce(self.contentUI.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, function()
    if not self.unLock then
      return false
    end
    do return RedPointDataUtils.IsShowCollectionItem end
    return RedPointDataUtils.IsShowCollectionItem, self.collectId
  end)
end

function OrganizationItem:RegisterEvents()
  self:AddButtonClickListener(self.contentUI.Button_Click, function()
    if self.unLock then
      RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Collection, RedPointDataUtils.RedAttrType.IsNew, self.collectId)
      UIManager.Instance:Reopen(Urls.OrganizationDetailView, self.collectId)
    else
      local cfg = DT.CollectionHall[self.collectId]
      if cfg and cfg.LockTip then
        local lockTip = LT.Text(cfg.LockTip)
        Alert.ShowStr(lockTip)
      else
        Alert.Show(10843)
      end
    end
  end)
end

return OrganizationItem
