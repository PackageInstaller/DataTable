local TDRoomInfoCtrl = class("TDRoomInfoCtrl", BaseCtrl)
local colorWhite = Color(1, 1, 1, 1)
local colorRed = Color(0.8470588235294118, 0.3137254901960784, 0.32941176470588235)
TDRoomInfoCtrl._mapNodeConfig = {
  TMPChallengeTime = {sComponentName = "TMP_Text"},
  rtChallengeTime = {},
  animatorTime = {
    sNodeName = "rtChallengeTime",
    sComponentName = "Animator"
  },
  canvasGroup = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  }
}
TDRoomInfoCtrl._mapEventConfig = {
  TravelerDuel_StartTime = "StartEvent",
  TravelerDuel_Result = "EndEvent",
  InputEnable = "OnEvent_InputEnable"
}

function TDRoomInfoCtrl:Awake()
  self.AnimatorRoot = self.gameObject:GetComponent("Animator")
end

function TDRoomInfoCtrl:FadeIn()
end

function TDRoomInfoCtrl:FadeOut()
end

function TDRoomInfoCtrl:OnEnable()
  self._mapNode.rtChallengeTime:SetActive(false)
end

function TDRoomInfoCtrl:OnDisable()
end

function TDRoomInfoCtrl:OnDestroy()
  EventManager.Remove("TravelerDuel_Time_CountUp", self, self.OnEvent_SpecialMode_Count)
  EventManager.Remove("OnEvent_ShowRtChallengeTime", self, self.ShowRtChallengeTime)
end

function TDRoomInfoCtrl:OnRelease()
end

function TDRoomInfoCtrl:SetTime(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format("%02d:%02d", nMin, nSec))
end

function TDRoomInfoCtrl:StartEvent(nTime)
  NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  self:SetTime(nTime)
  EventManager.Add("TravelerDuel_Time_CountUp", self, self.OnEvent_SpecialMode_Count)
  EventManager.Add("OnEvent_ShowRtChallengeTime", self, self.ShowRtChallengeTime)
end

function TDRoomInfoCtrl:EndEvent()
  EventManager.Remove("TravelerDuel_Time_CountUp", self, self.OnEvent_SpecialMode_Count)
  EventManager.Remove("OnEvent_ShowRtChallengeTime", self, self.ShowRtChallengeTime)
  self._mapNode.rtChallengeTime:SetActive(false)
end

function TDRoomInfoCtrl:OnEvent_SpecialMode_Count(nTime)
  if nTime <= 5 then
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorRed)
    self._mapNode.animatorTime:Play("BossChallengeTime_show")
  else
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  end
  self:SetTime(nTime)
end

function TDRoomInfoCtrl:ShowRtChallengeTime()
  self._mapNode.rtChallengeTime:SetActive(true)
end

function TDRoomInfoCtrl:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bEnable == true and 1 or 0)
end

return TDRoomInfoCtrl
