_class("UIQuestAchievementAchieveTypeItem", UICustomWidget)
UIQuestAchievementAchieveTypeItem = UIQuestAchievementAchieveTypeItem

function UIQuestAchievementAchieveTypeItem:OnShow(uiParams)
  self._atlas = self:RootUIOwner():GetAsset("UIQuest.spriteatlas", LoadType.SpriteAtlas)
end

function UIQuestAchievementAchieveTypeItem:SetData(type, sprite, name, nowValue, allValue, callback)
  self:_GetComponents()
  self._type = type
  self._sprite = sprite
  self._name = name
  self._nowValue = nowValue
  self._allValue = allValue
  self._callback = callback
  self:_OnValue()
end

function UIQuestAchievementAchieveTypeItem:PlayAnim(yieldTime)
  self._anim.enabled = false
  self._anim.enabled = true
  self._anim:Stop()
  self._anim:Sample()
  self._canvasGroup.alpha = 0
  if yieldTime then
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
    self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._anim:Play("uieffanim_UIQuestAchievementAchieveTypeItem_in01")
    end)
  else
    self._anim:Play("uieffanim_UIQuestAchievementAchieveTypeItem_in01")
  end
end

function UIQuestAchievementAchieveTypeItem:BtnOnClick(go)
  if self._callback then
    self._callback(self._type)
  end
end

function UIQuestAchievementAchieveTypeItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UIQuestAchievementAchieveTypeItem:_GetComponents()
  self._icon = self:GetUIComponent("Image", "icon")
  self._nameTex = self:GetUIComponent("UILocalizationText", "nameTex")
  self._rateImg = self:GetUIComponent("Image", "rateImg")
  self._rateTex = self:GetUIComponent("UILocalizationText", "rateTex")
  self._red = self:GetGameObject("red")
  self._anim = self:GetUIComponent("Animation", "UIQuestAchievementAchieveTypeItem")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "rect")
end

function UIQuestAchievementAchieveTypeItem:_OnValue()
  self._icon.sprite = self._atlas:GetSprite(self._sprite)
  self._nameTex:SetText(StringTable.Get(self._name))
  local rate = self._nowValue / self._allValue
  self._rateImg.fillAmount = rate
  local str
  if self._nowValue >= self._allValue then
    str = "<color=#fdd100>" .. self._nowValue .. "/" .. self._allValue .. "</color>"
  else
    str = "<color=#fdd100>" .. self._nowValue .. "</color>" .. "/" .. self._allValue
  end
  self._rateTex:SetText(str)
  if self._red then
    self:SetRed()
  end
end

function UIQuestAchievementAchieveTypeItem:SetRed()
  self._red:SetActive(self:CheckRed(self._type))
end

function UIQuestAchievementAchieveTypeItem:CheckRed(type)
  local questModule = GameGlobal.GetModule(QuestModule)
  local redInfo = questModule:GetRedPoint()
  if table.count(redInfo[QuestType.QT_Achieve]) > 0 then
    for i = 1, table.count(redInfo[QuestType.QT_Achieve]) do
      if redInfo[QuestType.QT_Achieve][i] == type then
        return true
      end
    end
  end
  return false
end
