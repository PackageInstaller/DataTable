local CopyVindicateRewardView, Super = NewClass("CopyVindicateRewardView", BaseView)
CopyVindicateRewardView.uiResCls = UI_Vindicate_Popup_RewardResource
local Vector2 = CS.UnityEngine.Vector2
local Z1ButtonState = CommonDefine.Z1ButtonState

function CopyVindicateRewardView:ctor(rewardList)
  Super.ctor(self)
  self.rewardList = rewardList
end

function CopyVindicateRewardView:OnEnterView()
  Super.OnEnterView(self)
  self:InitRewardTableView()
end

function CopyVindicateRewardView:OnExitView()
  Super.OnExitView(self)
end

function CopyVindicateRewardView:RegisterNotifications()
end

function CopyVindicateRewardView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function CopyVindicateRewardView:InitRewardTableView()
  local sizeDelta = self.ui.UI_Common_Item_WuPin_Type2.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self.rewardTableView = self:CreateTableview(self.ui.ScrollView_Award, function()
    return #self.rewardList
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.UI_Common_Item_WuPin_Type2)
    self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, self.rewardList[index])
    return cell
  end, function()
    return w, h
  end)
  AddLuaCompOnce(self.ui.ScrollView_Award, LuaTableRightHorizontal)
  self.rewardTableView:ReloadData()
end

return CopyVindicateRewardView
