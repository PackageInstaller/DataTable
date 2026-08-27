local UINEpOverclockListItem = class("UINEpOverclockListItem", UIBaseNode)

function UINEpOverclockListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Select, self, self.OnBtnSelectClicked)
end

function UINEpOverclockListItem:InitOverclockListItem(clockOptionData, overclockCtrl, clockSelectAction)
  self.clockOptionData = clockOptionData
  self.overclockId = clockOptionData.overclockId
  self.__clockSelectAction = clockSelectAction
  local overclockCfg = ConfigData.overclock[self.overclockId]
  local overclockLevel = self.clockOptionData.overclockLevel or 1
  local overclockLevelCfg = overclockCfg[overclockLevel]
  if overclockLevelCfg == nil then
    error("not contain overclock id:" .. self.overclockId .. " Level:" .. overclockLevel)
    return
  end
  self.overclockLevelCfg = overclockLevelCfg
  self:__RefreshClockLockState(overclockCtrl)
  self:__RefreshClockItemInfo(overclockCtrl)
end

function UINEpOverclockListItem:__RefreshClockLockState(overclockCtrl)
  local isUsed = overclockCtrl:IsUseOverclockOption(self.overclockId)
  self.ui.obj_IsUse:SetActive(isUsed)
  self.ui.btn_Select.gameObject:SetActive(not isUsed)
  if isUsed then
    self.ui.obj_lock:SetActive(false)
    return
  end
  local isUnlock = self.clockOptionData.isUnlock
  local isLimit = overclockCtrl:IsUseClockLimit()
  if not isUnlock or isLimit then
    self.ui.obj_lock:SetActive(true)
    self.ui.obj_texLock:SetActive(not isUnlock)
    self.ui.obj_isLimit:SetActive(isUnlock)
    if not isUnlock then
      self.ui.tex_Condition.text = self.clockOptionData.unlockDes
    end
  else
    self.ui.obj_lock:SetActive(false)
  end
end

function UINEpOverclockListItem:__RefreshClockItemInfo(overclockCtrl)
  self.ui.tex_desc.text = LanguageUtil.GetLocaleText(self.overclockLevelCfg.describe)
  local freeNum = overclockCtrl:GetLastFreeNum()
  if 0 < freeNum and self.clockOptionData.isUnlock then
    self.ui.tex_orginal.gameObject:SetActive(true)
    self.ui.tex_price:SetIndex(0)
    self.ui.tex_orginal.text = tostring(self.overclockLevelCfg.consumeNum)
  else
    self.ui.tex_orginal.gameObject:SetActive(false)
    self.ui.tex_price:SetIndex(1, tostring(self.overclockLevelCfg.consumeNum))
  end
  self.ui.img_money.sprite = CRH:GetSprite(ConfigData.item[self.overclockLevelCfg.consumeId].icon)
end

function UINEpOverclockListItem:OnBtnSelectClicked()
  if not self.clockOptionData.isUnlock then
    return
  end
  if self.__clockSelectAction ~= nil then
    self.__clockSelectAction(self)
  end
end

function UINEpOverclockListItem:OnDelete()
end

return UINEpOverclockListItem
