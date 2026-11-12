local BuildAttrPreviewCtrl = class("BuildAttrPreviewCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
BuildAttrPreviewCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnCloseBg = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Attribute_Title"
  },
  window = {},
  aniWindow = {sNodeName = "window", sComponentName = "Animator"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Attribute_DescTip"
  },
  All = {sNodeName = "--All---"},
  svAll = {
    sComponentName = "LoopScrollView"
  },
  Cur = {sNodeName = "--Cur---"},
  svCur = {
    sComponentName = "LoopScrollView"
  },
  txtCurScoreCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Attribute_CurScore"
  },
  imgBuildIcon = {sComponentName = "Image"},
  txtCurScore = {sComponentName = "TMP_Text"},
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  }
}
BuildAttrPreviewCtrl._mapEventConfig = {}

function BuildAttrPreviewCtrl:Open()
  self._mapNode.blur:SetActive(true)
  self:PlayInAni()
  self._mapNode.All:SetActive(not self.nRankId)
  self._mapNode.Cur:SetActive(self.nRankId)
  if self.nRankId then
    self:RefreshCur()
  else
    self:RefreshAll()
  end
end

function BuildAttrPreviewCtrl:RefreshCur()
  local mapCfg = ConfigTable.GetData("StarTowerBuildRank", self.nRankId)
  if not mapCfg then
    return
  end
  local sScore = "Icon/BuildRank/BuildRank_" .. self.nRankId
  self:SetPngSprite(self._mapNode.imgBuildIcon, sScore)
  NovaAPI.SetTMPText(self._mapNode.txtCurScore, self.nScore)
  self.tbRank = PlayerData.Build:GetBuildRank()
  local nCount = #self.tbRank
  self._mapNode.svCur.gameObject:SetActive(0 < nCount)
  if 0 < nCount then
    self._mapNode.svCur:Init(nCount, self, self.OnGridRefresh_Cur)
    self._mapNode.svCur:SetScrollGridPos(self.nRankId - 1, 0.1, -1)
  end
end

function BuildAttrPreviewCtrl:OnGridRefresh_Cur(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local rtGrid = goGrid.transform:Find("btnGrid/AnimRoot")
  local imgOn = rtGrid.transform:Find("imgOnBg").gameObject
  local imgOff = rtGrid.transform:Find("imgOffBg").gameObject
  local txtDesc = rtGrid.transform:Find("txtDesc"):GetComponent("TMP_Text")
  local txtLevel = rtGrid.transform:Find("txtLevel"):GetComponent("TMP_Text")
  local txtScore = rtGrid.transform:Find("txtScore"):GetComponent("TMP_Text")
  local txtScoreCn = rtGrid.transform:Find("txtScore/imgBg/txtScoreCn"):GetComponent("TMP_Text")
  local imgSelect = rtGrid.transform:Find("imgSelect").gameObject
  local imgIcon = rtGrid.transform:Find("imgIcon"):GetComponent("Image")
  local mapData = self.tbRank[nIndex]
  local bOn = nIndex == self.nRankId
  imgSelect:SetActive(bOn)
  imgOn:SetActive(bOn)
  imgOff:SetActive(not bOn)
  NovaAPI.SetTMPText(txtLevel, orderedFormat(ConfigTable.GetUIText("Build_Attribute_Level"), mapData.Level))
  NovaAPI.SetTMPText(txtScoreCn, ConfigTable.GetUIText("Build_Score"))
  NovaAPI.SetTMPText(txtScore, mapData.MinGrade)
  NovaAPI.SetTMPText(txtDesc, UTILS.ParseParamDesc(ConfigTable.GetUIText(mapData.Desc), mapData, nil, nil, "#ec6d21"))
  local sScore = "Icon/BuildRank/BuildRank_" .. nIndex
  self:SetPngSprite(imgIcon, sScore)
end

function BuildAttrPreviewCtrl:RefreshAll()
  self.tbRank = PlayerData.Build:GetBuildRank()
  local nCount = #self.tbRank
  self._mapNode.svAll.gameObject:SetActive(0 < nCount)
  if 0 < nCount then
    self._mapNode.svAll:Init(nCount, self, self.OnGridRefresh_All)
  end
end

function BuildAttrPreviewCtrl:OnGridRefresh_All(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local rtGrid = goGrid.transform:Find("btnGrid/AnimRoot")
  local imgOn = rtGrid.transform:Find("imgOnBg").gameObject
  local imgOff = rtGrid.transform:Find("imgOffBg").gameObject
  local txtDesc = rtGrid.transform:Find("txtDesc"):GetComponent("TMP_Text")
  local txtLevel = rtGrid.transform:Find("txtLevel"):GetComponent("TMP_Text")
  local txtScore = rtGrid.transform:Find("txtScore"):GetComponent("TMP_Text")
  local txtScoreCn = rtGrid.transform:Find("txtScore/imgBg/txtScoreCn"):GetComponent("TMP_Text")
  local imgIcon = rtGrid.transform:Find("imgIcon"):GetComponent("Image")
  local mapData = self.tbRank[nIndex]
  local bOn = true
  imgOn:SetActive(bOn)
  imgOff:SetActive(not bOn)
  NovaAPI.SetTMPText(txtLevel, orderedFormat(ConfigTable.GetUIText("Build_Attribute_Level"), mapData.Level))
  NovaAPI.SetTMPText(txtScoreCn, ConfigTable.GetUIText("Build_Score"))
  NovaAPI.SetTMPText(txtScore, mapData.MinGrade)
  NovaAPI.SetTMPText(txtDesc, UTILS.ParseParamDesc(ConfigTable.GetUIText(mapData.Desc), mapData, nil, nil, "#ec6d21"))
  local sScore = "Icon/BuildRank/BuildRank_" .. nIndex
  self:SetPngSprite(imgIcon, sScore)
end

function BuildAttrPreviewCtrl:PlayInAni()
  self._mapNode.window:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function BuildAttrPreviewCtrl:PlayOutAni()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, "Close", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function BuildAttrPreviewCtrl:Close()
  self._mapNode.window:SetActive(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.BuildAttrPreview)
end

function BuildAttrPreviewCtrl:Awake()
  self._mapNode.window:SetActive(false)
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nRankId = tbParam[1]
    self.nScore = tbParam[2]
  end
  self._mapNode.btnShortcutClose.gameObject:SetActive(GamepadUIManager.GetInputState())
  if GamepadUIManager.GetInputState() then
    local tbConfig = {
      {
        sAction = "Back",
        sLang = "ActionBar_Back"
      }
    }
    self._mapNode.ActionBar:InitActionBar(tbConfig)
  end
end

function BuildAttrPreviewCtrl:OnEnable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.EnableGamepadUI("BuildAttrPreviewCtrl", self:GetGamepadUINode(), nil, true)
  end
  self:Open()
end

function BuildAttrPreviewCtrl:OnDisable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("BuildAttrPreviewCtrl")
  end
end

function BuildAttrPreviewCtrl:OnDestroy()
end

function BuildAttrPreviewCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

return BuildAttrPreviewCtrl
