local SocialPlayerPveDataviewComp, Super = System.NewComponent("SocialPlayerPveDataviewComp")

function SocialPlayerPveDataviewComp:ctor(res, model, viewNode)
  Super.ctor(self)
  self.ui = UIBaseResource(res)
  self.viewNodeName = viewNode
  self.model = model
  self.pveRecordDatas = {}
end

function SocialPlayerPveDataviewComp:OnBind(binder)
  self.binder = binder
  self.ui.Group_Null_Black:SetActive(#self.model.pveDetailsList <= 0)
  self.binder:SetText(self.ui.Text_C_NoTask, LT.Text("PvEReplayTabNullDesc"))
  self:CreateTableView()
  self:OnMyCopyRecordUpdate()
  binder:BindEvent(EventMgr.Instance.MyCopyRecordUpdate, System.fn(self, self.OnMyCopyRecordUpdate))
end

function SocialPlayerPveDataviewComp:OnMyCopyRecordUpdate()
  self.pveRecordDatas = CopyRecordsModel.Instance:GetMyRecords()
  self.tableView:ReloadData()
  self.binder:SetActive(self.ui.Group_Null_Black, 0 == #self.pveRecordDatas)
end

function SocialPlayerPveDataviewComp:CreateTableView()
  local baseGameObj = self.ui.UI_Social_Item_PveRecord
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.tableView = self:CreateTableview(self.ui[self.viewNodeName], function()
    return #self.pveRecordDatas
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local recordData = self.pveRecordDatas[index]
    itemComps[gameObj] = self.binder:BindComponent(SocialPveRecordItem(gameObj, recordData, self.model.playerInfoData.facade))
    if index == #self.pveRecordDatas then
      CopyRecordsModel.Instance:ReqMyNextPageRecords()
    end
    return cell
  end, function(_, _)
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function SocialPlayerPveDataviewComp:Show()
  if not self.ui or not self.ui.uiNode then
    return
  end
  self.ui.uiNode:SetActive(true)
  self:OnMyCopyRecordUpdate()
end

function SocialPlayerPveDataviewComp:Hide()
  if not self.ui or not self.ui.uiNode then
    return
  end
  self.ui.uiNode:SetActive(false)
end

function SocialPlayerPveDataviewComp:OnUnbind()
end

return SocialPlayerPveDataviewComp
