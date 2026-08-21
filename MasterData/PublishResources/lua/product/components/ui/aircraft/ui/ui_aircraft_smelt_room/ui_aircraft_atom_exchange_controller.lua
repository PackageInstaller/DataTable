_class("UISmeltAtomExchangeController", UIController)
UISmeltAtomExchangeController = UISmeltAtomExchangeController

function UISmeltAtomExchangeController:OnShow(uiParams)
  self:InitWidget()
  self._airModule = self:GetModule(AircraftModule)
  self._smeltRoom = self._airModule:GetSmeltRoom()
  self._roleModule = self:GetModule(RoleModule)
  self._rate = Cfg.cfg_aircraft_values[17].IntValue
  self:OnCountChanged(1, true)
  local atomCfg = Cfg.cfg_top_tips[RoleAssetID.RoleAssetAtom]
  self._icon.sprite = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas):GetSprite(atomCfg.Icon)
  self:OnAtomChanged()
  self:OnFireflyChanged()
  self:AttachEvent(GameEventType.AircraftOnAtomChanged, self.OnAtomChanged)
  self:AttachEvent(GameEventType.AircraftOnFireFlyChanged, self.OnFireflyChanged)
end

function UISmeltAtomExchangeController:OnHide()
  self:DetachEvent(GameEventType.AircraftOnAtomChanged, self.OnAtomChanged)
  self:DetachEvent(GameEventType.AircraftOnFireFlyChanged, self.OnFireflyChanged)
  self.addBtn:Dispose()
  self.removeBtn:Dispose()
end

function UISmeltAtomExchangeController:InitWidget()
  self.tip = self:GetUIComponent("UILocalizationText", "tip")
  self.text2 = self:GetUIComponent("UILocalizationText", "text2")
  self.count = self:GetUIComponent("UILocalizationText", "count")
  self.add = self:GetUIComponent("UIEventTriggerListener", "add")
  self.remove = self:GetUIComponent("UIEventTriggerListener", "remove")
  self.currencymenu = self:GetUIComponent("UISelectObjectPath", "currencymenu")
  self.addBtn = UITouchButton:New(self.add, function()
    self:OnCountChanged(self._count + 1)
  end)
  self.removeBtn = UITouchButton:New(self.remove, function()
    self:OnCountChanged(self._count - 1)
  end)
  self._topTips = self.currencymenu:SpawnObject("UICurrencyMenu")
  self._topTips:SetData({
    RoleAssetID.RoleAssetAtom,
    RoleAssetID.RoleAssetFirefly
  }, true)
  self._icon = self:GetUIComponent("Image", "icon")
end

function UISmeltAtomExchangeController:OnCountChanged(count, notCheck)
  local max = self:_calMax()
  if not notCheck and (count > max or count < 1) then
    return
  end
  self._count = count
  self.count:SetText(self._count)
  local atom = self._count * self._rate
  self.text2:SetText(atom)
  self.tip:SetText(StringTable.Get("str_aircraft_smelt_atom_tip", self._count, atom))
end

function UISmeltAtomExchangeController:_calMax()
  local atom = self._roleModule:GetAtom()
  local atomMax = self._smeltRoom:GetStorageMax()
  if atom >= atomMax then
    return 0
  end
  local available = self._airModule:GetFirefly()
  if available < 1 then
    return 0
  end
  if available * self._rate > atomMax - atom then
    return math.ceil((atomMax - atom) / self._rate)
  else
    return math.floor(available)
  end
end

function UISmeltAtomExchangeController:OnAtomChanged()
  local atom = self._topTips:GetItemByTypeId(RoleAssetID.RoleAssetAtom)
  atom:SetText(math.floor(self._roleModule:GetAtom()) .. "/" .. math.floor(self._smeltRoom:GetStorageMax()))
end

function UISmeltAtomExchangeController:OnFireflyChanged()
  local firefly = self._topTips:GetItemByTypeId(RoleAssetID.RoleAssetFirefly)
  firefly:SetText(self._airModule:GetFirefly() .. "/" .. math.floor(self._airModule:GetMaxFirefly()))
end

function UISmeltAtomExchangeController:minOnClick(go)
  self:OnCountChanged(1, true)
end

function UISmeltAtomExchangeController:maxOnClick(go)
  local max = self:_calMax()
  self:OnCountChanged(max)
end

function UISmeltAtomExchangeController:cancelOnClick(go)
  self:CloseDialog()
end

function UISmeltAtomExchangeController:okOnClick(go)
  if self._airModule:GetFirefly() < self._count then
    self:OnCountChanged(1)
    ToastManager.ShowToast(StringTable.Get("str_aircraft_firefly_not_enough"))
    return
  end
  if self._roleModule:GetAtom() >= self._smeltRoom:GetStorageMax() then
    self:OnCountChanged(1)
    ToastManager.ShowToast(StringTable.Get("str_aircraft_atom_max"))
    return
  end
  local max = self:_calMax()
  if max < self._count then
    ToastManager.ShowToast(StringTable.Get("str_aircraft_atom_changed"))
    self:OnCountChanged(max)
    return
  end
  self:StartTask(self.exchange, self)
end

function UISmeltAtomExchangeController:exchange(TT)
  self:Lock(self:GetName())
  local updateRes = self._airModule:AircraftUpdate(TT, false)
  if not updateRes:GetSucc() then
    ToastManager.ShowToast(self._airModule:GetErrorMsg(updateRes:GetResult()))
    return
  end
  local res = self._airModule:HandleFireflyToAtom(TT, self._count)
  self:UnLock(self:GetName())
  if res:GetSucc() then
    ToastManager.ShowToast(StringTable.Get("str_aircraft_exchange_success"))
    self:CloseDialog()
  else
    ToastManager.ShowToast(self._airModule:GetErrorMsg(res:GetResult()))
  end
end
