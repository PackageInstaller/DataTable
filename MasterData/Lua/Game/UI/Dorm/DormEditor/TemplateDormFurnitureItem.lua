local TemplateDormFurnitureItem = class("TemplateDormFurnitureItem", BaseCtrl)
TemplateDormFurnitureItem._mapNodeConfig = {
  imgRare = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  txtCount = {sComponentName = "TMP_Text"},
  TMPMaskHint = {sComponentName = "TMP_Text"},
  ItemText = {sComponentName = "TMP_Text"},
  imgMask = {},
  imgMarkMask = {},
  imgMark = {},
  btnInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Info"
  },
  rtContent = {},
  txtX = {}
}
TemplateDormFurnitureItem._mapEventConfig = {}
TemplateDormFurnitureItem._mapRedDotConfig = {}

function TemplateDormFurnitureItem:Awake()
end

function TemplateDormFurnitureItem:FadeIn()
end

function TemplateDormFurnitureItem:FadeOut()
end

function TemplateDormFurnitureItem:OnEnable()
end

function TemplateDormFurnitureItem:OnDisable()
end

function TemplateDormFurnitureItem:OnDestroy()
end

function TemplateDormFurnitureItem:OnRelease()
end

function TemplateDormFurnitureItem:Refresh(nFurnitureId, nCount, nRoomId)
  local mapFurnitureCfg = ConfigTable.GetData("DormFurniture", nFurnitureId)
  local mapFurnitureItemCfg = ConfigTable.GetData("Item", nFurnitureId)
  if mapFurnitureCfg == nil or mapFurnitureItemCfg == nil then
    return
  end
  self.nFurnitureId = nFurnitureId
  self.nItemCount = nCount
  local bEnable = true
  local nReason = 0
  if 0 < nRoomId then
    local mapRoomConfig = ConfigTable.GetData("DormRoom", nRoomId)
    if mapRoomConfig ~= nil then
      bEnable = 0 < table.indexof(mapFurnitureCfg.CanIn, mapRoomConfig.RoomType)
      if not bEnable then
        nReason = mapRoomConfig.RoomType == 0 and 1 or 2
      end
    end
  end
  self.bEnable = bEnable
  NovaAPI.SetTMPText(self._mapNode.txtCount, nCount)
  NovaAPI.SetTMPText(self._mapNode.ItemText, mapFurnitureItemCfg.Title)
  self:SetPngSprite(self._mapNode.imgIcon, mapFurnitureItemCfg.Icon)
  local sFrame = AllEnum.FrameType_New.DormFurniture .. AllEnum.FrameColor_New[mapFurnitureItemCfg.Rarity]
  self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sFrame)
  self._mapNode.imgMark:SetActive(0 < mapFurnitureCfg.ActorSD_Id)
  self:SetMask(not bEnable, nReason)
end

function TemplateDormFurnitureItem:RefreshHandbook(nFurnitureId, nCount)
  local mapFurnitureCfg = ConfigTable.GetData("DormFurniture", nFurnitureId)
  local mapFurnitureItemCfg = ConfigTable.GetData("Item", nFurnitureId)
  if mapFurnitureCfg == nil or mapFurnitureItemCfg == nil then
    return
  end
  self.nFurnitureId = nFurnitureId
  self.nItemCount = nCount
  self.bEnable = 0 < nCount
  NovaAPI.SetTMPText(self._mapNode.txtCount, "")
  self._mapNode.txtX:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.ItemText, mapFurnitureItemCfg.Title)
  self:SetPngSprite(self._mapNode.imgIcon, mapFurnitureItemCfg.Icon)
  local sFrame = AllEnum.FrameType_New.DormFurniture .. AllEnum.FrameColor_New[mapFurnitureItemCfg.Rarity]
  self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sFrame)
  self._mapNode.imgMark:SetActive(0 < mapFurnitureCfg.ActorSD_Id)
  self:SetMask(not self.bEnable, 4)
end

function TemplateDormFurnitureItem:RefreshInSuitPreset(nFurnitureId, nCurCount, nNeedCount, nRoomId)
  local mapFurnitureCfg = ConfigTable.GetData("DormFurniture", nFurnitureId)
  local mapFurnitureItemCfg = ConfigTable.GetData("Item", nFurnitureId)
  self._mapNode.txtX:SetActive(false)
  if mapFurnitureCfg == nil or mapFurnitureItemCfg == nil then
    return
  end
  self.nFurnitureId = nFurnitureId
  self.nItemCount = nNeedCount
  local bEnable = true
  if nCurCount < nNeedCount then
    bEnable = false
  end
  local nReason = 0
  if 0 < nRoomId then
    local mapRoomConfig = ConfigTable.GetData("DormRoom", nRoomId)
    if mapRoomConfig ~= nil then
      local bRoomType = 0 < table.indexof(mapFurnitureCfg.CanIn, mapRoomConfig.RoomType)
      if not bRoomType then
        bEnable = false
        nReason = mapRoomConfig.RoomType == 0 and 1 or 2
      end
    end
  end
  self.bEnable = bEnable
  local sCount
  if nCurCount < nNeedCount then
    sCount = string.format("<color=#fa4e6c>%d</color>/%d", nCurCount, nNeedCount)
  else
    sCount = string.format("%d/%d", nCurCount, nNeedCount)
  end
  NovaAPI.SetTMPText(self._mapNode.txtCount, sCount)
  NovaAPI.SetTMPText(self._mapNode.ItemText, mapFurnitureItemCfg.Title)
  self:SetPngSprite(self._mapNode.imgIcon, mapFurnitureItemCfg.Icon)
  local sFrame = AllEnum.FrameType_New.DormFurniture .. AllEnum.FrameColor_New[mapFurnitureItemCfg.Rarity]
  self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sFrame)
  self._mapNode.imgMark:SetActive(0 < mapFurnitureCfg.ActorSD_Id)
  local bHave = PlayerData.PlayerDormData:CheckGetFurnitureById(nFurnitureId)
  self:SetMask(not bHave, 4)
end

function TemplateDormFurnitureItem:SetMask(bMask, nReason)
  self._mapNode.imgMask:SetActive(bMask)
  self._mapNode.imgMarkMask:SetActive(bMask)
  if bMask then
    local sReason = ConfigTable.GetUIText("Dorm_ItemHint_RoomType" .. nReason)
    NovaAPI.SetTMPText(self._mapNode.TMPMaskHint, sReason)
  end
end

function TemplateDormFurnitureItem:SetCount(nCount)
  self.nItemCount = nCount
  NovaAPI.SetTMPText(self._mapNode.txtCount, nCount)
  self:SetMask(nCount < 1, 3)
end

function TemplateDormFurnitureItem:OnBtnClick_Info()
  UTILS.ClickItemGridWithTips(self.nFurnitureId, self._mapNode.rtContent, false, false, false)
end

return TemplateDormFurnitureItem
