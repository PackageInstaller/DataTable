local EquipmentInstanceRewardSelectGridCtrl = class("EquipmentInstanceRewardSelectGridCtrl", BaseCtrl)
EquipmentInstanceRewardSelectGridCtrl._mapNodeConfig = {
  txtInstanceName = {sComponentName = "TMP_Text"},
  btnChosen = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickChosen"
  },
  imgCurChose = {sComponentName = "GameObject"},
  txtCurChose = {
    sComponentName = "TMP_Text",
    sLanguageId = "DailyInstance_Cur_Chose"
  },
  txtBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "DailyInstance_Reward_Select"
  },
  RewardItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 2
  },
  btnRewardItem = {
    sComponentName = "UIButton",
    nCount = 2,
    callback = "OnBtnClick_RewardItem"
  }
}
EquipmentInstanceRewardSelectGridCtrl._mapEventConfig = {
  ChangeEquipmentInstanceRewardMode = "OnEvent_ChangeEquipmentInstanceRewardMode"
}

function EquipmentInstanceRewardSelectGridCtrl:Refresh(nId)
  local mapData = ConfigTable.GetData("CharGemInstanceRewardGroup", nId)
  if mapData == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtInstanceName, mapData.RewardName)
  self.nRewardType = mapData.RewardType
  local curChoseType = PlayerData.EquipmentInstance:GetLastRewardType()
  self._mapNode.imgCurChose:SetActive(curChoseType == self.nRewardType)
  self._mapNode.txtCurChose.gameObject:SetActive(curChoseType == self.nRewardType)
  self._mapNode.btnChosen.gameObject:SetActive(curChoseType ~= self.nRewardType)
  local tbReward = decodeJson(mapData.BaseAwardPreview)
  self.tbReward = tbReward
  for index = 1, 5 do
    if self.tbReward[index] ~= nil then
      local bReceived = false
      if self.tbReward[index][#tbReward[index]] == 1 then
        bReceived = true
      end
      table.insert(self.tbReward[index], bReceived)
    end
  end
  self.tbAfterReward = {}
  for key, value in pairs(self.tbReward) do
    local lastIndex = #self.tbReward[key]
    if not self.tbReward[key][lastIndex] then
      table.remove(value)
      table.insert(self.tbAfterReward, value)
    end
  end
  for index = 1, 2 do
    self._mapNode.RewardItem[index].gameObject:SetActive(self.tbAfterReward[index] ~= nil)
    if self.tbAfterReward[index] ~= nil then
      local rewardItem = self.tbAfterReward[index]
      local nLastIndex = #rewardItem
      self._mapNode.RewardItem[index]:SetItem(rewardItem[1], nil, UTILS.ParseRewardItemCount(rewardItem), nil, false, rewardItem[nLastIndex] == 1, rewardItem[nLastIndex] == 2, true)
    end
  end
end

function EquipmentInstanceRewardSelectGridCtrl:OnEvent_ChangeEquipmentInstanceRewardMode()
  local curChoseType = PlayerData.EquipmentInstance:GetLastRewardType()
  self._mapNode.imgCurChose:SetActive(curChoseType == self.nRewardType)
  self._mapNode.txtCurChose.gameObject:SetActive(curChoseType == self.nRewardType)
  self._mapNode.btnChosen.gameObject:SetActive(curChoseType ~= self.nRewardType)
end

function EquipmentInstanceRewardSelectGridCtrl:OnBtn_ClickChosen()
  PlayerData.EquipmentInstance:SetRewardType(self.nRewardType)
  EventManager.Hit("ChangeEquipmentInstanceRewardMode")
end

function EquipmentInstanceRewardSelectGridCtrl:OnBtnClick_RewardItem(btn, nIdx)
  if self.tbAfterReward[nIdx] ~= nil then
    local nTid = self.tbAfterReward[nIdx][1]
    UTILS.ClickItemGridWithTips(nTid, btn.transform, true, true, false)
  end
end

return EquipmentInstanceRewardSelectGridCtrl
