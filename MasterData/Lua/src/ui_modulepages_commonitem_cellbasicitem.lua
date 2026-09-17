local this = class("cellBasicItem", G_UIModuleBase)

function this.bind()
  return {
    active_content = false,
    active_empty = false,
    img_qualityBg = "",
    img_qualityLine = "",
    active_qualityLine = false,
    txt_iconToggleName = "",
    iconToggleModule = {
      type = "toggleModule",
      moduleCommonContent = {
        assetName = "UI/CommonModules/moduleCommonContent",
        moduleName = "modulePages.CommonItem.moduleCommonContent"
      },
      moduleSoulEssenceContent = {
        assetName = "UI/CommonModules/moduleSoulEssenceContent",
        moduleName = "modulePages.CommonItem.moduleSoulEssenceContent"
      },
      modulePetContent = {
        assetName = "UI/CommonModules/modulePetContent",
        moduleName = "modulePages.CommonItem.modulePetContent"
      }
    },
    txt_topToggleName = "",
    topToggleModule = {
      type = "toggleModule",
      moduleTopContent = {
        assetName = "UI/CommonModules/moduleTopContent",
        moduleName = "modulePages.CommonItem.moduleTopContent"
      }
    },
    txt_bottomToggleName = "",
    bottomToggleModule = {
      type = "toggleModule",
      moduleBottomContent = {
        assetName = "UI/CommonModules/moduleBottomContent",
        moduleName = "modulePages.CommonItem.moduleBottomContent"
      }
    },
    txt_num = "",
    list_star = {},
    list_goldAccessoryStar = {},
    go_normalStar = false,
    go_goldSideAccessory = false,
    active_sel = false,
    active_using = false,
    txt_using = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self._callback then
        self._callback(self)
      end
      if not self._callback and not self._noTip then
        L_ItemTplManager:showInfoTip(self._itemType, self._itemId, self._guid)
      end
    end,
    onLongClick = function(self)
      if self._longPressCallback then
        self._longPressCallback(self)
      end
      if not self.bind.longPressCallback and not self._noTip then
        L_ItemTplManager:showInfoTip(self._itemType, self._itemId, self._guid)
      end
    end
  }
end

function this:open()
  self:refreshView()
end

function this:close()
  L_PhotoManager:clearPhotoEntity(self)
  if self.m_ReddotKey ~= "" then
    AzurWorld.RedDotMgr:UnRegistRedDot(self.m_ReddotKey)
  end
end

function this:refreshView()
  if not self.isBind then
    return
  end
  self.m_ReddotKey = ""
  self:setDataContent(self.bind)
end

