local MathParkourPauseCtrl = class("MathParkourPauseCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
MathParkourPauseCtrl._mapNodeConfig = {
  blur = {},
  txt_title = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Text_Pause"
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
  txt_dic = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_DicTitle"
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
  btn_dic = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_OpenDic",
    sAction = "Depot"
  }
}
MathParkourPauseCtrl._mapEventConfig = {}
MathParkourPauseCtrl._mapRedDotConfig = {}

function MathParkourPauseCtrl:Awake()
end

function MathParkourPauseCtrl:Open(nDicId)
  self.nDicId = nDicId
  self.gameObject:SetActive(true)
  self._mapNode.btn_dic.gameObject:SetActive(0 < nDicId)
  self.tbGamepadUINode = self:GetGamepadUINode()
  GamepadUIManager.EnableGamepadUI("MathParkourPauseCtrl", self.tbGamepadUINode)
end

function MathParkourPauseCtrl:Close()
  GamepadUIManager.DisableGamepadUI("MathParkourPauseCtrl")
  self.gameObject:SetActive(false)
end

function MathParkourPauseCtrl:OnBtnClick_Exit()
  EventManager.Hit("MathParkour_Exit_OnClick")
end

function MathParkourPauseCtrl:OnBtnClick_Restart()
  EventManager.Hit("MathParkour_Restart_OnClick")
end

function MathParkourPauseCtrl:OnBtnClick_Continue()
  EventManager.Hit("MathParkour_Continue_OnClick")
end

function MathParkourPauseCtrl:OnBtnClick_OpenDic()
  if self.nDicId == 0 then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.nDicId, true)
end

return MathParkourPauseCtrl
