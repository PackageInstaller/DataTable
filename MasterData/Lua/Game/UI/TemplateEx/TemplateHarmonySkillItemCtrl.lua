local TemplateHarmonySkillItemCtrl = class("TemplateHarmonySkillItemCtrl", BaseCtrl)
TemplateHarmonySkillItemCtrl._mapNodeConfig = {
  imgRare = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  imgIconBg = {sComponentName = "Image"},
  imgCornerBg = {sComponentName = "Image"},
  imgCornerIcon = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  txtTag = {sComponentName = "TMP_Text"},
  Select = {}
}
TemplateHarmonySkillItemCtrl._mapEventConfig = {}

function TemplateHarmonySkillItemCtrl:Refresh(nId)
  local mapCfg = ConfigTable.GetData("StarTowerHarmonySkill", nId)
  if not mapCfg then
    return
  end
  local mapTag = ConfigTable.GetData("DiscTag", mapCfg.Tag)
  if mapTag then
    NovaAPI.SetTMPText(self._mapNode.txtTag, mapTag.Title)
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  local sFrame = AllEnum.FrameType_New.HarmonySkillS .. AllEnum.FrameColor_New[mapCfg.Rarity]
  self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sFrame)
  self:SetPngSprite(self._mapNode.imgIcon, mapCfg.Icon)
  self:SetPngSprite(self._mapNode.imgIconBg, mapCfg.IconBg)
  self._mapNode.imgCornerBg.gameObject:SetActive(mapCfg.IconCorner ~= "")
  if mapCfg.IconCorner ~= "" then
    self:SetPngSprite(self._mapNode.imgCornerBg, mapCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Corner)
    self:SetPngSprite(self._mapNode.imgCornerIcon, mapCfg.IconCorner)
  end
end

function TemplateHarmonySkillItemCtrl:SetSelect(bSelect)
  self._mapNode.Select:SetActive(bSelect)
end

return TemplateHarmonySkillItemCtrl
