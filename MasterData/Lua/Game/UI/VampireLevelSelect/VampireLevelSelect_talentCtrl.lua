local VampireLevelSelect_talentCtrl = class("VampireLevelSelect_talentCtrl", BaseCtrl)
VampireLevelSelect_talentCtrl._mapNodeConfig = {
  TMPTalentTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_Talent_Point"
  },
  TMPEmptyTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireTalent_EmptyAttr"
  },
  TMPTalentPointHint = {sComponentName = "TMP_Text"},
  imgTitleTalentBg = {},
  TMPAttrTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_Talent_Attr"
  },
  txtBtnResetTalent = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_Talent_Reset"
  },
  rtTalentIcon = {
    sCtrlName = "Game.UI.VampireLevelSelect.VampireLevelSelect_talent_iconGridCtrl"
  },
  lsvTalentNodes = {
    sCtrlName = "Game.UI.VampireLevelSelect.VampireLevelSelect_talentListCtrl"
  },
  svAttrList = {sComponentName = "ScrollRect"},
  TMPTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireTalent_State1"
  },
  TMPTitle2 = {sComponentName = "TMP_Text"},
  TMPTitle3 = {sComponentName = "TMP_Text"},
  TMPTitle4 = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireTalent_State4"
  },
  TMPTitle5 = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireTalent_State5"
  },
  rtLock = {},
  rtActive = {},
  rtActived = {},
  TMPTalentName = {sComponentName = "TMP_Text"},
  TMPFateCardInfo = {sComponentName = "TMP_Text"},
  TMPTalentPoint = {sComponentName = "TMP_Text"},
  btnActiveTalent = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ActiveTalent"
  },
  btnResetTalent = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ResetTalent"
  },
  gridText = {},
  ContentAttr = {sComponentName = "Transform"},
  btnTalentTips = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TalentTips"
  },
  rtTalentPointHint = {
    sCtrlName = "Game.UI.VampireLevelSelect.VampireLevelSelect_TalentPointHintCtrl"
  }
}
VampireLevelSelect_talentCtrl._mapEventConfig = {
  VampireTalent_ClickNode = "OnEvent_ClickNode"
}
VampireLevelSelect_talentCtrl._mapRedDotConfig = {}

function VampireLevelSelect_talentCtrl:Awake()
end

function VampireLevelSelect_talentCtrl:FadeIn()
end

function VampireLevelSelect_talentCtrl:FadeOut()
end

function VampireLevelSelect_talentCtrl:OnEnable()
  self._mapNode.rtTalentPointHint.gameObject:SetActive(false)
  self._mapNode.lsvTalentNodes:InitList()
  local nFateCardPoint = ConfigTable.GetConfigNumber("FateCardBookToVampireTalentPoint")
  if nFateCardPoint == nil then
    nFateCardPoint = 1
  end
  if PlayerData.VampireSurvivor:GetIsTalentPointMax() then
    NovaAPI.SetTMPText(self._mapNode.TMPTalentPointHint, ConfigTable.GetUIText("VampireTalent_FateCardTrans_TalentPointMaxCount"))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPTalentPointHint, orderedFormat(ConfigTable.GetUIText("VampireTalent_FateCardHint") or "", nFateCardPoint))
  end
end

function VampireLevelSelect_talentCtrl:OnDisable()
end

function VampireLevelSelect_talentCtrl:OnDestroy()
end

function VampireLevelSelect_talentCtrl:OnRelease()
end

