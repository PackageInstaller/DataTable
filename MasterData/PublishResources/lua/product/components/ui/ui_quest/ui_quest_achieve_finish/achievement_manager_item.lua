_class("AchievementManagerItem", Object)
AchievementManagerItem = AchievementManagerItem

function AchievementManagerItem:SetGameObject(go)
  self._go = go
  self:_GetComponents()
  self._go:SetActive(false)
end

function AchievementManagerItem:OnHide()
  self._go:SetActive(false)
end

function AchievementManagerItem:SetData(quest)
  self._go:SetActive(true)
  self._achieveTagTex:SetText(StringTable.Get(quest.QuestName))
  self._achieveDesTex:SetText(StringTable.Get(quest.QuestDesc))
  local _c = 0
  local rewards = quest.rewards
  for i = 1, #rewards do
    local reward = rewards[i]
    if reward.assetid == RoleAssetID.RoleAssetAchPoint then
      _c = reward.count
      break
    end
  end
  self._achievePointTex:SetText("+" .. _c)
end

function AchievementManagerItem:DoTween()
  self._tweenImg:DOFillAmount(1, 0.4)
  self._quan:DOLocalRotate(Vector3(0, 0, 360), 0.4, DG.Tweening.RotateMode.FastBeyond360)
end

function AchievementManagerItem:ReplyTween()
  self._quan.localRotation = Quaternion:SetEuler(0, 0, -150)
  self._tweenImg.fillAmount = 0
end

function AchievementManagerItem:_GetComponents()
  self._rect = self._go.transform:Find("rect").gameObject:GetComponent("RectTransform")
  self._titleTex = self._go.transform:Find("rect/Title/LocalizationText").gameObject:GetComponent("UILocalizationText")
  self._titleTex:SetText(StringTable.Get("str_quest_base_new_achievement"))
  self._achieveTagTex = self._go.transform:Find("rect/achieveTagTex").gameObject:GetComponent("UILocalizationText")
  self._achieveDesTex = self._go.transform:Find("rect/GameObject/achieveDesTex").gameObject:GetComponent("UILocalizationText")
  self._achievePointTex = self._go.transform:Find("rect/GameObject/GameObject/Image/achievePointTex").gameObject:GetComponent("UILocalizationText")
  self._tweenImg = self._go.transform:Find("rect/Title/LocalizationText/GameObject/dui").gameObject:GetComponent("Image")
  self._quan = self._go.transform:Find("rect/Title/LocalizationText/GameObject/quan").gameObject:GetComponent("Transform")
end

function AchievementManagerItem:Dispose()
  self._rect = nil
  self._achieveTagTex = nil
  self._achieveDesTex = nil
  self._achievePointTex = nil
  self._tweenImg = nil
  self._quan = nil
  self._go = nil
end

function AchievementManagerItem:GetRectTransform()
  return self._rect
end

function AchievementManagerItem:_OnValue()
  self._achieveTagTex:SetText(StringTable.Get(self.quest.QuestName))
  self._achieveDesTex:SetText(StringTable.Get(self.quest.QuestDesc))
  local _c = 0
  local rewards = self.quest.rewards
  for i = 1, #rewards do
    local reward = rewards[i]
    if reward.assetid == RoleAssetID.RoleAssetAchPoint then
      _c = reward.count
    end
  end
  self._achievePointTex:SetText("+" .. _c)
end
