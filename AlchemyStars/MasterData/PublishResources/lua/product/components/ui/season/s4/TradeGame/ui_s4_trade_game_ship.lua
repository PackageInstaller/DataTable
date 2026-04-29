_class("UIS4TradeGameShip", UICustomWidget)
UIS4TradeGameShip = UIS4TradeGameShip

function UIS4TradeGameShip:Constructor()
  self._pos = {
    [1] = Vector2(0, 159),
    [2] = Vector2(0, -131),
    [3] = Vector2(0, -335)
  }
end

function UIS4TradeGameShip:OnShow(uiParams)
  self:InitWidget()
end

function UIS4TradeGameShip:InitWidget()
  self.nomal = self:GetUIComponent("Image", "Nomal")
  self.onChose = self:GetGameObject("OnChose")
  self.lock = self:GetGameObject("Lock")
  self._rect = self:GetUIComponent("RectTransform", "Rect")
  self._anim = self:GetUIComponent("Animation", "Rect")
  self.eff = self:GetGameObject("eff")
  self.eff2 = self:GetGameObject("eff2")
end

function UIS4TradeGameShip:SetData(id, harborId, unlock, btnCallback)
  self.harborId = harborId
  self.unlock = unlock
  self.btnCallback = btnCallback
  self._rect.anchorMax = Vector2(0.5, 0.5)
  self._rect.anchorMin = Vector2(0.5, 0.5)
  self._rect.transform.anchoredPosition = self._pos[id]
  if self.lock.activeSelf and self.unlock then
    self.eff:SetActive(true)
    self.eff2:SetActive(true)
    self._anim:Play("uianim_UIS4TradeGameShip_unlock")
  end
  self.lock:SetActive(not self.unlock)
  self.lockTips = "str_season_s4_trade_harbor_lock_tip_" .. id
end

function UIS4TradeGameShip:OnChose(chose)
  self.onChose:SetActive(chose)
end

function UIS4TradeGameShip:NomalOnClick(go)
  if not self.unlock then
    ToastManager.ShowToast(StringTable.Get(self.lockTips))
    return
  end
  if self.btnCallback then
    self.btnCallback(self.harborId)
  end
end

function UIS4TradeGameShip:OnChoseOnClick(go)
end

function UIS4TradeGameShip:LockOnClick(go)
end
