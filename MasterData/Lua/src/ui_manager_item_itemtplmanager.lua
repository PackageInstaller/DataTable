local this = class("itemManager", G_EventManagerBase)
local heroTpl = L_GameTpl:getHeroTpl()
local commonItemTpl = L_GameTpl:getCommonItemTpl()
local petInfoTpl = L_GameTpl:getPetTpl()
local petRankTpl = L_GameTpl:getPetRankTpl()
local unitTpl = L_GameTpl:getUnitTpl()
local soulessenceTpl = L_GameTpl:getSoulessenceTpl()
local accessoryTpl = L_GameTpl:getAccessoryTpl()
local taskItemTpl = L_GameTpl:getTaskItemTpl()
local buildingTpl = L_GameTpl:getHomeBuildingTpl()
local mountTpl = L_GameTpl:getMountTpl()
local currencyTpl = L_GameTpl:getCurrencyTpl()
local playerTitleTpl = L_GameTpl:getPlayerTitleTpl()
local petEggTpl = L_GameTpl:getPetEggTpl()
local petEggAppearanceTpl = L_GameTpl:getPetEggAppearanceTpl()
local enemyTpl = L_GameTpl:getEnemyTpl()
local starGiftTpl = L_GameTpl:getStargiftTpl()
local goodsTpl = L_GameTpl:getGoodsTpl()
local mountSaddleTpl = L_GameTpl:getMountSaddleTpl()
local collectionToolTpl = L_GameTpl:getCollectionToolTpl()
local playerDressTpl = L_GameTpl:getPlayercardDressTpl()
local petCustomizedTpl = L_GameTpl:getPetCustomizedTpl()
local libraryReadingsTpl = L_GameTpl:getLibraryReadingsTpl()
local librarySeriesTpl = L_GameTpl:getLibrarySeriesTpl()
local accessoryCustomedTpl = L_GameTpl:getAccessoryCustomedTpl()
local clothItemTpl = L_GameTpl:getClothItemTpl()
local heroClothTpl = L_GameTpl:getHeroClothingTpl()
local petSkinTpl = L_GameTpl:getPetSkinTpl()
local homeDormItemTpl = L_GameTpl:getHomeDormItemTpl()
local chatEmojiTpl = L_GameTpl:getChatEmojiTpl()
local chatBgTpl = L_GameTpl:getChatBackgroundTpl()
local chatBubbleTpl = L_GameTpl:getChatBubbleTpl()
local Type2Func = {
  [L_Const.resType.hero] = "getHeroItem",
  [L_Const.resType.commonItem] = "getCommonItem",
  [L_Const.resType.pet] = "getPetItem",
  [L_Const.resType.soulEssence] = "getsoulessenceItem",
  [L_Const.resType.currency] = "getCurrencyItem",
  [L_Const.resType.mount] = "getMountItem",
  [L_Const.resType.homeBuilding] = "getBuildingItem",
  [L_Const.resType.petEgg] = "getGeneralPetEggItem",
  [L_Const.resType.accessory] = "getAccessoryItem",
  [L_Const.resType.playerTitle] = "getPlayerTitleData",
  [L_Const.resType.stargift] = "getStarGiftData",
  [L_Const.resType.enemy] = "getEnemyItem",
  [L_Const.resType.goods] = "getGoodsItem",
  [L_Const.resType.taskItem] = "getTaskItem",
  [L_Const.resType.collectionTool] = "getCollectionToolItem",
  [L_Const.resType.mountSaddle] = "getMountSaddleItem",
  [L_Const.resType.playerDress] = "getPlayerDressItem",
  [L_Const.resType.petCustomized] = "getPetCustomizedItem",
  [L_Const.resType.book] = "getBookItem",
  [L_Const.resType.reputation] = "getReputationItem",
  [L_Const.resType.customAccessory] = "getCustomAccessoryItem",
  [L_Const.resType.cloth] = "getClothItem",
  [L_Const.resType.petSkin] = "getPetSkinItem",
  [L_Const.resType.heroCloth] = "getHeroClothItem",
  [L_Const.resType.homeDormItem] = "getHomeDormItem",
  [L_Const.resType.chatEmoji] = "getChatEmojiItem",
  [L_Const.resType.chatBg] = "getChatBgItem",
  [L_Const.resType.chatBubble] = "getChatBubbleItem"
}
local Bag2Info = {
  [L_Const.resType.commonItem] = "fromBagItem",
  [L_Const.resType.pet] = "fromPetItem",
  [L_Const.resType.currency] = "fromCurrencyItem",
  [L_Const.resType.homeBuilding] = "fromHomeBuildingItem",
  [L_Const.resType.petEgg] = "fromPetEggItem",
  [L_Const.resType.accessory] = "fromAccessoryItem",
  [L_Const.resType.taskItem] = "fromTaskItem"
}
local CachedItemConfig = {}
local NoCacheTypes = {
  [L_Const.resType.cloth] = true
}

