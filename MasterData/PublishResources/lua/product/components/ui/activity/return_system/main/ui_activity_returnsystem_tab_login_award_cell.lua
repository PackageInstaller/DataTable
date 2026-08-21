_class("UIActivityReturnSystemTabLoginAwardCell", UICustomWidget)
UIActivityReturnSystemTabLoginAwardCell = UIActivityReturnSystemTabLoginAwardCell

function UIActivityReturnSystemTabLoginAwardCell:Constructor()
  self.imgPetOffset = Vector2(0, -200)
end

function UIActivityReturnSystemTabLoginAwardCell:OnShow()
  self.imgBG = self:GetGameObject("imgBG")
  self.imgBGLight = self:GetGameObject("imgBGLight")
  self.txtDay = self:GetUIComponent("UILocalizationText", "txtDay")
  self.imgPet = self:GetUIComponent("RawImageLoader", "imgPet")
  self.tranPet = self:GetGameObject("imgPet"):GetComponent(typeof(UnityEngine.RectTransform))
  self.tranPet.anchoredPosition = self.imgPetOffset
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.awards = self:GetUIComponent("UISelectObjectPath", "awards")
  self.got = self:GetGameObject("got")
  self.canGet = self:GetGameObject("canGet")
  self.locked = self:GetGameObject("locked")
end

function UIActivityReturnSystemTabLoginAwardCell:OnHide()
  if self.imgPet then
    self.imgPet:DestoryLastImage()
    self.imgPet = nil
  end
end

function UIActivityReturnSystemTabLoginAwardCell:Flush(loginAward, getRewardCallback, tipsCallback)
  self.loginAward = loginAward
  self._getRewardCallback = getRewardCallback
  self._tipsCallback = tipsCallback
  if loginAward.status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV then
    self.imgBG:SetActive(false)
    self.imgBGLight:SetActive(true)
  else
    self.imgBG:SetActive(true)
    self.imgBGLight:SetActive(false)
  end
  local day = loginAward.day
  self.txtDay:SetText("Day " .. day)
  self.imgPet:DestoryLastImage()
  self.imgPet:LoadImage(loginAward.petIcon)
  self.txtName:SetText(loginAward.petAwardName)
  self:FlushAwards(loginAward.awards)
  if loginAward.status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED then
    self.got:SetActive(true)
    self.canGet:SetActive(false)
    self.locked:SetActive(false)
  elseif loginAward.status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV then
    self.got:SetActive(false)
    self.canGet:SetActive(true)
    self.locked:SetActive(false)
  elseif loginAward.status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK then
    self.got:SetActive(false)
    self.canGet:SetActive(false)
    self.locked:SetActive(true)
  end
end

function UIActivityReturnSystemTabLoginAwardCell:FlushAwards(awards)
  local len = table.count(awards)
  self.awards:SpawnObjects("UIActivityReturnSystemTabLoginAwardItem", len)
  local uiAwards = self.awards:GetAllSpawnList()
  for i, uiAward in ipairs(uiAwards) do
    uiAward:Flush(awards[i], self._tipsCallback)
  end
end

function UIActivityReturnSystemTabLoginAwardCell:imgCanGetOnClick(go)
  self._getRewardCallback(self.loginAward)
end
