local SoldierHandbookCharDetailCtrl = class("SoldierHandbookCharDetailCtrl", BaseCtrl)
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
local RootPath = "Icon/SoldierOtherIcon/"
local PartnerPath = "Icon/SoldierPartner/"
local tabType = {Vanguard = 1, Support = 2}
local barMax = 512
local ColorChessRarity = {
  [GameEnum.ChessRarity.Gold] = Color(0.996078431372549, 0.8, 0.5333333333333333, 1),
  [GameEnum.ChessRarity.Purple] = Color(0.792156862745098, 0.6823529411764706, 0.9803921568627451, 1),
  [GameEnum.ChessRarity.Blue] = Color(0.6274509803921569, 0.7843137254901961, 0.996078431372549, 1),
  [GameEnum.ChessRarity.Green] = Color(0.8470588235294118, 0.9098039215686274, 0.7137254901960784, 1),
  [GameEnum.ChessRarity.White] = Color(0.8352941176470589, 0.8666666666666667, 0.9254901960784314, 1)
}
SoldierHandbookCharDetailCtrl._mapNodeConfig = {
  imgBg_Rare = {sComponentName = "Image"},
  img_Rare = {sComponentName = "Image"},
  txt_name = {sComponentName = "TMP_Text"},
  txt_cost = {sComponentName = "TMP_Text"},
  icon_Position = {sComponentName = "Image"},
  txt_Position = {sComponentName = "TMP_Text"},
  Partner = {nCount = 3},
  property_hp = {},
  property_sp = {},
  property_atk = {},
  property_def = {},
  btn_Vanguard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Vanguard"
  },
  go_Vanguard_on = {},
  go_Vanguard_off = {},
  txt_Vanguard = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Vanguard_Skill"
  },
  btn_Support = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Support"
  },
  go_Support_on = {},
  go_Support_off = {},
  txt_Support = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Support_Skill"
  },
  txt_skillTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_SkillTitle"
  },
  txt_potentialTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_PotentialTitle"
  },
  sv_Skill = {
    sComponentName = "LoopScrollView"
  },
  sv_Potential = {
    sComponentName = "LoopScrollView"
  },
  btn_charDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CharDetail"
  },
  txtBtnCharDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_CharDetail"
  },
  rtTipsPos = {
    sComponentName = "RectTransform"
  }
}
SoldierHandbookCharDetailCtrl._mapEventConfig = {}
SoldierHandbookCharDetailCtrl._mapRedDotConfig = {}

function SoldierHandbookCharDetailCtrl:Awake()
  self.tbSkillItemCtrl = {}
  self.tbPotentialItemCtrl = {}
end

function SoldierHandbookCharDetailCtrl:OnDestroy()
  self:Clear()
end

function SoldierHandbookCharDetailCtrl:Clear()
  if self.tbSkillItemCtrl ~= nil then
    for _, v in ipairs(self.tbSkillItemCtrl) do
      self:UnbindCtrlByNode(v)
    end
    self.tbSkillItemCtrl = {}
  end
  if self.tbPotentialItemCtrl ~= nil then
    for _, v in ipairs(self.tbPotentialItemCtrl) do
      self:UnbindCtrlByNode(v)
    end
    self.tbPotentialItemCtrl = {}
  end
end