function this:getItemConfig(itemType, itemId, ...)
  local noCache = NoCacheTypes[itemType]
  CachedItemConfig[itemType] = CachedItemConfig[itemType] or {}
  if not noCache and CachedItemConfig[itemType][itemId] then
    local cacheData = CachedItemConfig[itemType][itemId]
    if cacheData then
      cacheData.num = self:getItemNum(itemType, itemId)
    end
    return cacheData
  end
  local data
  if Type2Func[itemType] and self[Type2Func[itemType]] then
    data = self[Type2Func[itemType]](self, itemId, ...)
  else
    data = {}
  end
  data = data or {}
  data.itemType = itemType
  data.itemId = itemId
  data.num = self:getItemNum(itemType, itemId)
  data.quality = self:getItemQuality(itemType, itemId)
  if not noCache then
    CachedItemConfig[itemType][itemId] = data or {}
  end
  return data
end

function this:getItemSmallType(itemBigType, itemId)
  if itemBigType == L_Const.resType.commonItem then
    local tpl = commonItemTpl:getTplById(itemId)
    return commonItemTpl:getType(tpl)
  elseif itemBigType == L_Const.resType.pet then
    local tpl = petRankTpl:getTplById(itemId)
    return petRankTpl:getPetGroup(tpl)
  else
    return nil
  end
end

function this:getToInfoFunction(itemBigType)
  if Bag2Info[itemBigType] and self[Bag2Info[itemBigType]] then
    return handler(self, self[Bag2Info[itemBigType]])
  end
  return nil
end

function this:getHeroItem(itemId)
  local tpl = heroTpl:getTplById(itemId)
  return {
    name = heroTpl:getName(tpl),
    icon_large = L_GameUtil.getAvatarTexturePath(itemId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.large),
    icon_mid = L_GameUtil.getAvatarTexturePath(itemId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.mid) or "",
    icon_small = L_GameUtil.getAvatarTexturePath(itemId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.small) or "",
    quality = heroTpl:getRarity(tpl),
    desc = heroTpl:getDec(tpl)
  }
end

function this:getStarGiftData(itemId)
  local tpl = starGiftTpl:getTplById(itemId)
  return {
    name = starGiftTpl:getName(tpl),
    icon = starGiftTpl:getTexture(tpl, L_Const.avatarTextureIndex.head),
    quality = starGiftTpl:getRarity(tpl),
    desc = starGiftTpl:getDec(tpl)
  }
end

local CachedCommonItem = {}

function this:getCommonItem(itemId)
  local tpl = commonItemTpl:getTplById(itemId)
  if not tpl then
    errorf("commonItem表里不存在该itemId = " .. tostring(itemId))
    return nil
  end
  if CachedCommonItem[itemId] == nil then
    CachedCommonItem[itemId] = {
      name = commonItemTpl:getName(tpl),
      icon = commonItemTpl:getIcon(tpl),
      quality = commonItemTpl:getRarity(tpl),
      desc = commonItemTpl:getDesc(tpl)
    }
  end
  return CachedCommonItem[itemId]
end

function this:getBookItem(itemId)
  local Tpl = libraryReadingsTpl:getTplById(itemId)
  if not Tpl then
    errorf("libraryReadingsTpl表里不存在该itemId = " .. tostring(itemId))
    return nil
  end
  local serialTpl = librarySeriesTpl:getIdBySubId(itemId)
  return {
    name = string.isEmpty(Tpl.name) and librarySeriesTpl:getName(serialTpl) or Tpl.name,
    icon = librarySeriesTpl:getIcon(serialTpl),
    quality = 4,
    desc = librarySeriesTpl:getDesc(serialTpl)
  }
end

function this:getReputationItem(itemId)
  local tpl = currencyTpl:getTplById(itemId)
  return {
    name = currencyTpl:getName(tpl),
    icon = currencyTpl:getIcon(tpl),
    smallIcon = currencyTpl:getIconSmall(tpl),
    quality = currencyTpl:getQuality(tpl),
    desc = currencyTpl:getDesc(tpl)
  }
end

function this:getCustomAccessoryItem(itemId)
  local accessoryId = accessoryCustomedTpl:getAccessoryIdById(itemId)
  return self:getAccessoryItem(accessoryId)
end

