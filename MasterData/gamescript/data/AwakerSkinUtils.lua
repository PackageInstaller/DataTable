local AwakerSkinUtils = {}
local AwakerSkinListMap = {}
local ItemToSkinMap = {}

function AwakerSkinUtils.Reset()
  table.clear(AwakerSkinListMap)
end

function AwakerSkinUtils.GetSkinConfig(skinTid)
  return DT.AwakerSkin[skinTid] or {}
end

function AwakerSkinUtils.GetBattleReplaceList(skinTid)
  if not skinTid or skinTid == cd.DefaultSkinTid then
    return
  end
  skinTid = AwakerSkinUtils.UnifyToSkinTid(skinTid)
  local skinCfg = AwakerSkinUtils.GetSkinConfig(skinTid)
  return skinCfg and skinCfg.ReplaceCombatResources
end

function AwakerSkinUtils._InitSkinMap()
  for skinTid, skinCfg in pairs(DT.AwakerSkin) do
    if skinCfg.OwnerAwaker then
      AwakerSkinListMap[skinCfg.OwnerAwaker] = AwakerSkinListMap[skinCfg.OwnerAwaker] or {}
      table.insert(AwakerSkinListMap[skinCfg.OwnerAwaker], skinTid)
    end
    if skinCfg.Item then
      assert(not ItemToSkinMap[skinCfg.Item], string.format("Skin Item %s has multiple skins %s and %s", skinCfg.Item, ItemToSkinMap[skinCfg.Item], skinTid))
      ItemToSkinMap[skinCfg.Item] = skinTid
    end
  end
end

function AwakerSkinUtils.GetAwakerSkinList(awakerTid)
  if not table.next(AwakerSkinListMap) then
    AwakerSkinUtils._InitSkinMap()
  end
  local skinList = AwakerSkinListMap[awakerTid]
  local validSkinList = {}
  local now = TimeUtils.GetServerTime()
  for _, skinId in ipairs(skinList or {}) do
    local skinCfg = AwakerSkinUtils.GetSkinConfig(skinId)
    if skinCfg.OpenDate and now < skinCfg.OpenDate then
    else
      if skinCfg.ClothersDisplayDate and now < skinCfg.ClothersDisplayDate then
        local skinItem = AwakerSkinUtils.GetItemTidBySkin(skinId)
        if not skinItem or 0 == ItemDataUtils.GetBagItemNum(skinItem) then
      end
      else
        table.insert(validSkinList, skinId)
      end
    end
  end
  return validSkinList
end

function AwakerSkinUtils.IsAwakerHasNewSkin(awakerTid)
  local skinList = AwakerSkinUtils.GetAwakerSkinList(awakerTid)
  for _, skinTid in ipairs(skinList) do
    if AwakerSkinUtils.IsNewSkin(skinTid) then
      return true
    end
  end
  return false
end

function AwakerSkinUtils.IsDynamicSkinRes(skinRes)
  local skinCfg = AwakerSkinUtils.GetSkinCfgBySkinRes(skinRes)
  if not skinCfg or not skinCfg.Quality then
    return false
  end
  if AwakerSkinDefine.SkinQualityStarNum[skinCfg.Quality] >= 4 then
    return true
  end
  return false
end

function AwakerSkinUtils.GetSkinCfgBySkinRes(skinRes)
  for _, skinCfg in pairs(DT.AwakerSkin) do
    if skinCfg.ClothersResNum == skinRes then
      return skinCfg
    end
  end
end

function AwakerSkinUtils.IsReplaceBattleEffect(skinTid)
  local replaceList = AwakerSkinUtils.GetBattleReplaceList(skinTid)
  return replaceList and table.contains(replaceList, cd.SkinReplace.BattleEffect)
end

function AwakerSkinUtils.IsReplaceBattleSpine(skinTid)
  local replaceList = AwakerSkinUtils.GetBattleReplaceList(skinTid)
  return replaceList and table.contains(replaceList, cd.SkinReplace.BattleSpine)
end

function AwakerSkinUtils.IsReplaceBattleAudio(skinTid)
  local replaceList = AwakerSkinUtils.GetBattleReplaceList(skinTid)
  return replaceList and table.contains(replaceList, cd.SkinReplace.BattleAudio)
end

function AwakerSkinUtils.IsReplaceBattleTalk(skinTid)
  local replaceList = AwakerSkinUtils.GetBattleReplaceList(skinTid)
  return replaceList and table.contains(replaceList, cd.SkinReplace.BattleTalk)
