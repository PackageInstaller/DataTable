_class("UIN12IntegralItem", UICustomWidget)
UIN12IntegralItem = UIN12IntegralItem

function UIN12IntegralItem:OnShow(uiParams)
  self:_GetComponent()
  self:_SetValue(uiParams)
end

function UIN12IntegralItem:_SetValue(uiParams)
  self.colorDate = {}
  self.colorDate.grey = Color.New(0.788235294117647, 0.7607843137254902, 0.7058823529411765)
  self.colorDate.yellow = Color.New(0.9450980392156862, 0.6745098039215687, 0.15294117647058825)
end

function UIN12IntegralItem:_GetComponent()
  self._reputation = self:GetGameObject("reputation")
  self._special = self:GetGameObject("special")
  self._txtTotal = self:GetUIComponent("UILocalizationText", "txtTotal")
  self._txtReputation = self:GetUIComponent("UILocalizationText", "txtReputation")
  self._imgReputation = self:GetUIComponent("RawImage", "imgReputation")
  self._grey = self:GetUIComponent("Image", "_grey")
  self._canGet = self:GetGameObject("canGet")
  self._got = self:GetGameObject("got")
  self._select = self:GetGameObject("select")
end

function UIN12IntegralItem:SetData(progress_component, idx, date, callback, curScore, callback2, callback3)
  self._progress_component = progress_component
  self._idx = idx
  self._date = date
  self._callback = callback
  self._callback2 = callback2
  self._curScore = curScore
  self._callback3 = callback3
  self:SetShow()
end

function UIN12IntegralItem:SetShow()
  self._got:SetActive(false)
  self._txtReputation:SetText(self._date.reputation)
  local award = self:GetUIComponent("UISelectObjectPath", "award")
  self._award = award:SpawnObject("UIN12AwardItem")
  self:_SetGrey(1)
  self._award:SetData(self._date.awards[1], self._curScore, self._date, function(matid, pos)
    self._callback(matid, pos)
  end, function(grey)
    self:_SetGrey(grey)
  end)
end

function UIN12IntegralItem:_SetGrey(grey)
  if grey == 1 then
    self._grey.color = self.colorDate.grey
    self._canGet:SetActive(false)
  else
    self._grey.color = self.colorDate.yellow
    self._canGet:SetActive(true)
  end
  if not self._date.gotState then
    UIN12ChallengesContorl.SetIconGrey({
      self._imgReputation
    }, 0)
  else
    UIN12ChallengesContorl.SetIconGrey({
      self._imgReputation
    }, grey)
  end
  if self._date.gotState == N12IntegralState.Got then
    self._got:SetActive(true)
  end
end

function UIN12IntegralItem:bgOnClick(go)
end

function UIN12IntegralItem:btnGetOnClick(go)
  if self._callback3() then
    return
  end
  self:StartTask(function(TT)
    local c = self._progress_component
    local res = AsyncRequestRes:New()
    local awards = c:HandleReceiveReward(TT, res, self._date.reputation)
    if awards then
      UIN12IntegralItem.ShowRewards(awards)
      self._date.gotState = N12IntegralState.Got
      self._award:RefGray(1)
      if self._callback2 then
        self._callback2()
      end
    end
  end, self)
end

function UIN12IntegralItem.ShowRewards(rewards, callback)
  local petIdList = {}
  local mPet = GameGlobal.GetModule(PetModule)
  for _, reward in pairs(rewards) do
    if mPet:IsPetID(reward.assetid) then
      table.insert(petIdList, reward)
    end
  end
  if table.count(petIdList) > 0 then
    GameGlobal.UIStateManager():ShowDialog("UIPetObtain", petIdList, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      GameGlobal.UIStateManager():ShowDialog("UIGetItemController", rewards, function()
        if callback then
          callback()
        end
      end)
    end)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIGetItemController", rewards, function()
    if callback then
      callback()
    end
  end)
end
