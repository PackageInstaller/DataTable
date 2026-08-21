_class("UINewQuestStoryListItem", UICustomWidget)
UINewQuestStoryListItem = UINewQuestStoryListItem

function UINewQuestStoryListItem:Constructor()
  self._hookShowGoto = true
end

function UINewQuestStoryListItem:OnShow(uiParams)
  self._gameObject = self:GetGameObject()
  self._itemCountPerRow = 1
  self._questModule = GameGlobal.GetModule(QuestModule)
  if self._questModule == nil then
    Log.fatal("[quest] error --> self._questModule is nil !")
    return
  end
end

function UINewQuestStoryListItem:HookCallBack(showGoto, fnGoto, fnGet, awardClick)
  self._hookShowGoto = showGoto
  self._hookGoto = fnGoto
  self._hookGet = fnGet
  self._awardClick = awardClick
end

function UINewQuestStoryListItem:SetData(index, quest, callback, awardClick, isIntro)
  if self._introTask then
    GameGlobal.TaskManager():KillTask(self._introTask)
  end
  self:_GetComponents()
  self._index = index
  self._data = quest:QuestInfo()
  if callback then
    self._callback = callback
  end
  if awardClick then
    self._awardClick = awardClick
  end
  self._target = self._data.QuestName
  self._items = self._data.rewards
  self:_OnValue()
  self.rootAnim:Stop()
  if isIntro and not self._isIntroPlayed then
    self._introTask = GameGlobal.TaskManager():StartTask(function(TT)
      self._isIntroPlayed = true
      self._introTask = nil
    end)
  end
  if 0 < index and index < 5 then
    self._gameObject:SetActive(false)
    GameGlobal.TaskManager():StartTask(function(TT)
      YIELD(TT, (index - 1) * 50)
      self._gameObject:SetActive(true)
    end)
  end
end

function UINewQuestStoryListItem:_RefrenshInfo()
  self._target = self._data.QuestDesc
  self._items = self._data.rewards
  self:_OnValue()
end

function UINewQuestStoryListItem:_GetComponents()
  self._targetTex = self:GetUIComponent("UILocalizationText", "targetTex")
  self._revolvingText = self:GetUIComponent("RevolvingTextWithDynamicScroll", "revolvingText")
  self._targetValueImg = self:GetUIComponent("Image", "targetValueImg")
  self._targetValueTex = self:GetUIComponent("UILocalizationText", "targetValueTex")
  self._awardPool = self:GetUIComponent("UISelectObjectPath", "awardPool")
  self._gotoGo = self:GetGameObject("GoTo")
  self._getGo = self:GetGameObject("Get")
  self._complete = self:GetGameObject("complete")
  self._unCanGo = self:GetGameObject("UnCanGo")
  self.rootAnim = self:GetUIComponent("Animation", "UIQuestSideListItem")
  self.canvasGroup = self:GetUIComponent("CanvasGroup", "UIQuestSideListItem")
end

function UINewQuestStoryListItem:InitAnim()
  self.rootAnim:Stop()
  self.canvasGroup.alpha = 0
end

function UINewQuestStoryListItem:ResetAlph()
  self.canvasGroup.alpha = 1
end

function UINewQuestStoryListItem:PlayAnim()
  if self.rootAnim == nil then
    return
  end
  if self.rootAnim.gameObject == nil then
    return
  end
  if self.rootAnim.transform == nil then
    return
  end
  self.rootAnim.enabled = false
  self.rootAnim.enabled = true
  self.canvasGroup.alpha = 1
  self.rootAnim:Play("uieffanim_UINewQuestStoryListItem_in")
end

function UINewQuestStoryListItem:_OnValue()
  self._gotoGo:SetActive(false)
  self._getGo:SetActive(false)
  self._complete:SetActive(false)
  self._unCanGo:SetActive(false)
  if self._data.status == QuestStatus.QUEST_Accepted then
    self._gotoGo:SetActive(self._hookShowGoto)
  elseif self._data.status == QuestStatus.QUEST_Completed then
    self._getGo:SetActive(true)
  elseif self._data.status == QuestStatus.QUEST_NotStart then
    self._unCanGo:SetActive(true)
  elseif self._data.status == QuestStatus.QUEST_Taken then
    self._complete:SetActive(true)
  else
    Log.error("###[Quest] get a quest , state is error , state --> ", self._data.status, "|quest id  --> ", self._data.quest_id)
  end
  local rate = self._data.cur_progress / self._data.total_progress
  self._targetValueImg.fillAmount = rate
  local progress = ""
  if self._data.ShowType == 1 then
    local c, d = math.modf(self._data.cur_progress * 100 / self._data.total_progress)
    if c < 1 and 0 < d then
      c = 1
    end
    progress = c .. "%"
  else
    progress = self._data.cur_progress .. "<color=#cfb38c>" .. "/" .. self._data.total_progress .. "</color>"
  end
  self._targetValueTex:SetText(progress)
  self._targetTex:SetText(StringTable.Get(self._target))
  self._revolvingText:OnRefreshRevolving()
  self._awardPool:SpawnObjects("UIQuestSideAwardItem", table.count(self._items))
  local pools = self._awardPool:GetAllSpawnList()
  for i = 1, table.count(self._items) do
    local id = self._items[i].assetid
    local cfg_item = Cfg.cfg_item[id]
    if not cfg_item then
      Log.error(" UINewQuestStoryListItem can't find cfg_item ", id)
    end
    local params = {}
    params.quality = cfg_item.Color
    params.icon = cfg_item.Icon
    params.text = self._items[i].count
    pools[i]:SetData(id, params, self._awardClick)
  end
end

function UINewQuestStoryListItem:GetOnClick()
  if self._hookGet ~= nil then
    self._hookGet(self._index)
    return
  end
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:Lock("UIQuestGet")
  GameGlobal.TaskManager():StartTask(self.GetClick, self)
end

function UINewQuestStoryListItem:GoToOnClick()
  if self._hookGoto ~= nil then
    self._hookGoto(self._index)
    return
  end
  local jumpModule = self._questModule.uiModule
  if jumpModule == nil then
    Log.fatal("[quest] error --> uiModule is nil ! --> jumpModule")
    return
  end
  local fromParam = {}
  table.insert(fromParam, QuestType.QT_Branch)
  jumpModule:SetFromUIData(FromUIType.NormalUI, "UIQuestController", UIStateType.UIMain, fromParam)
  local jumpType = self._data.JumpID
  local jumpParams = self._data.JumpParam
  jumpModule:SetJumpUIData(jumpType, jumpParams)
  jumpModule:Jump()
end

function UINewQuestStoryListItem:OnHide()
  self._isIntroPlayed = false
end

function UINewQuestStoryListItem:GetClick(TT)
  local res, msg = self._questModule:TakeQuestReward(TT, self._data.quest_id)
  self:UnLock("UIQuestGet")
  local result = res:GetResult()
  if result == 0 then
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
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, QuestType.QT_Main)
      end)
    else
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Main)
      end)
    end
  end
end

function UINewQuestStoryListItem:GetGotoBtnObj()
  return self._gotoGo
end

function UINewQuestStoryListItem:GetRewardBtnObj()
  return self._getGo
end

function UINewQuestStoryListItem:CheckQuestId(questId)
  return self._data and self._data.quest_id == questId
end

function UINewQuestStoryListItem:IsCanGogo()
  return self._data.status == QuestStatus.QUEST_Accepted
end
