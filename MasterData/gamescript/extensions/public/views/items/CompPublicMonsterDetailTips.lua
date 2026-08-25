local CompPublicMonsterDetailTips, Super = NewViewComponent("CompPublicMonsterDetailTips")
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)

function CompPublicMonsterDetailTips:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Chapter_Popup_Blame_Tip_OptimizedResource(uiNode)
  self.data = data
  self.stateList = {}
end

function CompPublicMonsterDetailTips:OnEnterComponent()
  self:RefreshInfo()
  self:RefreshExtraList()
end

function CompPublicMonsterDetailTips:RegisterEvents()
  self:_CreateStateTableView()
end

function CompPublicMonsterDetailTips:_CreateStateTableView()
  local cellRT = self.ui.UI_Chapter_Item_Skill:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.stateTableView = self:CreateTableview(self.ui.ScrollView, function()
    if not self.stateList then
      return 0
    end
    return #self.stateList
  end, function(tableView, index)
    do return self._ProgressCellAtIndex, self, tableView end
    return self._ProgressCellAtIndex, self, tableView, index
  end, function()
    return width, height
  end)
end

function CompPublicMonsterDetailTips:_ProgressCellAtIndex(tableView, index)
  local cell = tableView:DequeueCell()
  cell = cell or tableView:AddChild(self.ui.UI_Chapter_Item_Skill)
  local stateCompute = self.stateList[index]
  local monsterStateItemUI = UI_Chapter_Item_SkillResource(cell.gameObject)
  self:SetText(monsterStateItemUI.Text_Name, stateCompute:GetBuffName())
  self:SetText(monsterStateItemUI.Text_Desc_2, stateCompute:GetDesc())
  return cell
end

function CompPublicMonsterDetailTips:RefreshExtraList()
end

function CompPublicMonsterDetailTips:RefreshInfo()
  self:LoadAllLangFont(self.ui.Text_Name)
  self:LoadAllLangFont(self.ui.Text_Desc)
  self:SetText(self.ui.Text_Name, CopyDataUtils.GetMonsterName(self.data.monsterTid))
  self:SetText(self.ui.Text_Desc, CopyDataUtils.GetMonsterDesc(self.data.monsterTid))
  local monsterIconData = {
    stageId = self.data.stageId,
    tid = self.data.monsterTid
  }
  self:SetIcon(MaterialIconType.CommonMonster, self.ui.MonsterIconEmpty, monsterIconData)
  self:_SetMonterTags()
end

function CompPublicMonsterDetailTips:_IsExtraListVisible()
  return self.stateList and #self.stateList > 0
end

function CompPublicMonsterDetailTips:_SetMonterTags()
  local tagList = CopyDataUtils.GetMonsterTagList(self.data.monsterTid)
  local childList = {}
  local parent = self.ui.UI_Battle_Group_Tag.transform
  local baseGameObj = self.ui.MonsterTag
  for _, tagTid in ipairs(tagList) do
    local uiNode = self:Instantiate(baseGameObj, parent)
    self:SetActive(uiNode, true)
    local comp = self.binder:BindComponent(UIBattleTagItem(uiNode, tagTid, tagList))
    table.insert(childList, comp)
  end
  self:SetActive(self.ui.UI_Battle_Group_Tag, #childList > 0)
  local gapx, gapy = 8, 9
  local height = UIUtils.FillContainerToWidth(parent.sizeDelta.x, childList, gapx, gapy, 0, 0)
  CS.Framework.TransformUtil.SetHeight(parent, height)
  CS.Framework.TransformUtil.SetHeight(self.ui.Group_Location.transform, height + 186)
end

function CompPublicMonsterDetailTips:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompPublicMonsterDetailTips
