local BuildDiscSkillCtrl = class("BuildDiscSkillCtrl", BaseCtrl)
BuildDiscSkillCtrl._mapNodeConfig = {
  btnDiscSkill = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tips"
  },
  goSkillNone = {},
  imgDiscSkillIcon = {sComponentName = "Image"},
  imgDiscSkillIconBg = {nCount = 2, sComponentName = "Image"},
  txtDiscSkillLv = {sComponentName = "TMP_Text", sLanguageId = "Lv"},
  txtDiscSkillLevel = {sComponentName = "TMP_Text"},
  goSkillOff = {}
}
BuildDiscSkillCtrl._mapEventConfig = {}

function BuildDiscSkillCtrl:Refresh(mapSkill, card)
  self.mapSkill = mapSkill
  self.card = card
  local bEmpty = not self.mapSkill
  self._mapNode.goSkillNone:SetActive(bEmpty)
  self._mapNode.imgDiscSkillIcon.gameObject:SetActive(not bEmpty)
  self._mapNode.imgDiscSkillIconBg[1].gameObject:SetActive(not bEmpty)
  self._mapNode.txtDiscSkillLv.gameObject:SetActive(not bEmpty)
  self._mapNode.goSkillOff:SetActive(not bEmpty)
  if bEmpty then
    return
  end
  local skillCfg
  if mapSkill.nType == AllEnum.DiscSkillType.Common then
    skillCfg = ConfigTable.GetData("DiscCommonSkill", mapSkill.nId)
  else
    skillCfg = ConfigTable.GetData("DiscPassiveSkill", mapSkill.nId)
  end
  if skillCfg == nil then
    return
  end
  for i = 1, 2 do
    self:SetPngSprite(self._mapNode.imgDiscSkillIconBg[i], skillCfg.IconBg)
  end
  self:SetPngSprite(self._mapNode.imgDiscSkillIcon, skillCfg.Icon)
  local bUnlock = mapSkill.nLevel > 0
  self._mapNode.goSkillOff:SetActive(not bUnlock)
  self._mapNode.txtDiscSkillLv.gameObject:SetActive(bUnlock)
  if bUnlock then
    NovaAPI.SetTMPText(self._mapNode.txtDiscSkillLevel, mapSkill.nLevel)
  end
end

function BuildDiscSkillCtrl:Awake()
end

function BuildDiscSkillCtrl:OnEnable()
end

function BuildDiscSkillCtrl:OnDisable()
end

function BuildDiscSkillCtrl:OnDestroy()
end

function BuildDiscSkillCtrl:OnRelease()
end

function BuildDiscSkillCtrl:OnBtnClick_Tips(btn)
  if not self.mapSkill then
    return
  end
  
  local function callback()
    local mapData = {
      nType = self.mapSkill.nType,
      nSkillId = self.mapSkill.nId,
      nLevel = self.mapSkill.nLevel,
      nMaxLevel = self.mapSkill.nMaxLevel
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscSkillTips, btn.transform, mapData)
  end
  
  EventManager.Hit("BuildClickDiscSkill", self.card, callback)
end

return BuildDiscSkillCtrl
