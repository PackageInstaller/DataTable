local SoldierBossTemplateItemCtrl = class("SoldierBossTemplateItemCtrl", BaseCtrl)
SoldierBossTemplateItemCtrl._mapNodeConfig = {
  animRoot = {
    sNodeName = "AnimRootMain",
    sComponentName = "Animator"
  },
  imgCharHead = {sComponentName = "Image"},
  txtCharName = {sComponentName = "TMP_Text"},
  goPersonality = {nCount = 3},
  txtPersonality1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Instinct"
  },
  txtPersonality2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Analyze"
  },
  txtPersonality3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Chaos"
  },
  imgPersonalityPercent = {nCount = 3, sComponentName = "Image"},
  txtSkillTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Boss_Template_Skill_Title"
  },
  imgSkill = {sComponentName = "Image"},
  imgSkillInitiative = {},
  txtSkillInitiative = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BossSkill_Active"
  },
  imgSkillPassive = {},
  txtSkillPassive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BossSkill_Passive"
  },
  txt_bossSkillName = {sComponentName = "TMP_Text"},
  txt_bossSkillType = {sComponentName = "TMP_Text"},
  txt_Desc = {sComponentName = "TMP_Text"},
  goLocked = {sNodeName = "rtLock"},
  txt_Lock = {sComponentName = "TMP_Text"},
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BossTemplate_Confirm"
  }
}
SoldierBossTemplateItemCtrl._mapEventConfig = {}
SoldierBossTemplateItemCtrl._mapRedDotConfig = {}

function SoldierBossTemplateItemCtrl:Awake()
end

function SoldierBossTemplateItemCtrl:SetItemData(mapData)
  self.mapData = mapData
  local nTemplateId = mapData.nId
  local mapCfg = ConfigTable.GetData("SoldierBossTemplate", nTemplateId)
  if mapCfg ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtCharName, mapCfg.Name or "")
    self:SetPngSprite(self._mapNode.imgCharHead, mapCfg.SoldierPlayerHead)
    self:SetPngSprite(self._mapNode.imgSkill, mapCfg.SoldierRoleSkillIcon)
    NovaAPI.SetTMPText(self._mapNode.txt_bossSkillName, mapCfg.Title or "")
    NovaAPI.SetTMPText(self._mapNode.txt_Desc, mapCfg.Desc or "")
    local nSkillType = mapCfg.SoldierRoleSkillType
    self._mapNode.imgSkillPassive.gameObject:SetActive(nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_1 or nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_3)
    self._mapNode.imgSkillInitiative.gameObject:SetActive(nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_2 or nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_4)
    local showCfg = AllEnum.SoldierBossSkillType[nSkillType]
    if showCfg ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txt_bossSkillType, ConfigTable.GetUIText(showCfg.sLanguageId))
    end
    for i = 1, 3 do
      local nType = 0
      if i == 1 then
        nType = mapCfg.Personality_Intuition
      elseif i == 2 then
        nType = mapCfg.Personality_Analysis
      elseif i == 3 then
        nType = mapCfg.Personality_Chaos
      end
      local mapGradeCfg = ConfigTable.GetData("SoldierBossPersonalityGrade", nType)
      if mapGradeCfg ~= nil then
        self:SetPngSprite(self._mapNode.imgPersonalityPercent[i], mapGradeCfg.Icon)
      end
    end
    if mapData.nUnlock == 0 then
      local nNodeId = mapCfg.TechNodeId
      local mapTechNodeCfg = ConfigTable.GetData("SoldierTechNode", nNodeId)
      if mapTechNodeCfg ~= nil then
        local sLock = orderedFormat(ConfigTable.GetUIText("Soldier_BossTemplate_Lock"), mapTechNodeCfg.Name)
        NovaAPI.SetTMPText(self._mapNode.txt_Lock, sLock)
      end
    end
  end
  self._mapNode.goLocked:SetActive(mapData.nUnlock == 0)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
end

function SoldierBossTemplateItemCtrl:SetSelected(bSel)
  if self.mapData == nil or self.mapData.nUnlock == 0 then
    return
  end
  self._mapNode.btnConfirm.gameObject:SetActive(bSel)
  if bSel then
    self._mapNode.animRoot:Play("BossTemplateItem_up", 0, 0)
  else
    self._mapNode.animRoot:Play("BossTemplateItem_down", 0, 0)
  end
end

function SoldierBossTemplateItemCtrl:OnBtnClick_Confirm()
  PlayerData.SoldierData:GetCurLevelData():SendSelectBossAbility(self.mapData.nId, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.SoldierBossTemplateSelect)
  end)
end

return SoldierBossTemplateItemCtrl
