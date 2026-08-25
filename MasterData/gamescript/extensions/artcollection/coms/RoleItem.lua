local RoleItem, Super = NewViewComponent("RoleItem")

function RoleItem:ctor(uiNode, view, feature, key, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Panel_Role_ItemResource(uiNode)
  self.groupId = data.groupId
  self.list = data.list
  self.feature = feature
  self.key = key
  self.unLock = ArtCollectionController.Instance:IsUnlock(self.groupId)
end

function RoleItem:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:InitShow()
end

function RoleItem:InitShow()
  local cfg = DT.CollectionHall[self.groupId]
  self:SetImage(self.ui.Image_Icon, cfg.Picture)
  local str = LT.Text(cfg.Title)
  if self.unLock == false then
    str = StrUtils.Fix2ConfuseText(str)
  end
  self:SetText(self.ui.Text_Name, str)
  self.ui.Text_Cur:SetActive(self.unLock)
  if self.unLock then
    local finishCnt, totalCnt = ArtCollectionController.Instance:CollectUnlockCntByTids(self.list)
    self:SetText(self.ui.Text_Cur, finishCnt)
    self:SetText(self.ui.Text_Total, "/" .. totalCnt)
  end
  self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, function()
    if not self.unLock then
      return false
    end
    for _, collectId in pairs(self.list) do
      local rst = RedPointDataUtils.IsShowCollectionItem(collectId)
      if rst then
        return rst
      end
    end
    return false
  end)
  self.ui.Group_Mask:SetActive(not self.unLock)
end

function RoleItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, function()
    if self.unLock then
      RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Collection, RedPointDataUtils.RedAttrType.IsNew, self.groupId)
      local data = {
        feature = self.feature,
        key = self.key,
        list = self.list,
        groupId = self.groupId
      }
      UIManager.Instance:Reopen(Urls.CommonConceptView, data)
    else
      Alert.Show(10844)
    end
  end)
end

return RoleItem
