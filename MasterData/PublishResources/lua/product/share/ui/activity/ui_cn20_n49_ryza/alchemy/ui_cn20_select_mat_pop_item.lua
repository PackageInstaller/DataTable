_class("UICN20SelectMatPopItem", UICustomWidget)
UICN20SelectMatPopItem = UICN20SelectMatPopItem

function UICN20SelectMatPopItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN20SelectMatPopItem:InitWidget()
  self.bg = self:GetUIComponent("Image", "bg")
  self.pool = self:GetUIComponent("UISelectObjectPath", "Pool")
  self.root = self:GetGameObject("root")
  self.rootRect = self:GetUIComponent("RectTransform", "root")
  self.lock1 = self:GetGameObject("lock1")
  self.lock2 = self:GetGameObject("lock2")
  self.lock3 = self:GetGameObject("lock3")
  self.matIcon = self:GetUIComponent("Image", "MatIcon")
  self.matCountText = self:GetUIComponent("UILocalizationText", "MatCountText")
  self.itemRect = self:GetUIComponent("RectTransform", "Item")
  self._atlas = self:GetAsset("UICN20N49.spriteatlas", LoadType.SpriteAtlas)
  self.guideItemGo = self:GetGameObject("guideItem")
  self.guideItemGo:SetActive(false)
end

function UICN20SelectMatPopItem:SetData(itemid, num, ringIndex, ringItem, ringPos, selectCB, cancleCB)
  self.selectCB = selectCB
  self.cancleCB = cancleCB
  self.ringIndex = ringIndex
  self.itemid = itemid
  self.ringItem = ringItem
  self.ringPos = ringPos
  self:SetPopActive(true)
  
  function self.cb()
    self:SetPopActive(false)
    self.selectCB(self.ringItem, self.itemid, self.ringIndex)
  end
  
  self.ringPos.y = self.ringPos.y - 250
  local screenHeight = UnityEngine.Screen.height
  local maxHeight = screenHeight / 2 - 350
  local minHeight = -(screenHeight / 2 - 150)
  local defaultPos = Vector2(0, 250)
  if minHeight > self.ringPos.y then
    self.ringPos.y = self.ringPos.y + 500
    defaultPos = Vector2(0, -250)
  end
  self.rootRect.anchoredPosition = self.ringPos
  self.itemRect.anchoredPosition = defaultPos
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
  if 20 < num then
    num = 20
  end
  self.ALLItem = self.pool:SpawnObjects("UICN20SelectMatItem", num)
  for i = 1, num do
    local item = self.ALLItem[i]
    item:SetData(itemid, self.cb)
  end
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:IsGuideProcess(2004911) then
    self.guideItemGo:SetActive(true)
  end
end

function UICN20SelectMatPopItem:SetPopActive(active)
  self.root:SetActive(active)
end

function UICN20SelectMatPopItem:clickbgOnClick(go)
  if self.cancleCB then
    self.cancleCB(self.ringItem)
  end
  self.root:SetActive(false)
end

function UICN20SelectMatPopItem:GuideItemOnClick()
  self.ALLItem[1]:BgOnClick()
  self.guideItemGo:SetActive(false)
end
