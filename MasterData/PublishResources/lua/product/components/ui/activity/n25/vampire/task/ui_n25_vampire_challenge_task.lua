_class("UIN25VampireChallengeTask", UIController)
UIN25VampireChallengeTask = UIN25VampireChallengeTask

function UIN25VampireChallengeTask:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N25, ECampaignN25ComponentID.ECAMPAIGN_N25_QUEST, ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._questComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_QUEST)
  self._questComponentInfo = self._localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_QUEST)
  self._bloodsuckerComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  self._bloodsuckerComponentInfo = self._localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
end

function UIN25VampireChallengeTask:OnShow(uiParams)
  self.isHide = false
  local TopBtn = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self.poolContent = self:GetUIComponent("UISelectObjectPath", "Content")
  self.verticalLayoutGroup = self:GetUIComponent("VerticalLayoutGroup", "Content")
  self.rect = self:GetUIComponent("RectTransform", "Content")
  self.scrollRect = self:GetUIComponent("ScrollRect", "sv")
  self.sizeFilter = self:GetUIComponent("ContentSizeFitter", "Content")
  self.tempItem = self:GetGameObject("tempItem")
  self.tempAni = self:GetUIComponent("Animation", "tempItem")
  local backBtns = TopBtn:SpawnObject("UINewCommonTopButton")
  backBtns:SetData(function()
    self:CloseDialog()
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  self.tempItem:SetActive(false)
  self:Flush(true)
end

function UIN25VampireChallengeTask:OnHide()
  self.isHide = true
  local strUIN25VampireMain = "UIN25VampireMain"
  if GameGlobal.UIStateManager():IsShow(strUIN25VampireMain) then
    GameGlobal.UIStateManager():CallUIMethod(strUIN25VampireMain, "FlushRedPointTalentTree")
    GameGlobal.UIStateManager():CallUIMethod(strUIN25VampireMain, "FlushRedPointChallengeTask")
  end
end

function UIN25VampireChallengeTask:Flush(playAni)
  local componentId = self._questComponent:GetComponentCfgId(self._campaign._id, self._questComponentInfo.m_component_id)
  self._questInfoList = self._questComponent:GetQuestInfo()
  self._questComponent:SortQuestInfoByCampaignQuestStatus(self._questInfoList)
  local len = table.count(self._questInfoList)
  self.poolContent:SpawnObjects("UIN25VampireChallengeTaskItem", len)
  self.uis = self.poolContent:GetAllSpawnList()
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "Flush"
    YIELD(TT, 100)
    self:Lock(lockName)
    for i, data in pairs(self._questInfoList) do
      local ui = self.uis[i]
      ui:Flush(data, self, playAni)
      YIELD(TT)
    end
    self:UnLock(lockName)
  end, self)
end

function UIN25VampireChallengeTask:BackGroundOnClick(go)
end

function UIN25VampireChallengeTask:ReqAwards(id)
  self:StartTask(self._ReqAwards, self, id)
end

function UIN25VampireChallengeTask:_ReqAwards(TT, id)
  local res = AsyncRequestRes:New()
  local lastdata = self._bloodsuckerComponentInfo.talent_info
  local res, rewards = self._questComponent:HandleQuestTake(TT, res, id)
  if res == 0 then
    local function callback()
      self:HideCallBack()
    end
    
    self:ShowDialog("UIN25VampireChallengeTaskGain", self._bloodsuckerComponentInfo, rewards, lastdata, callback, id)
    self:Flush(false)
    YIELD(TT, 100)
    if not self.isHide then
      self.tempItem:SetActive(true)
      self.tempAni:Play("uieffanim_UIN25VampireChallengeTaskItem_in")
    end
  else
  end
end

function UIN25VampireChallengeTask:HideCallBack()
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "HideCallBack"
    self:Lock(lockName)
    self.scrollRect.enabled = false
    self.sizeFilter.enabled = false
    self.verticalLayoutGroup.enabled = false
    self.tempAni:Play("uieffanim_UIN25VampireChallengeTaskItem_out")
    YIELD(TT, 500)
    if self.rect == nil or self.rect.transform == nil then
      return
    end
    if self.isHide then
      return
    end
    self.rect.transform:DOLocalMoveY(self.rect.transform.localPosition.y + 293, 0.5):OnComplete(function()
      self.tempItem:SetActive(false)
      self.scrollRect.enabled = true
      self.sizeFilter.enabled = true
      self.verticalLayoutGroup.enabled = true
      self.rect.anchoredPosition = Vector2(0, 0)
      self:UnLock(lockName)
    end)
  end, self)
end

function UIN25VampireChallengeTask:GetNextShowData()
  if not self._questInfoList then
    return
  end
  if #self._questInfoList < 2 then
    return
  end
  return self._questInfoList[2]
end
