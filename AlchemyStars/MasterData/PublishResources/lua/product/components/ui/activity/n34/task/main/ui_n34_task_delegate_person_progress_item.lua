_class("UIN34TaskDelegatePersonProgressItem", UICustomWidget)
UIN34TaskDelegatePersonProgressItem = UIN34TaskDelegatePersonProgressItem

function UIN34TaskDelegatePersonProgressItem:OnShow(uiParams)
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._rewardLoader = self:GetUIComponent("UISelectObjectPath", "Rewards")
  self._rewardGetBtn = self:GetGameObject("RewardGetBtn")
  self._rewardUnComplete = self:GetGameObject("RewardUnComplete")
  self._rewardHasGet = self:GetGameObject("RewardHasGet")
  self._rewardHasGetBG = self:GetGameObject("RewardHasGetBG")
  self._rewardGetBg = self:GetGameObject("RewardGetBg")
  self._rewardUnCompleteBG = self:GetGameObject("RewardUnCompleteBG")
  self._go = self:GetGameObject()
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIN34TaskDelegatePersonProgressItem:SetData(data, callback, itemClickCallback)
  if not data then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._data = data
  self._callback = callback
  self._desLabel:SetText(data:GetDes())
  local status = self._data:GetStatus()
  self._rewardGetBtn:SetActive(false)
  self._rewardUnComplete:SetActive(false)
  self._rewardHasGet:SetActive(false)
  self._rewardHasGetBG:SetActive(false)
  self._rewardGetBg:SetActive(false)
  self._rewardUnCompleteBG:SetActive(false)
  if status == 0 then
    self._rewardUnComplete:SetActive(true)
    self._rewardUnCompleteBG:SetActive(true)
  elseif status == 1 then
    self._rewardGetBtn:SetActive(true)
    self._rewardGetBg:SetActive(true)
  elseif status == 2 then
    self._rewardHasGet:SetActive(true)
    self._rewardHasGetBG:SetActive(true)
  end
  local rewards = self._data:GetRewards()
  self._rewardLoader:SpawnObjects("UIN34TaskDelegatePersonProgressReward", #rewards)
  local items = self._rewardLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetData(rewards[i], function(id, pos)
      if itemClickCallback then
        itemClickCallback(id, pos)
      end
    end)
  end
end

function UIN34TaskDelegatePersonProgressItem:RewardGetBtnOnClick()
  if self._callback then
    self._callback(self._data)
  end
end

function UIN34TaskDelegatePersonProgressItem:PlayAnimation()
  self._anim:Play("uieff_UIN34TaskDelegatePersonProgressItem_in")
end

function UIN34TaskDelegatePersonProgressItem:SetActive(status)
  self._go:SetActive(status)
end