function this:getClothItem(itemId)
  local clothItem = clothItemTpl:getTplById(itemId)
  if clothItem then
    return {
      name = clothItemTpl:getName(clothItem),
      icon = clothItemTpl:getIcon(clothItem),
      quality = clothItemTpl:getQuality(clothItem),
      desc = clothItemTpl:getDesc(clothItem)
    }
  end
end

function this:getHeroClothItem(itemId)
  local heroClothing = heroClothTpl:getTplById(itemId)
  if heroClothing then
    return {
      name = heroClothTpl:getName(heroClothing),
      icon = heroClothTpl:getIcon(heroClothing),
      quality = heroClothTpl:getQuality(heroClothing),
      desc = heroClothTpl:getDesc(heroClothing)
    }
  end
end

function this:getPetItem(petConfigId, isSpecial)
  isSpecial = type(isSpecial) ~= "boolean" and false
  local tpl = petInfoTpl:getTplById(petConfigId)
  return {
    name = petInfoTpl:getName(tpl, isSpecial),
    icon = petInfoTpl:getPetPixelIcon(tpl, isSpecial),
    quality = 4,
    desc = petInfoTpl:getName(tpl, isSpecial)
  }
end

function this:getPetCustomizedItem(petCustomizedConfigId)
  local cTpl = petCustomizedTpl:getTplById(petCustomizedConfigId)
  local petConfigId = petCustomizedTpl:getPetId(cTpl)
  local isSpecial = 0
  local tpl = petInfoTpl:getTplById(petConfigId)
  return {
    name = petInfoTpl:getName(tpl, isSpecial),
    icon = petInfoTpl:getPetPixelIcon(tpl, isSpecial),
    quality = 4,
    desc = petInfoTpl:getName(tpl, isSpecial)
  }
end

function this:getBuildingItem(itemId)
  local tpl = buildingTpl:getTplById(itemId)
  return {
    name = buildingTpl:getName(tpl),
    icon = buildingTpl:getBuildIcon(tpl),
    desc = buildingTpl:getDesc(tpl),
    quality = 0
  }
end

function this:getsoulessenceItem(itemId, index)
  index = index or 2
  local tpl = soulessenceTpl:getTplById(itemId)
  return {
    name = soulessenceTpl:getName(tpl),
    icon = soulessenceTpl:getAvatarTexture(tpl, index),
    quality = soulessenceTpl:getRarity(tpl),
    desc = soulessenceTpl:getDesc(tpl),
    reishiExp = soulessenceTpl:getReishiExp(tpl)
  }
end

function this:getCurrencyItem(itemId)
  local tpl = currencyTpl:getTplById(itemId)
  return {
    name = currencyTpl:getName(tpl),
    icon = currencyTpl:getIcon(tpl),
    smallIcon = currencyTpl:getIconSmall(tpl),
    quality = currencyTpl:getQuality(tpl),
    desc = currencyTpl:getDesc(tpl)
  }
end

function this:getMountItem(itemId)
  local tpl = mountTpl:getTplById(itemId)
  return {
    name = mountTpl:getNameByTpl(tpl),
    icon = mountTpl:getIconByTpl(tpl),
    quality = mountTpl:getQuatityByTpl(tpl),
    desc = mountTpl:getDescByTpl(tpl)
  }
end

function this:getGeneralPetEggItem(itemId)
  local tpl = petEggTpl:getTplById(itemId)
  return {
    name = petEggTpl:getName(tpl),
    icon = petEggTpl:getEggImgIcon(tpl),
    quality = 1,
    desc = petEggTpl:getDesc(tpl)
  }
end

function this:getPetEggItem(itemId, guid)
  local tpl = petEggTpl:getTplById(itemId)
  local petEggData = L_PetStore:getPetEggItem(guid)
  return {
    name = petEggData.type,
    icon = petEggTpl:getEggImgIcon(tpl),
    quality = 1,
    desc = petEggTpl:getDesc(tpl)
  }
end

function this:getAccessoryItem(itemId)
  local tpl = accessoryTpl:getTplById(itemId)
  if tpl == nil then
    errorf("没有找到配置数据, Accessory id = " .. tostring(itemId))
    return {}
  end
  return {
    name = accessoryTpl:getName(tpl),
    icon = accessoryTpl:getIcon(tpl),
    quality = accessoryTpl:getRarity(tpl),
    desc = accessoryTpl:getDesc(tpl)
  }
end

function this:getPlayerTitleData(itemId)
  local tpl = playerTitleTpl:getTplById(itemId)
  return {
    name = playerTitleTpl:getItemName(tpl),
    icon = playerTitleTpl:getIcon(tpl),
    desc = playerTitleTpl:getItemDesc(tpl),
    quality = playerTitleTpl:getRarity(tpl)
  }
