local SoldierHandbookPartnerDetailCtrl = class("SoldierHandbookPartnerDetailCtrl", BaseCtrl)
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
local RootPath = "Icon/SoldierOtherIcon/"
local iconPath = "Icon/SoldierPartner/"
local tabType = {Camp = 1, Sect = 2}
local replace_Harvest = "==HARVEST=="
SoldierHandbookPartnerDetailCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  btn_tabcamp = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TabCamp"
  },
  txt_camp = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_Partner_Camp"
  },
  go_camp_on = {sNodeName = "tab_campOn"},
  go_camp_off = {
    sNodeName = "tab_campOff"
  },
  btn_tabsect = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TabSect"
  },
  txt_sect = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_Partner_Sect"
  },
  go_sect_on = {sNodeName = "tab_sectOn"},
  go_sect_off = {
    sNodeName = "tab_sectOff"
  },
  parnerLoop = {
    sNodeName = "PartnerDetailTab",
    sComponentName = "LoopScrollView"
  },
  txt_name = {sComponentName = "TMP_Text"},
  img_partnerIcon = {sComponentName = "Image"},
  TMP_Link = {
    sNodeName = "txt_PartnerDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  txt_PartnerDesc = {sComponentName = "TMP_Text"},
  partner_desc = {nCount = 6},
  txt_charListTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_PartnerCharListTitle"
  },
  sv_char = {
    sComponentName = "LoopScrollView"
  },
  charDetialRoot = {sComponentName = "Transform"},
  detailAnimator = {
    sNodeName = "PartnerDetail",
    sComponentName = "Animator"
  },
  content = {
    sNodeName = "Scroll View",
    sComponentName = "RectTransform"
  }
}
SoldierHandbookPartnerDetailCtrl._mapEventConfig = {}
SoldierHandbookPartnerDetailCtrl._mapRedDotConfig = {}

function SoldierHandbookPartnerDetailCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nPartnerGroupId = param[1]
  end
  self.mapPartnerGroupData = ConfigTable.GetData("SoldierPartnerGroup", self.nPartnerGroupId)
  self.tbPartnerItemCtrl = {}
  self.tbCharItemCtrl = {}
  self:SelectTab(self.mapPartnerGroupData.PartnerCatalogue)
end

function SoldierHandbookPartnerDetailCtrl:OnDestroy()
  if self.tbCharItemCtrl ~= nil then
    for _, v in ipairs(self.tbCharItemCtrl) do
      self:UnbindCtrlByNode(v)
    end
    self.tbCharItemCtrl = nil
  end
  if self.tbPartnerItemCtrl ~= nil then
    for _, v in ipairs(self.tbPartnerItemCtrl) do
      self:UnbindCtrlByNode(v)
    end
    self.tbPartnerItemCtrl = nil
  end
end

function SoldierHandbookPartnerDetailCtrl:InitTab()
  self._mapNode.go_camp_on.gameObject:SetActive(self.nCurrentTab == tabType.Camp)
  self._mapNode.go_sect_on.gameObject:SetActive(self.nCurrentTab == tabType.Sect)
  self._mapNode.go_camp_off.gameObject:SetActive(self.nCurrentTab ~= tabType.Camp)
  self._mapNode.go_sect_off.gameObject:SetActive(self.nCurrentTab ~= tabType.Sect)
end

function SoldierHandbookPartnerDetailCtrl:SelectTab(nTab)
  if self.nCurrentTab == nTab then
    return
  end
  self.nCurrentTab = nTab
  self.tbCurPartnerGroup = {}
  self:InitTab()
  self:InitPartnerGroup()
  self:InitPartnerGroupList()
  self:InitDetail()
end

function SoldierHandbookPartnerDetailCtrl:InitPartnerGroup()
  self.tbPartnerGroup = {}
  
  local function func_ForEach_PartnerGroup(mapPartnerGroup)
    if self.tbPartnerGroup[mapPartnerGroup.PartnerCatalogue] == nil then
      self.tbPartnerGroup[mapPartnerGroup.PartnerCatalogue] = {}
    end
    table.insert(self.tbPartnerGroup[mapPartnerGroup.PartnerCatalogue], mapPartnerGroup)
    if mapPartnerGroup.Id == self.nPartnerGroupId then
      nIndex = #self.tbPartnerGroup[mapPartnerGroup.PartnerCatalogue]
    end
  end
  
  ForEachTableLine(DataTable.SoldierPartnerGroup, func_ForEach_PartnerGroup)
end

