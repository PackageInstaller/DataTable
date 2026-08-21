_class("UIMedalGroupListItem", UICustomWidget)
UIMedalGroupListItem = UIMedalGroupListItem

function UIMedalGroupListItem:Constructor()
  self.medalData = nil
  self.callBack = nil
  self.select = false
  self._redState = false
  self._pstid = nil
  self._isSelect = nil
end

function UIMedalGroupListItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIMedalGroupListItem:_GetComponents()
  self.medalBg = self:GetUIComponent("RawImageLoader", "medal_bg")
  self.medalRedPoiot = self:GetGameObject("medal_redPoiot")
  self.medalSelectObj = self:GetGameObject("medal_select")
  self.medal_collect = self:GetUIComponent("UILocalizationText", "medal_collect")
  self.bg_collect = self:GetUIComponent("UILocalizationText", "bg_collect")
  self.anim = self:GetUIComponent("Animation", "UIMedalGroupListItem")
  self._anims = {
    select_in = "uieff_UIMedalBgListItem_unlocked_select_in",
    normal_in = "uieff_UIMedalBgListItem_unlocked_in",
    switch_out = "uieff_UIMedalBgListItem_switch_out",
    switch_in = "uieff_UIMedalBgListItem_switch_in"
  }
end

function UIMedalGroupListItem:SetData(idx, data, callBack)
  self.idx = idx
  self.medalData = data
  self.callBack = callBack
  self:CheckLock()
  self:ShowRedPoint()
  self:SetSelect(false)
  local icon = Cfg.cfg_item_medal_board[self.medalData.BoardID].Icon
  if icon then
    self.medalBg:LoadImage(icon)
  else
    self.medalBg:LoadImage("icon_item_6000202")
  end
  self:SetBgCollect()
  self:SetMedalListCollect()
  self:PlayAnim()
  self._inited = true
end

function UIMedalGroupListItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UIMedalGroupListItem:PlayAnim()
  local rootTr = self:GetUIComponent("RectTransform", "Root")
  rootTr.anchoredPosition = Vector2(0, -30)
  local canvasG = self:GetUIComponent("CanvasGroup", "UIMedalGroupListItem")
  canvasG.alpha = 0
  local yieldTime = (self.idx - 1) * 60
  self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
    if self.idx == 1 then
      self.anim:Play(self._anims.select_in)
    else
      self.anim:Play(self._anims.normal_in)
    end
  end)
end

function UIMedalGroupListItem:SetBgCollect()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local boardid = self.medalData.BoardID
  local items = itemModule:GetItemByTempId(boardid)
  local have = items and next(items)
  local haveCount = have and 1 or 0
  local allCount = 1
  self.bg_collect:SetText(haveCount .. "/" .. allCount)
end

function UIMedalGroupListItem:SetMedalListCollect()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local medals = self.medalData.MedalIDList
  local allCount = #medals
  local haveCount = 0
  for key, value in pairs(medals) do
    local medalid = value[1]
    local items = itemModule:GetItemByTempId(medalid)
    local have = items and next(items)
    if have then
      haveCount = haveCount + 1
    end
  end
  self.medal_collect:SetText(haveCount .. "/" .. allCount)
end

function UIMedalGroupListItem:GetData()
  return self.medalData
end

function UIMedalGroupListItem:GetID()
  return self.medalData.medal_id
end

function UIMedalGroupListItem:CheckLock()
  local locked = self.medalData.status == RewardStatus.E_MEDAL_REWARD_LOCK
  return locked
end

function UIMedalGroupListItem:ShowRedPoint()
  local item_data
  local itemModule = GameGlobal.GetModule(ItemModule)
  local items = itemModule:GetItemByTempId(self.medalData.medal_id)
  if items and table.count(items) > 0 then
    for key, value in pairs(items) do
      item_data = value
      break
    end
  end
  if item_data then
    self._redState = item_data:IsNewOverlay()
    self._pstid = item_data:GetID()
  end
  if self:CheckLock() then
    self.medalRedPoiot:SetActive(false)
  else
    self.medalRedPoiot:SetActive(self._redState)
  end
end

function UIMedalGroupListItem:SetSelect(bSelect)
  self.medalSelectObj:SetActive(bSelect)
end

function UIMedalGroupListItem:Select(idx)
  self:SetSelect(idx == self.idx)
  local isSelect = idx == self.idx
  if self._isSelect == nil then
  elseif self._isSelect == false and isSelect then
    self.anim:Play(self._anims.switch_in)
  elseif self._isSelect == true and not isSelect then
    self.anim:Play(self._anims.switch_out)
  end
  self._isSelect = isSelect
end

function UIMedalGroupListItem:MedalBtnOnClick(go)
  self:StartTask(function(TT)
    if self.medalData.medal_id and self._pstid then
      local itemModule = GameGlobal.GetModule(ItemModule)
      itemModule:SetItemUnnewOverlay(TT, self._pstid)
      itemModule:SetItemUnnew(TT, self._pstid)
    end
  end)
  self._redState = false
  self.medalRedPoiot:SetActive(self._redState)
  if self.callBack then
    self.callBack(self.idx)
  end
end
