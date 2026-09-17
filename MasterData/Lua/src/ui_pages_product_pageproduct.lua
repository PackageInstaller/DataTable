local this = class("pageProduct", G_UIPageBase)
local C_TechnologyStore = CS.Lens.Gameplay.UI.TechnologyStore
local _productsTpl = L_GameTpl:getProductsTpl()
local _buildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local _homeFreeWorkPositionTpl = L_GameTpl:getHomeFreeWorkPositionTpl()
local _productsMultiQualityTpl = L_GameTpl:getProductsMultiQualityTpl()
local HideNodeList_PageProduct = CS.System.Collections.Generic.List(CS.System.String)()
HideNodeList_PageProduct:Add(L_Const.WorldNode.PLAYER)
HideNodeList_PageProduct:Add(L_Const.WorldNode.PLAYERPETNODE)
local previewTxtColor = C_Color(0.984313725490196, 1, 0.7215686274509804, 1)
local NavigationAreaNames = {
  ProductListNormal = "AreaProductListNormal",
  ProductListCard = "AreaProductListCard",
  ProductListEgg = "AreaProductListEgg",
  MaterialList = "AreaMaterialList",
  ProductQueue = "AreaProductQueue"
}

function this.bind()
  return {
    module_productNormalNew = {
      moduleName = "pages/product/moduleProductNormalNew"
    },
    module_productInfo = {
      moduleName = "pages/product/moduleProductInfoNormal"
    },
    module_productQueueNew = {
      moduleName = "pages/product/moduleProductQueueNew"
    },
    module_homeProperty = {
      moduleName = "pages/home/homeProperty/moduleHomeProperty"
    },
    moduleStationInfo = {
      moduleName = "pages/home/homeStation/moduleStationInfo"
    },
    list_combineLink = {
      moduleName = "pages/product/cellProductCombineLink"
    },
    go_combineLinkList = false,
    go_mask = false,
    txt_petStationedNum = "",
    txt_petStationedTotal = "",
    alpha_previewPetBuffTime1 = previewTxtColor,
    alpha_previewPetBuffTime2 = previewTxtColor,
    alpha_previewPetBuffTime3 = previewTxtColor
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self:handleCloseLogic()
    end,
    onClick_bg = function(self)
      self.modules.module_productNormalNew:onSelectTarget(0)
    end,
    onClick_mask = function(self)
      if self.bind.go_mask then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getTplById("notice_quickJump_cannotSelect_Others"))
      end
    end,
    onClick_petManageBtn = function(self)
      local lt = self.modules.moduleStationInfo:needLaborType()
      L_UI:open("pageHomeLaborManage", {
        FilterLabor = type(lt) == "table" and lt[1] or lt
      })
    end
  }
end

function this:handleCloseLogic()
  if self.parentTab ~= nil and self.parentTab.fromBuildId ~= nil and self.parentTab.fromBuildId ~= 0 then
    local lst = C_HomeUtil.ToList_HomeProductCombineLink()
    if lst ~= nil and lst.Count > 1 then
      local obj = {}
      local v = lst[lst.Count - 2]
      obj.itemId = v.ItemID
      obj.itemType = v.ItemType
      obj.fromBuildId = v.FromBuildingID
      obj.parentId = v.ParentID
      obj.parentPageGuid = v.ParentPageGUID
      self:onClick_combineLink(obj)
      return
    end
  end
  L_UI:close(self.pageName)
end

function this:escHandle()
  if self:escHandleGamepadFocus() then
    return
  end
  self:handleCloseLogic()
end

function this:check(options, callback)
  local result = C_BattleManager.IsInBattle(C_EntityManager.MainPlayer)
  if result ~= nil and result == true then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_cannot_opn_inbattle_pageProduct"))
    callback(false)
    return
  end
  local manager = AzurWorld.HomeMgr
  local build = manager:GetHomeBuild(options.buildingGuid)
  local isFromHomeCenter = options.isFromHomeCenter
  if (not (build and build.buildEntityHandle) or not build.buildEntityHandle.entity) and isFromHomeCenter ~= true then
    callback(false)
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.product)
  callback(result)
end

