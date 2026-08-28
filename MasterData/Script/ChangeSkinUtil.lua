local ChangeSkinUtil = {}
local HairMaterialPropertyBlock

function ChangeSkinUtil.InitNormalSkinItems(friendData)
  local normalSkinItems = {}
  friendData = friendData or PlayerData.visitMode and PlayerData.visitInfo
  if friendData then
    local guard = friendData.guard or {}
    for skinType, skinInfo in pairs(guard) do
      normalSkinItems[tonumber(skinType)] = ChangeSkinUtil.GenerateSkinItem(skinInfo.id, skinInfo.skinUid)
    end
  else
    local dress = PlayerData.CaptainSkinSystem:GetAllSkinData()
    local guard = PlayerData.CaptainSkinSystem:GetNormalSkinData()
    for skinType, skinUid in pairs(guard) do
      if dress[skinUid] then
        normalSkinItems[tonumber(skinType)] = ChangeSkinUtil.GenerateSkinItem(dress[skinUid].id, skinUid)
      end
    end
  end
  if not normalSkinItems[EnumDefine.ESkinType.Hair] then
    local hairId = ChangeSkinUtil.GetDefaultHairId(friendData)
    normalSkinItems[EnumDefine.ESkinType.Hair] = ChangeSkinUtil.GenerateSkinItem(hairId)
  end
  return normalSkinItems
end

function ChangeSkinUtil.InitOverlaySkinItems(friendData)
  local overlaySkinItems = {}
  friendData = PlayerData.visitMode and PlayerData.visitInfo or friendData
  if friendData then
    local guard_many = friendData.guard_many or {}
    for skinType, skinInfoList in pairs(guard_many) do
      local t = {}
      for index, skinInfo in ipairs(skinInfoList) do
        table.insert(t, ChangeSkinUtil.GenerateSkinItem(skinInfo.id, skinInfo.skinUid))
      end
      overlaySkinItems[tonumber(skinType)] = t
    end
  else
    local dress = PlayerData.CaptainSkinSystem:GetAllSkinData()
    local guard_many = PlayerData.CaptainSkinSystem:GetOverlaySkinData()
    for skinType, skinUidList in pairs(guard_many) do
      local t = {}
      for index, skinUid in ipairs(skinUidList) do
        if dress[skinUid] then
          table.insert(t, ChangeSkinUtil.GenerateSkinItem(dress[skinUid].id, skinUid))
        end
      end
      overlaySkinItems[tonumber(skinType)] = t
    end
  end
  return overlaySkinItems
end

function ChangeSkinUtil.InitUICaptainSpineSkin(uiSpineAnim, animName, friendData)
  local characterId = ChangeSkinUtil.GetCaptainCharacterId(friendData)
  local characterCA = PlayerData:GetFactoryData(characterId, "HomeCharacterFactory")
  local spinePath = characterCA.resStatePath[2] and characterCA.resStatePath[2].path or characterCA.resDir
  uiSpineAnim:SetSpineInit(spinePath, animName)
  uiSpineAnim:SetActive(true)
  local normalSkinItems = ChangeSkinUtil.InitNormalSkinItems(friendData)
  local overlaySkinItems = ChangeSkinUtil.InitOverlaySkinItems(friendData)
  local skinJsonTable, attachmentJsonTable, atlasSkinJsonTable, atlasOverlaySkinJsonTable = ChangeSkinUtil.GetAllSkinJsonTable(normalSkinItems, overlaySkinItems)
  ChangeSkinUtil.ChangeUISpineSkin(uiSpineAnim, skinJsonTable, true)
  ChangeSkinUtil.ChangeUISpineAtlasSkin(uiSpineAnim, atlasSkinJsonTable, true)
  ChangeSkinUtil.ChangeUISpineAttachment(uiSpineAnim, attachmentJsonTable, true)
  ChangeSkinUtil.ChangeUISpineAtlasOverlaySkin(uiSpineAnim, atlasOverlaySkinJsonTable, true)
  local hairColor = ChangeSkinUtil.GetHairColor(normalSkinItems[EnumDefine.ESkinType.Hair], friendData)
  if hairColor then
    ChangeSkinUtil.InitSpineHairColor(uiSpineAnim.transform, hairColor)
  end
