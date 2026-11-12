local TemplateAffinityLevelCtrl = class("TemplateAffinityLevelCtrl", BaseCtrl)
TemplateAffinityLevelCtrl._mapNodeConfig = {
  imgHeart = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"}
}
TemplateAffinityLevelCtrl._mapEventConfig = {}

function TemplateAffinityLevelCtrl:SetInfo(nLevel)
  local data = {}
  
  local function forEachAffinityLevel(mapData)
    if mapData.AffinityLevel == nLevel then
      data = mapData
    end
  end
  
  ForEachTableLine(DataTable.AffinityLevel, forEachAffinityLevel)
  self:SetPngSprite(self._mapNode.imgHeart, data.AffinityLevelIcon)
  NovaAPI.SetTMPText(self._mapNode.txtLevel, nLevel)
end

return TemplateAffinityLevelCtrl
