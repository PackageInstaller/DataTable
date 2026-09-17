local this = class("pageInfoTip", G_UIPageBase)
local _currencyTpl = L_GameTpl:getCurrencyTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local _accessoryMainTpl = L_GameTpl:getAccessoryMainTpl()
local _soulessenceTpl = L_GameTpl:getSoulessenceTpl()
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local _soulessenceRankTpl = L_GameTpl:getSoulessenceRankTpl()
local _taskItemTpl = L_GameTpl:getTaskItemTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _mountSaddleTpl = L_GameTpl:getMountSaddleTpl()
local _collectionToolTpl = L_GameTpl:getCollectionToolTpl()
local _playerDressTpl = L_GameTpl:getPlayercardDressTpl()
local _playerTitleTpl = L_GameTpl:getPlayerTitleTpl()
local _petEggTpl = L_GameTpl:getPetEggTpl()
local _petFeedItemTpl = L_GameTpl:getPetFeedItemTpl()
local _petSkinTpl = L_GameTpl:getPetSkinTpl()
local clothTpl = L_GameTpl:getClothItemTpl()
local heroClothTpl = L_GameTpl:getHeroClothingTpl()
local homeDormItemTpl = L_GameTpl:getHomeDormItemTpl()
local chatEmojiTpl = L_GameTpl:getChatEmojiTpl()
local _chatBgTpl = L_GameTpl:getChatBackgroundTpl()
local _chatBubbleTpl = L_GameTpl:getChatBubbleTpl()
local _openAudio = "Play_SFX_System_HUD_General_Item_Detail_Open"
local _closeAudio = "Play_SFX_System_HUD_General_Item_Detail_Close"
local typeToFunc = {
  [L_Const.resType.commonItem] = "setCommonItemData",
  [L_Const.resType.soulEssence] = "setSoulEssenceData",
  [L_Const.resType.currency] = "setCurrencyData",
  [L_Const.resType.taskItem] = "setTaskItemData",
  [L_Const.resType.mountSaddle] = "setMountSaddleData",
  [L_Const.resType.collectionTool] = "setCollectionToolData",
  [L_Const.resType.playerTitle] = "setPlayerTitleData",
  [L_Const.resType.playerDress] = "setPlayerDressData",
  [L_Const.resType.petEgg] = "setPegEggData",
  [L_Const.resType.book] = "setBookData",
  [L_Const.resType.reputation] = "setReputationData",
  [L_Const.resType.petSkin] = "setPetSkinData",
  [L_Const.resType.cloth] = "setClothItemData",
  [L_Const.resType.heroCloth] = "setHeroClothItemData",
  [L_Const.resType.homeDormItem] = "setHomeDormItemData",
  [L_Const.resType.chatEmoji] = "setChatEmojiItemData",
  [L_Const.resType.chatBg] = "setChatBgItemData",
  [L_Const.resType.chatBubble] = "setChatBubbleItemData"
}
local GamepadAreaType = {
  commonItem_list_access = 1,
  commonItem_GiftContent = 2,
  currency = 3
}
local GamepadAreaConfigs = {
  [GamepadAreaType.commonItem_list_access] = {
    areaName = "commonItem_list_access_area",
    shortCutGroupName = "commonItem_list_access_group"
  },
  [GamepadAreaType.commonItem_GiftContent] = {
    areaName = "commonItem_GiftContent_area",
    shortCutGroupName = "commonItem_GiftContent_group"
  },
  [GamepadAreaType.currency] = {
    areaName = "currency_area",
    shortCutGroupName = "currency_group"
  }
}
local DefaultGamepadBackShortcutGroupName = "default_back"
local NoTipType = {
  [L_Const.resType.hero] = true,
  [L_Const.resType.pet] = true,
  [L_Const.resType.homeBuilding] = true
}

