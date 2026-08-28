local InstantiateList = {}
local module = {
  SetActivityPreviewItem = function(self, itemView, data, itemType, timeView, View, isHideEffect)
    if data == nil or data ~= nil and table.count(data) == 0 then
      itemView.self:SetActive(false)
      return
    end
    itemView.self:SetActive(true)
    local id = tonumber(data.id)
    local factoryName = DataManager:GetFactoryNameById(id)
    if itemView.Txt_Num then
      itemView.Txt_Num:SetActive(data.isShowNum)
      itemView.Txt_Num:SetText(data.num)
    end
    local caData = PlayerData:GetFactoryData(id, factoryName)
    itemView.Img_Item:SetActive(true)
    local quality_int
    if caData.qualityInt ~= nil then
      quality_int = caData.qualityInt + 1
    elseif caData.rarityInt ~= nil then
      quality_int = caData.rarityInt + 1
    else
      quality_int = 1
    end
    if factoryName == "UnitFactory" then
      local unit = PlayerData:GetFactoryData(caData.viewId)
      itemView.Img_Item:SetSprite(unit.face)
      itemView.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality_int - 1] and UIConfig.BottomConfig[quality_int - 1] or UIConfig.BottomConfig[1])
      itemView.Img_Mask:SetSprite(UIConfig.MaskConfig[quality_int - 1] and UIConfig.MaskConfig[quality_int - 1] or UIConfig.MaskConfig[1])
    elseif factoryName == "HomeCoachFactory" then
      itemView.Img_Item:SetSprite(caData.thumbnailone)
      itemView.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality_int])
      itemView.Img_Mask:SetSprite(UIConfig.MaskConfig[quality_int])
    elseif factoryName == "UnitViewFactory" then
      itemView.Img_Item:SetSprite(caData.iconPath)
      itemView.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality_int])
      itemView.Img_Mask:SetSprite(UIConfig.MaskConfig[quality_int])
    elseif factoryName == "CollectionCardPackFactory" then
      if itemView.Group_Effect then
        itemView.Group_Effect:SetActive(false)
      end
      itemView.Img_Mask:SetActive(false)
      itemView.Img_Item:SetSprite(caData.itemIconPath)
      itemView.Img_Bottom:SetSprite(caData.backPic)
    elseif factoryName == "CollectionCardFactory" then
      itemView.Group_Effect:SetActive(false)
      itemView.Img_Mask:SetActive(false)
      itemView.Img_Item:SetSprite(caData.tipsPath)
      local cardPackCfg = PlayerData:GetFactoryData(caData.correspondingPack, "CollectionCardPackFactory")
      itemView.Img_Bottom:SetSprite(cardPackCfg.backPic)
    else
      itemView.Img_Item:SetSprite(caData.iconPath or caData.imagePath)
      itemView.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality_int])
      itemView.Img_Mask:SetSprite(UIConfig.MaskConfig[quality_int])
    end
    if itemView.Img_Type01 then
      if EnumDefine.ItemType.Item == itemType then
        itemView.Img_Type02:SetActive(false)
        itemView.Img_Type01:SetActive(true)
      elseif EnumDefine.ItemType.Material == itemType then
        itemView.Img_Type01:SetActive(false)
        itemView.Img_Type02:SetActive(true)
      end
    end
    if itemView.Group_Break then
      itemView.Group_Break.self:SetActive(false)
      if type(caData.breakPath) == "string" and caData.breakPath ~= "" or type(caData.breakPath) ~= "string" and caData.breakPath then
        itemView.Group_Break.self:SetActive(true)
        itemView.Group_Break.Img_Mask.Img_Face:SetSprite(caData.breakPath)
      end
      if factoryName == "UnitViewFactory" then
        itemView.Group_Break.self:SetActive(true)
        itemView.Group_Break.Img_Mask.Img_Face:SetSprite(caData.face)
      end
    end
    if itemView.Group_EType ~= nil then
      itemView.Group_EType:SetActive(false)
    end
    if factoryName == "EquipmentFactory" and itemView.Group_EType then
      itemView.Group_EType:SetActive(true)
      local index = PlayerData:GetTypeInt("enumEquipTypeList", caData.equipTagId)
      itemView.Group_EType.Img_Icon:SetSprite(UIConfig.EquipmentTypeMark[index])
      itemView.Group_EType.Img_IconBg:SetSprite(UIConfig.EquipmentTypeMarkBg[caData.qualityInt])
    end
    if itemView.Group_Effect ~= nil and View and not isHideEffect and quality_int <= #UIConfig.CommonEffectReward then
      local effect_obj = View.self:GetRes(UIConfig.CommonEffectReward[quality_int], itemView.Group_Effect.transform)
      effect_obj:SetActive(true)
      table.insert(InstantiateList, effect_obj)
    end
  end,
  SetItem = function(self, itemView, data, itemType, timeView, View, isHideEffect)
    if data == nil or data ~= nil and table.count(data) == 0 then
      itemView.self:SetActive(false)
      return
    end
    itemView.self:SetActive(true)
    local id = tonumber(data.id)
    local factoryName = DataManager:GetFactoryNameById(id)
    if itemView.Txt_Num then
      itemView.Txt_Num:SetActive(true)
      if factoryName == "EquipmentFactory" or factoryName == "ForgeFactory" or factoryName == "UnitFactory" then
        itemView.Txt_Num:SetActive(false)
      else
        itemView.Txt_Num:SetActive(true)
        itemView.Txt_Num:SetText(data.num)
      end
      if data.isfirst ~= nil and data.isfirst == false then
        itemView.Txt_Num:SetActive(data.isfirst)
      end
    end
    local caData = PlayerData:GetFactoryData(id, factoryName)
    itemView.Img_Item:SetActive(true)
    local quality_int
    if caData.qualityInt ~= nil then
      quality_int = caData.qualityInt + 1
    elseif caData.rarityInt ~= nil then
      quality_int = caData.rarityInt + 1
    else
      quality_int = 1
    end
    if factoryName == "UnitFactory" then
      local unit = PlayerData:GetFactoryData(caData.viewId)
      itemView.Img_Item:SetSprite(unit.face)
      itemView.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality_int - 1] and UIConfig.BottomConfig[quality_int - 1] or UIConfig.BottomConfig[1])
      itemView.Img_Mask:SetSprite(UIConfig.MaskConfig[quality_int - 1] and UIConfig.MaskConfig[quality_int - 1] or UIConfig.MaskConfig[1])
    elseif factoryName == "HomeCoachFactory" then
      itemView.Img_Item:SetSprite(caData.thumbnailone)
      itemView.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality_int])
      itemView.Img_Mask:SetSprite(UIConfig.MaskConfig[quality_int])
    elseif factoryName == "UnitViewFactory" then
      itemView.Img_Item:SetSprite(caData.iconPath)
      itemView.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality_int])
      itemView.Img_Mask:SetSprite(UIConfig.MaskConfig[quality_int])
    elseif factoryName == "CollectionCardPackFactory" then
      if itemView.Group_Effect then
        itemView.Group_Effect:SetActive(false)
      end
      itemView.Img_Mask:SetActive(false)
      itemView.Img_Item:SetSprite(caData.itemIconPath)
      itemView.Img_Bottom:SetSprite(caData.backPic)
    elseif factoryName == "CollectionCardFactory" then
      itemView.Group_Effect:SetActive(false)
      itemView.Img_Mask:SetActive(false)
      itemView.Img_Item:SetSprite(caData.tipsPath)
      local cardPackCfg = PlayerData:GetFactoryData(caData.correspondingPack, "CollectionCardPackFactory")
      itemView.Img_Bottom:SetSprite(cardPackCfg.backPic)
    else
      itemView.Img_Item:SetSprite(caData.iconPath or caData.imagePath)
      itemView.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality_int])
      itemView.Img_Mask:SetSprite(UIConfig.MaskConfig[quality_int])
    end
    if factoryName == "ProfilePhotoFactory" then
      CommonTips:SetPlayerHeadShader(itemView.Img_spAdd, caData)
    end
    if itemView.Img_Type01 then
      if EnumDefine.ItemType.Item == itemType then
        itemView.Img_Type02:SetActive(false)
        itemView.Img_Type01:SetActive(true)
      elseif EnumDefine.ItemType.Material == itemType then
        itemView.Img_Type01:SetActive(false)
        itemView.Img_Type02:SetActive(true)
      end
    end
    if itemView.Group_Break then
      itemView.Group_Break.self:SetActive(false)
      if type(caData.breakPath) == "string" and caData.breakPath ~= "" or type(caData.breakPath) ~= "string" and caData.breakPath then
        itemView.Group_Break.self:SetActive(true)
        itemView.Group_Break.Img_Mask.Img_Face:SetSprite(caData.breakPath)
      end
      if factoryName == "UnitViewFactory" then
        itemView.Group_Break.self:SetActive(true)
        itemView.Group_Break.Img_Mask.Img_Face:SetSprite(caData.face)
      end
    end
    if itemView.Group_EType ~= nil then
      itemView.Group_EType:SetActive(false)
    end
    if factoryName == "EquipmentFactory" and itemView.Group_EType then
      itemView.Group_EType:SetActive(true)
      local index = PlayerData:GetTypeInt("enumEquipTypeList", caData.equipTagId)
      itemView.Group_EType.Img_Icon:SetSprite(UIConfig.EquipmentTypeMark[index])
      itemView.Group_EType.Img_IconBg:SetSprite(UIConfig.EquipmentTypeMarkBg[caData.qualityInt])
    end
    if itemView.Group_Effect ~= nil and View and not isHideEffect and quality_int <= #UIConfig.CommonEffectReward then
      local effect_obj = View.self:GetRes(UIConfig.CommonEffectReward[quality_int], itemView.Group_Effect.transform)
      effect_obj:SetActive(true)
      table.insert(InstantiateList, effect_obj)
    end
  end,
  SetEquipment = function(self, itemView, data, isEquipd, type)
    self:SetItem(itemView, data.data)
    if itemView.Img_Lock then
      itemView.Img_Lock:SetActive(data.server.is_locked == 1)
    end
    local index = PlayerData:GetTypeInt("enumEquipTypeList", data.data.equipTagId)
    if itemView.Img_Tag then
      itemView.Img_Tag.Img_Type:SetSprite(UIConfig.EquipmentTypeMark[index])
      itemView.Img_Tag:SetSprite(UIConfig.EquipmentTypeMarkBg[data.data.qualityInt])
    end
    if itemView.Group_NoWearing then
      itemView.Group_NoWearing.self:SetActive(false)
      if type ~= nil then
        itemView.Group_NoWearing.self:SetActive(not type)
      end
    end
    if itemView.Txt_EquipmentLvNum then
      itemView.Txt_EquipmentLvNum:SetText(data.server.lv)
    end
    if itemView.Txt_EquipmentLevel then
      itemView.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), data.server.lv))
    end
    if itemView.Group_Face then
      itemView.Group_Face:SetActive(false)
      local hid = data.server.hid
      if hid ~= "" then
        itemView.Group_Face:SetActive(true)
        local unitCA = PlayerData:GetFactoryData(hid)
        local viewCA = PlayerData:GetFactoryData(unitCA.viewId)
        itemView.Group_Face.Img_Character.Img_Face:SetSprite(viewCA.face)
      end
    end
  end,
  SetWarehouse = function(self, itemView, data, itemType, timeView)
    if data == nil or data ~= nil and table.count(data) == 0 then
      itemView.self:SetActive(false)
      return
    end
    itemView.self:SetActive(true)
    itemView.Txt_Num:SetText(data.num)
    local id = tonumber(data.id)
    local caData = PlayerData:GetFactoryData(id)
    itemView.Img_Item:SetActive(true)
    local quality_int
    if caData.qualityInt ~= nil then
      quality_int = caData.qualityInt + 1
    elseif caData.rarityInt ~= nil then
      quality_int = caData.rarityInt + 1
    else
      quality_int = 1
    end
    itemView.Img_Item:SetSprite(caData.iconPath or caData.imagePath)
    itemView.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality_int])
    itemView.Img_Mask:SetSprite(UIConfig.MaskConfig[quality_int])
    itemView.Group_JiaoYi:SetActive(false)
    itemView.Img_Lock:SetActive(false)
    if caData.mod == "\232\174\162\229\141\149\232\180\167\231\137\169" then
      itemView.Group_JiaoYi:SetActive(true)
    elseif caData.mod == "\229\159\186\231\161\128\232\180\167\231\137\169" then
      itemView.Img_Specialty:SetActive(caData.isSpeciality)
      local goodsServerInfo = PlayerData:GetHomeInfo().warehouse[tostring(id)]
      itemView.Img_Lock:SetActive(goodsServerInfo and goodsServerInfo.is_locked == 1)
    end
  end,
  SetHaveItem = function(self, itemView, data, isEquipd)
  end,
  SetFridgeItems = function(self, itemView, data)
    if data == nil or data ~= nil and table.count(data) == 0 then
      itemView.self:SetActive(false)
      return
    end
    local caData = PlayerData:GetFactoryData(data.id, "FridgeItemFactory")
    itemView.self:SetActive(true)
    itemView.Txt_Num:SetText(data.num)
    itemView.Img_Item:SetSprite(caData.iconPath)
    local quality_int
    if caData.qualityInt ~= nil then
      quality_int = caData.qualityInt + 1
    elseif caData.rarityInt ~= nil then
      quality_int = caData.rarityInt + 1
    else
      quality_int = 1
    end
    itemView.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality_int])
    itemView.Img_Mask:SetSprite(UIConfig.MaskConfig[quality_int])
  end,
  DestroyInstantiate = function()
    if InstantiateList and table.count(InstantiateList) > 0 then
      for k, v in pairs(InstantiateList) do
        Object.Destroy(v)
      end
      InstantiateList = {}
    end
  end
}
return module
