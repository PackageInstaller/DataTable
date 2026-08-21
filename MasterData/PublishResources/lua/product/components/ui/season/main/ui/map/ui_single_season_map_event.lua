_class("UISingleSeasonMapEvent", UICustomWidget)
UISingleSeasonMapEvent = UISingleSeasonMapEvent

function UISingleSeasonMapEvent:OnShow(uiParams)
  self:InitWidget()
  self._uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  self._seasonManager = self._uiSeasonModule:SeasonManager()
  self._seasonPlayerManager = self._seasonManager:SeasonPlayerManager()
  self._seasonPlayer = self._seasonPlayerManager:GetPlayer()
  self._seasonMapManager = self._seasonManager:SeasonMapManager()
  self._bindEventData = nil
end

function UISingleSeasonMapEvent:InitWidget()
  self._seasonMapCfg = Cfg.cfg_season_map[GameGlobal.GetModule(SeasonModule):GetCurSeasonID()]
  self._rootRectTf = self:GetUIComponent("RectTransform", "Icon")
  self._iconImage = self:GetUIComponent("Image", "Icon")
  self._leftUpAnchorPos = Vector3(self._seasonMapCfg.LeftUpAnchorPos[1], self._seasonMapCfg.LeftUpAnchorPos[2], self._seasonMapCfg.LeftUpAnchorPos[3])
  self._rightDownAnchorpos = Vector3(self._seasonMapCfg.RightDownAnchorPos[1], self._seasonMapCfg.RightDownAnchorPos[2], self._seasonMapCfg.RightDownAnchorPos[3])
  self._atlas = self:GetAsset("UISeasonMain.spriteatlas", LoadType.SpriteAtlas)
end

function UISingleSeasonMapEvent:SetData(point, mapRect)
  if point then
    local pos = point:Position()
    self._bindEventData = point
    local icon = self._bindEventData:EventMapIcon()
    if icon then
      local sprite = self._atlas:GetSprite(icon)
      if sprite then
        self._iconImage.sprite = sprite
        self._iconImage:SetNativeSize()
      end
    else
      self._iconImage.sprite = nil
    end
    self.mapRect = mapRect
    self:RefreshMapIcon(pos)
  end
end

function UISingleSeasonMapEvent:OnHide()
end

function UISingleSeasonMapEvent:Update(dt)
  if self._seasonPlayer == nil or self._bindEventData == nil then
    return
  end
  if not self._bindEventData:IsShow() then
    self._rootRectTf.gameObject:SetActive(false)
    return
  else
    self._rootRectTf.gameObject:SetActive(true)
  end
  self:RefreshMapIcon(self._bindEventData:Position())
end

function UISingleSeasonMapEvent:RefreshMapIcon(pos)
  local tf = self._seasonPlayer:Transform()
  local singlePos = pos
  local leftUpPos = self._leftUpAnchorPos
  local rightDownPos = self._rightDownAnchorpos
  local rolePos = tf.position
  local mapPosDelta = rightDownPos - leftUpPos
  local curPosDelta = rightDownPos - singlePos
  local percentX = curPosDelta.x / mapPosDelta.x
  local percentY = curPosDelta.z / mapPosDelta.z
  local leftUpUIPos = Vector2(self.mapRect.anchoredPosition.x - self.mapRect.sizeDelta.x, self.mapRect.anchoredPosition.y - self.mapRect.sizeDelta.y)
  local rightDownUIPos = self.mapRect.anchoredPosition
  local anchoredPos = rightDownUIPos - leftUpUIPos
  anchoredPos = rightDownUIPos - Vector2(anchoredPos.x * percentX, -anchoredPos.y * percentY)
  self._rootRectTf.anchoredPosition = anchoredPos
end