end

function ChangeSkinUtil.InitHomeCaptainSpineSkin()
  local character = ChangeSkinUtil.GetCaptainHomeCharacter()
  if character then
    local normalSkinItems = ChangeSkinUtil.InitNormalSkinItems()
    local overlaySkinItems = ChangeSkinUtil.InitOverlaySkinItems()
    local skinJsonTable, attachmentJsonTable, atlasSkinJsonTable, atlasOverlaySkinJsonTable = ChangeSkinUtil.GetAllSkinJsonTable(normalSkinItems, overlaySkinItems)
    ChangeSkinUtil.ChangeHomeCharacterSpineSkin(character, skinJsonTable, true)
    ChangeSkinUtil.ChangeHomeCharacterSpineAtlasSkin(character, atlasSkinJsonTable, true)
    ChangeSkinUtil.ChangeHomeCharacterSpineAttachment(character, attachmentJsonTable, true)
    ChangeSkinUtil.ChangeHomeCharacterSpineAtlasOverlaySkin(character, atlasOverlaySkinJsonTable, true)
  end
end

function ChangeSkinUtil.InitHomeCaptainSpineHairColor()
  local character = ChangeSkinUtil.GetCaptainHomeCharacter()
  if character then
    local normalSkinItems = ChangeSkinUtil.InitNormalSkinItems()
    local hairColor = ChangeSkinUtil.GetHairColor(normalSkinItems[EnumDefine.ESkinType.Hair])
    if hairColor then
      ChangeSkinUtil.InitSpineHairColor(character.view.transform:Find("model"), hairColor)
    end
  end
end

function ChangeSkinUtil.InitTimeLineCaptainSpineSkin(timeLineId)
  local timeLineCA = PlayerData:GetFactoryData(timeLineId, "TimeLineFactory")
  if table.count(timeLineCA.lczPathList) > 0 then
    local timeLineInfo = TimelineManager:GetTimeLineByPath(timeLineCA.timeLinePath)
    if not timeLineInfo then
      return
    end
    local normalSkinItems = ChangeSkinUtil.InitNormalSkinItems()
    local overlaySkinItems = ChangeSkinUtil.InitOverlaySkinItems()
    local skinJsonTable, attachmentJsonTable, atlasSkinJsonTable, atlasOverlaySkinJsonTable = ChangeSkinUtil.GetAllSkinJsonTable(normalSkinItems, overlaySkinItems)
    for _, v in pairs(timeLineCA.lczPathList) do
      ChangeSkinUtil.ChangeTimeLineSpineSkin(timeLineCA.timeLinePath, v.lcz, skinJsonTable, true)
      ChangeSkinUtil.ChangeTimeLineSpineAtlasSkin(timeLineCA.timeLinePath, v.lcz, atlasSkinJsonTable, true)
      ChangeSkinUtil.ChangeTimeLineSpineAttachment(timeLineCA.timeLinePath, v.lcz, attachmentJsonTable, true)
      ChangeSkinUtil.ChangeTimeLineSpineAtlasOverlaySkin(timeLineCA.timeLinePath, v.lcz, atlasOverlaySkinJsonTable, true)
    end
  end
end

function ChangeSkinUtil.InitTimeLineCaptainSpineHairColor(timeLineId)
  local timeLineCA = PlayerData:GetFactoryData(timeLineId, "TimeLineFactory")
  if table.count(timeLineCA.lczPathList) > 0 then
    local timeLineInfo = TimelineManager:GetTimeLineByPath(timeLineCA.timeLinePath)
    if not timeLineInfo then
      return
    end
    local normalSkinItems = ChangeSkinUtil.InitNormalSkinItems()
    local spineTrans, hairColor
    local paths = {}
    for _, v in pairs(timeLineCA.lczPathList) do
      spineTrans = timeLineInfo.go.transform
      paths = {}
      for part in string.gmatch(v.lcz, "[^%.]+") do
        table.insert(paths, part)
      end
      for _, path in ipairs(paths) do
        spineTrans = spineTrans:Find(path)
      end
      if spineTrans then
        hairColor = ChangeSkinUtil.GetHairColor(normalSkinItems[EnumDefine.ESkinType.Hair])
        if not hairColor then
          return
        end
        ChangeSkinUtil.InitSpineHairColor(spineTrans, hairColor)
      end
    end
  end
