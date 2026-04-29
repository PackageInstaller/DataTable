_class("UIAircraftSmeltItem", UICustomWidget)
UIAircraftSmeltItem = UIAircraftSmeltItem

function UIAircraftSmeltItem:OnShow(uiParams)
  self._selectNameColor = {
    [1] = Color(0.00392156862745098, 0.00392156862745098, 0.00392156862745098, 1),
    [2] = Color(0.7843137254901961, 0.7843137254901961, 0.7843137254901961, 1)
  }
  self._selectBgSize = {
    [1] = Vector2(413, 124),
    [2] = Vector2(393, 84)
  }
  self._atlas = self:GetAsset("UIAircraftSmeltRoom.spriteatlas", LoadType.SpriteAtlas)
  self:InitWidget()
end

function UIAircraftSmeltItem:InitWidget()
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.unlock = self:GetUIComponent("UILocalizationText", "unlock")
  self.lockGO = self:GetGameObject("lockGO")
  self.select = self:GetUIComponent("Image", "select")
  self.selectRect = self:GetUIComponent("RectTransform", "select")
  self.color = self:GetUIComponent("Image", "color")
  self.colorGo = self:GetGameObject("color")
end

function UIAircraftSmeltItem:SetData(idx, cfg, onClick, lockInfo, sp1, sp2)
  self._selectSprite = sp1
  self._unSelectSprite = sp2
  self._index = idx
  local itemID = cfg.Output[1]
  local itemCfg = Cfg.cfg_item[itemID]
  if lockInfo then
    self._lockType = lockInfo[1]
    self._lockParam = lockInfo[2]
  else
    self._lockType = nil
  end
  self.name:SetText(StringTable.Get(itemCfg.Name))
  self.icon:LoadImage(itemCfg.Icon)
  self.quality = itemCfg.Color
  self._onClick = onClick
  if self._lockType == SmeltItemType.SIT_Mission then
    local chapter = Cfg.cfg_mission[self._lockParam].Chapter
    self._lockTip = StringTable.Get("str_aircraft_trunk_unlock", chapter[1], chapter[2])
    self.unlock:SetText(self._lockTip)
    self.lockGO:SetActive(true)
  elseif self._lockType == SmeltItemType.SIT_Lv then
    self._lockTip = StringTable.Get("str_aircraft_smelt_room_unlock", self._lockParam)
    self.unlock:SetText(self._lockTip)
    self.lockGO:SetActive(true)
  else
    self.lockGO:SetActive(false)
  end
  self:Cancel()
end

function UIAircraftSmeltItem:Select()
  if self._lockType then
    return
  end
  self.select.sprite = self._selectSprite
  self.selectRect.sizeDelta = self._selectBgSize[1]
  self.name.color = self._selectNameColor[1]
end

function UIAircraftSmeltItem:Cancel()
  self.select.sprite = self._unSelectSprite
  self.selectRect.sizeDelta = self._selectBgSize[2]
  self.name.color = self._selectNameColor[2]
end

function UIAircraftSmeltItem:itemOnClick(go)
  if self._lockType then
    ToastManager.ShowToast(self._lockTip)
    return
  end
  if self._onClick then
    self._onClick(self._index)
  end
end

function UIAircraftSmeltItem:ShowColor()
  if self.colorGo then
    self.colorGo:SetActive(true)
    local sp = self._atlas:GetSprite("wind_ronglian_pinji" .. self.quality)
    self.color.sprite = sp
  end
end
