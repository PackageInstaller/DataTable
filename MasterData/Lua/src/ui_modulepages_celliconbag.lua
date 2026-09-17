local this = class("cellIcon", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _medicineTpl = L_GameTpl:getMedicineTpl()
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local accessoryCustomedTpl = L_GameTpl:getAccessoryCustomedTpl()
local GuidType2Func = {
  [L_Const.resType.commonItem] = "setCommonItemDataContent",
  [L_Const.resType.soulEssence] = "setSoulEssenceDataContent",
  [L_Const.resType.accessory] = "setAccessoryDataContent",
  [L_Const.resType.taskItem] = "setTaskItemDataContent",
  [L_Const.resType.petEgg] = "setPetEggDataContent",
  [L_Const.resType.collectionTool] = "setCollectionToolDataContent"
}

function this.bind()
  return {
    active_content = false,
    active_empty = false,
    img_qualityBg = "",
    img_qualityLine = "",
    active_qualityLine = false,
    active_icon = false,
    img_icon = "",
    img_iconFilter = "",
    go_soulessenceIcon = false,
    img_soulessenceIcon = "",
    active_rectPet = false,
    img_petIcon = "",
    active_foodBuff = false,
    img_foodBuff = "",
    txt_level = "",
    txt_num = "",
    active_sel = false,
    active_hasobtain = false,
    active_lock = false,
    active_owner = false,
    img_owner = "",
    list_star = {
      moduleName = "modulePages/cellIconBagStarUnit"
    },
    list_soulessenceStar = {},
    list_goldAccessoryStar = {},
    go_normalStar = false,
    go_soulEssenceStar = false,
    go_goldSideAccessory = false,
    active_light = false,
    active_intensify = false,
    active_weaken = false,
    alpha_content = 1,
    active_using = false,
    txt_using = "",
    enable_content = false,
    active_emptyStar = false,
    active_weaponContent = false,
    active_element = false,
    active_position = false,
    active_quality = false,
    img_elementIcon = "",
    img_positionIcon = "",
    img_qualityIcon = "",
    txt_qualityContent = "",
    list_emptyStar = {}
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.callback then
        self.bind.callback(self)
        return
      end
      if not self.bind.callback and not self.noTip then
        L_ItemTplManager:showInfoTip(self._itemType, self._itemId, self._guid, nil, self._notShowAccess)
      end
    end,
    onLongClick = function(self)
      if self.bind.longPressCallback then
        self.bind.longPressCallback(self)
      end
      if not self.bind.longPressCallback and not self.noTip then
        L_ItemTplManager:showInfoTip(self._itemType, self._itemId, self._guid)
      end
    end
  }
end

function this:open()
  self:refreshView()
  if self._warningReddotKey and not self.bind.noReddot then
    self:registerReddot(self.bindComponents.rect_reddot, string.format(self._warningReddotKey, self._warningReddotId))
  else
    self.bindComponents.rect_reddot.gameObject:SetActive(false)
  end
  if self._newReddotKey then
    self:registerReddot(self.bindComponents.reddotNew, string.format(self._newReddotKey, self._newReddotId))
  else
    self.bindComponents.reddotNew.gameObject:SetActive(false)
  end
  self.isSelected = false
  self.bind.enable_content = not self.disable_content
end

function this:close()
  L_PhotoManager:clearPhotoEntity(self)
end

function this:refresh()
  self:refreshView()
end

function this:refreshView()
  if not self.isBind then
    return
  end
  self._itemType = self._itemType or self.bind.itemType
  self._itemId = self._itemId or self.bind.itemId
  self._guid = self._guid or self.bind.guid
  self._notShowAccess = self._notShowAccess or self.bind.notShowAccess or self:GetSourceLuaPageOptions("notShowAccess") or self:GetSourceLuaPageOptions("failure_jump")
  self.noTip = self.noTip or self.bind.noTip
  if not self._itemType then
    self:setContentActive(false)
    return
  end
  self:setDataContent(self._itemType, self._guid, self._itemId, self.bind)
  if self.bind.active_sel then
    self:clearNew()
  end
  self:setReceiveActive(self.bind.isReceived)
  self:setScanUsingState()
end

function this:setScanUsingState()
  local id = C_BagMgr:getScanUsingItemId()
  if id == 0 or id == nil then
    return
  end
  self:getCurrenItemUseType(id, L_GameTpl:getWordsTpl():getTplById("ui_lens_working"))
end

function this:setDataContent(itemType, guid, itemId, params)
  if not math.isEmpty(guid) and self[GuidType2Func[itemType]] then
    self._guid = guid
    self._itemId = itemId
    self._itemType = itemType
    self:setContentActive(true)
    self[GuidType2Func[itemType]](self, guid, params)
  else
    self:setGeneralContent(itemType, itemId, params)
  end
end

function this:setGeneralContent(itemType, itemId, params)
  params = params or {}
  self._itemType = itemType
  self._itemId = itemId
  self.bind.index = params.index
  self.noTip = params.noTip
  self:setContentActive(self._itemId ~= nil)
  if self._itemId == nil then
    return
  end
  local isUnstackable = false
  if self._itemType == L_Const.resType.commonItem then
    local tpl = _commonItemTpl:getTplById(itemId)
    if tpl then
      isUnstackable = _commonItemTpl:getStackNum(tpl) == 1
    end
  end
  self.bind.txt_num = not params.itemNumTxt and params.itemNum and L_GameUtil.itemShowNum(params.itemNum)
  local conf = L_ItemTplManager:getItemConfig(itemType, itemId)
  if params.notShowAccess ~= nil then
    self._notShowAccess = params.notShowAccess
  end
  if params.bShowName then
    self.bind.txt_num = conf.name
  end
  self:SetMainIcon(itemType, conf, params)
  local quality = conf.quality or params.quality or 0
  self.bind.img_qualityBg = string.format("UI/Atlas/CellIcon/tex_icon_raritybsqrtd_%s.png", quality)
  self:setQualityLineActive(true)
  self.bind.img_qualityLine = string.format("UI/Atlas/CellIcon/tex_icon_raritybsqrt_%s.png", quality)
  if self._itemType == L_Const.resType.accessory then
    self.bind.txt_level = string.concat("+", params.level or 0)
  end
  if params.isBasicItem then
    self:SetBasicItem(params)
  elseif self._itemType ~= L_Const.resType.soulEssence and self._itemType ~= L_Const.resType.warehouse then
    local starNum = 0
    local maxNum
    if self._itemType == L_Const.resType.accessory or self._itemType == L_Const.resType.customAccessory then
      local accId = self._itemType == L_Const.resType.customAccessory and accessoryCustomedTpl:getAccessoryIdById(self._itemId) or self._itemId
      local conf = L_ItemTplManager:getItemConfig(L_Const.resType.accessory, accId)
      if self._guid then
        local serverData = C_AccessoryMgr:getAccessory(self._guid)
        starNum = serverData and serverData.grade or 0
      end
      local upgradeConfig = C_AccessoryMgr:getAccessoryUpgradeConfig(conf.quality, starNum + 1)
      maxNum = upgradeConfig.maxGrade
    else
      starNum = L_ItemTplManager:getItemShowStarNum(self._itemType, self._itemId)
    end
    if self._itemType == L_Const.resType.customAccessory and self._bGoldSide then
      self:setAccessoryToStars(accessoryCustomedTpl:getAccessoryIdById(self._itemId), starNum, true)
    elseif self._itemType == L_Const.resType.accessory and self._bGoldSide then
      self:setAccessoryToStars(self._itemId, starNum, true)
    else
      self:setStars(starNum, maxNum)
    end
  end
  if self.bind.lock and self.bind.lock == true then
    self.bind.active_lock = true
  else
    self.bind.active_lock = false
  end
  self.bind.callback = params.callback
  self.bind.longPressCallback = params.longPressCallback
  self.bind.noTip = params.noTip
end

function this:SetBasicItem(params)
  if params.accessoryWearData == nil or params.accessoryWearData == {} then
    return
  end
  self.bind.active_emptyStar = false
  self.bind.active_weaponContent = true
  local num = params.accessoryWearData.starNum or 0
  local maxNum = math.max(params.accessoryWearData.maxStarNum or 0, num)
  if params.accessoryWearData.elementIcon ~= nil then
    self.bind.img_elementIcon = params.accessoryWearData.elementIcon
  end
  if params.accessoryWearData.positionIcon ~= nil then
    self.bind.img_positionIcon = params.accessoryWearData.positionIcon
  end
  if params.accessoryWearData.accessoryQualityIcon ~= nil then
    self.bind.img_qualityIcon = params.accessoryWearData.accessoryQualityIcon
    self.bind.txt_qualityContent = params.accessoryWearData.txtQuality
  end
  self.bind.active_quality = params.accessoryWearData.accessoryQualityIcon ~= nil
  self.bind.active_position = params.accessoryWearData.positionIcon ~= nil
  self.bind.active_element = params.accessoryWearData.elementIcon ~= nil
  self.bind.list_emptyStar:clear()
  self:setStars(num, maxNum)
end

function this:SetMainIcon(itemType, conf, params)
  if not self.bindComponents then
    return
  end
  self.bind.active_icon = false
  self.bind.go_soulessenceIcon = false
  self.bind.active_rectPet = false
  if not self.imgIconSize then
    self.imgIconSize = self.bindComponents.img_icon.sizeDelta
  end
  self.bindComponents.img_icon.sizeDelta = self.imgIconSize
  if itemType == L_Const.resType.soulEssence then
    self.bind.go_soulessenceIcon = true
    self.bind.img_soulessenceIcon = conf.icon
  elseif itemType == L_Const.resType.pet or itemType == L_Const.resType.petCustomized then
    self.bind.active_rectPet = true
    self.bind.img_petIcon = conf.icon
  else
    self.bind.active_icon = true
    if itemType == L_Const.resType.hero then
      self.bindComponents.img_icon.sizeDelta = C_Vector2(200, 200)
      self.bind.img_icon = conf.icon_mid
    elseif itemType == L_Const.resType.accessory then
      local serverData = C_AccessoryMgr:getAccessory(params.guid)
      if serverData ~= nil and serverData.quality == 5 then
        local conf = L_ItemTplManager:getItemConfig(L_Const.resType.accessory, serverData.accessoryId)
        local path = conf.icon
        self.bind.img_icon = path:gsub("%.png$", "_G.png")
      else
        self.bind.img_icon = conf.icon or params.icon
      end
    else
      self.bind.img_icon = conf.icon or params.icon
    end
  end
  local img_iconFilter = ""
  if params and params.customIcon then
    self.bind.img_icon = params.customIcon
  elseif itemType == L_Const.resType.commonItem or itemType == L_Const.resType.warehouse then
    local commonItemTpl = _commonItemTpl:getTplById(self._itemId)
    img_iconFilter = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
  end
  self.bind.img_iconFilter = img_iconFilter
  if params.blight then
    self.bind.active_light = true
  else
    self.bind.active_light = false
  end
end

function this:setCommonItemDataContent(guid, params)
  local itemData = C_BagMgr:getItem(guid)
  if itemData then
    params.itemNum = C_BagMgr:GetItemNumByGuid(guid)
    local tpl = _commonItemTpl:getTplById(guid)
    if _commonItemTpl:getType(tpl) == L_BagConst.bagItemType.food then
      local tpl_food = _foodTpl:getTplById(guid)
      self.bind.active_foodBuff = true
      self.bind.img_foodBuff = string.format("UI/Atlas/FoodType/tex_icon_foodtype_tag_0%s.png", _foodTpl:getFoodType(tpl_food))
      self.bindComponents.ani_cellIconBag:Stop()
      self.bindComponents.ani_cellIconBag:Play("anim_cellicon_init")
    elseif _commonItemTpl:getType(tpl) == L_BagConst.bagItemType.potion then
      local tpl_potion = _medicineTpl:getTplById(guid)
      if tpl_potion then
        self.bind.active_foodBuff = true
        self.bind.img_foodBuff = string.format("UI/Atlas/MedicineType/tex_icon_medicineType_tag_0%s.png", _medicineTpl:getMedicineType(tpl_potion))
        self.bindComponents.ani_cellIconBag:Stop()
        self.bindComponents.ani_cellIconBag:Play("anim_cellicon_init")
      else
        warn("背包物品药剂，缺少的配置信息:" .. guid)
      end
    end
    self:setGeneralContent(L_Const.resType.commonItem, guid, params)
  end
end

function this:setSoulEssenceDataContent(guid, params)
  params = params or {}
  self._warningReddotKey = L_ReddotManager.DotDef.SpiritNew
  self._warningReddotId = guid
  local serverData = C_SoulEssenceMgr:getsoulessenceItem(guid)
  if serverData then
    self:setGeneralContent(L_Const.resType.soulEssence, serverData.soulEssenceId, params)
    self:setSpiritStars(serverData.star - 1)
    self.bind.txt_num = ""
    self.bind.txt_level = string.concat("LV", serverData.level)
    self.bind.active_lock = serverData.bLock
    local isEquipped = not math.isEmpty(serverData.wearHero)
    self.bind.active_owner = isEquipped
    if isEquipped then
      local heroData = L_HeroStore:getHero(serverData.wearHero)
      if heroData then
        local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroData))
        self.bind.img_owner = heroConf.icon_small
        if heroData.type == L_Const.HeroType.HT_MAIN then
          L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.rect_img_owner, L_PlayerStore:getPlayerModHeadImgName())
        else
          L_PhotoManager:clearPhotoEntity(self)
        end
      end
    end
  end
