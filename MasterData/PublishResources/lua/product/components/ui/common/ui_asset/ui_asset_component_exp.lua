_class("UIAssetComponentExp", UIAssetComponentBase)
UIAssetComponentExp = UIAssetComponentExp

function UIAssetComponentExp:OnInit()
  self._expObj = self._gameObject.transform:Find("g_exp").gameObject
  self._rect = self._expObj:GetComponent("RectTransform")
  self._expTxt = self._gameObject.transform:Find("g_exp/exp"):GetComponent("UILocalizationText")
  self._upPos = Vector2(-51, 58)
  self._downPos = Vector2(-51, 4.5)
  self._tweener = nil
end

function UIAssetComponentExp:ChangePos(changePos, isUp)
  if not changePos then
    return
  end
  local targetPos
  if isUp then
    targetPos = self._upPos
  else
    targetPos = self._downPos
  end
  if self._tweener then
    self._tweener:Kill()
  end
  self._tweener = self._rect:DOAnchorPos(targetPos, 0.2)
end

function UIAssetComponentExp:SetExpNum(text)
  if string.isnullorempty(text) then
    self._expObj:SetActive(false)
  else
    self._expObj:SetActive(true)
    self._expTxt:SetText(text)
  end
end
