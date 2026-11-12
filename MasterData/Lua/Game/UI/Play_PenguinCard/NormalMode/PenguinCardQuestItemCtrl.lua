local PenguinCardQuestItemCtrl = class("PenguinCardQuestItemCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")
local _, NotMaxLevel = ColorUtility.TryParseHtmlString("#FFF7EA")
local _, MaxLevel = ColorUtility.TryParseHtmlString("#ffe075")
PenguinCardQuestItemCtrl._mapNodeConfig = {
  AnimRoot = {sComponentName = "Animator"},
  MoveRoot = {sComponentName = "Animator"},
  imgSelect = {},
  imgIcon = {sComponentName = "Image"},
  goProgress = {},
  txtName = {nCount = 2, sComponentName = "TMP_Text"},
  txtProgress = {nCount = 2, sComponentName = "TMP_Text"},
  txtTurn = {sComponentName = "TMP_Text"},
  goSuc = {},
  txtSuc = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Quest_Success"
  },
  goBuff = {},
  txtBuffTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Quest_BuffTitle"
  },
  imgBuff = {sComponentName = "Image"},
  txtBuffDesc = {sComponentName = "TMP_Text"},
  goFail = {},
  txtFail = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Quest_Fail"
  },
  txtProgressFail = {nCount = 2, sComponentName = "TMP_Text"},
  txtHp = {sComponentName = "TMP_Text"}
}
PenguinCardQuestItemCtrl._mapEventConfig = {}

