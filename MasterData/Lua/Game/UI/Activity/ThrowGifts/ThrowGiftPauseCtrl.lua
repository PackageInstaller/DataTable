local ThrowGiftPauseCtrl = class("ThrowGiftPauseCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
ThrowGiftPauseCtrl._mapNodeConfig = {
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
    sAction = "Giveup",
    sActionIconType = "Dark"
  },
  btn_restart = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Restart",
    sAction = "Retry",
    sActionIconType = "Dark"
  },
  btn_continue = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Continue",
    sAction = "Back",
    sActionIconType = "Dark"
  },
  txt_dic = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_DicTitle"
  },
  btn_dic = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Dic",
    sAction = "Depot",
    sActionIconType = "Dark"
  }
}
ThrowGiftPauseCtrl._mapEventConfig = {}
ThrowGiftPauseCtrl._mapRedDotConfig = {}

function ThrowGiftPauseCtrl:Awake()
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function ThrowGiftPauseCtrl:Open(DictionaryID)
  self.gameObject:SetActive(true)
  self.DictionaryID = DictionaryID
  self._mapNode.btn_dic.gameObject:SetActive(self.DictionaryID > 0)
  GamepadUIManager.EnableGamepadUI("ThrowGiftPauseCtrl", self.tbGamepadUINode)
end

function ThrowGiftPauseCtrl:Close()
  GamepadUIManager.DisableGamepadUI("ThrowGiftPauseCtrl")
  self.gameObject:SetActive(false)
end

function ThrowGiftPauseCtrl:OnBtnClick_Exit()
  EventManager.Hit("ThrowGift_Exit_OnClick")
end

function ThrowGiftPauseCtrl:OnBtnClick_Restart()
  EventManager.Hit("ThrowGift_Restart_OnClick")
end

function ThrowGiftPauseCtrl:OnBtnClick_Continue()
  EventManager.Hit("ThrowGift_Continue_OnClick")
end

function ThrowGiftPauseCtrl:OnBtnClick_Dic()
  if self.DictionaryID > 0 then
    EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.DictionaryID, true)
  end
end

return ThrowGiftPauseCtrl
