local SoldierCharSkillItemCtrl = class("SoldierCharSkillItemCtrl", BaseCtrl)
SoldierCharSkillItemCtrl._mapNodeConfig = {
  imgBg = {nCount = 2, sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  imgType = {sComponentName = "Image"}
}
SoldierCharSkillItemCtrl._mapEventConfig = {}
SoldierCharSkillItemCtrl._mapRedDotConfig = {}

function SoldierCharSkillItemCtrl:Awake()
end

function SoldierCharSkillItemCtrl:OnEnable()
end

function SoldierCharSkillItemCtrl:OnDisable()
end

function SoldierCharSkillItemCtrl:OnDestroy()
end

function SoldierCharSkillItemCtrl:SetData(nSkillId, nSkillIndex)
  local skillCfg = ConfigTable.GetData_Skill(nSkillId)
  if nil == skillCfg then
    printError("找不到技能配置！！技能id = " .. nSkillId)
    return
  end
  local skillShowCfg = AllEnum.SkillTypeShow[nSkillIndex]
  local bgIconIndex = skillShowCfg.bgIconIndex
  self:SetAtlasSprite(self._mapNode.imgBg[2], "10_ico", "zs_character_skill_" .. bgIconIndex)
  local _, color = ColorUtility.TryParseHtmlString(skillShowCfg.bgColor)
  NovaAPI.SetImageColor(self._mapNode.imgBg[2], Color(color.r, color.g, color.b, 0.19607843137254902))
  self:SetAtlasSprite(self._mapNode.imgBg[1], "12_rare", "rare_character_skill_6")
  local skillTypeIconIdx = skillShowCfg.iconIndex
  self:SetAtlasSprite(self._mapNode.imgType, "05_language", "zs_character_skill_text_" .. skillTypeIconIdx)
  NovaAPI.SetImageNativeSize(self._mapNode.imgType)
  self:SetPngSprite(self._mapNode.imgIcon, skillCfg.Icon)
end

return SoldierCharSkillItemCtrl
