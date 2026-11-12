local JointDrillTimeCtrl = class("JointDrillTimeCtrl", BaseCtrl)
JointDrillTimeCtrl._mapNodeConfig = {
  canvasGroup = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  rtnfo = {},
  rtChallengeTime = {},
  TMPChallengeTime = {sComponentName = "TMP_Text"},
  animatorTime = {
    sNodeName = "rtChallengeTime",
    sComponentName = "Animator"
  }
}
JointDrillTimeCtrl._mapEventConfig = {
  RefreshJointDrillGameTime = "SetTime",
  JointDrill_StartTiming = "OnEvent_BattleStart",
  JointDrill_BattleLvsToggle = "OnEvent_ChangeBattleLevel",
  RestartJointDrill = "OnEvent_Restart",
  VampireInstanceEnd = "OnEvent_LevelEnd",
  InputEnable = "OnEvent_InputEnable"
}
local colorWhite = Color(1, 1, 1, 1)
local colorRed = Color(0.8470588235294118, 0.3137254901960784, 0.32941176470588235)

function JointDrillTimeCtrl:Awake()
  self._mapNode.rtnfo:SetActive(false)
  self._mapNode.rtChallengeTime:SetActive(false)
  self.bStart = false
  self.nTotalTime = self._panel.nTotalTime
  self.nLastTime = 0
  self:ResetTimer()
end

function JointDrillTimeCtrl:ResetTimer()
  self.nLastTime = 0
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format("%02d:%02d:%03d", 0, 0, 0))
end

function JointDrillTimeCtrl:SetTime(nTime)
  if not self.bStart then
    return
  end
  nTime = self.nTotalTime * 1000 - nTime
  local nMin = math.floor(nTime / 60000)
  local nRemain = nTime % 60000
  local nSec = math.floor(nRemain / 1000)
  local nMs = nTime % 1000
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format("%02d:%02d:%03d", nMin, nSec, nMs))
  if self.nLastTime == 0 then
    self.nLastTime = nTime
  elseif nTime <= 15000 then
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorRed)
    if 1000 <= self.nLastTime - nTime then
      self._mapNode.animatorTime:Play("BossChallengeTime_show")
      self.nLastTime = nTime
    end
  else
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  end
end

function JointDrillTimeCtrl:OnEvent_BattleStart()
  self._mapNode.rtChallengeTime:SetActive(true)
  self.bStart = true
end

function JointDrillTimeCtrl:OnEvent_Restart()
  self._mapNode.rtChallengeTime:SetActive(false)
  self.bStart = false
  self:ResetTimer()
end

function JointDrillTimeCtrl:OnEvent_ChangeBattleLevel()
  self._mapNode.rtChallengeTime:SetActive(false)
  self.bStart = false
  self:ResetTimer()
end

function JointDrillTimeCtrl:OnEvent_LevelEnd()
  self._mapNode.rtChallengeTime:SetActive(false)
  self.bStart = false
end

function JointDrillTimeCtrl:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, bEnable == true)
end

return JointDrillTimeCtrl
