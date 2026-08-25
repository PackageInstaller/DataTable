local CopySmallBranchView, Super = NewClass("CopySmallBranchView", BaseView)
CopySmallBranchView.uiResCls = UI_Copy_BranchSmall_ViewResource

function CopySmallBranchView:ctor(_, targetStageGroupTid)
  Super.ctor(self)
  self._targetStageGroupTid = targetStageGroupTid
end

function CopySmallBranchView:RegisterEvents()
  self.tableview = self:CreateTableview(self.ui.UI_Copy_View, function()
    return self.groupIdList and #self.groupIdList or 0
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.ItemBranch)
    local comp = self:AddViewComponentOnce(cell.gameObject, UICompSubplotGroupItem, self.groupIdList[index])
    self.groupItemComponents[cell] = comp
    return cell
  end, function()
    return 376, 894
  end)
end

function CopySmallBranchView:RefreshOnRendered()
  self:_ReqSubplotBranchStageData()
  self:PlayEnterAnim()
end

function CopySmallBranchView:PlayEnterAnim()
  local gameObjectList = self.tableview:GetVisibleCellsList()
  if not gameObjectList or gameObjectList.Count <= 0 then
    return
  end
  for i = 0, gameObjectList.Count - 1 do
    local obj = gameObjectList[i]
    local comp = self.groupItemComponents[obj]
    if comp then
      comp:PlaySmallItemAnim(i + 1)
    end
  end
end

function CopySmallBranchView:OnEnterView()
  Super.OnEnterView(self)
  self:BindCurrency(self.ui.Guoup_SmallBranch, DT.Constant.SmallSubplotCurrencies.Data)
  self.groupItemComponents = {}
  self.groupIdList = CopyExtModel.Instance:GetSubplotGroupList()
  self:_ReqSubplotBranchStageData()
  self.tableview:ReloadData()
  self:JumpToTargetStageGroup()
end

function CopySmallBranchView:_ReqSubplotBranchStageData()
  CopyController.Instance:ReqSubplotBranchStageData(self.groupIdList)
end

function CopySmallBranchView:JumpToTargetStageGroup()
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

function CopySmallBranchView:OnExitView()
  Super.OnExitView(self)
end

return CopySmallBranchView