function VampireLevelSelect_talentCtrl:Refresh(nTalentId)
  local nCur = PlayerData.VampireSurvivor:GetCurTalentPoint()
  NovaAPI.SetTMPText(self._mapNode.TMPTalentPoint, tostring(nCur))
  local tbActivedTalent = PlayerData.VampireSurvivor:GetActivedTalent()
  local tbAttr, nAnimIdx = self:SubTalentDesc(tbActivedTalent, nTalentId)
  delChildren(self._mapNode.ContentAttr)
  self._mapNode.TMPEmptyTitle.gameObject:SetActive(#tbAttr == 0)
  self._mapNode.btnResetTalent.gameObject:SetActive(0 < #tbAttr)
  self._mapNode.imgTitleTalentBg:SetActive(0 < #tbAttr)
  for nIdx, tbString in ipairs(tbAttr) do
    local go = instantiate(self._mapNode.gridText, self._mapNode.ContentAttr)
    go:SetActive(true)
    local goTMP = go.transform:Find("TMPText"):GetComponent("TMP_Text")
    if nIdx == nAnimIdx then
      local fx = go.transform:Find("FX")
      fx.gameObject:SetActive(true)
    end
    NovaAPI.SetTMPText(goTMP, tbString[2])
  end
  if nAnimIdx ~= nil then
    if nAnimIdx > #tbAttr * 0.5 then
      NovaAPI.SetVerticalNormalizedPosition(self._mapNode.svAttrList, 0)
    else
      NovaAPI.SetVerticalNormalizedPosition(self._mapNode.svAttrList, 1)
    end
  end
end

function VampireLevelSelect_talentCtrl:SubTalentDesc(tbAllActivedTalent, nAnimTalentId)
  local ret = {}
  local mapDic = {}
  local nAnimTag = 0
  for _, nTalentId in ipairs(tbAllActivedTalent) do
    local mapData = ConfigTable.GetData("VampireTalent", nTalentId)
    if mapData ~= nil then
      local nTagId = mapData.DescTag
      if nTalentId == nAnimTalentId then
        nAnimTag = nTagId
      end
      if mapDic[nTagId] == nil then
        mapDic[nTagId] = 0
      end
      if 0 <= mapData.Param then
        mapDic[nTagId] = mapDic[nTagId] + mapData.Param
      elseif mapDic[nTagId] > mapData.Param then
        mapDic[nTagId] = mapData.Param
      end
    end
  end
  local retIdx = 0
  for nTagId, nParam in pairs(mapDic) do
    if 0 <= nParam then
      local mapDesc = ConfigTable.GetData("VampireTalentDesc", nTagId)
      local nStr = string.format(mapDesc.Num, nParam)
      table.insert(ret, {nTagId, nStr})
    else
      local mapDesc = ConfigTable.GetData("VampireTalentDesc", nTagId * 100 - nParam)
      table.insert(ret, {
        nTagId,
        mapDesc.Num
      })
    end
  end
  
  local function srot(tbDataA, tbDataB)
    return tbDataA[1] < tbDataB[1]
  end
  
  table.sort(ret, srot)
  for idx, tbData in ipairs(ret) do
    if nAnimTag == tbData[1] then
      retIdx = idx
    end
  end
  return ret, retIdx
end

function VampireLevelSelect_talentCtrl:SubSingleDesc(nTalentId)
  local mapData = ConfigTable.GetData("VampireTalent", nTalentId)
  if mapData ~= nil then
    if mapData.Param >= 0 then
      local nTagId = mapData.DescTag
      local mapDesc = ConfigTable.GetData("VampireTalentDesc", nTagId)
      if mapDesc ~= nil then
        local Str = string.format(mapDesc.Num, mapData.Param)
        return Str
      end
    else
      local nTagId = mapData.DescTag
      local mapDesc = ConfigTable.GetData("VampireTalentDesc", nTagId * 100 - mapData.Param)
      if mapDesc ~= nil then
        local Str = mapDesc.Num
        return Str
      end
    end
  end
  return ""
end

function VampireLevelSelect_talentCtrl:OpenHint(nCard, nExp)
  self._mapNode.rtTalentPointHint:OpenHint(nCard, nExp)
end

function VampireLevelSelect_talentCtrl:OnEvent_ClickNode(nTalentId)
  self.nCurTalent = nTalentId
  local mapTalentData = ConfigTable.GetData("VampireTalent", nTalentId)
  local nState = PlayerData.VampireSurvivor:IsActiveTalent(nTalentId)
  self._mapNode.rtTalentIcon:SetTalent(nTalentId)
  self._mapNode.rtTalentIcon:SetState(nState)
  NovaAPI.SetTMPText(self._mapNode.TMPTalentName, mapTalentData.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPFateCardInfo, self:SubSingleDesc(nTalentId))
  if nState == 3 then
    NovaAPI.SetTMPText(self._mapNode.TMPTitle2, ConfigTable.GetUIText("VampireTalent_State6"))
    self._mapNode.rtLock:SetActive(true)
    self._mapNode.rtActive:SetActive(false)
    self._mapNode.rtActived:SetActive(false)
  elseif nState == 2 then
    local nCost = mapTalentData.Point
    local nCur = PlayerData.VampireSurvivor:GetCurTalentPoint()
    if nCost <= nCur then
      self._mapNode.rtLock:SetActive(false)
      self._mapNode.rtActive:SetActive(true)
      self._mapNode.rtActived:SetActive(false)
      local str = orderedFormat(ConfigTable.GetUIText("VampireTalent_State3"), nCost)
      NovaAPI.SetTMPText(self._mapNode.TMPTitle3, str)
    else
      self._mapNode.rtLock:SetActive(true)
      self._mapNode.rtActive:SetActive(false)
      self._mapNode.rtActived:SetActive(false)
      local str = orderedFormat(ConfigTable.GetUIText("VampireTalent_State2"), nCur, nCost)
      NovaAPI.SetTMPText(self._mapNode.TMPTitle2, str)
    end
  else
    self._mapNode.rtLock:SetActive(false)
    self._mapNode.rtActive:SetActive(false)
    self._mapNode.rtActived:SetActive(true)
  end
end

function VampireLevelSelect_talentCtrl:OnBtnClick_ActiveTalent()
  if self.nCurTalent ~= nil then
    local function callback(nTalentId)
      self:Refresh(nTalentId)
      
      self._mapNode.lsvTalentNodes:RefreshList(nTalentId)
      self:OnEvent_ClickNode(self.nCurTalent)
      local WwiseManger = CS.WwiseAudioManager.Instance
      WwiseManger:PostEvent("ui_vampire_talent_refresh")
      PlayerData.Voice:PlayCharVoice("thankLvup", 9102, nil, true)
    end
    
    PlayerData.VampireSurvivor:ActiveTalent(self.nCurTalent, callback)
  end
end

function VampireLevelSelect_talentCtrl:OnBtnClick_ResetTalent()
  local function callback()
    self:Refresh()
    
    self._mapNode.lsvTalentNodes:RefreshList(0)
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Vampire_Talent_Reset_Tips"))
    self:OnEvent_ClickNode(1)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("VampireTalent_ResetConfirm"),
    callbackConfirm = function()
      PlayerData.VampireSurvivor:ResetTalent(callback)
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function VampireLevelSelect_talentCtrl:OnBtnClick_TalentTips()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Vampire_Talent_Tips"))
end

return VampireLevelSelect_talentCtrl
