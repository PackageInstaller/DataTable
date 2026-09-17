local this = class("itemManager", G_EventManagerBase)

function this:parseItem(itemType, itemId, guid)
  local data = {}
  if itemType == L_Const.resType.commonItem then
    data = self:parseCommonItem(itemId)
  elseif itemType == L_Const.resType.hero then
    data = self:parseHeroItem(itemId)
  elseif itemType == L_Const.resType.soulEssence then
    data = self:parsesoulessenceItem(itemId)
  elseif itemType == L_Const.resType.accessory then
    data = self:parseAccessoryItem(itemId)
  elseif itemType == L_Const.resType.homeBuilding then
    data = self:parseBuildingItem(itemId)
  elseif itemType == L_Const.resType.currency then
    data = self:parseCurrencyItem(itemId)
  elseif itemType == L_Const.resType.mount then
    data = self:parseMountItem(itemId, guid)
  elseif itemType == L_Const.resType.petEgg then
    data = self:parsePetEggItem(itemId, guid)
  elseif itemType == L_Const.resType.pet then
    local petItem = L_PetStore:getPetItem(guid)
    data = self:parsePetItem(itemId, petItem and petItem:isSpecialPet() or false)
  elseif itemType == L_Const.resType.playerTitle then
    data = self:parsePlayerTitleData(itemId, guid)
  elseif itemType == L_Const.resType.playerDress then
    data = self:parsePlayerDressItem(itemId)
  elseif itemType == L_Const.resType.stargift then
    data = self:parseStarGiftItem(itemId)
  elseif itemType == L_Const.resType.collectionTool then
    data = self:parseCollectionToolItem(itemId)
  elseif itemType == L_Const.resType.mountSaddle then
    data = self:parseMountSaddleItem(itemId)
  elseif itemType == L_Const.resType.petSkin then
    data = self:parsePetSkinItem(itemId)
  elseif itemType == L_Const.resType.homeDormItem then
    data = self:parseHomeDormItem(itemId)
  end
  if not table.isEmpty(data) then
    data.itemId = itemId
    data.itemType = itemType
  end
  return data
end

function this:parseCommonItem(itemId)
  local commonItemTpl = L_GameTpl:getCommonItemTpl()
  local tpl = commonItemTpl:getTplById(itemId)
  local item = C_BagMgr:getItem(itemId)
  local quality = commonItemTpl:getRarity(tpl)
  local key = L_Const.qualityToKey[quality]
  local commonItemTypeIconTpl = L_GameTpl:getCommonItemTypeIconTpl()
  local tab = commonItemTpl:getTab(tpl)
  local commonTpl = commonItemTypeIconTpl:getTplById(L_Const.resType.commonItem)
  local type = commonItemTpl:getType(tpl)
  local desc = commonItemTpl:getDesc(tpl)
  local specialDesc = commonItemTpl:getSpecialDesc(tpl)
  return {
    itemType = L_Const.resType.commonItem,
    itemId = itemId,
    name = commonItemTpl:getName(tpl),
    num = item and item.itemNum or 0,
    icon = commonItemTpl:getIcon(tpl),
    quality = quality,
    config = tpl,
    desc = desc,
    specialDesc = specialDesc,
    imgQuality = string.format("Page/BSCommon/tex_icon_iconbg_%s", key),
    type = type,
    canUseInBag = commonItemTpl:getCanUse(tpl),
    tab = tab,
    inBag = commonItemTpl:getInBag(tpl),
    subId = commonItemTpl:getSubId(tpl),
    imgType = commonItemTypeIconTpl:getIcon(commonTpl)
  }
end

