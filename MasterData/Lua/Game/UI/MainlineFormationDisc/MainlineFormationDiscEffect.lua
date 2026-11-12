local MainlineFormationDiscEffect = class("MainlineFormationDiscEffect", BaseCtrl)
MainlineFormationDiscEffect._mapNodeConfig = {
  discNone = {},
  tex_Effect_discNone = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainlineFormationDisc_None"
  },
  discMsg = {},
  discName = {sComponentName = "TMP_Text"},
  goPassiveSkill = {
    sCtrlName = "Game.UI.Disc.DiscCoreSkillCtrl"
  },
  goCommonSkill = {
    nCount = 2,
    sCtrlName = "Game.UI.Disc.DiscCommonSkillCtrl"
  },
  goCommonNone = {nCount = 2}
}

function MainlineFormationDiscEffect:Refresh(nId)
  if nId == 0 then
    self._mapNode.discNone:SetActive(true)
    self._mapNode.discMsg:SetActive(false)
    self.nId = 0
    return
  else
    self._mapNode.discNone:SetActive(false)
    self._mapNode.discMsg:SetActive(true)
  end
  self.nId = nId
  self.mapData = PlayerData.Disc:GetDiscById(nId)
  NovaAPI.SetTMPText(self._mapNode.discName, self.mapData.sName)
  local nPassiveSkillId = self.mapData.nPassiveSkillId
  if nPassiveSkillId then
    self._mapNode.goPassiveSkill.gameObject:SetActive(true)
    self._mapNode.goPassiveSkill:Refresh(nPassiveSkillId, false)
  else
    self._mapNode.goPassiveSkill.gameObject:SetActive(false)
  end
  local tbCommonSkillId = self.mapData.tbCommonSkillId
  for i = 1, 2 do
    if tbCommonSkillId[i] then
      self._mapNode.goCommonSkill[i].gameObject:SetActive(true)
      self._mapNode.goCommonSkill[i]:Refresh(tbCommonSkillId[i])
      self._mapNode.goCommonNone[i]:SetActive(false)
    else
      self._mapNode.goCommonSkill[i].gameObject:SetActive(false)
      self._mapNode.goCommonNone[i]:SetActive(true)
    end
  end
end

function MainlineFormationDiscEffect:ShowType(type)
  if self.nId == 0 then
    return
  end
  if type == 1 then
    self._mapNode.goPassiveSkill.gameObject:SetActive(self.mapData.nPassiveSkillId)
    for i = 1, 2 do
      self._mapNode.goCommonSkill[i].gameObject:SetActive(false)
      self._mapNode.goCommonNone[i]:SetActive(false)
    end
  else
    self._mapNode.goPassiveSkill.gameObject:SetActive(false)
    local tbCommonSkillId = self.mapData.tbCommonSkillId
    for i = 1, 2 do
      self._mapNode.goCommonSkill[i].gameObject:SetActive(tbCommonSkillId[i])
      self._mapNode.goCommonNone[i]:SetActive(not tbCommonSkillId[i])
    end
  end
end

return MainlineFormationDiscEffect
