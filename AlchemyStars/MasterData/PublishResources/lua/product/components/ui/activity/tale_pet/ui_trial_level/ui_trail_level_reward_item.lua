_class("UITrailLevelRewardItem", UICustomWidget)
UITrailLevelRewardItem = UITrailLevelRewardItem

function UITrailLevelRewardItem:OnShow()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._des = self:GetUIComponent("UILocalizationText", "Des")
  self._hasGetGo = self:GetGameObject("HasGet")
  self._getGo = self:GetGameObject("GetBtn")
  self._unCompleteGo = self:GetGameObject("UnComplete")
  self._redGo = self:GetGameObject("Red")
end

function UITrailLevelRewardItem:Refresh(rewardData)
  self._rewardData = rewardData
  self._name:SetText(rewardData.name)
  self._des:SetText(rewardData.des)
  self._icon:LoadImage(rewardData.icon)
  self:RefreshButtonStatus()
end

function UITrailLevelRewardItem:RefreshButtonStatus()
  self._hasGetGo:SetActive(false)
  self._getGo:SetActive(false)
  self._unCompleteGo:SetActive(false)
  self._redGo:SetActive(false)
  if self._rewardData.status == TrailLevelRewardStatus.UnComplete then
    self._unCompleteGo:SetActive(true)
    self._getGo:SetActive(false)
  elseif self._rewardData.status == TrailLevelRewardStatus.UnGet then
    self._getGo:SetActive(true)
    self._redGo:SetActive(true)
  elseif self._rewardData.status == TrailLevelRewardStatus.HasGet then
    self._hasGetGo:SetActive(true)
  end
end

function UITrailLevelRewardItem:GetBtnOnClick()
  GameGlobal.TaskManager():StartTask(self.GetReward, self)
end

function UITrailLevelRewardItem:GetReward(TT)
  self:Lock("UITrailLevelRewardItem_GetRewarda")
  local talePetModule = GameGlobal.GetModule(TalePetModule)
  local res = talePetModule:ApplyGetReward(TT, self._rewardData.id)
  if res:GetSucc() then
    self._rewardData.status = TrailLevelRewardStatus.HasGet
    self:RefreshButtonStatus()
    local dropId = self._rewardData.dropId
    if dropId then
      local dropDewards = Cfg.cfg_drop({DropID = dropId})
      local rewards = {}
      for i = 1, #dropDewards do
        if dropDewards[i].AssetID and dropDewards[i].AssetID > 0 then
          local asset = RoleAsset:New()
          asset.assetid = dropDewards[i].AssetID
          asset.count = dropDewards[i].MinCount
          rewards[#rewards + 1] = asset
        end
      end
      self:ShowRewards(rewards)
    end
  else
    Log.error("Get Reward Error", res.m_result)
  end
  self:UnLock("UITrailLevelRewardItem_GetRewarda")
end

function UITrailLevelRewardItem:ShowRewards(rewards)
  local petIdList = {}
  local petModule = GameGlobal.GetModule(PetModule)
  for _, reward in pairs(rewards) do
    if petModule:IsPetID(reward.assetid) then
      table.insert(petIdList, reward)
    end
  end
  if table.count(petIdList) > 0 then
    self:ShowDialog("UIPetObtain", petIdList, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", rewards)
    end)
    return
  end
  self:ShowDialog("UIGetItemController", rewards)
end
