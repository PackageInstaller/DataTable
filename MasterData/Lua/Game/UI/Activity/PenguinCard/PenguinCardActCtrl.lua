local PenguinCardActCtrl = class("PenguinCardActCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
PenguinCardActCtrl._mapNodeConfig = {
  svItem = {
    sComponentName = "LoopScrollView"
  },
  txtTime = {sComponentName = "TMP_Text"},
  txtBtnDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Detail"
  },
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Activity_Goto"
  },
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtRewardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Reward"
  }
}
PenguinCardActCtrl._mapEventConfig = {}
PenguinCardActCtrl._mapRedDotConfig = {}

function PenguinCardActCtrl:Awake()
end

function PenguinCardActCtrl:RefreshRemainTime()
  if self.actData.actCfg.EndType == GameEnum.activityEndType.NoLimit then
    self._mapNode.txtTime.transform.parent.gameObject:SetActive(false)
  else
    local endTime = self.actData:GetActEndTime()
    local curTime = CS.ClientManager.Instance.serverTimeStamp
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
    end
    local sTimeStr = self:GetTimeText(remainTime)
    NovaAPI.SetTMPText(self._mapNode.txtTime, orderedFormat(ConfigTable.GetUIText("PerActivity_Remain_Time") or "", sTimeStr))
  end
end

function PenguinCardActCtrl:GetTimeText(remainTime)
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
  return sTimeStr
end

function PenguinCardActCtrl:InitItem()
  local mapCfg = ConfigTable.GetData("PenguinCardControl", self.nActId)
  if mapCfg == nil then
    return
  end
  local rewardData = mapCfg.RewardsShow
  self.tbReward = decodeJson(rewardData)
  self.tbItemIns = {}
  self._mapNode.svItem:Init(#self.tbReward, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function PenguinCardActCtrl:OnGridRefresh(go, nIndex)
  local nDataIndex = nIndex + 1
  local itemId = self.tbReward[nDataIndex]
  local goItem = go.transform:Find("btnGrid/AnimRoot/tcItem").gameObject
  local instanceId = goItem:GetInstanceID()
  if self.tbItemIns[instanceId] == nil then
    self.tbItemIns[instanceId] = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  self.tbItemIns[instanceId]:SetItem(itemId)
end

function PenguinCardActCtrl:OnGridBtnClick(go, nIndex)
  local nDataIndex = nIndex + 1
  local itemId = self.tbReward[nDataIndex]
  UTILS.ClickItemGridWithTips(itemId, go.transform:Find("btnGrid"), true, true, false)
end

function PenguinCardActCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self:RefreshRemainTime()
  if nil == self.remainTimer then
    self.remainTimer = self:AddTimer(0, 1, "RefreshRemainTime", true, true, false)
  end
  self:InitItem()
end

function PenguinCardActCtrl:ClearActivity()
  if self.tbItemIns ~= nil then
    for _, ctrl in pairs(self.tbItemIns) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.tbItemIns = {}
end

function PenguinCardActCtrl:OnBtnClick_Detail()
  local config = ConfigTable.GetData("PenguinCardControl", self.nActId)
  if config == nil then
    return
  end
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Desc,
    sContent = config.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  })
end

function PenguinCardActCtrl:OnBtnClick_Go()
  local bPlayCond = self.actData:CheckActJumpCond(true)
  if not bPlayCond then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.PenguinCardLevel, self.nActId)
end

return PenguinCardActCtrl
