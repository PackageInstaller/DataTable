local RewardState = CommonDefine.RewardState
local PVPRankRewardPanel, Super = System.NewClass("PVPRankRewardPanel", BaseView)
PVPRankRewardPanel.uiResCls = UI_Pvp_Popup_Reward_TipsResource

function PVPRankRewardPanel:ctor(seasonModel)
  Super.ctor(self)
  self.seasonModel = seasonModel
end

function PVPRankRewardPanel:OnBuildView()
  Super.OnBuildView(self)
  self:AddButtonClickListener(self.ui.Btn_Mask, function()
    self:Close()
  end)
  if not self.seasonModel or not self.seasonModel.rankRewardGroups then
    self.ui.Text_Time:SetActive(false)
    return
  end
  local baseGameObj = self.ui.UI_Pvp_Item_Reward or self.ui.UI_Pvp_Item_Ranking or self.ui.UI_Pvp_Item_RankAward
  if not baseGameObj then
    self.ui.Text_Time:SetActive(false)
    return
  end
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.tableView = self:CreateTableview(self.ui.ScrollView, function()
    return #self.seasonModel.rankRewardGroups
  end, function(view, idx)
    local cell = self:DequeueCell(view, baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local rewardGroup = self.seasonModel.rankRewardGroups[idx]
    itemComps[gameObj] = self.binder:BindComponent(PVPRankRewardGroupItem(gameObj, rewardGroup, function(reward)
      if reward.receiveState == RewardState.Available then
        self.seasonModel:ReqGainRankReward(reward.rankTid, function()
          local rewardGroupIdx = self.seasonModel:GetFirstAvailableRewardGroupIdx()
          if not rewardGroupIdx then
            RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.PVPRankReward, "red")
          end
        end)
      end
    end))
    return cell
  end, function()
    return itemW, itemH
  end)
  self.tableView:ReloadData()
  self:_RefreshCountdown()
end

function PVPRankRewardPanel:_RefreshCountdown()
  local seasonEndTime = self.seasonModel and self.seasonModel.seasonEndTime or 0
  if 0 == seasonEndTime then
    self.ui.Text_Time:SetActive(false)
    return
  end
  self.ui.Text_Time:SetActive(true)
  self:SetText(self.ui.Text_Time, "")
  local countdown = seasonEndTime - TimeUtils.GetServerTime()
  self:BindTimer(0.033, -1, function()
    countdown = math.max(countdown - 0.033, 0)
    local d, h = TimeUtils.PVPSeasonEnd(countdown)
    self:SetText(self.ui.Text_Time, LT.Textf("PVPRankRewardCountdown", d, h))
  end)
end

function PVPRankRewardPanel:OnExitView()
  Super.OnExitView(self)
end

return PVPRankRewardPanel