function this.bind()
  return {
    txt_name = "",
    img_icon = nil,
    img_iconFilter = nil,
    img_qualityCircle = nil,
    go_num = false,
    txt_num = nil,
    go_desc_main = false,
    txt_desc_main = nil,
    go_desc_sub = false,
    txt_desc_sub = nil,
    go_access = false,
    list_access = {
      moduleName = "pages/bag/cellItemAccess"
    },
    go_foodBuff = false,
    img_foodBuff = nil,
    go_foodDesc = false,
    go_foodDesc_pet = false,
    txt_foodDesc_pet = nil,
    go_foodDesc_heroHungry = false,
    txt_foodDesc_heroHungry = nil,
    go_foodDesc_hero = false,
    txt_foodDesc_hero = nil,
    module_fishRodBuff = {
      moduleName = "pages/fishing/moduleFishRodBuff"
    },
    go_petGeneFruit = false,
    module_petGeneFruit = {
      moduleName = "pages/pet/new/cellPetTipsGene"
    },
    go_soulessenceLevel = false,
    txt_soulessenceLevel = nil,
    go_soulessenceStar = false,
    list_soulessenceStar = {
      moduleName = "pages/bag/cellBagTipStar"
    },
    go_soulessenceSkillDesc = false,
    txt_soulessenceSkillDesc = nil,
    go_randomPreview = false,
    moduleGiftContent = {
      moduleName = "pages/bag/moduleGiftContent"
    },
    go_soulessenceAccessoryAtt = false,
    list_soulessenceAccessoryAtt = {
      moduleName = "pages/bag/cellBagTipSoulEssenceAccessoryAtt"
    },
    goSelectNum = false,
    moduleSelectNum = {
      moduleName = "modulePages/moduleSelectNum"
    },
    go_normalContent = true,
    go_preview = false,
    go_limit = false,
    img_limit = "",
    txt_limit = "",
    go_imgCircle = true,
    go_imgEmojiCircle = false,
    img_emotion = "",
    img_emotionQuality = "",
    frameCountPerRow = 0,
    frameCountPerCol = 0,
    frameCount = 0,
    frameAniFps = 8,
    frameAnimParamsComplete = true,
    go_button = false,
    active_gamepad_area_config = table.clone(GamepadAreaConfigs[GamepadAreaType.commonItem_list_access]),
    gamepad_area_config_changed = false,
    go_petEggTipEle = false
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self:popItem()
    end,
    onClick_confirmSelectNum = function(self)
      if self._selectNumCB then
        local num = self.modules.moduleSelectNum:getNum()
        self._selectNumCB(num)
      end
      L_UI:close(self.pageName)
    end,
    onClick_bg = function(self)
      self:popItem()
    end,
    onClick_preview = function(self)
      self:openPreviewPage()
    end,
    onClick_peg = function(self)
      self:openPreviewPage()
    end
  }
end

function this:check(options, callback)
  if NoTipType[options.itemType] then
    callback(false)
    return
  end
  if options.itemType == L_Const.resType.soulEssence then
    local serverData = C_SoulEssenceMgr:getsoulessenceItem(options.guid)
    callback(serverData ~= nil)
    return
  end
  callback(true)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._itemStack = {}
  self._itemType = options.itemType
  self._itemId = options.itemId
  self._guid = options.guid
  self._itemNum = options.itemNum
  self._curNum = options.curNum
  self._maxNum = options.maxNum
  self._selectNumCB = options.selectNumCB
  self._parentTabInfo = options and options.parentTab
  self.isRogueInside = options.isRogueInside
  self.notShowAccess = options.notShowAccess
  self.goodsId = options.goodsId or nil
  self:initPage()
  C_AudioManager.Play(_openAudio)
  L_UI:addListener(L_UI.pageEvent.showed, self.onPageShowed, self)
  self.onEvent_refreshBagHandle = handler(self, self.onEvent_refreshBag)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.onEvent_refreshBagHandle)
end

function this:onPageShowed()
  self:refreshGamepadConfig()
end

function this:close()
  L_UI:removeListener(L_UI.pageEvent.showed, self.onPageShowed, self)
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.onEvent_refreshBagHandle)
  self:clearLimitRefreshTimer()
  table.clear(self._itemStack)
  C_AudioManager.Play(_closeAudio)
  this.super.close(self)
end

function this:clearLimitRefreshTimer()
  if self.refreshTimer then
    self.refreshTimer:stop()
    self.refreshTimer = nil
  end
end

function this:onEvent_refreshBag()
  self:initPage()
end