end

function this:setAccessoryDataContent(guid, params)
  params = params or {}
  if not guid then
    self:setContentActive(false)
    return
  end
  self._warningReddotId = guid
  self._warningReddotKey = L_ReddotManager.DotDef.JewelNew
  local serverData = C_AccessoryMgr:getAccessory(guid)
  if serverData then
    self._bGoldSide = serverData.quality == 5
    self:setGeneralContent(L_Const.resType.accessory, serverData.accessoryId, params)
    self.bind.txt_level = string.concat("+", serverData.level)
    self.bind.txt_num = ""
    self.bind.active_lock = serverData.bLock
    local isEquipped = not math.isEmpty(serverData.wearHero)
    self.bind.active_owner = isEquipped
    if isEquipped then
      local heroData = L_HeroStore:getHero(serverData.wearHero)
      if heroData then
        local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroData))
        self.bind.img_owner = heroConf.icon_small
        if heroData.type == L_Const.HeroType.HT_MAIN then
          L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.rect_img_owner, L_PlayerStore:getPlayerModHeadImgName())
        else
          L_PhotoManager:clearPhotoEntity(self)
        end
      end
    end
    if serverData.quality == 5 then
      local conf = L_ItemTplManager:getItemConfig(L_Const.resType.accessory, serverData.accessoryId)
      local quality = conf.quality or params.quality or 0
      local starNum = serverData.grade
      self:setGoldAccessoryStars(starNum)
      local conf = L_ItemTplManager:getItemConfig(L_Const.resType.accessory, serverData.accessoryId)
      local path = conf.icon
      self.bind.img_icon = path:gsub("%.png$", "_G.png")
    end
  end
