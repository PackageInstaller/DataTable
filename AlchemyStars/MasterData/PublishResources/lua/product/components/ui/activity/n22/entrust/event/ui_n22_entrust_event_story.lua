_class("UIN22EntrustEventStory", UIN22EntrustEventBase)
UIN22EntrustEventStory = UIN22EntrustEventStory

function UIN22EntrustEventStory:Refresh()
  self:_SetRoot(true)
  self:_SetCloseBtn()
  local cfg = self:GetCfgCampaignEntrustEvent()
  local params = cfg.Params[1]
  local storyID = params.StoryID
  local desc = params.Desc
  local pass = self._component:IsEventPass(self._levelId, self._eventId)
  self:_SetPass(pass)
  self:_SetTalkIcon("n22_wt_dfqb_icon03")
  self:_SetTalkDesc(StringTable.Get(desc))
  local str1 = StringTable.Get("str_n22_entrust_event_story_look_again")
  local str2 = StringTable.Get("str_n22_entrust_event_story_look")
  local txtConfirm = pass and str1 or str2
  self:_SetConfirmBtn(true, txtConfirm, function()
    GameGlobal.UIStateManager():ShowDialog("UIStoryController", storyID, function()
      if not pass then
        self:RequestEvent()
      else
        self:CloseDialog()
      end
    end)
  end)
end

function UIN22EntrustEventStory:OnEventFinish(rewards)
  Log.info("UIN22EntrustEventStory:OnEventFinish()")
  if rewards and table.count(rewards) > 0 then
    local title = StringTable.Get("str_activity_battlepass_buy_deluxe_claim")
    self:ShowDialog("UIN22EntrustRewardsController", title, rewards, function()
      self:CloseDialog()
    end)
  else
    self:CloseDialog()
  end
end