end

function this:getEnemyItem(itemId)
  local tpl = enemyTpl:getTplById(itemId)
  return {
    name = enemyTpl:getName(tpl),
    icon = enemyTpl:getAvatarTexture(tpl),
    desc = enemyTpl:getDesc(tpl),
    quality = nil
  }
end

function this:getGoodsItem(itemId)
  local tpl = goodsTpl:getTplById(itemId)
  return {
    name = goodsTpl:getGoodsName(tpl),
    icon = goodsTpl:getIcon(tpl),
    desc = "",
    quality = goodsTpl:getRarity(tpl)
  }
end

function this:getTaskItem(itemId)
  local tpl = taskItemTpl:getTplById(itemId)
  return {
    name = taskItemTpl:getName(tpl),
    icon = taskItemTpl:getIcon(tpl),
    quality = taskItemTpl:getRarity(tpl),
    desc = taskItemTpl:getDesc(tpl)
  }
end

function this:getMountSaddleItem(itemId)
  local tpl = mountSaddleTpl:getTplById(itemId)
  return {
    name = tpl == nil and "" or mountSaddleTpl:getName(tpl),
    icon = tpl == nil and "" or mountSaddleTpl:getIcon(tpl),
    quality = tpl == nil and 0 or mountSaddleTpl:getRarity(tpl),
    desc = tpl == nil and "" or mountSaddleTpl:getDesc(tpl)
  }
end

function this:getCollectionToolItem(itemId)
  local tpl = collectionToolTpl:getTplById(itemId)
  return {
    name = collectionToolTpl:getName(tpl),
    icon = collectionToolTpl:getIcon(tpl),
    quality = collectionToolTpl:getRarity(tpl),
    desc = collectionToolTpl:getDesc(tpl)
  }
end

function this:getPlayerDressItem(itemId)
  local tpl = playerDressTpl:getTplById(itemId)
  if not tpl then
    errorf("playercardDress表里不存在该itemId = " .. tostring(itemId))
    return {
      name = "",
      icon = "",
      quality = 0,
      desc = ""
    }
  end
  return {
    name = playerDressTpl:getItemName(tpl),
    icon = playerDressTpl:getIcon(tpl),
    quality = playerDressTpl:getRarity(tpl),
    desc = playerDressTpl:getDesc(tpl)
  }
end

function this:getPetSkinItem(itemId)
  local tpl = petSkinTpl:getTplById(itemId)
  return {
    name = petSkinTpl:getName(tpl),
    icon = petSkinTpl:getIcon(tpl),
    quality = petSkinTpl:getRarity(tpl),
    desc = petSkinTpl:getDesc(tpl)
  }
end

function this:getHomeDormItem(itemId)
  local tpl = homeDormItemTpl:getTplById(itemId)
  return {
    name = homeDormItemTpl:getName(tpl),
    icon = homeDormItemTpl:getIcon(tpl),
    quality = homeDormItemTpl:getRarity(tpl),
    desc = homeDormItemTpl:getDesc(tpl)
  }
end

function this:getChatEmojiItem(itemId)
  local tpl = chatEmojiTpl:getTplById(itemId)
  return {
    name = chatEmojiTpl:getName(tpl),
    icon = chatEmojiTpl:getIcon(tpl),
    quality = chatEmojiTpl:getRarity(tpl),
    desc = chatEmojiTpl:getDesc(tpl)
  }
end

function this:getChatBgItem(itemId)
  local tpl = chatBgTpl:getTplById(itemId)
  return {
    name = chatBgTpl:getName(tpl),
    icon = chatBgTpl:getIcon(tpl),
    quality = chatBgTpl:getRarity(tpl),
    desc = chatBgTpl:getDesc(tpl)
  }
end

function this:getChatBubbleItem(itemId)
  local tpl = chatBubbleTpl:getTplById(itemId)
  return {
    name = chatBubbleTpl:getName(tpl),
    icon = chatBubbleTpl:getIcon(tpl),
    quality = chatBubbleTpl:getRarity(tpl),
    desc = chatBubbleTpl:getDesc(tpl)
  }
end

function this:fromBagItem(item)
  local tpl = commonItemTpl:getTplById(item.itemId)
  if not tpl then
    return nil
  end
  return {
    itemId = item.itemId,
    itemNum = item.itemNum,
    itemType = commonItemTpl:getType(tpl)
  }
end