function this:setDataContent(params)
  self._itemType = params.itemType
  self._itemId = params.itemId
  self._guid = params.guid
  self._callback = params.callback
  self._longPressCallback = params.longPressCallback
  self._noTip = params.noTip
  self._noReddot = params.noReddot
  if params.itemType == nil or params.itemId == nil then
    self:setContentActive(false)
    return
  else
    self:setContentActive(true)
  end
  if self._itemType == L_Const.resType.soulEssence then
    self.bind.txt_iconToggleName = "moduleSoulEssenceContent"
  elseif self._itemType == L_Const.resType.pet or self._itemType == L_Const.resType.petCustomized then
    self.bind.txt_iconToggleName = "modulePetContent"
  else
    self.bind.txt_iconToggleName = "moduleCommonContent"
  end
  local icon = params.icon
  if icon == nil then
    icon = L_ItemTplManager:getItemConfig(params.itemType, params.itemId).icon
  end
  local star = 0
  if params.itemType == L_Const.resType.soulEssence and self._guid then
    local soulEssenceData = C_SoulEssenceMgr:getsoulessenceItem(self._guid)
    if soulEssenceData then
      star = soulEssenceData.star
    end
  end
  self.modules.iconToggleModule[self.bind.txt_iconToggleName]:refreshView({
    icon = icon,
    filterIcon = params.filterIcon,
    star = star
  })
  local quality = L_ItemTplManager:getItemConfig(params.itemType, params.itemId).quality
  self.bind.img_qualityBg = string.format("UI/Atlas/CellIcon/tex_icon_raritybsqrtd_%s.png", quality)
  if params.qualityLineActive == nil or params.qualityLineActive == true then
    self.bind.active_qualityLine = true
  else
    self.bind.active_qualityLine = false
  end
  self.bind.img_qualityLine = string.format("UI/Atlas/CellIcon/tex_icon_raritybsqrt_%s.png", quality)
  if params.itemType ~= L_Const.resType.soulEssence and self._itemType ~= L_Const.resType.warehouse then
    local starNum = L_ItemTplManager:getItemShowStarNum(params.itemType, params.itemId)
    if params.itemType == L_Const.resType.accessory then
      self:setAccessoryToStars(starNum, params.bGoldSide)
    else
      self:setStars(starNum)
    end
  end
  self.bind.txt_num = tostring(self:formatItemNumText(params))
  local img_foodBuff = C_BagMgr:GetFoodBuff(self._itemId)
  if img_foodBuff ~= "" then
    self.bindComponents.ani_cellIconBag:Stop()
    self.bindComponents.ani_cellIconBag:Play("anim_cellicon_init")
  end
  if img_foodBuff ~= "" or self.bind.specialRarity ~= nil or self.bind.limit or self.bind.elementEffect then
    self.bind.txt_topToggleName = "moduleTopContent"
    self.modules.topToggleModule[self.bind.txt_topToggleName]:refreshView({
      img_foodBuff = img_foodBuff,
      specialRarity = params.specialRarity,
      elementEffect = params.elementEffect
    })
  else
    self.bind.txt_topToggleName = ""
  end
  local lock = false
  local wearHero = 0
  if params.itemType == L_Const.resType.accessory then
    lock = C_AccessoryMgr:getAccessory(params.guid).bLock
    wearHero = C_AccessoryMgr:getAccessory(params.guid).wearHero
  elseif params.itemType == L_Const.resType.soulEssence and params.guid then
    lock = C_SoulEssenceMgr:getsoulessenceItem(params.guid).bLock
    wearHero = C_SoulEssenceMgr:getsoulessenceItem(params.guid).wearHero
  end
  if lock or wearHero ~= 0 or params.limit or params.using then
    self.bind.txt_bottomToggleName = "moduleBottomContent"
    self.modules.bottomToggleModule[self.bind.txt_bottomToggleName]:refreshView({
      wearHero = params.wearHero,
      lock = lock,
      limit = params.limit,
      using = params.using
    })
  else
    self.bind.txt_bottomToggleName = ""
  end
  if self._noReddot then
    self.bindComponents.reddotNormal.gameObject:SetActive(false)
  elseif params.customReddotKey then
    L_ReddotManager:registerReddot(self.bindComponents.reddotNormal, params.customReddotKey)
  elseif params.itemType == L_Const.resType.soulEssence or params.itemType == L_Const.resType.accessory then
    self:refreshReddot(params)
  else
    self.bindComponents.reddotNormal.gameObject:SetActive(false)
  end
  if params.bSel ~= nil then
    self:setSel(params.bSel)
  end
end

function this:refreshReddot(params)
  self.m_ReddotKey = params.itemType == L_Const.resType.soulEssence and "SoulEssence_" .. L_PlayerStore:getPlayerId() .. "_" .. params.guid or "Accessory_" .. L_PlayerStore:getPlayerId() .. "_" .. params.guid
  AzurWorld.RedDotMgr:RegistRedDot(self.m_ReddotKey, nil, nil, function()
    return self:CheckBagRedDotNew()
  end, true)
  AzurWorld.RedDotMgr:BindRedDotRenderer(self.m_ReddotKey, self.bindComponents.reddotNormal.gameObject)
end

function this:CheckBagRedDotNew()
  return C_PlayerPrefsUtility.HasKey(self.m_ReddotKey) == false
end

function this:clearNew()
  if self.m_ReddotKey ~= "" then
    C_PlayerPrefsUtility.SetString(self.m_ReddotKey, "1")
    AzurWorld.RedDotMgr:RefreshRedDot(self.m_ReddotKey)
  end
end

