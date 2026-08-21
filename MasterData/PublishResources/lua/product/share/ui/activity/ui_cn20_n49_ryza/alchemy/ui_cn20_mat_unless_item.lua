_class("UICN20MatUnlessItem", UICustomWidget)
UICN20MatUnlessItem = UICN20MatUnlessItem

function UICN20MatUnlessItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN20MatUnlessItem:InitWidget()
  self.nameText = self:GetUIComponent("UILocalizationText", "NameText")
  self.item = self:GetUIComponent("UISelectObjectPath", "Item")
  self.root = self:GetGameObject("root")
  self.lock1 = self:GetGameObject("lock1")
  self.lock2 = self:GetGameObject("lock2")
  self.lock3 = self:GetGameObject("lock3")
  self.matIcon = self:GetUIComponent("Image", "MatIcon")
  self.matCountText = self:GetUIComponent("UILocalizationText", "MatCountText")
  self.itemRect = self:GetUIComponent("RectTransform", "Item")
  self._atlas = self:GetAsset("UICN20N49.spriteatlas", LoadType.SpriteAtlas)
end

function UICN20MatUnlessItem:SetPopActive(active)
  self.root:SetActive(active)
end

function UICN20MatUnlessItem:SetData(itemid)
  local itemCfg = Cfg.cfg_item[itemid]
  if not itemCfg then
    Log.error("itemCfg IS NIL", itemid)
    return
  end
  self._cfg_item = itemCfg
  local matCfg = Cfg.cfg_component_alchemy_material[itemid]
  if matCfg == nil then
    Log.error("alchemyCfg matCfg IS nil", itemid)
    return
  end
  self.matCfg = matCfg
  if self.matCfg.Property == 1 then
    self.matIcon.sprite = self._atlas:GetSprite("cn20_ljjm_ljsx02")
  elseif self.matCfg.Property == 2 then
    self.matIcon.sprite = self._atlas:GetSprite("cn20_ljjm_ljsx01")
  elseif self.matCfg.Property == 3 then
    self.matIcon.sprite = self._atlas:GetSprite("cn20_ljjm_ljsx03")
  elseif self.matCfg.Property == 4 then
    self.matIcon.sprite = self._atlas:GetSprite("cn20_ljjm_ljsx04")
  end
  self.matCountText:SetText("" .. self.matCfg.PropertyVal)
  if self.matCfg.PropertyVal == 1 then
    self.lock1.gameObject:SetActive(false)
    self.lock2.gameObject:SetActive(true)
    self.lock3.gameObject:SetActive(true)
  elseif self.matCfg.PropertyVal == 2 then
    self.lock1.gameObject:SetActive(false)
    self.lock2.gameObject:SetActive(false)
    self.lock3.gameObject:SetActive(true)
  elseif self.matCfg.PropertyVal == 3 then
    self.lock1.gameObject:SetActive(false)
    self.lock2.gameObject:SetActive(false)
    self.lock3.gameObject:SetActive(false)
  end
  local name = StringTable.Get(self._cfg_item.Name)
  self.nameText:SetText(name)
  self.selectItem = self.item:SpawnObject("UICN20SelectMatItem")
  self.selectItem:SetData(itemid)
  self:SetPopActive(true)
end

function UICN20MatUnlessItem:ClickBGOnClick(go)
  self:SetPopActive(false)
end
