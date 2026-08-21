_class("UICN13PerfectPuzzleGetItem", UICustomWidget)
UICN13PerfectPuzzleGetItem = UICN13PerfectPuzzleGetItem

function UICN13PerfectPuzzleGetItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN13PerfectPuzzleGetItem:InitWidget()
  self.planTypeText = self:GetUIComponent("UILocalizationText", "PlanTypeText")
  self.planTipsText = self:GetUIComponent("UILocalizationText", "PlanTipsText")
  self.planStateText = self:GetUIComponent("UILocalizationText", "PlanStateText")
  self.overRoot = self:GetUIComponent("Image", "OverRoot")
  self.getBtn = self:GetUIComponent("Image", "GetBtn")
  self.getBtnText = self:GetUIComponent("UILocalizationText", "GetBtnText")
  self.beingText = self:GetUIComponent("UILocalizationText", "BeingText")
  self.awardRoot = self:GetUIComponent("UISelectObjectPath", "AwardRoot")
end

function UICN13PerfectPuzzleGetItem:SetData(campaign, quest, callback, tipsCallback, component)
  self._dispatchTypeQuest = QuestType.QT_None
  self._questModule = GameGlobal.GetModule(QuestModule)
  self._campaign = campaign
  self._quest = quest
  self._questInfo = self._quest:QuestInfo()
  self._callback = callback
  self._tipsCallback = tipsCallback
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._component = component
  self._state = self._quest:Status()
  self:_Refresh()
end

function UICN13PerfectPuzzleGetItem:_Refresh()
  local val = {}
  val[CampaignPersonProgressStatus.CPPS_Completed] = 0
  val[CampaignPersonProgressStatus.CPPS_Accepted] = 1
  val[CampaignPersonProgressStatus.CPPS_Taken] = 2
  self.planTipsText:SetText(StringTable.Get(self._questInfo.CondDesc))
  local cur, max, str1 = self._component:GetQuestProgressString(self._questInfo)
  self.planStateText:SetText(StringTable.Get("str_cn13_PerfectPuzzle_cur_process", str1))
  if self._state == CampaignPersonProgressStatus.CPPS_Completed then
    self.beingText.gameObject:SetActive(false)
    self.getBtn.gameObject:SetActive(true)
    self.overRoot.gameObject:SetActive(false)
  elseif self._state == CampaignPersonProgressStatus.CPPS_Accepted then
    self.beingText.gameObject:SetActive(true)
    self.getBtn.gameObject:SetActive(false)
    self.overRoot.gameObject:SetActive(false)
  elseif self._state == CampaignPersonProgressStatus.CPPS_Taken then
    self.beingText.gameObject:SetActive(false)
    self.getBtn.gameObject:SetActive(false)
    self.overRoot.gameObject:SetActive(true)
  end
  local cfg = Cfg.cfg_component_quest({
    QuestID = self._questInfo.quest_id
  })
  if cfg[1].NeedReset then
    self.planTypeText:SetText(StringTable.Get("str_cn13_PerfectPuzzle_quest_day_title"))
  else
    self.planTypeText:SetText(StringTable.Get("str_cn13_PerfectPuzzle_quest_plan_title"))
  end
  if 0 < #self._questInfo.rewards then
    self.awardList = self.awardRoot:SpawnObjects("UIPerfectPuzzleRewardItem", #self._questInfo.rewards)
    for i = 1, #self.awardList do
      local award = self.awardList[i]
      local cfgAward = self._questInfo.rewards[i]
      award:SetData(cfgAward, function(matid, pos)
        if self._tipsCallback then
          self._tipsCallback(matid, pos)
        end
      end)
    end
  end
end

function UICN13PerfectPuzzleGetItem:GetBtnOnClick(go)
  self:Lock("UICN13PerfectPuzzle:UIQuestGet")
  if self._callback then
    self._callback(self._questInfo.quest_id)
  end
end

function UICN13PerfectPuzzleGetItem:_GetQuestItemAwardReq(TT, id)
  local res, msg = self._questModule:TakeQuestReward(TT, id)
  self:UnLock("UICN13PerfectPuzzle:UIQuestGet")
  if self.uiOwner == nil then
    return
  end
  if res:GetSucc() then
    local tempPets = {}
    local pets = msg.rewards
    self._tempMsgRewards = msg.rewards
    if 0 < #pets then
      for i = 1, #pets do
        local ispet = GameGlobal.GetModule(PetModule):IsPetID(pets[i].assetid)
        if ispet then
          table.insert(tempPets, pets[i])
        end
      end
    end
    if 0 < #tempPets then
      self:ShowDialog("UIPetObtain", tempPets, function()
        GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, self._dispatchTypeQuest)
      end)
    else
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, self._dispatchTypeQuest)
      end)
    end
  end
end