end

function this:setTaskItemDataContent(guid, params)
  params = params or {}
  self._itemType = L_Const.resType.taskItem
  self._guid = guid
  self:setContentActive(true)
  local itemNum = AzurWorld.TaskMgr:GetTaskUIModule():GetTaskPropNum(guid)
  if 0 < itemNum then
    params.itemNum = itemNum
    self:setGeneralContent(L_Const.resType.taskItem, guid, params)
  end
end

function this:setPetEggDataContent(guid, params)
  params = params or {}
  self._itemType = L_Const.resType.petEgg
  self._guid = guid
  self:setContentActive(true)
  local serverData = L_PetStore:getPetEggItem(guid)
  if serverData then
    params.itemNum = 1
    self:setGeneralContent(L_Const.resType.petEgg, serverData.configId, params)
  end
end

function this:setCollectionToolDataContent(itemId, params)
  self._itemType = L_Const.resType.collectionTool
  self._guid = itemId
  self:setContentActive(true)
  self:setGeneralContent(L_Const.resType.collectionTool, itemId, params)
end

function this:setAccessoryToLock(lock)
  if self.isBind then
    self.bind.active_lock = lock
  end
end

function this:setAccessoryToStars(accessoryId, starNum, bGoldSide)
  local conf = L_ItemTplManager:getItemConfig(L_Const.resType.accessory, accessoryId)
  if bGoldSide then
    local quality = conf.quality or 0
    self:setGoldAccessoryStars(starNum)
    local conf = L_ItemTplManager:getItemConfig(L_Const.resType.accessory, accessoryId)
    local path = conf.icon
    self:SetMainIcon(L_Const.resType.accessory, {
      icon = path:gsub("%.png$", "_G.png")
    }, {})
  else
    self:setStars(starNum)
  end