function this:fromPetItem(item)
  if item == nil then
    return nil
  end
  if item.id == nil then
    error("petItem has no id!")
    return nil
  end
  local hide = item.is_lock or item.work_status and item.work_status ~= 0 or item.roulette_pos and item.roulette_pos ~= 0 or item.capacity_id and item.capacity_id ~= 0 or item.hero_id and item.hero_id ~= 0
  local tpl = petRankTpl:getTplById(item.id)
  return {
    itemId = item.id,
    itemNum = 1,
    itemType = petRankTpl:getPetGroup(tpl),
    guid = item.guid,
    hide = hide
  }
end

function this:fromAccessoryItem(item)
  return {
    itemId = item.accessoryId,
    itemNum = 1,
    guid = item.guid,
    hide = item.lock
  }
end

function this:fromPetEggItem(item)
  return {
    itemId = item.configId,
    itemNum = 1,
    guid = item.guid,
    hide = item.hatching or item.lock_state
  }
end

function this:fromCurrencyItem(item)
  return {
    itemId = item.attr_id,
    itemNum = item.attr_val
  }
end

function this:fromHomeBuildingItem(item)
  return {
    itemId = item.build_id,
    itemNum = item.total_num - item.used_num,
    guid = item.id
  }
end

function this:fromTaskItem(item)
  return {
    itemId = item.itemId,
    itemNum = item.itemNum
  }
end

function this:getItemNum(type, id)
  if type == L_Const.resType.commonItem then
    return C_BagMgr:getItemNumByItemId(id)
  elseif type == L_Const.resType.currency then
    return L_PlayerStore:getCurrencyNum(id)
  elseif type == L_Const.resType.accessory then
    return C_AccessoryMgr:getAccessoryNum(id)
  elseif type == L_Const.resType.petEgg then
    return L_PetStore:getPetEggNum(id)
  elseif type == L_Const.resType.pet then
    return L_PetStore:getPetNum(id)
  elseif type == L_Const.resType.hero then
    return L_HeroStore:getHasHero(id) and 1 or 0
  elseif type == L_Const.resType.soulEssence then
    return C_SoulEssenceMgr:getSoulEssenceNum(id)
  elseif type == L_Const.resType.collectionTool then
    return 0
  elseif type == L_Const.resType.homeBuilding then
    return L_HomeStore:getTotalNumByBuildingId(id)
  elseif type == L_Const.resType.taskItem then
    local num = AzurWorld.TaskMgr:GetTaskUIModule():GetTaskPropNum(id)
    return num and num or 0
  elseif type == L_Const.resType.mountSaddle then
    return AzurWorld.mountMgr:GetIdMountSaddleUnlock(id) and 1 or 0
  elseif type == L_Const.resType.book then
    return L_LibraryBookStore:isLibraryBookCollect(id) and 1 or 0
  elseif type == L_Const.resType.reputation then
    return 0
  elseif type == L_Const.resType.customAccessory then
    return C_AccessoryMgr:getAccessoryNum(accessoryCustomedTpl:getAccessoryIdById(id))
  elseif type == L_Const.resType.petSkin then
    local C_HomeManager = AzurWorld.HomeMgr
    local C_PetStore = C_HomeManager:GetPetStore()
    local hasPetSkin = C_PetStore:HasPetSkin(id)
    return hasPetSkin and 1 or 0
  elseif type == L_Const.resType.homeDormItem then
    return 0
  elseif type == L_Const.resType.chatEmoji then
    return L_ChatStore:checkEmojiOwnedDic(id) and 1 or 0
  elseif type == L_Const.resType.petCustomized then
    local cTpl = petCustomizedTpl:getTplById(id)
    return L_PetStore:getPetNum(cTpl.petId)
  end
  return C_BagMgr:getItemNumByItemId(id)
end

