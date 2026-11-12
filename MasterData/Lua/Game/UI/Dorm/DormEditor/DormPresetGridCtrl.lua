local DormPresetGridCtrl = class("DormPresetGridCtrl", BaseCtrl)
local DefaultPath = "Icon/DormFurnitureSet/DormFurnitureSet_1001"
DormPresetGridCtrl._mapNodeConfig = {
  imgSelect = {},
  imgIconMask = {},
  imgIcon = {sComponentName = "Image"},
  Use_Num = {},
  TMPNumUse = {sComponentName = "TMP_Text"},
  rtPreset = {},
  imgTag = {},
  TMPTagName = {sComponentName = "TMP_Text"},
  imgTagMask = {},
  imgMask = {},
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  btnEdit = {sComponentName = "UIButton"},
  TMPName = {sComponentName = "TMP_Text"},
  rtDetail = {},
  Use_Mask = {},
  TMPHintUse = {sComponentName = "TMP_Text"},
  TMPPresetHint = {sComponentName = "TMP_Text"},
  imgSaveMask = {},
  btn_use = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Use"
  },
  btn_overwrite = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Save"
  },
  btn_save = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Save"
  },
  goOverWrite = {},
  btnReward = {sComponentName = "UIButton"},
  txtBtnSave = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_PresetBtn_Save"
  },
  txtBtnUse = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_PresetBtn_Use"
  },
  txtBtnOverwrite = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_PresetBtn_OverWrite"
  }
}
DormPresetGridCtrl._mapEventConfig = {
  DormUpdatePresetNameSuc = "OnEvent_DormUpdatePresetNameSuc"
}
DormPresetGridCtrl._mapRedDotConfig = {}

function DormPresetGridCtrl:Awake()
  self.nIdx = 0
  self.nType = 0
  self.bEmpty = true
end

function DormPresetGridCtrl:FadeIn()
end

function DormPresetGridCtrl:FadeOut()
end

function DormPresetGridCtrl:OnEnable()
end

function DormPresetGridCtrl:OnDisable()
end

function DormPresetGridCtrl:OnDestroy()
end

function DormPresetGridCtrl:OnRelease()
end

function DormPresetGridCtrl:SetSuit(nSuitId, bEnable, bSelect)
  self.nType = 0
  self.nId = nSuitId
  self.bSelect = bSelect
  self._mapNode.btnEdit.gameObject:SetActive(false)
  self._mapNode.btnReward.gameObject:SetActive(false)
  self._mapNode.btnDetail.gameObject:SetActive(true)
  self._mapNode.imgIconMask:SetActive(true)
  local mapSuitCfgData = ConfigTable.GetData("DormLayoutReward", nSuitId)
  if mapSuitCfgData == nil then
    return
  end
  local nCurCount = 0
  local nTotalCount = 0
  local mapTempCount = {}
  local tbFurnitureList = self._panel.mapDormSuitData[nSuitId]
  if tbFurnitureList ~= nil then
    for _, mapFurniture in ipairs(tbFurnitureList) do
      local mapFurnitureCfg = ConfigTable.GetData("DormFurniture", mapFurniture.FurnitureId)
      if mapFurnitureCfg ~= nil and mapFurnitureCfg.NotShow < 1 then
        if mapTempCount[mapFurniture.FurnitureId] == nil then
          mapTempCount[mapFurniture.FurnitureId] = 0
        end
        mapTempCount[mapFurniture.FurnitureId] = mapTempCount[mapFurniture.FurnitureId] + 1
        local nCurBagCount = self._panel:GetFurnitureCountIncludeCurRoom(self._panel.nCurRoom, mapFurniture.FurnitureId)
        if nCurBagCount >= mapTempCount[mapFurniture.FurnitureId] then
          nCurCount = nCurCount + 1
        end
        nTotalCount = nTotalCount + 1
      end
    end
  end
  self._mapNode.Use_Num:SetActive(true)
  local str = nCurCount >= nTotalCount and string.format("%d/%d", nCurCount, nTotalCount) or string.format("<color=#ef3d5c>%d</color>/%d", nCurCount, nTotalCount)
  NovaAPI.SetTMPText(self._mapNode.TMPNumUse, str)
  NovaAPI.SetTMPText(self._mapNode.TMPName, mapSuitCfgData.RoomLayoutName)
  self:SetPngSprite(self._mapNode.imgIcon, mapSuitCfgData.RoomLayoutListIcon)
  self._mapNode.rtPreset:SetActive(false)
  self._mapNode.imgTag:SetActive(mapSuitCfgData.RoomLayoutTag ~= "")
  NovaAPI.SetTMPText(self._mapNode.TMPTagName, mapSuitCfgData.RoomLayoutTag)
  self:SetMask(not bEnable)
  if not bEnable then
    local nReason = mapSuitCfgData.RoomType == 0 and 2 or 1
    NovaAPI.SetTMPText(self._mapNode.TMPPresetHint, ConfigTable.GetUIText("Dorm_SuitHint_RoomType" .. nReason))
  end
  self:SetSelect(bSelect)