function SoldierHandbookCharDetailCtrl:RefreshDetail(nCharId)
  if self.animator == nil then
    self.animator = self.gameObject:GetComponent("Animator")
  end
  self.animator:Play("CharDetail_in")
  if self.tbSkillItemCtrl ~= nil then
    for _, v in ipairs(self.tbSkillItemCtrl) do
      self:UnbindCtrlByNode(v)
    end
    self.tbSkillItemCtrl = {}
  end
  if self.tbPotentialItemCtrl ~= nil then
    for _, v in ipairs(self.tbPotentialItemCtrl) do
      self:UnbindCtrlByNode(v)
    end
    self.tbPotentialItemCtrl = {}
  end
  self.nCharId = nCharId
  self.charConfig = ConfigTable.GetData("SoldierCharacter", self.nCharId)
  if self.charConfig == nil then
    return
  end
  self.skinConfig = ConfigTable.GetData("SoldierSkin", self.charConfig.Skin)
  if self.skinConfig == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imgBg_Rare, RootPath .. AllEnum.SoldierChessRarityIcon[self.charConfig.Rarity] .. AllEnum.SoldierChessIconSurfix.XL)
  NovaAPI.SetImageColor(self._mapNode.img_Rare, ColorChessRarity[self.charConfig.Rarity])
  NovaAPI.SetTMPText(self._mapNode.txt_name, self.skinConfig.Name)
  NovaAPI.SetTMPText(self._mapNode.txt_cost, self.charConfig.Cost)
  local nChessType = self.charConfig.Type
  local tbChessTypeConfig = CacheTable.GetData("_SoldierChessType", nChessType)
  if tbChessTypeConfig ~= nil then
    self:SetPngSprite(self._mapNode.icon_Position, RootPath .. tbChessTypeConfig.Icon)
    NovaAPI.SetTMPText(self._mapNode.txt_Position, tbChessTypeConfig.Name)
  end
  local _, tbAttrMap = SoldierAttrData.CalcCharacterAttr(self.nCharId, 1, nil, nil, false)
  local txt_hp = self._mapNode.property_hp.transform:Find("txtValue"):GetComponent("TMP_Text")
  local hp = tbAttrMap.Hp
  NovaAPI.SetTMPText(txt_hp, hp.nValue .. "/" .. hp.nValue)
  local imgMainBarFill = self._mapNode.property_sp.transform:Find("imgBarBg/rtBarFill/imgMainBarFill"):GetComponent("Image")
  local txt_sp = self._mapNode.property_sp.transform:Find("txtValue"):GetComponent("TMP_Text")
  local sp = tbAttrMap.InitialEnergy
  local spMax = tbAttrMap.Energy
  NovaAPI.SetTMPText(txt_sp, sp.nValue .. "/" .. spMax.nValue)
  imgMainBarFill.rectTransform.sizeDelta = Vector2(sp.nValue / spMax.nValue * barMax, imgMainBarFill.rectTransform.sizeDelta.y)
  local txt_defName = self._mapNode.property_def.transform:Find("txtProperty"):GetComponent("TMP_Text")
  local txt_def = self._mapNode.property_def.transform:Find("txtValue2"):GetComponent("TMP_Text")
  local def = tbAttrMap.Def
  NovaAPI.SetTMPText(txt_def, def.nValue)
  NovaAPI.SetTMPText(txt_defName, ConfigTable.GetUIText(def.sLanguageId))
  local txt_atkName = self._mapNode.property_atk.transform:Find("txtProperty"):GetComponent("TMP_Text")
  local txt_atk = self._mapNode.property_atk.transform:Find("txtValue2"):GetComponent("TMP_Text")
  local atkValue = tbAttrMap.Atk
  NovaAPI.SetTMPText(txt_atkName, ConfigTable.GetUIText(atkValue.sLanguageId))
  NovaAPI.SetTMPText(txt_atk, atkValue.nValue)
  self:InitPartner()
  self:SwitchTab(tabType.Vanguard, true)
end

function SoldierHandbookCharDetailCtrl:InitPartner()
  local partnerType = self.charConfig.PartnerType
  for i = 1, 3 do
    self._mapNode.Partner[i]:SetActive(false)
  end
  for i = 1, 3 do
    if i > #partnerType then
      return
    end
    local configPartner = CacheTable.GetData("_SoldierPartnerGroup", partnerType[i])
    if configPartner == nil then
      return
    end
    local icon = self._mapNode.Partner[i].transform:Find("imgIcon"):GetComponent("Image")
    local txt_Partner = self._mapNode.Partner[i].transform:Find("txt_Partner"):GetComponent("TMP_Text")
    self:SetPngSprite(icon, PartnerPath .. configPartner.Icon .. AllEnum.SoldierChessIconSurfix.M)
    NovaAPI.SetTMPText(txt_Partner, configPartner.Name)
    self._mapNode.Partner[i]:SetActive(true)
  end
end

function SoldierHandbookCharDetailCtrl:SwitchTab(nTab, bForce)
  if self.nCurTab == nTab and not bForce then
    return
  end
  self.nCurTab = nTab
  self._mapNode.go_Vanguard_on:SetActive(self.nCurTab == tabType.Vanguard)
  self._mapNode.go_Vanguard_off:SetActive(self.nCurTab ~= tabType.Vanguard)
  self._mapNode.go_Support_on:SetActive(self.nCurTab == tabType.Support)
  self._mapNode.go_Support_off:SetActive(self.nCurTab ~= tabType.Support)
  if self.nCurTab == tabType.Vanguard then
    self:InitVanguard()
  else
    self:InitSupport()
  end
