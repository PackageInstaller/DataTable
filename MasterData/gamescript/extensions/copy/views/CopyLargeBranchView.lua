local CopyLargeBranchView, Super = NewClass("CopyLargeBranchView", BaseView)
CopyLargeBranchView.uiResCls = UI_Copy_BranchLarge_ViewResource

function CopyLargeBranchView:ctor(_, targetStageGroupTid)
  Super.ctor(self)
  self._targetStageGroupTid = targetStageGroupTid
end

function CopyLargeBranchView:RegisterEvents()
  self.tableview = self:CreateTableview(self.ui.UI_Copy_View, function()
    return self.groupIdList and #self.groupIdList or 0
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.ItemBranch)
    local comp = self:AddViewComponentOnce(cell.gameObject, UICompSubplotGroupItem, self.groupIdList[index])
    self.groupItemComponents[cell] = comp
    return cell
  end, function()
    return 420, 962
  end)
end

function CopyLargeBranchView:RefreshOnRendered()
  self:_ReqSubplotBranchStageData()
  self:PlayEnterAnim()
end

function CopyLargeBranchView:PlayEnterAnim()
  local gameObjectList = self.tableview:GetVisibleCellsList()
  if not gameObjectList or gameObjectList.Count <= 0 then
    return
  end
  for i = 0, gameObjectList.Count - 1 do
    local obj = gameObjectList[i]
    local comp = self.groupItemComponents[obj]
    if comp then
      comp:PlayLargeItemAnim(i + 1)
    end
  end
end

function CopyLargeBranchView:OnEnterView()
  Super.OnEnterView(self)
  self.groupItemComponents = {}
  self.groupIdList = CopyExtModel.Instance:GetSublplotLargeGroupList()
  self:_ReqSubplotBranchStageData()
  self.tableview:ReloadData()
  self:JumpToTargetStageGroup()
  self:BindCurrency(self.ui.Guoup_ItemBranch, DT.Constant.LargeSubplotCurrencies.Data)
end

function CopyLargeBranchView:_ReqSubplotBranchStageData()
  CopyController.Instance:ReqSubplotBranchStageData(self.groupIdList)
end

function CopyLargeBranchView:JumpToTargetStageGroup()
  local targetIdx = 1
  for idx, groupId in ipairs(self.groupIdList or {}) do
    if groupId == self._targetStageGroupTid then
      targetIdx = idx
      break
    end
  end
  self._targetStageGroupTid = nil
  if self.tableview.isReady then
    local offset = self.tableview:GetOffsetByIndex(targetIdx - 1)
    self.tableview:SetOffset(offset, false)
    self:PlayEnterAnim()
  else
    function self.tableview.reloadFinishCallback()
      local offset = self.tableview:GetOffsetByIndex(targetIdx - 1)
      
      self.tableview:SetOffset(offset, false)
      self:PlayEnterAnim()
    end
  end
end

function CopyLargeBranchView:OnExitView()
  Super.OnExitView(self)
end

return CopyLargeBranchView
