local CharTalentInfoTrialCtrl = class("CharTalentInfoTrialCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
local newDayTime = UTILS.GetDayRefreshTimeOffset()
CharTalentInfoTrialCtrl._mapNodeConfig = {
  sv = {sComponentName = "ScrollRect"},
  txtNodeName = {sComponentName = "TMP_Text"},
  txtTitleDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharTalent_Title_Desc"
  },
  TMP_Link1 = {
    sNodeName = "txtSkillDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  txtSkillDesc = {sComponentName = "TMP_Text"}
}
CharTalentInfoTrialCtrl._mapEventConfig = {}

function CharTalentInfoTrialCtrl:RefreshKey(mapGroup, mapTalent)
  local mapTalentCfg = ConfigTable.GetData("Talent", mapGroup.nKeyTalent)
  local mapGroupCfg = ConfigTable.GetData("TalentGroup", mapGroup.nId)
  if not mapTalentCfg or not mapGroupCfg then
    return
  end
  self.sKeyName = mapTalentCfg.Title
  self.nGroupId = mapGroup.nId
  NovaAPI.SetTMPText(self._mapNode.txtNodeName, mapTalentCfg.Title)
  NovaAPI.SetTMPText(self._mapNode.txtSkillDesc, UTILS.ParseDesc(mapTalentCfg, nil, nil, nil, nil, {
    nCharId = self._panel.nCharId
  }))
  local bActive = mapTalent.tbActiveTalent[mapGroup.nKeyTalent]
  if bActive then
  else
    local nLeft = mapGroupCfg.NodeLimit - mapGroup.nNormalCount
    local mapCharCfg = ConfigTable.GetData_Character(self._panel.nCharId)
    if not mapCharCfg then
      return
    end
    local mapGradeCfg = ConfigTable.GetData("CharGrade", mapCharCfg.Grade)
    if not mapGradeCfg then
      return
    end
  end
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.sv, 1)
end

function CharTalentInfoTrialCtrl:RefreshNormal(nTalentId, mapGroup, mapTalent)
  self.nTalentId = nTalentId
  local mapTalentCfg = ConfigTable.GetData("Talent", nTalentId)
  if not mapTalentCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtNodeName, mapTalentCfg.Title)
  NovaAPI.SetTMPText(self._mapNode.txtSkillDesc, UTILS.ParseParamDesc(mapTalentCfg.Desc, mapTalentCfg, nil, {
    nCharId = self._panel.nCharId
  }))
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.sv, 1)
end

function CharTalentInfoTrialCtrl:ActiveLayer(active)
  local isSelectAgain = false
  
  local function confirmCallback()
    if isSelectAgain then
      local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
      local _fixedTimeStamp = _curTimeStamp + newDayTime * 3600
      local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
      local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
      local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
      local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
      LocalData.SetPlayerLocalData("TalentActiveLayer_Tips_Time", tostring(_nowD))
    end
    active()
  end
  
  local function againCallback(isSelect)
    isSelectAgain = isSelect
  end
  
  if not self.nLayerCost then
    return
  end
  local mapCharCfg = ConfigTable.GetData_Character(self._panel.nCharId)
  if not mapCharCfg then
    return
  end
  local mapGradeCfg = ConfigTable.GetData("CharGrade", mapCharCfg.Grade)
  if not mapGradeCfg then
    return
  end
  local nGeneralCount = PlayerData.Item:GetItemCountByID(mapGradeCfg.GeneralFragmentId)
  local nFragmentCount = PlayerData.Item:GetItemCountByID(mapCharCfg.FragmentsId)
  local sFragment = ConfigTable.GetData_Item(mapCharCfg.FragmentsId).Title
  local sGeneral = ConfigTable.GetData_Item(mapGradeCfg.GeneralFragmentId).Title
  local sChar = mapCharCfg.Name
  if nFragmentCount >= self.nLayerCost then
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = orderedFormat(ConfigTable.GetUIText("CharTalent_ActiveLayerTip_CharFragment"), sFragment, self.nLayerCost, sChar, self.sKeyName),
      callbackConfirm = confirmCallback,
      callbackAgain = againCallback
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  elseif self.nLayerCost <= nFragmentCount + nGeneralCount then
    local sTip = ""
    if nFragmentCount == 0 then
      sTip = orderedFormat(ConfigTable.GetUIText("CharTalent_ActiveLayerTip_GeneralFragment"), sGeneral, self.nLayerCost, sChar, self.sKeyName)
    else
      sTip = orderedFormat(ConfigTable.GetUIText("CharTalent_ActiveLayerTip_BothFragment"), sFragment, nFragmentCount, sGeneral, self.nLayerCost - nFragmentCount, sChar, self.sKeyName)
    end
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = sTip,
      callbackConfirm = confirmCallback,
      callbackAgain = againCallback
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
end

function CharTalentInfoTrialCtrl:Awake()
end

function CharTalentInfoTrialCtrl:OnEnable()
end

function CharTalentInfoTrialCtrl:OnDisable()
end

function CharTalentInfoTrialCtrl:OnDestroy()
end

function CharTalentInfoTrialCtrl:OnBtnClick_Tips(btn, nIndex)
  local mapCharCfg = ConfigTable.GetData_Character(self._panel.nCharId)
  if not mapCharCfg then
    return
  end
  local mapData = {
    nTid = mapCharCfg.FragmentsId,
    bShowDepot = true,
    bShowJumpto = true
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
end

function CharTalentInfoTrialCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId, {
    nCharId = self._panel.nCharId
  })
end

return CharTalentInfoTrialCtrl
