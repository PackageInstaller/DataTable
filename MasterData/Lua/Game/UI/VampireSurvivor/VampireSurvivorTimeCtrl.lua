local VampireSurvivorTimeCtrl = class("VamireSurvivorTimeCtrl", BaseCtrl)
VampireSurvivorTimeCtrl._mapNodeConfig = {
  rtnfo = {},
  rtChallengeTime = {},
  TMPChallengeTime = {sComponentName = "TMP_Text"},
  cgRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  }
}
VampireSurvivorTimeCtrl._mapEventConfig = {
  VampireSurvivor_Time = "SetTime",
  Vampire_Level_Times = "OnEvent_SetLevelProgress",
  Vampire_Boss_Spawn = "OnEvent_Boss_Spawn",
  VampireBattleEnd = "OnEvent_LevelEnd",
  InputEnable = "OnEvent_InputEnable"
}

function VampireSurvivorTimeCtrl:Awake()
  self._mapNode.rtnfo:SetActive(false)
  self._mapNode.rtChallengeTime:SetActive(false)
  self.bStart = false
  self.nTotlaTime = 0
  self:SetTime(0)
end

function VampireSurvivorTimeCtrl:SetTime(nTime)
  if not self.bStart then
    return
  end
  local nSubTime = self.nTotlaTime - nTime
  local nMin = math.floor(nSubTime / 60)
  local nSec = math.fmod(nSubTime, 60)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format("%02d:%02d", nMin, nSec))
end

function VampireSurvivorTimeCtrl:OnEvent_SetLevelProgress(nTime)
  self._mapNode.rtChallengeTime:SetActive(false)
  self.bStart = false
  self.nTotlaTime = nTime
end

function VampireSurvivorTimeCtrl:OnEvent_Boss_Spawn()
  local function waitTime()
    self._mapNode.rtChallengeTime:SetActive(true)
  end
  
  self.warningTimer = self:AddTimer(0, 4, waitTime, true, true, true)
  self.bStart = true
end

function VampireSurvivorTimeCtrl:OnEvent_LevelEnd()
  if self.warningTimer ~= nil then
    self.warningTimer:Cancel()
    self.warningTimer = nil
  end
  self._mapNode.rtChallengeTime:SetActive(false)
  self.bStart = false
end

function VampireSurvivorTimeCtrl:OnEvent_InputEnable(bEnable)
  print("VampireSurvivorTimeCtrl:OnEvent_InputEnable:" .. tostring(bEnable))
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgRoot, bEnable == true and 1 or 0)
end

return VampireSurvivorTimeCtrl
