local TemplateDiscSkillCardCtrl = class("TemplateDiscSkillCardCtrl", BaseCtrl)
TemplateDiscSkillCardCtrl._mapNodeConfig = {
  imgRare = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  imgIconBg = {sComponentName = "Image"},
  imgCornerBg = {sComponentName = "Image"},
  imgCornerIcon = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  txtName = {sComponentName = "TMP_Text"},
  goStar = {sComponentName = "Image"},
  goStarEmpty = {},
  Content = {
    sComponentName = "RectTransform"
  },
  txtDesc = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "txtDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  }
}
TemplateDiscSkillCardCtrl._mapEventConfig = {}

function TemplateDiscSkillCardCtrl:Refresh(nDiscId, nMainSkillId, nSubSkillId, nStar)
  local mapItem = ConfigTable.GetData("Item", nDiscId)
  if not mapItem then
    return
  end
  self._mapNode.goStar.gameObject:SetActive(nMainSkillId)
  self._mapNode.goStarEmpty.gameObject:SetActive(nMainSkillId)
  self._mapNode.txtLevel.gameObject:SetActive(nSubSkillId)
  if nMainSkillId ~= nil then
    self:SetAtlasSprite(self._mapNode.goStar, "12_rare", AllEnum.FrameType_New.DiscLimitS .. AllEnum.FrameColor_New[mapItem.Rarity] .. "_0" .. nStar + 1)
    NovaAPI.SetImageNativeSize(self._mapNode.goStar)
    local mapSkillCfg = ConfigTable.GetData("MainSkill", nMainSkillId)
    if mapSkillCfg ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtName, mapSkillCfg.Name)
      self:SetPngSprite(self._mapNode.imgIcon, mapSkillCfg.Icon)
      self:SetPngSprite(self._mapNode.imgIconBg, mapSkillCfg.IconBg)
      NovaAPI.SetTMPText(self._mapNode.txtDesc, UTILS.ParseParamDesc(mapSkillCfg.Desc, mapSkillCfg))
    end
  elseif nSubSkillId ~= nil then
    local mapSkillCfg = ConfigTable.GetData("SecondarySkill", nSubSkillId)
    if mapSkillCfg ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("Disc_Skill_Level") or "", mapSkillCfg.Level))
      NovaAPI.SetTMPText(self._mapNode.txtName, mapSkillCfg.Name)
      self:SetPngSprite(self._mapNode.imgIcon, mapSkillCfg.Icon)
      self:SetPngSprite(self._mapNode.imgIconBg, mapSkillCfg.IconBg)
      NovaAPI.SetTMPText(self._mapNode.txtDesc, UTILS.ParseParamDesc(mapSkillCfg.Desc, mapSkillCfg))
    end
  end
  local sFrame = AllEnum.FrameType_New.HarmonySkillL .. AllEnum.FrameColor_New[mapItem.Rarity]
  self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sFrame)
  self._mapNode.imgCornerBg.gameObject:SetActive(false)
  self._mapNode.Content.anchoredPosition = Vector2(0, 0)
  self:ChangeWordRaycast(false)
end

function TemplateDiscSkillCardCtrl:ChangeWordRaycast(bEnable)
  self._mapNode.txtDesc.raycastTarget = bEnable
end

function TemplateDiscSkillCardCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return TemplateDiscSkillCardCtrl
