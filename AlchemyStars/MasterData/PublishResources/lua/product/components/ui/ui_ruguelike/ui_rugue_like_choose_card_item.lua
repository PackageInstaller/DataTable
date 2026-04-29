_class("UIRugueLikeChooseCardItem", UICustomWidget)
UIRugueLikeChooseCardItem = UIRugueLikeChooseCardItem

function UIRugueLikeChooseCardItem:OnShow(uiParam)
  self._atlas = self:GetAsset("UIMazeChoose.spriteatlas", LoadType.SpriteAtlas)
end

function UIRugueLikeChooseCardItem:GetComponents()
  self._card = self:GetUIComponent("RectTransform", "card")
  self._itemPool = self:GetUIComponent("UISelectObjectPath", "itemPool")
  self._itemPoolCanvasGroup = self:GetUIComponent("CanvasGroup", "itemPool")
end

function UIRugueLikeChooseCardItem:SetData(index, itemID, pos, _cardClick)
  self:GetComponents()
  self._index = index
  self._pos = pos
  self._callback = _cardClick
  self._canClick = false
  self._item = self._itemPool:SpawnObject("UIRugueLikeBackpackItem")
  self._item:SetData(index, itemID, function()
    self:CardClick()
  end)
  self._card:DOScale(Vector3(1, 1, 1), 0.2)
  self._card:DOMove(pos, 0.2):OnComplete(function()
    self._canClick = true
  end)
  self._colorBg = self:GetUIComponent("Image", "colorBg")
  self._colorBg.gameObject:SetActive(false)
  local cfg_item = Cfg.cfg_item[itemID]
  if cfg_item then
    local color = cfg_item.Color
    self._colorBg.sprite = self._atlas:GetSprite("map_xuanzhong_di" .. color)
  end
end

function UIRugueLikeChooseCardItem:CardClick()
  if self._canClick == true then
    self._callback(self._index)
  end
end

function UIRugueLikeChooseCardItem:Flush(itemid)
  self:Lock("UIRugueLikeChooseCardItem:Flush")
  self._itemPoolCanvasGroup:DOFade(0, 0.5)
  self._card:DOScale(Vector3(0.1, 0.1, 0.1), 0.5):OnComplete(function()
    self._card:DOScale(Vector3(1, 1, 1), 0.1)
    self._itemPoolCanvasGroup:DOFade(1, 0.1)
    self:UnLock("UIRugueLikeChooseCardItem:Flush")
    self._item:Flush(itemid)
    local cfg_item = Cfg.cfg_item[itemid]
    if cfg_item then
      local color = cfg_item.Color
      self._colorBg.sprite = self._atlas:GetSprite("map_xuanzhong_di" .. color)
    end
  end)
end

function UIRugueLikeChooseCardItem:CancelOrSelect(select)
  if select then
    self._card:DOScale(Vector3(1.1, 1.1, 1.1), 0.2)
  else
    self._card:DOScale(Vector3(1, 1, 1), 0.2)
  end
  self._colorBg.gameObject:SetActive(select)
end

function UIRugueLikeChooseCardItem:MoveTwwen(move, pos)
  if move then
    self._card:DOMove(pos, 0.2)
  else
    self._card.gameObject:SetActive(false)
  end
end