end

function AwakerSkinUtils.IsNewSkin(skinTid)
  if not skinTid or skinTid == CommonDefine.DefaultSkinTid then
    return false
  end
  if not AwakerSkinUtils.IsOwnSkin(skinTid) then
    return false
  end
  local isNew = ClientDataUtils.GetData(CommonDefine.ClientDataMainKey.NewObtainSkin, skinTid, cd.NumberTrue)
  return isNew == cd.NumberTrue
end

function AwakerSkinUtils.ClearNewSkinTag(skinTid)
  ClientDataUtils.SetData(CommonDefine.ClientDataMainKey.NewObtainSkin, skinTid, cd.NumberFalse)
end

function AwakerSkinUtils.ReplaceSkinRes(resName, curSkin)
  if not curSkin or curSkin == CommonDefine.DefaultSkinTid then
    return resName
  end
  curSkin = AwakerSkinUtils.UnifyToSkinTid(curSkin)
  local skinCfg = curSkin and AwakerSkinUtils.GetSkinConfig(curSkin)
  if not skinCfg then
    return resName
  end
  local awakerTid = skinCfg.OwnerAwaker
  if not awakerTid then
    return resName
  end
  do return AwakerDataUtils.ReplaceSkinTidRes, resName, awakerTid end
  return AwakerDataUtils.ReplaceSkinTidRes, resName, awakerTid, curSkin
end

function AwakerSkinUtils.GetAwakerSkinListWithDefault(awakerTid)
  local skinList = AwakerSkinUtils.GetAwakerSkinList(awakerTid)
  table.insert(skinList, 1, CommonDefine.DefaultSkinTid)
  return skinList
end

function AwakerSkinUtils.GetSkinByItem(itemTid)
  if not table.next(ItemToSkinMap) then
    AwakerSkinUtils._InitSkinMap()
  end
  return ItemToSkinMap[itemTid]
end

function AwakerSkinUtils.GetItemTidBySkin(skinTid)
  local skinCfg = AwakerSkinUtils.GetSkinConfig(skinTid)
  return skinCfg and skinCfg.Item
end

function AwakerSkinUtils.IsOwnSkin(skinTid, awakerTid)
  skinTid = AwakerSkinUtils.UnifyToSkinTid(skinTid)
  if skinTid == CommonDefine.DefaultSkinTid then
    if awakerTid then
      do return AwakerDataUtils.HasOwnedAwaker end
      return AwakerDataUtils.HasOwnedAwaker, awakerTid, nil, nil
    end
    return true
  end
  if AwakerSkinUtils.IsDressing(skinTid) then
    return true
  end
  local skinCfg = AwakerSkinUtils.GetSkinConfig(skinTid)
  local itemTid = skinCfg and skinCfg.Item
  if itemTid then
    return ItemDataUtils.GetBagItemNum(itemTid) > 0
  end
end

function AwakerSkinUtils.GetSkinByShopItem(shopItemTid)
  local shopItemCfg = ShopDataUtils.GetShopItemCfg(shopItemTid)
  local item = shopItemCfg and shopItemCfg.Item[1]
  if not item then
    return
  end
  do return AwakerSkinUtils.GetSkinByItem end
  return AwakerSkinUtils.GetSkinByItem, item
end

function AwakerSkinUtils.GetAwakerTidBySkin(skinTid)
  skinTid = AwakerSkinUtils.UnifyToSkinTid(skinTid)
  local skinCfg = AwakerSkinUtils.GetSkinConfig(skinTid)
  return skinCfg and skinCfg.OwnerAwaker
end

function AwakerSkinUtils.UnifyToSkinTid(itemOrShopOrSkinTid)
  if not itemOrShopOrSkinTid or itemOrShopOrSkinTid == cd.DefaultSkinTid then
    return itemOrShopOrSkinTid
  end
  local skinCfg = AwakerSkinUtils.GetSkinConfig(itemOrShopOrSkinTid)
  if skinCfg and table.next(skinCfg) then
    return itemOrShopOrSkinTid
  end
  local shopSkinTid = AwakerSkinUtils.GetSkinByShopItem(itemOrShopOrSkinTid)
  if shopSkinTid then
    return shopSkinTid
  end
  local skinTid = AwakerSkinUtils.GetSkinByItem(itemOrShopOrSkinTid)
  return skinTid
end