function this:getItemIcon(type, id)
  if type == L_Const.resType.commonItem then
    local tpl = commonItemTpl:getTplById(id)
    if tpl == nil then
      return nil
    end
    return commonItemTpl:getIcon(tpl)
  elseif type == L_Const.resType.currency then
    return currencyTpl:getIcon(currencyTpl:getTplById(id))
  elseif type == L_Const.resType.accessory then
    return accessoryTpl:getIcon(accessoryTpl:getTplById(id))
  elseif type == L_Const.resType.petEgg then
    return petEggTpl:getEggImgIcon(petEggTpl:getTplById(id))
  elseif type == L_Const.resType.hero then
  elseif type == L_Const.resType.soulEssence then
  elseif type == L_Const.resType.collectionTool then
    return collectionToolTpl:getIcon(collectionToolTpl:getTplById(id))
  elseif type == L_Const.resType.taskItem then
    return taskItemTpl:getIcon(taskItemTpl:getTplById(id))
  elseif type == L_Const.resType.mountSaddle then
    return mountSaddleTpl:getTplById(id) ~= nil and mountSaddleTpl:getIcon(mountSaddleTpl:getTplById(id)) or nil
  elseif type == L_Const.resType.customAccessory then
    return accessoryTpl:getIcon(accessoryTpl:getTplById(accessoryCustomedTpl:getAccessoryIdById(id)))
  elseif type == L_Const.resType.petSkin then
    return petSkinTpl:getIcon(petSkinTpl:getTplById(id))
  elseif type == L_Const.resType.homeDormItem then
    return homeDormItemTpl:getIcon(homeDormItemTpl:getTplById(id))
  elseif type == L_Const.resType.playerDress then
    return playerDressTpl:getIcon(id) ~= nil and playerDressTpl:getRarity(playerDressTpl:getTplById(id)) or 0
  elseif type == L_Const.resType.stargift then
  elseif type == L_Const.resType.mount then
    return mountTpl:getTplById(id) ~= nil and mountTpl:getIconByTpl(mountTpl:getTplById(id)) or 0
  elseif type == L_Const.resType.goods then
    return goodsTpl:getTplById(id) ~= nil and goodsTpl:getIcon(goodsTpl:getTplById(id)) or 0
  elseif type == L_Const.resType.pet or type == L_Const.resType.petCustomized then
  elseif type == L_Const.resType.homeBuilding then
    return buildingTpl:getBuildIcon(buildingTpl:getTplById(id))
  elseif type == L_Const.resType.book then
  elseif type == L_Const.resType.reputation then
    return currencyTpl:getIcon(currencyTpl:getTplById(id))
  elseif type == L_Const.resType.cloth then
    return clothItemTpl:getIcon(id) ~= nil and clothItemTpl:getQuality(clothItemTpl:getTplById(id)) or 0
  elseif type == L_Const.resType.heroCloth then
    return heroClothTpl:getTplById(id) ~= nil and heroClothTpl:getIcon(heroClothTpl:getTplById(id)) or 0
  elseif type == L_Const.resType.enemy then
  elseif type == L_Const.resType.playerTitle then
    return playerTitleTpl:getIcon(playerTitleTpl:getTplById(id))
  elseif type == L_Const.resType.chatEmoji then
    return chatEmojiTpl:getIcon(chatEmojiTpl:getTplById(id))
  elseif type == L_Const.resType.chatBg then
    return chatBgTpl:getIcon(chatBgTpl:getTplById(id))
  elseif type == L_Const.resType.chatBubble then
    return chatBubbleTpl:getIcon(chatBubbleTpl:getTplById(id))
  end
  return nil
end

function this:getItemQuality(type, id)
  if type == L_Const.resType.commonItem then
    local tpl = commonItemTpl:getTplById(id)
    if tpl == nil then
      return 0
    end
    return commonItemTpl:getRarity(tpl)
  elseif type == L_Const.resType.currency then
    return currencyTpl:getQuality(currencyTpl:getTplById(id))
  elseif type == L_Const.resType.accessory then
    return accessoryTpl:getRarity(accessoryTpl:getTplById(id))
  elseif type == L_Const.resType.petEgg then
    return petEggTpl:getRarity(petEggTpl:getTplById(id))
  elseif type == L_Const.resType.hero then
    return heroTpl:getRarity(heroTpl:getTplById(id))
  elseif type == L_Const.resType.soulEssence then
    return soulessenceTpl:getRarity(soulessenceTpl:getTplById(id))
  elseif type == L_Const.resType.collectionTool then
    return collectionToolTpl:getRarity(collectionToolTpl:getTplById(id))
  elseif type == L_Const.resType.taskItem then
    return taskItemTpl:getRarity(taskItemTpl:getTplById(id))
  elseif type == L_Const.resType.mountSaddle then
    return mountSaddleTpl:getTplById(id) ~= nil and mountSaddleTpl:getRarity(mountSaddleTpl:getTplById(id)) or 0
  elseif type == L_Const.resType.customAccessory then
    return accessoryTpl:getRarity(accessoryTpl:getTplById(accessoryCustomedTpl:getAccessoryIdById(id)))
  elseif type == L_Const.resType.petSkin then
    return petSkinTpl:getRarity(petSkinTpl:getTplById(id))
  elseif type == L_Const.resType.homeDormItem then
    return homeDormItemTpl:getRarity(homeDormItemTpl:getTplById(id))
  elseif type == L_Const.resType.playerDress then
    return playerDressTpl:getTplById(id) ~= nil and playerDressTpl:getRarity(playerDressTpl:getTplById(id)) or 0
  elseif type == L_Const.resType.stargift then
    return starGiftTpl:getTplById(id) ~= nil and starGiftTpl:getRarity(starGiftTpl:getTplById(id)) or 0
  elseif type == L_Const.resType.mount then
    return mountTpl:getTplById(id) ~= nil and mountTpl:getQuatityByTpl(mountTpl:getTplById(id)) or 0
  elseif type == L_Const.resType.goods then
    return goodsTpl:getTplById(id) ~= nil and goodsTpl:getRarity(goodsTpl:getTplById(id)) or 0
  elseif type == L_Const.resType.pet or type == L_Const.resType.petCustomized then
    return 4
  elseif type == L_Const.resType.homeBuilding then
    return 0
  elseif type == L_Const.resType.book then
    return 4
  elseif type == L_Const.resType.reputation then
    return currencyTpl:getQuality(currencyTpl:getTplById(id))
  elseif type == L_Const.resType.cloth then
    return clothItemTpl:getTplById(id) ~= nil and clothItemTpl:getQuality(clothItemTpl:getTplById(id)) or 0
  elseif type == L_Const.resType.heroCloth then
    return heroClothTpl:getTplById(id) ~= nil and heroClothTpl:getQuality(heroClothTpl:getTplById(id)) or 0
  elseif type == L_Const.resType.enemy then
    return 0
  elseif type == L_Const.resType.playerTitle then
    return playerTitleTpl:getRarity(playerTitleTpl:getTplById(id))
  elseif type == L_Const.resType.chatEmoji then
    return chatEmojiTpl:getRarity(chatEmojiTpl:getTplById(id))
  elseif type == L_Const.resType.chatBg then
    return chatBgTpl:getRarity(chatBgTpl:getTplById(id))
  elseif type == L_Const.resType.chatBubble then
    return chatBubbleTpl:getRarity(chatBubbleTpl:getTplById(id))
  end
  return 0
