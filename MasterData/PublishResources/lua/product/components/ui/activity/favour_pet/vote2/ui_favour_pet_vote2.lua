require("ui_side_enter_center_content_base")
_class("UIFavourPetVote2", UISideEnterCenterContentBase)
UIFavourPetVote2 = UIFavourPetVote2

function UIFavourPetVote2:DoInit(params)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_VOTE
  self._componentId = ECampaignVoteComponentID.ECAMPAIGN_VOTE
  self._campaignId = params and params.campaign_id
  self._campaign = self._data
  self._component = self._campaign:GetComponent(self._componentId)
  self:_ForceRefresh()
end

function UIFavourPetVote2:DoShow()
  if self._campaign:CheckCampaignClose_ShowClientError() then
    return
  end
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  
  function self._tipsCallback(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
  end
  
  self:_SetReqTime()
  local closeTime = self._campaign:GetSample().end_time
  self:_SetRemainingTime("_time", "str_favour_pet_remain_time", closeTime)
  local animName, duration = "uieff_UIFavourPet_Vote2_in", 467
  UIWidgetHelper.PlayAnimation(self, "_anim", animName, duration, nil, true)
  self:_Refresh(true)
  self:_AttachEvent()
end

function UIFavourPetVote2:DoHide()
  UIWidgetHelper.ClearWidgets(self, "_tipsPool")
  self:_DetachEvent()
end

function UIFavourPetVote2:DoDestroy()
end

function UIFavourPetVote2:_ForceRefresh()
  if self._refreshTaskID ~= nil then
    return
  end
  self._refreshTaskID = self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    if res and res:GetSucc() then
      self:_Refresh()
    end
    self._refreshTaskID = nil
  end, self)
end

function UIFavourPetVote2:_Refresh(playAnim)
  if not self.view then
    return
  end
  self:_SetCoin()
  self:_SetQuest()
  self:_SetList()
  self:_PlayAnim_List(playAnim)
end

function UIFavourPetVote2:_SetRemainingTime(widgetName, descId, endTime, stopCallback)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, stopCallback)
end

function UIFavourPetVote2:_SetCoin()
  local obj = UIWidgetHelper.SpawnObject(self, "_coin", "UIFavourPetCoin")
  obj:SetData(self._component, self._tipsCallback)
end

function UIFavourPetVote2:_SetQuest()
  local obj = UIWidgetHelper.SpawnObject(self, "_quest", "UIFavourPetVote2QuestCell")
  obj:SetData(self._campaign, self._tipsCallback)
end

function UIFavourPetVote2:_SetList()
  local listData = self._component:GetAllVoteItemId()
  local champion = self._component:CalcZonePetVoteChampion()
  
  local function clickCallback(voteId)
    self:_VoteBtnOnClick(voteId)
  end
  
  local objs = UIWidgetHelper.SpawnObjects(self, "_item", "UIFavourPetVote2Item", #listData)
  for i, v in ipairs(objs) do
    local voteId = listData[i]
    local isChampion = champion == voteId
    v:SetData(self._campaign, self._component, voteId, isChampion, clickCallback)
  end
  self._list = objs
end

function UIFavourPetVote2:_PlayAnim_List(isPlay)
  if not isPlay then
    return
  end
  for i, v in ipairs(self._list) do
    v:PlayAnimationInSequence(i)
  end
end

function UIFavourPetVote2:_SetReqTime()
  if not self.view then
    return
  end
  local curTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000
  local reqTime = curTime + 180
  self:_SetRemainingTime("_reqTime", nil, reqTime, function()
    if not self.view then
      return
    end
    self._component:Start_HandleGetZoneInfo(function()
      self:_Refresh()
    end)
    self:_SetReqTime()
  end)
end

function UIFavourPetVote2:_VoteBtnOnClick(voteId)
  local isVoted = UIFavourPetHelper.NotEnoughVoteItem(self._component)
  if isVoted then
    local text = StringTable.Get("str_favour_pet_2_vote_fin_msg")
    ToastManager.ShowToast(text)
  else
    self:ShowDialog("UIFavourPetVote2Confirm", self._component, voteId, function()
      self:_Start_HandleVote(voteId)
    end)
  end
end

function UIFavourPetVote2:_Start_HandleVote(voteId)
  self._component:Start_HandleVote(voteId, 1, function(res, ret)
    if res:GetSucc() then
      local cfg = UIFavourPetHelper.GetSkinInfo(self._component, voteId)
      local skinName = StringTable.Get(cfg.SkinName)
      local text = StringTable.Get("str_favour_pet_2_vote_succ_msg", skinName)
      ToastManager.ShowToast(text)
      self:_Refresh()
    else
      self._campaign:CheckErrorCode(res.m_result, function()
        self:_Refresh()
      end)
    end
  end)
end

function UIFavourPetVote2:IntroBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UIFavourPetVote2Intro")
end

function UIFavourPetVote2:_AttachEvent()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIFavourPetVote2:_DetachEvent()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIFavourPetVote2:OnUIGetItemCloseInQuest()
  self:_Refresh()
end