function SoldierHandbookPartnerDetailCtrl:InitPartnerGroupList()
  self.tbCurPartnerGroup = self.tbPartnerGroup[self.nCurrentTab]
  local nIndex = 0
  for i, v in ipairs(self.tbCurPartnerGroup) do
    if v.Id == self.nPartnerGroupId then
      nIndex = i
      break
    end
  end
  self._mapNode.parnerLoop:Init(#self.tbCurPartnerGroup, self, self.OnPartnerGroupRefreshGrid, self.OnPartnerGroupBtnClick, false)
  if 0 < nIndex then
    self._mapNode.parnerLoop:SetScrollGridPos(nIndex - 1, 0.5, 0)
  else
    self.nPartnerGroupId = self.tbCurPartnerGroup[1].Id
    self.mapPartnerGroupData = self.tbCurPartnerGroup[1]
    EventManager.Hit("SoldierHandbookPartnerSelect", self.nPartnerGroupId)
  end
end

function SoldierHandbookPartnerDetailCtrl:OnPartnerGroupRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local partnerGroup = self.tbCurPartnerGroup[nIndex]
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbPartnerItemCtrl[nInstanceId] then
    self.tbPartnerItemCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Soldier.Handbook.SoldierHandbookParnerListItem")
  end
  self.tbPartnerItemCtrl[nInstanceId]:SetPartnerGroup(partnerGroup, self.nPartnerGroupId == partnerGroup.Id)
end

function SoldierHandbookPartnerDetailCtrl:OnPartnerGroupBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local partnerGroup = self.tbCurPartnerGroup[nIndex]
  self.nPartnerGroupId = partnerGroup.Id
  self.mapPartnerGroupData = partnerGroup
  EventManager.Hit("SoldierHandbookPartnerSelect", self.nPartnerGroupId)
  self:InitDetail()
end

function SoldierHandbookPartnerDetailCtrl:InitDetail()
  if self.mapPartnerGroupData == nil then
    return
  end
  self._mapNode.detailAnimator:Play("SoldierHandbookPartnerDetail_in")
  self:SetPngSprite(self._mapNode.img_partnerIcon, iconPath .. self.mapPartnerGroupData.Icon .. AllEnum.SoldierChessIconSurfix.M)
  NovaAPI.SetTMPText(self._mapNode.txt_name, self.mapPartnerGroupData.Name)
  local sDesc = UTILS.ParseDesc(self.mapPartnerGroupData)
  sDesc = string.gsub(sDesc, replace_Harvest, 0)
  NovaAPI.SetTMPText(self._mapNode.txt_PartnerDesc, sDesc)
  for i = 1, 6 do
    self._mapNode.partner_desc[i]:SetActive(false)
  end
  local tbAttrData = SoldierAttrData.GetPartnerLevelsByType(self.mapPartnerGroupData.PartnerType)
  for i, v in ipairs(tbAttrData) do
    local mapCfg = ConfigTable.GetData("SoldierPartner", v.nConfigId)
    if mapCfg ~= nil then
      local bg_icon = self._mapNode.partner_desc[i].transform:Find("icon_Level"):GetComponent("Image")
      self:SetPngSprite(bg_icon, RootPath .. AllEnum.SoldierPartnerLevelIcon[mapCfg.PartnerLevelQuality].levelIcon)
      local txt_desc = self._mapNode.partner_desc[i].transform:Find("txt_desc"):GetComponent("TMP_Text")
      local txt_level = self._mapNode.partner_desc[i].transform:Find("icon_Level/txt_level"):GetComponent("TMP_Text")
      local link = txt_desc.transform:GetComponent("TMPHyperLink")
      NovaAPI.SetTMPText(txt_desc, v.sDesc)
      NovaAPI.SetTMPText(txt_level, mapCfg.Num)
      local handler = ui_handler(self, function(_, goLink, sWordId)
        UTILS.ClickWordLink(goLink, sWordId)
      end, link)
      link.onClick:AddListener(handler)
      self._mapNode.partner_desc[i]:SetActive(true)
    end
  end
  self.tbCharIds = self.mapPartnerGroupData.ChessCharacterIds
  table.sort(self.tbCharIds, function(a, b)
    local aCfg = ConfigTable.GetData("SoldierCharacter", a)
    local bCfg = ConfigTable.GetData("SoldierCharacter", b)
    if aCfg == nil or bCfg == nil then
      return false
    end
    if aCfg.Rarity ~= bCfg.Rarity then
      return aCfg.Rarity > bCfg.Rarity
    end
    return aCfg.Id < bCfg.Id
  end)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.sv_char:Init(#self.mapPartnerGroupData.ChessCharacterIds, self, self.OnCharRefreshGrid, self.OnCharBtnClick, false)
  end
  
  cs_coroutine.start(wait)
end

function SoldierHandbookPartnerDetailCtrl:OnBtnClick_TabSect()
  if self.nCurrentTab == tabType.Sect then
    return
  end
  self:SelectTab(tabType.Sect)
end

function SoldierHandbookPartnerDetailCtrl:OnBtnClick_TabCamp()
  if self.nCurrentTab == tabType.Camp then
    return
  end
  self:SelectTab(tabType.Camp)
end

function SoldierHandbookPartnerDetailCtrl:OnCharRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local charId = self.tbCharIds[nIndex]
  local go_char = goGrid.transform:Find("tc_char_small")
  local nInstanceId = go_char:GetInstanceID()
  if not self.tbCharItemCtrl[nInstanceId] then
    self.tbCharItemCtrl[nInstanceId] = self:BindCtrlByNode(go_char, "Game.UI.Soldier.Template.Character.SoldierCharItemCtrl")
  end
  self.tbCharItemCtrl[nInstanceId]:SetItemData(charId)
  self.tbCharItemCtrl[nInstanceId]:SetCharLevel(0)
end

function SoldierHandbookPartnerDetailCtrl:OnCharBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local charId = self.tbCharIds[nIndex]
  local chessData = {nId = charId, nStar = 1}
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, self._mapNode.charDetialRoot, chessData)
  local tr = self._mapNode.charDetialRoot
  EventManager.Hit("OnSetTipsPosition", tr:GetChild(0).position, tr:GetChild(1).position, tr:GetChild(2).position)
  EventManager.Hit("SoldierCharTips_ShowBg")
end

function SoldierHandbookPartnerDetailCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return SoldierHandbookPartnerDetailCtrl
