local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local CopyProgressRewardView, Super = NewClass("CopyProgressRewardView", BaseView)
CopyProgressRewardView.uiResCls = UI_Chaper_Popup_AwardResource

function CopyProgressRewardView:ctor(data)
  Super.ctor(self)
  self.progressDrops = data.progressDrops
  self.star = data.star
  self.stageGroupTid = data.stageGroupTid
  self.getData = data.getData
  self.starRewardDatas = data.starRewardDatas
end

function CopyProgressRewardView:RegisterNotifications()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  local cellRT = self.ui.UI_Common_Item_WuPin_Type2:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.rewardListView = self:CreateTableview(self.ui.ScrollView_Rewards, function()
    if not self.model.rewardDataList then
      return 0
    end
    return #self.model.rewardDataList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type2)
    local reward = self.model.rewardDataList[index]
    local viewData = {
      itemTid = reward.tid,
      itemCount = reward.count,
      clickFunc = function()
        ItemDataUtils.ShowItemDetailTips(self.binder, cell.gameObject, nil, reward.tid)
      end
    }
    self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, viewData)
    return cell
  end, function()
    return width, height
  end)
end

function CopyProgressRewardView:RegisterEvents()
end

function CopyProgressRewardView:OnEnterView()
  Super.OnEnterView(self)
  self:_InitBg()
end

function CopyProgressRewardView:_InitBg()
  local viewData = {textTitleCN = nil, textTitleEN = nil}
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_Full, CompPublicPopupFullTips, viewData)
end

function CopyProgressRewardView:RefreshOnRendered()
end

function CopyProgressRewardView:OnEnterViewFinished()
end

function CopyProgressRewardView:OnExitView()
  Super.OnExitView(self)
end

return CopyProgressRewardView
