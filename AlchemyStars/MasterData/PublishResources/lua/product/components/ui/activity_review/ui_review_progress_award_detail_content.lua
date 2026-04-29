_class("UIReviewProgressAwardDetailContent", UICustomWidget)
UIReviewProgressAwardDetailContent = UIReviewProgressAwardDetailContent

function UIReviewProgressAwardDetailContent:SetData(uiView, awardTipsCallback, campaignType, itemClassName, itemPrefabName)
  self._uiView = uiView
  self._awardTipsCallback = awardTipsCallback
  self._itemClassName = itemClassName
  self._itemPrefabName = itemPrefabName
  self._reviewData = GameGlobal.GetModule(CampaignModule):GetReviewData():GetActivityByType(campaignType)
  self._campaign = self._reviewData:GetDetailInfo()
  self._progressCom = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_POINT_PROGRESS, 1)
  self._progressInfo = self._progressCom:GetComponentInfo()
  self:_Refresh(true)
end

function UIReviewProgressAwardDetailContent:_Refresh(playAnim)
  self._allAwards = {}
  for progress, award in pairs(self._progressInfo.m_progress_rewards) do
    table.insert(self._allAwards, {
      Progress = progress,
      AwardID = award[1].assetid,
      Count = award[1].count
    })
  end
  table.sort(self._allAwards, function(a, b)
    return a.Progress < b.Progress
  end)
  local uis = UIWidgetHelper.SpawnObjects(self, "awards", self._itemClassName, #self._allAwards, self._itemPrefabName)
  for index, award in ipairs(self._allAwards) do
    uis[index]:SetData(award.AwardID, award.Count, award.Progress, table.icontains(self._progressInfo.m_received_progress, award.Progress), self._reviewData:ProgressPercent() >= award.Progress, self._awardTipsCallback, function(progress)
      self._progressCom:Start_HandleReceiveReward(progress, function(res, rewards)
        self:_OnReceiveRewards(res, rewards)
      end)
    end)
    if playAnim and uis[index].PlayEnterAni then
      uis[index]:PlayEnterAni(index)
    end
  end
end

function UIReviewProgressAwardDetailContent:_OnReceiveRewards(res, rewards)
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    UIActivityHelper.ShowUIGetRewards(rewards)
    self:_Refresh()
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:_Refresh()
    end, function()
      self._uiView:CloseDialog()
    end)
  end
end

function UIReviewProgressAwardDetailContent:CloseOnClick(go)
  local animName, duration = self:_GetCloseAnim()
  if animName and duration then
    UIWidgetHelper.PlayAnimation(self, "_anim", animName, duration, function()
      self._uiView:CloseDialog()
    end)
  else
    self._uiView:CloseDialog()
  end
end

function UIReviewProgressAwardDetailContent:_GetCloseAnim()
  return nil, nil
end
