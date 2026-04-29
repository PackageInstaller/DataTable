_class("UIN30EntrustStage", UIController)
UIN30EntrustStage = UIN30EntrustStage

function UIN30EntrustStage:Constructor()
end

function UIN30EntrustStage:LoadDataOnEnter(TT, res, uiParams)
  self._node = uiParams[1]
  self._node:EntrustData():NodeRewardsData(self._node)
end

function UIN30EntrustStage:OnShow(uiParams)
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._txtExplorValue = self:GetUIComponent("UILocalizationText", "txtExplorValue")
  self._uiFinish = self:GetUIComponent("RectTransform", "uiFinish")
  self._contentFinishReward = self:GetUIComponent("UISelectObjectPath", "contentFinishReward")
  self._contentExplorReward = self:GetUIComponent("UISelectObjectPath", "contentExplorReward")
  self._safeArea = self:GetUIComponent("Animation", "safeArea")
  self._animation = self:GetUIComponent("Animation", "animation")
  self:Refresh()
end

function UIN30EntrustStage:OnHide()
end

function UIN30EntrustStage:BtnCloseOnClick(go)
  self:CloseDialogAnimation()
end

function UIN30EntrustStage:BtnStartOnClick(go)
  self:CallUIMethod("UIN30Entrust", "OutAnimation")
  self:CloseDialogAnimation(function()
    self:SwitchState(UIStateType.UIN30EntrustLine, self._node)
  end)
end

function UIN30EntrustStage:Refresh()
  local cfg = self._node:GetCfg()
  self._txtTitle:SetText(StringTable.Get(cfg.StrTitle))
  self._txtDesc:SetText(StringTable.Get(cfg.StrDesc))
  local value = self._node:GetExplor() * 100
  local strExplor = string.format("%d%%", math.floor(value))
  self._txtExplorValue:SetText(strExplor)
  self._uiFinish.gameObject:SetActive(self._node:IsPass())
  local rewardFinish = self._node:GetRewardFinish()
  local widgetFinish = self._contentFinishReward:SpawnObjects("UIN30EntrustStageReward", #rewardFinish)
  for k, v in pairs(rewardFinish) do
    local ui = widgetFinish[k]
    ui:Flush(v)
  end
  local rewardExplor = self._node:GetRewardExplor()
  local widgetExplor = self._contentExplorReward:SpawnObjects("UIN30EntrustStageReward", #rewardExplor)
  for k, v in pairs(rewardExplor) do
    local ui = widgetExplor[k]
    ui:Flush(v)
  end
end

function UIN30EntrustStage:RewardItemInfo(reward, go)
  local deltaPosition = go.transform.position - self._safeArea.transform.position
  self:ShowDialog("UIN30EntrustItemInfo", reward, deltaPosition)
end

function UIN30EntrustStage:CloseDialogAnimation(cbFinish)
  local lockName = "UIN30EntrustStage:CloseDialogAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_N30_EntrustStage_out")
    YIELD(TT, 200)
    self:UnLock(lockName)
    self:CloseDialog()
    if cbFinish then
      cbFinish()
    end
  end)
end

_class("UIN30EntrustStageReward", UICustomWidget)
UIN30EntrustStageReward = UIN30EntrustStageReward

function UIN30EntrustStageReward:Constructor()
  self._reward = nil
end

function UIN30EntrustStageReward:OnShow(uiParams)
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self._uiObtained = self:GetUIComponent("RectTransform", "uiObtained")
end

function UIN30EntrustStageReward:OnHide()
end

function UIN30EntrustStageReward:ButtonOnClick(go)
  local uiOwner = self:RootUIOwner()
  if uiOwner.RewardItemInfo ~= nil then
    uiOwner:RewardItemInfo(self._reward, go)
  end
end

function UIN30EntrustStageReward:Flush(reward)
  self._reward = reward
  local cfgItem = Cfg.cfg_item[reward.assetid]
  if not cfgItem then
    self._iconLoader.gameObject:SetActive(false)
  else
    self._iconLoader.gameObject:SetActive(true)
    self._iconLoader:LoadImage(cfgItem.Icon)
  end
  local countValue = string.format("-%d-", reward.count)
  self._txtCount:SetText(countValue)
  self._uiObtained.gameObject:SetActive(reward.received)
end
