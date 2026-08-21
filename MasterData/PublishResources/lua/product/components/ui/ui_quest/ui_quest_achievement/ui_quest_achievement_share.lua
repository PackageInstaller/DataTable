_class("UIQuestAchievementShare", UIController)
UIQuestAchievementShare = UIQuestAchievementShare

function UIQuestAchievementShare:Constructor()
  self._questModule = GameGlobal.GetModule(QuestModule)
  self._cfg_quest_achieve_type = Cfg.cfg_quest_achieve_type({})
end

function UIQuestAchievementShare:OnShow(uiParams)
  self:_GetComponents()
  self:_OnValue()
end

function UIQuestAchievementShare:_GetComponents()
  self._achTypePool = self:GetUIComponent("UISelectObjectPath", "achTypePool")
  self._allViewFillAmont = self:GetUIComponent("Image", "allViewFillAmont")
  self._allViewValue = self:GetUIComponent("UILocalizationText", "allViewValue")
  self._allViewValue2 = self:GetUIComponent("UILocalizedTMP", "allViewValue2")
end

function UIQuestAchievementShare:_OnValue()
  self:_InitAchTypePool()
  self:_Share()
end

function UIQuestAchievementShare:_InitAchTypePool()
  local allViewType = self._cfg_quest_achieve_type[1].BigTypeEnum
  local allViewNowValue, allViewAllValue = self:GetCountByType(allViewType)
  self._allViewFillAmont.fillAmount = allViewNowValue / allViewAllValue
  self._allViewValue:SetText(allViewNowValue)
  self._allViewValue2:SetText("/" .. allViewAllValue)
  local achieveTypes = {}
  for i = 1, #self._cfg_quest_achieve_type do
    if i ~= 1 then
      table.insert(achieveTypes, self._cfg_quest_achieve_type[i])
    end
  end
  local count = table.count(achieveTypes)
  self._achTypePool:SpawnObjects("UIQuestAchievementAchieveTypeItem", count)
  local items = self._achTypePool:GetAllSpawnList()
  for i = 1, count do
    local name = achieveTypes[i].BigTypeName
    local type = achieveTypes[i].BigTypeEnum
    local nowValue, allValue = self:GetCountByType(type)
    local sprite = achieveTypes[i].Icon
    items[i]:SetData(type, sprite, name, nowValue, allValue)
  end
end

function UIQuestAchievementShare:GetCountByType(enum)
  local cur, total, taken = self._questModule:GetAchieveCount(enum)
  return taken, total
end

function UIQuestAchievementShare:_Share()
  self:Lock("UIQuestAchievementShare")
  self:StartTask(function(TT)
    YIELD(TT)
    self:ShowDialog("UIShare", self:GetName(), nil, function()
      self:CloseDialog()
    end, nil, nil, nil, ShareSceneType.Achievement)
    self:UnLock("UIQuestAchievementShare")
  end, self)
end