end

function ChangeSkinUtil.ChangeUISpineSkin(uiSpineAnim, skinJsonTable, takeOn)
  if table.count(skinJsonTable) > 0 then
    uiSpineAnim:ChangeSpineSkin(Json.encode(skinJsonTable), takeOn)
  end
end

function ChangeSkinUtil.ChangeUISpineAtlasSkin(uiSpineAnim, atlasSkinJsonTable, takeOn)
  if table.count(atlasSkinJsonTable) > 0 then
    pcall(function()
      uiSpineAnim:ChangeSpineAtlasSkin(Json.encode(atlasSkinJsonTable), takeOn)
    end)
  end
end

function ChangeSkinUtil.ChangeUISpineAttachment(uiSpineAnim, attachmentJsonTable, takeOn)
  if table.count(attachmentJsonTable) > 0 then
    uiSpineAnim:ChangeSpineAttachment(Json.encode(attachmentJsonTable), takeOn)
  end
end

function ChangeSkinUtil.ChangeUISpineAtlasAttachment(uiSpineAnim, atlasAttachmentJsonTable, takeOn)
  if table.count(atlasAttachmentJsonTable) > 0 then
    pcall(function()
      uiSpineAnim:ChangeSpineAtlasAttachment(Json.encode(atlasAttachmentJsonTable), takeOn)
    end)
  end
end

function ChangeSkinUtil.ChangeUISpineAtlasOverlaySkin(uiSpineAnim, atlasOverlaySkinJsonTable, takeOn)
  if table.count(atlasOverlaySkinJsonTable) > 0 then
    pcall(function()
      uiSpineAnim:ChangeSpineAtlasOverlaySkin(Json.encode(atlasOverlaySkinJsonTable), takeOn)
    end)
  end
end

function ChangeSkinUtil.ChangeTimeLineSpineSkin(timeLinePath, spineGoPath, skinJsonTable, takeOn)
  if table.count(skinJsonTable) > 0 then
    TimelineManager:ChangeSpineSkin(timeLinePath, spineGoPath, Json.encode(skinJsonTable), takeOn)
  end
end

function ChangeSkinUtil.ChangeTimeLineSpineAtlasSkin(timeLinePath, spineGoPath, atlasSkinJsonTable, takeOn)
  if table.count(atlasSkinJsonTable) > 0 then
    pcall(function()
      TimelineManager:ChangeSpineAtlasSkin(timeLinePath, spineGoPath, Json.encode(atlasSkinJsonTable), takeOn)
    end)
  end
end

function ChangeSkinUtil.ChangeTimeLineSpineAttachment(timeLinePath, spineGoPath, attachmentJsonTable, takeOn)
  if table.count(attachmentJsonTable) > 0 then
    TimelineManager:ChangeSpineAttachment(timeLinePath, spineGoPath, Json.encode(attachmentJsonTable), takeOn)
  end
end

function ChangeSkinUtil.ChangeTimeLineSpineAtlasAttachment(timeLinePath, spineGoPath, atlasAttachmentJsonTable, takeOn)
  if table.count(atlasAttachmentJsonTable) > 0 then
    pcall(function()
      TimelineManager:ChangeSpineAtlasAttachment(timeLinePath, spineGoPath, Json.encode(atlasAttachmentJsonTable), takeOn)
    end)
  end
end

function ChangeSkinUtil.ChangeTimeLineSpineAtlasOverlaySkin(timeLinePath, spineGoPath, atlasOverlaySkinJsonTable, takeOn)
  if table.count(atlasOverlaySkinJsonTable) > 0 then
    pcall(function()
      TimelineManager:ChangeSpineAtlasOverlaySkin(timeLinePath, spineGoPath, Json.encode(atlasOverlaySkinJsonTable), takeOn)
    end)
  end
end

