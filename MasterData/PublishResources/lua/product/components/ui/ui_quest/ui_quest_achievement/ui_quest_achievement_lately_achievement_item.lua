_class("UIQuestAchievementLatelyAchieveItem", UICustomWidget)
UIQuestAchievementLatelyAchieveItem = UIQuestAchievementLatelyAchieveItem

function UIQuestAchievementLatelyAchieveItem:OnShow(uiParams)
  self._module = GameGlobal.GetModule(QuestModule)
  if self._module == nil then
    Log.fatal("[quest] error --> module is nil !")
    return
  end
  self._atlas = self:RootUIOwner():GetAsset("UIQuest.spriteatlas", LoadType.SpriteAtlas)
end

function UIQuestAchievementLatelyAchieveItem:SetData(index, quest, getCallback, awardCallBack, forceFinish, isIntro)
  self:_GetComponents()
  self._quest = quest
  self._index = index
  self._forceFinish = forceFinish
  self._point = 0
  for i = 1, #self._quest.rewards do
    if self._quest.rewards[i].assetid == RoleAssetID.RoleAssetAchPoint then
      self._point = self._quest.rewards[i].count
    end
  end
  self._getCallback = getCallback
  self._awardCallBack = awardCallBack
  if self._forceFinish then
    self._finishState = QuestStatus.QUEST_Taken
  else
    self._finishState = quest.status
  end
  self:_OnValue()
  self._anim:Stop()
  self._alpha.alpha = 0
  if isIntro then
    self:PlayAnim()
  else
    self._alpha.alpha = 1
  end
end

function UIQuestAchievementLatelyAchieveItem:PlayAnim()
  local yieldTime = (self._index - 1) * 50
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  if yieldTime == 0 then
    self._anim:Play("uieffanim_UIQuestAchievementLatelyAchieveItem_in")
  else
    self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._anim:Play("uieffanim_UIQuestAchievementLatelyAchieveItem_in")
    end)
  end
end

function UIQuestAchievementLatelyAchieveItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UIQuestAchievementLatelyAchieveItem:_GetComponents()
  self._achieveTagTex = self:GetUIComponent("UILocalizationText", "achieveTagTex")
  self._achieveDesTex = self:GetUIComponent("UILocalizationText", "achieveDesTex")
  self._achievePointTex = self:GetUIComponent("UILocalizationText", "achievePointTex")
  self._stateValueTex = self:GetUIComponent("UILocalizationText", "stateValueTex")
  self._finishGo = self:GetGameObject("Finish")
  self._gotoGo = self:GetGameObject("GoTo")
  self._getGo = self:GetGameObject("Get")
  self._pools = self:GetUIComponent("UISelectObjectPath", "pools")
  self._anim = self:GetUIComponent("Animation", "UIQuestAchievementLatelyAchieveItem")
  self._alpha = self:GetUIComponent("CanvasGroup", "UIQuestAchievementLatelyAchieveItem")
end

function UIQuestAchievementLatelyAchieveItem:_OnValue()
  self._achieveTagTex:SetText(StringTable.Get(self._quest.QuestName))
  self._achieveDesTex:SetText(StringTable.Get(self._quest.CondDesc))
  self._achievePointTex:SetText("+" .. self._point)
  local progress = ""
  if self._quest.ShowType == 1 then
    local c, d = math.modf(self._quest.cur_progress * 100 / self._quest.total_progress)
    if c < 1 and 0 < d then
      c = 1
    end
    progress = c .. "%"
  else
    progress = self._quest.cur_progress .. " /" .. self._quest.total_progress
  end
  self._stateValueTex:SetText(progress)
  self:_CheckQuestState()
  local awards = self._quest.rewards
  local awardsTemp = {}
  for i = 1, #awards do
    local award = awards[i]
    if award.assetid ~= RoleAssetID.RoleAssetAchPoint then
      table.insert(awardsTemp, award)
    end
  end
  local awardsCount = table.count(awardsTemp)
  self._pools:SpawnObjects("UIQuestSideAwardItem", awardsCount)
  local items = self._pools:GetAllSpawnList()
  for i = 1, table.count(items) do
    if i <= awardsCount then
      items[i]:GetGameObject():SetActive(true)
      local id = awardsTemp[i].assetid
      local cfg_item = Cfg.cfg_item[id]
      local params = {}
      params.quality = cfg_item.Color
      params.icon = cfg_item.Icon
      params.text = awardsTemp[i].count
      items[i]:SetData(id, params, self._awardCallBack)
    else
      items[i]:GetGameObject():SetActive(false)
    end
  end
end

function UIQuestAchievementLatelyAchieveItem:_CheckQuestState()
  self._finishGo:SetActive(false)
  self._gotoGo:SetActive(false)
  self._getGo:SetActive(false)
  if self._finishState <= QuestStatus.QUEST_Accepted then
    self._gotoGo:SetActive(true)
  elseif self._finishState == QuestStatus.QUEST_Completed then
    self._getGo:SetActive(true)
  elseif self._finishState == QuestStatus.QUEST_Taken then
    self._finishGo:SetActive(true)
  end
end

function UIQuestAchievementLatelyAchieveItem:GetBtnOnClick()
  if self._getCallback then
    self._getCallback(self._quest)
  end
end
