local DiscCommonSkillCtrl = class("DiscCommonSkillCtrl", BaseCtrl)
DiscCommonSkillCtrl._mapNodeConfig = {
  txtSkillName = {sComponentName = "TMP_Text"},
  imgSkillIcon = {sComponentName = "Image"},
  imgSkillIconBg = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  btnPrevLevel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Prev"
  },
  btnNextLevel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Next"
  },
  imgPrevOn = {},
  imgPrevOff = {},
  imgNextOn = {},
  imgNextOff = {},
  goNote = {
    sCtrlName = "Game.UI.TemplateEx.TemplateDiscMultiNoteCtrl"
  },
  txtSkillDesc = {sComponentName = "TMP_Text"},
  txtNoteTip = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "txtSkillDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  }
}
DiscCommonSkillCtrl._mapEventConfig = {}

function DiscCommonSkillCtrl:Refresh(nId, nLayer)
  self.mapCfg = ConfigTable.GetData("DiscCommonSkill", nId)
  if not self.mapCfg then
    return
  end
  self.nLayer = 1
  if nLayer then
    self.nLayer = nLayer
  end
  self:SetPngSprite(self._mapNode.imgSkillIcon, self.mapCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
  self:SetPngSprite(self._mapNode.imgSkillIconBg, self.mapCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Small)
  NovaAPI.SetTMPText(self._mapNode.txtSkillName, self.mapCfg.Name)
  self.nMaxLayer = #self.mapCfg.ActiveNoteNum
  self:RefreshSkill()
end

function DiscCommonSkillCtrl:RefreshSkill()
  local sDesc = UTILS.ParseDiscDesc(self.mapCfg.Desc, self.mapCfg, nil, self.nLayer)
  NovaAPI.SetTMPText(self._mapNode.txtSkillDesc, sDesc)
  self._mapNode.goNote:SetNoteItem(self.mapCfg.ActiveNoteType, self.mapCfg.ActiveNoteNum[self.nLayer])
  local bMulti = #self.mapCfg.ActiveNoteType > 1
  if bMulti then
    local mapNote1 = ConfigTable.GetData("Note", self.mapCfg.ActiveNoteType[1])
    local mapNote2 = ConfigTable.GetData("Note", self.mapCfg.ActiveNoteType[2])
    if not mapNote1 or not mapNote2 then
      return
    end
    NovaAPI.SetTMPText(self._mapNode.txtNoteTip, orderedFormat(ConfigTable.GetUIText("Disc_CommonSkill_MultiNoteTip"), mapNote1.Name1, mapNote2.Name1))
  else
    local mapNote1 = ConfigTable.GetData("Note", self.mapCfg.ActiveNoteType[1])
    if not mapNote1 then
      return
    end
    NovaAPI.SetTMPText(self._mapNode.txtNoteTip, orderedFormat(ConfigTable.GetUIText("Disc_CommonSkill_NoteTip"), mapNote1.Name1))
  end
  NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("Disc_CommonSkill_Level"), self.nLayer))
  self._mapNode.imgPrevOn:SetActive(self.nLayer > 1)
  self._mapNode.imgPrevOff:SetActive(self.nLayer == 1)
  self._mapNode.imgNextOn:SetActive(self.nLayer < self.nMaxLayer)
  self._mapNode.imgNextOff:SetActive(self.nLayer == self.nMaxLayer)
end

function DiscCommonSkillCtrl:OnBtnClick_Prev()
  if self.nLayer == 1 then
    return
  end
  self.nLayer = self.nLayer - 1
  self:RefreshSkill()
end

function DiscCommonSkillCtrl:OnBtnClick_Next()
  if self.nLayer == self.nMaxLayer then
    return
  end
  self.nLayer = self.nLayer + 1
  self:RefreshSkill()
end

function DiscCommonSkillCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return DiscCommonSkillCtrl