function ChangeSkinUtil.ChangeHomeCharacterSpineSkin(character, skinJsonTable, takeOn)
  if table.count(skinJsonTable) > 0 then
    local animePart = character.animePart
    if not animePart then
      return
    end
    character.animePart:ChangeSpineSkin(Json.encode(skinJsonTable), takeOn)
  end
end

function ChangeSkinUtil.ChangeHomeCharacterSpineAtlasSkin(character, atlasSkinJsonTable, takeOn)
  if table.count(atlasSkinJsonTable) > 0 then
    local animePart = character.animePart
    if not animePart then
      return
    end
    pcall(function()
      character.animePart:ChangeSpineAtlasSkin(Json.encode(atlasSkinJsonTable), takeOn)
    end)
  end
end

function ChangeSkinUtil.ChangeHomeCharacterSpineAttachment(character, attachmentJsonTable, takeOn)
  if table.count(attachmentJsonTable) > 0 then
    local animePart = character.animePart
    if not animePart then
      return
    end
    character.animePart:ChangeSpineAttachment(Json.encode(attachmentJsonTable), takeOn)
  end
end

function ChangeSkinUtil.ChangeHomeCharacterSpineAtlasAttachment(character, atlasAttachmentJsonTable, takeOn)
  if table.count(atlasAttachmentJsonTable) > 0 then
    local animePart = character.animePart
    if not animePart then
      return
    end
    pcall(function()
      character.animePart:ChangeSpineAtlasAttachment(Json.encode(atlasAttachmentJsonTable), takeOn)
    end)
  end
end

function ChangeSkinUtil.ChangeHomeCharacterSpineAtlasOverlaySkin(character, atlasOverlaySkinJsonTable, takeOn)
  if table.count(atlasOverlaySkinJsonTable) > 0 then
    local animePart = character.animePart
    if not animePart then
      return
    end
    pcall(function()
      character.animePart:ChangeSpineAtlasOverlaySkin(Json.encode(atlasOverlaySkinJsonTable), takeOn)
    end)
  end
end

function ChangeSkinUtil.GenerateSkinItem(skinId, skinUid, commodityId)
  local skinItem = {}
  skinItem.itemId = tonumber(skinId)
  skinItem.skinUid = skinUid
  skinItem.commodityId = tonumber(commodityId)
  return skinItem
end

function ChangeSkinUtil.GetNudeSkins(normalSkinItems)
  local nudeSkins = {}
  local hasSuit = normalSkinItems[EnumDefine.ESkinType.Suit]
  local hasUp = normalSkinItems[EnumDefine.ESkinType.Up]
  local hasBottom = normalSkinItems[EnumDefine.ESkinType.Bottom]
  local hasShoes = normalSkinItems[EnumDefine.ESkinType.Shoes]
  if not hasSuit then
    if not hasUp then
      nudeSkins[EnumDefine.ESkinType.Up] = EnumDefine.ESkinNude.Up
    end
    if not hasBottom then
      nudeSkins[EnumDefine.ESkinType.Bottom] = EnumDefine.ESkinNude.Bottom
    end
  end
  if not hasShoes then
    nudeSkins[EnumDefine.ESkinType.Shoes] = EnumDefine.ESkinNude.Shoes
  end
  return nudeSkins
end

function ChangeSkinUtil.GetHairMachInfo(hairId, hairType)
  local hairSkinCA = PlayerData:GetFactoryData(hairId, "HomeCharacterSkinFactory")
  for i, v in pairs(hairSkinCA.hairList) do
    if v.hairType == hairType then
      return v
    end
  end
end

function ChangeSkinUtil.GetHairSkinJsonTable(hairId, hairType)
  local matchInfo = ChangeSkinUtil.GetHairMachInfo(hairId, hairType)
  if matchInfo then
    return {
      resPath = matchInfo.spineDataPath,
      skinPath = matchInfo.skinPath
    }
  end
end

function ChangeSkinUtil.GetAtlasReplaceSpineDataPath(skinCA)
  if not string.nilorempty(skinCA.spineDataPath) then
    return skinCA.spineDataPath
  end
  return skinCA.baseSpineDataPath
end

