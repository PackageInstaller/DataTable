local StarTowerFastBattleLogCtrl = class("StarTowerFastBattleLogCtrl", BaseCtrl)
StarTowerFastBattleLogCtrl._mapNodeConfig = {
  goWindow = {},
  aniWindow = {sNodeName = "goWindow", sComponentName = "Animator"},
  goBlur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Sweep_Log_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnFullScreenClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  EmptyRoot = {},
  textEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Sweep_Log_Empty"
  },
  LogRoot = {},
  svLog = {
    sComponentName = "LoopScrollView"
  }
}
StarTowerFastBattleLogCtrl._mapEventConfig = {}

function StarTowerFastBattleLogCtrl:Awake()
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.goWindow:SetActive(false)
end

function StarTowerFastBattleLogCtrl:OnEnable()
  local canvas = self.gameObject:GetComponent("Canvas")
  NovaAPI.SetCanvasOverrideSorting(canvas, true)
  NovaAPI.SetCanvasSortingOrder(canvas, AllEnum.UI_SORTING_ORDER.StarTowerAutoDecisionHUD + 1)
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:Refresh()
    self._mapNode.goWindow:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  end
  
  cs_coroutine.start(wait)
end

function StarTowerFastBattleLogCtrl:OnDisable()
end

function StarTowerFastBattleLogCtrl:OnDestroy()
end

function StarTowerFastBattleLogCtrl:Refresh()
  if nil ~= self._panel.tbHistoryLog and #self._panel.tbHistoryLog > 0 then
    self._mapNode.svLog:Init(#self._panel.tbHistoryLog, self, self.OnGridRefreshLog)
    self._mapNode.EmptyRoot:SetActive(false)
    self._mapNode.LogRoot:SetActive(true)
    self._mapNode.svLog:SetScrollGridPos(#self._panel.tbHistoryLog - 1, 0)
  else
    self._mapNode.LogRoot:SetActive(false)
    self._mapNode.EmptyRoot:SetActive(true)
  end
end

function StarTowerFastBattleLogCtrl:OnGridRefreshLog(goGrid, gridIndex)
  local nLogIndex = gridIndex + 1
  local sLog = self._panel.tbHistoryLog[nLogIndex]
  local txtLog = goGrid.transform:Find("btnGrid/AnimRoot/imgBg_Log/textLog"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtLog, sLog)
end

function StarTowerFastBattleLogCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerFastBattleLog)
  end, true, true, true)
end

return StarTowerFastBattleLogCtrl
