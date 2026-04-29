_class("UIQuestAchievementPointAwardsItem", UICustomWidget)
UIQuestAchievementPointAwardsItem = UIQuestAchievementPointAwardsItem

function UIQuestAchievementPointAwardsItem:OnShow(uiParams)
  self._questModule = GameGlobal.GetModule(QuestModule)
  self._atlas = self:RootUIOwner():GetAsset("UIQuest.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvents()
end

function UIQuestAchievementPointAwardsItem:OnHide()
  self:RemoveEvents()
end

function UIQuestAchievementPointAwardsItem:_GetComponents()
  self._pointValueTex = self:GetUIComponent("UILocalizationText", "getState")
  self._itemCountTex = self:GetUIComponent("UILocalizationText", "cTex")
  self._itemPool = self:GetUIComponent("UISelectObjectPath", "item")
  self._btnImg = self:GetUIComponent("Image", "btn")
  self._btnGo = self:GetGameObject("btn")
  self._countGo = self:GetGameObject("count")
  self._line = self:GetGameObject("line")
  self._light2 = self:GetGameObject("light2")
  self._light = self:GetGameObject("light")
  self._BtnRaycast = self:GetUIComponent("Graphic", "Btn")
end

function UIQuestAchievementPointAwardsItem:_OnValue()
  local got = self._questModule:IsGotAchPointReward(self._rewardid)
  if got then
    self._getState = QuestStatus.QUEST_Taken
  elseif self._currentPoint < self._value then
    self._getState = QuestStatus.QUEST_Accepted
  else
    self._getState = QuestStatus.QUEST_Completed
  end
  self._btnGo:SetActive(false)
  self._countGo:SetActive(false)
  self._light:SetActive(false)
  self._light2:SetActive(false)
  self._BtnRaycast.raycastTarget = false
  if self._getState <= QuestStatus.QUEST_Accepted then
    self._countGo:SetActive(true)
    self._itemCountTex:SetText(self._value)
  elseif self._getState == QuestStatus.QUEST_Completed then
    self._BtnRaycast.raycastTarget = true
    self._btnGo:SetActive(true)
    self._light:SetActive(true)
    self._btnImg.sprite = self._atlas:GetSprite("task_achieve_kelingqu2")
    self._pointValueTex:SetText("<color=#2e2e2e>" .. StringTable.Get("str_quest_base_can_get") .. "</color>")
  elseif self._getState == QuestStatus.QUEST_Taken then
    self._btnGo:SetActive(true)
    self._light2:SetActive(true)
    self._btnImg.sprite = self._atlas:GetSprite("task_achieve_yilingqu2")
    self._pointValueTex:SetText("<color=#818181>" .. StringTable.Get("str_quest_base_got") .. "</color>")
  end
  self._item = self._itemPool:SpawnObject("UIQuestSideAwardItem")
  local params = {}
  local cfg_item = Cfg.cfg_item[self._reward[1]]
  params.quality = cfg_item.Color
  params.icon = cfg_item.Icon
  params.text = self._reward[2]
  local hideRaycast = self._getState == QuestStatus.QUEST_Completed
  self._item:SetData(self._reward[1], params, self._lookCallback, hideRaycast)
end

function UIQuestAchievementPointAwardsItem:SetData(index, cfg, currentPoint, lookCallback)
  self:_GetComponents()
  self._rewardid = index
  self._value = cfg.AchPoint
  self._currentPoint = currentPoint
  self._reward = cfg.Reward[1]
  self._lookCallback = lookCallback
  self._line:SetActive(index ~= 1)
  self._getState = 0
  self:_OnValue()
end

function UIQuestAchievementPointAwardsItem:BtnOnClick()
  if self._getState <= QuestStatus.QUEST_Accepted then
  elseif self._getState == QuestStatus.QUEST_Completed then
    GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
    self:Lock("UIQuestGet")
    self:StartTask(self._OnGet, self)
  elseif self._getState == QuestStatus.QUEST_Taken then
  end
end

function UIQuestAchievementPointAwardsItem:OnUIGetItemCloseInQuest(type, index)
  if type == QuestType.QT_Achieve + 100 and index == self._rewardid then
    self._btnGo:SetActive(true)
    self._countGo:SetActive(false)
    self._getState = QuestStatus.QUEST_Taken
    self._btnImg.sprite = self._atlas:GetSprite("task_achieve_yilingqu2")
    self._pointValueTex:SetText("<color=#818181>" .. StringTable.Get("str_quest_base_got") .. "</color>")
    self._light2:SetActive(true)
    self._light:SetActive(false)
    if self._item then
      self._item:HideRaycast(false)
    end
  end
end

function UIQuestAchievementPointAwardsItem:AttachEvents()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
end

function UIQuestAchievementPointAwardsItem:RemoveEvents()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:DetachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
end

function UIQuestAchievementPointAwardsItem:OnUIPetObtainCloseInQuest(type, idx)
  if type == QuestType.QT_Achieve + 100 and idx == self._rewardid then
    self:ShowDialog("UIGetItemController", self._tempMsgRewards, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Achieve + 100, self._rewardid)
    end)
  end
end

function UIQuestAchievementPointAwardsItem:_OnGet(TT)
  local res, msg = self._questModule:TakeAchReward(TT, self._rewardid)
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
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, QuestType.QT_Achieve + 100, self._rewardid)
      end)
    else
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Achieve + 100, self._rewardid)
      end)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnAchievePointFinish)
  else
    Log.fatal("###questModule:TakeAchReward - res:", res:GetResult(), " -id --> ", self._rewardid)
  end
end
