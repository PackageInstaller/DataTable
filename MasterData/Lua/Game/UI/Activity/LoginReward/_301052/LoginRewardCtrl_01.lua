local LoginRewardCtrl_01 = class("LoginRewardCtrl_01", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
local ClientManager = CS.ClientManager.Instance
LoginRewardCtrl_01._mapNodeConfig = {
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Detail"
  },
  goActTime = {},
  txtActivityTime = {sComponentName = "TMP_Text"},
  sv = {
    sComponentName = "LoopScrollView"
  },
  btnActivity = {
    sComponentName = "Button",
    callback = "OnBtnClick_Activity"
  }
}
LoginRewardCtrl_01._mapEventConfig = {}

function LoginRewardCtrl_01:UnbindCtrl()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function LoginRewardCtrl_01:RefreshRemainTime()
  local endTime = self.actData:GetActEndTime()
  local curTime = ClientManager.serverTimeStamp
  local remainTime = endTime - curTime
  if remainTime < 0 then
    TimerManager.Remove(self.remainTimer)
    self.remainTimer = nil
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_1"),
      callbackConfirm = function()
        EventManager.Hit(EventId.ClosePanel, PanelId.ActivityList)
      end
    })
    return
  end
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  NovaAPI.SetTMPText(self._mapNode.txtActivityTime, sTimeStr)
end

function LoginRewardCtrl_01:RefreshRewardList()
  local tbRewardList = self.actData:GetActLoginRewardList()
  if nil ~= tbRewardList then
    local nMaxDay = #tbRewardList
    self.nReceiveDay = self.actData:GetCanReceive()
    self.nActual = self.actData:GetReceived()
    local canReceive = self.actData:CheckCanReceive()
    local nSelectIndex = 0
    if canReceive then
      nSelectIndex = self.actData:GetCanReceive()
    else
      nSelectIndex = self.nActual
    end
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
    self._mapNode.sv:SetAnim(0.06)
    self._mapNode.sv:Init(nMaxDay, self, self.OnGridRefresh, self.OnGridBtnClick)
    self._mapNode.sv:SetScrollGridPos(nSelectIndex - 2, 0)
  end
end

function LoginRewardCtrl_01:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local tbRewardList = self.actData:GetActLoginRewardList()
  local nMaxDay = #tbRewardList
  local mapReward = tbRewardList[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Activity.LoginReward.LoginRewardItemCtrl")
  end
  self.tbGridCtrl[nInstanceID]:SetRewardItem(nIndex, mapReward, nIndex == nMaxDay, self.nReceiveDay == self.nActual and nIndex == self.nActual + 1, "zs_activity_03_num_")
end

function LoginRewardCtrl_01:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local tbRewardList = self.actData:GetActLoginRewardList()
  local mapReward = tbRewardList[nIndex]
  local tbShowReward = {}
  if mapReward ~= nil then
    for i = 1, 3 do
      local nTid = mapReward["RewardId" .. i]
      local nCount = mapReward["Qty" .. i]
      if nTid ~= 0 then
        table.insert(tbShowReward, {nTid = nTid, nCount = nCount})
      end
    end
  end
  self._mapNode.sv:SetScrollGridPos(nIndex - 1, 0.1, 1)
  EventManager.Hit(EventId.BlockInput, true)
  self:AddTimer(1, 0.1, function()
    EventManager.Hit(EventId.BlockInput, false)
    local btn = goGrid.transform:Find("btnGrid/AnimRoot/goRewardItem/btnItem")
    if #tbShowReward == 1 then
      local nTid = tbShowReward[1].nTid
      UTILS.ClickItemGridWithTips(nTid, btn.gameObject.transform, true, true, false)
    else
      local tbReward = {}
      for _, v in ipairs(tbShowReward) do
        local rewardData = {
          [1] = v.nTid,
          [5] = v.nCount
        }
        table.insert(tbReward, rewardData)
      end
      EventManager.Hit("ShowActRewardList", tbReward)
    end
  end, true, true, true)
end

function LoginRewardCtrl_01:RefreshDetail()
  local mapActCfg = self.actData:GetLoginRewardControlCfg()
  local bEmpty = mapActCfg.DesText == ""
  self._mapNode.btnDetail.gameObject:SetActive(not bEmpty)
end

function LoginRewardCtrl_01:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self:RefreshRewardList()
  self:RefreshDetail()
  local canReceive = self.actData:CheckCanReceive()
  self._mapNode.btnActivity.gameObject:SetActive(canReceive)
  local actCfg = self.actData:GetActCfgData()
  if actCfg.EndType == GameEnum.activityEndType.NoLimit then
    self._mapNode.goActTime.gameObject:SetActive(false)
  else
    self._mapNode.goActTime.gameObject:SetActive(true)
    self:RefreshRemainTime()
    if nil == self.remainTimer then
      self.remainTimer = self:AddTimer(0, 1, "RefreshRemainTime", true, true, false)
    end
  end
end

function LoginRewardCtrl_01:ClearActivity()
  self:UnbindCtrl()
end

function LoginRewardCtrl_01:Awake()
  self.tbGridCtrl = {}
end

function LoginRewardCtrl_01:OnDisable()
  self:UnbindCtrl()
end

function LoginRewardCtrl_01:OnBtnClick_Detail()
  local mapActCfg = self.actData:GetLoginRewardControlCfg()
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = mapActCfg.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function LoginRewardCtrl_01:OnBtnClick_Activity()
  local function callback()
    self._mapNode.btnActivity.gameObject:SetActive(false)
    
    local actData = PlayerData.Activity:GetActivityDataById(self.actData:GetActId())
    self:InitActData(actData)
  end
  
  local canReceive = self.actData:CheckCanReceive()
  if not canReceive then
    callback()
    return
  end
  PlayerData.Activity:SendReceiveLoginRewardMsg(self.actData:GetActId(), callback)
end

return LoginRewardCtrl_01
