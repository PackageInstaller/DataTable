local this = class("pageProductAccessory", G_UIPageBase)
local _HomeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _HomeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local NavigationAreaNames = {
  ProductList = "AreaProductList",
  MaterialList = "AreaMaterialList",
  ProductQueue = "AreaProductQueue"
}

function this.bind()
  return {
    module_productAccessory = {
      moduleName = "pages/product/moduleProductAccessory"
    },
    module_productQueue = {
      moduleName = "pages/product/moduleProductQueueNew"
    },
    module_productInfo = {
      moduleName = "pages/home/homeStation/moduleStationInfo"
    },
    module_Product = {
      moduleName = "pages/product/moduleProductInfoNormal"
    },
    active_mask = false,
    active_nodeProductInfo = false
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_mask = function(self)
      self:refreshInfo(false)
      self.modules.module_Product:OnClearSingleQuaProductData()
    end,
    onClick_pageMask = function(self)
      self:refreshInfo(false)
      self.modules.module_Product:OnClearSingleQuaProductData()
    end
  }
end

function this:check(options, callback)
  local result = C_BattleManager.IsInBattle(C_EntityManager.MainPlayer)
  if result ~= nil and result == true then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_cannot_opn_inbattle_pageProduct"))
    callback(result)
    return
  end
  result = result or C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.product)
  callback(result)
end

function this:preOpen(options)
  self._buildingId = options.buildingId
  self._buildingGuid = options.buildingGuid
  self._buildingType = options.buildType
  self._selProductId = options.selProductId
  self._navMgr = self.gameObject:GetComponent(typeof(CS.Lens.Gameplay.UI.UINavigationBinding))
  self._inputActionBinding = self.gameObject:GetComponent(typeof(CS.Lens.Gameplay.UI.UIInputActionBinding))
  this.super.preOpen(self, options)
  self.modules.module_Product:setAttributionProduct(true)
  self.modules.module_productInfo:setAttributionProduct(true)
  self.modules.module_productQueue:initModule(self._buildingGuid)
  self.modules.module_productAccessory:initModule(self._buildingGuid, options.selectTabId, self._selProductId)
  local serverData = L_HomeStore:getHomeBuildingByGuid(self._buildingGuid)
  local buildTpl = _HomeBuildingTpl:getTplById(serverData.build_id)
  local groupId = _HomeBuildingTpl:getGroupId(buildTpl)
  if self._selProductId then
    self:newOrResetTimer("selTimer", function()
      self.modules.module_productAccessory:manualSIMSelAndClick(tonumber(self._selProductId))
    end, 0.5)
  else
    self:refreshInfo(false)
  end
end

function this:onSelectId(id, pos, blockClick, kiboExpInfos)
  self.modules.module_productInfo:setQualityAccessory()
  self:setDynaNodePos(pos)
  self.modules.module_Product:setSingleQualityProduct(self._buildingGuid, id, self._buildingType, L_HomeConst.ProductInfoDescType.Accessory, blockClick, self._buildingId)
  self.modules.module_Product:updateKiboWorkInfo(kiboExpInfos)
end

function this:setDynaNodePos(pos)
  if pos == nil then
    return
  end
  local rRects = self.bindComponents.rNodeTrans
  local viewWidth = 656
  local screenPos = C_CameraManager.uiCamera:WorldToScreenPoint(pos)
  local targetPos = rRects.position
  targetPos.x = pos.x
  targetPos.z = pos.z
  rRects.position = targetPos
  local anchoredPos = rRects.anchoredPosition
  if screenPos.x < C_Screen.width / 2 then
    rRects.anchoredPosition = C_Vector2(anchoredPos.x + viewWidth / 2 + 121, anchoredPos.y)
  else
    rRects.anchoredPosition = C_Vector2(anchoredPos.x - viewWidth / 2 - 182, anchoredPos.y)
  end
end

function this:show()
  self:refreshdata()
  self:registerShortCut()
  self:refreshShortKeyFlag()
  self:setGamepadFocusModule(self.modules.module_productAccessory)
  L_TimerManager:newOrResetTimer(self, "pageProductAccessory_show_SelectArea", function()
    self._navMgr:SelectArea(NavigationAreaNames.ProductList)
  end, 0.066, 1)
end

function this:close()
  self.bind.active_nodeProductInfo = false
  self:unregisterShortCut()
  self:clearShortKeyFlag()
  self._navMgr = nil
  self._inputActionBinding = nil
  self.isOpen = false
  self.isTop = false
end