function this:initPage()
  self:setGeneralData()
  if self[typeToFunc[self._itemType]] then
    self[typeToFunc[self._itemType]](self)
  end
  if self._selectNumCB then
    self.bind.goSelectNum = true
    self.modules.moduleSelectNum:initModule(nil, self._maxNum, 1, self._curNum)
    local weight, _ = self.bindComponents.transInfo:GetUISize()
    self.bindComponents.transInfo:SetUISize(weight, 280)
  end
end

function this:pushItem(options)
  if NoTipType[options.itemType] then
    return
  end
  local stackData = {
    itemType = self._itemType,
    itemId = self._itemId,
    guid = self._guid,
    curNum = self._curNum,
    maxNum = self._maxNum,
    selectNumCB = self._selectNumCB
  }
  table.insert(self._itemStack, stackData)
  self._itemType = options.itemType
  self._itemId = options.itemId
  self._guid = options.guid
  self._curNum = options.curNum
  self._maxNum = options.maxNum
  self._selectNumCB = options.selectNumCB
  self:initPage()
  self:playShowAnim()
  self:refreshGamepadConfig()
end

function this:popItem()
  if self._itemStack and #self._itemStack > 0 then
    self:playHideAnim(function()
      local recoverOption = self._itemStack[#self._itemStack]
      table.remove(self._itemStack)
      self._itemType = recoverOption.itemType
      self._itemId = recoverOption.itemId
      self._guid = recoverOption.guid
      self._curNum = recoverOption.curNum
      self._maxNum = recoverOption.maxNum
      self._selectNumCB = recoverOption.selectNumCB
      self:initPage()
      self:playShowAnim()
      self:refreshGamepadConfig()
    end)
  else
    L_UI:close(self.pageName)
  end
end

function this:openPreviewPage()
  if self._itemType == L_Const.resType.heroCloth then
    local tpl = heroClothTpl:getTplById(self._itemId)
    local heroId = heroClothTpl:getHero(tpl)
    if tpl then
      if L_GameUtil.checkClothingBlocked() then
        return
      end
      L_UI:open("pageHeroClothing", {
        heroId = heroId,
        clothingId = self._itemId
      })
    end
  elseif self._itemType == L_Const.resType.cloth then
    if L_GameUtil.checkClothingBlocked() then
      return
    end
    L_UI:open("pageCustomClothes", {
      clothingId = self._itemId
    })
  elseif self._itemType == L_Const.resType.petEgg then
    L_UI:open("PagePetEggInfoTip", {
      petEggId = self._itemId
    })
  end
end

function this:setGeneralData()
  local configData = L_ItemTplManager:getItemConfig(self._itemType, self._itemId)
  local commonItemTpl = _commonItemTpl:getTplById(self._itemId)
  self.bind.go_normalContent = true
  self.bind.img_iconFilter = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
  self:formatName(configData.name)
  self.bind.img_icon = configData.icon
  if self._itemType == L_Const.resType.book and self.goodsId then
    local goodsTpl = L_GameTpl:getGoodsTpl()
    local tpl = goodsTpl:getTplById(self.goodsId)
    self.bind.txt_desc_main = goodsTpl:getGoodsDesc(tpl)
  else
    self.bind.txt_desc_main = configData.desc
  end
  if self._itemType == L_Const.resType.petEgg then
    self.bind.go_button = true
    self.bind.go_petEggTipEle = true
    if not self.modulePetEggTipEle then
      local addModuleGeneric = xlua.get_generic_method(self.csharpPage:GetType(), "AddModule", 1)
      local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.ModulePetEggTipEle, CS.UnityEngine.GameObject)
      self.modulePetEggTipEle = addModule(self.csharpPage, self.csharpPage, self.bindComponents.ModulePetEggTipEle.gameObject)
    end
    self.modulePetEggTipEle:InitModule(self._guid or 0)
  else
    self.bind.go_button = false
    self.bind.go_petEggTipEle = false
  end
  self.bind.img_qualityCircle = string.format("UI/Atlas/Bag/tex_bag_rarity_tips_w_%s.png", configData.quality)
  self.bind.go_randomPreview = false
  self.bind.go_preview = false
end

function this:formatName(name)
  self.bind.txt_name = name
end

