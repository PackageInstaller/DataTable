local LevelMenuResourceCtrl = class("LevelMenuResourceCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
LevelMenuResourceCtrl._mapNodeConfig = {
  btnEquipment = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Equipment"
  },
  TMPEquipTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_Equipment"
  },
  TMPEquipTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_SEquipment"
  },
  LockEquipment = {},
  TMPCondEquipment = {sComponentName = "TMP_Text"},
  imgEquipmentDoubleDrop = {},
  btnSkill = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skill"
  },
  TMPSkillTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_Skill"
  },
  TMPSkillTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_SSkill"
  },
  LockSkill = {},
  TMPCondSkill = {sComponentName = "TMP_Text"},
  imgSkillDoubleDrop = {},
  btnRegion = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RogueBoss"
  },
  TMPChallengeTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_Region"
  },
  TMPChallengeTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_SRegion"
  },
  LockRegion = {},
  TMPCondRegion = {sComponentName = "TMP_Text"},
  redDotRegion = {},
  imgRegionDoubleDrop = {},
  btnTimes = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DailyInstance"
  },
  TMPTimesTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_Time"
  },
  TMPTimesTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_STime"
  },
  LockTimes = {},
  TMPCondTimes = {sComponentName = "TMP_Text"},
  imgTimesDoubleDrop = {},
  rtEnergyBarFill = {
    sComponentName = "RectTransform"
  },
  btnAddEnergy = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AddEnergy"
  },
  TMPDailyInstanceEnergy = {sComponentName = "TMP_Text"},
  imgChooseTimes = {},
  imgChooseSkill = {},
  imgChooseRegion = {},
  imgChooseEquipment = {},
  imgReengagementTips = {},
  txtReengagementTips = {sComponentName = "TMP_Text"}
}
LevelMenuResourceCtrl._mapEventConfig = {}
LevelMenuResourceCtrl._mapRedDotConfig = {
  [RedDotDefine.Map_RogueBoss] = {
    sNodeName = "redDotRegion"
  }
}
local totalEnergyBarLength = 390
local totalEnergyBarHeight = 22

function LevelMenuResourceCtrl:RefreshChooseImg(nType)
  self._mapNode.imgChooseTimes.gameObject:SetActive(nType == GameEnum.OpenFuncType.DailyInstance)
  self._mapNode.imgChooseSkill.gameObject:SetActive(nType == GameEnum.OpenFuncType.SkillInstance)
  self._mapNode.imgChooseRegion.gameObject:SetActive(nType == GameEnum.OpenFuncType.RegionBoss)
  self._mapNode.imgChooseEquipment.gameObject:SetActive(nType == GameEnum.OpenFuncType.CharGemInstance)
end

function LevelMenuResourceCtrl:InitResource(nType)
  self:RefreshChooseImg(nType)
  self:RefreshEnergy()
end

function LevelMenuResourceCtrl:RefreshEnergy()
  local nMaxEnergy = ConfigTable.GetConfigNumber("EnergyMaxLimit")
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  NovaAPI.SetTMPText(self._mapNode.TMPDailyInstanceEnergy, nCurEnergy .. "/" .. nMaxEnergy)
  local nPercent = nCurEnergy / nMaxEnergy
  if 1 < nPercent then
    nPercent = 1
  end
  self._mapNode.rtEnergyBarFill.sizeDelta = Vector2(nPercent * totalEnergyBarLength, totalEnergyBarHeight)
end

function LevelMenuResourceCtrl:RefreshFuncOpen()
  if not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.DailyInstance) then
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.DailyInstance)
    self._mapNode.LockTimes:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.TMPCondTimes, UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData))
  else
    self._mapNode.LockTimes:SetActive(false)
  end
  if not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.RegionBoss) then
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.RegionBoss)
    self._mapNode.LockRegion:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.TMPCondRegion, UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData))
  else
    self._mapNode.LockRegion:SetActive(false)
  end
  if not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.SkillInstance) then
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.SkillInstance)
    self._mapNode.LockSkill:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.TMPCondSkill, UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData))
  else
    self._mapNode.LockSkill:SetActive(false)
  end
  if not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.CharGemInstance) then
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.CharGemInstance)
    self._mapNode.LockEquipment:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.TMPCondEquipment, UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData))
  else
    self._mapNode.LockEquipment:SetActive(false)
  end
end

