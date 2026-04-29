_class("UIMedalBgListItem", UICustomWidget)
UIMedalBgListItem = UIMedalBgListItem

function UIMedalBgListItem:Constructor()
  self.medalData = nil
  self.callBack = nil
  self.select = false
  self._redState = false
  self._pstid = nil
end

function UIMedalBgListItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIMedalBgListItem:_GetComponents()
  self.medalBgLoader = self:GetUIComponent("RawImageLoader", "medal_bg")
  self.medalBg = self:GetUIComponent("RawImage", "medal_bg")
  self.medalRedPoiot = self:GetGameObject("medal_redPoiot")
  self.medalSelectObj = self:GetGameObject("medal_select")
  self.medalLockBg = self:GetGameObject("medal_lock_bg")
end

function UIMedalBgListItem:SetData(data, callBack)
  self.medalData = data
  self.callBack = callBack
  self:CheckLock()
  self:ShowRedPoint()
  self:SetSelect(false)
  local icon = Cfg.cfg_item_medal_board[self.medalData.medal_id].Icon
  if icon then
    self.medalBgLoader:LoadImage(icon)
  else
    self.medalBgLoader:LoadImage("icon_item_6000202")
  end
end

function UIMedalBgListItem:GetData()
  return self.medalData
end

function UIMedalBgListItem:GetID()
  return self.medalData.medal_id
end

function UIMedalBgListItem:CheckLock()
  local locked = self.medalData.status == RewardStatus.E_MEDAL_REWARD_LOCK
  self.medalLockBg:SetActive(locked)
  if locked then
    self.medalBg.color = Color(1, 1, 1, 0.7)
  end
  return locked
end

function UIMedalBgListItem:ShowRedPoint()
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

function UIMedalBgListItem:SetSelect(bSelect)
  self.medalSelectObj:SetActive(bSelect)
end

function UIMedalBgListItem:MedalBtnOnClick(go)
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
    self.callBack(self)
  end
end
