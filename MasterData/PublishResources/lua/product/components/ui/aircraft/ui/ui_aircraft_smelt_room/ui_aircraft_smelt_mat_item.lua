_class("UIAircraftItemSmeltMatItem", UICustomWidget)
UIAircraftItemSmeltMatItem = UIAircraftItemSmeltMatItem

function UIAircraftItemSmeltMatItem:OnShow(uiParams)
  self._roleModule = self:GetModule(RoleModule)
  self._waitTime = Cfg.cfg_global.shakeWaitTime.IntValue or 2000
  self._shakeX = Cfg.cfg_global.shakeOffsetX.IntValue or 10
  self._shakeY = Cfg.cfg_global.shakeOffsetY.IntValue or 10
  self:InitWidget()
end

function UIAircraftItemSmeltMatItem:InitWidget()
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.count = self:GetUIComponent("UILocalizationText", "itemCount")
  self._root = self:GetUIComponent("RectTransform", "root")
  self._go = self:GetGameObject("root")
  self._selector = self:GetGameObject("selector")
  self._selector:SetActive(false)
  self.quality = self:GetUIComponent("Image", "quality")
end

function UIAircraftItemSmeltMatItem:SetData(id, count, onClick, idx)
  self._matid = id
  self._count = count
  self._currentCount = self._roleModule:GetAssetCount(self._matid)
  self._onClick = onClick
  self._idx = idx
  local cfg_item = Cfg.cfg_item[id]
  self.icon:LoadImage(cfg_item.Icon)
  local quality = cfg_item.Color
  local spriteName = "spirit_shengji_se" .. quality
  local atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self.quality.sprite = atlas:GetSprite(spriteName)
  self:SetCount()
end

function UIAircraftItemSmeltMatItem:ResetCount(count)
  self._count = count
  self:SetCount()
end

function UIAircraftItemSmeltMatItem:SetCount()
  local str, color
  if self._count > self._currentCount then
    color = "<color=#ff0000>"
  else
    color = "<color=#ffffff>"
  end
  str = color .. self._count .. "</color>/" .. self:GetCurrentMaterialCountStr()
  self.count:SetText(str)
end

function UIAircraftItemSmeltMatItem:GetCurrentMaterialCountStr()
  return HelperProxy:GetInstance():FormatItemCount(self._currentCount)
end

function UIAircraftItemSmeltMatItem:ShakeAndHighlight()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUIMaterialNotEnough)
  if self.shakeTweener then
    self.shakeTweener:Kill()
    self._root.anchoredPosition = Vector2(0, 0)
  end
  if self.highLightTimer then
    GameGlobal.Timer():CancelEvent(self.highLightTimer)
  end
  local str = "<color=#ff0000>" .. self:GetCurrentMaterialCountStr() .. "/" .. self._count .. "</color>"
  self.count:SetText(str)
  self.shakeTweener = self._root:DOShakePosition(1, Vector3(self._shakeX, self._shakeY, 0)):OnComplete(function()
    self.highLightTimer = GameGlobal.Timer():AddEvent(self._waitTime, function()
      self:SetCount()
    end)
  end)
end

function UIAircraftItemSmeltMatItem:TryStopShake()
  if self._currentCount >= self._count then
    if self.shakeTweener then
      self.shakeTweener:Kill()
      self._root.anchoredPosition = Vector2(0, 0)
      self.shakeTweener = nil
    end
    if self.highLightTimer then
      GameGlobal.Timer():CancelEvent(self.highLightTimer)
      self.highLightTimer = nil
    end
    self:SetCount()
  end
end

function UIAircraftItemSmeltMatItem:Active(active)
  self._go:SetActive(active)
end

function UIAircraftItemSmeltMatItem:OnHide()
  if self.shakeTweener then
    self.shakeTweener:Kill()
    self._root.anchoredPosition = Vector2(0, 0)
  end
  if self.highLightTimer then
    GameGlobal.Timer():CancelEvent(self.highLightTimer)
  end
end

function UIAircraftItemSmeltMatItem:iconOnClick(go)
  if self._onClick then
    self._onClick(self._matid, go, self._idx)
  end
end

function UIAircraftItemSmeltMatItem:Select(select)
  self._selector:SetActive(select)
end

function UIAircraftItemSmeltMatItem:SetCamp()
  if not self._camp then
    self._camp = self:GetUIComponent("Image", "camp")
    self._atlas = self:GetAsset("UIAircraftSmeltRoom.spriteatlas", LoadType.SpriteAtlas)
  end
  local cfg = Cfg.cfg_aircraft_smelt_camp[self._matid]
  if not cfg.Camp then
    Log.exception("势力材料没有配置在cfg_aircraft_smelt_camp中:", self._matid)
  end
  self._camp.sprite = self._atlas:GetSprite("wind_shili_di" .. cfg.Camp)
  self._camp.gameObject:SetActive(true)
end