function LevelMenuResourceCtrl:RefreshDropUp(actData)
  self._mapNode.imgTimesDoubleDrop.gameObject:SetActive(false)
  self._mapNode.imgRegionDoubleDrop.gameObject:SetActive(false)
  self._mapNode.imgSkillDoubleDrop.gameObject:SetActive(false)
  self._mapNode.imgEquipmentDoubleDrop.gameObject:SetActive(false)
  self._mapNode.imgReengagementTips:SetActive(false)
  local nReengagementCount = PlayerData.Reengagement:GetDoubleDropCount()
  if actData ~= nil then
    local tbDoubleType = {}
    tbDoubleType = actData:GetDoubleFuncType()
    self._mapNode.imgTimesDoubleDrop.gameObject:SetActive(table.indexof(tbDoubleType, GameEnum.OpenFuncType.DailyInstance) > 0)
    self._mapNode.imgRegionDoubleDrop.gameObject:SetActive(0 < table.indexof(tbDoubleType, GameEnum.OpenFuncType.RegionBoss))
    self._mapNode.imgSkillDoubleDrop.gameObject:SetActive(0 < table.indexof(tbDoubleType, GameEnum.OpenFuncType.SkillInstance))
    self._mapNode.imgEquipmentDoubleDrop.gameObject:SetActive(0 < table.indexof(tbDoubleType, GameEnum.OpenFuncType.CharGemInstance))
  end
  if 0 < nReengagementCount then
    self._mapNode.imgReengagementTips:SetActive(true)
    self._mapNode.imgTimesDoubleDrop.gameObject:SetActive(true)
    self._mapNode.imgRegionDoubleDrop.gameObject:SetActive(true)
    self._mapNode.imgSkillDoubleDrop.gameObject:SetActive(true)
    self._mapNode.imgEquipmentDoubleDrop.gameObject:SetActive(true)
    self:RefreshReengagementCount()
  end
end

function LevelMenuResourceCtrl:RefreshReengagementCount()
  local nReengagementCount = PlayerData.Reengagement:GetDoubleDropCount()
  local nMaxCount = PlayerData.Reengagement:GetMaxDoubleDropCount()
  local str = ConfigTable.GetUIText("Reengagement_DoubleDrop_LevelTip")
  str = str .. ":" .. nReengagementCount .. "/" .. nMaxCount
  NovaAPI.SetTMPText(self._mapNode.txtReengagementTips, str)
end

function LevelMenuResourceCtrl:Awake()
  self:RefreshChooseImg(0)
end

function LevelMenuResourceCtrl:OnEnable()
end

function LevelMenuResourceCtrl:OnDisable()
end

function LevelMenuResourceCtrl:OnDestroy()
end

function LevelMenuResourceCtrl:OnBtnClick_RogueBoss()
  local function callback()
    self:RefreshChooseImg(GameEnum.OpenFuncType.RegionBoss)
    
    EventManager.Hit("SelectResourceInstance", GameEnum.OpenFuncType.RegionBoss)
    WwiseAudioMgr:PlaySound("ui_level_daily_tog")
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.RegionBoss, callback, "ui_systerm_locked")
end

function LevelMenuResourceCtrl:OnBtnClick_DailyInstance(btn)
  local function callback()
    self:RefreshChooseImg(GameEnum.OpenFuncType.DailyInstance)
    
    EventManager.Hit("SelectResourceInstance", GameEnum.OpenFuncType.DailyInstance)
    WwiseAudioMgr:PlaySound("ui_level_daily_tog")
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.DailyInstance, callback, "ui_systerm_locked")
end

function LevelMenuResourceCtrl:OnBtnClick_Equipment(btn)
  local function callbackCheck()
    self:RefreshChooseImg(GameEnum.OpenFuncType.CharGemInstance)
    
    WwiseAudioMgr:PlaySound("ui_level_daily_tog")
    EventManager.Hit("SelectResourceInstance", GameEnum.OpenFuncType.CharGemInstance)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.CharGemInstance, callbackCheck, "ui_systerm_locked")
end

function LevelMenuResourceCtrl:OnBtnClick_Skill(btn)
  local function callbackCheck()
    self:RefreshChooseImg(GameEnum.OpenFuncType.SkillInstance)
    
    WwiseAudioMgr:PlaySound("ui_level_daily_tog")
    EventManager.Hit("SelectResourceInstance", GameEnum.OpenFuncType.SkillInstance)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.SkillInstance, callbackCheck, "ui_systerm_locked")
end

function LevelMenuResourceCtrl:OnBtnClick_AddEnergy(btn)
  self._panel._nFadeInType = 2
  
  local function callback()
    EventManager.Hit(EventId.ClosePanel, PanelId.EnergyBuy)
  end
  
  EventManager.Hit(EventId.OpenPanel, PanelId.EnergyBuy, AllEnum.EnergyPanelType.Main, {}, true, callback)
end

return LevelMenuResourceCtrl
