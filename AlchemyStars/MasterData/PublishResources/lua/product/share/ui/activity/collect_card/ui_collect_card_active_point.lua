_class("UICollectCardActivePoint", UICustomWidget)
UICollectCardActivePoint = UICollectCardActivePoint

function UICollectCardActivePoint:OnShow(uiParam)
  self._pos = self:GetUIComponent("RectTransform", "Pos")
  self._imgNormal = self:GetGameObject("imgNormal")
  self._imgSpecial = self:GetGameObject("imgSpecial")
  self._red = self:GetGameObject("red")
  self._got = self:GetGameObject("got")
  self._gotNormal = self:GetGameObject("gotNormal")
  self._gotSpecial = self:GetGameObject("gotSpecial")
  self._eff = self:GetGameObject("eff")
  self._anim = self:GetUIComponent("Animation", "Btn")
  self._num = self:GetUIComponent("UILocalizationText", "Number")
end

function UICollectCardActivePoint:SetData(idx, questInfo, callback, maxPoint, sliderWidth)
  self._idx = idx
  self._questInfo = questInfo
  self._callback = callback
  local progress = self._questInfo.total_progress
  local posx = sliderWidth * (progress / maxPoint)
  self._pos.anchoredPosition = Vector2(posx, 0)
  local special = 1 < idx
  self._imgNormal:SetActive(not special)
  self._imgSpecial:SetActive(special)
  self._gotNormal:SetActive(not special)
  self._gotSpecial:SetActive(special)
  self._got:SetActive(self._questInfo.status == QuestStatus.QUEST_Taken)
  self._eff:SetActive(self._questInfo.status == QuestStatus.QUEST_Completed)
  self._num:SetText(progress)
  if self._questInfo.status == QuestStatus.QUEST_Completed then
    self._anim:Play()
  else
    self._anim:Stop()
  end
end

function UICollectCardActivePoint:BtnOnClick(go)
  if self._questInfo.status == QuestStatus.QUEST_Completed then
    if self._callback then
      self._callback(self._idx)
    end
  else
    local awards = self._questInfo.rewards
    local award = awards[1]
    local id = award.assetid
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampaignCenterShowItemTips, id, go.transform.position)
  end
end
