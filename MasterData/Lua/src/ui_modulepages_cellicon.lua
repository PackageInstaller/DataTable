local this = class("cellIcon", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self._selectedNum = 0
end

function this.bind()
  return {
    imageIcon = "",
    go_imgIcon = false,
    go_soulessenceImgIcon = false,
    img_soulessenceIcon = nil,
    go_rectPet = false,
    img_petIcon = nil,
    imageColor = "",
    textNum = "",
    img_qualityBg = nil,
    activeSelect = false,
    activeSelectNum = false,
    textSelectNum = "",
    activeReduce = true,
    listStar = {},
    activeLock = false,
    textLevel = "",
    activeHead = false,
    imageHead = "",
    activeRode = false,
    classIcon = "",
    activeClassIcon = false,
    activeDisable = false,
    activeReward = false,
    activeEquip = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.activeDisable then
        return
      end
      if self._reddotKey and self._reddotId then
        L_ReddotManager:clearNew(self._reddotKey, self._reddotId)
      end
      if self._selectMode then
        self._selectedNum = self._selectedNum or 0
        if not self.bind.mutiSelect then
          self:setSelectNum(1 - self._selectedNum)
        else
          self:setSelectNum(self._selectedNum + 1)
        end
      end
      if self._callback then
        self._callback(self)
      end
      if not self._selectMode and not self._callback and not self._noTip then
        L_ItemTplManager:showInfoTip(self._itemType, self._itemId, self._guid)
      end
    end,
    onClickReduce = function(self)
      if self.bind.activeDisable then
        return
      end
      self:setSelectNum(self._selectedNum - 1)
    end,
    onLongPress = function(self)
      if self.bind.activeDisable then
        return
      end
      if (self._callback or self._selectMode) and not self._noTip then
        L_ItemTplManager:showInfoTip(self._itemType, self._itemId, self._guid)
      end
    end
  }
end

function this:open()
  this.super.open(self)
  self:refreshView()
end

function this:refreshView()
  if not self.isBind then
    return
  end
  self._itemType = self._itemType or self.bind.itemType
  self._itemId = self._itemId or self.bind.itemId
  self._guid = self._guid or self.bind.guid
  if not self._itemType then
    return
  end
  self.bind.itemNum = self.bind.itemNum or 1
  if not math.isEmpty(self._guid) then
    self:setDataContent(self._itemType, self._guid, self.bind)
  else
    self:setGeneralContent(self._itemType, self._itemId, self.bind)
  end
end

function this:close()
  L_PhotoManager:clearPhotoEntity(self)
end

function this:setGeneralContent(itemType, itemId, params)
  params = params or {}
  self._itemType = itemType
  self._itemId = itemId
  self.bind.itemNum = params.itemNum
  self.bind.textNum = params.itemNumTxt or params.itemNum and params.itemNum > 1 and tostring(params.itemNum) or ""
  local conf = L_ItemTplManager:getItemConfig(itemType, itemId)
  self:setTargetItemImgByItemTypeAndItemConfig(itemType, conf)
  self.bind.imageColor = conf.quality and L_RarityTpl:getIconByType(conf.quality, L_Const.qualityPathType.cell) or ""
  self.bind.img_qualityBg = string.format("UI/Atlas/CellIcon/tex_icon_raritysqrtd_%s.png", conf.quality or 0)
  self.bind.activeReduce = params.mutiSelect == true
  self._callback = params.callback
  self._selectCallback = params.selectCallback
  self._selectMode = params.selectMode or params.selectCallback ~= nil
  self._validateSelectFunc = params.validateSelectFunc
  self._noTip = params.noTip
  if itemType == L_Const.resType.hero then
    if params.headUrl then
      L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.ImageIcon, params.headUrl)
    elseif self._itemId == L_GameUtil.getDefaultHeroId() then
      L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.ImageIcon, L_PlayerStore:getPlayerModHeadImgName())
    else
      L_PhotoManager:clearPhotoEntity(self)
    end
  elseif itemType == L_Const.resType.stargift then
    local tpl = L_GameTpl:getStargiftTpl():getTplById(itemId)
    self.bind.classIcon = L_GameTpl:getStargiftTpl():getClassIcon(tpl)
    self.bind.activeClassIcon = true
  end
  self.bind.activeReward = params.activeReward
  self.bind.activeEquip = params.activeEquip
  if params.showLevel then
    self.bind.textLevel = "LV" .. params.showLevel
  end
  if params.showStar then
    self:_setStars(params.showStar)
  else
    self:_setStars(L_ItemTplManager:getItemShowStarNum(itemType, itemId))
  end
  if not self.isBind then
    return
  end
  if self._reddotKey then
    self:registerReddot(self.bindComponents.reddotNew, string.format(self._reddotKey, self._reddotId))
  else
    self.bindComponents.reddotNew.gameObject:SetActive(false)
  end
