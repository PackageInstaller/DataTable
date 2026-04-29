_class("UIActivityN34TaskInfomationRewardPreviewItem", UICustomWidget)
UIActivityN34TaskInfomationRewardPreviewItem = UIActivityN34TaskInfomationRewardPreviewItem

function UIActivityN34TaskInfomationRewardPreviewItem:OnShow()
  self:GetComponents()
  self:Init()
end

function UIActivityN34TaskInfomationRewardPreviewItem:OnHide()
end

function UIActivityN34TaskInfomationRewardPreviewItem:GetComponents()
  self._titleText = self:GetUIComponent("UILocalizationText", "titleText")
  self._stateText = self:GetUIComponent("UILocalizationText", "stateText")
  self._rewards = self:GetUIComponent("UISelectObjectPath", "Content")
  self._rewardHasGet = self:GetGameObject("rewardHasGet")
end

function UIActivityN34TaskInfomationRewardPreviewItem:SetData(index, cfg, quest, questState, tipFun)
  self._index = index
  self._cfg = cfg
  self._quest = quest
  self._state = questState
  self._rewardHasGet:SetActive(self._state == 4)
  local questInfo = self._quest:QuestInfo()
  self._name = StringTable.Get(questInfo.QuestName) or ""
  self._des = StringTable.Get(questInfo.QuestDesc) or ""
  self._questReward = questInfo.rewards
  self._icon = questInfo.Icon
  self._tipFun = tipFun
  self:Refresh()
  local root = self:GetGameObject("Root")
  root:SetActive(false)
  self:StartTask(function(TT)
    YIELD(TT, index * 60)
    if not self.view then
      return
    end
    root:SetActive(true)
    local anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
    anim:Play()
  end)
end

function UIActivityN34TaskInfomationRewardPreviewItem:Init()
  self._titleText:SetText("")
  self._stateText:SetText("")
end

function UIActivityN34TaskInfomationRewardPreviewItem:Refresh()
  self._titleText:SetText(self._name)
  local stateText = ""
  if self._state == QuestStatus.QUEST_NotStart then
    stateText = ""
  end
  self._stateText:SetText(stateText)
  if #self._questReward > 0 then
    local items = self._rewards:SpawnObjects("UIN34TaskDelegatePersonProgressReward", #self._questReward)
    for index, value in ipairs(items) do
      value:SetData(self._questReward[index], self._tipFun)
    end
  end
end