function this:setCommonItemData()
  local tpl = _commonItemTpl:getTplById(self._itemId)
  print("_itemId: " .. tostring(self._itemId) .. "showNum: " .. tostring(_commonItemTpl:getShowNum(tpl)))
  self.bind.go_num = _commonItemTpl:getShowNum(tpl)
  self.bind.txt_num = tostring(C_BagMgr:getItemNumByItemId(self._itemId))
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _commonItemTpl:getSpecialDesc(tpl)
  local accessList = _commonItemTpl:getWayList(tpl)
  self:initAccessList(accessList)
  self.bind.active_gamepad_area_config = table.clone(GamepadAreaConfigs[GamepadAreaType.commonItem_list_access])
  if table.isEmpty(accessList) then
    self.bind.active_gamepad_area_config.shortCutGroupName = DefaultGamepadBackShortcutGroupName
  end
  self.bind.gamepad_area_config_changed = true
  if _commonItemTpl:getType(tpl) == L_BagConst.bagItemType.food then
    self:setFoodData()
  elseif _commonItemTpl:getType(tpl) == L_BagConst.bagItemType.fishingRod then
    self:setFishingRodData()
  elseif _commonItemTpl:getType(tpl) == L_BagConst.bagItemType.petGeneFeedItem and _petFeedItemTpl:getEffectType(_petFeedItemTpl:getTplById(self._itemId)) == 3 then
    self:setPetGeneFruitData()
  end
  if _commonItemTpl:getType(tpl) == L_BagConst.bagItemType.heroRandomGift or _commonItemTpl:getType(tpl) == L_BagConst.bagItemType.heroGift or _commonItemTpl:getType(tpl) == L_BagConst.bagItemType.heroFixedGift or _commonItemTpl:getType(tpl) == L_BagConst.bagItemType.petFeedGift then
    self.bind.go_normalContent = false
    self.bind.go_randomPreview = true
    self:setRandomPreviewData()
  else
    self.bind.go_randomPreview = false
  end
  self:clearLimitRefreshTimer()
  if C_BagMgr:isLimitItem(self._itemId) then
    self.bind.go_limit = true
    self.bind.img_limit = "Assets/Arts/UI/Page/Common/icon/tex_common_icon_countdown_03.png"
    local bOwn = self._guid and self._guid ~= 0
    if bOwn then
      local bagItem = C_BagMgr:getItemByGuid(self._guid)
      local deadTime = bagItem and bagItem.deadTime or 0
      if 0 < deadTime then
        local function refreshLimitTxt()
          if deadTime <= L_TimeUtil.getServerTime() then
            self.bind.txt_limit = L_WordsTpl:getValue("item_expired")
            
            self:clearLimitRefreshTimer()
          else
            self.bind.txt_limit = L_TimeUtil.getLeftTimeString2(deadTime)
          end
        end
        
        refreshLimitTxt()
        if deadTime > L_TimeUtil.getServerTime() then
          self.refreshTimer = Timer.repeated(1, refreshLimitTxt)
        end
      else
        self.bind.txt_limit = L_WordsTpl:getValue("item_expired")
      end
    else
      self.bind.txt_limit = L_WordsTpl:getValue("limit_time_use")
    end
  else
    self.bind.go_limit = false
  end
end

function this:setFoodData()
  local tpl_food = _foodTpl:getTplById(self._itemId)
  self.bind.go_foodBuff = true
  self.bind.img_foodBuff = string.format("UI/Atlas/FoodType/tex_icon_foodtype_tag_0%s.png", _foodTpl:getFoodType(tpl_food))
  local satiety = _foodTpl:getSatietyScore(tpl_food)
  local isPetFood = not math.isEmpty(satiety)
  self.bind.go_desc_main = false
  self.bind.go_foodDesc = true
  self.bind.go_foodDesc_pet = isPetFood
  self.bind.txt_foodDesc_pet = string.concat(L_WordsTpl:getValue("ui_pet_food_desc"), satiety)
  satiety = _foodTpl:getCharge(tpl_food)
  self.bind.go_foodDesc_heroHungry = not math.isEmpty(satiety)
  self.bind.txt_foodDesc_heroHungry = string.concat(L_WordsTpl:getValue("ui_hero_food_desc"), satiety)
  local tpl_commonItem = _commonItemTpl:getTplById(self._itemId)
  if _commonItemTpl:getDesc(tpl_commonItem) and _commonItemTpl:getDesc(tpl_commonItem) ~= "" then
    self.bind.go_foodDesc_hero = true
    self.bind.txt_foodDesc_hero = _commonItemTpl:getDesc(tpl_commonItem)
  else
    self.bind.go_foodDesc_hero = false
  end
