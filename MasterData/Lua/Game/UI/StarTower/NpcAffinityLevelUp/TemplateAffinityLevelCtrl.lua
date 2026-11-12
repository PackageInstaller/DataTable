local TemplateAffinityLevelCtrl = class("TemplateAffinityLevelCtrl", BaseCtrl)
TemplateAffinityLevelCtrl._mapNodeConfig = {
  imgHeart = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"}
}
TemplateAffinityLevelCtrl._mapEventConfig = {}

function TemplateAffinityLevelCtrl:SetInfo(nLevel, NpcId)
  local mapNpc = ConfigTable.GetData("StarTowerNPC", NpcId)
  if mapNpc ~= nil then
    local nGroupId = mapNpc.AffinityGroupId
    local nId = nGroupId * 100 + nLevel
    local mapAffinityCfgData = ConfigTable.GetData("NPCAffinityGroup", nId)
    if mapAffinityCfgData ~= nil then
      self:SetPngSprite(self._mapNode.imgHeart, mapAffinityCfgData.Icon)
      NovaAPI.SetTMPText(self._mapNode.txtLevel, nLevel)
    end
  end
end

return TemplateAffinityLevelCtrl
