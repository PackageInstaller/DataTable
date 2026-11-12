local TimerManager = require("GameCore.Timer.TimerManager")
local ClientManager = CS.ClientManager.Instance
local SoldierActCtrl = class("SoldierActCtrl", BaseCtrl)
SoldierActCtrl._mapNodeConfig = {
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Entrance"
  },
  txtBtnActDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_ActDesc"
  },
  btnActDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  imgTimeBg = {},
  txtTime = {sComponentName = "TMP_Text"},
  txtDate = {sComponentName = "TMP_Text"},
  imgLock = {},
  txtLock = {sComponentName = "TMP_Text"},
  txtAdvanceMat = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_RewardPre"
  },
  svItem = {
    sNodeName = "PreviewUpgradeMaterial",
    sComponentName = "LoopScrollView"
  }
}
SoldierActCtrl._mapEventConfig = {}
SoldierActCtrl._mapRedDotConfig = {}

function SoldierActCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = self.actData:GetActId()
  local bOpen = self.actData:CheckActShow()
  self._mapNode.btnGo.gameObject:SetActive(bOpen)
  self._mapNode.imgLock.gameObject:SetActive(not bOpen)
  if not bOpen then
    NovaAPI.SetTMPText(self._mapNode.txtLock, orderedFormat(ConfigTable.GetUIText("ActivityEnter_Lock"), self.actData.actCfg.LimitParam))
  end
  self:RefreshTimeout()
  if nil == self.remainTimer then
    self.remainTimer = self:AddTimer(0, 1, "RefreshTimeout", true, true, false)
  end
  self:InitItem()
  self:RefreshDate()
end

function SoldierActCtrl:InitItem()
  local config = ConfigTable.GetData("SoldierControl", self.nActId)
  if config == nil then
    return
  end
  local rewardData = config.RewardsShow
  self.tbReward = decodeJson(rewardData)
  self.tbItemIns = {}
  self._mapNode.svItem:Init(#self.tbReward, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function SoldierActCtrl:OnGridRefresh(go, nIndex)
  local nDataIndex = nIndex + 1
  local itemId = self.tbReward[nDataIndex]
  local goItem = go.transform:Find("AnimRoot/item").gameObject
  local instanceId = goItem:GetInstanceID()
  if self.tbItemIns[instanceId] == nil then
    self.tbItemIns[instanceId] = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  self.tbItemIns[instanceId]:SetItem(itemId)
end

function SoldierActCtrl:OnGridBtnClick(go, nIndex)
  local nDataIndex = nIndex + 1
  local itemId = self.tbReward[nDataIndex]
  UTILS.ClickItemGridWithTips(itemId, go.transform:Find("AnimRoot/item"), true, true, false)
end

function SoldierActCtrl:RefreshTimeout()
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
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  NovaAPI.SetTMPText(self._mapNode.txtLock, sTimeStr)
  NovaAPI.SetTMPText(self._mapNode.txtTime, sTimeStr)
end

function SoldierActCtrl:RefreshDate()
  local actCfg = ConfigTable.GetData("Activity", self.actData.nActId)
  local nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(actCfg.StartTime)
  local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(actCfg.EndTime)
  local nOpenYear = tonumber(os.date("%Y", nOpenTime))
  local nOpenMonth = tonumber(os.date("%m", nOpenTime))
  local nOpenDay = tonumber(os.date("%d", nOpenTime))
  local nEndYear = tonumber(os.date("%Y", nEndTime))
  local nEndMonth = tonumber(os.date("%m", nEndTime))
  local nEndDay = tonumber(os.date("%d", nEndTime))
  local strOpenDay = string.format("%d", nOpenDay)
  local strEndDay = string.format("%d", nEndDay)
  local dateStr = string.format("%s/%s/%s ~ %s/%s/%s", nOpenYear, nOpenMonth, strOpenDay, nEndYear, nEndMonth, strEndDay)
  NovaAPI.SetTMPText(self._mapNode.txtDate, dateStr)
end

function SoldierActCtrl:OnBtnClick_Go()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierMainViewPanel)
end

function SoldierActCtrl:OnBtnClick_Detail()
  local config = ConfigTable.GetData("SoldierControl", self.nActId)
  if config == nil then
    return
  end
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Desc,
    sContent = config.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  })
end

return SoldierActCtrl