function this:parseHeroItem(itemId)
  local unitID = L_GameUtil.getUnitIdByRole(itemId, L_Const.roleType.hero)
  local heroTpl = L_GameTpl:getHeroTpl()
  local tpl = heroTpl:getTplById(itemId)
  local key = L_Const.qualityToKey[heroTpl:getRarity(tpl)]
  local _, qualityColor = C_ColorUtility.TryParseHtmlString(L_Const.qualityColor[key])
  local _, carrerColor = C_ColorUtility.TryParseHtmlString(L_Const.elementColor[heroTpl:getElement(tpl)])
  return {
    itemType = L_Const.resType.hero,
    itemId = itemId,
    name = heroTpl:getName(tpl),
    icon = L_GameUtil.getAvatarTexturePath(itemId, L_Const.avatarTextureIndex.head) or "",
    iconBattle = L_GameUtil.getAvatarTexturePath(itemId, L_Const.avatarTextureIndex.head_circle) or "",
    iconHalf = L_GameUtil.getAvatarTexturePath(itemId, L_Const.avatarTextureIndex.half_formation) or "",
    iconRaffle = L_GameUtil.getAvatarTexturePath(itemId, L_Const.avatarTextureIndex.half_raffle) or "",
    iconFull = L_GameUtil.getAvatarTexturePath(itemId, L_Const.avatarTextureIndex.painting) or "",
    quality = heroTpl:getRarity(tpl),
    desc = heroTpl:getDec(tpl),
    unitID = unitID,
    headBg = string.format("Page/BSHeroStar/tex_herorankup_bg_%s", key),
    heroFrame = string.format("Page/BSHeroStar/tex_herorankup_frame_%s", key),
    imgQuality = string.format("Page/BSCommon/tex_icon_iconbg_%s", key),
    qualityColor = qualityColor,
    carrerColor = carrerColor,
    position = heroTpl:getPosition(tpl),
    lifeSkill = heroTpl:getLifeskillDesc(tpl)
  }
end

function this:parsesoulessenceItem(itemId)
  local soulessenceTpl = L_GameTpl:getSoulessenceTpl()
  local tpl = soulessenceTpl:getTplById(itemId)
  local key = L_Const.qualityToKey[soulessenceTpl:getRarity(tpl)]
  local avatarTexture = soulessenceTpl:getAvatarTexture(tpl, 2)
  return {
    itemType = L_Const.resType.soulEssence,
    itemId = itemId,
    name = soulessenceTpl:getName(tpl),
    icon = avatarTexture,
    iconHalf = avatarTexture,
    quality = soulessenceTpl:getRarity(tpl),
    desc = soulessenceTpl:getDesc(tpl),
    spinepath = soulessenceTpl:getSpinePath(tpl),
    startAnim = soulessenceTpl:getStartAnimation(tpl),
    lvBgColor = L_Const.lvBgColor[soulessenceTpl:getRarity(tpl)],
    imgQuality = string.format("Page/SoulEssence/tex_herosoulessence_frame_%s", soulessenceTpl:getRarity(tpl)),
    imgQuality_small = string.format("BSCommon/tex_icon_iconbg_%s", key)
  }
end

function this:parseAccessoryItem(itemId)
  local accessoryTpl = L_GameTpl:getAccessoryTpl()
  local tpl = accessoryTpl:getTplById(itemId)
  local key = L_Const.qualityToKey[accessoryTpl:getRarity(tpl)]
  return {
    itemType = L_Const.resType.accessory,
    itemId = itemId,
    name = accessoryTpl:getName(tpl),
    icon = accessoryTpl:getIcon(tpl),
    quality = accessoryTpl:getRarity(tpl),
    imgQuality = string.format("Page/BSCommon/tex_icon_iconbg_%s", key),
    imgQuality_info = string.format("Page/BSCommon/tex_item_tip_title_%s", key),
    imgQuality_slot = string.format("Page/BSJewelry/tex_accessory_icon_bg_%s", key),
    type = accessoryTpl:getType(tpl)
  }
end

function this:parseBuildingItem(itemId)
  local buildingTpl = L_GameTpl:getHomeBuildingTpl()
  local tpl = buildingTpl:getTplById(itemId)
  return {
    itemType = L_Const.resType.building,
    itemId = itemId,
    name = buildingTpl:getName(tpl),
    icon = nil,
    desc = buildingTpl:getDesc(tpl),
    level = buildingTpl:getLevel(tpl),
    prosperity = buildingTpl:getProsperity(tpl)
  }
