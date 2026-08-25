local SubplotAvgReviewView, Super = System.NewClass("SubplotAvgReviewView", BaseView)
SubplotAvgReviewView.uiResCls = UI_Chapter_Review_TipResource

function SubplotAvgReviewView:ctor(stageGroupTid, fromActivityTid)
  Super.ctor(self)
  self.stageGroupTid = stageGroupTid
  self.fromActivityTid = fromActivityTid
  self._reviewAvgTidList = {}
end

function SubplotAvgReviewView:OnBuildView()
end

function SubplotAvgReviewView:OnEnterView()
  self:_UpdateReviewAvgTidList()
  self:_RefreshView()
end

function SubplotAvgReviewView:RegisterNotifications()
end

function SubplotAvgReviewView:RegisterEvents()
  self:_CreateReviewItemView()
  self:AddButtonClickListener(self.ui.Btn_Close, System.fn(self, self.Close))
end

function SubplotAvgReviewView:_UpdateReviewAvgTidList()
  self._reviewAvgTidList = StageGroupCfgUtils.GetShowPopupAvgTids(self.stageGroupTid, self.fromActivityTid)
end

function SubplotAvgReviewView:_RefreshView()
  self.reviewItemListView:ReloadData()
end

function SubplotAvgReviewView:_CreateReviewItemView()
  self.reviewItemListView = self:CreateTableview(self.ui.ReviewView, function()
    return self._reviewAvgTidList and #self._reviewAvgTidList or 0
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.UI_Chapter_Item_Review)
    local uiRes = UI_Chapter_Item_ReviewResource(cell.gameObject)
    local avgTid = self._reviewAvgTidList[index]
    local showIdx = StageGroupCfgUtils.GetAvgIndex(self.stageGroupTid, avgTid)
    self:SetActive(uiRes.Group_Lock, false)
    self:SetActive(uiRes.Com_RedDot, false)
    self:SetText(uiRes.Text_Chapter_Name, LT.Textf("SubPlotAvgPreviewItemName", showIdx))
    self:AddButtonClickListener(uiRes.Btn_Click, function()
      AvgStoryManager.Instance:StartStoryById(avgTid)
    end)
    return cell
  end, function()
    return 528, 134
  end)
end

return SubplotAvgReviewView
