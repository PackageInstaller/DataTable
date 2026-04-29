_class("UICN20MatRingItem", UICustomWidget)
UICN20MatRingItem = UICN20MatRingItem

function UICN20MatRingItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN20MatRingItem:InitWidget()
  self.criRingBg = self:GetUIComponent("Image", "CriRingBg")
  self.cubeRingBg = self:GetUIComponent("Image", "CubeRingBg")
  self.lock = self:GetGameObject("lock")
  self.needMatNameText = self:GetUIComponent("UILocalizationText", "NeedMatNameText")
  self.matIcon = self:GetUIComponent("Image", "MatIcon")
  self.matCountText = self:GetUIComponent("UILocalizationText", "MatCountText")
  self.layout = self:GetGameObject("layout")
  self.addBG = self:GetUIComponent("Image", "AddBG")
  self.lock1 = self:GetUIComponent("Image", "lock1")
  self.full1 = self:GetUIComponent("Image", "full1")
  self.lock2 = self:GetUIComponent("Image", "lock2")
  self.full2 = self:GetUIComponent("Image", "full2")
  self.lock3 = self:GetUIComponent("Image", "lock3")
  self.full3 = self:GetUIComponent("Image", "full3")
  self.matItemIcon = self:GetUIComponent("RawImageLoader", "MatItemIcon")
  self.addImgObj = self:GetGameObject("AddImg")
  self.rootRect = self:GetUIComponent("RectTransform", "Root")
  self.selectImgObj = self:GetGameObject("SelectImg")
  self.selectImg = self:GetUIComponent("Image", "SelectImg")
  self.rootObj = self:GetGameObject("Root")
  self._amim = self:GetUIComponent("Animation", "Root")
  self.criFull = self:GetUIComponent("Image", "CriFull")
  self.hexFull = self:GetUIComponent("Image", "HexFull")
  self._atlas = self:GetAsset("UICN20N49.spriteatlas", LoadType.SpriteAtlas)
end

function UICN20MatRingItem:SetData(itemCfgId, isHex, originPos, index, centerRect, clickCB)
  self.itemCfgId = itemCfgId
  self.isHex = isHex
  self.putItem = false
  self.isLock = true
  self.originPos = originPos
  self.index = index
  self.clickCB = clickCB
  self.centerRect = centerRect
  self.selectImgObj:SetActive(false)
  self.rootRect.anchoredPosition = self.originPos
  local itemCfg = Cfg.cfg_item[itemCfgId]
  if not itemCfg then
    Log.error("itemCfg matCfg IS NIL", itemCfgId)
    return
  end
  self.itemCfg = itemCfg
  local matCfg = Cfg.cfg_component_alchemy_material[itemCfgId]
  if matCfg == nil then
    Log.error("alchemyCfg matCfg IS nil", itemCfgId)
    return
  end
  self.matCfg = matCfg
  self.matItemIcon.gameObject:SetActive(false)
  self.addImgObj:SetActive(true)
  if self.isHex then
    self.criRingBg.gameObject:SetActive(false)
    self.cubeRingBg.gameObject:SetActive(true)
    self.layout:SetActive(true)
    self.needMatNameText.gameObject:SetActive(false)
  else
    self.criRingBg.gameObject:SetActive(true)
    self.cubeRingBg.gameObject:SetActive(false)
    self.layout:SetActive(false)
    self.needMatNameText.gameObject:SetActive(true)
  end
  self:Refresh_Lock()
  self:Refresh_Attribute()
  self.matCountText:SetText(self.matCfg.PropertyVal)
  self.needMatNameText:SetText(StringTable.Get(self.itemCfg.Name))
  self.matItemIcon:LoadImage(self.itemCfg.Icon)
  self.criFull.gameObject:SetActive(false)
  self.hexFull.gameObject:SetActive(false)
  if self.matCfg.Property == 1 then
    self.matIcon.sprite = self._atlas:GetSprite("cn20_ljjm_ljsx02")
    self.criFull.sprite = self._atlas:GetSprite("cn20_ljjm_yhsx02")
    self.hexFull.sprite = self._atlas:GetSprite("cn20_ljjm_lbxsx02")
    self.full1.sprite = self._atlas:GetSprite("cn20_ljjm_scsx02")
    self.full2.sprite = self._atlas:GetSprite("cn20_ljjm_scsx02")
    self.full3.sprite = self._atlas:GetSprite("cn20_ljjm_scsx02")
  elseif self.matCfg.Property == 2 then
    self.matIcon.sprite = self._atlas:GetSprite("cn20_ljjm_ljsx01")
    self.criFull.sprite = self._atlas:GetSprite("cn20_ljjm_yhsx01")
    self.hexFull.sprite = self._atlas:GetSprite("cn20_ljjm_lbxsx01")
    self.full1.sprite = self._atlas:GetSprite("cn20_ljjm_scsx01")
    self.full2.sprite = self._atlas:GetSprite("cn20_ljjm_scsx01")
    self.full3.sprite = self._atlas:GetSprite("cn20_ljjm_scsx01")
  elseif self.matCfg.Property == 3 then
    self.matIcon.sprite = self._atlas:GetSprite("cn20_ljjm_ljsx03")
    self.criFull.sprite = self._atlas:GetSprite("cn20_ljjm_yhsx03")
    self.hexFull.sprite = self._atlas:GetSprite("cn20_ljjm_lbxsx03")
    self.full1.sprite = self._atlas:GetSprite("cn20_ljjm_scsx03")
    self.full2.sprite = self._atlas:GetSprite("cn20_ljjm_scsx03")
    self.full3.sprite = self._atlas:GetSprite("cn20_ljjm_scsx03")
  elseif self.matCfg.Property == 4 then
    self.matIcon.sprite = self._atlas:GetSprite("cn20_ljjm_ljsx04")
    self.criFull.sprite = self._atlas:GetSprite("cn20_ljjm_yhsx04")
    self.hexFull.sprite = self._atlas:GetSprite("cn20_ljjm_lbxsx04")
    self.full1.sprite = self._atlas:GetSprite("cn20_ljjm_scsx04")
    self.full2.sprite = self._atlas:GetSprite("cn20_ljjm_scsx04")
    self.full3.sprite = self._atlas:GetSprite("cn20_ljjm_scsx04")
  end