end

function this:setTargetItemImgByItemTypeAndItemConfig(itemType, conf)
  self.bind.go_imgIcon = false
  self.bind.go_soulessenceImgIcon = false
  self.bind.go_rectPet = false
  local isSoulEssence = itemType == L_Const.resType.soulEssence
  local isPet = itemType == L_Const.resType.pet
  if isSoulEssence then
    self.bind.go_soulessenceImgIcon = true
    self.bind.img_soulessenceIcon = conf.icon
  elseif isPet then
    self.bind.go_rectPet = true
    self.bind.img_petIcon = conf.icon
  else
    self.bind.go_imgIcon = true
    self.bind.imageIcon = conf.icon
  end
end

local GuidType2Func = {
  [L_Const.resType.commonItem] = "setCommonItemDataContent",
  [L_Const.resType.hero] = "setHeroDataContent",
  [L_Const.resType.soulEssence] = "setSoulEssenceDataContent",
  [L_Const.resType.accessory] = "setJewelDataContent",
  [L_Const.resType.pet] = "setPetDataContent",
  [L_Const.resType.collectionTool] = "setCollectionToolDataContent",
  [L_Const.resType.petSkin] = "setPetSkinDataContent",
  [L_Const.resType.homeDormItem] = "setHomeDormItemDataContent"
}

function this:setDataContent(itemType, guid, params)
  if self[GuidType2Func[itemType]] then
    self[GuidType2Func[itemType]](self, guid, params)
  else
    errorf("类型" .. itemType .. "不支持数据显示 请不要传入guid")
  end
end

function this:setCommonItemDataContent(guid, params)
  params = params or {}
  self._guid = guid
  local itemData = C_BagMgr:getItem(guid)
  if itemData then
    params.itemNum = itemData.itemNum
    self:setGeneralContent(L_Const.resType.commonItem, guid, params)
  end
end

function this:setHeroDataContent(guid, params)
  self._guid = guid
  local heroData = L_HeroStore:getHero(guid)
  if heroData then
    self:setGeneralContent(L_Const.resType.hero, L_HeroStore:getHeroConfigId(heroData), params)
    self.bind.textLevel = "LV" .. L_HeroStore:getHeroLevel(heroData)
    self.bind.activeLock = false
    self.bind.activeHead = false
  end
end

function this:setSoulEssenceDataContent(guid, params)
  params = params or {}
  self._guid = guid
  self._reddotKey = L_ReddotManager.DotDef.SpiritNew
  self._reddotId = guid
  local soulEssenceData = C_SoulEssenceMgr:getsoulessenceItem(guid)
  if soulEssenceData then
    self:setGeneralContent(L_Const.resType.soulEssence, soulEssenceData.soulEssenceId, params)
    self.bind.textLevel = "LV" .. soulEssenceData.level
    self.bind.activeLock = soulEssenceData.bLock
    if not math.isEmpty(soulEssenceData.wearHero) and not params.activeEquip then
      self.bind.activeHead = true
      local heroData = L_HeroStore:getHero(soulEssenceData.wearHero)
      if heroData then
        local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroData))
        self.bind.imageHead = heroConf.icon
        if heroData.type == L_Const.HeroType.HT_MAIN then
          L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.ImageHead, L_PlayerStore:getPlayerModHeadImgName())
        else
          L_PhotoManager:clearPhotoEntity(self)
        end
      end
    else
      self.bind.activeHead = false
    end
  end
end