end

function DormPresetGridCtrl:SetPreset(sName, bEnable, bEmpty, bUse, bSelect, nIdx, nCreateTime, nRoomId)
  self.nType = 1
  self.nIdx = nIdx
  self.bEmpty = bEmpty
  self.bEnable = bEnable
  self.bSelect = bSelect
  self.nCreateTime = nCreateTime
  self._mapNode.btnEdit.gameObject:SetActive(false)
  self._mapNode.Use_Num:SetActive(false)
  self._mapNode.btnReward.gameObject:SetActive(false)
  self._mapNode.btnDetail.gameObject:SetActive(not self.bEmpty)
  NovaAPI.SetTMPText(self._mapNode.TMPName, sName)
  if not self.bEmpty then
    local spCover = self._panel:GetPresetCover(tostring(nCreateTime))
    if spCover ~= nil then
      self._mapNode.imgIconMask:SetActive(true)
      NovaAPI.SetImageSpriteAsset(self._mapNode.imgIcon, spCover)
    else
      self._mapNode.imgIconMask:SetActive(false)
    end
  else
    self._mapNode.imgIconMask:SetActive(false)
  end
  self._mapNode.imgTag:SetActive(false)
  self._mapNode.rtPreset:SetActive(true)
  self._mapNode.Use_Mask:SetActive(false)
  self._mapNode.btn_use.gameObject:SetActive(bEnable)
  if not bEnable then
    local mapRoomConfig = ConfigTable.GetData("DormRoom", nRoomId)
    if mapRoomConfig ~= nil then
      local nReason = mapRoomConfig.RoomType == 0 and 1 or 2
      NovaAPI.SetTMPText(self._mapNode.TMPPresetHint, ConfigTable.GetUIText("Dorm_SuitHint_RoomType" .. nReason))
    else
      NovaAPI.SetTMPText(self._mapNode.TMPPresetHint, "")
    end
  end
  self:SetMask(not bEnable and not bEmpty)
  self:SetSelectPreset(bSelect)
end

function DormPresetGridCtrl:SetSelectPreset(bSelect)
  self._mapNode.imgSelect:SetActive(bSelect)
  if self.bEmpty then
    self._mapNode.imgSaveMask:SetActive(true)
    self._mapNode.goOverWrite:SetActive(false)
  else
    self._mapNode.imgSaveMask:SetActive(false)
    self._mapNode.goOverWrite:SetActive(bSelect)
    self._mapNode.rtDetail:SetActive(not bSelect)
  end
end

function DormPresetGridCtrl:SetSelect(bSelect)
  self._mapNode.imgSelect:SetActive(bSelect)
end

function DormPresetGridCtrl:SetMask(bMask)
  self._mapNode.imgTagMask:SetActive(bMask)
  self._mapNode.imgMask:SetActive(bMask)
end

function DormPresetGridCtrl:OnBtnClick_Save()
  EventManager.Hit("DormPresetGrid_Save", self.nIdx)
