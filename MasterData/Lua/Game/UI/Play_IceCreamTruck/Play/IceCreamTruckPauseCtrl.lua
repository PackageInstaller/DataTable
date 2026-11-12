local IceCreamTruckPauseCtrl = class("IceCreamTruckPauseCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
IceCreamTruckPauseCtrl._mapNodeConfig = {
  blur = {},
  txt_title = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_ThrowGifts_Text_Pause"
  },
  txt_exit = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Button_Leave"
  },
  txt_restart = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Button_Re"
  },
  txt_continue = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Button_Back"
  },
  btn_exit = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Exit",
    sAction = "Giveup"
  },
  btn_restart = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Restart",
    sAction = "Retry"
  },
  btn_continue = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Continue",
    sAction = "Back"
  },
  txt_SettleScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_CurrentScore"
  },
  txt_SettleScore = {sComponentName = "TMP_Text"},
  txt_FinishOrderTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_FinishOrder"
  },
  txt_SettleOrder = {sComponentName = "TMP_Text"},
  txt_MaxCombosTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_MaxCombos"
  },
  txt_MaxCombos = {sComponentName = "TMP_Text"},
  txt_MaxScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_HistoryMaxScore"
  },
  txt_MaxScore = {sComponentName = "TMP_Text"},
  txt_LevelName = {sComponentName = "TMP_Text"},
  btn_dic = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_OpenDic",
    sAction = "Depot"
  },
  txt_dic = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_DicTitle"
  },
  obj_MaScoreBg = {}
}
IceCreamTruckPauseCtrl._mapEventConfig = {}
IceCreamTruckPauseCtrl._mapRedDotConfig = {}

function IceCreamTruckPauseCtrl:Awake()
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function IceCreamTruckPauseCtrl:Open(levelName, nCurrentScore, nNumOrder, nMaxStreakCount, nMaxScore, bShowMaxScore, nDicId)
  self.gameObject:SetActive(true)
  EventManager.Hit("Event_SetPause", true)
  self:ShowPauseDetail(levelName, nCurrentScore, nNumOrder, nMaxStreakCount, nMaxScore, bShowMaxScore)
  GamepadUIManager.EnableGamepadUI("IceCreamTruckPauseCtrl", self.tbGamepadUINode)
  self.nDicId = nDicId
  self._mapNode.btn_dic.gameObject:SetActive(self.nDicId ~= 0)
end

function IceCreamTruckPauseCtrl:Close()
  self.gameObject:SetActive(false)
  EventManager.Hit("Event_SetPause", false)
  GamepadUIManager.DisableGamepadUI("IceCreamTruckPauseCtrl")
end

function IceCreamTruckPauseCtrl:ShowPauseDetail(levelName, nCurrentScore, nNumOrder, nMaxStreakCount, nMaxScore, bShowMaxScore)
  NovaAPI.SetTMPText(self._mapNode.txt_LevelName, levelName)
  NovaAPI.SetTMPText(self._mapNode.txt_SettleScore, nCurrentScore)
  NovaAPI.SetTMPText(self._mapNode.txt_SettleOrder, nNumOrder)
  NovaAPI.SetTMPText(self._mapNode.txt_MaxCombos, nMaxStreakCount)
  self._mapNode.obj_MaScoreBg:SetActive(bShowMaxScore)
  if bShowMaxScore then
    NovaAPI.SetTMPText(self._mapNode.txt_MaxScore, nMaxScore)
  end
end

function IceCreamTruckPauseCtrl:OnBtnClick_Exit()
  EventManager.Hit("IceCream_Exit_OnClick")
end

function IceCreamTruckPauseCtrl:OnBtnClick_Restart()
  EventManager.Hit("IceCream_Restart_OnClick")
end

function IceCreamTruckPauseCtrl:OnBtnClick_Continue()
  EventManager.Hit("IceCream_Continue_OnClick")
end

function IceCreamTruckPauseCtrl:OnBtnClick_OpenDic()
  if self.nDicId == 0 then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.nDicId, false)
end

return IceCreamTruckPauseCtrl
