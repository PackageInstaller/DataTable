local SoldierHandbookSelectCtrl = class("SoldierHandbookSelectCtrl", BaseCtrl)
SoldierHandbookSelectCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  btn_Boss = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Boss"
  },
  txt_Boss = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_Boss"
  },
  txt_BossCount = {sComponentName = "TMP_Text"},
  btn_Char = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Character"
  },
  txt_Char = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_Character"
  },
  txt_CharCount = {sComponentName = "TMP_Text"},
  btn_Partner = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Partner"
  },
  txt_Partner = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_Partner"
  },
  txt_PartnerCount = {sComponentName = "TMP_Text"},
  btn_StrategyCard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_StrategyCard"
  },
  txt_StrategyCard = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_StrategyCard"
  },
  txt_StrategyCardCount = {sComponentName = "TMP_Text"}
}
SoldierHandbookSelectCtrl._mapEventConfig = {}
SoldierHandbookSelectCtrl._mapRedDotConfig = {}

function SoldierHandbookSelectCtrl:Awake()
end

function SoldierHandbookSelectCtrl:OnEnable()
  self:RefreshBossCount()
  self:RefreshCharCount()
  self:RefreshPartnerCount()
  self:RefreshStrategyCardCount()
end

function SoldierHandbookSelectCtrl:RefreshEndCount()
  local nCount = 0
  
  local function func_ForEach_End(mapEndData)
    nCount = nCount + 1
  end
  
  ForEachTableLine(DataTable.SoldierEndingPlan, func_ForEach_End)
  NovaAPI.SetTMPText(self._mapNode.txt_EndCount, nCount)
end

function SoldierHandbookSelectCtrl:RefreshBossCount()
  local nCount = 0
  
  local function func_ForEach_Boss(mapBossData)
    nCount = nCount + 1
  end
  
  ForEachTableLine(DataTable.SoldierBossTemplate, func_ForEach_Boss)
  NovaAPI.SetTMPText(self._mapNode.txt_BossCount, nCount)
end

function SoldierHandbookSelectCtrl:RefreshCharCount()
  local nCount = 0
  local nSeasonId = PlayerData.SoldierData:GetCurSelectSeasonId()
  local seasonConfig = ConfigTable.GetData("SoldierSeason", nSeasonId)
  if seasonConfig == nil then
    return
  end
  
  local function func_ForEach_Char(mapCharData)
    if mapCharData.BoardChess and seasonConfig.ChessGroupId == mapCharData.GroupId then
      nCount = nCount + 1
    end
  end
  
  ForEachTableLine(DataTable.SoldierCharacter, func_ForEach_Char)
  NovaAPI.SetTMPText(self._mapNode.txt_CharCount, nCount)
end

function SoldierHandbookSelectCtrl:RefreshPartnerCount()
  local nCount = 0
  
  local function func_ForEach_Partner(mapPartnerData)
    nCount = nCount + 1
  end
  
  ForEachTableLine(DataTable.SoldierPartnerGroup, func_ForEach_Partner)
  NovaAPI.SetTMPText(self._mapNode.txt_PartnerCount, nCount)
end

function SoldierHandbookSelectCtrl:RefreshStrategyCardCount()
  local nCount = 0
  
  local function func_ForEach_StrategyCard(mapStrategyCardData)
    nCount = nCount + 1
  end
  
  ForEachTableLine(DataTable.SoldierStrategyCard, func_ForEach_StrategyCard)
  NovaAPI.SetTMPText(self._mapNode.txt_StrategyCardCount, nCount)
end

function SoldierHandbookSelectCtrl:OnBtnClick_Boss()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierHandbookPanel, AllEnum.SoldierHandbookType.Boss)
end

function SoldierHandbookSelectCtrl:OnBtnClick_Character()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierHandbookPanel, AllEnum.SoldierHandbookType.Character)
end

function SoldierHandbookSelectCtrl:OnBtnClick_Partner()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierHandbookPanel, AllEnum.SoldierHandbookType.Partner)
end

function SoldierHandbookSelectCtrl:OnBtnClick_StrategyCard()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierHandbookPanel, AllEnum.SoldierHandbookType.StrategyCard)
end

return SoldierHandbookSelectCtrl