end

function SoldierHandbookCharDetailCtrl:InitVanguard()
  self.tbVanguardSkill = {}
  table.insert(self.tbVanguardSkill, self.charConfig.Skill)
  self._mapNode.sv_Skill:Init(#self.tbVanguardSkill, self, self.OnSkillRefreshGrid, self.OnSkillBtnClick, false)
  self.tbVanguardPotential = {}
  for i = 1, 4 do
    local potentialList = self.charConfig["Potential" .. tostring(i)]
    for _, potentialId in ipairs(potentialList) do
      table.insert(self.tbVanguardPotential, {nId = potentialId, nStar = i})
    end
  end
  self._mapNode.sv_Potential:Init(#self.tbVanguardPotential, self, self.OnPotentialRefreshGrid)
end

function SoldierHandbookCharDetailCtrl:OnSkillRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local skillId = 0
  if self.nCurTab == tabType.Vanguard then
    skillId = self.tbVanguardSkill[nIndex]
  else
    skillId = self.tbSupportSkill[nIndex]
  end
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbSkillItemCtrl[nInstanceId] then
    self.tbSkillItemCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateSkillCharCtrl")
  end
  local nSkillIndex = 2
  if self.nCurTab == tabType.Vanguard then
    nSkillIndex = 2
  else
    nSkillIndex = 3
  end
  self.tbSkillItemCtrl[nInstanceId]:SetSkill(skillId, nSkillIndex, 1, GameEnum.elementType.DE, false)
  local btnSkill = goGrid:GetComponent("UIButton")
  if btnSkill then
    btnSkill.onClick:RemoveAllListeners()
    btnSkill.onClick:AddListener(function()
      EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharSkillPreview, self.nCharId, nSkillIndex)
    end)
  end
end

function SoldierHandbookCharDetailCtrl:OnSkillBtnClick(goGrid, gridIndex)
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharSkillPreview, self.nCharId)
end

function SoldierHandbookCharDetailCtrl:OnPotentialRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local potential = self.tbVanguardPotential[nIndex]
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbPotentialItemCtrl[nInstanceId] then
    self.tbPotentialItemCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Soldier.Template.SoldierPotentialItemCtrl")
  end
  self.tbPotentialItemCtrl[nInstanceId]:SetItemData(potential.nId, potential.nStar)
  local btnPotential = goGrid.transform:Find("btnItem"):GetComponent("UIButton")
  if btnPotential then
    btnPotential.onClick:RemoveAllListeners()
    btnPotential.onClick:AddListener(function()
      EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharPontentialDetailPanel, self._mapNode.rtTipsPos, potential.nId)
    end)
  end
end

function SoldierHandbookCharDetailCtrl:InitSupport()
  self.tbSupportSkill = {}
  table.insert(self.tbSupportSkill, self.charConfig.Support)
  self._mapNode.sv_Skill:Init(#self.tbSupportSkill, self, self.OnSkillRefreshGrid, self.OnSkillBtnClick, false)
  self.tbVanguardPotential = {}
  for i = 1, 4 do
    local potentialList = self.charConfig["Potential" .. tostring(i)]
    for _, potentialId in ipairs(potentialList) do
      table.insert(self.tbVanguardPotential, {nId = potentialId, nStar = i})
    end
  end
  self._mapNode.sv_Potential:Init(#self.tbVanguardPotential, self, self.OnPotentialRefreshGrid)
end

function SoldierHandbookCharDetailCtrl:OnBtnClick_Vanguard()
  self:SwitchTab(tabType.Vanguard)
end

function SoldierHandbookCharDetailCtrl:OnBtnClick_Support()
  self:SwitchTab(tabType.Support)
end

function SoldierHandbookCharDetailCtrl:OnBtnClick_CharDetail()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharAttriTips, self.nCharId)
end

function SoldierHandbookCharDetailCtrl:OnEvent_SoldierHandbookChar_Selected(nCharId)
end

return SoldierHandbookCharDetailCtrl