end

function this:setFishingRodData()
  self.bind.go_desc_main = false
  local moduleRodBuff = self.modules.module_fishRodBuff
  moduleRodBuff:setData(self._itemId)
end

function this:setPetGeneFruitData()
  self.bind.go_petGeneFruit = true, self.modules.module_petGeneFruit:setData(self._itemId)
end

function this:setTaskItemData()
  local tpl = _taskItemTpl:getTplById(self._itemId)
  self.bind.go_num = _taskItemTpl:getInBag(tpl)
  self.bind.txt_num = tostring(AzurWorld.TaskMgr:GetTaskUIModule():GetTaskPropNum(self._itemId))
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _taskItemTpl:getSpecialDesc(tpl)
end

function this:setClothItemData()
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = true
  if L_UI:checkPageShown("PageCommonFashionBuy") then
    self.bind.go_preview = false
  else
    self.bind.go_preview = true
  end
  local tpl = clothTpl:getTplById(self._itemId)
  if tpl then
    self.bind.txt_desc_sub = clothTpl:getSpecialDesc(tpl)
    local accessList = clothTpl:getWayList(tpl)
    self:initAccessList(accessList)
    return
  end
end

function this:setHeroClothItemData()
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = true
  local tpl = heroClothTpl:getTplById(self._itemId)
  if tpl then
    self.bind.txt_desc_sub = heroClothTpl:getSpecialDesc(tpl)
  end
  local accessList = heroClothTpl:getWayList(tpl)
  self:initAccessList(accessList)
  self.bind.go_preview = true
end

function this:setSoulEssenceData()
  local serverData = C_SoulEssenceMgr:getsoulessenceItem(self._guid)
  self.bind.go_soulessenceLevel = true
  local rankData = _soulessenceRankTpl:getChildren(serverData.soulEssenceId)
  local limitTxt = L_GameUtil.fillColor(string.concat("/", rankData[serverData.rank].rankLevelLimit), L_Const.colorHtml.grey008)
  self.bind.txt_soulessenceLevel = string.concat(serverData.level, limitTxt)
  local tpl = _soulessenceTpl:getTplById(serverData.soulEssenceId)
  self.bind.img_icon = _soulessenceTpl:getAvatarTexture(tpl, 1)
  self.bind.go_soulessenceStar = true
  local stars = {}
  for i = 1, serverData.star - 1 do
    table.insert(stars, {})
  end
  self.bind.list_soulessenceStar:clear()
  self.bind.list_soulessenceStar:insert_array(stars)
  if serverData.soulEssenceId == 10001 then
    self.bind.go_soulessenceSkillDesc = true
    self.bind.txt_soulessenceSkillDesc = C_SoulEssenceMgr:getExclusiveSkill(serverData.soulEssenceId, serverData.star - 1).skillDesc
  else
    self.bind.go_soulessenceSkillDesc = false
  end
  local tmp = {}
  local attList = C_SoulEssenceMgr:getConfigAttList(self._itemId, serverData.level, serverData.rank)
  for k, v in pairs(attList) do
    local tpl_battleInfo = _battleInfoTpl:getTplById(k)
    table.insert(tmp, {
      txt_name = _battleInfoTpl:getName(tpl_battleInfo),
      txt_value = _battleInfoTpl:getShowTxt(k, v)
    })
  end
  self.bind.go_soulessenceAccessoryAtt = true
  self.bind.list_soulessenceAccessoryAtt:clear()
  self.bind.list_soulessenceAccessoryAtt:insert_array(tmp)
end

function this:setCurrencyData()
  local tpl = _currencyTpl:getTplById(self._itemId)
  local num = L_PlayerStore:getCurrencyNum(self._itemId)
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _currencyTpl:getSpecialDesc(tpl)
  self.bind.go_num = _currencyTpl:getShowNum(tpl)
  self.bind.txt_num = tostring(num)
  if self.isRogueInside then
    self.bind.txt_num = tostring(self._curNum or 0)
  end
  local accessList = _currencyTpl:getWayList(tpl)
  self:initAccessList(accessList)
  self.bind.active_gamepad_area_config = table.clone(GamepadAreaConfigs[GamepadAreaType.currency])
  if table.isEmpty(accessList) then
    self.bind.active_gamepad_area_config.shortCutGroupName = DefaultGamepadBackShortcutGroupName
  end
  self.bind.gamepad_area_config_changed = true