function ChangeSkinUtil.GetAtlasReplacePath(skinCA)
  if not string.nilorempty(skinCA.atlasPath) then
    return skinCA.atlasPath
  end
  return skinCA.AtlasPath
end

function ChangeSkinUtil.IsAtlasReplaceSkin(skinCA)
  return skinCA and (skinCA.mod == "\229\155\190\233\155\134\230\155\191\230\141\162" or not string.nilorempty(ChangeSkinUtil.GetAtlasReplacePath(skinCA)))
end

function ChangeSkinUtil.GetSkinJsonTable(skinId)
  local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
  if skinCA.mod ~= "\229\143\145\229\158\139" and not ChangeSkinUtil.IsAtlasReplaceSkin(skinCA) then
    return {
      resPath = skinCA.spineDataPath,
      skinPath = skinCA.skinPath
    }
  end
end

function ChangeSkinUtil.GetAtlasSkinJsonTable(skinId)
  local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
  if ChangeSkinUtil.IsAtlasReplaceSkin(skinCA) then
    return {
      resPath = ChangeSkinUtil.GetAtlasReplaceSpineDataPath(skinCA),
      skinPath = skinCA.skinPath,
      atlasPath = ChangeSkinUtil.GetAtlasReplacePath(skinCA)
    }
  end
end

function ChangeSkinUtil.AddSkinJsonTableByMod(skinId, skinJsonTable, atlasSkinJsonTable)
  local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
  local targetTable, info
  if ChangeSkinUtil.IsAtlasReplaceSkin(skinCA) then
    targetTable = atlasSkinJsonTable
    info = ChangeSkinUtil.GetAtlasSkinJsonTable(skinId)
  else
    targetTable = skinJsonTable
    info = ChangeSkinUtil.GetSkinJsonTable(skinId)
  end
  if info then
    targetTable[tostring(table.count(targetTable))] = info
  end
end

function ChangeSkinUtil.AddOverlayJsonTableByMod(skinId, index, attachmentJsonTable, atlasOverlaySkinJsonTable)
  local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
  local targetTable, info
  if ChangeSkinUtil.IsAtlasReplaceSkin(skinCA) then
    targetTable = atlasOverlaySkinJsonTable
    info = ChangeSkinUtil.GetAtlasOverlaySkinJsonTable(skinId, index)
  else
    targetTable = attachmentJsonTable
    info = ChangeSkinUtil.GetOverlayAttachmentsInfo(skinId, index)
  end
  if info then
    targetTable[tostring(table.count(targetTable))] = info
  end
end

function ChangeSkinUtil.GetOverlayMaxNum(skinType)
  if skinType == EnumDefine.ESkinType.Head then
    return 10
  end
  return 0
end

function ChangeSkinUtil.GetDefaultHairId(friendData)
  local characterId = ChangeSkinUtil.GetCaptainCharacterId(friendData)
  local hairId
  if characterId == 70000067 then
    hairId = 85500001
  elseif characterId == 70000063 then
    hairId = 85500011
  end
  return hairId
end

function ChangeSkinUtil.GetHairColorKey(hairUid, hairId)
  local key
  if not hairUid then
    key = hairId and tostring(hairId)
  else
    key = hairUid
  end
  return key
end

function ChangeSkinUtil.GetHairType(normalSkinItems, overlaySkinItems)
  local hairType = EnumDefine.ESkinHairType.Default
  local faceCoverSkinItem = normalSkinItems[EnumDefine.ESkinType.FaceCover]
  if faceCoverSkinItem then
    local skinCA = PlayerData:GetFactoryData(faceCoverSkinItem.itemId, "HomeCharacterSkinFactory")
    hairType = skinCA.hairType
  else
    local headSkinItem = normalSkinItems[EnumDefine.ESkinType.Head]
    if not headSkinItem then
      local overlayHeadSkinItems = overlaySkinItems[EnumDefine.ESkinType.Head]
      headSkinItem = overlayHeadSkinItems and overlayHeadSkinItems[1]
    end
    if headSkinItem then
      local skinCA = PlayerData:GetFactoryData(headSkinItem.itemId, "HomeCharacterSkinFactory")
      hairType = skinCA.hairType
    end
  end
  return hairType
