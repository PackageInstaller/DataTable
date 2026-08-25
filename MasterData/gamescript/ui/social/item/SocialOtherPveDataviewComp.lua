local SocialPlayerPveDataviewComp = require("UI.Social.Item.SocialPlayerPveDataviewComp")
local SocialOtherPveDataviewComp, Super = System.NewComponent("SocialOtherPveDataviewComp", SocialPlayerPveDataviewComp)
local SocialPveRecordItem = require("UI.Social.Item.SocialPveRecordItem")

function SocialOtherPveDataviewComp:OnBind(binder)
  self.binder = binder
  self.ui.Group_Null_Black:SetActive(#CopyRecordsModel.Instance:GetOtherRecordWidList() <= 0)
  self.binder:SetText(self.ui.Text_C_NoTask, LT.Text("PvEReplayTabNullDesc"))
  self:CreateTableView()
  self:OnOtherCopyRecordUpdate()
  binder:BindEvent(EventMgr.Instance.OtherCopyRecordUpdate, System.fn(self, self.OnOtherCopyRecordUpdate))
end

function SocialOtherPveDataviewComp:OnOtherCopyRecordUpdate()
  self.pveRecordDatas = CopyRecordsModel.Instance:GetOtherRecords()
  self.tableView:ReloadData()
  self.binder:SetActive(self.ui.Group_Null_Black, 0 == #self.pveRecordDatas)
end

function SocialOtherPveDataviewComp:CreateTableView()
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
    return cell
  end, function(_, _)
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
  
  function self.tableView.onScrollValueChanged(_, vector2)
    if vector2.y < 0 then
      CopyRecordsModel.Instance:ReqOtherNextPageRecords()
    end
  end
end

function SocialOtherPveDataviewComp:Show()
  Super.Show(self)
  self:OnOtherCopyRecordUpdate()
end

return SocialOtherPveDataviewComp
