local RewardState = CommonDefine.RewardState
local PVPRankRewardItem, Super = System.NewComponent("PVPRankRewardItem")

function PVPRankRewardItem:ctor(obj, reward, onClickReward)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_DanResource(obj)
  self.reward = reward
  self.onClickReward = onClickReward
end

function PVPRankRewardItem:OnBind(binder)
  binder:BindToRaw(function(childBinder, rankTid)
    local cfg = DT.PVPRank[rankTid]
    childBinder:SetImage(self.ui.Image_Icon, cfg.Icon)
    childBinder:SetImage(self.ui.Image_Level, CommonDefine.PVPRankStageIcon[cfg.Stage])
    childBinder:SetText(self.ui.Text_Dan, LT.Text(cfg.Name))
    self:_BindRewardItem(childBinder, cfg)
  end, function()
    return self.reward.rankTid
  end)
  binder:BindToRaw(function(_, isCurrRank)
    self.ui.Image_Selected:SetActive(isCurrRank)
    self.ui.Image_Current:SetActive(isCurrRank)
  end, function()
    return self.reward.isCurrRank
  end)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    self.onClickReward(self.reward)
  end)
end

function PVPRankRewardItem:_BindRewardItem(binder, rankCfg)
  local itemTid_1 = rankCfg.Award[1]
  local itemCnt_1 = rankCfg.Award[2]
  if itemTid_1 then
    self.ui.WuPin_Type_1:SetActive(true)
    local itemData = {
      itemTid = itemTid_1,
      itemCount = itemCnt_1,
      isShowRing = function()
        return self.reward.receiveState == RewardState.Available
      end,
      isGotFunc = function()
        return self.reward.receiveState == RewardState.Received
      end,
      clickFunc = function()
        self.onClickReward(self.reward)
        if self.reward.receiveState ~= RewardState.Available then
          ItemDataUtils.ShowItemDetailTips(binder, self.ui.WuPin_Type_1, nil, itemTid_1)
        end
      end
    }
    binder:BindComponent(CommonIconItemType2(self.ui.WuPin_Type_1, itemData))
  else
    self.ui.WuPin_Type_1:SetActive(false)
  end
  local itemTid_2 = rankCfg.Award[3]
  local itemCnt_2 = rankCfg.Award[4]
  if itemTid_2 then
    self.ui.WuPin_Type_2:SetActive(true)
    local itemData = {
      itemTid = itemTid_2,
      itemCount = itemCnt_2,
      isShowRing = function()
        return self.reward.receiveState == RewardState.Available
      end,
      isGotFunc = function()
        return self.reward.receiveState == RewardState.Received
      end,
      clickFunc = function()
        self.onClickReward(self.reward)
        if self.reward.receiveState ~= RewardState.Available then
          ItemDataUtils.ShowItemDetailTips(binder, self.ui.WuPin_Type_2, nil, itemTid_2)
        end
      end
    }
    binder:BindComponent(CommonIconItemType2(self.ui.WuPin_Type_2, itemData))
  else
    self.ui.WuPin_Type_2:SetActive(false)
  end
end

return PVPRankRewardItem
