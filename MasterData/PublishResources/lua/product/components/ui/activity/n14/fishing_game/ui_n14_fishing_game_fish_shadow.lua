_class("UIN14FishingGameFishShadow", UICustomWidget)
UIN14FishingGameFishShadow = UIN14FishingGameFishShadow

function UIN14FishingGameFishShadow:OnShow(uiParams)
  self:InitWidget()
end

function UIN14FishingGameFishShadow:InitWidget()
  self._Image = self:GetUIComponent("Image", "Image")
  self._shadowTrans = self:GetGameObject("Image").transform
  self._atlas = self:GetAsset("UIN14FishingGame.spriteatlas", LoadType.SpriteAtlas)
end

function UIN14FishingGameFishShadow:SetShadow(fishShadow, scale)
  self._Image.sprite = self._atlas:GetSprite(fishShadow)
  self._Image.gameObject.transform.localScale = Vector3.one * scale
  self._shadowTrans.gameObject:SetActive(true)
end

function UIN14FishingGameFishShadow:UpdatePosAndAngle(pos, angle, offset)
  local tmp = pos
  tmp.x = tmp.x + offset
  tmp.y = tmp.y + offset
  self._shadowTrans.localPosition = tmp
  self._shadowTrans.localEulerAngles = angle
end

function UIN14FishingGameFishShadow:SetVisible(status)
  self._shadowTrans.gameObject:SetActive(status)
end
