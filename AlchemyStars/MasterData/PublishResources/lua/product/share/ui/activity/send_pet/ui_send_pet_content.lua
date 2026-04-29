require("ui_side_enter_center_content_base")
_class("UISendPetContent", UISideEnterCenterContentBase)
UISendPetContent = UISendPetContent

function UISendPetContent:DoInit()
  self:GetComponents()
  self._campaign = self._data
  self._sample = self._campaign:GetSample()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
end

function UISendPetContent:CreateData()
  local localProcess = self._campaign:GetLocalProcess()
  self._questCom = localProcess:GetComponent(ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_QUEST)
  self._questComInfo = localProcess:GetComponentInfo(ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_QUEST)
  self._progressInfo = localProcess:GetComponentInfo(ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_PERSON_PROCESS)
end

function UISendPetContent:DoShow()
  if self._campaign:CheckCampaignNew() then
    self:StartTask(function(TT)
      self._campaign:ClearCampaignNew(TT)
    end)
  end
  self._cruProcess = 0
  self._totalProcess = 0
  self._totalWidth = 0
  UIEventTriggerListener.Get(self._questBtn).onDown = function(go)
    self:QuestBtnOnPressed()
  end
  UIEventTriggerListener.Get(self._questBtn).onUp = function(go)
    self:QuestBtnOnReleased()
  end
  self:OnRefresh()
  self:Attach()
end

function UISendPetContent:DoHide()
  self:Detach()
end

function UISendPetContent:DoDestroy()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self:Detach()
end

function UISendPetContent:Attach()
  self:AttachEvent(GameEventType.OnSendPetCardQuestGet, self.OnRefresh)
end

function UISendPetContent:Detach()
  self:DetachEvent(GameEventType.OnSendPetCardQuestGet, self.OnRefresh)
end

function UISendPetContent:GetComponents()
  self._awardPools = self:GetUIComponent("UISelectObjectPath", "progressPool")
  self._awardPools_rect = self:GetUIComponent("RectTransform", "progressPool")
  self._bigPool = self:GetUIComponent("UISelectObjectPath", "bigProgressPool")
  self._pools = self:GetUIComponent("UISelectObjectPath", "petPool")
  self._scrollView_rect = self:GetUIComponent("RectTransform", "ScrollView")
  self._lessTime = self:GetUIComponent("UILocalizationText", "lessTime")
  self._progressNow_Image = self:GetUIComponent("Image", "progressNow")
  self._progressNow_rect = self:GetUIComponent("RectTransform", "progressNow")
  self._progressAll_rect = self:GetUIComponent("RectTransform", "progressAll")
  self._progressTxtNow = self:GetUIComponent("UILocalizationText", "progressTxtNow")
  self._progressTxtAll = self:GetUIComponent("UILocalizationText", "progressTxtAll")
  self._questRedGO = self:GetGameObject("questRed")
  self._questTxt = self:GetUIComponent("UILocalizationText", "questTxt")
  self._questBtn = self:GetGameObject("QuestBtn")
  self._questImage = self:GetUIComponent("Image", "QuestBtn")
end

function UISendPetContent:OnRefresh()
  self:CreateData()
  self:ShowAwards()
  self:ShowPets()
  self:ShowTimer()
  self:ShowQuestRed()
end

function UISendPetContent:ShowQuestRed()
  local color = "#000000"
  local str = UIActivityHelper.GetColorText(color, StringTable.Get("str_common_mission"))
  self._questTxt:SetText(str)
  local questList = self._questComInfo.m_accept_cam_quest_list
  for _, questId in pairs(questList) do
    local questInfo = self:GetQuestInfo(questId)
    if questInfo.status == QuestStatus.QUEST_Completed then
      self._questRedGO:SetActive(true)
      return
    end
  end
  self._questImage.sprite = self:GetAsset("SendCard.spriteatlas", LoadType.SpriteAtlas):GetSprite("cn15_glzx_btn01")
  self._questRedGO:SetActive(false)
end

function UISendPetContent:GetQuestInfo(id)
  local questModule = self:GetModule(QuestModule)
  return questModule:GetQuest(id):QuestInfo()
end

function UISendPetContent:ShowTimer()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEventTimes(0, TimerTriggerCount.Infinite, function()
    self:ShowTimeTex()
  end)
end

