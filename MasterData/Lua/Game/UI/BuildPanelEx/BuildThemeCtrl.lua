local BuildThemeCtrl = class("BuildThemeCtrl", BaseCtrl)
BuildThemeCtrl._mapNodeConfig = {
  rtPerk = {sComponentName = "Transform"},
  imgTheme = {sComponentName = "Image"},
  goPerk = {},
  txtName = {sComponentName = "TMP_Text"},
  txtHas = {sComponentName = "TMP_Text"},
  txtAll = {sComponentName = "TMP_Text"}
}
BuildThemeCtrl._mapEventConfig = {}

function BuildThemeCtrl:Refresh(nTheme, tbPerk)
  self:RefreshTheme(nTheme)
  self:RefreshList(tbPerk)
end

function BuildThemeCtrl:RefreshTheme(nTheme)
  local mapTheme = ConfigTable.GetData("PresentsTheme", nTheme)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapTheme.ThemeName)
  self:SetPngSprite(self._mapNode.imgTheme, mapTheme.ThemeItemIcon)
end

function BuildThemeCtrl:RefreshList(tbPerk)
  self.tbPerk = {}
  for _, v in pairs(tbPerk) do
    table.insert(self.tbPerk, v)
  end
  local nAllPerk = #self.tbPerk
  delChildren(self._mapNode.rtPerk)
  self.tbGridCtrl = {}
  for i = 1, nAllPerk do
    local obj = instantiate(self._mapNode.goPerk, self._mapNode.rtPerk)
    obj.gameObject:SetActive(true)
    local ctrl = self:BindCtrlByNode(obj, "Game.UI.TemplateEx.TemplatePerkItemCtrl")
    table.insert(self.tbGridCtrl, ctrl)
    ctrl:SetPerk(self.tbPerk[i].nTid, self.tbPerk[i].nCount - 1, self.tbPerk[i].nMaxLevel - 1)
    local btn = obj.transform:GetComponent("UIButton")
    local func_Handler = ui_handler(self, self.OnBtnClick_Select, obj, i)
    btn.onClick:AddListener(func_Handler)
  end
  NovaAPI.SetTMPText(self._mapNode.txtHas, nAllPerk)
end

function BuildThemeCtrl:Awake()
end

function BuildThemeCtrl:OnEnable()
  self.tbGridCtrl = {}
end

function BuildThemeCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function BuildThemeCtrl:OnDestroy()
end

function BuildThemeCtrl:OnBtnClick_Select(btn, nIndex)
  local function tip()
    local mapPanelData = {
      nPerkId = self.tbPerk[nIndex].nTid,
      
      nCount = self.tbPerk[nIndex].nCount
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.PerkTips, btn.transform, mapPanelData)
  end
  
  EventManager.Hit("BuildThemeSelect", btn.gameObject, 0.1)
  self:AddTimer(1, 0.1, tip, true, true, true)
end

return BuildThemeCtrl
