_class("UISendPetAward", UICustomWidget)
UISendPetAward = UISendPetAward

function UISendPetAward:OnShow(uiParam)
  self._posRect = self:GetUIComponent("RectTransform", "pos")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._countTex = self:GetUIComponent("UILocalizationText", "Count")
end

function UISendPetAward:SetData(state, roleAsset, progress, isLastAward, isRed, pos, callback)
  if pos then
    self._posRect.anchoredPosition = Vector2(pos, 0)
  end
  self._state = state
  self._callback = callback
  self._isLastAward = isLastAward
  self._roleAsset = roleAsset
  self._progress = progress
  self._isRed = isRed
  self._IconGO = self:GetGameObject("Icon")
  self._IconBigGO = self:GetGameObject("IconBig")
  self._IconGO:SetActive(not isLastAward)
  self._IconBigGO:SetActive(isLastAward)
  self:DoShow()
end

function UISendPetAward:DoShow()
  local isbig = ""
  if self._isLastAward then
    isbig = "Big"
  end
  self._posRect = self:GetUIComponent("RectTransform", "pos")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon" .. isbig)
  self._countTex = self:GetUIComponent("UILocalizationText", "count" .. isbig)
  self._porgressTex = self:GetUIComponent("UILocalizationText", "porgress" .. isbig)
  self._awardGO = self:GetGameObject("award")
  self._awardBigGO = self:GetGameObject("awardBig")
  self._doingGO = self:GetGameObject("doing" .. isbig)
  self._takeGO = self:GetGameObject("take" .. isbig)
  self._overGO = self:GetGameObject("over" .. isbig)
  self._redGO = self:GetGameObject("red" .. isbig)
  local cfg_item = Cfg.cfg_item[self._roleAsset.assetid]
  local icon = cfg_item.Icon
  self._iconLoader:LoadImage(icon)
  self:Refresh()
end

function UISendPetAward:Refresh()
  self._awardGO:SetActive(not self._isLastAward)
  self._awardBigGO:SetActive(self._isLastAward)
  self._doingGO:SetActive(false)
  self._overGO:SetActive(false)
  self._takeGO:SetActive(false)
  self._redGO:SetActive(false)
  self._countTex:SetText(self._roleAsset.count)
  if self._state == QuestStatus.QUEST_Completed then
    local finishColor = "#FFE8C9"
    local str = UIActivityHelper.GetColorText(finishColor, self._progress)
    self._porgressTex:SetText(str)
  elseif self._state == QuestStatus.QUEST_Taken then
    local finishColor = "#9C9C9C"
    local str = UIActivityHelper.GetColorText(finishColor, self._progress)
    self._porgressTex:SetText(str)
  elseif self._state == QuestStatus.QUEST_Accepted then
    local finishColor = "#FFFEFE"
    local str = UIActivityHelper.GetColorText(finishColor, self._progress)
    self._porgressTex:SetText(str)
  end
  self._countTex:SetText(self._roleAsset.count)
  if self._state == QuestStatus.QUEST_Completed then
    self._redGO:SetActive(true)
    self._takeGO:SetActive(true)
  elseif self._state == QuestStatus.QUEST_Accepted then
    self._doingGO:SetActive(true)
  else
    if self._state == QuestStatus.QUEST_Taken then
      self._overGO:SetActive(true)
    else
    end
  end
end

function UISendPetAward:AwardOnClick(go)
  if self._state == QuestStatus.QUEST_Completed then
    if self._callback then
      self._callback()
    end
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampaignCenterShowItemTips, self._roleAsset.assetid, go.transform.position)
  end
end

function UISendPetAward:AwardBigOnClick(go)
  if self._state == QuestStatus.QUEST_Completed then
    if self._callback then
      self._callback()
    end
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampaignCenterShowItemTips, self._roleAsset.assetid, go.transform.position)
  end
end
