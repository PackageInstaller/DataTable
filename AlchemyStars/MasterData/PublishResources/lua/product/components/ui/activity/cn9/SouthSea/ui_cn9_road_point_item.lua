_class("UICN9RoadPointItem", UICustomWidget)
UICN9RoadPointItem = UICN9RoadPointItem

function UICN9RoadPointItem:Constructor()
  self._pos = {
    [1] = Vector2(2270, 175),
    [2] = Vector2(2600, -100),
    [3] = Vector2(3000, 175),
    [4] = Vector2(3400, -100),
    [5] = Vector2(3750, 175),
    [6] = Vector2(4125, -100)
  }
end

function UICN9RoadPointItem:OnShow(uiParams)
  self:_InitWidget()
end

function UICN9RoadPointItem:_InitWidget()
  self._rect = self:GetUIComponent("RectTransform", "gameObj")
  self._RoadPointNameText = self:GetUIComponent("UILocalizationText", "RoadPointNameText")
  self._bg = self:GetUIComponent("Image", "bg")
  self._pass = self:GetGameObject("Pass")
  self._atlas = self:GetAsset("UICN9.spriteatlas", LoadType.SpriteAtlas)
end

function UICN9RoadPointItem:SetData(id, pass, info, clickCallback)
  self._rect.anchorMax = Vector2(0.5, 0.5)
  self._rect.anchorMin = Vector2(0.5, 0.5)
  self._pass:SetActive(pass)
  self._clickCallback = clickCallback
  self._id = id
  local cfg = Cfg.cfg_component_asheep_mission[self._id]
  local name = cfg.MissionName
  local bg = cfg.MissionBG
  self._RoadPointNameText:SetText(StringTable.Get(name))
  self._bg.sprite = self._atlas:GetSprite(bg)
  self:SetPos(id)
end

function UICN9RoadPointItem:SetPos(id)
  self._rect.transform.anchoredPosition = self._pos[id]
end

function UICN9RoadPointItem:ClickBtnOnClick()
  if self._clickCallback then
    self._clickCallback(self._id)
  end
end