function this:preOpen(options)
  CS.UnityEngine.Profiling.Profiler.BeginSample("pageProduct preOpen")
  self._buildingGuid = options.buildingGuid
  self._selectbuildingId = options.buildingId
  self.isFromHomeCenter = options.isFromHomeCenter
  self._navMgr = self.gameObject:GetComponent(typeof(CS.Lens.Gameplay.UI.UINavigationBinding))
  self._inputActionBinding = self.gameObject:GetComponent(typeof(CS.Lens.Gameplay.UI.UIInputActionBinding))
  self:cameraFocusOnMainUITrans()
  this.super.preOpen(self, options)
  self._isJourney = false
  if options.jumpParams and options.jumpParams[2] and options.jumpParams[2] == "journey" then
    self._isJourney = true
  end
  if options.jumpTab ~= nil then
    self.parentTab = table.clone(options.jumpTab)
    if self._isJourney then
      self:clearProductCombineLink()
      local id = self.parentTab.itemId
      local tpl = _productsTpl:getTplById(id)
      if tpl then
        local rewardList = _productsTpl:getRewardId(tpl)
        local reward = L_DataUtil.parseRewardConfigItem(rewardList[1])
        self.parentTab.itemId = reward.itemId
        self.parentTab.itemType = reward.itemType
        self.parentTab.parentId = id
      end
    end
    if not math.isEmpty(self.parentTab.parentId) then
      self:pushHomeProductCombineLink()
    else
      self:clearProductCombineLink()
    end
  end
  self:refreshProperty()
  self.isFirstInAndSelectId = true
  local animationName = "anim_product_in"
  local lst = C_HomeUtil.ToList_HomeProductCombineLink()
  if lst ~= nil and 2 < lst.Count then
    animationName = "anim_product_show"
  end
  self.bindComponents.anim_pageProduct.m_curOpenStyle.clipName = animationName
  CS.UnityEngine.Profiling.Profiler.EndSample()
end

function this:cameraFocusOnMainUITrans()
  if self.isFromHomeCenter == true then
    return
  end
  C_HomeUtil.FocusBuildWithCustomHideList(self._buildingGuid, L_HomeConst.FocusType.MAINUI, HideNodeList_PageProduct, "pageProduct")
end

function this:cameraExitFocusOnMainUITrans()
  if self.isFromHomeCenter == true then
    return
  end
  C_HomeUtil.ExitFocusBuildAndRevertCustomHideNodeList(HideNodeList_PageProduct, "pageProduct")
end

function this:onSelectId(id, isMultiQuality, sourceOfPlayModuleProductInfoAnimation)
  if self.cachePlaySoundId ~= id then
    self.cachePlaySoundId = id
    C_AudioManager.Play("Play_SFX_System_UI_General_Parchment_Switch_L2")
  end
  local moduleProductInfo = self.modules.module_productInfo
  local moduleProductInfoAnimation = moduleProductInfo.bindComponents.animation
  if self.isFirstInAndSelectId == true or sourceOfPlayModuleProductInfoAnimation == nil then
    self:setModuleProductInfo(id, isMultiQuality)
  elseif sourceOfPlayModuleProductInfoAnimation == L_HomeConst.SourceOfPlayModuleProductInfoAnimation.OnClickTab then
    if moduleProductInfoAnimation.isPlaying then
      moduleProductInfoAnimation:Stop()
    end
    moduleProductInfoAnimation:Play("anim_product_commoninfo_change")
    Timer.once(0.13, function()
      self:setModuleProductInfo(id, isMultiQuality)
    end)
  elseif sourceOfPlayModuleProductInfoAnimation == L_HomeConst.SourceOfPlayModuleProductInfoAnimation.OnClickItem then
    if moduleProductInfoAnimation.isPlaying then
      moduleProductInfoAnimation:Stop()
    end
    moduleProductInfoAnimation:Play("anim_product_commoninfo_change1")
    Timer.once(0.066, function()
      self:setModuleProductInfo(id, isMultiQuality)
    end)
  end
  if sourceOfPlayModuleProductInfoAnimation == L_HomeConst.SourceOfPlayModuleProductInfoAnimation.OnClickItem then
    self:setGamepadFocusModule(self.modules.module_productInfo)
  else
    local buildingType = self._buildingType or C_HomeUtil.GetBuildingType(self._buildingGuid)
    if buildingType == L_Const.WorldMapBuildType.WMBT_HATCH and isMultiQuality == L_HomeConst.SourceOfPlayModuleProductInfoAnimation.OnClickItem then
      self:setGamepadFocusModule(self.modules.module_productInfo)
    end
  end
  self.isFirstInAndSelectId = false
  self:onSelect_combineLink(id, isMultiQuality)
