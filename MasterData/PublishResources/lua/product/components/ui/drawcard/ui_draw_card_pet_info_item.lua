_class("UIDrawCardPetInfoItem", Object)
UIDrawCardPetInfoItem = UIDrawCardPetInfoItem

function UIDrawCardPetInfoItem:Constructor(go)
  self._go = go
  self.boxNames = {
    "obtain_huodong_bing",
    "obtain_huodong_huo",
    "obtain_huodong_sen",
    "obtain_huodong_lei"
  }
  self._assets = {}
  local view = go:GetComponent("UIView")
  self.icon = view:GetUIComponent("Image", "icon")
  self.box = view:GetUIComponent("Image", "box")
  self.name = view:GetUIComponent("UILocalizationText", "name")
  self.btn = view:GetGameObject("btn")
  self._view = view
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._events = UICustomUIEventListener:New()
end

function UIDrawCardPetInfoItem:SetData(tmpID, cfg, callback)
  local offset = cfg.pos
  self.ID = tmpID
  local petCfg = Cfg.cfg_pet[self.ID]
  if not petCfg then
    Log.warn("### no pet in cfg_pet. self.ID=", self.ID)
    return
  end
  self.name.text = StringTable.Get(petCfg.Name)
  self.icon.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(Cfg.cfg_pet_element[petCfg.FirstElement].IconWhite))
  local atlas = self:GetAsset("UIDrawCard.spriteatlas", LoadType.SpriteAtlas)
  self.box.sprite = atlas:GetSprite(self.boxNames[petCfg.FirstElement])
  if cfg.type == 4 or cfg.type == 5 then
    if not self.stars then
      self.stars = UICustomWidgetPool:New(self, self._view:GetUIComponent("UISelectObjectPath", "stars"))
    end
    local stars = self.stars:GetAllSpawnList()
    for i = 1, petCfg.Star do
      stars[i]:SetData(cfg.star)
    end
  elseif cfg.type == 6 or cfg.type == 7 then
    local image = self._view:GetUIComponent("RawImageLoader", "stars")
    local rect = self._view:GetUIComponent("RectTransform", "stars")
    if image == nil then
      Log.exception("星灵控件配置错误:", cfg.type)
    end
    local starCfg = cfg.starCfg
    image:LoadImage(starCfg.name)
    rect.sizeDelta = Vector2(starCfg.size[1], starCfg.size[2])
    rect.anchoredPosition = Vector2(starCfg.pos[1], starCfg.pos[2])
  else
    if not self.stars then
      self.stars = UICustomWidgetPool:New(self, self._view:GetUIComponent("UISelectObjectPath", "stars"))
    end
    local stars = self.stars:SpawnObjects("UIDrawCardPetInfoStar", petCfg.Star)
    for i = 1, petCfg.Star do
      if cfg.starColor then
        local curColor = cfg.starColor
        stars[i]:SetData(curColor)
      end
    end
  end
  local rect = self._go:GetComponent(typeof(UnityEngine.RectTransform))
  rect.anchoredPosition = Vector2(offset[1], offset[2])
  self._events:AddUICustomEventListener(UICustomUIEventListener.Get(self.btn), UIEvent.Click, function()
    if callback then
      callback(self.ID)
    end
  end)
end

function UIDrawCardPetInfoItem:Dispose()
  self._events:Dispose()
  if self.stars then
    self.stars:Dispose()
  end
  for _, req in pairs(self._assets) do
    req:Dispose()
  end
end

function UIDrawCardPetInfoItem:GetAsset(name, type)
  if self._assets[name] then
    return self._assets[name].Obj
  end
  local req = ResourceManager:GetInstance():SyncLoadAsset(name, type)
  self._assets[name] = req
  return req.Obj
end
