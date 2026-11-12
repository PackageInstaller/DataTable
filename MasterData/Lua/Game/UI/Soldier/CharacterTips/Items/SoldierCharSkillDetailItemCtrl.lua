local SoldierCharSkillDetailItemCtrl = class("SoldierCharSkillDetailItemCtrl", BaseCtrl)
SoldierCharSkillDetailItemCtrl._mapNodeConfig = {
  goSkillItem = {
    sCtrlName = "Game.UI.Soldier.CharacterTips.Items.SoldierCharSkillItemCtrl"
  },
  txt_title = {sComponentName = "TMP_Text"},
  txt_desc = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "txt_desc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  imgLine = {}
}
SoldierCharSkillDetailItemCtrl._mapEventConfig = {}
SoldierCharSkillDetailItemCtrl._mapRedDotConfig = {}

function SoldierCharSkillDetailItemCtrl:Awake()
end

function SoldierCharSkillDetailItemCtrl:OnEnable()
end

function SoldierCharSkillDetailItemCtrl:OnDisable()
end

function SoldierCharSkillDetailItemCtrl:OnDestroy()
end

function SoldierCharSkillDetailItemCtrl:SetData(nSkillId, nSkillIndex, nSkillLevel, bLast)
  if nSkillId == nil or nSkillId == 0 then
    self.gameObject:SetActive(false)
    return
  end
  self.gameObject:SetActive(true)
  self.nSkillId = nSkillId
  self._mapNode.goSkillItem:SetData(nSkillId, nSkillIndex)
  local skillCfg = ConfigTable.GetData("Skill", nSkillId)
  if skillCfg == nil then
    printError("[SoldierCharSkillDetailItemCtrl] Skill 表找不到数据，id：" .. tostring(nSkillId))
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txt_title, skillCfg.Title)
  local sDesc = UTILS.ParseDesc(skillCfg, GameEnum.levelTypeData.SoldierLevel, nil, false, nSkillLevel)
  NovaAPI.SetTMPText(self._mapNode.txt_desc, sDesc)
  self._mapNode.imgLine:SetActive(not bLast)
end

function SoldierCharSkillDetailItemCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return SoldierCharSkillDetailItemCtrl
