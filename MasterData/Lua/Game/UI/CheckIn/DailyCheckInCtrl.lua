local DailyCheckInCtrl = class("DailyCheckInCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
DailyCheckInCtrl._mapNodeConfig = {
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  cgRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  cgBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "CanvasGroup"
  },
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  snapshot = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  imgMonth = {nCount = 2, sComponentName = "Image"},
  txtYear = {sComponentName = "TMP_Text"},
  goSpace = {},
  txtRewardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "DailyCheckIn_Reward"
  },
  goCurItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  txtRewardName = {sComponentName = "TMP_Text"},
  btnCur = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tips"
  },
  sv = {
    sComponentName = "LoopScrollView"
  },
  trSv = {sNodeName = "sv", sComponentName = "Transform"}
}
DailyCheckInCtrl._mapEventConfig = {}

function DailyCheckInCtrl:Refresh()
  self:RefreshRight()
  self:RefreshList()
  self:RefreshSelect()
end

function DailyCheckInCtrl:RefreshRight()
  local nTens, _ = math.modf(self.nMonth / 10 % 10)
  local nOnes, _ = math.modf(self.nMonth % 10)
  NovaAPI.SetTMPText(self._mapNode.txtYear, self.nYear)
  self._mapNode.goSpace:SetActive(nTens == 1)
  self:SetAtlasSprite(self._mapNode.imgMonth[1], "05_number", "zs_dailycheckin_month_" .. nTens)
  NovaAPI.SetImageNativeSize(self._mapNode.imgMonth[1])
  self:SetAtlasSprite(self._mapNode.imgMonth[2], "05_number", "zs_dailycheckin_month_" .. nOnes)
  NovaAPI.SetImageNativeSize(self._mapNode.imgMonth[2])
end

function DailyCheckInCtrl:RefreshList()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.sv:Init(#self.tbList, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function DailyCheckInCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapItem = self.tbList[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  if nIndex == self.nIndex then
    self.tbGridCtrl[nInstanceID]:SetItem(mapItem.ItemId, nil, mapItem.ItemQty, nil, self.bReceived, nil, nil, true)
  else
    self.tbGridCtrl[nInstanceID]:SetItem(mapItem.ItemId, nil, mapItem.ItemQty, nil, nIndex <= self.nIndex, nil, nil, true)
  end
  self.tbGridCtrl[nInstanceID]:SetMultiSelected_Blue(nIndex == self.nIndex)
  self.tbGridCtrl[nInstanceID]:SetSelect(nIndex == self.nSelect)
end

function DailyCheckInCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if self.nSelect then
    local goSelect = self._mapNode.trSv:Find("Viewport/Content/" .. self.nSelect - 1)
    if goSelect then
      self.tbGridCtrl[goSelect.gameObject:GetInstanceID()]:SetSelect(false)
    end
  end
  self.nSelect = nIndex
  self.tbGridCtrl[nInstanceID]:SetSelect(true)
  self:RefreshSelect()
end

function DailyCheckInCtrl:RefreshSelect()
  local mapItem = self.tbList[self.nSelect]
  local mapCfg = ConfigTable.GetData_Item(mapItem.ItemId)
  self._mapNode.goCurItem:SetItem(mapItem.ItemId, nil, mapItem.ItemQty, nil, nil, nil, nil, true)
  NovaAPI.SetTMPText(self._mapNode.txtRewardName, mapCfg.Title)
end

function DailyCheckInCtrl:PlayReceiveAni()
  local goCur = self._mapNode.trSv:Find("Viewport/Content/" .. self.nIndex - 1)
  local aniReceive = goCur:Find("btnGrid/AnimRoot/goItem/--Common--/goReceived"):GetComponent("Animator")
  aniReceive.gameObject:SetActive(true)
  aniReceive:SetTrigger("tIn")
  CS.WwiseAudioManager.Instance:PlaySound("ui_common_stamp")
  self:AddTimer(1, 0.4, function()
    UTILS.OpenReceiveByReward(self.mapReward, function()
      NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgRoot, true)
      NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgBlur, true)
    end)
  end, true, true, true)
end

function DailyCheckInCtrl:FadeIn(bPlayFadeIn)
  self._mapNode.aniRoot:SetTrigger("tIn")
  if not self.bReceived then
    self:AddTimer(1, 0.4, "PlayReceiveAni", true, true, true)
  end
end

function DailyCheckInCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.mapReward = tbParam[1]
    self.callback = tbParam[2]
  end
  local nYear, nMonth, nDays = PlayerData.Daily.GetMonthAndDays()
  self.nYear = nYear
  self.nMonth = nMonth
  self.nIndex = PlayerData.Daily.GetDailyCheckInIndex()
  self.tbList = PlayerData.Daily.GetDailyCheckInList(nDays)
  self.nSelect = self.nIndex
  self.bReceived = self.mapReward == nil or self.mapReward.tbReward == nil or #self.mapReward.tbReward == 0
  if self.bReceived then
    PlayerData.Daily.SetManualPanel(true)
  else
    NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgRoot, false)
    NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgBlur, false)
  end
end

function DailyCheckInCtrl:OnEnable()
  self.tbGridCtrl = {}
  self._mapNode.blur:SetActive(true)
  self:Refresh()
end

function DailyCheckInCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function DailyCheckInCtrl:OnDestroy()
end

function DailyCheckInCtrl:OnBtnClick_Close(btn)
  if self.bReceived then
    PlayerData.Daily.SetManualPanel(false)
  end
  WwiseAudioMgr:PlaySound("ui_main_dailyPanel_close")
  self._mapNode.aniRoot:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
  self:AddTimer(1, 0.4, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.DailyCheckIn)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      if self.callback then
        self.callback()
      end
    end
    
    cs_coroutine.start(wait)
  end, true, true, true)
end

function DailyCheckInCtrl:OnBtnClick_Tips(btn)
  UTILS.ClickItemGridWithTips(self.tbList[self.nSelect].ItemId, btn.transform, true, true, false)
end

return DailyCheckInCtrl
