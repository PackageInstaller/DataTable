local BuildPerkCtrl = class("BuildPerkCtrl", BaseCtrl)
local _, Gray = ColorUtility.TryParseHtmlString("#A0A9B2")
BuildPerkCtrl._mapNodeConfig = {
  btnPerk = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  txtTheme = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Perk_Theme"
  },
  txtExclusive = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Perk_Exclusive"
  },
  imgOn = {nCount = 2},
  imgOff = {nCount = 2},
  svExclusive = {},
  svTheme = {},
  scExclusive = {
    sNodeName = "svExclusive",
    sComponentName = "UIScrollToClick"
  },
  scTheme = {
    sNodeName = "svTheme",
    sComponentName = "UIScrollToClick"
  },
  ExclusiveList = {
    nCount = 3,
    sCtrlName = "Game.UI.BuildPanelEx.BuildExclusiveCtrl"
  },
  ThemeList = {
    nCount = 4,
    sCtrlName = "Game.UI.BuildPanelEx.BuildThemeCtrl"
  },
  goSlot = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplatePerkItemCtrl"
  },
  btnSlot = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Select"
  },
  imgSlotIcon = {nCount = 4, sComponentName = "Image"},
  txtSlotName = {nCount = 4, sComponentName = "TMP_Text"},
  imgSlotBg = {nCount = 4, sComponentName = "Image"}
}
BuildPerkCtrl._mapEventConfig = {
  BuildThemeSelect = "OnEvent_ThemeSelect",
  BuildExclusiveSelect = "OnEvent_ExclusiveSelect"
}

function BuildPerkCtrl:Refresh(mapBuild)
  self:RefreshData(mapBuild)
  self:RefreshExclusive()
  self:RefreshSlot()
  self:RefreshTheme()
  self:SetDefaultTab()
end

function BuildPerkCtrl:RefreshData(mapBuild)
  self.tbChar = mapBuild.tbChar
  self.tbTheme = mapBuild.tbTheme
  self.tbExclusivePerk = {}
  self.tbThemePerk = {}
  self.tbSlot = {}
  for _, mapPerk in ipairs(mapBuild.tbPerk) do
    local mapCfg = ConfigTable.GetData_Perk(mapPerk.Id)
    local mapAfter = {
      nTid = mapPerk.Id,
      nCount = mapPerk.Qty,
      nMaxLevel = mapPerk.MaxQty
    }
    if mapCfg.Slot and mapCfg.Slot > 0 then
      self.tbSlot[mapCfg.Slot] = mapAfter
    elseif mapCfg.CharId and 0 < mapCfg.CharId then
      if not self.tbExclusivePerk[mapCfg.CharId] then
        self.tbExclusivePerk[mapCfg.CharId] = {}
      end
      table.insert(self.tbExclusivePerk[mapCfg.CharId], mapAfter)
    elseif mapCfg.Theme and 0 < mapCfg.Theme then
      if not self.tbThemePerk[mapCfg.Theme] then
        self.tbThemePerk[mapCfg.Theme] = {}
      end
      table.insert(self.tbThemePerk[mapCfg.Theme], mapAfter)
    end
  end
end

local function sort(a, b)
  local cfgDataA = ConfigTable.GetData_Item(a.nTid)
  local cfgDataB = ConfigTable.GetData_Item(b.nTid)
  if cfgDataA.Rarity ~= cfgDataB.Rarity then
    return cfgDataA.Rarity < cfgDataB.Rarity
  end
  if a.nTid ~= b.nTid then
    return a.nTid < b.nTid
  end
  return a.nCount > b.nCount
end

function BuildPerkCtrl:RefreshExclusive()
  for i = 1, 3 do
    local nCharId = self.tbChar[i].nTid
    local tbPerk = self.tbExclusivePerk[nCharId]
    if tbPerk and 0 < #tbPerk then
      table.sort(tbPerk, sort)
      self._mapNode.ExclusiveList[i].gameObject:SetActive(true)
      self._mapNode.ExclusiveList[i]:Refresh(nCharId, tbPerk)
    else
      self._mapNode.ExclusiveList[i].gameObject:SetActive(false)
    end
  end
end