function PenguinCardQuestItemCtrl:Refresh(mapQuest)
  self.mapQuest = mapQuest
  self:RefreshCommon()
  self._mapNode.goProgress:SetActive(true)
  self._mapNode.goSuc:SetActive(false)
  self._mapNode.goBuff:SetActive(true)
  self._mapNode.goFail:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtName[1], mapQuest.sDesc)
  if mapQuest.nType == GameEnum.PenguinCardQuestType.Score then
    self._mapNode.txtProgress[1].gameObject:SetActive(true)
    self._mapNode.txtProgress[2].gameObject:SetActive(false)
    local nAimCount = math.floor(mapQuest.nAimCount)
    local sAim = "<color=#b7d65d>" .. self:ThousandsNumber(nAimCount) .. "</color>"
    NovaAPI.SetTMPText(self._mapNode.txtProgress[1], sAim .. "/" .. self:ThousandsNumber(math.floor(mapQuest.nMaxAim)))
  else
    self._mapNode.txtProgress[1].gameObject:SetActive(false)
    self._mapNode.txtProgress[2].gameObject:SetActive(true)
    local nAimCount = math.floor(mapQuest.nAimCount)
    local sAim = "<color=#b7d65d>" .. self:ThousandsNumber(nAimCount) .. "</color>"
    NovaAPI.SetTMPText(self._mapNode.txtProgress[2], sAim .. "/" .. self:ThousandsNumber(math.floor(mapQuest.nMaxAim)))
  end
  local nLeftTurn = mapQuest.nTurnLimit - mapQuest.nTurnCount
  NovaAPI.SetTMPText(self._mapNode.txtTurn, orderedFormat(ConfigTable.GetUIText("PenguinCard_Quest_LeftTurn"), nLeftTurn))
  local mapCfg = ConfigTable.GetData("PenguinCardBuff", mapQuest.nBuffId)
  if mapCfg then
    self:SetSprite(self._mapNode.imgBuff, "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. mapCfg.Icon)
    NovaAPI.SetTMPText(self._mapNode.txtBuffDesc, PenguinCardUtils.SetEffectDesc(mapCfg))
  end
end

function PenguinCardQuestItemCtrl:SetSelect(bSelect)
  self._mapNode.imgSelect:SetActive(bSelect)
end

function PenguinCardQuestItemCtrl:RefreshCommon()
  self._mapNode.imgSelect:SetActive(false)
end

function PenguinCardQuestItemCtrl:RefreshSuc(mapQuest)
  self.mapQuest = mapQuest
  self:RefreshCommon()
  self._mapNode.goProgress:SetActive(false)
  self._mapNode.goSuc:SetActive(true)
  self._mapNode.goBuff:SetActive(true)
  self._mapNode.goFail:SetActive(false)
  local mapCfg = ConfigTable.GetData("PenguinCardBuff", mapQuest.nBuffId)
  if mapCfg then
    self:SetSprite(self._mapNode.imgBuff, "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. mapCfg.Icon)
    NovaAPI.SetTMPText(self._mapNode.txtBuffDesc, PenguinCardUtils.SetEffectDesc(mapCfg))
  end
end

function PenguinCardQuestItemCtrl:RefreshFail(mapQuest)
  self.mapQuest = mapQuest
  self:RefreshCommon()
  self._mapNode.goProgress:SetActive(false)
  self._mapNode.goSuc:SetActive(false)
  self._mapNode.goBuff:SetActive(false)
  self._mapNode.goFail:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtName[2], mapQuest.sDesc)
  if mapQuest.nType == GameEnum.PenguinCardQuestType.Score then
    self._mapNode.txtProgressFail[1].gameObject:SetActive(true)
    self._mapNode.txtProgressFail[2].gameObject:SetActive(false)
    local nAimCount = math.floor(mapQuest.nAimCount)
    local sAim = "<color=#b7d65d>" .. self:ThousandsNumber(nAimCount) .. "</color>"
    NovaAPI.SetTMPText(self._mapNode.txtProgressFail[1], sAim .. "/" .. self:ThousandsNumber(math.floor(mapQuest.nMaxAim)))
  else
    self._mapNode.txtProgressFail[1].gameObject:SetActive(false)
    self._mapNode.txtProgressFail[2].gameObject:SetActive(true)
    local nAimCount = math.floor(mapQuest.nAimCount)
    local sAim = "<color=#b7d65d>" .. self:ThousandsNumber(nAimCount) .. "</color>"
    NovaAPI.SetTMPText(self._mapNode.txtProgressFail[2], sAim .. "/" .. self:ThousandsNumber(math.floor(mapQuest.nMaxAim)))
  end
end

function PenguinCardQuestItemCtrl:PlaySelectAni(bSelect)
  if bSelect then
    self._mapNode.MoveRoot:Play("tc_newperk_card_switch_up", 0, 0)
  else
    self._mapNode.MoveRoot:Play("tc_newperk_card_switch_down", 0, 0)
  end
end

function PenguinCardQuestItemCtrl:PlayInAni()
  if self.mapQuest.nLevel == 1 then
    self._mapNode.AnimRoot:Play("PenguinCardQuest_Blue_in", 0, 0)
  elseif self.mapQuest.nLevel == 2 then
    self._mapNode.AnimRoot:Play("PenguinCardQuest_Red_in", 0, 0)
  end
end

function PenguinCardQuestItemCtrl:PlayOutAni()
  if self.mapQuest.nLevel == 1 then
    self._mapNode.AnimRoot:Play("PenguinCardQuest_Blue_Out", 0, 0)
  elseif self.mapQuest.nLevel == 2 then
    self._mapNode.AnimRoot:Play("PenguinCardQuest_Red_Out", 0, 0)
  end
end

function PenguinCardQuestItemCtrl:PlaySelectOutAni()
  if self.mapQuest.nLevel == 1 then
    self._mapNode.AnimRoot:Play("PenguinCardQuest_Blue_Select", 0, 0)
  elseif self.mapQuest.nLevel == 2 then
    self._mapNode.AnimRoot:Play("PenguinCardQuest_Red_Select", 0, 0)
  end
end

function PenguinCardQuestItemCtrl:Awake()
end

function PenguinCardQuestItemCtrl:OnEnable()
end

function PenguinCardQuestItemCtrl:OnDisable()
end

return PenguinCardQuestItemCtrl
