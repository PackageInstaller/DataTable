_class("UIPetObtainStar", UICustomWidget)
UIPetObtainStar = UIPetObtainStar

function UIPetObtainStar:OnShow()
  self._go = self:GetGameObject()
  self._eff = self:GetGameObject("eff").transform
  self._tweener = nil
  local eff = UIHelper.GetGameObject("uieff_uipetobtain_xingxing01.prefab")
  eff.transform:SetParent(self._eff, false)
  self:HideStar()
end

function UIPetObtainStar:OnHide()
  self._go = nil
  self._eff = nil
  if self._tweener then
    self._tweener:Kill()
  end
end

function UIPetObtainStar:ShowStar(idx, count)
  if not self._go then
    return
  end
  local go
  self._tweener = self._go.transform:DOScale(1, 1):SetDelay(2.35 + (idx - 1) * 0.1):OnStart(function()
    if not self._go then
      return
    end
    self._go:SetActive(true)
    self._eff.gameObject:SetActive(true)
    if idx == count then
      if not self._eff then
        return
      end
      go = UIHelper.GetGameObject("uieff_uipetobtain_xingxing02.prefab")
      go.transform:SetParent(self._eff, false)
    end
  end):OnComplete(function()
    if idx == count then
      if not go then
        return
      end
      go:SetActive(false)
    end
  end)
end

function UIPetObtainStar:HideStar()
  if self._go then
    self._go:SetActive(false)
  end
end

function UIPetObtainStar:CompleteTween()
  if self._tweener then
    self._tweener:Complete(true)
  end
  self._go:SetActive(true)
  self._eff.gameObject:SetActive(false)
end
