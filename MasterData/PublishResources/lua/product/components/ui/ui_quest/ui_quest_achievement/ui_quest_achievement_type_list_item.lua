_class("UIQuestAchievementTypeListItem", UICustomWidget)
UIQuestAchievementTypeListItem = UIQuestAchievementTypeListItem

function UIQuestAchievementTypeListItem:OnShow(uiParams)
  self._atlas = self:RootUIOwner():GetAsset("UIQuest.spriteatlas", LoadType.SpriteAtlas)
end

function UIQuestAchievementTypeListItem:SetData(type, sp1, sp2, nameStr, callback)
  self._select = 0
  self:_GetComponents()
  self._type = type
  self._sp1 = sp1
  self._sp2 = sp2
  self._nameStr = nameStr
  self._callback = callback
end

function UIQuestAchievementTypeListItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UIQuestAchievementTypeListItem:_GetComponents()
  self._icon = self:GetUIComponent("Image", "icon")
  self._name1 = self:GetUIComponent("UILocalizedTMP", "name1")
  self._name1Go = self:GetGameObject("name1")
  self._name2 = self:GetUIComponent("UILocalizedTMP", "name2")
  self._name2Go = self:GetGameObject("name2")
  self._selectGo = self:GetGameObject("select")
  self._selectGo:SetActive(true)
  self._selectImg = self:GetUIComponent("Image", "select")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIQuestAchievementTypeListItem:_OnValue()
  local spName = self._select and self._sp2 or self._sp1
  self._icon.sprite = self._atlas:GetSprite(spName)
  self._name2Go:SetActive(not self._select)
  self._name1Go:SetActive(self._select)
  self._name1:SetText(StringTable.Get(self._nameStr))
  self._name2:SetText(StringTable.Get(self._nameStr))
end

function UIQuestAchievementTypeListItem:BtnOnClick(go)
  if self._select == true then
    return
  end
  if self._callback then
    self._callback(self._type)
  end
end

function UIQuestAchievementTypeListItem:Select(type)
  local select = self._type == type
  Log.fatal("###[UIQuestAchievementTypeListItem] type:", type, "|select:", select)
  if self._select == 0 then
    if select then
      self._selectImg.color = Color(1, 1, 1, 1)
    else
      self._selectImg.color = Color(1, 1, 1, 0)
    end
  else
    self._anim:Stop()
    if self._select == false and select == true then
      if self._timer then
        GameGlobal.Timer():CancelEvent(self._timer)
      end
      self._timer = GameGlobal.Timer():AddEvent(50, function()
        self._selectImg.color = Color(1, 1, 1, 0)
        self._anim:Play("uieffanim_UIQuestAchievementTypeListItem_in")
      end)
    elseif self._select == true and select == false then
      self._selectImg.color = Color(1, 1, 1, 1)
      self._anim:Play("uieffanim_UIQuestAchievementTypeListItem_out")
    end
  end
  self._select = select
  self:_OnValue()
end
