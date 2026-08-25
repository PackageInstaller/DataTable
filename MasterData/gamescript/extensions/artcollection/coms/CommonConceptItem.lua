local CommonConceptItem, Super = NewViewComponent("CommonConceptItem")

function CommonConceptItem:ctor(uiNode, view, collectId, curSelectId)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Panel_Main_ItemResource(uiNode)
  self.collectId = collectId
  self.curSelectId = curSelectId
  self.unLock = ArtCollectionController.Instance:IsUnlock(collectId)
end

function CommonConceptItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:InitLockState()
  self:InitRedComp()
  self:UpdateCommonConcept(self.curSelectId)
end

function CommonConceptItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, function()
    if self.unLock then
      RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Collection, RedPointDataUtils.RedAttrType.IsNew, self.collectId)
      self:LocalNotify(NotifyId.OnSelectCommonConcept, self.collectId)
    else
      local collectionHallCfg = CollectionHallCfgUtils.GetCfg(self.collectId)
      if collectionHallCfg and collectionHallCfg.LockTip then
        local lockTip = LT.Text(collectionHallCfg.LockTip)
        Alert.ShowStr(lockTip)
      else
        Alert.Show(10843)
      end
    end
  end)
end

function CommonConceptItem:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnSelectCommonConcept, self.UpdateCommonConcept, self)
end

function CommonConceptItem:UpdateCommonConcept(selectCfgId)
  self.ui.Group_Sel:SetActive(selectCfgId == self.collectId)
  self.curSelectId = selectCfgId
end

function CommonConceptItem:InitLockState()
  self.ui.Group_Mask:SetActive(self.unLock == false)
  local cfg = DT.CollectionHall[self.collectId]
  local str = LT.Text(cfg.Title)
  if self.unLock == false then
    str = StrUtils.Fix2ConfuseText(str)
  end
  self:SetText(self.ui.Text_Name, str)
end

function CommonConceptItem:InitRedComp()
  self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, function()
    if not self.unLock then
      return false
    end
    do return RedPointDataUtils.IsShowCollectionItem end
    return RedPointDataUtils.IsShowCollectionItem, self.collectId
  end)
end

return CommonConceptItem