end

function DormPresetGridCtrl:OnBtnClick_Use()
  local mapCurEnlabeCount = {}
  local bAllHave = true
  local mapPresetData = self._panel.mapPresetInfo[self.nIdx]
  local mapPresetCount = {}
  for _, mapFurnitur in ipairs(mapPresetData.FurnitureList) do
    if mapPresetCount[mapFurnitur.FurnitureId] == nil then
      mapPresetCount[mapFurnitur.FurnitureId] = 0
    end
    mapPresetCount[mapFurnitur.FurnitureId] = mapPresetCount[mapFurnitur.FurnitureId] + 1
  end
  for nFurnitureId, nNeedCount in pairs(mapPresetCount) do
    local nCurCount = self._panel:GetFurnitureCountIncludeCurRoom(self._panel.nCurRoom, nFurnitureId)
    if nNeedCount > nCurCount then
      bAllHave = false
      break
    end
  end
  
  local function confirmCallback()
    EventManager.Hit("DormPresetGrid_Use", self.nIdx)
  end
  
  local sContent
  if bAllHave then
    sContent = ConfigTable.GetUIText("Dorm_PresetUseHint")
  else
    sContent = ConfigTable.GetUIText("Dorm_PresetUseLackHint")
  end
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sContent,
    callbackConfirmAfterClose = confirmCallback,
    bDisableSnap = false,
    bCloseNoHandler = true
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function DormPresetGridCtrl:OnBtnClick_Detail()
  if self.nType == 1 then
    local function callback(bConfirm)
      if bConfirm then
        self:OnBtnClick_Use()
      end
    end
    
    local mapPresetData = self._panel.mapPresetInfo[self.nIdx]
    local spCover = self._panel:GetPresetCover(tostring(self.nCreateTime))
    local mapCurEnlabeCount = {}
    for _, mapFurnitur in ipairs(mapPresetData.FurnitureList) do
      if mapCurEnlabeCount[mapFurnitur.FurnitureId] == nil then
        mapCurEnlabeCount[mapFurnitur.FurnitureId] = self._panel:GetFurnitureCountIncludeCurRoom(self._panel.nCurRoom, mapFurnitur.FurnitureId)
      end
    end
    EventManager.Hit(EventId.OpenPanel, PanelId.DormEditorPresetDetailPanel, mapPresetData, self.bEnable, self.bSelect, self._panel.nCurRoom, mapCurEnlabeCount, callback, spCover)
  else
    local function callback(bConfirm)
      if bConfirm then
        EventManager.Hit("DormSuitGrid_Use", self.nId)
      end
    end
    
    local nSuitId = self.nId
    local tbSuitFurniture = self._panel.mapDormSuitData[nSuitId]
    local mapCurCount = {}
    local mapTotalCount = {}
    for _, mapFurniture in ipairs(tbSuitFurniture) do
      if mapCurCount[mapFurniture.FurnitureId] == nil then
        mapCurCount[mapFurniture.FurnitureId] = self._panel:GetFurnitureCountIncludeCurRoom(self._panel.nCurRoom, mapFurniture.FurnitureId)
      end
      if mapTotalCount[mapFurniture.FurnitureId] == nil then
        mapTotalCount[mapFurniture.FurnitureId] = self._panel:GetBagFurnitureCount(mapFurniture.FurnitureId)
      end
    end
    local nRoom = self._panel.nCurRoom
    local bCurSuit = self.bSelect
    EventManager.Hit(EventId.OpenPanel, PanelId.DormEditorSuitDetailPanel, nSuitId, tbSuitFurniture, mapCurCount, nRoom, mapTotalCount, bCurSuit, callback)
  end
end

function DormPresetGridCtrl:OnEvent_DormUpdatePresetNameSuc(nBuildId, sName)
  if self.nType == 1 and self.nIdx == nBuildId then
    NovaAPI.SetTMPText(self._mapNode.TMPName, sName)
  end
end

return DormPresetGridCtrl
