_class("UIQuestGrowthAwardItem", UICustomWidget)
UIQuestGrowthAwardItem = UIQuestGrowthAwardItem

function UIQuestGrowthAwardItem:OnShow(uiParams)
  self._atlas = self:RootUIOwner():GetAsset("UIQuest.spriteatlas", LoadType.SpriteAtlas)
  self._questModule = GameGlobal.GetModule(QuestModule)
  self:_GetComponents()
  self:AttachEvents()
end

function UIQuestGrowthAwardItem:_GetComponents()
  self._awardImg = self:GetUIComponent("Image", "awardImg")
  self._awardFinishTex = self:GetUIComponent("UILocalizationText", "awardFinishTex")
  self._closeTex = self:GetUIComponent("UILocalizationText", "closeTex")
  self._awardLightAnim = self:GetUIComponent("Animation", "UIQuestGrowthAwardItem")
end

function UIQuestGrowthAwardItem:OnHide()
  self:RemoveEvents()
end

function UIQuestGrowthAwardItem:AttachEvents()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
end

function UIQuestGrowthAwardItem:RemoveEvents()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:DetachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
end

function UIQuestGrowthAwardItem:SetData(index, quest, refrenshCb, anim)
  self._index = index
  self._questLua = quest
  self._refrenshCb = refrenshCb
  self._quest = self._questLua:QuestInfo()
  if self._quest == nil then
    Log.fatal("[quest] error --> quest is nil ! id --> " .. self._quest.quest_id)
    return
  end
  self:_OnValue(anim)
end

function UIQuestGrowthAwardItem:_OnValue(anim)
  self._getState = self._quest.status
  local progress = ""
  if self._quest.ShowType == 1 then
    local c, d = math.modf(self._quest.cur_progress * 100 / self._quest.total_progress)
    if c < 1 and 0 < d then
      c = 1
    end
    progress = c .. "%"
  else
    progress = self._quest.cur_progress .. "/" .. self._quest.total_progress
  end
  self._awardFinishTex:SetText(progress)
  self._awardImg:CrossFadeAlpha(1, 0, true)
  local color = Color(1, 1, 1)
  if self._getState <= QuestStatus.QUEST_Accepted then
    self._closeTex:SetText(StringTable.Get("str_quest_base_un_open"))
    self._awardImg.sprite = self._atlas:GetSprite("task_chengzhang_icon8")
  elseif self._getState == QuestStatus.QUEST_Completed then
    self._closeTex:SetText(StringTable.Get("str_quest_base_can_get"))
    color = Color(1, 0.6235294117647059, 0.13333333333333333)
    self._awardImg.sprite = self._atlas:GetSprite("task_chengzhang_icon12")
  elseif self._getState == QuestStatus.QUEST_Taken then
    self._closeTex:SetText(StringTable.Get("str_quest_base_got"))
    color = Color(0.5411764705882353, 0.5411764705882353, 0.5411764705882353)
    self._awardImg.sprite = self._atlas:GetSprite("task_chengzhang_icon9")
  else
    Log.fatal("### UIQuestGrowthAwardItem")
  end
  if anim then
    self._awardLightAnim:Play("uieff_Quest_GrowthAwardItem_In")
  end
  self._closeTex.color = color
  self._awardFinishTex.color = color
end

function UIQuestGrowthAwardItem:SetDataTaken(index)
  self._index = index
  self._quest = MobileQuestInfo:New()
  self._quest.status = QuestStatus.QUEST_Taken
  self._quest.cur_progress = 3
  self._quest.total_progress = 3
  self:_OnValue()
end

function UIQuestGrowthAwardItem:bgOnClick()
  if self._getState <= QuestStatus.QUEST_Accepted then
    self:ShowDialog("UIQuestAwardsInfoController", self._quest.rewards)
  elseif self._getState == QuestStatus.QUEST_Completed then
    GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
    self:Lock("UIQuestGet")
    GameGlobal.TaskManager():StartTask(self._OnbgOnClick, self)
  elseif self._getState == QuestStatus.QUEST_Taken then
    ToastManager.ShowToast(StringTable.Get("str_quest_base_achieve_awards") .. StringTable.Get("str_quest_base_got"))
  end
end

function UIQuestGrowthAwardItem:OnUIGetItemCloseInQuest(type)
  if type == QuestType.QT_Growth + 10000 and self._refrenshCb then
    self._refrenshCb()
  end
end

function UIQuestGrowthAwardItem:OnUIPetObtainCloseInQuest(type)
  if type == QuestType.QT_Growth + 10000 then
    self:ShowDialog("UIGetItemController", self._tempMsgRewards, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Growth + 10000)
    end)
  end
end

function UIQuestGrowthAwardItem:_OnbgOnClick(TT)
  if self._questModule == nil then
    Log.fatal("[quest] error --> questModule is nil !")
    return
  end
  local res, msg = self._questModule:TakeQuestReward(TT, self._quest.quest_id)
  self:UnLock("UIQuestGet")
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
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, QuestType.QT_Growth + 10000)
      end)
    else
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Growth + 10000)
      end)
    end
  end
end