function AwakerSkinUtils.GetSkinName(skinTid)
  if not skinTid or skinTid == CommonDefine.DefaultSkinTid then
    do return LT.Text end
    return LT.Text, "DefaultWord"
  end
  skinTid = AwakerSkinUtils.UnifyToSkinTid(skinTid)
  local skinCfg = DT.AwakerSkin[skinTid]
  if not skinCfg then
    return ""
  end
  return skinCfg.Name
end

function AwakerSkinUtils.GetAwakerDressedSkin(awakerTid, isJumpMockData)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid, isJumpMockData)
  if not awakerData then
    return nil
  end
  local skinItemTid = awakerData.curSkin
  if skinItemTid == CommonDefine.DefaultSkinTid then
    return nil
  end
  do return AwakerSkinUtils.GetSkinByItem end
  return AwakerSkinUtils.GetSkinByItem, skinItemTid
end

function AwakerSkinUtils.IsDressing(skinTid, awakerTid)
  skinTid = AwakerSkinUtils.UnifyToSkinTid(skinTid)
  local skinCfg = AwakerSkinUtils.GetSkinConfig(skinTid)
  local dressedSkinTid = AwakerSkinUtils.GetAwakerDressedSkin(awakerTid or skinCfg.OwnerAwaker)
  if not dressedSkinTid and skinTid == CommonDefine.DefaultSkinTid then
    return true
  end
  return dressedSkinTid == skinTid
end

function AwakerSkinUtils.IsOffSell(skinTid)
  skinTid = AwakerSkinUtils.UnifyToSkinTid(skinTid)
  local skinItemTid = AwakerSkinUtils.GetItemTidBySkin(skinTid)
  local serverTime = TimeUtils.GetServerTime()
  for shopTid, shopCfg in pairs(DT.Shop) do
    for sellItemTid, num in table.iteraDouble(shopCfg.Item) do
      if sellItemTid == skinItemTid and serverTime > (shopCfg.OffSaleDate or math.huge) then
        return true
      end
    end
  end
  return false
end

function AwakerSkinUtils.IsSellInShop(skinTid)
  skinTid = AwakerSkinUtils.UnifyToSkinTid(skinTid)
  local skinItemTid = AwakerSkinUtils.GetItemTidBySkin(skinTid)
  local serverTime = TimeUtils.GetServerTime()
  for shopTid, shopCfg in pairs(DT.Shop) do
    for sellItemTid, num in table.iteraDouble(shopCfg.Item) do
      if sellItemTid == skinItemTid and serverTime > (shopCfg.OnSaleDate or 0) and serverTime < (shopCfg.OffSaleDate or math.huge) then
        return true
      end
    end
  end
  return false
end

function AwakerSkinUtils.GetAwakerDefaultFullHeadImg(awakerTid)
  local config = AwakerDataUtils.GetAwakerConfig(awakerTid)
  if not config then
    return
  end
  do return string.format, "Portraits/Fullhead/Portrait_Fullhead_Awaker_%s.png" end
  return string.format, "Portraits/Fullhead/Portrait_Fullhead_Awaker_%s.png", config.AwakerResNum
end

function AwakerSkinUtils.IsAwakerOwnSkil(awakerTid)
  local skinList = AwakerSkinUtils.GetAwakerSkinList(awakerTid)
  for _, skinTid in ipairs(skinList) do
    if AwakerSkinUtils.IsOwnSkin(skinTid) then
      return true
    end
  end
end

function AwakerSkinUtils.GetSkinResNum(skinTid, awakerTid)
  if not skinTid or skinTid == CommonDefine.DefaultSkinTid then
    if awakerTid then
      do return AwakerDataUtils.GetAwakerResNum, awakerTid end
      return AwakerDataUtils.GetAwakerResNum, awakerTid, true
    end
    return
  end
  skinTid = AwakerSkinUtils.UnifyToSkinTid(skinTid)
  local cfg = AwakerSkinUtils.GetSkinConfig(skinTid)
  return cfg.ClothersResNum
end

function AwakerSkinUtils.GetSkinFullHeadImg(skinTid)
  local resNum = AwakerSkinUtils.GetSkinResNum(skinTid)
  do return string.format, "Portraits/Fullhead/Portrait_Fullhead_Awaker_%s.png" end
  return string.format, "Portraits/Fullhead/Portrait_Fullhead_Awaker_%s.png", resNum
end

return AwakerSkinUtils
