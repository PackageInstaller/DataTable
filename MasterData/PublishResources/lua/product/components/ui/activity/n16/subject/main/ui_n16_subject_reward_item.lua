_class("UIN16SubjectRewardItem", UICustomWidget)
UIN16SubjectRewardItem = UIN16SubjectRewardItem

function UIN16SubjectRewardItem:OnShow()
  self._iconImgLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._iconImgRaw = self:GetUIComponent("RawImage", "Icon")
  self._iconImg = self:GetUIComponent("RawImage", "Icon")
  self._iconGo = self:GetGameObject("Icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._countBg = self:GetGameObject("CountBg")
  self._hasGetCountBg = self:GetGameObject("HasGetCount")
  self._hasGetCountImg = self:GetUIComponent("Image", "HasGetCount")
  self._go = self:GetGameObject()
end

function UIN16SubjectRewardItem:OnHide()
  self._EMIMat = nil
end

function UIN16SubjectRewardItem:Refresh(reward, hasComplete)
  self._rewardId = reward[1]
  self._countLabel.text = reward[2]
  local ItemTempleate = Cfg.cfg_item[self._rewardId]
  self._iconImgLoader:LoadImage(ItemTempleate.Icon)
  if hasComplete then
    self._countBg:SetActive(false)
    self._hasGetCountBg:SetActive(true)
    self:SetRawImageGray(true)
  else
    self._countBg:SetActive(true)
    self._hasGetCountBg:SetActive(false)
    self:SetRawImageGray(false)
  end
end

function UIN16SubjectRewardItem:SetRawImageGray(gray)
  if gray then
    self._iconImgRaw.color = Color.New(1.0, 1.0, 1.0, 0.5882352941176471)
    self._countLabel.color = Color.New(1.0, 1.0, 1.0, 0.5882352941176471)
    self._hasGetCountImg.color = Color.New(1.0, 1.0, 1.0, 0.5882352941176471)
  else
    self._iconImgRaw.color = Color.New(1.0, 1.0, 1.0, 1.0)
    self._countLabel.color = Color.New(1.0, 1.0, 1.0, 1.0)
    self._hasGetCountImg.color = Color.New(1.0, 1.0, 1.0, 1.0)
  end
end

function UIN16SubjectRewardItem:BtnOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN16SubjectRewardItemClicked, self._rewardId, self._go.transform.position)
end
