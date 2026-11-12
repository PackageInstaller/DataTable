local SoldierHandbookCtrl = class("SoldierHandbookCtrl", BaseCtrl)
SoldierHandbookCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  btn_char = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Char"
  },
  go_char_in = {},
  go_char_off = {},
  btn_partner = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Partner"
  },
  go_partner_in = {},
  go_partner_off = {},
  btn_strategyCard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_StrategyCard"
  },
  go_strategyCard_in = {},
  go_strategyCard_off = {},
  btn_boss = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Boss"
  },
  go_boss_in = {},
  go_boss_off = {},
  txt_char = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_Character"
  },
  txt_partner = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_Partner"
  },
  txt_boss = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_Boss"
  },
  txt_strategyCard = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_StrategyCard"
  },
  CharCtrl = {
    sNodeName = "CharRoot",
    sCtrlName = "Game.UI.Soldier.Handbook.SoldierHandbookCharCtrl"
  },
  PartnerCtrl = {
    sNodeName = "PartnerRoot",
    sCtrlName = "Game.UI.Soldier.Handbook.SoldierHandbookPartnerCtrl"
  },
  BossCtrl = {
    sNodeName = "BossRoot",
    sCtrlName = "Game.UI.Soldier.Handbook.SoldierHandbookBossCtrl"
  },
  StrategyCardCtrl = {
    sNodeName = "StrategyCardRoot",
    sCtrlName = "Game.UI.Soldier.Handbook.SoldierHandbookStrategyCardCtrl"
  }
}
SoldierHandbookCtrl._mapEventConfig = {}
SoldierHandbookCtrl._mapRedDotConfig = {}

function SoldierHandbookCtrl:Awake()
  local param = self:GetPanelParam()
  local nSelectedType = 0
  if type(param) == "table" then
    nSelectedType = param[1]
  end
  if nSelectedType == 0 then
    nSelectedType = AllEnum.SoldierHandbookType.Character
  end
  self:SwitchToSelectedType(nSelectedType)
end

function SoldierHandbookCtrl:OnEnable()
  EventManager.Hit("SoldierHandbookPanel_Open")
end

function SoldierHandbookCtrl:OnDisable()
  EventManager.Hit("SoldierHandbookPanel_Close")
end

function SoldierHandbookCtrl:SwitchToSelectedType(nSelectedType)
  self._mapNode.CharCtrl:Clear()
  self._mapNode.PartnerCtrl:Clear()
  self._mapNode.BossCtrl:Clear()
  self._mapNode.StrategyCardCtrl:Clear()
  self.nSelectedType = nSelectedType
  self._mapNode.CharCtrl.gameObject:SetActive(self.nSelectedType == AllEnum.SoldierHandbookType.Character)
  self._mapNode.PartnerCtrl.gameObject:SetActive(self.nSelectedType == AllEnum.SoldierHandbookType.Partner)
  self._mapNode.BossCtrl.gameObject:SetActive(self.nSelectedType == AllEnum.SoldierHandbookType.Boss)
  self._mapNode.StrategyCardCtrl.gameObject:SetActive(self.nSelectedType == AllEnum.SoldierHandbookType.StrategyCard)
  self._mapNode.go_char_in.gameObject:SetActive(self.nSelectedType == AllEnum.SoldierHandbookType.Character)
  self._mapNode.go_char_off.gameObject:SetActive(self.nSelectedType ~= AllEnum.SoldierHandbookType.Character)
  self._mapNode.go_partner_in.gameObject:SetActive(self.nSelectedType == AllEnum.SoldierHandbookType.Partner)
  self._mapNode.go_partner_off.gameObject:SetActive(self.nSelectedType ~= AllEnum.SoldierHandbookType.Partner)
  self._mapNode.go_boss_in.gameObject:SetActive(self.nSelectedType == AllEnum.SoldierHandbookType.Boss)
  self._mapNode.go_boss_off.gameObject:SetActive(self.nSelectedType ~= AllEnum.SoldierHandbookType.Boss)
  self._mapNode.go_strategyCard_in.gameObject:SetActive(self.nSelectedType == AllEnum.SoldierHandbookType.StrategyCard)
  self._mapNode.go_strategyCard_off.gameObject:SetActive(self.nSelectedType ~= AllEnum.SoldierHandbookType.StrategyCard)
  if self.nSelectedType == AllEnum.SoldierHandbookType.Character then
    self._mapNode.CharCtrl:Init()
  elseif self.nSelectedType == AllEnum.SoldierHandbookType.Partner then
    self._mapNode.PartnerCtrl:Init()
  elseif self.nSelectedType == AllEnum.SoldierHandbookType.Boss then
    self._mapNode.BossCtrl:Init()
  elseif self.nSelectedType == AllEnum.SoldierHandbookType.StrategyCard then
    self._mapNode.StrategyCardCtrl:Init()
  end
end

function SoldierHandbookCtrl:OnBtnClick_Char()
  if self.nSelectedType == AllEnum.SoldierHandbookType.Character then
    return
  end
  self:SwitchToSelectedType(AllEnum.SoldierHandbookType.Character)
end

function SoldierHandbookCtrl:OnBtnClick_Partner()
  if self.nSelectedType == AllEnum.SoldierHandbookType.Partner then
    return
  end
  self:SwitchToSelectedType(AllEnum.SoldierHandbookType.Partner)
end

function SoldierHandbookCtrl:OnBtnClick_Boss()
  if self.nSelectedType == AllEnum.SoldierHandbookType.Boss then
    return
  end
  self:SwitchToSelectedType(AllEnum.SoldierHandbookType.Boss)
end

function SoldierHandbookCtrl:OnBtnClick_StrategyCard()
  if self.nSelectedType == AllEnum.SoldierHandbookType.StrategyCard then
    return
  end
  self:SwitchToSelectedType(AllEnum.SoldierHandbookType.StrategyCard)
end

return SoldierHandbookCtrl
