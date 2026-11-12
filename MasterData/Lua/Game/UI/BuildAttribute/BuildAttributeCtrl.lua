local BuildAttributeCtrl = class("BuildAttributeCtrl", BaseCtrl)
BuildAttributeCtrl._mapNodeConfig = {
  aniBlur = {sComponentName = "Animator"},
  aniBlur2 = {sComponentName = "Animator"},
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  btnBlur2 = {
    sNodeName = "snapshot2",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  window = {},
  aniWindow = {sNodeName = "window", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Note_SkillTitle"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  sv = {
    sComponentName = "LoopScrollView"
  }
}
BuildAttributeCtrl._mapEventConfig = {}

function BuildAttributeCtrl:Open()
  self._mapNode.aniBlur.gameObject:SetActive(self.bBlur)
  self._mapNode.aniBlur2.gameObject:SetActive(not self.bBlur)
  self:InitData()
  self:PlayInAni()
  self:Refresh()
end

function BuildAttributeCtrl:InitData()
  self.tbBuildRank = {}
  
  local function func_ForEach(mapData)
    self.tbBuildRank[mapData.Level] = mapData
  end
  
  ForEachTableLine(DataTable.StarTowerBuildRank, func_ForEach)
  self.nListCount = #self.tbBuildRank
end

function BuildAttributeCtrl:Refresh()
  if self.nListCount < 0 then
    return
  end
  self._mapNode.sv:Init(self.nListCount, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function BuildAttributeCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local rtGrid = goGrid.transform:Find("btnGrid/AnimRoot")
  local txtLevel = rtGrid.transform:Find("layout/txtLevel"):GetComponent("TMP_Text")
  local txtLevelDesc = rtGrid.transform:Find("layout/txtLevelDesc"):GetComponent("TMP_Text")
  local imgSelect = rtGrid.transform:Find("imgSelect").gameObject
  local imgOnBg = rtGrid.transform:Find("imgOnBg").gameObject
  local imgOffBg = rtGrid.transform:Find("imgOffBg").gameObject
  local imgOn = rtGrid.transform:Find("layout/imgOn").gameObject
  local imgOff = rtGrid.transform:Find("layout/imgOff").gameObject
  NovaAPI.SetTMPText(txtLevel, orderedFormat(ConfigTable.GetUIText("StarTower_Disc_Info_Level"), nIndex))
  local bOn = self.nLevel > 0 and nIndex == self.nLevel
  imgSelect:SetActive(bOn)
  imgOnBg:SetActive(bOn)
  imgOn:SetActive(bOn)
  imgOffBg:SetActive(not bOn)
  imgOff:SetActive(not bOn)
  local mapData = self.tbBuildRank[nIndex]
  NovaAPI.SetTMPText(txtLevelDesc, UTILS.ParseParamDesc(mapData.Desc, mapData))
end

function BuildAttributeCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
end

function BuildAttributeCtrl:PlayInAni()
  self._mapNode.window:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function BuildAttributeCtrl:PlayOutAni()
  if self.bBlur then
    self._mapNode.aniWindow:Play("t_window_04_t_out")
    self._mapNode.aniBlur:SetTrigger("tOut")
    self:AddTimer(1, 0.2, "Close", true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  else
    self._mapNode.aniBlur2.gameObject:SetActive(false)
    self:Close()
  end
end

function BuildAttributeCtrl:Close()
  self._mapNode.window:SetActive(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.BuildAttribute)
end

function BuildAttributeCtrl:Awake()
  self._mapNode.window:SetActive(false)
  self.bBlur = true
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nLevel = tbParam[1]
    if tbParam[2] ~= nil then
      self.bBlur = tbParam[2]
    end
  end
end

function BuildAttributeCtrl:OnEnable()
  self:Open()
end

function BuildAttributeCtrl:OnDisable()
end

function BuildAttributeCtrl:OnDestroy()
end

function BuildAttributeCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

return BuildAttributeCtrl
