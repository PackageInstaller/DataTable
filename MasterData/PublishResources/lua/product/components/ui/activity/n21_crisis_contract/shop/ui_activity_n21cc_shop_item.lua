_class("UIActivityN21CCShopItem", UICustomWidget)
UIActivityN21CCShopItem = UIActivityN21CCShopItem

function UIActivityN21CCShopItem:OnShow()
  self._go = self:GetGameObject()
  self._rewardsLoader = self:GetUIComponent("UISelectObjectPath", "Rewards")
  self._normalScoreLabel = self:GetUIComponent("UILocalizationText", "NormalScore")
  self._completeScoreLabel = self:GetUIComponent("UILocalizationText", "CompleteScore")
  self._normalBG = self:GetGameObject("NormalBG")
  self._completeBG = self:GetGameObject("CompleteBG")
  self._nameGo = self:GetGameObject("Name")
  self._completeNameGo = self:GetGameObject("CompleteName")
  self._normalScoreGo = self:GetGameObject("NormalScore")
  self._completeScoreGo = self:GetGameObject("CompleteScore")
  self._btnGet = self:GetGameObject("BtnGet")
  self._unComplete = self:GetGameObject("UnComplete")
  self._hasGet = self:GetGameObject("HasGet")
  self._mask = self:GetGameObject("Mask")
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIActivityN21CCShopItem:OnHide()
end

function UIActivityN21CCShopItem:Refresh(data, callback)
  if data == nil then
    self._go:SetActive(false)
    return
  end
  self._callback = callback
  self._go:SetActive(true)
  self._data = data
  local score = self._data:GetProgress()
  self._normalScoreLabel:SetText(score)
  self._completeScoreLabel:SetText(score)
  self._normalBG:SetActive(false)
  self._completeBG:SetActive(false)
  self._nameGo:SetActive(false)
  self._completeNameGo:SetActive(false)
  self._normalScoreGo:SetActive(false)
  self._completeScoreGo:SetActive(false)
  self._btnGet:SetActive(false)
  self._unComplete:SetActive(false)
  self._hasGet:SetActive(false)
  self._mask:SetActive(false)
  local status = self._data:GetStatus()
  if status == UIActivityN21CCShopRewardStatus.UnComplete then
    self._nameGo:SetActive(true)
    self._normalBG:SetActive(true)
    self._unComplete:SetActive(true)
    self._normalScoreGo:SetActive(true)
  elseif status == UIActivityN21CCShopRewardStatus.HasGet then
    self._completeBG:SetActive(true)
    self._hasGet:SetActive(true)
    self._completeNameGo:SetActive(true)
    self._completeScoreGo:SetActive(true)
    self._mask:SetActive(true)
  elseif status == UIActivityN21CCShopRewardStatus.UnGet then
    self._nameGo:SetActive(true)
    self._normalBG:SetActive(true)
    self._btnGet:SetActive(true)
    self._normalScoreGo:SetActive(true)
  end
  local rewards = data:GetRewards()
  if rewards then
    self._rewardsLoader:SpawnObjects("UIActivityN21CCRewardItem", #rewards)
    local items = self._rewardsLoader:GetAllSpawnList()
    for i = 1, #items do
      local data = rewards[i]
      local item = items[i]
      item:Refresh(data)
    end
  else
    self._rewardsLoader:SpawnObjects("UIActivityN21CCShopItem", 0)
  end
end

function UIActivityN21CCShopItem:BtnGetOnClick()
  if self._callback then
    self._callback(self._data)
  end
end

function UIActivityN21CCShopItem:PlayAnim()
  self._anim:Play("UIActivityN21CCShopItem")
end