end

function this:setModuleProductInfo(id, isMultiQuality)
  local moduleProductInfo = self.modules.module_productInfo
  local moduleStationInfo = self.modules.moduleStationInfo
  if id == 0 then
    moduleProductInfo:setIsEmpty(true)
    return
  end
  if self.parentTab ~= nil then
    moduleProductInfo:OnGetParentTab(self.parentTab)
  end
  self._buildingType = self._buildingType or C_HomeUtil.GetBuildingType(self._buildingGuid)
  if self._buildingType == L_Const.WorldMapBuildType.WMBT_HATCH then
    local eggGuid = id
    moduleProductInfo:setEggInfo(eggGuid, self._buildingGuid, moduleStationInfo:isPreviewPet())
  else
    if isMultiQuality then
      local foodGroupId = id
      moduleProductInfo:setMultiQualityProduct(self._buildingGuid, foodGroupId, moduleStationInfo:isPreviewPet())
    else
      local productId = id
      moduleProductInfo:setSingleQualityProduct(self._buildingGuid, productId, self._buildingType, nil, nil, self._selectbuildingId, moduleStationInfo:isPreviewPet())
    end
    moduleProductInfo:setSelectNumGamepadShortCutEnable(self:isGamepadFocusOn(moduleProductInfo))
  end
end

function this:open(options)
  self.bindComponents.anim_moduleProduct_BgTemplate:Play("anim_product_common_bg")
  L_ProductStore:listenCallFunc(L_ProductStore.event.closeTargetInfo, self.closeTargetInfo, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshBuildingPet, self.onEventMessageRefreshPet, self)
  L_ProductStore:listenCallFunc(L_ProductStore.event.refreshHomeProduct, self.onEventMessageRefreshHomeProduct, self)
  self.onHomeHubSyncHandler = handler(self, self.refreshdata)
  L_HomeStore:getCsHomeStore():RegisterEvent(C_EHomeStoreEvent.HomeHubSync, self.onHomeHubSyncHandler)
  L_TechnologyStore:listenCallFunc(L_TechnologyStore.event.refresh, self.onHomeHubSyncHandler)
  self.isOpen = true
  self.isTop = true
end

function this:close(options)
  local entity = L_HomeManager:getBuildingEntityByGuid(self._buildingGuid)
  if entity then
    L_HomeManager:sendEvent(L_HomeManager.event.triggerBuilding, {
      isIn = entity.data.isIn,
      entity = entity
    })
  end
  self:cameraExitFocusOnMainUITrans()
  L_ProductStore:unListenCallFunc(L_ProductStore.event.closeTargetInfo, self.closeTargetInfo, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshBuildingPet, self.onEventMessageRefreshPet, self)
  L_ProductStore:unListenCallFunc(L_ProductStore.event.refreshHomeProduct, self.onEventMessageRefreshHomeProduct, self)
  L_TimerManager:clearTimer(self)
  L_HomeStore:getCsHomeStore():UnregisterEvent(C_EHomeStoreEvent.HomeHubSync, self.onHomeHubSyncHandler)
  L_TechnologyStore:unListenCallFunc(L_TechnologyStore.event.refresh, self.onHomeHubSyncHandler)
  self:unregisterShortCut()
  self:clearShortKeyFlag()
  self._navMgr = nil
  self._inputActionBinding = nil
  self.isOpen = false
  self.isTop = false
  self.cachePlaySoundId = nil
  this.super.close(self, options)
end

function this:show()
  CS.UnityEngine.Profiling.Profiler.BeginSample("pageProduct show")
  self:cameraFocusOnMainUITrans()
  self:refreshdata()
  self:initCombineLinkListView()
  self:freshCombineLinkListView()
  self:refreshPetStationedNum()
  self:registerShortCut()
  self:refreshShortKeyFlag()
  self:setGamepadFocusModule(self.modules.module_productNormalNew)
  L_TimerManager:newOrResetTimer(self, "pageProduct_show_SelectArea", function()
    self._navMgr:SelectArea(self:getProductListAreaName())
  end, 0.066, 1)
  CS.UnityEngine.Profiling.Profiler.EndSample()
