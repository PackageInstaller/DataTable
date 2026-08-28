local Class = require("UIDialog/MetatableClass")
local CaptainSkinSystem = Class.New("CaptainSkinSystem")

function CaptainSkinSystem:Ctor()
end

function CaptainSkinSystem:InitData(dress)
  self.dress = dress
  local gender = PlayerData:GetUserInfo().gender or 1
  self.characterId = gender == 1 and 70000067 or 70000063
  self.unitId = gender == 1 and 10000137 or 10000173
  self.defaultHairId = ChangeSkinUtil.GetDefaultHairId()
end

function CaptainSkinSystem:GetDressData()
  local data = self.dress
  if not data then
    data = {}
    self.dress = data
  end
  return data
end

function CaptainSkinSystem:GetAllSkinData()
  local data = self:GetDressData().dress
  if not data then
    data = {}
    self:GetDressData().dress = data
  end
  return data
end

function CaptainSkinSystem:GetNormalSkinData()
  local data = self:GetDressData().guard
  if not data then
    data = {}
    self:GetDressData().guard = data
  end
  return data
end

function CaptainSkinSystem:GetNormalSkinInfoByType(skinType)
  local allSkinData = self:GetAllSkinData()
  local normalSkinData = self:GetNormalSkinData()
  local skinUid = normalSkinData[tostring(skinType)]
  local skinData = allSkinData[skinUid] and Clone(allSkinData[skinUid])
  if skinData then
    skinData.skinUid = skinUid
  end
  return skinData
end

function CaptainSkinSystem:GetOverlaySkinData()
  local data = self:GetDressData().guard_many
  if not data then
    data = {}
    self:GetDressData().guard_many = data
  end
  return data
end

function CaptainSkinSystem:GetCurHairColorData()
  local data = self:GetDressData().cur_hair
  if not data then
    data = {}
    self:GetDressData().cur_hair = data
  end
  return data
end

function CaptainSkinSystem:GetAllHairColorData()
  local data = self:GetDressData().hair_color
  if not data then
    data = {}
    self:GetDressData().hair_color = data
  end
  return data
end

function CaptainSkinSystem:GetSaveHairSaveColor()
  local hairSkinInfo = self:GetNormalSkinInfoByType(EnumDefine.ESkinType.Hair)
  if hairSkinInfo then
    local hairSkinItem = ChangeSkinUtil.GenerateSkinItem(hairSkinInfo.id, hairSkinInfo.skinUid)
    return ChangeSkinUtil.GetHairColor(hairSkinItem)
  end
end

function CaptainSkinSystem:GetShowHairSaveColor()
  return self.curShowHairSkinItem and ChangeSkinUtil.GetHairColor(self.curShowHairSkinItem)
end

function CaptainSkinSystem:UpdateDressReward(reward)
  local data = reward and reward.dress
  if data then
    for dressUid, skinData in pairs(data) do
      PlayerData.CaptainSkinSystem:GetAllSkinData()[dressUid] = skinData
    end
  end
end

function CaptainSkinSystem:InitChangeSkinCacheData()
  self.curShowNormalSkinItems = ChangeSkinUtil.InitNormalSkinItems()
  self.curShowOverlaySkinItems = ChangeSkinUtil.InitOverlaySkinItems()
  self.curShowHairSkinItem = self.curShowNormalSkinItems[EnumDefine.ESkinType.Hair]
  self.curShowHairColor = ChangeSkinUtil.GetHairColor(self.curShowHairSkinItem)
  self.curShowHairType = ChangeSkinUtil.GetHairType(self.curShowNormalSkinItems, self.curShowOverlaySkinItems)
end

function CaptainSkinSystem:IsSkinCurShow(skinItem)
  local skinId = skinItem.itemId
  local skinUid = skinItem.skinUid
  local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
  if skinCA.overlay then
    local skinItems = self.curShowOverlaySkinItems[skinCA.skinType]
    if skinItems then
      for i, _skinItem in ipairs(skinItems) do
        if _skinItem.skinUid == skinUid then
          return true
        end
      end
    end
    return false
  else
    local _skinItem = self.curShowNormalSkinItems[skinCA.skinType]
    return _skinItem and _skinItem.skinUid == skinUid
  end
end

