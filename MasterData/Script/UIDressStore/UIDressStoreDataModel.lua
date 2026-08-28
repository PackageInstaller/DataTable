local View = require("UIDressStore/UIDressStoreView")
local DataModel = {}
DataModel.shopId = nil
DataModel.isBack = false
DataModel.shopItemTypes = {}
DataModel.defaultShopItemType = nil
DataModel.curSelectShopItemType = nil
DataModel.allShopItems = {}
DataModel.curTypeShopItems = {}

function DataModel.Init()
  for i, v in ipairs(PlayerData:GetFactoryData(99900014, "ConfigFactory").dressTypeOrder) do
    table.insert(DataModel.shopItemTypes, v.id)
  end
  DataModel.defaultShopItemType = PlayerData:GetFactoryData(99900014, "ConfigFactory").defaultDressType
end

function DataModel.SetJsonData(json)
  if not json then
    return
  end
  local data = Json.decode(json)
  DataModel.shopItems = data.shopItems
  DataModel.shopId = data.shopId
end

function DataModel.InitData()
  DataModel.isBack = false
  DataModel.InitAllShopItems()
  PlayerData.CaptainSkinSystem:InitChangeSkinCacheData()
end

function DataModel.InitAllShopItems()
  local dressData = PlayerData.CaptainSkinSystem:GetAllSkinData()
  DataModel.allShopItems = {}
  local skinCA
  for index, id in pairs(DataModel.shopItems) do
    local commodityCA = PlayerData:GetFactoryData(id, "CommodityFactory")
    for _, cfg in pairs(commodityCA.commodityItemList) do
      skinCA = PlayerData:GetFactoryData(cfg.id, "HomeCharacterSkinFactory")
      DataModel.allShopItems[skinCA.skinType] = DataModel.allShopItems[skinCA.skinType] or {}
      local shopItem, skinUid
      for uid, v in pairs(dressData) do
        if v.id == tostring(cfg.id) then
          skinUid = uid
          break
        end
      end
      if skinUid then
        shopItem = ChangeSkinUtil.GenerateSkinItem(cfg.id, skinUid)
      else
        shopItem = ChangeSkinUtil.GenerateSkinItem(cfg.id, skinUid, id)
      end
      table.insert(DataModel.allShopItems[skinCA.skinType], shopItem)
    end
  end
  local guard = PlayerData.CaptainSkinSystem:GetNormalSkinData()
  local skinData
  for skinType, skinUid in pairs(guard) do
    skinData = dressData[skinUid]
    if skinData then
      local itemId = tonumber(skinData.id)
      if not DataModel.IsShopHave(itemId) then
        local shopItem = ChangeSkinUtil.GenerateSkinItem(itemId, skinUid)
        DataModel.allShopItems[tonumber(skinType)] = DataModel.allShopItems[tonumber(skinType)] or {}
        table.insert(DataModel.allShopItems[tonumber(skinType)], shopItem)
      end
    end
  end
  local guard_many = PlayerData.CaptainSkinSystem:GetOverlaySkinData()
  for skinType, skinUidList in pairs(guard_many) do
    for index, skinUid in ipairs(skinUidList) do
      skinData = dressData[skinUid]
      if skinData then
        local itemId = tonumber(skinData.id)
        if not DataModel.IsShopHave(itemId) then
          local shopItem = ChangeSkinUtil.GenerateSkinItem(itemId, skinUid)
          DataModel.allShopItems[tonumber(skinType)] = DataModel.allShopItems[tonumber(skinType)] or {}
          table.insert(DataModel.allShopItems[tonumber(skinType)], shopItem)
        end
      end
    end
  end
  local defaultHairId = PlayerData.CaptainSkinSystem.defaultHairId
  local hairSkinItem = ChangeSkinUtil.GenerateSkinItem(defaultHairId)
  DataModel.allShopItems[EnumDefine.ESkinType.Hair] = DataModel.allShopItems[EnumDefine.ESkinType.Hair] or {}
  table.insert(DataModel.allShopItems[EnumDefine.ESkinType.Hair], hairSkinItem)