end

function ChangeSkinUtil.GetHairColor(hairSkinItem, friendData)
  friendData = PlayerData.visitMode and PlayerData.visitInfo or friendData
  local hairColorData
  if friendData then
    hairColorData = friendData.cur_hair
  else
    hairColorData = PlayerData.CaptainSkinSystem:GetCurHairColorData()
  end
  local hairId = hairSkinItem.itemId
  local hairColor = hairColorData[tostring(hairId)]
  if hairColor then
    return tonumber(hairColor)
  else
    local hairSkinCA = PlayerData:GetFactoryData(hairId, "HomeCharacterSkinFactory")
    return hairSkinCA.defaultColor or 12602018
  end
end

function ChangeSkinUtil.GetAllSkinJsonTable(normalSkinItems, overlaySkinItems)
  local skinJsonTable = {}
  local atlasSkinJsonTable = {}
  for skinType, skinItem in pairs(normalSkinItems) do
    ChangeSkinUtil.AddSkinJsonTableByMod(skinItem.itemId, skinJsonTable, atlasSkinJsonTable)
  end
  local nudeSkins = ChangeSkinUtil.GetNudeSkins(normalSkinItems)
  for skinType, skinId in pairs(nudeSkins) do
    ChangeSkinUtil.AddSkinJsonTableByMod(skinId, skinJsonTable, atlasSkinJsonTable)
  end
  local hairId = normalSkinItems[EnumDefine.ESkinType.Hair].itemId
  local hairType = ChangeSkinUtil.GetHairType(normalSkinItems, overlaySkinItems)
  local faceCoverSkin = normalSkinItems[EnumDefine.ESkinType.FaceCover]
  if not faceCoverSkin then
    skinJsonTable[tostring(table.count(skinJsonTable))] = ChangeSkinUtil.GetHairSkinJsonTable(hairId, hairType)
  end
  local attachmentJsonTable = {}
  local atlasOverlaySkinJsonTable = {}
  for skinType, skinItems in pairs(overlaySkinItems) do
    for index, skinItem in ipairs(skinItems) do
      ChangeSkinUtil.AddOverlayJsonTableByMod(skinItem.itemId, index, attachmentJsonTable, atlasOverlaySkinJsonTable)
    end
  end
  return skinJsonTable, attachmentJsonTable, atlasSkinJsonTable, atlasOverlaySkinJsonTable
end

function ChangeSkinUtil.GetAllSkinJson(normalSkinItems, overlaySkinItems)
  local skinJsonTable, attachmentJsonTable, atlasSkinJsonTable, atlasOverlaySkinJsonTable = ChangeSkinUtil.GetAllSkinJsonTable(normalSkinItems, overlaySkinItems)
  local skinJson, overlayAttachmentsJson, atlasSkinJson, atlasOverlaySkinJson
  if table.count(skinJsonTable) > 0 then
    skinJson = Json.encode(skinJsonTable)
  end
  if table.count(attachmentJsonTable) > 0 then
    overlayAttachmentsJson = Json.encode(attachmentJsonTable)
  end
  if table.count(atlasSkinJsonTable) > 0 then
    atlasSkinJson = Json.encode(atlasSkinJsonTable)
  end
  if table.count(atlasOverlaySkinJsonTable) > 0 then
    atlasOverlaySkinJson = Json.encode(atlasOverlaySkinJsonTable)
  end
  return skinJson, overlayAttachmentsJson, atlasSkinJson, atlasOverlaySkinJson
end

local HatOverlaySlotMap = {
  hat_among = {
    "hat_among",
    "hat_among02",
    "hat_among04",
    "hat_among05",
    "hat_among06",
    "hat_among07",
    "hat_among08",
    "hat_among09",
    "hat_among10"
  },
  hat_back = {
    "hat_back",
    "hat_back02",
    "hat_back03",
    "hat_back04",
    "hat_back05",
    "hat_back06",
    "hat_back07",
    "hat_back08",
    "hat_back09",
    "hat_back10"
  },
  hat_front = {
    "hat_front",
    "hat_front02",
    "hat_front03",
    "hat_front04",
    "hat_front05",
    "hat_front06",
    "hat_front07",
    "hat_front08",
    "hat_front09",
    "hat_front10"
  }
}