end

function UICN20MatRingItem:GetPos()
  local worldPos = self.rootRect.transform.position
  local camera = GameGlobal.UIStateManager():GetControllerCamera("UICN20AlchemyMainController")
  local screenPos = camera:WorldToScreenPoint(worldPos)
  local res, calcuPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.centerRect, screenPos, camera, nil)
  return calcuPos
end

function UICN20MatRingItem:Refresh_Lock()
  if not self.isHex then
    self.isLock = false
    self.lock:SetActive(false)
    self.addBG.gameObject:SetActive(true)
  elseif not self.isLock then
    if self.lock.activeSelf then
      self._amim:Play("uieff_UICN20MatRingItem_unlock_in")
    end
    self.lock:SetActive(false)
    self.addBG.gameObject:SetActive(true)
  else
    self.lock:SetActive(true)
    self.addBG.gameObject:SetActive(false)
  end
end

function UICN20MatRingItem:SetUnLock()
  self.isLock = false
  self:Refresh_Lock()
  self:Refresh_Attribute()
end

function UICN20MatRingItem:Refresh_Attribute()
  if self.matCfg == nil then
    return
  end
  self.full1.gameObject:SetActive(false)
  self.full2.gameObject:SetActive(false)
  self.full3.gameObject:SetActive(false)
  if self.isLock then
    self.lock1.gameObject:SetActive(true)
    self.lock2.gameObject:SetActive(true)
    self.lock3.gameObject:SetActive(true)
    return
  end
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
  if self.putItem and not self.isLock then
    if self.matCfg.PropertyVal == 1 then
      self.full1.gameObject:SetActive(true)
    elseif self.matCfg.PropertyVal == 2 then
      self.full1.gameObject:SetActive(true)
      self.full2.gameObject:SetActive(true)
    elseif self.matCfg.PropertyVal == 3 then
      self.full1.gameObject:SetActive(true)
      self.full2.gameObject:SetActive(true)
      self.full3.gameObject:SetActive(true)
    end
  end
end

function UICN20MatRingItem:Refresh_PutShow()
  self.putItem = true
  self.addImgObj:SetActive(false)
  self.matItemIcon.gameObject:SetActive(true)
  if self.isHex then
    self.needMatNameText.gameObject:SetActive(true)
    self.layout:SetActive(false)
    self.hexFull.gameObject:SetActive(true)
  else
    self.criFull.gameObject:SetActive(true)
  end
  self._amim:Play("uieff_UICN20MatRingItem_put_in")
  GameGlobal.Timer():AddEvent(300, function()
    self:Refresh_Attribute()
  end)
end

function UICN20MatRingItem:Refresh_HeXPutPop(active)
  self.addImgObj:SetActive(active)
end

function UICN20MatRingItem:Refresh_UnPut()
  self.putItem = false
  self.addImgObj:SetActive(true)
  self.matItemIcon.gameObject:SetActive(false)
  if self.isHex then
    self.needMatNameText.gameObject:SetActive(false)
    self.layout:SetActive(true)
  else
  end
  self:Refresh_Attribute()
end

function UICN20MatRingItem:RefreshUnSelect()
  if self.selectImgObj.activeSelf then
    self._amim:Play("uieff_UICN20MatRingItem_select_out")
  end
  self.selectImgObj:SetActive(false)
end

function UICN20MatRingItem:AddBGOnClick(go)
  if not self.isHex and self.putItem then
    return
  end
  self.selectImg.color = Color(1, 1, 1, 1)
  self.selectImgObj:SetActive(true)
  self.selectImg:DOColor(Color(1, 1, 1, 0), 1)
  if self.clickCB then
    self.clickCB(self.index)
  end
  self._amim:Play("uieff_UICN20MatRingItem_select")
end
