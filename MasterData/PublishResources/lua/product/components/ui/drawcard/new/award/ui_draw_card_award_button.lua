_class("UIDrawCardAwardButton", UICustomWidget)
UIDrawCardAwardButton = UIDrawCardAwardButton

function UIDrawCardAwardButton:OnShow(uiParam)
  self:GetComponents()
  self:AttachEvent(GameEventType.OnDrawCardGetAward, self.RefreshInfo)
end

function UIDrawCardAwardButton:GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._num = self:GetUIComponent("UILocalizationText", "num")
  self._rate = self:GetUIComponent("UILocalizationText", "rate")
  self._getEffObj = self:GetGameObject("getEff")
end

function UIDrawCardAwardButton:SetData(comp)
  self._comp = comp
  self:RefreshInfo()
end

function UIDrawCardAwardButton:RefreshInfo()
  if not self._comp then
    return
  end
  local curQuest, preQuest = self:GetCurQuest()
  local curAward = curQuest._questInfo.rewards[1]
  local finalQuest = self:GetFinalQuest()
  if curQuest == preQuest then
    self._rate:SetText(StringTable.Get("str_aircraft_tactic_rank_btn_finish"))
  else
    local finalProgress = finalQuest._questInfo.cur_progress
    local targetProgress = curQuest._questInfo.total_progress
    local progress = finalProgress .. "/" .. targetProgress
    self._rate:SetText(progress)
  end
  self._getEffObj:SetActive(curQuest._questInfo.status == QuestStatus.QUEST_Completed)
  local itemCfg = Cfg.cfg_item[curAward.assetid]
  self._icon:LoadImage(itemCfg.Icon)
  self._num:SetText("×" .. curAward.count)
end

function UIDrawCardAwardButton:BtnAwardOnClick()
  local questList = self._comp:GetQuestInfo()
  self:ShowDialog("UIDrawCardAwardController", questList, self._comp)
end

function UIDrawCardAwardButton:GetCurQuest()
  local curQuest, preQuest
  local questList = self._comp:GetQuestInfo()
  for _, quest in pairs(questList) do
    if quest._questInfo.status < QuestStatus.QUEST_Completed then
      curQuest = quest
      break
    elseif quest._questInfo.status == QuestStatus.QUEST_Completed then
      curQuest = quest
      break
    else
      preQuest = quest
    end
  end
  if not curQuest then
    local len = table.count(questList)
    curQuest = questList[len]
    preQuest = curQuest
  end
  return curQuest, preQuest
end

function UIDrawCardAwardButton:GetFinalQuest()
  local questList = self._comp:GetQuestInfo()
  return questList[table.count(questList)]
end