function this:formatItemNumText(data)
  local res = ""
  if data.itemNum and data.itemNum ~= "" and data.itemNum ~= 0 then
    res = data.itemNum
  elseif data.itemType == L_Const.resType.commonItem then
    res = C_BagMgr:getItemNumByItemId(self._itemId)
  elseif data.itemType == L_Const.resType.accessory then
    local level = C_AccessoryMgr:getAccessory(self._guid).level
    res = "+" .. level
  elseif data.itemType == L_Const.resType.soulEssence then
    local level = self._guid and C_SoulEssenceMgr:getsoulessenceItem(self._guid).level or 1
    res = "LV" .. level
  elseif data.itemType == L_Const.resType.petEgg then
    res = 1
  elseif data.itemType == L_Const.resType.taskItem then
    res = AzurWorld.TaskMgr:GetTaskUIModule():GetTaskPropNum(data.itemId)
  elseif data.itemType == L_Const.resType.petSkin then
    local C_HomeManager = AzurWorld.HomeMgr
    local C_PetStore = C_HomeManager:GetPetStore()
    local hasPetSkin = C_PetStore:HasPetSkin(data.itemId)
    res = hasPetSkin and 1 or 0
  elseif data.itemType == L_Const.resType.homeDormItem then
    res = 0
  else
    res = C_BagMgr:getItemNumByItemId(data.itemId)
  end
  return res
end

function this:checkBottomModuleIsAdd()
  if self.bind.txt_bottomToggleName == "" then
    self.bind.txt_bottomToggleName = "moduleBottomContent"
  end
end

function this:checkTopModuleIsAdd()
  if self.bind.txt_topToggleName == "" then
    self.bind.txt_topToggleName = "moduleTopContent"
  end
end

function this:setLockState(lock)
  self:checkBottomModuleIsAdd()
  self.modules.bottomToggleModule[self.bind.txt_bottomToggleName]:refreshLock(lock)
end

function this:setOwnerActive(isActive, heroGuid)
  self:checkBottomModuleIsAdd()
  if isActive then
    self.modules.bottomToggleModule[self.bind.txt_bottomToggleName]:refreshOwner(heroGuid)
  else
    self.modules.bottomToggleModule[self.bind.txt_bottomToggleName]:refreshOwner(nil)
  end
end

function this:setBuffActive(intensifyType)
  self._intensity = intensifyType
  self:checkBottomModuleIsAdd()
  self.modules.topToggleModule[self.bind.txt_topToggleName]:refreshEleEffect(intensifyType)
end

function this:setScanUsingState(configId, content, bUsing)
  if not self.modules or not self.modules.bottomToggleModule then
    return
  end
  self:checkBottomModuleIsAdd()
  if configId == self._itemId then
    self.modules.bottomToggleModule[self.bind.txt_bottomToggleName]:refreshUsing(bUsing)
  else
    self.modules.bottomToggleModule[self.bind.txt_bottomToggleName]:refreshUsing(false)
  end
end

function this:setAccessoryToStars(starNum, bGoldSide)
  if bGoldSide then
    self:setGoldAccessoryStars(starNum)
  else
    self:setStars(starNum)
  end
end

function this:setSel(active)
  if not self.isBind then
    return
  end
  if self.bind.active_sel ~= active then
    self.bind.active_sel = active
  end
  if active then
    self:clearNew()
  end
end

function this:setContentActive(active)
  self.bind.active_content = active
  self.bind.active_empty = not active
end

function this:setQualityLineActive(active)
  self.bind.active_qualityLine = active
end

function this:setNumInfo(itemNum)
  if not self.isBind then
    return
  end
  self.bind.txt_num = tostring(itemNum)
end

function this:setStars(num)
  if not self.isBind then
    return
  end
  self.bind.go_normalStar = true
  self.bind.go_goldSideAccessory = false
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(stars)
end

function this:setGoldAccessoryStars(num)
  if not self.isBind then
    return
  end
  self.bind.go_normalStar = false
  self.bind.go_goldSideAccessory = true
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.list_goldAccessoryStar:clear()
  self.bind.list_goldAccessoryStar:insert_array(stars)
end

function this:getRaycastGo()
  if self.isBind then
    return self.bindComponents.btn_img_qualityBg.gameObject
  end
end

function this:playFx(name)
  if not self.isBind then
    return
  end
  self.bindComponents.ani_cellIconBag:Stop()
  self.bindComponents.ani_cellIconBag:Play(name)
end

function this:getItemId()
  return self._itemId
end

return this