end

function this:refreshdata()
  local buildType = C_HomeUtil.GetBuildingType(self._buildingGuid)
  local selectId = self.parentTab ~= nil and self.parentTab.itemId or self._combineLinkSelectItemId or nil
  self.modules.moduleStationInfo:initBuilding(self._buildingGuid, true)
  self.modules.module_productInfo:setAttributionProduct(true)
  self.modules.moduleStationInfo:setAttributionProduct(true)
  self.modules.module_productQueueNew:initModule(self._buildingGuid)
  self.modules.module_productNormalNew:initModule(self._buildingGuid, selectId, selectId ~= nil, self._isJourney)
  local c = 0
  L_TimerManager:newOrResetTimer(self, "previewAlpha", function()
    c = c + 2
    local a = c % 60 / 30
    if 1 < a then
      a = 2 - a
    end
    if not math.isEmpty(self.modules.moduleStationInfo:isPreviewPet()) then
      self.bind.alpha_previewPetBuffTime1 = C_Color(previewTxtColor.r, previewTxtColor.g, previewTxtColor.b, a)
      self.bind.alpha_previewPetBuffTime2 = self.bind.alpha_previewPetBuffTime1
      self.bind.alpha_previewPetBuffTime3 = self.bind.alpha_previewPetBuffTime1
      local color = C_Color(1, 1, 1, a)
      self.modules.moduleStationInfo.modules.module_petIcon:SetColor(color)
      self.modules.moduleStationInfo.modules.module_petIconOutLine:SetColor(color)
    else
      self.bind.alpha_previewPetBuffTime1 = previewTxtColor
      self.bind.alpha_previewPetBuffTime2 = previewTxtColor
      self.bind.alpha_previewPetBuffTime3 = previewTxtColor
      self.modules.moduleStationInfo.modules.module_petIcon:SetColor(C_Color.white)
      self.modules.moduleStationInfo.modules.module_petIconOutLine:SetColor(C_Color.white)
    end
  end, 0.1, -1)
end

function this:refreshPreviewPetGuid()
  self.modules.module_productInfo:refreshPreviewPetGuid(self._buildingGuid, self.modules.moduleStationInfo:isPreviewPet())
end

function this:refreshProperty()
  self.modules.module_homeProperty:setProduct(self._buildingGuid)
end

function this:closeTargetInfo()
  self.modules.module_productNormalNew:onSelectTarget(0)
end

function this:onEventMessageRefreshPet()
  self.modules.module_productInfo:refreshView()
end

function this:onEventMessageRefreshHomeProduct()
  self:refreshProperty()
end

function this:CheckCanFindTargetCellItem(guideSerializeId, guideParam)
  return true
end

function this:FindTargetCellItem(guideSerializeId, guideParam)
  if guideSerializeId == L_Const.GuideSerializeId.ProductCooking then
    return self.modules.module_productNormalNew:FindTargetCellItem(guideSerializeId, guideParam)
  end
  return nil
end

function this:initCombineLinkListView()
  local data = L_HomeStore:getHomeBuildingByGuid(self._buildingGuid)
  local tpl = L_GameTpl:getHomeBuildingProductionTpl()
  local td = tpl:getTplById(data.build_id)
  local listType = tpl:getProductListType(td)
  self.CombineLinkList = {}
  if listType == 1 then
  end
  local lst = C_HomeUtil.ToList_HomeProductCombineLink()
  if lst ~= nil and lst.Count > 0 then
    self.CombineLinkList = {}
    for i = 0, lst.Count - 1 do
      local v = lst[i]
      local obj = {}
      obj.itemId = v.ItemID
      obj.itemType = v.ItemType
      obj.fromBuildId = v.FromBuildingID
      obj.parentId = v.ParentID
      obj.parentPageGuid = v.ParentPageGUID
      obj.isLast = i == lst.Count - 1
      table.insert(self.CombineLinkList, i + 1, obj)
    end
  end
end