end

function this:setCollectionToolData()
  local tpl = _collectionToolTpl:getTplById(self._itemId)
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _collectionToolTpl:getSpecialDesc(tpl)
  self.bind.go_num = false
  local access = _collectionToolTpl:getWay1(tpl)
  local accessDesc = _collectionToolTpl:getWay1desc(tpl)
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.itemAccess) then
    return
  end
  self.bind.go_access = not math.isEmpty(access)
  local tmp = {}
  local fromBuildId = self._parentTabInfo and self._parentTabInfo.fromBuildId
  local parentId = self._parentTabInfo and self._parentTabInfo.parentId
  table.insert(tmp, {
    systemId = access,
    txt_access = accessDesc,
    itemId = self._itemId,
    parentId = parentId,
    fromBuildId = fromBuildId,
    parentPageGuid = self._guid,
    itemNum = self._itemNum
  })
  self.bind.list_access:clear()
  self.bind.list_access:insert_array(tmp)
end

function this:setMountSaddleData()
  local tpl = _mountSaddleTpl:getTplById(self._itemId)
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _mountSaddleTpl:getSpecialDesc(tpl)
end

function this:setRandomPreviewData()
  local tpl = _commonItemTpl:getTplById(self._itemId)
  local dropId = _commonItemTpl:getUseFunction(tpl)[1]
  local dropItems = L_GameTpl:getDropTpl():getDropGroup(dropId)
  local previewList = {}
  for _, dropInfo in pairs(dropItems) do
    local numStr = dropInfo.minValue == dropInfo.maxValue and tostring(dropInfo.minValue) or tostring(dropInfo.minValue) .. "~" .. tostring(dropInfo.maxValue)
    table.insert(previewList, {
      itemType = dropInfo.type,
      itemId = dropInfo.itemId,
      txt_num = numStr,
      callback = function()
        self:pushItem({
          itemType = dropInfo.type,
          itemId = dropInfo.itemId
        })
      end
    })
  end
  self.modules.moduleGiftContent:setGiftPreviewData(previewList, _commonItemTpl:getDesc(tpl))
  self.bind.active_gamepad_area_config = table.clone(GamepadAreaConfigs[GamepadAreaType.commonItem_GiftContent])
  if table.isEmpty(previewList) then
    self.bind.active_gamepad_area_config.shortCutGroupName = DefaultGamepadBackShortcutGroupName
  end
  self.bind.gamepad_area_config_changed = true
end

function this:setPlayerTitleData()
  local tpl = _playerTitleTpl:getTplById(self._itemId)
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _playerTitleTpl:getSpecialDesc(tpl)
  local accessList = _playerTitleTpl:getWayList(tpl)
  self:initAccessList(accessList)
end

function this:setPlayerDressData()
  local tpl = _playerDressTpl:getTplById(self._itemId)
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _playerDressTpl:getSpecialDesc(tpl)
  local accessList = _playerDressTpl:getWayList(tpl)
  self:initAccessList(accessList)
end

function this:setPegEggData()
  local tpl = _petEggTpl:getTplById(self._itemId)
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _petEggTpl:getSpecialDesc(tpl)
end

function this:setBookData()
  self.bind.go_desc_main = true
end

function this:setReputationData()
  local tpl = _currencyTpl:getTplById(self._itemId)
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _currencyTpl:getSpecialDesc(tpl)
  self.bind.go_num = false
end

function this:setPetSkinData()
  local tpl = _petSkinTpl:getTplById(self._itemId)
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _petSkinTpl:getSpecialDesc(tpl)
  self.bind.go_num = false
  local accessList = _petSkinTpl:getWayList(tpl)
  self:initAccessList(accessList)
end

function this:setHomeDormItemData()
  local tpl = homeDormItemTpl:getTplById(self._itemId)
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = false
  self.bind.go_num = false
  local accessList = homeDormItemTpl:getWayList(tpl)
  self:initAccessList(accessList)
