local IceCreamResultCtrl = class("IceCreamResultCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
IceCreamResultCtrl._mapNodeConfig = {
  txt_SettleScoreTitle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_CurrentScore"
  },
  txt_SettleScore = {nCount = 2, sComponentName = "TMP_Text"},
  txt_FinishOrderTitle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_FinishOrder"
  },
  txt_SettleOrder = {nCount = 2, sComponentName = "TMP_Text"},
  txt_MaxCombosTitle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_MaxCombos"
  },
  txt_MaxCombos = {nCount = 2, sComponentName = "TMP_Text"},
  txt_MaxScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_HistoryMaxScore"
  },
  txt_MaxScore = {sComponentName = "TMP_Text"},
  txt_SucceedTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_Succeed"
  },
  txt_FailTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_Fail"
  },
  obj_Succeed = {},
  obj_Fail = {},
  obj_MaScoreBg = {},
  btn_OutResult = {
    nCount = 2,
    sComponentName = "NaviButton",
    callback = "OnBtn_OutResult",
    sAction = "Retry"
  },
  btn_InRestart = {
    sComponentName = "NaviButton",
    callback = "OnBtn_InRestart",
    sAction = "Giveup"
  },
  btn_InNext = {
    sComponentName = "NaviButton",
    callback = "OnBtn_InNext",
    sAction = "Giveup"
  },
  txtBtnClose = {
    nCount = 4,
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_BtnEnd"
  },
  txtBtnNext = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_BtnNext"
  },
  txtBtnConfirm = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_BtnRestart"
  }
}

function IceCreamResultCtrl:Awake()
  self.tbGamepadUINode = self:GetGamepadUINode()
  self.animator = self.gameObject:GetComponent("Animator")
  self.canvasGroup = self.gameObject:GetComponent("CanvasGroup")
end

function IceCreamResultCtrl:FadeIn()
end

function IceCreamResultCtrl:FadeOut()
end

function IceCreamResultCtrl:OnEnable()
end

function IceCreamResultCtrl:OnDisable()
  EventManager.Hit("Event_SetPause", false)
  GamepadUIManager.DisableGamepadUI("IceCreamResultCtrl")
end

function IceCreamResultCtrl:OnDestroy()
end

function IceCreamResultCtrl:OnRelease()
end

function IceCreamResultCtrl:ShowResultPanel(bWin, nCurrentScore, nNumOrder, nMaxStreakCount, nMaxScore, bShowMaxScore, changeInfo, bNextTimeLock, nNextLevel)
  EventManager.Hit("Event_SetPause", true)
  GamepadUIManager.EnableGamepadUI("IceCreamResultCtrl", self.tbGamepadUINode)
  self.bWin = bWin
  NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 1)
  self.gameObject:SetActive(true)
  self._mapNode.obj_Succeed:SetActive(self.bWin)
  self._mapNode.obj_Fail:SetActive(not self.bWin)
  if self.bWin then
    NovaAPI.SetTMPText(self._mapNode.txt_SettleScore[1], nCurrentScore)
    NovaAPI.SetTMPText(self._mapNode.txt_SettleOrder[1], nNumOrder)
    NovaAPI.SetTMPText(self._mapNode.txt_MaxCombos[1], nMaxStreakCount)
  else
    NovaAPI.SetTMPText(self._mapNode.txt_SettleScore[2], nCurrentScore)
    NovaAPI.SetTMPText(self._mapNode.txt_SettleOrder[2], nNumOrder)
    NovaAPI.SetTMPText(self._mapNode.txt_MaxCombos[2], nMaxStreakCount)
  end
  self.nNextLevel = nNextLevel
  self._mapNode.obj_MaScoreBg:SetActive(bShowMaxScore)
  if bShowMaxScore then
    NovaAPI.SetTMPText(self._mapNode.txt_MaxScore, nMaxScore)
  end
  if self.bWin then
    self._mapNode.btn_InNext.gameObject:SetActive(not bNextTimeLock)
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  self:AddTimer(1, 1, function()
    if not self.gameObject or not changeInfo then
      return
    end
    local mapReward = PlayerData.Item:ProcessRewardChangeInfo(changeInfo.Change)
    local tbItem = {}
    for _, v in pairs(mapReward.tbReward) do
      local item = {
        Tid = v.id,
        Qty = v.count,
        rewardType = AllEnum.RewardType.First
      }
      table.insert(tbItem, item)
    end
    UTILS.OpenReceiveByDisplayItem(tbItem, changeInfo.Change)
  end, true, true, true)
end

function IceCreamResultCtrl:OnBtn_OutResult()
  GamepadUIManager.DisableGamepadUI("IceCreamTruckGameCtrl")
  self:CloseResultPanel()
  EventManager.Hit("Event_ExitIceCreamTruckGame")
end

function IceCreamResultCtrl:OnBtn_InRestart()
  self:CloseResultPanel()
  EventManager.Hit("Event_RestartIceCreamTruckGame")
end

function IceCreamResultCtrl:OnBtn_InNext()
  GamepadUIManager.DisableGamepadUI("IceCreamTruckGameCtrl")
  self:CloseResultPanel()
  if self.nNextLevel then
    EventManager.Hit("IceCream_NextLevel", self.nNextLevel)
  end
end

function IceCreamResultCtrl:CloseResultPanel()
  EventManager.Hit("Event_SetPause", false)
  NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 0)
  self.gameObject:SetActive(false)
  GamepadUIManager.DisableGamepadUI("IceCreamResultCtrl")
  PlayerData.Base:SetSkipNewDayWindow(false)
  PlayerData.Base:OnBackToMainMenuModule()
end

return IceCreamResultCtrl
