local SoldierHandbookPartnerCtrl = class("SoldierHandbookPartnerCtrl", BaseCtrl)
local iconPath = "Icon/SoldierPartner/"
local tabType = {Camp = 1, Sect = 2}
SoldierHandbookPartnerCtrl._mapNodeConfig = {
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
  sv_partnerGroup = {
    sComponentName = "LoopScrollView"
  }
}
SoldierHandbookPartnerCtrl._mapEventConfig = {}
SoldierHandbookPartnerCtrl._mapRedDotConfig = {}

function SoldierHandbookPartnerCtrl:Awake()
end

function SoldierHandbookPartnerCtrl:OnDestroy()
  self:Clear()
end

function SoldierHandbookPartnerCtrl:Clear()
end

function SoldierHandbookPartnerCtrl:Init()
  self:Clear()
  self:InitPartnerGroupList()
  self:SetSelectTab(tabType.Camp, true)
end

function SoldierHandbookPartnerCtrl:InitTab()
  self._mapNode.go_camp_on.gameObject:SetActive(self.nCurrentTab == tabType.Camp)
  self._mapNode.go_sect_on.gameObject:SetActive(self.nCurrentTab == tabType.Sect)
  self._mapNode.go_camp_off.gameObject:SetActive(self.nCurrentTab ~= tabType.Camp)
  self._mapNode.go_sect_off.gameObject:SetActive(self.nCurrentTab ~= tabType.Sect)
end

function SoldierHandbookPartnerCtrl:InitPartnerGroupList()
  self.tbPartnerGroup = {}
  
  local function func_ForEach_PartnerGroup(mapPartnerGroup)
    if self.tbPartnerGroup[mapPartnerGroup.PartnerCatalogue] == nil then
      self.tbPartnerGroup[mapPartnerGroup.PartnerCatalogue] = {}
    end
    table.insert(self.tbPartnerGroup[mapPartnerGroup.PartnerCatalogue], mapPartnerGroup)
  end
  
  ForEachTableLine(DataTable.SoldierPartnerGroup, func_ForEach_PartnerGroup)
end

function SoldierHandbookPartnerCtrl:SetSelectTab(nTab, bForce)
  bForce = bForce or false
  if self.nCurrentTab == nTab and not bForce then
    return
  end
  self.nCurrentTab = nTab
  self:InitTab()
  self.tbCurPartnerGroup = {}
  if self.nCurrentTab == tabType.Camp then
    self.tbCurPartnerGroup = self.tbPartnerGroup[GameEnum.PartnerCatalogue.Camp]
  else
    self.tbCurPartnerGroup = self.tbPartnerGroup[GameEnum.PartnerCatalogue.Style]
  end
  self._mapNode.sv_partnerGroup:Init(#self.tbCurPartnerGroup, self, self.OnPartnerGroupRefreshGrid)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:PlayGridAnim()
  end
  
  cs_coroutine.start(wait)
end

function SoldierHandbookPartnerCtrl:PlayGridAnim()
  local listInUse = {}
  listInUse = self._mapNode.sv_partnerGroup:GetInUseGridIndex()
  self.tbGridInUse = {}
  for i = 0, listInUse.Count - 1 do
    table.insert(self.tbGridInUse, listInUse[i])
  end
  local columnCount = 5
  for k, v in ipairs(self.tbGridInUse) do
    local goGrid = self._mapNode.sv_partnerGroup.transform:Find("Viewport/Content/" .. v)
    local animRoot = goGrid:GetComponent("Animator")
    local delayTime = math.modf((k - 1) / columnCount) * 0.2 + k % (columnCount + 1) * 0.04
    animRoot:Play("ready")
    if 0 < delayTime then
      self:AddTimer(1, delayTime, function()
        animRoot:Play("go")
      end, true, true, true)
    else
      animRoot:Play("go")
    end
  end
end

function SoldierHandbookPartnerCtrl:OnPartnerGroupRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local iconPartner = goGrid.transform:Find("partnerCell/iconPartner"):GetComponent("Image")
  local txt_name = goGrid.transform:Find("partnerCell/txt_name"):GetComponent("TMP_Text")
  local btn = goGrid.transform:Find("partnerCell"):GetComponent("UIButton")
  local cfg = self.tbCurPartnerGroup[nIndex]
  self:SetPngSprite(iconPartner, iconPath .. cfg.Icon .. AllEnum.SoldierChessIconSurfix.L)
  NovaAPI.SetTMPText(txt_name, cfg.Name)
  btn.onClick:RemoveAllListeners()
  btn.onClick:AddListener(function()
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierHandbookPartnerDetailPanel, cfg.Id)
  end)
end

function SoldierHandbookPartnerCtrl:OnBtnClick_TabCamp()
  self:SetSelectTab(tabType.Camp)
end

function SoldierHandbookPartnerCtrl:OnBtnClick_TabSect()
  self:SetSelectTab(tabType.Sect)
end

return SoldierHandbookPartnerCtrl