end

function this:parseMountItem(itemId)
  local mountTpl = L_GameTpl:getMountTpl()
  local tpl = mountTpl:getTplById(itemId)
  local icon = mountTpl:getIconByTpl(tpl)
  local name = mountTpl:getNameByTpl(tpl)
  local quality = mountTpl:getQuatityByTpl(tpl)
  local key = L_Const.qualityToKey[quality]
  local desc = mountTpl:getDescByTpl(tpl)
  return {
    itemType = L_Const.resType.mount,
    itemId = itemId,
    name = name,
    icon = icon,
    quality = quality,
    config = tpl,
    desc = desc,
    imgQuality = string.format("BSCommon/tex_icon_iconbg_%s", key)
  }
end

function this:parseCurrencyItem(itemId)
  local currencyTpl = L_GameTpl:getCurrencyTpl()
  local tpl = currencyTpl:getTplById(itemId)
  local key = L_Const.qualityToKey[currencyTpl:getQuality(tpl)]
  return {
    itemType = L_Const.resType.currency,
    itemId = itemId,
    name = currencyTpl:getName(tpl),
    num = L_PlayerStore:getCurrencyNum(itemId),
    icon = currencyTpl:getIcon(tpl),
    quality = currencyTpl:getQuality(tpl),
    imgQuality = string.format("BSCommon/tex_icon_iconbg_%s", key),
    desc = currencyTpl:getDesc(tpl)
  }
end

function this:parsePlayerTitleData(itemId)
  local playerTitleTpl = L_GameTpl:getPlayerTitleTpl()
  local tpl = playerTitleTpl:getTplById(itemId)
  local quality = playerTitleTpl:getRarity(tpl)
  local key = L_Const.qualityToKey[quality] or L_Const.quality.n
  return {
    itemType = L_Const.resType.playerTitle,
    itemId = itemId,
    name = playerTitleTpl:getItemName(tpl),
    icon = playerTitleTpl:getIcon(tpl),
    desc = playerTitleTpl:getDesc(tpl),
    specialDesc = playerTitleTpl:getSpecialDesc(tpl),
    quality = quality,
    special = playerTitleTpl:getSpecial(tpl),
    showType = playerTitleTpl:getType(tpl),
    wayList = playerTitleTpl:getWayList(tpl),
    imgQuality = string.format("Page/BSCommon/tex_icon_iconbg_%s", key)
  }
end

function this:parsePlayerDressItem(itemId)
  local playerDressTpl = L_GameTpl:getPlayercardDressTpl()
  local tpl = playerDressTpl:getTplById(itemId)
  local quality = playerDressTpl:getRarity(tpl)
  local key = L_Const.qualityToKey[quality] or L_Const.quality.n
  return {
    itemType = L_Const.resType.playerDress,
    itemId = itemId,
    name = playerDressTpl:getItemName(tpl),
    icon = playerDressTpl:getIcon(tpl),
    quality = quality,
    desc = playerDressTpl:getDesc(tpl),
    specialDesc = playerDressTpl:getSpecialDesc(tpl),
    showType = playerDressTpl:getType(tpl),
    wayList = playerDressTpl:getWayList(tpl),
    imgQuality = string.format("Page/BSCommon/tex_icon_iconbg_%s", key)
  }
end

function this:parsePetEggItem(itemId, guid)
  local petEggTpl = L_GameTpl:getPetEggTpl()
  local tpl = petEggTpl:getTplById(itemId)
  local icon = petEggTpl:getEggImgIcon(tpl)
  local name = L_WordsTpl:getValue("ui_itemManager")
  local quality = 1
  local key = L_Const.quality.n
  local desc = ""
  return {
    itemType = L_Const.resType.petEgg,
    itemId = itemId,
    name = name,
    num = 1,
    icon = icon,
    quality = quality,
    config = tpl,
    desc = desc,
    imgQuality = string.format("Temp/tex_icon_raritycirclet_%s", key),
    dropType = L_Const.dropItemType.Crystal,
    dropImg = petEggTpl:getEggImgDrop(tpl)
  }