function ChangeSkinUtil.GetOverlayAttachmentsInfo(skinId, index)
  local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
  local info
  if #skinCA.attachments > 0 then
    info = {}
    local overlaySlotMap
    if skinCA.skinType == EnumDefine.ESkinType.Head then
      overlaySlotMap = HatOverlaySlotMap
    end
    if not overlaySlotMap then
      return nil
    else
      for i, v in ipairs(skinCA.attachments) do
        local replaceSlotName = overlaySlotMap[v.slotName][index]
        info[tostring(i)] = {
          resPath = v.spineUrl,
          targetSlotName = v.slotName,
          targetAttachName = v.attachName,
          replaceSlotName = replaceSlotName,
          replaceAttachName = v.attachName:gsub("%d+$", "")
        }
      end
    end
  end
  return info
end

function ChangeSkinUtil.GetAtlasOverlaySkinJsonTable(skinId, index)
  local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
  if not skinCA.overlay then
    return nil
  end
  if skinCA.skinType ~= EnumDefine.ESkinType.Head then
    return nil
  end
  local resPath = ChangeSkinUtil.GetAtlasReplaceSpineDataPath(skinCA)
  local atlasPath = ChangeSkinUtil.GetAtlasReplacePath(skinCA)
  if string.nilorempty(resPath) or string.nilorempty(skinCA.skinPath) or string.nilorempty(atlasPath) then
    return nil
  end
  local info = {
    resPath = resPath,
    skinPath = skinCA.skinPath,
    atlasPath = atlasPath,
    overlayIndex = index
  }
  return info
end

function ChangeSkinUtil.InitSpineHairColor(meshTrans, hairColorTagId)
  local mesh = meshTrans:GetComponent(typeof(CS.UnityEngine.MeshRenderer))
  if not mesh then
    return
  end
  local publicMethod = require("UICubeRogueMain/CubeRoguePublicMethod")
  local tagCA = PlayerData:GetFactoryData(hairColorTagId, "TagFactory")
  local colorCurvesTexture, maskTexture
  local func = publicMethod.GetTFunc(CS.ResManager, "GetRes", typeof(CS.UnityEngine.Texture2D))
  if not string.nilorempty(tagCA.hairColorCurves) then
    colorCurvesTexture = func(ResManager, tagCA.hairColorCurves, "#ChangeSpineColor")
  end
  if not string.nilorempty(tagCA.hairColorMask) then
    maskTexture = func(ResManager, tagCA.hairColorMask, "#ChangeSpineColor")
  end
  if HairMaterialPropertyBlock == nil then
    HairMaterialPropertyBlock = CS.UnityEngine.MaterialPropertyBlock()
  end
  HairMaterialPropertyBlock:Clear()
  if colorCurvesTexture then
    HairMaterialPropertyBlock:SetTexture("_LUTTex", colorCurvesTexture)
  end
  if maskTexture then
    HairMaterialPropertyBlock:SetTexture("_MaskTex", maskTexture)
  end
  mesh:SetPropertyBlock(HairMaterialPropertyBlock)
end

function ChangeSkinUtil.IsDefaultSkin(skinId)
  local isDefaultHair = skinId == 85500001 or skinId == 85500011
  return isDefaultHair
end

function ChangeSkinUtil.GetCaptainCharacterId(friendData)
  local userInfo = friendData and friendData.user_info or PlayerData:GetUserInfo()
  local gender = userInfo.gender or 1
  return gender == 1 and 70000067 or 70000063
end

function ChangeSkinUtil.GetCaptainHomeCharacter()
  if PlayerData.foodTempRole then
    return CS.FRef.getProperty(HomeStationStoreManager, "gener_character")
  end
  local characterId = ChangeSkinUtil.GetCaptainCharacterId()
  local character
  if HomeStationStoreManager:GetCurStationPlace() > 0 then
    character = HomeStationStoreManager:GetCharacterById(characterId)
  else
    character = HomeCharacterManager:GetCharacterById(characterId)
  end
  return character
end

return ChangeSkinUtil