function CaptainSkinSystem:IsSkinHave(skinId)
  if ChangeSkinUtil.IsDefaultSkin(skinId) then
    return true
  end
  local allSkinData = self:GetAllSkinData()
  for i, skinData in pairs(allSkinData) do
    if skinData.id == tostring(skinId) then
      return true
    end
  end
end

function CaptainSkinSystem:IsCurShowHairHaveColor(colorTagId)
  local hairId = self.curShowHairSkinItem.itemId
  local hairCA = PlayerData:GetFactoryData(hairId, "HomeCharacterSkinFactory")
  if colorTagId == hairCA.defaultColor then
    return true
  end
  local hairColorKey = self:GetCurShowHairColorKey()
  local hairColorData = self:GetAllHairColorData()[hairColorKey]
  return hairColorData and hairColorData[tostring(colorTagId)]
end

function CaptainSkinSystem:IsCurShowHairWearColor()
  local hairColorKey = ChangeSkinUtil.GetHairColorKey(self.curShowHairSkinItem.skinUid, self.curShowHairSkinItem.itemId)
  local hairColor = self:GetCurHairColorData()[hairColorKey]
  return hairColor and tonumber(hairColor) == self.curShowHairColor
end

function CaptainSkinSystem:GetCurShowHairColorKey()
  return ChangeSkinUtil.GetHairColorKey(self.curShowHairSkinItem.skinUid, self.curShowHairSkinItem.itemId)
end

local LastNormalSkinItems = {}
local LastOverlaySkinItems = {}
local TakeOnSkinJsonTable = {}
local TakeOffSkinJsonTable = {}
local TakeOnAtlasSkinJsonTable = {}
local TakeOffAtlasSkinJsonTable = {}
local TakeOnAttachmentsJsonTable = {}
local TakeOffAttachmentsJsonTable = {}
local TakeOnAtlasOverlaySkinJsonTable = {}
local TakeOffAtlasOverlaySkinJsonTable = {}