function this:freshCombineLinkListView(refresh)
  if self.CombineLinkList == nil or #self.CombineLinkList <= 1 then
    self.bind.go_combineLinkList = false
    if self.bind.go_mask then
      self.bind.go_mask = false
    end
    return
  end
  self.bind.go_combineLinkList = true
  self.bind.go_mask = true
  self.bind.list_combineLink:clear()
  local delayTime = refresh and 0.066 or 0.233
  self:freshCombineLinkListViewTimer(delayTime)
end

function this:freshCombineLinkListViewTimer(delayTime)
  self:newOrResetTimer("freshCombineLinkListView", function()
    local cnt = self.bind.list_combineLink:getLength()
    self.bind.list_combineLink:insert_array({
      [1] = self.CombineLinkList[cnt + 1]
    })
    if cnt + 1 < #self.CombineLinkList then
      self:freshCombineLinkListViewTimer(0.033)
    end
  end, delayTime)
end

function this:onSelect_combineLink(id, isMultiQuality)
  if not (not self.parentTab or math.isEmpty(self.parentTab.parentId)) or math.isEmpty(id) then
    return
  end
  local productId = id
  if isMultiQuality then
    local productsIdList = _productsMultiQualityTpl:getProductIdListByFoodGroupId(id)
    productId = productsIdList and productsIdList[1] or 0
  end
  local tpl = _productsTpl:getTplById(productId, false)
  if not tpl then
    return
  end
  local rewardList = _productsTpl:getRewardId(tpl)
  local reward = L_DataUtil.parseRewardConfigItem(rewardList[1])
  self:clearProductCombineLink()
  local node = {
    itemId = reward.itemId,
    itemType = reward.itemType,
    parentId = id,
    parentPageGuid = self._buildingGuid,
    fromBuildId = self._selectbuildingId
  }
  C_HomeUtil.Push_HomeProductCombineLink(node)
end

function this:onClick_combineLink(bind)
  local node = {
    itemId = bind.itemId,
    itemType = bind.itemType,
    parentId = bind.parentId,
    parentPageGuid = bind.parentPageGuid,
    fromBuildId = bind.fromBuildId
  }
  C_HomeUtil.Remove_HomeProductCombineLink(node, false)
  local lst = C_HomeUtil.ToList_HomeProductCombineLink()
  if lst ~= nil and lst.Count > 1 then
    self.parentTab = node
  else
    self.parentTab = nil
  end
  self._buildingGuid = bind.parentPageGuid
  self._combineLinkSelectItemId = bind.itemId
  self:refreshdata()
  self:initCombineLinkListView()
  self:freshCombineLinkListView(true)
  self.bindComponents.anim_pageProduct:PlayShow(function()
  end)
end

function this:pushHomeProductCombineLink()
  local data = self.parentTab
  if data == nil then
    return
  end
  local clone = table.clone(data)
  clone.parentPageGuid = self._buildingGuid
  clone.fromBuildId = self._selectbuildingId
  if clone.fromBuildId == nil then
    clone.fromBuildId = 0
  end
  C_HomeUtil.Push_HomeProductCombineLink(clone)
end

function this:removeProductCombineLink()
  local data = self.parentTab
  if not data then
    return
  end
  C_HomeUtil.Remove_HomeProductCombineLink(data, true)
end

function this:clearProductCombineLink()
  C_HomeUtil.Clear_HomeProductCombineLink()
end

