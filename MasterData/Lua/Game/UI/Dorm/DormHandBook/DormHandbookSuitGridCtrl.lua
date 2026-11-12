local DormHandbookSuitGridCtrl = class("DormHandbookSuitGridCtrl", BaseCtrl)
local DefaultPath = "Icon/DormFurnitureSet/DormFurnitureSet_1001"
DormHandbookSuitGridCtrl._mapNodeConfig = {
  imgSelect = {},
  imgIcon = {sComponentName = "Image"},
  Use_Num = {},
  TMPNum = {sComponentName = "TMP_Text"},
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
  imgSaveMask = {},
  goOverWrite = {},
  btnReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  }
}
DormHandbookSuitGridCtrl._mapEventConfig = {
  DormUpdatePresetNameSuc = "OnEvent_DormUpdatePresetNameSuc",
  DormLayoutRewardReceive = "OnEvent_LayoutRewardReceive"
}
DormHandbookSuitGridCtrl._mapRedDotConfig = {}

function DormHandbookSuitGridCtrl:Awake()
  self.nIdx = 0
  self.nType = 0
  self.bEmpty = true
end

function DormHandbookSuitGridCtrl:FadeIn()
end

function DormHandbookSuitGridCtrl:FadeOut()
end

function DormHandbookSuitGridCtrl:OnEnable()
end

function DormHandbookSuitGridCtrl:OnDisable()
end

function DormHandbookSuitGridCtrl:OnDestroy()
end

function DormHandbookSuitGridCtrl:OnRelease()
end

function DormHandbookSuitGridCtrl:SetSuit(nSuitId, bEnable, bReceived, mapBagCount)
  self.nType = 0
  self.nId = nSuitId
  self._mapNode.btnEdit.gameObject:SetActive(false)
  self._mapNode.btnReward.gameObject:SetActive(false)
  self._mapNode.btnDetail.gameObject:SetActive(false)
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
        local nCurBagCount = mapBagCount[mapFurniture.FurnitureId] == nil and 0 or mapBagCount[mapFurniture.FurnitureId]
        if nCurBagCount >= mapTempCount[mapFurniture.FurnitureId] then
          nCurCount = nCurCount + 1
        end
        nTotalCount = nTotalCount + 1
      end
    end
  end
  self._mapNode.Use_Num:SetActive(false)
  if bReceived then
    self._mapNode.btnReward.gameObject:SetActive(false)
    local str = string.format("%d/%d", nTotalCount, nTotalCount)
    NovaAPI.SetTMPText(self._mapNode.TMPNum, str)
  else
    self._mapNode.btnReward.gameObject:SetActive(nCurCount >= nTotalCount)
    local str = nCurCount >= nTotalCount and string.format("%d/%d", nCurCount, nTotalCount) or string.format("<color=#ef3d5c>%d</color>/%d", nCurCount, nTotalCount)
    NovaAPI.SetTMPText(self._mapNode.TMPNum, str)
  end
  self.nCurCount = nCurCount
  self.nTotalCount = nTotalCount
  NovaAPI.SetTMPText(self._mapNode.TMPName, mapSuitCfgData.RoomLayoutName)
  self:SetPngSprite(self._mapNode.imgIcon, mapSuitCfgData.RoomLayoutListIcon)
  self._mapNode.rtPreset:SetActive(false)
  self._mapNode.imgTag:SetActive(mapSuitCfgData.RoomLayoutTag ~= "")
  NovaAPI.SetTMPText(self._mapNode.TMPTagName, mapSuitCfgData.RoomLayoutTag)
  self:SetMask(not bEnable)
  self:SetSelect(false)
end

function DormHandbookSuitGridCtrl:SetSelectPreset(bSelect)
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

function DormHandbookSuitGridCtrl:SetSelect(bSelect)
  self._mapNode.imgSelect:SetActive(bSelect)
end

function DormHandbookSuitGridCtrl:SetMask(bMask)
  self._mapNode.imgTagMask:SetActive(bMask)
  self._mapNode.imgMask:SetActive(bMask)
end

function DormHandbookSuitGridCtrl:OnBtnClick_Detail()
  if self.nType == 1 then
    local function callback(bConfirm)
      if bConfirm then
        self:OnBtnClick_Use()
      end
    end
    
    local mapPresetData = self._panel.mapPresetInfo[self.nIdx]
    local spCover = self._panel:GetPresetCover(tostring(self.nCreateTime))
    EventManager.Hit(EventId.OpenPanel, PanelId.DormEditorPresetDetailPanel, mapPresetData, self.bEnable, self.bSelect, self._panel.nCurRoom, callback, spCover)
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

function DormHandbookSuitGridCtrl:OnBtnClick_Reward(btn)
  local function callback(changeInfo, _)
    self._mapNode.btnReward.gameObject:SetActive(false)
    
    UTILS.OpenReceiveByChangeInfo(changeInfo)
  end
  
  PlayerData.PlayerDormData:DormLayoutRewardReceive({
    self.nId
  }, callback)
end

function DormHandbookSuitGridCtrl:OnEvent_LayoutRewardReceive()
  local bReceived = PlayerData.PlayerDormData:CheckLayoutReceived(self.nId)
  if bReceived then
    self._mapNode.btnReward.gameObject:SetActive(false)
    local str = string.format("%d/%d", self.nTotalCount, self.nTotalCount)
    NovaAPI.SetTMPText(self._mapNode.TMPNum, str)
  else
    self._mapNode.btnReward.gameObject:SetActive(self.nCurCount >= self.nTotalCount)
    local str = self.nCurCount >= self.nTotalCount and string.format("%d/%d", self.nCurCount, self.nTotalCount) or string.format("<color=#ef3d5c>%d</color>/%d", self.nCurCount, self.nTotalCount)
    NovaAPI.SetTMPText(self._mapNode.TMPNum, str)
  end
end

return DormHandbookSuitGridCtrl
