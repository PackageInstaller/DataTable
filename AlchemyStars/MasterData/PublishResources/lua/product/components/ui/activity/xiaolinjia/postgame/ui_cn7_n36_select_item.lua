_class("UICN7N36PostSelectItem", UICustomWidget)
UICN7N36PostSelectItem = UICN7N36PostSelectItem

function UICN7N36PostSelectItem:InitWidget()
  self._atlas = self:GetAsset("CN7N36PostGame.spriteatlas", LoadType.SpriteAtlas)
  self._specialText = self:GetUIComponent("UILocalizationText", "specialText")
  self._countText = self:GetUIComponent("UILocalizationText", "countText")
  self._normalText = self:GetUIComponent("UILocalizationText", "normalText")
  self._iconRawImage = self:GetUIComponent("RawImageLoader", "icon")
  self._thumbImage = self:GetUIComponent("Image", "thumb")
  self._specialScoreObj = self:GetGameObject("specialScore")
  self._btnObj = self:GetGameObject("btn")
  self._anim = self:GetGameObject("anim")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnObj), UIEvent.BeginDrag, function(go)
    Log.debug("UICN7N36PostSelectItem BeginDrag")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCN7N36PostGameItemPress, self)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnObj), UIEvent.EndDrag, function(go)
    Log.debug("UICN7N36PostSelectItem EndDrag")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCN7N36PostGameItemRelease, self)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnObj), UIEvent.Click, function(go)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCN7N36PostGameItemClick, self)
  end)
end

function UICN7N36PostSelectItem:OnValue()
  if self._specialScoreDesc then
    self._specialScoreObj:SetActive(true)
    self._specialText:SetText(StringTable.Get(self._specialScoreDesc))
  else
    self._specialScoreObj:SetActive(false)
  end
  self._countText:SetText("X" .. self._count)
  self._normalText:SetText(self._score)
  self._iconRawImage:LoadImage(self._bagIcon)
  self._thumbImage.sprite = self._atlas:GetSprite(self._thumbIcon)
end

function UICN7N36PostSelectItem:GetItemIcon()
  return self._itemIcon
end

function UICN7N36PostSelectItem:GetCanPutItemIcon()
  return self._canPutItemIcon
end

function UICN7N36PostSelectItem:GetUnPutItemIcon()
  return self._unPutItemIcon
end

function UICN7N36PostSelectItem:PlayShowAnimation()
  self._anim:Play("uieff_UICN7N36PostSelectItem_in")
end

function UICN7N36PostSelectItem:OnShow()
  self:InitWidget()
end

function UICN7N36PostSelectItem:SetData(cfg, count, index)
  self._cfg = cfg
  self._count = count
  self._score = cfg.Score
  self._specialScoreDesc = cfg.ExtraScoreText
  self._bagIcon = cfg.BagItemIcon
  self._thumbIcon = cfg.ItemThumbIcon
  self._itemIcon = cfg.GameItemIcon
  self._canPutItemIcon = cfg.CanPutItemIcon
  self._unPutItemIcon = cfg.UnPutItemIcon
  self._id = cfg.ID
  self:PlayInAnim(index)
  self:OnValue()
end

function UICN7N36PostSelectItem:PlayInAnim(index)
  self:Lock("UICN7N36PostSelectItem_PlayInAnim" .. index)
  self:StartTask(function(TT)
    YIELD(TT, 23 * index)
    self._anim:SetActive(true)
    self:UnLock("UICN7N36PostSelectItem_PlayInAnim" .. index)
  end)
end

function UICN7N36PostSelectItem:GetItemCount()
  return self._count
end

function UICN7N36PostSelectItem:GetItemID()
  return self._id
end

function UICN7N36PostSelectItem:GetGuideGameObject()
  return self:GetGameObject()
end

function UICN7N36PostSelectItem:GetGuideGameObjectBtn()
  return self._btnObj
end