function BuildPerkCtrl:RefreshSlot()
  for i = 1, 4 do
    local bHas = self.tbSlot[i] ~= nil
    NovaAPI.SetImageColor(self._mapNode.imgSlotBg[i], bHas and White_Dark or Gray_Dark)
    NovaAPI.SetImageColor(self._mapNode.imgSlotIcon[i], bHas and White_Normal or Gray)
    NovaAPI.SetTMPColor(self._mapNode.txtSlotName[i], bHas and White_Normal or Gray)
    self._mapNode.btnSlot[i].gameObject:SetActive(bHas)
    if bHas then
      self._mapNode.goSlot[i]:SetPerk(self.tbSlot[i].nTid, self.tbSlot[i].nCount - 1, self.tbSlot[i].nMaxLevel - 1)
      self._mapNode.goSlot[i]:SetSelect(self.nSlotSelect == i)
    end
    self:SetAtlasSprite(self._mapNode.imgSlotIcon[i], "10_ico", "zs_vestige_icon_" .. i)
    NovaAPI.SetImageNativeSize(self._mapNode.imgSlotIcon[i])
    NovaAPI.SetTMPText(self._mapNode.txtSlotName[i], ConfigTable.GetUIText("Slot_Title_" .. i))
  end
end

function BuildPerkCtrl:RefreshTheme()
  local tbDefaultPresents = ConfigTable.GetConfigNumberArray("RglCommonPresentsThemeList")
  local tbDefaultTheme = {}
  for _, v in ipairs(tbDefaultPresents) do
    local mapCfg = ConfigTable.GetData("Presents", v)
    table.insert(tbDefaultTheme, mapCfg.Theme)
  end
  local mapThemePerk = {}
  for i = 1, 4 do
    local nTheme = self.tbTheme[i].Theme
    local tbPerk = self.tbThemePerk[nTheme]
    if tbPerk and 0 < #tbPerk then
      table.insert(mapThemePerk, {
        nTheme = nTheme,
        nCount = #tbPerk,
        bBase = table.indexof(tbDefaultTheme, 0 < nTheme)
      })
    end
  end
  table.sort(mapThemePerk, function(a, b)
    if a.nCount ~= b.nCount then
      return a.nCount > b.nCount
    elseif a.bBase ~= b.bBase then
      return not a.bBase and b.bBase
    else
      return a.nTheme < b.nTheme
    end
  end)
  for i = 1, 4 do
    if mapThemePerk[i] then
      local nTheme = mapThemePerk[i].nTheme
      local tbPerk = self.tbThemePerk[nTheme]
      table.sort(tbPerk, sort)
      self._mapNode.ThemeList[i].gameObject:SetActive(true)
      self._mapNode.ThemeList[i]:Refresh(nTheme, tbPerk)
    else
      self._mapNode.ThemeList[i].gameObject:SetActive(false)
    end
  end
end

function BuildPerkCtrl:SetDefaultTab()
  self.nCurTab = 1
  self._mapNode.svExclusive:SetActive(self.nCurTab == 2)
  self._mapNode.svTheme:SetActive(self.nCurTab == 1)
end

function BuildPerkCtrl:Awake()
end

function BuildPerkCtrl:OnEnable()
end

function BuildPerkCtrl:OnDisable()
end

function BuildPerkCtrl:OnDestroy()
end

function BuildPerkCtrl:OnBtnClick_Tab(btn, nIndex)
  if nIndex == self.nCurTab then
    return
  end
  for i = 1, 2 do
    self._mapNode.imgOn[i]:SetActive(i == nIndex)
    self._mapNode.imgOff[i]:SetActive(i ~= nIndex)
  end
  self.nCurTab = nIndex
  self._mapNode.svExclusive:SetActive(self.nCurTab == 2)
  self._mapNode.svTheme:SetActive(self.nCurTab == 1)
end

function BuildPerkCtrl:OnBtnClick_Select(btn, nIndex)
  local function tip()
    local mapPanelData = {
      nPerkId = self.tbSlot[nIndex].nTid,
      
      nCount = self.tbSlot[nIndex].nCount
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.PerkTips, btn.transform, mapPanelData)
  end
  
  EventManager.Hit("BuildThemeSelect", btn.gameObject, 0.1)
  self:AddTimer(1, 0.1, tip, true, true, true)
end

function BuildPerkCtrl:OnEvent_ThemeSelect(go, nTime)
  self._mapNode.scTheme:ScrollToClick(go, nTime)
end

function BuildPerkCtrl:OnEvent_ExclusiveSelect(go, nTime)
  self._mapNode.scExclusive:ScrollToClick(go, nTime)
end

return BuildPerkCtrl