function this:setJewelDataContent(guid, params)
  params = params or {}
  self._itemType = L_Const.resType.accessory
  self._guid = guid
  self._reddotId = guid
  self._reddotKey = L_ReddotManager.DotDef.JewelNew
  local jewelData = C_AccessoryMgr:getAccessory(guid)
  if jewelData then
    self:setGeneralContent(L_Const.resType.accessory, jewelData.accessoryId, params)
    self.bind.textLevel = C_AccessoryMgr:getShowLevelTxt(jewelData)
    self.bind.activeLock = jewelData.lock
    if not math.isEmpty(jewelData.wearHero) and not params.activeEquip then
      self.bind.activeHead = true
      local heroData = L_HeroStore:getHero(jewelData.wearHero)
      if heroData then
        local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroData))
        self.bind.imageHead = heroConf.icon
        if heroData.type == L_Const.HeroType.HT_MAIN then
          L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.ImageHead, L_PlayerStore:getPlayerModHeadImgName())
        else
          L_PhotoManager:clearPhotoEntity(self)
        end
      end
    else
      self.bind.activeHead = false
    end
  end
end

function this:setPetDataContent(guid, params)
  params = params or {}
  self._guid = guid
  self._reddotKey = L_ReddotManager.DotDef.PetNew
  self._reddotId = guid
  local petData = L_PetStore:getPetItem(guid)
  if petData then
    params.rank = petData.rank
    self:setGeneralContent(L_Const.resType.pet, petData.id, params)
    self.bind.textLevel = "LV" .. petData.lv
    self.bind.activeLock = false
    if not math.isEmpty(petData.hero_id) and not params.activeEquip then
      self.bind.activeHead = true
      local heroData = L_HeroStore:getHero(petData.hero_id)
      local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroData))
      self.bind.imageHead = heroConf.icon
    else
      self.bind.activeHead = false
    end
  end
  if params and params.hideHead then
    self.bind.activeHead = false
  end
end

function this:setCollectionToolDataContent(itemId, params)
  self._itemType = L_Const.resType.collectionTool
  self._guid = itemId
  self:setContentActive(true)
  self:setGeneralContent(L_Const.resType.collectionTool, itemId, params)
end

function this:setPetSkinDataContent(guid, params)
  self._itemType = L_Const.resType.petSkin
  self._guid = guid
  self:setGeneralContent(L_Const.resType.petSkin, guid, params)
end

function this:setHomeDormItemDataContent(guid, params)
  self._itemType = L_Const.resType.homeDormItem
  self._guid = guid
  self:setGeneralContent(L_Const.resType.homeDormItem, guid, params)
end

function this:_setStars(num)
  if not self.isBind then
    return
  end
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.listStar:clear()
  self.bind.listStar:insert_array(stars)
end

local NoNumType = {
  [L_Const.resType.hero] = true,
  [L_Const.resType.soulEssence] = true,
  [L_Const.resType.accessory] = true,
  [L_Const.resType.pet] = true,
  [L_Const.resType.mount] = true
}

function this:updateSelectView()
  self._selectedNum = self._selectedNum or 0
  if not self.bind.mutiSelect then
    self.bind.activeSelectNum = false
    self._selectedNum = math.min(self._selectedNum, 1)
  else
    self.bind.activeSelectNum = not NoNumType[self._itemType]
    self._selectedNum = math.min(self._selectedNum, self.bind.itemNum or self._selectedNum)
  end
  self.bind.activeSelect = self._selectedNum > 0
  self.bind.textSelectNum = tostring(self._selectedNum)
  if self._selectCallback then
    self._selectCallback(self)
  end
end

function this:setSelectState(state)
  self._selectedNum = state and 1 or 0
  self:updateSelectView()
end

function this:getSelectState()
  return self._selectedNum and self._selectedNum > 0
end

function this:setSelectNum(num)
  if self._validateSelectFunc and not self._validateSelectFunc(self._selectedNum, num) then
    return
  end
  self._selectedNum = num
  self:updateSelectView()
end

function this:getSelectNum()
  return self._selectedNum or 0
end

function this:setDisable(state)
  self.bind.activeDisable = state
end

function this:setNum(itemNum)
  itemNum = itemNum or 1
  self.bind.itemNum = itemNum
  self.bind.textNum = 1 < itemNum and tostring(itemNum) or ""
end

return this