end

function this:getAllItemsOfBigType(type)
  if type == L_Const.resType.currency then
    return L_PlayerStore:getAllCurrencies()
  elseif type == L_Const.resType.accessory then
    local res = {}
    local acc = C_AccessoryMgr:getHeroAccessory()
    for key, value in pairs(acc) do
      table.insert(res, {
        guid = value.guid,
        accessoryId = value.accessoryId,
        level = value.level,
        wearHero = value.wearHero,
        bLock = value.bLock
      })
    end
    return res
  elseif type == L_Const.resType.petEgg then
    return L_PetStore:getPetEggList()
  elseif type == L_Const.resType.pet then
    return L_PetStore:getPetList()
  elseif type == L_Const.resType.homeBuilding then
    return L_HomeStore:getAllBagBuilding()
  elseif type == L_Const.resType.taskItem then
    return AzurWorld.TaskMgr:GetTaskUIModule():GetTaskPropDic()
  end
  local res = {}
  local acc = C_BagMgr:getAllItem()
  for key, value in pairs(acc) do
    table.insert(res, {
      itemType = value.itemType,
      itemId = value.itemId,
      itemNum = value.itemNum
    })
  end
  return res
end

function this:showInfoTip(itemType, itemId, guid, parentTab, notShowAccess, needItemNum)
  if itemType == L_Const.resType.hero and guid == nil then
    local entityId = itemId
    local list = {}
    table.insert(list, entityId)
    L_UI:open("pageHero", {
      heroIdList = list,
      pageType = L_Const.heroPageType.PreviewMode
    })
    return
  end
  if itemType == L_Const.resType.soulEssence then
    local entityId = itemId
    local list = {}
    table.insert(list, entityId)
    L_UI:open("pageSoulEssencePreview", {
      heroGuid = list,
      soulEssenceConfigId = itemId,
      pageType = L_Const.heroPageType.SpritronPreviewMode
    })
    return
  end
  if itemType == L_Const.resType.pet or itemType == L_Const.resType.petCustomized then
    L_UI:open("pagePetPreview", {itemType = itemType, configId = itemId})
    return
  end
  if itemType == L_Const.resType.accessory or itemType == L_Const.resType.customAccessory then
    L_UI:open("pageAccessoryInfoTipLarge", {
      guid = guid,
      itemId = itemType == L_Const.resType.accessory and itemId or accessoryCustomedTpl:getAccessoryIdById(itemId)
    })
    return
  end
  if needItemNum ~= nil and 0 < needItemNum then
    local hadCount = L_ItemTplManager:getItemNum(itemType, itemId)
    needItemNum = needItemNum > hadCount and needItemNum - hadCount or 0
  end
  L_UI:open("pageInfoTip", {
    itemType = itemType,
    itemId = itemId,
    guid = guid,
    parentTab = parentTab,
    notShowAccess = notShowAccess,
    itemNum = needItemNum
  })