end

function this:parsePetItem(itemId, isSpecial)
  local id = itemId
  local petInfoTpl = L_GameTpl:getPetTpl()
  local tpl = petInfoTpl:getTplById(id)
  if table.isEmpty(tpl) then
    return {}
  end
  local petIcon = petInfoTpl:getPetIcon(tpl, isSpecial)
  local petName = petInfoTpl:getName(tpl, isSpecial)
  return {
    itemType = L_Const.resType.pet,
    itemId = itemId,
    name = petName,
    icon = petIcon,
    num = 1,
    quality = 1,
    imgQuality = "BSCommon/tex_icon_iconbg_n",
    desc = petName,
    dropType = L_Const.dropItemType.Crystal
  }
end

function this:parseEnemyItem(itemId)
  local dungeonEnemyTpl = L_GameTpl:getDungeonEnemyTpl()
  local tpl = dungeonEnemyTpl:getTplById(itemId)
  return {
    name = dungeonEnemyTpl:getName(tpl),
    icon = dungeonEnemyTpl:getAvatarTexture(tpl),
    desc = dungeonEnemyTpl:getDescription(tpl)
  }
end

function this:parseStarGiftItem(itemId)
  local starGiftTpl = L_GameTpl:getStargiftTpl()
  local tpl = starGiftTpl:getTplById(itemId)
  return {
    itemType = L_Const.resType.stargift,
    itemId = itemId,
    name = starGiftTpl:getName(tpl),
    icon = starGiftTpl:getTexture(tpl, L_Const.avatarTextureIndex.head),
    quality = starGiftTpl:getRarity(tpl),
    config = tpl,
    desc = starGiftTpl:getDec(tpl)
  }
end

function this:parseCollectionToolItem(itemId)
  local collectionToolTpl = L_GameTpl:getCollectionToolTpl()
  local tpl = collectionToolTpl:getTplById(itemId)
  return {
    itemType = L_Const.resType.collectionTool,
    itemId = itemId,
    name = collectionToolTpl:getName(tpl),
    icon = collectionToolTpl:getIcon(tpl),
    quality = collectionToolTpl:getRarity(tpl),
    config = tpl,
    desc = collectionToolTpl:getDesc(tpl)
  }
end

function this:parseMountSaddleItem(itemId)
  local mountSaddleTpl = L_GameTpl:getMountSaddleTpl()
  local tpl = mountSaddleTpl:getTplById(itemId)
  return {
    itemType = L_Const.resType.mountSaddle,
    itemId = itemId,
    name = mountSaddleTpl:getName(tpl),
    icon = mountSaddleTpl:getIcon(tpl),
    quality = mountSaddleTpl:getRarity(tpl),
    config = tpl,
    desc = mountSaddleTpl:getDesc(tpl)
  }
end

function this:parsePetSkinItem(itemId)
  local petSkinTpl = L_GameTpl:getPetSkinTpl()
  local tpl = petSkinTpl:getTplById(itemId)
  return {
    itemType = L_Const.resType.petSkin,
    itemId = itemId,
    name = petSkinTpl:getName(tpl),
    icon = petSkinTpl:getIcon(tpl),
    quality = petSkinTpl:getRarity(tpl),
    config = tpl,
    desc = petSkinTpl:getDesc(tpl)
  }
end

function this:parseHomeDormItem(itemId)
  local homeDormItemTpl = L_GameTpl:getHomeDormItemTpl()
  local tpl = homeDormItemTpl:getTplById(itemId)
  return {
    itemType = L_Const.resType.homeDormItem,
    itemId = itemId,
    name = homeDormItemTpl:getName(tpl),
    icon = homeDormItemTpl:getIcon(tpl),
    quality = homeDormItemTpl:getRarity(tpl),
    config = tpl,
    desc = homeDormItemTpl:getDesc(tpl)
  }
end

return this
