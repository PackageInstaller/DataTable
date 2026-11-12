local CookieActCtrl = class("CookieActCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
local ClientManager = CS.ClientManager.Instance
CookieActCtrl._mapNodeConfig = {
  btnEnter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Enter"
  },
  txtBtnEnter = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Btn_Go"
  },
  btnActDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ActDetail"
  },
  txtBtnActDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Detail"
  },
  txtLabelPreview = {
    sComponentName = "TMP_Text",
    sLanguageId = "Daily_Quest_Reward_Tip_Title"
  },
  txtRemainTime = {sComponentName = "TMP_Text"},
  txtActTime = {sComponentName = "TMP_Text"},
  svItem = {
    sComponentName = "LoopScrollView"
  }
}

function CookieActCtrl:InitActData(actData)
  self.actData = actData
  self:RefreshTimeout()
  self.mapActCtrl = ConfigTable.GetData("CookieControl", self.actData:GetActId())
  if self.mapActCtrl ~= nil then
    local rewardData = self.mapActCtrl.RewardsShow
    local tbReward = decodeJson(rewardData)
    self.tbPreviewItem = tbReward
  end
  self._mapNode.svItem:Init(#self.tbPreviewItem, self, self.OnGridRefresh, self.OnGridBtnClick)
  local nStartTime = self.actData:GetActOpenTime() or 0
  local nEndTime = self.actData:GetActEndTime() or 0
  local sStartTime = os.date("%m.%d", nStartTime)
  local sEndTime = os.date("%m.%d", nEndTime)
  NovaAPI.SetTMPText(self._mapNode.txtActTime, sStartTime .. " - " .. sEndTime)
end

function CookieActCtrl:OnGridRefresh(go, nIndex)
  local nDataIndex = nIndex + 1
  local itemData = self.tbPreviewItem[nDataIndex]
  if itemData == nil then
    return
  end
  local goItem = go.transform:Find("btnGrid/AnimRoot/tcItem").gameObject
  if goItem == nil then
    return
  end
  local itemCtrl = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
  if itemCtrl ~= nil then
    itemCtrl:SetItem(itemData)
  end
end

function CookieActCtrl:OnGridBtnClick(go, nIndex)
  local nDataIndex = nIndex + 1
  local itemData = self.tbPreviewItem[nDataIndex]
  if itemData == nil then
    return
  end
  UTILS.ClickItemGridWithTips(itemData[1], go.transform, true, false, false)
end

function CookieActCtrl:UnInit()
end

function CookieActCtrl:RefreshTimeout()
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
    sTimeStr = string.format(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = string.format(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = string.format(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  NovaAPI.SetTMPText(self._mapNode.txtRemainTime, sTimeStr)
end

function CookieActCtrl:OnBtnClick_Enter(...)
  local nRandom = math.random(28, 29)
  local nActId = self.actData:GetActId()
  
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.CookieGamePanel_400004, nActId)
  end
  
  EventManager.Hit(EventId.SetTransition, nRandom, func)
end

function CookieActCtrl:OnBtnClick_ActDetail(...)
  if self.mapActCtrl == nil then
    return
  end
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = self.mapActCtrl.DetailDesc,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function CookieActCtrl:ClearActivity()
end

return CookieActCtrl