end

function this:showInfoTipSelectNum(itemType, itemId, guid, curNum, maxNum, selectNumCB)
  if itemType == L_Const.resType.accessory then
    L_UI:open("pageAccessoryInfoTipLarge", {
      guid = guid,
      itemId = itemId,
      scrollToAccess = true
    })
    return
  end
  L_UI:open("pageInfoTip", {
    itemType = itemType,
    itemId = itemId,
    guid = guid,
    curNum = curNum,
    maxNum = maxNum,
    selectNumCB = selectNumCB
  })
end

function this:showInfoTipRogueInside(itemType, itemId, isRogueInside, curNum, guid, parentTab)
  L_UI:open("pageInfoTip", {
    itemType = itemType,
    itemId = itemId,
    guid = guid,
    parentTab = parentTab,
    isRogueInside = isRogueInside,
    curNum = curNum
  })
end

local function utf8_chars(s)
  local t = {}
  local i = 1
  local len = #s
  while i <= len do
    local c = s:byte(i)
    local n = 1
    if 240 <= c then
      n = 4
    elseif 224 <= c then
      n = 3
    elseif 192 <= c then
      n = 2
    else
      n = 1
    end
    table.insert(t, s:sub(i, i + n - 1))
    i = i + n
  end
  return t
end

function this:getNameLength(name)
  local chars = utf8_chars(name or "")
  return #chars
end

function this:getSplitName(s, maxCount)
  if type(s) ~= "string" or maxCount == nil or maxCount <= 0 then
    return s
  end
  local chars = utf8_chars(s)
  if maxCount >= #chars then
    return s
  end
  local out = table.concat(chars, "", 1, maxCount)
  return out .. "..."
end

function this:getItemSpecialDesc(type, id)
  if type == L_Const.resType.commonItem then
    return commonItemTpl:getSpecialDesc(commonItemTpl:getTplById(id))
  elseif type == L_Const.resType.currency then
    return currencyTpl:getSpecialDesc(currencyTpl:getTplById(id))
  elseif type == L_Const.resType.petEgg then
    return petEggTpl:getSpecialDesc(petEggTpl:getTplById(id))
  elseif type == L_Const.resType.collectionTool then
    return collectionToolTpl:getSpecialDesc(collectionToolTpl:getTplById(id))
  elseif type == L_Const.resType.taskItem then
    return taskItemTpl:getSpecialDesc(taskItemTpl:getTplById(id))
  elseif type == L_Const.resType.mountSaddle then
    return mountSaddleTpl:getSpecialDesc(mountSaddleTpl:getTplById(id))
  elseif type == L_Const.resType.playerTitle then
    return playerTitleTpl:getSpecialDesc(playerTitleTpl:getTplById(id))
  elseif type == L_Const.resType.playerDress then
    return playerDressTpl:getSpecialDesc(playerDressTpl:getTplById(id))
  elseif type == L_Const.resType.petSkin then
    return petSkinTpl:getSpecialDesc(petSkinTpl:getTplById(id))
  elseif type == L_Const.resType.homeDormItem then
    return homeDormItemTpl:getSpecialDesc(homeDormItemTpl:getTplById(id))
  end
  return nil
end

function this:req_composeSoulEssence(param, lastlv, lastprop, callback)
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.SpiritStrength))
    return
  end
  local data = param
  L_Net:sendMessage(MsgGenCode.CSProtoComposeSoulEssence, data, function(sData, errorCode)
    if callback then
      callback(sData, errorCode)
    end
    local currData = C_SoulEssenceMgr:getsoulessenceItem(data.guid)
    if currData.level > lastlv then
      L_UI:open("pageSoulEssenceStrengthSuccess", {
        guid = data.guid,
        curPropertyList = lastprop
      })
    end
    if sData.rewards then
      local data = sData.rewards
      data.title = L_WordsTpl:getValue("notice_soulessenceStore")
      L_RewardManager:showPage(data, sData.src)
    end
  end)
end

function this:req_risingStarSoulEssence(param, callback)
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.SpiritStrength))
    return
  end
  local data = param
  L_Net:sendMessage(MsgGenCode.CSProtoRisingStarSoulEssence, data, function(sData, errorCode)
    if callback then
      callback(sData, errorCode)
    end
  end)
end

function this:getItemShowStarNum(itemType, itemId)
  if itemType == nil or itemId == nil then
    return 0
  end
  return AzurWorld.ItemMgr:GetItemShowStarNum(itemType, itemId)
end

return this
