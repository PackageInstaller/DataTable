_class("UIDrawCardAwardItem", UICustomWidget)
UIDrawCardAwardItem = UIDrawCardAwardItem

function UIDrawCardAwardItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIDrawCardAwardItem:_GetComponents()
  self._scoreTxt = self:GetUIComponent("UILocalizationText", "scoreTxt")
  self._topBg = self:GetUIComponent("Image", "topBg")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._num = self:GetUIComponent("UILocalizationText", "num")
  self._finalBgObj = self:GetGameObject("finalBg")
  self._animObj = self:GetGameObject("anim")
  self._getMaskObj = self:GetGameObject("GetMask")
  self._canReceiveMaskObj = self:GetGameObject("CanReceiveMask")
  self._canReceiveRedMaskObj = self:GetGameObject("CanReceiveRedMask")
  self._getMaskObj:SetActive(false)
  self._canReceiveMaskObj:SetActive(false)
  self._canReceiveRedMaskObj:SetActive(false)
end

function UIDrawCardAwardItem:SetData(quest, index, isFinal, clickCallback, receiveCallback)
  self._quest = quest
  self._index = index
  self._clickCallback = clickCallback
  self._receiveCallback = receiveCallback
  self._finalBgObj:SetActive(isFinal)
  self:_InitComponents()
end

function UIDrawCardAwardItem:_InitComponents()
  self._ownerController = self:RootUIOwner()
  self._atlas = self._ownerController.atlas
  local questInfo = self._quest:QuestInfo()
  local reward = questInfo.rewards[1]
  self._canReceiveMaskObj:SetActive(questInfo.status == QuestStatus.QUEST_Completed)
  self._canReceiveRedMaskObj:SetActive(questInfo.status == QuestStatus.QUEST_Completed)
  self._getMaskObj:SetActive(questInfo.status == QuestStatus.QUEST_Taken)
  self._scoreTxt:SetText(StringTable.Get("str_draw_card_award_time_info1", questInfo.total_progress))
  local cfg = Cfg.cfg_item[reward.assetid]
  self._icon:LoadImage(cfg.Icon)
  self._num:SetText(reward.count)
end

function UIDrawCardAwardItem:FullBtnOnClick(go)
  local questInfo = self._quest:QuestInfo()
  if questInfo.status == QuestStatus.QUEST_Completed then
    if self._receiveCallback then
      self._receiveCallback()
    end
  elseif self._clickCallback then
    local questInfo = self._quest:QuestInfo()
    local reward = questInfo.rewards[1]
    self._clickCallback(reward.assetid, go.transform.position)
  end
end
