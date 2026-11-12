local GoldenSpyTargetScoreCtrl = class("GoldenSpyTargetScoreCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
GoldenSpyTargetScoreCtrl._mapNodeConfig = {
  blur = {},
  animator = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  AnimRoot = {},
  UIParticle = {},
  btn_close = {
    sNodeName = "btn_TargetClose",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txt_ScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_Result_GoNextTarget1"
  },
  txt_Num = {sComponentName = "TMP_Text"},
  txt_Num2 = {sComponentName = "TMP_Text"}
}
GoldenSpyTargetScoreCtrl._mapEventConfig = {}
GoldenSpyTargetScoreCtrl._mapRedDotConfig = {}

function GoldenSpyTargetScoreCtrl:Awake()
end

function GoldenSpyTargetScoreCtrl:ShowPanel(nTargetScore, nCurScore)
  self.gameObject:SetActive(true)
  self._mapNode.AnimRoot:SetActive(false)
  self._mapNode.UIParticle:SetActive(false)
  self._mapNode.blur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.AnimRoot:SetActive(true)
    self._mapNode.UIParticle:SetActive(true)
  end
  
  cs_coroutine.start(wait)
  self._mapNode.animator:Play("open")
  self.tbGamepadUINode = {}
  GamepadUIManager.EnableGamepadUI("GoldenSpyTargetScoreCtrl", self.tbGamepadUINode)
  EventManager.Hit(EventId.TemporaryBlockInput, 1)
  NovaAPI.SetTMPText(self._mapNode.txt_Num, nTargetScore)
  NovaAPI.SetTMPText(self._mapNode.txt_Num2, ConfigTable.GetUIText("GoldenSpy_Result_GoNextTarget2") .. ":" .. nCurScore)
end

function GoldenSpyTargetScoreCtrl:OnBtnClick_Close()
  GamepadUIManager.DisableGamepadUI("GoldenSpyTargetScoreCtrl")
  self._mapNode.animator:Play("close")
  self:AddTimer(1, 0.15, function()
    self.gameObject:SetActive(false)
    EventManager.Hit("GoldenSpy_TargetScore_Close")
  end, true, true, true)
end

return GoldenSpyTargetScoreCtrl