function CaptainSkinSystem:ChangeSkin(spineAnim, skinItem, takeOn)
  local skinId = skinItem.itemId
  local skinUid = skinItem.skinUid
  local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
  if skinCA.skinType == 12600362 and not takeOn then
    return false
  end
  LastNormalSkinItems = Clone(self.curShowNormalSkinItems)
  LastOverlaySkinItems = Clone(self.curShowOverlaySkinItems)
  TakeOnSkinJsonTable = {}
  TakeOffSkinJsonTable = {}
  TakeOnAtlasSkinJsonTable = {}
  TakeOffAtlasSkinJsonTable = {}
  TakeOnAttachmentsJsonTable = {}
  TakeOffAttachmentsJsonTable = {}
  TakeOnAtlasOverlaySkinJsonTable = {}
  TakeOffAtlasOverlaySkinJsonTable = {}
  local curOverlayNum = self.curShowOverlaySkinItems[skinCA.skinType] and #self.curShowOverlaySkinItems[skinCA.skinType] or 0
  if takeOn and skinCA.overlay and curOverlayNum + 1 > ChangeSkinUtil.GetOverlayMaxNum(skinCA.skinType) then
    return false
  end
  if skinCA.overlay then
    if takeOn then
      if not self.curShowOverlaySkinItems[skinCA.skinType] then
        self.curShowOverlaySkinItems[skinCA.skinType] = {}
      end
      table.insert(self.curShowOverlaySkinItems[skinCA.skinType], skinItem)
      self.curShowNormalSkinItems[skinCA.skinType] = nil
      local skinTypeCA = PlayerData:GetFactoryData(skinCA.skinType, "TagFactory")
      for i, v in ipairs(skinTypeCA.takeOnExtraRemove) do
        self.curShowNormalSkinItems[v.id] = nil
        self.curShowOverlaySkinItems[v.id] = nil
      end
    else
      for index, v in ipairs(self.curShowOverlaySkinItems[skinCA.skinType]) do
        if v.skinUid == skinUid then
          table.remove(self.curShowOverlaySkinItems[skinCA.skinType], index)
          break
        end
      end
    end
  elseif takeOn then
    self.curShowOverlaySkinItems[skinCA.skinType] = nil
    local skinTypeCA = PlayerData:GetFactoryData(skinCA.skinType, "TagFactory")
    for i, v in ipairs(skinTypeCA.takeOnExtraRemove) do
      self.curShowNormalSkinItems[v.id] = nil
      self.curShowOverlaySkinItems[v.id] = nil
    end
    self.curShowNormalSkinItems[skinCA.skinType] = skinItem
  else
    self.curShowNormalSkinItems[skinCA.skinType] = nil
  end
  for k, lastSkinItem in pairs(LastNormalSkinItems) do
    local lastSkinId = lastSkinItem.itemId
    local curSkinItem = self.curShowNormalSkinItems[k]
    if not curSkinItem then
      ChangeSkinUtil.AddSkinJsonTableByMod(lastSkinId, TakeOffSkinJsonTable, TakeOffAtlasSkinJsonTable)
    else
      local curSkinId = curSkinItem.itemId
      if curSkinId ~= lastSkinId then
        ChangeSkinUtil.AddSkinJsonTableByMod(lastSkinId, TakeOffSkinJsonTable, TakeOffAtlasSkinJsonTable)
        ChangeSkinUtil.AddSkinJsonTableByMod(curSkinId, TakeOnSkinJsonTable, TakeOnAtlasSkinJsonTable)
      end
    end
  end
  for k, curSkinItem in pairs(self.curShowNormalSkinItems) do
    local curSkinId = curSkinItem.itemId
    local lastSkinItem = LastNormalSkinItems[k]
    if not lastSkinItem then
      ChangeSkinUtil.AddSkinJsonTableByMod(curSkinId, TakeOnSkinJsonTable, TakeOnAtlasSkinJsonTable)
    end
  end
  for k, lastSkinItems in pairs(LastOverlaySkinItems) do
    local curSkinItems = self.curShowOverlaySkinItems[k]
    for index, lastSkinItem in ipairs(lastSkinItems) do
      local curSkinItem = curSkinItems and curSkinItems[index]
      if not curSkinItem then
        ChangeSkinUtil.AddOverlayJsonTableByMod(lastSkinItem.itemId, index, TakeOffAttachmentsJsonTable, TakeOffAtlasOverlaySkinJsonTable)
      elseif curSkinItem.skinUid ~= lastSkinItem.skinUid then
        ChangeSkinUtil.AddOverlayJsonTableByMod(lastSkinItem.itemId, index, TakeOffAttachmentsJsonTable, TakeOffAtlasOverlaySkinJsonTable)
        ChangeSkinUtil.AddOverlayJsonTableByMod(curSkinItem.itemId, index, TakeOnAttachmentsJsonTable, TakeOnAtlasOverlaySkinJsonTable)
      end
    end
  end
  for k, curSkinItems in pairs(self.curShowOverlaySkinItems) do
    local lastSkinItems = LastOverlaySkinItems[k]
    for index, curSkinItem in ipairs(curSkinItems) do
      local lastSkinItem = lastSkinItems and lastSkinItems[index]
      if not lastSkinItem then
        ChangeSkinUtil.AddOverlayJsonTableByMod(curSkinItem.itemId, index, TakeOnAttachmentsJsonTable, TakeOnAtlasOverlaySkinJsonTable)
      end
    end
  end
  local currentNudeSkins = ChangeSkinUtil.GetNudeSkins(self.curShowNormalSkinItems)
  for skinType, _skinId in pairs(currentNudeSkins) do
    ChangeSkinUtil.AddSkinJsonTableByMod(_skinId, TakeOnSkinJsonTable, TakeOnAtlasSkinJsonTable)
  end
  local curShowHairSkinItem = self.curShowNormalSkinItems[EnumDefine.ESkinType.Hair]
  local curHairId = curShowHairSkinItem.itemId
  local curHairType = ChangeSkinUtil.GetHairType(self.curShowNormalSkinItems, self.curShowOverlaySkinItems)
  local isChangeHair = self.curShowHairSkinItem.itemId ~= curHairId
  if self.curShowHairSkinItem.itemId ~= curHairId or self.curShowHairType ~= curHairType then
    if self.curShowHairSkinItem.itemId then
      TakeOffSkinJsonTable[tostring(table.count(TakeOffSkinJsonTable))] = ChangeSkinUtil.GetHairSkinJsonTable(self.curShowHairSkinItem.itemId, self.curShowHairType)
    end
    if curHairId then
      TakeOnSkinJsonTable[tostring(table.count(TakeOnSkinJsonTable))] = ChangeSkinUtil.GetHairSkinJsonTable(curHairId, curHairType)
    end
    self.curShowHairSkinItem = curShowHairSkinItem
    self.curShowHairType = curHairType
  end
  ChangeSkinUtil.ChangeUISpineSkin(spineAnim, TakeOffSkinJsonTable, false)
  ChangeSkinUtil.ChangeUISpineAtlasSkin(spineAnim, TakeOffAtlasSkinJsonTable, false)
  ChangeSkinUtil.ChangeUISpineAttachment(spineAnim, TakeOffAttachmentsJsonTable, false)
  ChangeSkinUtil.ChangeUISpineAtlasOverlaySkin(spineAnim, TakeOffAtlasOverlaySkinJsonTable, false)
  ChangeSkinUtil.ChangeUISpineSkin(spineAnim, TakeOnSkinJsonTable, true)
  ChangeSkinUtil.ChangeUISpineAtlasSkin(spineAnim, TakeOnAtlasSkinJsonTable, true)
  ChangeSkinUtil.ChangeUISpineAttachment(spineAnim, TakeOnAttachmentsJsonTable, true)
  ChangeSkinUtil.ChangeUISpineAtlasOverlaySkin(spineAnim, TakeOnAtlasOverlaySkinJsonTable, true)
  if isChangeHair then
    local hairColor = ChangeSkinUtil.GetHairColor(self.curShowHairSkinItem)
    self:ChangeHairColor(spineAnim, hairColor, true)
  end
  self.change = true
  return true
