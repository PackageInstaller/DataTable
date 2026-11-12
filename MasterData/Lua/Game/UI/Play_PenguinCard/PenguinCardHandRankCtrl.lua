local PenguinCardHandRankCtrl = class("PenguinCardHandRankCtrl", BaseCtrl)
local ConfigData = require("GameCore.Data.ConfigData")
PenguinCardHandRankCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnCloseBg = {
    sNodeName = "snapshot",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Title_HandRank"
  },
  window = {},
  aniWindow = {sNodeName = "window", sComponentName = "Animator"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtHandRank = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_HandRank"
  },
  txtBase = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_HandRankBase"
  },
  txtRatio = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_HandRankRatio"
  },
  sv = {
    sComponentName = "LoopScrollView"
  }
}
PenguinCardHandRankCtrl._mapEventConfig = {PenguinCard_OpenHandRank = "Open"}

function PenguinCardHandRankCtrl:Open()
  self._panel.mapLevel:Pause()
  self:PlayInAni()
  self:Refresh()
end

function PenguinCardHandRankCtrl:Refresh()
  local nCount = #self._panel.mapLevel.mapHandRankRule
  self._mapNode.sv.gameObject:SetActive(0 < nCount)
  if 0 < nCount then
    self._mapNode.sv:SetAnim(0.08)
    self._mapNode.sv:Init(nCount, self, self.OnGridRefresh)
  end
end

function PenguinCardHandRankCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local rtGrid = goGrid.transform:Find("btnGrid/AnimRoot")
  local txtDesc = rtGrid.transform:Find("txtDesc"):GetComponent("TMP_Text")
  local txtName = rtGrid.transform:Find("txtName"):GetComponent("TMP_Text")
  local txtScoreBase = rtGrid.transform:Find("imgBase/txtScoreBase"):GetComponent("TMP_Text")
  local txtScoreRatio = rtGrid.transform:Find("imgRatio/txtScoreRatio"):GetComponent("TMP_Text")
  local mapData = self._panel.mapLevel.mapHandRankRule[nIndex]
  local mapCfg = ConfigTable.GetData("PenguinCardHandRank", mapData.Id)
  if mapCfg then
    NovaAPI.SetTMPText(txtName, mapCfg.Title)
    NovaAPI.SetTMPText(txtDesc, mapCfg.Desc)
    NovaAPI.SetTMPText(txtScoreBase, self:ThousandsNumber(mapCfg.Value))
    NovaAPI.SetTMPText(txtScoreRatio, string.format("%.1f", mapCfg.Ratio * ConfigData.IntFloatPrecision + 1))
  end
end

function PenguinCardHandRankCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self._mapNode.blur:SetActive(true)
  self._mapNode.window:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function PenguinCardHandRankCtrl:Close()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, function()
    self._mapNode.window:SetActive(false)
    self.gameObject:SetActive(false)
    self._panel.mapLevel:Resume()
  end, true, true, true)
end

function PenguinCardHandRankCtrl:Awake()
  self._mapNode.window:SetActive(false)
end

function PenguinCardHandRankCtrl:OnEnable()
end

function PenguinCardHandRankCtrl:OnDisable()
end

function PenguinCardHandRankCtrl:OnBtnClick_Close()
  self:Close()
end

return PenguinCardHandRankCtrl
