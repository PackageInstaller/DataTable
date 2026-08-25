local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local SchoolTowerProgressFristRewardView, Super = NewClass("SchoolTowerProgressFristRewardView", SchoolTowerProgressRewardView)
SchoolTowerProgressFristRewardView.uiResCls = UI_Dungeous_Popup_Tips_NewResource

function SchoolTowerProgressFristRewardView:ctor(data)
  Super.ctor(self, data)
  self.showFirstReward = false
  self.stageDataList = data.stageDataList
  self.firstRewardList = self:GetFirstRewardList()
end

function SchoolTowerProgressFristRewardView:OnBuildView()
  Super.OnBuildView(self)
end

function SchoolTowerProgressFristRewardView:RegisterEvents()
  Super.RegisterEvents(self)
end

function SchoolTowerProgressFristRewardView:RegisterNotifications()
  self:AddButtonClickListener(self.ui.Btn_Game, function()
    self.showFirstReward = false
    self:_RefreshPageState()
  end)
  self:AddButtonClickListener(self.ui.Btn_Activity, function()
    self.showFirstReward = true
    self:_RefreshPageState()
  end)
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:_InitFirstRewardListView()
end

function SchoolTowerProgressFristRewardView:_InitFirstRewardListView()
  local cellRT = self.ui.UI_Dungeous_Item_Popup_Award2:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.firstRewardListView = self:CreateTableview(self.ui.ScrollView_Popup_Award_2, function()
    if not self.firstRewardList then
      return 0
    end
    return #self.firstRewardList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Dungeous_Item_Popup_Award2)
    local viewData = self.firstRewardList[index]
    self:AddViewComponentOnce(cell.gameObject, UICompSchoolTowerFirstRewardItem, viewData)
    return cell
  end, function()
    return width, height
  end)
end

function SchoolTowerProgressFristRewardView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshPageState()
  self:_RefreshFirstRewardListView()
end

function SchoolTowerProgressFristRewardView:_RefreshFirstRewardListView()
  self.firstRewardListView:ReloadData()
end

function SchoolTowerProgressFristRewardView:_RefreshPageState()
  self:SetButtonChosen(self.ui.Btn_Game, not self.showFirstReward)
  self:SetButtonChosen(self.ui.Btn_Activity, self.showFirstReward)
  self:SetActive(self.ui.ScrollView_Popup_Award, not self.showFirstReward)
  self:SetActive(self.ui.ScrollView_Popup_Award_2, self.showFirstReward)
  self:SetActive(self.ui.Btn_OneKey, not self.showFirstReward)
end

function SchoolTowerProgressFristRewardView:GetFirstRewardList()
  local rst = {}
  for _, stageData in pairs(self.stageDataList) do
    local stageCfg = DT.Stage[stageData.stageID]
    if not stageCfg.FirstTimeReward then
    else
      local _rewards = {}
      for tid, num in table.iteraDouble(stageCfg.FirstTimeReward) do
        table.insert(_rewards, {tid = tid, num = num})
      end
      local firstReward = {
        isGot = stageData.firstRewardDraw,
        rewards = _rewards,
        stageId = stageData.stageID
      }
      table.insert(rst, firstReward)
    end
  end
  return rst
end

function SchoolTowerProgressFristRewardView:ReqOneKeyReward(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "GainAllStageGroupStarRw", function(_)
    if callback then
      callback()
    end
  end, nil, self.stageGroupTid)
end

return SchoolTowerProgressFristRewardView