end

function CaptainSkinSystem:ChangeHairColor(uiSpineAnimation, hairColorTagId, differentHair)
  if not hairColorTagId then
    return
  end
  if not differentHair and self.curShowHairColor == hairColorTagId then
    return
  end
  self.curShowHairColor = hairColorTagId
  ChangeSkinUtil.InitSpineHairColor(uiSpineAnimation.transform, hairColorTagId)
  return true
end

function CaptainSkinSystem:ReqSaveDress(callBack)
  if self.change then
    self.change = false
    local skinUidList = {}
    for skinType, skinItem in pairs(self.curShowNormalSkinItems) do
      table.insert(skinUidList, skinItem.skinUid)
    end
    for skinType, skinItems in pairs(self.curShowOverlaySkinItems) do
      for i, _skinItem in ipairs(skinItems) do
        table.insert(skinUidList, _skinItem.skinUid)
      end
    end
    local dressesStr = table.concat(skinUidList, ",")
    Net:SendProto("hero.dress", function(json)
      if callBack then
        callBack()
      end
    end, self.unitId, dressesStr)
  end
  CommonTips.OpenTips(80602333)
end

function CaptainSkinSystem:ReqDyeHairColor(itemId, callBack)
  local hairColorKey = self:GetCurShowHairColorKey()
  local defaultId = self.curShowHairSkinItem.skinUid == nil and self.defaultHairId or nil
  Net:SendProto("hero.hair_dye", function(json)
    local itemCA = PlayerData:GetFactoryData(itemId)
    local colorTag = itemCA.hairColor
    PlayerData.CaptainSkinSystem:GetAllHairColorData()[hairColorKey] = PlayerData.CaptainSkinSystem:GetAllHairColorData()[hairColorKey] or {}
    PlayerData.CaptainSkinSystem:GetAllHairColorData()[hairColorKey][tostring(colorTag)] = 0
    if callBack then
      callBack()
    end
  end, itemId, self.curShowHairSkinItem.skinUid, defaultId)
end

function CaptainSkinSystem:ReqSaveHairColor(callBack)
  local hairColorTagId = self.curShowHairColor
  if not self:IsCurShowHairHaveColor(hairColorTagId) then
    return
  end
  local hairColorKey = self:GetCurShowHairColorKey()
  local hairColor = self:GetCurHairColorData()[hairColorKey]
  if hairColor and tonumber(hairColor) == self.curShowHairColor then
    CommonTips.OpenTips(80602333)
    return
  end
  local defaultId = self.curShowHairSkinItem.skinUid == nil and self.defaultHairId or nil
  Net:SendProto("hero.hair_use", function(json)
    PlayerData.CaptainSkinSystem:GetCurHairColorData()[hairColorKey] = tostring(hairColorTagId)
    if callBack then
      callBack()
    end
  end, hairColorTagId, self.curShowHairSkinItem.skinUid, defaultId)
  CommonTips.OpenTips(80602333)
end

return CaptainSkinSystem