end

function DataModel.RefreshOnShow()
  if DataModel.defaultShopItemType then
    DataModel.SetCurSkinListByType(DataModel.defaultShopItemType)
  end
  ChangeSkinUtil.InitUICaptainSpineSkin(View.Group_Character.SpineAnimation_, "dorm_stand")
  View.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
  local placeId = HomeStationStoreManager:GetCurStationPlace()
  local stationPlaceCA = PlayerData:GetFactoryData(placeId, "HomeStationPlaceFactory")
  View.Img_Bg:SetSprite(stationPlaceCA.bgStore)
end

local function GetCustomSort(skinItem)
  local isDefault = ChangeSkinUtil.IsDefaultSkin(skinItem.itemId)
  if isDefault then
    return -1
  end
  local isHave = PlayerData.CaptainSkinSystem:IsSkinHave(skinItem.itemId)
  local isWear = PlayerData.CaptainSkinSystem:IsSkinCurShow(skinItem)
  if isHave and isWear then
    return 0
  end
  if not isHave then
    return 1
  end
  if isHave and not isWear then
    return 2
  end
end

function DataModel.SetCurSkinListByType(skinType)
  DataModel.curSelectShopItemType = skinType
  View.Group_RightPanel.Group_Top.ScrollGrid_SkinType.grid.self:SetDataCount(table.count(DataModel.shopItemTypes))
  View.Group_RightPanel.Group_Top.ScrollGrid_SkinType.grid.self:RefreshAllElement()
  DataModel.curTypeShopItems = DataModel.allShopItems[skinType] or {}
  table.sort(DataModel.curTypeShopItems, function(a, b)
    return GetCustomSort(a) < GetCustomSort(b)
  end)
  View.Group_RightPanel.Group_Middle.ScrollGrid_Skin.grid.self:SetDataCount(#DataModel.curTypeShopItems)
  View.Group_RightPanel.Group_Middle.ScrollGrid_Skin.grid.self:RefreshAllElement()
  View.Group_RightPanel.Group_Middle.Img_NoCloth:SetActive(#DataModel.curTypeShopItems == 0)
end

function DataModel.IsShopHave(skinId)
  for index, id in pairs(DataModel.shopItems) do
    local commodityCA = PlayerData:GetFactoryData(id, "CommodityFactory")
    for _, cfg in pairs(commodityCA.commodityItemList) do
      if tonumber(skinId) == cfg.id then
        return true
      end
    end
  end
  return false
end

function DataModel.TakeOnSkinPlayAnim(itemId)
  local skinCA = PlayerData:GetFactoryData(itemId, "HomeCharacterSkinFactory")
  local particle = View.Group_Character.transform:Find("UI_clothes"):GetComponent(typeof(CS.UnityEngine.ParticleSystem))
  particle:Play()
  local skinTypeCA = PlayerData:GetFactoryData(skinCA.skinType, "TagFactory")
  local animCA = PlayerData:GetFactoryData(skinTypeCA.animId, "ListFactory")
  if not animCA then
    return
  end
  local anims = DataModel.isBack and animCA.backAnimList or animCA.frontAnimList
  local index = math.random(1, table.count(anims))
  View.Group_Character.SpineAnimation_:SetActionWithoutMix(anims[index].animName, true, true)
  DataModel.sound = SoundManager:CreateSound(30002649)
  if DataModel.sound ~= nil then
    DataModel.sound:Play()
  end
end

function DataModel.ChangeSkin(shopItem, takeOn)
  return PlayerData.CaptainSkinSystem:ChangeSkin(View.Group_Character.SpineAnimation_, shopItem, takeOn)
end

function DataModel.SaveDresses()
  local function SaveDressesCallBack()
    ChangeSkinUtil.InitHomeCaptainSpineSkin()
  end
  
  PlayerData.CaptainSkinSystem:ReqSaveDress(SaveDressesCallBack)
end

DataModel.Init()
return DataModel
