local BuildSimpleDiscItem = class("BuildSimpleDiscItem", BaseCtrl)
BuildSimpleDiscItem._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  imgRarity = {sComponentName = "Image"},
  imgElement = {sComponentName = "Image"}
}
BuildSimpleDiscItem._mapEventConfig = {}
BuildSimpleDiscItem._mapRedDotConfig = {}

function BuildSimpleDiscItem:Init(nDiscId)
  local mapData = ConfigTable.GetData("Disc", nDiscId, true)
  if mapData == nil then
    mapData = ConfigTable.GetData("TrialDisc", nDiscId)
    if mapData ~= nil then
      nDiscId = mapData.DiscId
      mapData = ConfigTable.GetData("Disc", nDiscId)
    else
      return
    end
  end
  local mapCfg = ConfigTable.GetData_Item(nDiscId)
  self:SetPngSprite(self._mapNode.imgIcon, mapCfg.Icon .. AllEnum.OutfitIconSurfix.ListGrid)
  local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCfg.Rarity]
  self:SetAtlasSprite(self._mapNode.imgRarity, "12_rare", sFrame, true)
  self:SetAtlasSprite(self._mapNode.imgElement, "12_rare", AllEnum.Star_Element[mapData.EET].icon)
end

return BuildSimpleDiscItem
