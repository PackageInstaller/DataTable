_class("UIActiveTaskFlipAwardItem", UICustomWidget)
UIActiveTaskFlipAwardItem = UIActiveTaskFlipAwardItem

function UIActiveTaskFlipAwardItem:OnShow()
  self._atlas = self:GetAsset("ActiveTask.spriteatlas", LoadType.SpriteAtlas)
  self:AddListener()
  self:_GetComponent()
end

function UIActiveTaskFlipAwardItem:OnHide()
  self:RemoveListener()
end

function UIActiveTaskFlipAwardItem:AddListener()
  self._onFlipMaskCallback = GameHelper:GetInstance():CreateCallback(self.OnFlipMask, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnFlipMask, self._onFlipMaskCallback)
end

function UIActiveTaskFlipAwardItem:RemoveListener()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnFlipMask, self._onFlipMaskCallback)
end

function UIActiveTaskFlipAwardItem:_GetComponent()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._isGetImg = self:GetUIComponent("Image", "isGet")
  self._isGetObj = self:GetGameObject("isGet")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._imgRect = self:GetUIComponent("RectTransform", "img")
  self._anim = self:GetUIComponent("Animation", "rect")
end

function UIActiveTaskFlipAwardItem:SetData(data, gridSize)
  self._id = data.id
  self._index = data.index
  self._isGet = data.isGet
  self._maskList = data.maskList
  self._gridSize = gridSize
  self:InitComponent()
end

function UIActiveTaskFlipAwardItem:InitComponent()
  local cfg = Cfg.cfg_component_turn_card_item[self._id]
  self._icon:LoadImage(cfg.ItemEntireIcon)
  self:SetGetState(self._isGet)
  local height = self._gridSize.y
  local width = self._gridSize.x
  if cfg.RewardLevel == 1 then
    height = self._gridSize.y * 2
    width = self._gridSize.x * 2
    self._isGetImg.sprite = self._atlas:GetSprite("N32_hywf_mask01")
    self._imgRect.localScale = Vector3(1, 1, 1)
  elseif cfg.RewardLevel == 2 then
    width = self._gridSize.x * 2
    self._isGetImg.sprite = self._atlas:GetSprite("N32_hywf_mask03")
    self._imgRect.localScale = Vector3(0.7, 0.7, 0.7)
  elseif cfg.RewardLevel == 3 then
    self._isGetImg.sprite = self._atlas:GetSprite("N32_hywf_mask04")
    self._imgRect.localScale = Vector3(0.7, 0.7, 0.7)
  end
  self._rect.anchorMax = Vector2(0, 1)
  self._rect.anchorMin = Vector2(0, 1)
  self._rect.sizeDelta = Vector2(width, height)
  local row = math.floor(self._index / 10)
  local arrange = -(self._index % 10)
  self._rect.anchoredPosition = Vector2(row * self._gridSize.x, arrange * self._gridSize.y)
end

function UIActiveTaskFlipAwardItem:OnFlipMask(index)
  if self._maskList[index] ~= nil then
    self._maskList[index] = true
  else
    return
  end
  local isAllFliped = true
  for _, v in pairs(self._maskList) do
    isAllFliped = isAllFliped and v
  end
  self._isGet = isAllFliped
  self:SetGetState(isAllFliped, true)
end

function UIActiveTaskFlipAwardItem:SetGetState(isGet, anim)
  self._isGetObj:SetActive(isGet)
  if anim and isGet then
    self:StartTask(function(TT)
      self:Lock("UIActiveTaskFlipAwardItem_SetGetState")
      self._anim:Play("uieff_UIActiveTaskFilpAwardItem_getting")
      YIELD(TT, 420)
      self:UnLock("UIActiveTaskFlipAwardItem_SetGetState")
    end, self)
  end
end
