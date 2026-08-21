_class("UIN22EntrustEventQuest", UIN22EntrustEventBase)
UIN22EntrustEventQuest = UIN22EntrustEventQuest

function UIN22EntrustEventQuest:Refresh()
  self:_SetRoot(true)
  self:_SetCloseBtn()
  self._itemModule = GameGlobal.GetModule(ItemModule)
  local cfg = self:GetCfgCampaignEntrustEvent()
  local params = cfg.Params[1]
  local head = params.Head
  local desc = params.Desc
  self._showNumber = params.ShowNumber and params.ShowNumber == 1
  self._rewards = cfg.RewardList
  local pass = self._component:IsEventPass(self._levelId, self._eventId)
  self._questType = self:_CheckQuestType(self._eventType)
  self:_SetPass(pass)
  self:_SetTalkIcon(head)
  self:_SetTalkDesc(StringTable.Get(desc))
  self._rewardText = self:_GetRewardText()
  local txtConfirm = self:_GetConfirmBtnText(self._rewardText)
  self:_SetConfirmBtn(not pass, txtConfirm, function()
    if pass then
      return
    end
    if self._questType == 2 and not self:_ItemEnough() then
      local tips = StringTable.Get("str_n22_entrust_event_quest_not_enough")
      ToastManager.ShowToast(tips)
      return
    end
    self:RequestEvent()
  end)
end

function UIN22EntrustEventQuest:OnEventFinish(rewards)
  Log.info("UIN22EntrustEventQuest:OnEventFinish()")
  local tb = {
    [1] = StringTable.Get("str_n22_entrust_event_quest_get", self._rewardText),
    [2] = StringTable.Get("str_n22_entrust_event_quest_finish")
  }
  local tips = tb[self._questType]
  ToastManager.ShowToast(tips)
  self:Refresh()
end

function UIN22EntrustEventQuest:_CheckQuestType(eventType)
  local tb = {
    [EntrustEventType.EntrustEventType_MissionOccupy] = 1,
    [EntrustEventType.EntrustEventType_MissionSubmit] = 2
  }
  local questType = tb[eventType]
  if not questType then
    Log.error("UIN22EntrustEventQuest:_CheckQuestType() cfg_campaign_entrust_event[", self._eventId, "].EventType is not 5 or 6 ! EventType = ", eventType)
  end
  return questType
end

function UIN22EntrustEventQuest:_GetRewardText()
  local cfg_item = Cfg.cfg_item({})
  local rewardText = ""
  for i = 1, #self._rewards do
    local item = {}
    item.id = self._rewards[i][1]
    item.count = self._rewards[i][2]
    item.name = cfg_item[item.id].Name
    local itemName = StringTable.Get(item.name)
    if 1 < item.count then
      itemName = StringTable.Get("str_n22_entrust_event_quest_x", itemName, item.count)
    end
    if i == 1 then
      rewardText = rewardText .. itemName
    elseif i == #self._rewards then
      rewardText = StringTable.Get("str_n22_entrust_event_quest_and", rewardText, itemName)
    else
      rewardText = StringTable.Get("str_n22_entrust_event_quest_point", rewardText, itemName)
    end
  end
  return rewardText
end

function UIN22EntrustEventQuest:_GetConfirmBtnText(rewardText)
  local btnText = ""
  if self._questType == 1 then
    btnText = StringTable.Get("str_n22_entrust_event_quest_get", rewardText)
  elseif self._questType == 2 then
    btnText = StringTable.Get("str_n22_entrust_event_quest_send", rewardText)
    if self._showNumber then
      local firstID = self._rewards[1][1]
      local firstCount = self._itemModule:GetItemCount(firstID)
      btnText = btnText .. StringTable.Get("str_n22_entrust_event_quest_owner", firstCount)
    end
  end
  return btnText
end

function UIN22EntrustEventQuest:_ItemEnough()
  for _, reward in pairs(self._rewards) do
    local count = reward[2]
    local haveCount = self._itemModule:GetItemCount(reward[1])
    if count > haveCount then
      return false
    end
  end
  return true
end