function UISendPetContent:ShowTimeTex()
  local endTime = self._sample.end_time
  local nowTime = math.ceil(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = endTime - nowTime
  if 0 <= sec then
    local secStr = HelperProxy:GetInstance():Time2Tex(sec)
    self._lessTime:SetText(StringTable.Get("str_n_plus_six_time_tips1") .. "  " .. secStr)
  else
    self._lessTime:SetText(StringTable.Get("str_activity_error_107"))
  end
end

function UISendPetContent:ShowAwards()
  self:ShowNormalAwards()
  self:ShowBigAwards()
end

function UISendPetContent:ShowBigAwards()
  local lastAward
  local maxProgress = 0
  for k, v in pairs(self._progressInfo.m_progress_rewards) do
    if k > maxProgress then
      maxProgress = k
      lastAward = v
    end
  end
  local big = lastAward[1]
  self._progressTxtAll:SetText("/" .. maxProgress)
  self._bigAwardWidget = self._bigPool:SpawnObject("UISendPetAward")
  local state = self:GetState(maxProgress)
  local isRed = self._progressInfo.m_current_progress == maxProgress
  self._bigAwardWidget:SetData(state, big, maxProgress, true, isRed, Vector2.zero, function()
    self:AwardClick()
  end)
end

function UISendPetContent:GetState(progress)
  local cur = self._progressInfo.m_current_progress
  local pass = self._progressInfo.m_received_progress
  if table.icontains(pass, progress) then
    return QuestStatus.QUEST_Taken
  end
  if progress <= cur then
    return QuestStatus.QUEST_Completed
  end
  return QuestStatus.QUEST_Accepted
end

function UISendPetContent:ISFirst(progress)
  local cur = self._progressInfo.m_current_progress
  local pass = self._progressInfo.m_received_progress
  if table.icontains(pass, progress) then
    return false
  end
  return true
end

function UISendPetContent:ShowNormalAwards()
  local awards = self._progressInfo.m_progress_rewards
  local showAwards = {}
  local maxProgress = 0
  local curProcess = 0
  for k, v in pairs(awards) do
    local data = {}
    if k > maxProgress then
      maxProgress = k
      self._totalProcess = k
    end
    data.progress = k
    data.awards = v
    table.insert(showAwards, data)
  end
  self._maxProgress = maxProgress
  table.sort(showAwards, function(a, b)
    return a.progress < b.progress
  end)
  table.remove(showAwards, #showAwards)
  self._awardPools:SpawnObjects("UISendPetAward", #showAwards)
  local width = 200
  local isFirst = true
  local firstPos = 0
  local pools = self._awardPools:GetAllSpawnList()
  for i = 1, #showAwards do
    local widget = pools[i]
    local roleAsset = showAwards[i].awards[1]
    local posX = width
    local state = self:GetState(showAwards[i].progress)
    local isRed = state == QuestStatus.QUEST_Completed
    if self:ISFirst(showAwards[i].progress) and isFirst then
      firstPos = width
      isFirst = false
    end
    width = width + 200
    widget:SetData(state, roleAsset, showAwards[i].progress, false, isRed, posX, function()
      self:AwardClick()
    end)
  end
  if firstPos == 0 and isFirst == true then
    firstPos = width
  end
  self._totalWidth = width
  local size = self._awardPools_rect.sizeDelta
  if maxProgress <= self._progressInfo.m_current_progress then
    self._progressTxtNow:SetText(maxProgress)
    self._progressNow_rect.sizeDelta = Vector2(width, 5)
  else
    self._progressTxtNow:SetText(self._progressInfo.m_current_progress)
    local cur = self._progressInfo.m_current_progress / maxProgress
    self._progressNow_rect.sizeDelta = Vector2(cur * width, 5)
  end
  self._progressAll_rect.sizeDelta = Vector2(width, 5)
  self._awardPools_rect.sizeDelta = Vector2(width, size.y)
  self._awardPools_rect.anchoredPosition = Vector2(-(firstPos - 80), self._awardPools_rect.anchoredPosition.y)
end

function UISendPetContent:GetPos(progress)
  return progress
end

function UISendPetContent:AwardClick()
  if self:CheckActivityOver() then
    return
  end
  self:Lock("UISendPetContent:AwardClick")
  GameGlobal.TaskManager():StartTask(self.OnAwardClick, self)
end

function UISendPetContent:OnAwardClick(TT)
  local res = AsyncRequestRes:New()
  local com = self._campaign:GetComponent(ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_PERSON_PROCESS)
  local rewards = com:HandleOneKeyReceiveRewards(TT, res)
  self:UnLock("UISendPetContent:AwardClick")
  if res and res:GetSucc() then
    Log.debug("###[UISendPetContent] HandleOneKeyReceiveRewards succ !")
    self:ShowUIGetItemController(rewards)
    self:CreateData()
    self:ShowAwards()
  else
    Log.error("###[UISendPetContent] HandleOneKeyReceiveRewards fail ! result : ", res:GetResult())
  end
end

function UISendPetContent:ShowUIGetItemController(rewards)
  if not rewards then
    return
  end
  self._petModule = GameGlobal.GetModule(PetModule)
  local tempPets = {}
  if 0 < #rewards then
    for i = 1, #rewards do
      local ispet = self._petModule:IsPetID(rewards[i].assetid)
      if ispet then
        table.insert(tempPets, rewards[i])
      end
    end
  end
  
  local function cbFunc()
  end
  
  if 0 < #tempPets then
    self:ShowDialog("UIPetObtain", tempPets, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", rewards, cbFunc)
    end)
  else
    self:ShowDialog("UIGetItemController", rewards, cbFunc)
  end
end

function UISendPetContent:ShowPets()
  local awards = self._progressInfo.m_progress_rewards
  local showAwards = {}
  for k, v in pairs(awards) do
    local data = {}
    data.progress = k
    data.awards = v
    table.insert(showAwards, data)
  end
  table.sort(showAwards, function(a, b)
    return a.progress < b.progress
  end)
  local len = table.count(showAwards)
  local maxAward = showAwards[len]
  local big = maxAward.awards[1]
  local itemid = big.assetid
  local cfg_item_gift = Cfg.cfg_item_gift[itemid]
  if cfg_item_gift then
    local itemList = cfg_item_gift.ItemList
    local pets = {}
    for i, v in ipairs(itemList) do
      local id = v[1]
      pets[i] = id
    end
    if 4 < #pets then
      Log.error("###[UISendPetContent] itemList count > 4 !")
    end
    self._pools:SpawnObjects("UISendPetCard", #pets)
    local pools = self._pools:GetAllSpawnList()
    for i = 1, #pets do
      local widget = pools[i]
      widget:SetData(pets[i])
    end
  else
    Log.error("###[UISendPetContent] last award cfg_item_gift is nil ! id:", itemid)
  end
end

function UISendPetContent:QuestBtnOnClick()
  self:ShowDialog("UISendPetQuest", self._campaign, self._questCom, nil, function()
    if self.uiOwner then
      local totalProcess = 0
      if self._totalProcess < self._progressInfo.m_current_progress then
        totalProcess = self._totalProcess
      else
        totalProcess = self._progressInfo.m_current_progress
      end
      if self._cruProcess ~= totalProcess then
        local targetWidth = self._progressInfo.m_current_progress * (self._totalWidth / self._maxProgress)
        if targetWidth > self._totalWidth then
          targetWidth = self._totalWidth
        end
        local firstWidth = self._progressNow_rect.sizeDelta.x
        self._progressNow_rect.sizeDelta = Vector2(targetWidth, 5)
        local fillAmount = firstWidth / targetWidth
      end
    end
  end)
end

function UISendPetContent:QuestBtnOnPressed()
  self._questImage.sprite = self:GetAsset("SendCard.spriteatlas", LoadType.SpriteAtlas):GetSprite("cn15_glzx_btn02")
  local color = "#FFFFFF"
  local str = UIActivityHelper.GetColorText(color, StringTable.Get("str_common_mission"))
  self._questTxt:SetText(str)
end

function UISendPetContent:QuestBtnOnReleased()
  self._questImage.sprite = self:GetAsset("SendCard.spriteatlas", LoadType.SpriteAtlas):GetSprite("cn15_glzx_btn01")
  local color = "#000000"
  local str = UIActivityHelper.GetColorText(color, StringTable.Get("str_common_mission"))
  self._questTxt:SetText(str)
end

function UISendPetContent:IntrBtnOnClick()
  self:ShowDialog("UIIntroLoader", "UISendPetIntro")
end

function UISendPetContent:PlayAnime(fillAmount)
  self:Lock("UISendPetContent:PlayAnime")
  self._progressNow_Image.fillAmount = fillAmount
  local phaseTime = (1 - fillAmount) * 4
  GameGlobal.Timer():AddEvent(850.0, function()
    if self._progressNow_Image.gameObject ~= nil and self._progressNow_Image.gameObject.activeInHierarchy then
      self._progressNow_Image:DOFillAmount(1, phaseTime):SetEase(DG.Tweening.Ease.OutCirc)
    end
    self:UnLock("UISendPetContent:PlayAnime")
  end)
  self:UnLock("UISendPetContent:PlayAnime")
end

function UISendPetContent:CheckActivityOver()
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local endTime = self._sample.end_time
  if curTime < endTime then
    return false
  else
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    return true
  end
end
