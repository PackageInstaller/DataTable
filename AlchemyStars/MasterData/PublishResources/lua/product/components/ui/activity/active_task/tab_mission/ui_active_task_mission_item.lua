_class("UIActiveTaskMissionItem", UICustomWidget)
UIActiveTaskMissionItem = UIActiveTaskMissionItem

function UIActiveTaskMissionItem:Constructor()
  self._delayTimer = 50
  self._primaryPos = Vector2(0, -10)
end

function UIActiveTaskMissionItem:OnShow(uiParams)
  self:_GetComponents()
  self._specialTaskID = {}
  self._atlas = self:GetAsset("Valentine.spriteatlas", LoadType.SpriteAtlas)
end

function UIActiveTaskMissionItem:_GetComponents()
  self._taskTxt = self:GetUIComponent("UILocalizationText", "taskTxt")
  self._progressTxt = self:GetUIComponent("UILocalizationText", "progress")
  self._iconContent = self:GetUIComponent("UISelectObjectPath", "iconContent")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._fullRect = self:GetUIComponent("RectTransform", "Full")
  self._doneBtnObj = self:GetGameObject("doneBtn")
  self._taskBtnObj = self:GetGameObject("taskBtn")
  self._getBtnObj = self:GetGameObject("getBtn")
  self._getCantGoBtn = self:GetGameObject("getCantGoBtn")
end

function UIActiveTaskMissionItem:SetData(quest, data, iconClickCb)
  self._quest = quest
  self._data = data
  self._iconClickCb = iconClickCb
  self._cfg = Cfg.cfg_quest[quest:ID()]
  self:InitData()
end

function UIActiveTaskMissionItem:InitData()
  local reward = self._cfg.Reward[1]
  self._taskTxt:SetText(StringTable.Get(self._cfg.QuestDesc))
  self._reward = self._iconContent:SpawnObject("UIActiveTaskMissionReward")
  local rew = {}
  rew.assetid = reward[1]
  rew.count = reward[2]
  self._reward:Flush(rew, function(id, pos)
    if self._iconClickCb then
      self._iconClickCb(id, pos)
    end
  end)
  self:SetBtnStatus(self._quest:Status())
end

function UIActiveTaskMissionItem:Open(index)
  self:StartTask(function(TT)
    YIELD(TT, self._delayTimer * index)
    self._anim:Play("uieff_UIActiveTaskMissionItem_doneBtn_in")
  end)
end

function UIActiveTaskMissionItem:Close()
  self._fullRect.anchoredPosition = self._primaryPos
end

function UIActiveTaskMissionItem:SetBtnStatus(status)
  local info = self._quest:QuestInfo()
  local curProcess = info.cur_progress
  local totalPorcess = info.total_progress
  local isSpecial = self:_CheckTaskIsSpecial(self._quest:ID())
  totalPorcess = isSpecial and 1 or totalPorcess
  if status == QuestStatus.QUEST_Completed then
    curProcess = isSpecial and 1 or curProcess
    local tmpStr = "<color=#A77B4A>" .. curProcess .. "</color>/" .. totalPorcess
    local str = StringTable.Get("str_n32_turn_card_process", tmpStr)
    self._progressTxt:SetText(str)
    self._doneBtnObj:SetActive(false)
    self._taskBtnObj:SetActive(false)
    self._getBtnObj:SetActive(true)
    self._getCantGoBtn:SetActive(false)
  elseif status == QuestStatus.QUEST_Taken then
    curProcess = isSpecial and 1 or curProcess
    local tmpStr = "<color=#A77B4A>" .. curProcess .. "</color>/" .. totalPorcess
    local str = StringTable.Get("str_n32_turn_card_process", tmpStr)
    self._progressTxt:SetText(str)
    self._doneBtnObj:SetActive(true)
    self._taskBtnObj:SetActive(false)
    self._getBtnObj:SetActive(false)
    self._getCantGoBtn:SetActive(false)
  else
    curProcess = isSpecial and 0 or curProcess
    local tmpStr = "<color=#f08c58>" .. curProcess .. "</color>/" .. totalPorcess
    local str = StringTable.Get("str_n32_turn_card_process", tmpStr)
    self._progressTxt:SetText(str)
    self._doneBtnObj:SetActive(false)
    self._getBtnObj:SetActive(false)
    local jumpType = info.JumpID
    if jumpType == 0 then
      self._taskBtnObj:SetActive(false)
      self._getCantGoBtn:SetActive(true)
    else
      self._taskBtnObj:SetActive(true)
      self._getCantGoBtn:SetActive(false)
    end
  end
end

function UIActiveTaskMissionItem:TaskBtnOnClick()
  if self._quest and self._quest:Status() >= QuestStatus.QUEST_Completed then
    return
  end
  local isOver = self._data:CheckTaskIsOver()
  if isOver then
    return
  end
  local questInfo = self._quest:QuestInfo(QuestStatus.QUEST_Taken)
  local questModule = GameGlobal.GetModule(QuestModule)
  local jumpModule = questModule.uiModule
  local jumpType = questInfo.JumpID
  local jumpParam = questInfo.JumpParam
  if jumpType == 0 then
    return
  end
  jumpModule:SetJumpUIData(jumpType, jumpParam)
  jumpModule:Jump()
end

function UIActiveTaskMissionItem:GetBtnOnClick()
  if self._quest and self._quest:Status() > QuestStatus.QUEST_Completed then
    return
  end
  local isOver = self._data:CheckTaskIsOver()
  if isOver then
    return
  end
  local questId = self._quest:ID()
  local comp = self._data:GetMissionComp()
  local res = AsyncRequestRes:New()
  self:StartTask(function(TT)
    local ret, rewards = comp:HandleQuestTake(TT, res, questId)
    if res:GetSucc() then
      self:ShowDialog("UIGetItemController", rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshActiveTaskRed)
      end)
    end
  end, self)
end

function UIActiveTaskMissionItem:_CheckTaskIsSpecial(taskID)
  for _, v in ipairs(self._specialTaskID) do
    if v == taskID then
      return true
    end
  end
  return false
end