end

function this:setSel(active)
  if self.bind.active_sel ~= active then
    self.bind.active_sel = active
  end
  if active then
    self:clearNew()
  end
  self.isSelected = active
end

function this:setContentIsDisable(disable)
  self.disable_content = disable
  self.bind.enable_content = not self.disable_content
end

function this:setContentActive(active)
  self.bind.active_content = active
  self.bind.active_empty = not active
end

function this:setQualityLineActive(active)
  self.bind.active_qualityLine = active
end

function this:setReceiveActive(active)
  self.bind.active_hasobtain = active and active or false
end

function this:setNumInfo(itemNum)
  if not self.isBind then
    return
  end
  self.bind.txt_num = tostring(itemNum)
end

function this:setOwnerActive(isActive)
  self.bind.active_owner = isActive
end

function this:setStars(num, maxNum)
  if not self.isBind then
    return
  end
  self.bind.go_normalStar = true
  self.bind.go_soulEssenceStar = false
  self.bind.go_goldSideAccessory = false
  local stars = {}
  local total = maxNum or num
  for i = 1, total do
    table.insert(stars, {
      isActiveStar = i <= num
    })
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(stars)
end

function this:setSpiritStars(num)
  if not self.isBind then
    return
  end
  self.bind.go_normalStar = false
  self.bind.go_soulEssenceStar = true
  self.bind.go_goldSideAccessory = false
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.list_soulessenceStar:clear()
  self.bind.list_soulessenceStar:insert_array(stars)
