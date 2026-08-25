local MainCopyMonsterDetailItem, Super = System.NewComponent("MainCopyMonsterDetailItem")

function MainCopyMonsterDetailItem:ctor(uiNode, stageId, monsterTid)
  Super.ctor(self)
  self.ui = UI_Chapter_Popup_Blame_TipResource(uiNode)
  self.stageId = stageId
  self.monsterTid = monsterTid
  self.stateList = {}
  self.monsterItem = nil
end

function MainCopyMonsterDetailItem:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(MainCopyMonsterDetailModel, self.monsterTid)
  self:_BindMonsterItem()
  binder:BindToText(self.ui.Text_Name, System.fn(self, self._GetMonsterName))
  binder:BindToText(self.ui.Text_Desc, System.fn(self, self._GetMonsterDesc))
  binder:BindToVisible(self.ui.ScrollView, System.fn(self, self._IsExtraListVisible))
  binder:BindToCircularListView(self.ui.ScrollView, System.fn(self, self._GetExtraList), System.fn(self, self._OnUpdateExtraItem))
end

function MainCopyMonsterDetailItem:_BindMonsterItem()
  self:_UnbindMonsterItem()
  local binder = self.binder
  self.monsterItem = binder:BindComponent(MainCopyMonsterItem(self.ui.UI_Chapter_Item_Monster, self.stageId, self.monsterTid))
end

function MainCopyMonsterDetailItem:_GetExtraList()
  self.stateList = CopyDataUtils.GetMonsterStateComputeList(self.stageId, self.model.monsterTid)
  return self.stateList
end

function MainCopyMonsterDetailItem:_OnUpdateExtraItem(itemBinder, go, index)
  local monsterStateItemUI = UI_Chapter_Item_SkillResource(go)
  local stateCompute = self.stateList[index]
  itemBinder:BindToText(monsterStateItemUI.Text_Name, System.fn(stateCompute, stateCompute.GetBuffName))
  itemBinder:BindToText(monsterStateItemUI.Text_Desc_2, System.fn(stateCompute, stateCompute.GetDesc))
end

function MainCopyMonsterDetailItem:_GetMonsterName()
  do return self.model.GetMonsterName end
  return self.model.GetMonsterName, self.model
end

function MainCopyMonsterDetailItem:_GetMonsterDesc()
  do return self.model.GetMonsterIntro end
  return self.model.GetMonsterIntro, self.model
end

function MainCopyMonsterDetailItem:_GetMonsterTypeName()
  do return self.model.GetMonsterTypeName end
  return self.model.GetMonsterTypeName, self.model
end

function MainCopyMonsterDetailItem:_IsExtraListVisible()
  return self.stateList and #self.stateList > 0
end

function MainCopyMonsterDetailItem:_UnbindMonsterItem()
  if self.monsterItem then
    self.monsterItem:OnUnbind()
    self.monsterItem = nil
  end
end

function MainCopyMonsterDetailItem:_UnbindTagItems()
  if self.tagItems then
    for _, item in ipairs(self.tagItems) do
      item.binder:teardown()
    end
    self.tagItems = nil
  end
end

function MainCopyMonsterDetailItem:SetStageTid(stageId)
  self.stageId = stageId
  if self.monsterItem then
    self.monsterItem:SetStageTid(stageId)
  end
end

function MainCopyMonsterDetailItem:SetMonsterTid(monsterTid)
  if monsterTid == self.model.monsterTid then
    return
  end
  self.model:SetMonsterTid(monsterTid)
  if self.monsterItem then
    self.monsterItem:SetMonsterTid(monsterTid)
  end
  self:_SetMonterTags(monsterTid)
end

function MainCopyMonsterDetailItem:_SetMonterTags(monsterTid)
  local tagList = CopyDataUtils.GetMonsterTagList(monsterTid)
  self:_UnbindTagItems()
  self.tagItems = self.tagItems or {}
  local parent = self.ui.UI_Battle_Group_Tag.transform
  local baseGameObj = self.ui.MonsterTag
  local curChildCount = parent.childCount
  for index, tagTid in ipairs(tagList) do
    local uiNode
    if index <= curChildCount then
      uiNode = parent:GetChild(index - 1).gameObject
    else
      uiNode = self.binder:Instantiate(baseGameObj, parent)
    end
    self.binder:SetActive(uiNode, true)
    local comp = self.binder:BindComponent(UIBattleTagItem(uiNode, tagTid, tagList))
    table.insert(self.tagItems, comp)
  end
  for i = #tagList + 1, parent.childCount do
    local go = parent:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
  self.binder:SetActive(self.ui.UI_Battle_Group_Tag, #self.tagItems > 0)
  local gapx, gapy = 8, 9
  local height = UIUtils.FillContainerToWidth(parent.sizeDelta.x, self.tagItems, gapx, gapy, 0, 0)
  CS.Framework.TransformUtil.SetHeight(parent, height)
  CS.Framework.TransformUtil.SetHeight(self.ui.Group_Location.transform, height + 186)
end

function MainCopyMonsterDetailItem:OnUnbind()
  self:_UnbindMonsterItem()
  self:_UnbindTagItems()
end

return MainCopyMonsterDetailItem
