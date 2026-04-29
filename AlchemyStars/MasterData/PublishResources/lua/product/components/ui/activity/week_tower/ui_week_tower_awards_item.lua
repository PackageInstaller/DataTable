_class("UIWeekTowerAwardsItem", UICustomWidget)
UIWeekTowerAwardsItem = UIWeekTowerAwardsItem

function UIWeekTowerAwardsItem:OnShow(uiParams)
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._starCount = self:GetUIComponent("UILocalizationText", "starCount")
  self._items = self:GetUIComponent("UISelectObjectPath", "items")
  self._btnCanGet = self:GetGameObject("BtnCanGet")
  self._btnGot = self:GetGameObject("BtnGot")
  self._needStars = self:GetGameObject("needStars")
  self._needStarCount = self:GetUIComponent("UILocalizationText", "needStarCount")
  self._anim = self:GetUIComponent("Animation", "UIWeekTowerAwardsItem")
end

function UIWeekTowerAwardsItem:SetData(questCmpt, quest, playEnterAnim, index)
  self._questCmpt = questCmpt
  self._quest = quest
  local questInfo = quest:QuestInfo()
  self._title:SetText(StringTable.Get(questInfo.QuestName))
  self._starCount:SetText(questInfo.total_progress)
  local status = quest:Status()
  if status == QuestStatus.QUEST_Taken then
    self._btnGot:SetActive(true)
    self._btnCanGet:SetActive(false)
    self._needStars:SetActive(false)
  elseif status == QuestStatus.QUEST_Completed then
    self._btnGot:SetActive(false)
    self._btnCanGet:SetActive(true)
    self._needStars:SetActive(false)
  else
    self._btnGot:SetActive(false)
    self._btnCanGet:SetActive(false)
    self._needStars:SetActive(true)
    self._needStarCount:SetText(questInfo.cur_progress .. "/" .. questInfo.total_progress)
  end
  local rewards = questInfo.rewards
  local uiAssets = self._items:SpawnObjects("UIAsset", #rewards)
  for i = 1, #rewards do
    local reward = rewards[i]
    local uiAsset = uiAssets[i]
    local cfgItem = Cfg.cfg_item[reward.assetid]
    local icon = cfgItem.Icon
    local quality = cfgItem.Color
    uiAsset:SetData(reward.assetid)
    uiAsset:SetItemData({
      showBG = true,
      icon = icon,
      text = reward.count,
      quality = quality
    })
    local eventComponent = uiAsset:AddComponent(UIAssetComponentEvent)
    eventComponent:SetClickCallBack(function(go)
      self:ShowTip(reward.assetid, go)
    end)
  end
  if playEnterAnim and index < 6 then
    self._anim:Play()
    self._anim:Sample()
    self._anim:Stop()
    self._animTask = self:StartTask(function(TT)
      local frame = index - 1
      while 0 < frame do
        YIELD(TT)
        frame = frame - 1
      end
      self._anim:Play()
      self._animTask = nil
    end)
  end
end

function UIWeekTowerAwardsItem:OnHide()
  if self._animTask then
    GameGlobal.TaskManager():KillTask(self._animTask)
  end
end

function UIWeekTowerAwardsItem:ShowTip(id, go)
  self:CallUIMethod("UIWeekTowerAwardsController", "ShowAssetTips", id, go.transform.position)
end

function UIWeekTowerAwardsItem:BtnCanGetOnClick()
  self:StartTask(self.DoTakeQuest, self)
end

function UIWeekTowerAwardsItem:DoTakeQuest(TT)
  self:Lock("UIWeekTowerAwardsItem:DoTakeQuest")
  local res = AsyncRequestRes:New()
  local ret, rewards = self._questCmpt:HandleQuestTake(TT, res, self._quest:ID())
  if res:GetSucc() then
    self:ShowDialog("UIGetItemController", rewards)
    self:CallUIMethod("UIWeekTowerAwardsController", "RefreshUI")
  else
    LogWrapper.LogFatal("HandleQuestTake failed, ret:", ret)
  end
  self:UnLock("UIWeekTowerAwardsItem:DoTakeQuest")
end
