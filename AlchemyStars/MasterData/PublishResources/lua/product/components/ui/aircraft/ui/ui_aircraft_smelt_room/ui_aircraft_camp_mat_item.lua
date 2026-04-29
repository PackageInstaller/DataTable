_class("UIAircraftCampMatItem", UICustomWidget)
UIAircraftCampMatItem = UIAircraftCampMatItem

function UIAircraftCampMatItem:OnShow(uiParams)
  self._roleModule = self:GetModule(RoleModule)
  self._waitTime = Cfg.cfg_global.shakeWaitTime.IntValue or 2000
  self._shakeX = Cfg.cfg_global.shakeOffsetX.IntValue or 10
  self._shakeY = Cfg.cfg_global.shakeOffsetY.IntValue or 10
  self:InitWidget()
end

function UIAircraftCampMatItem:InitWidget()
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.count = self:GetUIComponent("UILocalizationText", "itemCount")
  self._root = self:GetUIComponent("RectTransform", "root")
  self._go = self:GetGameObject("root")
  self._selector = self:GetGameObject("selector")
  self._selector:SetActive(false)
end

function UIAircraftCampMatItem:SetData(id, count, onClick, idx)
  self._matid = id
  self._count = count
  self._currentCount = self._roleModule:GetAssetCount(self._matid)
  self._onClick = onClick
  self._idx = idx
  local cfg_item = Cfg.cfg_item[id]
  self.icon:LoadImage(cfg_item.Icon)
  self.name:SetText(StringTable.Get(cfg_item.Name))
  self:SetCount()
end

function UIAircraftCampMatItem:ResetCount(count)
  self._count = count
  self:SetCount()
end

function UIAircraftCampMatItem:SetCount()
  local str
  if self._selected then
    if self._currentCount >= self._count then
      str = "<color=#ffd300>" .. self._currentCount .. "/" .. self._count .. "</color>"
    else
      str = self._currentCount .. "/<color=#ffd300>" .. self._count .. "</color>"
    end
  else
    str = self._currentCount
  end
  self.count:SetText(str)
end

function UIAircraftCampMatItem:ShakeAndHighlight()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUIMaterialNotEnough)
  if self.shakeTweener then
    self.shakeTweener:Kill()
    self._root.anchoredPosition = Vector2(0, 0)
  end
  if self.highLightTimer then
    GameGlobal.Timer():CancelEvent(self.highLightTimer)
  end
  local str = "<color=#ff0000>" .. self._currentCount .. "/" .. self._count .. "</color>"
  self.count:SetText(str)
  self.shakeTweener = self._root:DOShakePosition(1, Vector3(self._shakeX, self._shakeY, 0)):OnComplete(function()
    self.highLightTimer = GameGlobal.Timer():AddEvent(self._waitTime, function()
      self:SetCount()
    end)
  end)
end

function UIAircraftCampMatItem:TryStopShake()
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

function UIAircraftCampMatItem:Active(active)
  self._go:SetActive(active)
end

function UIAircraftCampMatItem:OnHide()
  if self.shakeTweener then
    self.shakeTweener:Kill()
    self._root.anchoredPosition = Vector2(0, 0)
  end
  if self.highLightTimer then
    GameGlobal.Timer():CancelEvent(self.highLightTimer)
  end
end

function UIAircraftCampMatItem:iconOnClick(go)
  if self._onClick then
    self._onClick(self._matid, go, self._idx)
  end
end

function UIAircraftCampMatItem:Select(select)
  self._selected = select
  self:SetCount()
  self._selector:SetActive(select)
end

function UIAircraftCampMatItem:SetCamp()
  if not self._matid then
    return
  end
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
