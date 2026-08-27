local UINEpChipDetailButtonGroup = class("UINEpChipDetailButtonGroup", UIBaseNode)
local base = UIBaseNode

function UINEpChipDetailButtonGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Lock, self, self._OnLockClick)
  UIUtil.AddButtonListener(self.ui.btn_Select, self, self._OnSelectClick)
  UIUtil.AddButtonListener(self.ui.btn_SelByCost, self, self._OnSelByCostClick)
  self:SetLockState(false)
  self:SetLockGoActive(false)
end

function UINEpChipDetailButtonGroup:InitChipDetailButtonGroup(panel)
  self.panel = panel
  self:SetDefaultState()
end

function UINEpChipDetailButtonGroup:SetDefaultState()
  self.ui.btn_Select.gameObject:SetActive(false)
  self.ui.btn_SelByCost.gameObject:SetActive(false)
  self.ui.obj_tips:SetActive(false)
end

function UINEpChipDetailButtonGroup:SetLockGoActive(active)
  self.ui.btn_Lock.gameObject:SetActive(active)
end

function UINEpChipDetailButtonGroup:SetLockState(lockState)
  self.lock = lockState
  self:_RefreshLockUi()
end

function UINEpChipDetailButtonGroup:_RefreshLockUi()
  if self.lock then
    self.ui.img_Lock:SetIndex(1)
  else
    self.ui.img_Lock:SetIndex(0)
  end
end

function UINEpChipDetailButtonGroup:SetLockCallback(callback)
  self._onLockCallback = callback
end

function UINEpChipDetailButtonGroup:_OnLockClick()
  if self._onLockCallback ~= nil then
    self._onLockCallback()
  end
end

function UINEpChipDetailButtonGroup:InitBtnSelect(selectCallback)
  self:SetBtnSelectActive(true)
  self:RefreshBtnSelectUI()
  self._onSelectCallback = selectCallback
end

function UINEpChipDetailButtonGroup:RefreshBtnSelectUI(index)
  if index == nil then
    local _isOwnData = self.panel._isOwnData or false
    index = _isOwnData and 1 or 0
  end
  self.ui.tex_Select:SetIndex(index)
end

function UINEpChipDetailButtonGroup:SetBtnSelectActive(active)
  if active and not self.ui.btn_Select.gameObject.activeSelf then
    self:SetDefaultState()
  end
  self.ui.btn_Select.gameObject:SetActive(active)
end

function UINEpChipDetailButtonGroup:_OnSelectClick()
  if self._onSelectCallback ~= nil then
    self._onSelectCallback()
  end
end

function UINEpChipDetailButtonGroup:InitBtnSelByCost(isBuy, cost, selectCallback, sprite)
  self._onSelByCostCallback = selectCallback
  if sprite ~= nil then
    self.ui.img_SelByCostIcon.sprite = sprite
  end
  self:SetBtnSelByCostActive(true)
  self:_RefreshBtnSelByCostUI(isBuy, cost)
end

function UINEpChipDetailButtonGroup:_RefreshBtnSelByCostUI(isBuy, cost)
  if cost == nil then
    cost = self.panel._chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId(), not isBuy)
  end
  local index = isBuy and 1 or 0
  local str = isBuy and "-" or "+"
  self.ui.btn_SelByCost.interactable = true
  if isBuy then
    local currMoney = ExplorationManager:GetDynPlayer():GetMoneyCount()
    local couldLoanMoney = ExplorationManager.epCtrl.campFetterCtrl:GetCouldLeonMoney()
    if cost > currMoney + couldLoanMoney then
      self.ui.btn_SelByCost.interactable = false
      self.ui.tex_SelByCostName:SetIndex(2)
    else
      self.ui.tex_SelByCostName:SetIndex(1)
    end
    self.ui.img_SelByCostBg:SetIndex(1)
  else
    self.ui.tex_SelByCostName:SetIndex(0)
    self.ui.img_SelByCostBg:SetIndex(0)
  end
  self.ui.tex_Cost.text = str .. tostring(cost)
end

function UINEpChipDetailButtonGroup:SetBtnSelByCostActive(active)
  if active and not self.ui.btn_SelByCost.gameObject.activeSelf then
    self:SetDefaultState()
  end
  self.ui.btn_SelByCost.gameObject:SetActive(active)
end

function UINEpChipDetailButtonGroup:_OnSelByCostClick()
  if self._onSelByCostCallback ~= nil then
    self._onSelByCostCallback()
  end
end

function UINEpChipDetailButtonGroup:ShowIsLevelMaxTips()
  if not self.ui.obj_tips.activeSelf then
    self:SetDefaultState()
  end
  self.ui.obj_tips:SetActive(true)
end

function UINEpChipDetailButtonGroup:OnDelete()
  base.OnDelete(self)
end

return UINEpChipDetailButtonGroup
