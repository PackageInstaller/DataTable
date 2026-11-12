local MonthlyCardCtrl = class("MonthlyCardCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local BoxBornTime = 0.9
local InTime = 0.7
local OutTime = 0.5
MonthlyCardCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  txtTime = {sComponentName = "TMP_Text"},
  txtClick = {
    sComponentName = "TMP_Text",
    sLanguageId = "MonthlyCard_Click"
  },
  Model = {
    sCtrlName = "Game.UI.MonthlyCard.MonthlyCardModelCtrl"
  },
  imgTitle = {}
}
MonthlyCardCtrl._mapEventConfig = {}

function MonthlyCardCtrl:Refresh()
  EventManager.Hit(EventId.TemporaryBlockInput, BoxBornTime + InTime)
  local tbStr = {}
  for i = 1, 2 do
    if self.tbMonthlyCard[i] ~= nil then
      ForEachTableLine(DataTable.MallMonthlyCard, function(mapData)
        if mapData.MonthlyCardId == self.tbMonthlyCard[i].nId then
          local str = mapData.Name2 .. orderedFormat(ConfigTable.GetUIText("MonthlyCard_RemainDay"), self.tbMonthlyCard[i].nRemaining)
          table.insert(tbStr, str)
        end
      end)
    end
  end
  local sStr = ""
  for i, v in ipairs(tbStr) do
    if i == #tbStr then
      sStr = sStr .. v
    else
      sStr = sStr .. v .. "\n"
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtTime, sStr)
  self._mapNode.txtTime.gameObject:SetActive(false)
  self._mapNode.txtClick.gameObject:SetActive(false)
  self._mapNode.imgTitle.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.Model:ShowRawImage()
    WwiseAudioMgr:PlaySound("ui_mall_monthlyCard_appear")
    self:PlayInAnim()
  end
  
  cs_coroutine.start(wait)
end

function MonthlyCardCtrl:PlayInAnim()
  local function func_in()
    self._mapNode.txtTime.gameObject:SetActive(true)
    
    self._mapNode.txtClick.gameObject:SetActive(true)
    self._mapNode.imgTitle.gameObject:SetActive(true)
    self._mapNode.aniRoot:SetTrigger("tIn")
  end
  
  self:AddTimer(1, 0.9, func_in, true, true, true)
end

function MonthlyCardCtrl:PlayOutAnim()
  self._mapNode.Model:PlayOpenAnim()
  self._mapNode.aniRoot:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, OutTime)
end

function MonthlyCardCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.callback = tbParam[2]
  end
  self.tbMonthlyCard = {}
  local tbTempMonthlyCard = {}
  tbTempMonthlyCard = PlayerData.Daily.GetTempMonthlyCardData() or {}
  for i, v in ipairs(tbTempMonthlyCard) do
    table.insert(self.tbMonthlyCard, v)
  end
  PlayerData.Daily.ClearTempMonthlyCardData()
  self.mapReward = {
    tbDst = {},
    tbReward = {},
    tbSpReward = {},
    tbSrc = {}
  }
  for _, v in ipairs(self.tbMonthlyCard) do
    if v.mapReward.tbDst ~= nil then
      for _, v in ipairs(v.mapReward.tbDst) do
        table.insert(self.mapReward.tbDst, v)
      end
    end
    if v.mapReward.tbReward ~= nil then
      for _, v in ipairs(v.mapReward.tbReward) do
        table.insert(self.mapReward.tbReward, v)
      end
    end
    if v.mapReward.tbSpReward ~= nil then
      for _, v in ipairs(v.mapReward.tbSpReward) do
        table.insert(self.mapReward.tbSpReward, v)
      end
    end
    if v.mapReward.tbSrc ~= nil then
      for _, v in ipairs(v.mapReward.tbSrc) do
        table.insert(self.mapReward.tbSrc, v)
      end
    end
  end
end

function MonthlyCardCtrl:OnEnable()
  self._mapNode.blur:SetActive(true)
  self:Refresh()
end

function MonthlyCardCtrl:OnDisable()
end

function MonthlyCardCtrl:OnDestroy()
end

function MonthlyCardCtrl:OnBtnClick_Close(btn)
  local function func_close_receive()
    EventManager.Hit(EventId.ClosePanel, PanelId.MonthlyCard)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      if self.callback then
        self.callback()
      end
    end
    
    cs_coroutine.start(wait)
  end
  
  WwiseAudioMgr:PlaySound("ui_mall_monthlyCard_open")
  self:PlayOutAnim()
  self:AddTimer(1, OutTime, function()
    UTILS.OpenReceiveByReward(self.mapReward, func_close_receive)
  end, true, true, true)
end

return MonthlyCardCtrl
