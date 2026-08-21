_class("UIN25IdolAchieveDetails", UICustomWidget)
UIN25IdolAchieveDetails = UIN25IdolAchieveDetails

function UIN25IdolAchieveDetails:Constructor()
  self._parent = nil
  self._cfg = nil
  self._reddotl = nil
  self._urlIcon = {
    [0] = "n25_ychsj_icon11",
    [4] = "n25_ychsj_icon04",
    [5] = "n25_ychsj_icon05",
    [6] = "n25_ychsj_icon06"
  }
  self._nameColor = UIN25IdolAchieveTitle:GetNameColor()
end

function UIN25IdolAchieveDetails:OnShow(uiParams)
  self._imgIcon = self:GetUIComponent("Image", "imgIcon")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtCondition = self:GetUIComponent("UILocalizationText", "txtCondition")
  self._txtDescription = self:GetUIComponent("UILocalizationText", "txtDescription")
  self._rewardContent = self:GetUIComponent("UISelectObjectPath", "rewardContent")
  self._stateReceive = self:GetUIComponent("RectTransform", "stateReceive")
  self._stateReceived = self:GetUIComponent("RectTransform", "stateReceived")
  self._stateLocked = self:GetUIComponent("RectTransform", "stateLocked")
  self._redDot = self:View():GetUIComponent("UISelectObjectPath", "redDot")
  self._redDotSpawn = nil
  self._redDotReward = self:View():GetUIComponent("UISelectObjectPath", "redDotReward")
  self._redDotRewardSpawn = nil
  self._arContentPool = nil
end

function UIN25IdolAchieveDetails:OnHide()
end

function UIN25IdolAchieveDetails:BtnReceiveOnClick(go)
  self._parent:OnAchieveDetails(self._cfg)
end

function UIN25IdolAchieveDetails:SetRedDot(showRedDot)
  self._redDot.gameObject:SetActive(showRedDot)
  if showRedDot and self._redDotSpawn == nil then
    self._redDotSpawn = self._redDot:SpawnOneObject("ManualLoad0")
  end
end

function UIN25IdolAchieveDetails:SetRewardRedDot(showRedDot)
  self._redDotReward.gameObject:SetActive(showRedDot)
  if showRedDot and self._redDotRewardSpawn == nil then
    self._redDotRewardSpawn = self._redDotReward:SpawnOneObject("ManualLoad0")
  end
end

function UIN25IdolAchieveDetails:ID()
  return self._cfg.ID
end

function UIN25IdolAchieveDetails:SetData(parent, cfg)
  self._parent = parent
  self._cfg = cfg
  self._reddot = parent:GetRedDot()
  self._txtName:SetText(StringTable.Get(cfg.Name))
  self._txtCondition:SetText(StringTable.Get(cfg.ConditionTxt))
  self._txtDescription:SetText(StringTable.Get(cfg.DescriptionTxt))
  local url = self._urlIcon[cfg.StateIcon]
  if url ~= nil then
    self._imgIcon.enabled = true
    self._imgIcon.sprite = self._parent:GetAtlas():GetSprite(url)
  else
    self._imgIcon.enabled = false
  end
  local countReward = 0
  local cfgRewardList = cfg.RewardList
  if cfgRewardList ~= nil then
    countReward = #cfgRewardList
  end
  self._arContentPool = self._rewardContent:SpawnObjects("UIN25IdolAchieveReward", countReward)
  for i = 1, countReward do
    local ui = self._arContentPool[i]
    local data = cfgRewardList[i]
    ui:SetData(self._parent, data)
  end
  self._imgIcon.gameObject:SetActive(false)
  self._stateReceive.gameObject:SetActive(false)
  self._stateReceived.gameObject:SetActive(false)
  self._stateLocked.gameObject:SetActive(false)
  self._txtDescription.gameObject:SetActive(false)
  local unlocked = self._reddot:GetAchieveUnlocked()
  local achieveState = unlocked[cfg.ID]
  if achieveState == nil then
    self._txtName.color = self._nameColor[0]
    self._txtName:SetText(StringTable.Get("str_n25_idol_y_coll_locked"))
    self._imgIcon.gameObject:SetActive(true)
    self._imgIcon.sprite = self._parent:GetAtlas():GetSprite(self._urlIcon[0])
    self._stateLocked.gameObject:SetActive(true)
  elseif achieveState == IdolAchieveState.IdolAchieveState_CanRecv then
    self._txtName.color = self._nameColor[cfg.StateIcon]
    self._imgIcon.gameObject:SetActive(true)
    self._stateReceive.gameObject:SetActive(true)
    self._txtDescription.gameObject:SetActive(true)
  elseif achieveState == IdolAchieveState.IdolAchieveState_Recved then
    self._txtName.color = self._nameColor[cfg.StateIcon]
    self._imgIcon.gameObject:SetActive(true)
    self._stateReceived.gameObject:SetActive(true)
    self._txtDescription.gameObject:SetActive(true)
  end
end
