local DiscNoteSkillItemCtrl = class("DiscNoteSkillItemCtrl", BaseCtrl)
DiscNoteSkillItemCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"},
  txtLastLevel = {sComponentName = "TMP_Text"},
  txtCurLevel = {sComponentName = "TMP_Text"},
  imgCritical = {},
  txtCritical = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_Skill_Active_Critical_Text"
  }
}
DiscNoteSkillItemCtrl._mapEventConfig = {}
DiscNoteSkillItemCtrl._mapRedDotConfig = {}

function DiscNoteSkillItemCtrl:Awake()
end

function DiscNoteSkillItemCtrl:OnEnable()
end

function DiscNoteSkillItemCtrl:OnDisable()
end

function DiscNoteSkillItemCtrl:OnDestroy()
end

function DiscNoteSkillItemCtrl:SetSkillItem(nNoteId, nCurLevel, nLastLevel, bLucky)
  local mapCfg = ConfigTable.GetData("SubNoteSkill", nNoteId)
  if mapCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgIcon, mapCfg.Icon)
    NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
    local sDesc = UTILS.ParseDesc(mapCfg, nil, nil, false, nCurLevel)
    NovaAPI.SetTMPText(self._mapNode.txtDesc, sDesc)
    NovaAPI.SetTMPText(self._mapNode.txtLastLevel, orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Tips_Skill_Lv"), nLastLevel))
    NovaAPI.SetTMPText(self._mapNode.txtCurLevel, orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Tips_Skill_Lv"), nCurLevel))
    self._mapNode.imgCritical.gameObject:SetActive(bLucky)
  end
end

return DiscNoteSkillItemCtrl
