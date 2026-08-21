_class("UISummer1RewardDetailRewivw", UIController)
UISummer1RewardDetailRewivw = UISummer1RewardDetailRewivw

function UISummer1RewardDetailRewivw:OnShow(uiParams)
  self._datas = uiParams[1]
  local s = self:GetUIComponent("UISelectObjectPath", "ItemInfo")
  self._tips = s:SpawnObject("UISelectInfo")
  self._tips:SetType(3)
  local detailObj = self._tips:GetG3CustomPool()
  detailObj.dynamicInfoOfEngine:SetObjectName("UISummer1SelectInfoReview.prefab")
  self._selectDetail = detailObj:SpawnObject("UISummer1SelectInfoReview")
  self._tips._selectInfo.sizeDelta = Vector2(550, 200)
  self._tips:GetOffset()
  local go = self._tips:GetGameObject("g3")
  local tran = go.transform:Find("bg3")
  tran.gameObject:SetActive(false)
  local CanCollect = uiParams[2]
  local rewardLoader = self:GetUIComponent("UISelectObjectPath", "Content")
  rewardLoader:SpawnObjects("UIXH1Summer1RewardItemReview", #self._datas)
  local items = rewardLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetData(self._datas[i], function(matid, pos)
      self:ShowItemInfo(matid, pos)
    end, function(progress)
      if CanCollect then
        CanCollect(progress)
      end
    end)
  end
end

function UISummer1RewardDetailRewivw:GetReward(progress)
  self:StartTask(self.GetRewardCoro, self, progress)
end

function UISummer1RewardDetailRewivw:GetRewardCoro(TT, progress)
  self:Lock("UISummer1Review_GetRewardCoro")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local rewards = self._pointProgressComponent:HandleReceiveReward(TT, res, progress)
  if rewards and 0 < #rewards then
    UIActivityHelper.ShowUIGetRewards(rewards)
    self:RefreshRewards()
  end
  self:UnLock("UISummer1Review_GetRewardCoro")
end

function UISummer1RewardDetailRewivw:OnHide()
end

function UISummer1RewardDetailRewivw:ShowItemInfo(roleAsset, pos)
  if self._tips then
    self._selectDetail:SetData(roleAsset)
    self._tips:OnlyShow(pos)
  end
end

function UISummer1RewardDetailRewivw:BtnCloseOnClick()
  self:CloseDialog()
end