function this:refreshPetStationedNum()
  self.bind.txt_petStationedNum = tostring(#L_HomeStore:getHomeHubStationedPetGuidList())
  self.bind.txt_petStationedTotal = "/" .. tostring(self:getUnlockedPetStationedNum())
end

function this:getUnlockedPetStationedNum()
  local unlockedPetStationedNum = 0
  local freeWorkPosId2UnlockConditionList = _homeFreeWorkPositionTpl:getFreeWorkPosId2UnlockConditionList()
  for freeWorkPositionId, unlockConditionList in pairs(freeWorkPosId2UnlockConditionList) do
    if L_ConditionManager:isComplete(unlockConditionList) and freeWorkPositionId > unlockedPetStationedNum then
      unlockedPetStationedNum = freeWorkPositionId
    end
  end
  return unlockedPetStationedNum
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

function this:setGamepadFocusModule(module)
  if self._currentGamepadFocusModule and self._currentGamepadFocusModule.setGamepadFocus then
    self._currentGamepadFocusModule:setGamepadFocus(false)
  end
  self._currentGamepadFocusModule = module
  if self._currentGamepadFocusModule and self._currentGamepadFocusModule.setGamepadFocus then
    self._currentGamepadFocusModule:setGamepadFocus(true)
  end
  self._navMgr.navigationEnabled = not self:isGamepadFocusOn(self.modules.module_productInfo)
  self.modules.moduleStationInfo:setGamepadShortCutEnable(not self:isGamepadFocusOn(self.modules.module_productInfo))
  self:refreshShortKeyFlag()
end

function this:isGamepadFocusOn(module)
  if self._currentGamepadFocusModule == module then
    return true
  end
  if self._currentGamepadFocusModule == nil and module == self.modules.module_productNormalNew then
    return true
  end
  return false
end

function this:getProductListModule()
  return self.modules.module_productNormalNew
end

function this:getProductListAreaName()
  local buildingType = self._buildingType or C_HomeUtil.GetBuildingType(self._buildingGuid)
  if buildingType == L_Const.WorldMapBuildType.WMBT_HATCH then
    return NavigationAreaNames.ProductListEgg
  end
  if self.modules.module_productNormalNew.listType == 2 then
    return NavigationAreaNames.ProductListCard
  end
  return NavigationAreaNames.ProductListNormal
end

function this:escHandleGamepadFocus()
  if not C_InputManager.IsEnableGamePad then
    return false
  end
  if self:isGamepadFocusOn(self.modules.module_productNormalNew) then
  elseif self:isGamepadFocusOn(self.modules.module_productInfo) then
    if self._navMgr.navigationEnabled then
      self._navMgr.navigationEnabled = false
      if self.modules.module_productInfo.refreshBottomShortCut then
        self.modules.module_productInfo:refreshBottomShortCut()
      end
    else
      self:setGamepadFocusModule(self.modules.module_productNormalNew)
      self._navMgr:SelectArea(self:getProductListAreaName())
    end
    return true
  else
    if self:isGamepadFocusOn(self.modules.module_productQueueNew) then
      self:setGamepadFocusModule(self.modules.module_productNormalNew)
      self._navMgr:SelectArea(self:getProductListAreaName())
      return true
    else
    end
  end
  return false
end

function this:registerShortCut()
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPageProductFocusProductQueue, function()
    if not self.isTop then
      return
    end
    if self.modules.module_productQueueNew:hasItemInQueue() then
      self:setGamepadFocusModule(self.modules.module_productQueueNew)
      self._navMgr:SelectArea(NavigationAreaNames.ProductQueue)
    end
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPageProductKiboManage, function()
    if not self.isTop then
      return
    end
    if not self:isGamepadFocusOn(self.modules.module_productInfo) then
      self.methods.onClick_petManageBtn(self)
    end
  end)
end

function this:unregisterShortCut()
  L_ShortCutManager:unregisterShortCut(self.pageName, C_InputManager_KeyType.EPageProductFocusProductQueue)
  L_ShortCutManager:unregisterShortCut(self.pageName, C_InputManager_KeyType.EPageProductKiboManage)
end

function this:refreshShortKeyFlag()
  L_ShortCutManager:removeShortKeyFlag(self, "UI_PageProductKiboManage")
  if not self:isGamepadFocusOn(self.modules.module_productInfo) then
    L_ShortCutManager:addShortKeyFlag(self, "UI_PageProductKiboManage", L_Const.AnchorType.Middle, self.bindComponents.rect_txtQuantity, L_Vector3.new(-80, 0))
  end
  if self:isGamepadFocusOn(self.modules.module_productNormalNew) then
    local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
    args.isLuaEvent = true
    local buildingType = self._buildingType or C_HomeUtil.GetBuildingType(self._buildingGuid)
    if buildingType == L_Const.WorldMapBuildType.WMBT_HATCH then
      args.luaTable = {
        moduleOrPageName = "pageProduct",
        changeGroupName = "GroupEgg"
      }
    else
      args.luaTable = {
        moduleOrPageName = "pageProduct",
        changeGroupName = "GroupCommon"
      }
    end
    C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
  end
end

function this:clearShortKeyFlag()
  L_ShortCutManager:clearShortKeyFlag(self)
end

return this