end

function this:setChatEmojiItemData()
  self.bind.go_desc_main = true
  local tpl = chatEmojiTpl:getTplById(self._itemId)
  self.bind.go_imgCircle = false
  self.bind.go_imgEmojiCircle = true
  local quality = chatEmojiTpl:getRarity(tpl)
  self.bind.img_emotionQuality = string.format("UI/Atlas/Bag/tex_bag_rarity_tips_w_%s.png", quality)
  self.bind.img_emotion = chatEmojiTpl:getResource(tpl)
  self.bind.frameCount = chatEmojiTpl:getMaxFrame(tpl)
  self.bind.frameCountPerRow = chatEmojiTpl:getFramePerRow(tpl)
  self.bind.frameCountPerCol = chatEmojiTpl:getFramePerCol(tpl)
  local accessList = chatEmojiTpl:getWayList(tpl)
  self:initAccessList(accessList)
end

function this:setChatBgItemData()
  local tpl = _chatBgTpl:getTplById(self._itemId)
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = false
  local accessList = _chatBgTpl:getWayList(tpl)
  self:initAccessList(accessList)
end

function this:setChatBubbleItemData()
  local tpl = _chatBubbleTpl:getTplById(self._itemId)
  self.bind.go_desc_main = true
  self.bind.go_desc_sub = true
  self.bind.txt_desc_sub = _chatBubbleTpl:getSpecialDesc(tpl)
  local accessList = _chatBubbleTpl:getWayList(tpl)
  self:initAccessList(accessList)
end

function this:initAccessList(accessList)
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.itemAccess) then
    return
  end
  if self.notShowAccess then
    self.bind.list_access:clear()
    return
  end
  self.bind.go_access = not table.isEmpty(accessList)
  local fromBuildId = self._parentTabInfo and self._parentTabInfo.fromBuildId
  local parentId = self._parentTabInfo and self._parentTabInfo.parentId
  local guid = self._parentTabInfo and self._parentTabInfo.parentPageGuid or self._guid
  local tmp = {}
  for i, v in ipairs(accessList) do
    table.insert(tmp, {
      systemId = v.id,
      txt_access = v.desc,
      itemId = self._itemId,
      parentId = parentId,
      fromBuildId = fromBuildId,
      parentPageGuid = guid,
      itemNum = self._itemNum
    })
  end
  self.bind.list_access:clear()
  self.bind.list_access:insert_array(tmp)
end

function this:playShowAnim(callback)
  self.bindComponents.anim:Play("anim_tip_bg_show2")
  if callback then
    L_TimerManager:newOrResetTimer(self, "playShowAnim", callback, 0.5)
  end
end

function this:playHideAnim(callback)
  self.bindComponents.anim:Play("anim_tip_bg_close")
  if callback then
    L_TimerManager:newOrResetTimer(self, "playHideAnim", callback, 0.2)
  end
end

function this:refreshGamepadConfig()
  if not self.bind.gamepad_area_config_changed then
    return
  end
  self.bind.gamepad_area_config_changed = false
  local areaConfig = self.bind.active_gamepad_area_config
  if not areaConfig then
    C_MJLog.LogError("refreshGamepadConfig: no GamepadAreaConfigs for active_gamepad_area_config = " .. tostring(self.bind.active_gamepad_area_config))
    return
  end
  local pageName = tostring(self.pageName)
  local areaName = tostring(areaConfig.areaName)
  local ok, err = pcall(function()
    CS.Lens.Gameplay.UI.UIPageAreaStateMachine.instance:ReplaceArea(pageName, areaName)
  end)
  if not ok then
    C_MJLog.LogError("refreshGamepadConfig ReplaceArea failed: " .. tostring(err) .. ", pageName type=" .. type(self.pageName) .. ", areaName type=" .. type(areaConfig.areaName))
    return
  end
  C_MJLog.LogInfo("refreshGamepadConfig ReplaceArea: " .. ", pageName =" .. pageName .. ", areaName =" .. areaName .. ", areaConfig.shortCutGroupName =" .. areaConfig.shortCutGroupName)
  local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
  args.isLuaEvent = true
  args.luaTable = {
    moduleOrPageName = pageName,
    changeGroupName = areaConfig.shortCutGroupName
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
end

return this
