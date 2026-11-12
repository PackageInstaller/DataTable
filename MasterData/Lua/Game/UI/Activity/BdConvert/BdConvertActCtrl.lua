local BdConvertActCtrl = class("BdConvertActCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local barMinX = -378
local barMaxX = 0
BdConvertActCtrl._mapNodeConfig = {
  txt_time = {sComponentName = "TMP_Text"},
  txt_des = {
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_DesTitle"
  },
  btn_des = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txt_quest = {
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_QuestTitle"
  },
  redDotQuest = {},
  btn_quest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  txt_mainProcess = {sComponentName = "TMP_Text"},
  imgMainBarFill = {
    sComponentName = "RectTransform"
  },
  txt_go = {
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_EnterActivity"
  },
  btn_go = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtRewardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_RewardPre"
  },
  svItem = {
    sComponentName = "LoopScrollView"
  },
  imgBgLevelSelect = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  }
}
BdConvertActCtrl._mapEventConfig = {BdConvertQuestUpdate = "InitQuest"}
BdConvertActCtrl._mapRedDotConfig = {
  [RedDotDefine.Activity_BdConvert_AllQuest] = {
    sNodeName = "redDotQuest"
  }
}

function BdConvertActCtrl:RefreshRemainTime()
  if self.actData.actCfg.EndType == GameEnum.activityEndType.NoLimit then
    self._mapNode.txt_time.transform.parent.gameObject:SetActive(false)
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
    NovaAPI.SetTMPText(self._mapNode.txt_time, orderedFormat(ConfigTable.GetUIText("PerActivity_Remain_Time") or "", sTimeStr))
  end
end

function BdConvertActCtrl:GetTimeText(remainTime)
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

function BdConvertActCtrl:InitItem()
  local rewardData = ConfigTable.GetData("BdConvertControl", self.nActId)
  if rewardData == nil then
    return
  end
  self.tbReward = rewardData.RewardsShow
  self.tbItemIns = {}
  self._mapNode.svItem:Init(#self.tbReward, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function BdConvertActCtrl:OnGridRefresh(go, nIndex)
  local nDataIndex = nIndex + 1
  local itemId = self.tbReward[nDataIndex]
  local goItem = go.transform:Find("btnGrid/AnimRoot/tcItem").gameObject
  local instanceId = goItem:GetInstanceID()
  if self.tbItemIns[instanceId] == nil then
    self.tbItemIns[instanceId] = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  self.tbItemIns[instanceId]:SetItem(itemId)
end

function BdConvertActCtrl:OnGridBtnClick(go, nIndex)
  local nDataIndex = nIndex + 1
  local itemId = self.tbReward[nDataIndex]
  UTILS.ClickItemGridWithTips(itemId, go.transform:Find("btnGrid"), true, true, false)
end

function BdConvertActCtrl:InitQuest()
  local allCount = self.actData:GetAllQuestCount()
  local receivedCount = self.actData:GetAllReceivedCount()
  NovaAPI.SetTMPText(self._mapNode.txt_mainProcess, receivedCount .. "/" .. allCount)
  self._mapNode.imgMainBarFill.anchoredPosition = Vector2(barMinX + (barMaxX - barMinX) * (receivedCount / allCount), self._mapNode.imgMainBarFill.anchoredPosition.y)
end

function BdConvertActCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self:RefreshRemainTime()
  if nil == self.remainTimer then
    self.remainTimer = self:AddTimer(0, 1, "RefreshRemainTime", true, true, false)
  end
  self:InitItem()
  self:InitQuest()
  local bUseL2D = LocalSettingData.mapData.UseLive2D
  self._mapNode.imgBgLevelSelect.transform.localScale = bUseL2D == true and Vector3.one or Vector3.zero
  self._mapNode.trActor2D_PNG.localScale = bUseL2D == true and Vector3.zero or Vector3.one
  if bUseL2D == true then
    Actor2DManager.SetBoardNPC2D(PanelId.BdConvertActPanel, self._mapNode.imgBgLevelSelect, 9102)
  else
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG, PanelId.BdConvertActPanel, 9102)
  end
end

function BdConvertActCtrl:ClearActivity()
  Actor2DManager.UnsetBoardNPC2D()
  if self.tbItemIns ~= nil then
    for _, ctrl in pairs(self.tbItemIns) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.tbItemIns = {}
end

function BdConvertActCtrl:OnBtnClick_Detail()
  local config = ConfigTable.GetData("BdConvertControl", self.nActId)
  if config == nil then
    return
  end
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Desc,
    sContent = config.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  })
end

function BdConvertActCtrl:OnBtnClick_Quest()
  EventManager.Hit(EventId.OpenPanel, PanelId.BdConvertQuestPanel, self.nActId)
end

function BdConvertActCtrl:OnBtnClick_Go()
  local bPlayCond = self.actData:CheckActJumpCond(true)
  if not bPlayCond then
    return
  end
  self.actData:RequestAllBuildData(function()
    EventManager.Hit(EventId.OpenPanel, PanelId.BdConvertPanel, self.nActId)
  end)
end

return BdConvertActCtrl