function this:refreshdata()
  self.modules.module_productQueue:initModule(self._buildingGuid)
  self.modules.module_productInfo:initBuilding(self._buildingGuid)
end

function this:refreshBuildiCell(buildId)
  self.modules.module_productAccessory:refreshBuildiCell(buildId)
end

function this:refreshInfo(isActive)
  if isActive then
    self.bind.active_nodeProductInfo = true
  end
  local isCurActive = self.bind.active_mask
  self.bind.active_mask = isActive
  if isCurActive ~= isActive then
    if not isActive then
      if self.bindComponents.animModuleProductFormula then
        self.bindComponents.animModuleProductFormula:Play("anim_product_commoninfo_out")
      end
      self.modules.module_productAccessory:selectSelectNone()
    else
      self.bindComponents.animModuleProductFormula:Play("anim_product_commoninfo_in")
    end
  end
  if isActive then
    self:setGamepadFocusModule(self.modules.module_Product)
  else
    self:setGamepadFocusModule(self.modules.module_productAccessory)
    self._navMgr:DisableAllArea(true)
    self._navMgr:SelectArea(NavigationAreaNames.ProductList)
  end
end

function this:initProductInfo()
  self.modules.module_productInfo:setQualityAccessory()
end

function this:open(options)
  self.super.open(self, options)
  self.isOpen = true
  self.isTop = true
end

function this:onTopChange(options)
  if not self.isOpen then
    return
  end
  local preIsTop = self.isTop
  local curPageName = L_UI:currentPage(L_UI.groupKeys.stack)
  self.isTop = self.pageName == curPageName
  if self.isTop ~= preIsTop then
    for _, module in pairs(self.modules) do
      if module.onPageTopChange then
        module:onPageTopChange(self.isTop, preIsTop)
      end
    end
  end
end

function this:escHandle()
  if not (C_InputManager.IsEnableGamePad and self._navMgr) or self:isGamepadFocusOn(self.modules.module_productAccessory) then
  elseif self:isGamepadFocusOn(self.modules.module_Product) then
    if self._navMgr.navigationEnabled then
      self._navMgr.navigationEnabled = false
      if self.modules.module_Product.refreshBottomShortCut then
        self.modules.module_Product:refreshBottomShortCut()
      end
    else
      self:refreshInfo(false)
    end
    return
  else
    if self:isGamepadFocusOn(self.modules.module_productQueue) then
      self:setGamepadFocusModule(self.modules.module_productAccessory)
      self._navMgr:SelectArea(NavigationAreaNames.ProductList)
      return
    else
    end
  end
  L_UI:close(self.pageName)
end

function this:setGamepadFocusModule(module)
  if self._currentGamepadFocusModule and self._currentGamepadFocusModule.setGamepadFocus then
    self._currentGamepadFocusModule:setGamepadFocus(false)
  end
  self._currentGamepadFocusModule = module
  if self._currentGamepadFocusModule and self._currentGamepadFocusModule.setGamepadFocus then
    self._currentGamepadFocusModule:setGamepadFocus(true)
  end
  self._navMgr.navigationEnabled = not self:isGamepadFocusOn(self.modules.module_Product)
  self._inputActionBinding.inputEnabled = self:isGamepadFocusOn(self.modules.module_productAccessory)
  self.modules.module_productInfo:setGamepadShortCutEnable(not self:isGamepadFocusOn(self.modules.module_Product))
  self:refreshShortKeyFlag()
end

function this:isGamepadFocusOn(module)
  if self._currentGamepadFocusModule == module then
    return true
  end
  if self._currentGamepadFocusModule == nil and module == self.modules.module_productAccessory then
    return true
  end
  return false
end

function this:registerShortCut()
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPageProductFocusProductQueue, function()
    if not self.isTop then
      return
    end
    if self.modules.module_productQueue:hasItemInQueue() then
      self:setGamepadFocusModule(self.modules.module_productQueue)
      self._navMgr:SelectArea(NavigationAreaNames.ProductQueue)
    end
  end)
end

function this:unregisterShortCut()
  L_ShortCutManager:unregisterShortCut(self.pageName, C_InputManager_KeyType.EPageProductFocusProductQueue)
end

function this:refreshShortKeyFlag()
  if self:isGamepadFocusOn(self.modules.module_productAccessory) then
    local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
    args.isLuaEvent = true
    args.luaTable = {
      moduleOrPageName = "pageProductAccessory",
      changeGroupName = "Group1"
    }
    C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
  end
end

function this:clearShortKeyFlag()
end

return this
