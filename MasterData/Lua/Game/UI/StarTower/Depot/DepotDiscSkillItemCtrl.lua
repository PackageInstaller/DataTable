local DepotDiscSkillItemCtrl = class("DepotDiscSkillItemCtrl", BaseCtrl)
DepotDiscSkillItemCtrl._mapNodeConfig = {
  imgNone = {},
  goInfo = {},
  imgIcon = {sComponentName = "Image"},
  imgIconBg = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  txtLevelMax = {sComponentName = "TMP_Text"},
  txtLevel = {sComponentName = "TMP_Text"},
  goNote = {
    sCtrlName = "Game.UI.TemplateEx.TemplateDiscMultiNoteCtrl"
  },
  imgLock = {},
  imgChoose = {}
}
DepotDiscSkillItemCtrl._mapEventConfig = {}
DepotDiscSkillItemCtrl._mapRedDotConfig = {}

function DepotDiscSkillItemCtrl:SetNone()
  self._mapNode.imgNone:SetActive(true)
  self._mapNode.goInfo:SetActive(false)
end

function DepotDiscSkillItemCtrl:SetSkillInfo(skillCfg)
  NovaAPI.SetTMPText(self._mapNode.txtName, skillCfg.Name)
  self:SetPngSprite(self._mapNode.imgIcon, skillCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
  self:SetPngSprite(self._mapNode.imgIconBg, skillCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Small)
end

function DepotDiscSkillItemCtrl:InitDiscSkill(mapSkill)
  self._mapNode.imgNone:SetActive(false)
  self._mapNode.goInfo:SetActive(true)
  if mapSkill.nType == AllEnum.DiscSkillType.Common then
    self:InitDiscCommonSkill(mapSkill)
  else
    self:InitDiscPassiveSkill(mapSkill)
  end
end

function DepotDiscSkillItemCtrl:InitDiscCommonSkill(mapSkill)
  self._mapNode.imgChoose.gameObject:SetActive(false)
  local skillCfg = ConfigTable.GetData("DiscCommonSkill", mapSkill.nId)
  if skillCfg == nil then
    return
  end
  self:SetSkillInfo(skillCfg)
  local nLevel = mapSkill.nLevel
  local nMaxLevel = mapSkill.nMaxLevel
  local bMaxLv = nMaxLevel == nLevel
  self._mapNode.txtLevelMax.gameObject:SetActive(bMaxLv)
  self._mapNode.txtLevel.gameObject:SetActive(not bMaxLv)
  NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Skill_Lv"), nLevel, nMaxLevel))
  NovaAPI.SetTMPText(self._mapNode.txtLevelMax, orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Skill_MaxLv"), nLevel, nMaxLevel))
  local bUnlock = mapSkill.nLevel > 0
  self._mapNode.imgLock.gameObject:SetActive(not bUnlock)
  local nLayer = nLevel == 0 and 1 or nLevel
  self._mapNode.goNote:SetNoteItem(skillCfg.ActiveNoteType, skillCfg.ActiveNoteNum[nLayer])
end

function DepotDiscSkillItemCtrl:InitDiscPassiveSkill(mapSkill)
  self._mapNode.imgChoose.gameObject:SetActive(false)
  local skillCfg = ConfigTable.GetData("DiscPassiveSkill", mapSkill.nId)
  if skillCfg == nil then
    return
  end
  self:SetSkillInfo(skillCfg)
  local nLevel = mapSkill.nLevel
  local nMaxLevel = mapSkill.nMaxLevel
  NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Skill_Lv"), nLevel, nMaxLevel))
  NovaAPI.SetTMPText(self._mapNode.txtLevelMax, orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Skill_MaxLv"), nLevel, nMaxLevel))
  local bUnlock = 0 < nLevel
  local bMaxLv = nLevel == nMaxLevel
  self._mapNode.imgLock.gameObject:SetActive(not bUnlock)
  self._mapNode.txtLevelMax.gameObject:SetActive(bMaxLv)
  self._mapNode.txtLevel.gameObject:SetActive(not bMaxLv)
  local nLayer = nLevel == 0 and 1 or nLevel
  local tbLayerNote = decodeJson(skillCfg["ActiveParam" .. nLayer])
  local tbNoteId = {}
  local nNoteCount = 0
  for k, v in pairs(tbLayerNote) do
    local nNoteId = tonumber(k)
    local nCount = tonumber(v)
    if nNoteId then
      nNoteCount = nNoteCount + nCount
      table.insert(tbNoteId, nNoteId)
    end
  end
  self._mapNode.goNote:SetNoteItem(tbNoteId, nNoteCount)
end

function DepotDiscSkillItemCtrl:SetSelect(bSelect)
  self._mapNode.imgChoose.gameObject:SetActive(bSelect)
end

function DepotDiscSkillItemCtrl:InitDiscSkillTips(tbSkill)
  if tbSkill.nType == AllEnum.DiscSkillType.Common then
    self:InitDiscCommonSkillTip(tbSkill)
  else
    self:InitDiscPassiveSkillTip(tbSkill)
  end
end

function DepotDiscSkillItemCtrl:InitDiscCommonSkillTip(tbSkill)
  local skillCfg = ConfigTable.GetData("DiscCommonSkill", tbSkill.nId)
  if skillCfg == nil then
    return
  end
  self:SetSkillInfo(skillCfg)
  local nLevel = tbSkill.nLevel
  local bMaxLv = tbSkill.nMaxLevel == nLevel
  self._mapNode.txtLevelMax.gameObject:SetActive(bMaxLv)
  self._mapNode.txtLevel.gameObject:SetActive(not bMaxLv)
  NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Skill_Lv"), nLevel, tbSkill.nMaxLevel))
  NovaAPI.SetTMPText(self._mapNode.txtLevelMax, orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Skill_MaxLv"), nLevel, tbSkill.nMaxLevel))
  local nLayer = nLevel == 0 and 1 or nLevel
  self._mapNode.goNote:SetNoteItem(skillCfg.ActiveNoteType, skillCfg.ActiveNoteNum[nLayer])
end

function DepotDiscSkillItemCtrl:InitDiscPassiveSkillTip(mapSkill)
  local skillCfg = ConfigTable.GetData("DiscPassiveSkill", mapSkill.nId)
  if skillCfg == nil then
    return
  end
  self:SetSkillInfo(skillCfg)
  local nLevel = mapSkill.nLevel
  local nMaxLevel = mapSkill.nMaxLevel
  NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Skill_Lv"), nLevel, nMaxLevel))
  NovaAPI.SetTMPText(self._mapNode.txtLevelMax, orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Skill_MaxLv"), nLevel, nMaxLevel))
  local bMaxLv = nLevel == nMaxLevel
  self._mapNode.txtLevelMax.gameObject:SetActive(bMaxLv)
  self._mapNode.txtLevel.gameObject:SetActive(not bMaxLv)
  local nLayer = nLevel == 0 and 1 or nLevel
  local tbLayerNote = decodeJson(skillCfg["ActiveParam" .. nLayer])
  local tbNoteId = {}
  local nNoteCount = 0
  for k, v in pairs(tbLayerNote) do
    local nNoteId = tonumber(k)
    local nCount = tonumber(v)
    if nNoteId then
      nNoteCount = nNoteCount + nCount
      table.insert(tbNoteId, nNoteId)
    end
  end
  self._mapNode.goNote:SetNoteItem(tbNoteId, nNoteCount)
end

return DepotDiscSkillItemCtrl