end

function this:setGoldAccessoryStars(num)
  if not self.isBind then
    return
  end
  self.bind.go_normalStar = false
  self.bind.go_soulEssenceStar = false
  self.bind.go_goldSideAccessory = true
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.list_goldAccessoryStar:clear()
  self.bind.list_goldAccessoryStar:insert_array(stars)
end

function this:setBuffActive(intensifyType)
  if intensifyType == 0 then
    self.bind.active_intensify = false
    self.bind.active_weaken = false
  elseif intensifyType == 1 then
    self.bind.active_intensify = true
    self.bind.active_weaken = false
  elseif intensifyType == 2 then
    self.bind.active_intensify = false
    self.bind.active_weaken = true
  end
end

function this:clearNew()
  if self._warningReddotKey and self._warningReddotId then
    L_ReddotManager:clearNew(self._warningReddotKey, self._warningReddotId)
  end
end

function this:getRaycastGo()
  if self.isBind then
    return self.bindComponents.btn_img_qualityBg.gameObject
  end
end

function this:getCurrenItemUseType(configId, content)
  if configId == self._itemId then
    self.bind.active_using = true
    self.bind.txt_using = content
    return true
  end
  self.bind.active_using = false
  return false
end

function this:playFx(name)
  if not self.isBind then
    return
  end
  self.bindComponents.ani_cellIconBag:Stop()
  self.bindComponents.ani_cellIconBag:Play(name)
end

function this:checkIsSelected()
  return self.isSelected
end

function this:getId()
  return self._itemId
end

function this:setAlpha(value)
  local canvasGrp = self.gameObject.transform:GetComponent(typeof(C_CanvasGroup))
  canvasGrp.alpha = value
end

function this:doClickAction()
  self.methods.onClick(self)
end

local QualityLevelPaths = {
  [3] = "Assets/Arts/UI/Icon/HomeCollectionIcon/tex_home_collection_bg_tapbule.png",
  [4] = "Assets/Arts/UI/Icon/HomeCollectionIcon/tex_home_collection_bg_tappurple.png",
  [5] = "Assets/Arts/UI/Icon/HomeCollectionIcon/tex_home_collection_bg_tapyellow.png"
}

function this:setQualityLevel(quality)
  if not self.bindComponents.img_qualityLevel then
    return
  end
  local qualityIcon = QualityLevelPaths[quality]
  if not qualityIcon then
    return
  end
  self.bindComponents.img_qualityLevel = qualityIcon
end

return this
