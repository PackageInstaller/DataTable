local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local UICompMonsterDetailItem, Super = NewViewComponent("UICompMonsterDetailItem")

function UICompMonsterDetailItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Chapter_Popup_Blame_Tip_NewResource(uiNode)
  self.monsterTid = data.monsterTid
  self.stageId = data.stageId
  self.stateList = CopyDataUtils.GetMonsterStateComputeList(self.stageId, self.monsterTid)
  self.monsterItem = nil
end

function UICompMonsterDetailItem:OnEnterComponent()
  self:RefreshComp()
end

function UICompMonsterDetailItem:RefreshComp()
  local viewData = {
    stageId = self.stageId,
    monsterTid = self.monsterTid
  }
  self:AddViewComponentOnce(self.ui.UI_Chapter_Item_Monster, UICompMonsterItem, viewData)
  self:SetText(self.ui.Text_Name, self:_GetMonsterName())
  self:SetText(self.ui.Text_Desc, self:_GetMonsterDesc())
  self.ui.ScrollView:SetActive(self:_IsExtraListVisible())
  self:_InitStateListView()
end

function UICompMonsterDetailItem:_InitStateListView()
  local cellRT = self.ui.UI_Chapter_Item_Skill:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.stateListView = self:CreateTableview(self.ui.ScrollView, function()
    if not self.stateList then
      return 0
    end
    return #self.stateList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Chapter_Item_Skill)
    local viewData = {
      relicTid = self.model.relicDataList[index],
      hideName = true
    }
    self:AddViewComponentOnce(cell.gameObject, UICompRelicIconItem, viewData)
    local monsterStateItemUI = UI_Chapter_Item_SkillResource(cell.gameObject)
    local stateCompute = self.stateList[index]
    self:SetText(monsterStateItemUI.Text_Name, System.fn(stateCompute, stateCompute.GetBuffName))
    self:SetText(monsterStateItemUI.Text_Desc_2, System.fn(stateCompute, stateCompute.GetDesc))
    return cell
  end, function()
    return width, height
  end)
  self.stateListView:ReloadData()
end

function UICompMonsterDetailItem:SetStageTid(stageId)
  self.stageId = stageId
  self:RefreshComp()
end

function UICompMonsterDetailItem:SetMonsterTid(monsterTid)
  if monsterTid == self.monsterTid then
    return
  end
  self.monsterTid = monsterTid
  self:RefreshComp()
end

function UICompMonsterDetailItem:_GetMonsterDesc()
  do return CopyDataUtils.GetMonsterDesc end
  return CopyDataUtils.GetMonsterDesc, self.monsterTid
end

function UICompMonsterDetailItem:_GetMonsterName()
  do return CopyDataUtils.GetMonsterName end
  return CopyDataUtils.GetMonsterName, self.monsterTid
end

function UICompMonsterDetailItem:_IsExtraListVisible()
  return self.stateList and #self.stateList > 0
end

return UICompMonsterDetailItem
