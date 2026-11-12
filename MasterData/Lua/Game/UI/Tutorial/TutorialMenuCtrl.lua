local TutorialMenuCtrl = class("TutorialMenuCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TutorialMenuCtrl._mapNodeConfig = {
  btnPause = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Pause"
  },
  btn_card = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_OpenCard",
    sAction = "Depot",
    sActionIconType = "Dark"
  },
  txt_dic = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_DicTitle"
  },
  canvasGroup = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  }
}
TutorialMenuCtrl._mapEventConfig = {
  [EventId.ClosePanel] = "OnEvent_CloseDic",
  Tutorial_OpenCard = "OnEvent_OpenDic",
  TutorialLevel_Success = "OnEvent_Success",
  InputEnable = "OnEvent_InputEnable"
}
TutorialMenuCtrl._mapRedDotConfig = {}

function TutorialMenuCtrl:Awake()
  self._mapNode.btn_card.gameObject:SetActive(false)
end

function TutorialMenuCtrl:OnEnable()
  GamepadUIManager.AddGamepadUINode("BattleMenu", self:GetGamepadUINode())
end

function TutorialMenuCtrl:OnDisable()
end

function TutorialMenuCtrl:OnDestroy()
end

function TutorialMenuCtrl:PauseLogic()
  EventManager.Hit("BattlePause")
  PanelManager.InputDisable()
end

function TutorialMenuCtrl:ResumeLogic()
  PanelManager.InputEnable()
end

function TutorialMenuCtrl:OpenDic()
  self:PauseLogic()
  local dicId = PlayerData.TutorialData:GetCurDicId()
  if dicId ~= 0 then
    EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, dicId, true)
  end
end

function TutorialMenuCtrl:OnBtnClick_Pause()
  EventManager.Hit("TutorialPause")
end

function TutorialMenuCtrl:OnBtnClick_OpenCard()
  self:OpenDic()
end

function TutorialMenuCtrl:OnEvent_OpenDic(cardId, bIsLevelStart)
  if bIsLevelStart then
    PanelManager.InputDisable()
    self:AddTimer(1, 0.8, function()
      PanelManager.InputEnable()
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self:OpenDic()
        self._mapNode.btn_card.gameObject:SetActive(true)
      end
      
      cs_coroutine.start(wait)
    end, true, true, true)
  else
    self:OpenDic()
    self._mapNode.btn_card.gameObject:SetActive(true)
  end
end

function TutorialMenuCtrl:OnEvent_CloseDic(panelId)
  if panelId == PanelId.DictionaryEntry then
    NovaAPI.DispatchEventWithData("Tutorial_CloseCard", nil, {})
    self:ResumeLogic()
  end
end

function TutorialMenuCtrl:OnEvent_Success()
  PlayerData.TutorialData:FinishLevel(true)
end

function TutorialMenuCtrl:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, bEnable == true)
end

return TutorialMenuCtrl
