_class("MedalManagerItem", Object)
MedalManagerItem = MedalManagerItem

function MedalManagerItem:SetGameObject(go)
  self._go = go
  self:_GetComponents()
  self._go:SetActive(false)
  self._atlas = ResourceManager:GetInstance():SyncLoadAsset("UIMedal.spriteatlas", LoadType.SpriteAtlas)
end

function MedalManagerItem:OnHide()
  self._go:SetActive(false)
end

function MedalManagerItem:SetData(medalID)
  self._go:SetActive(true)
  local cfg = Cfg.cfg_item[medalID]
  if self._atlas then
    self._medalImg.sprite = self._atlas.Obj:GetSprite(cfg.Icon)
  end
  self._titleTex:SetText(StringTable.Get(cfg.Name))
  self._desTex:SetText(StringTable.Get(Cfg.cfg_item_medal[medalID].GetPathDesc))
end

function MedalManagerItem:DoTween()
  self._tweenImg:DOFillAmount(1, 0.4)
  self._quan:DOLocalRotate(Vector3(0, 0, 360), 0.4, DG.Tweening.RotateMode.FastBeyond360)
end

function MedalManagerItem:ReplyTween()
  self._quan.localRotation = Quaternion:SetEuler(0, 0, -150)
  self._tweenImg.fillAmount = 0
end

function MedalManagerItem:_GetComponents()
  self._rect = self._go.transform:Find("rect").gameObject:GetComponent("RectTransform")
  self._medalImg = self._go.transform:Find("rect/leftObj/bg/medalImg").gameObject:GetComponent("Image")
  self._headTex = self._go.transform:Find("rect/rightObj/line/medalHeadTex").gameObject:GetComponent("UILocalizationText")
  self._titleTex = self._go.transform:Find("rect/rightObj/medelTitleTex").gameObject:GetComponent("UILocalizationText")
  self._desTex = self._go.transform:Find("rect/rightObj/medalDesTex").gameObject:GetComponent("UILocalizationText")
  self._tweenImg = self._go.transform:Find("rect/rightObj/line/medalHeadTex/dui").gameObject:GetComponent("Image")
  self._quan = self._go.transform:Find("rect/rightObj/line/medalHeadTex/quan").gameObject:GetComponent("Transform")
  self._headTex:SetText(StringTable.Get("str_medal_get_title"))
end

function MedalManagerItem:Dispose()
  self._rect = nil
  self._medalImg = nil
  self._titleTex = nil
  self._desTex = nil
  self._go = nil
  self._atlas = nil
end

function MedalManagerItem:GetRectTransform()
  return self._rect
end

function MedalManagerItem:_OnValue()
end
