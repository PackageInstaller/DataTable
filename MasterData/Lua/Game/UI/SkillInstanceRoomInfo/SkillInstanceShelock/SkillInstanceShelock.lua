local SkillInstanceRoomInfoCtrl = class("SkillInstanceRoomInfoCtrl", BaseCtrl)
local colorWhite = Color(1, 1, 1, 1)
local colorRed = Color(0.8470588235294118, 0.3137254901960784, 0.32941176470588235)
SkillInstanceRoomInfoCtrl._mapNodeConfig = {
  BossHUDPanel = {
    sNodeName = "BossHUDPanel",
    sCtrlName = "Game.UI.SkillInstanceRoomInfo.SkillInstanceShelock.SkillInstanceShelockHpBar"
  },
  rtnfo = {},
  TMPTitle = {sComponentName = "TMP_Text"},
  TMPDesc = {sComponentName = "TMP_Text"},
  TMPChallengeTime = {sComponentName = "TMP_Text"},
  imgBoxIcon = {sComponentName = "Image"},
  rtChallengeTime = {},
  imgBoxIconMask = {sComponentName = "Image"}
}
SkillInstanceRoomInfoCtrl._mapEventConfig = {
  Equipment_Instance_Gameplay_TypeOne_UniqueID = "OnEvent_OpenHpBar"
}
local tbIconName = {
  [3] = "item_90101",
  [2] = "item_90102",
  [1] = "item_90103"
}

function SkillInstanceRoomInfoCtrl:Awake()
  self.rootAnim = self.gameObject:GetComponent("Animator")
end

function SkillInstanceRoomInfoCtrl:FadeIn()
end

function SkillInstanceRoomInfoCtrl:FadeOut()
end

function SkillInstanceRoomInfoCtrl:OnEnable()
  self._mapNode.imgBoxIconMask.gameObject:SetActive(true)
  self:SetPngSprite(self._mapNode.imgBoxIcon, "Icon/Item/" .. tbIconName[1])
  self:SetPngSprite(self._mapNode.imgBoxIconMask, "Icon/Item/" .. tbIconName[1])
end

function SkillInstanceRoomInfoCtrl:OnDisable()
end

function SkillInstanceRoomInfoCtrl:OnDestroy()
end

function SkillInstanceRoomInfoCtrl:OnRelease()
end

function SkillInstanceRoomInfoCtrl:OnStageChange(nCond)
  self.rootAnim:Play("DailyShelock_reward")
  
  local function Wait()
    self._mapNode.imgBoxIconMask.gameObject:SetActive(false)
    self:SetPngSprite(self._mapNode.imgBoxIcon, "Icon/Item/" .. tbIconName[nCond])
  end
  
  self:AddTimer(1, 1, Wait, true, true, nil, nil)
end

function SkillInstanceRoomInfoCtrl:StartEvent(nFloorId, nWaitTime, nLevelId)
  self.gameObject:SetActive(true)
  local mapFloorCfgData = ConfigTable.GetData("SkillInstanceFloor", nFloorId)
  local mapLevelCfgData = ConfigTable.GetData("SkillInstance", nLevelId)
  self.nBossDataId = mapFloorCfgData.monsterId
  self.nTotalTime = mapFloorCfgData.LevelTotalTime
  self._mapNode.BossHUDPanel:SetHpBarGrid(mapFloorCfgData.OneStarCondition, mapFloorCfgData.TwoStarCondition)
  self.cond1 = mapFloorCfgData.OneStarCondition
  self.cond2 = mapFloorCfgData.TwoStarCondition
  self.nState = 1
  self.bEnd = false
  self._mapNode.rtnfo:SetActive(false)
  self._mapNode.imgBoxIcon.gameObject:SetActive(true)
  self._mapNode.TMPDesc.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.TMPDesc, mapLevelCfgData.ThreeStarDesc)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, "00:00")
  NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  self._mapNode.BossHUDPanel.gameObject:SetActive(false)
  self._mapNode.rtChallengeTime:SetActive(false)
  EventManager.Add("Skill_Instance_Gameplay_Time", self, self.OnEvent_SpecialMode_Count)
  EventManager.Add("OnEvent_ShowRtChallengeTime", self, self.ShowRtChallengeTime)
  
  local function waitCallback()
    self._mapNode.rtnfo:SetActive(false)
    self._mapNode.TMPDesc.gameObject:SetActive(true)
    self._mapNode.BossHUDPanel.gameObject:SetActive(true)
  end
  
  self:AddTimer(1, nWaitTime, waitCallback, true, true, false)
end

function SkillInstanceRoomInfoCtrl:SetTime(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format("%02d:%02d", nMin, nSec))
end

function SkillInstanceRoomInfoCtrl:OnEvent_SpecialMode_Count(nTime)
  if self.nTotalTime - nTime <= 5 then
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorRed)
  else
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  end
  self:SetTime(self.nTotalTime - nTime)
end

function SkillInstanceRoomInfoCtrl:OnEvent_OpenHpBar(nEntityId)
  self._mapNode.BossHUDPanel:OpenUI(nEntityId, self.nBossDataId, self)
end

function SkillInstanceRoomInfoCtrl:ShowRtChallengeTime()
  self._mapNode.rtChallengeTime:SetActive(true)
end

function SkillInstanceRoomInfoCtrl:LevelEnd()
  self.bEnd = true
  self.gameObject:SetActive(false)
  EventManager.Remove("Skill_Instance_Gameplay_Time", self, self.OnEvent_SpecialMode_Count)
  EventManager.Remove("OnEvent_ShowRtChallengeTime", self, self.ShowRtChallengeTime)
end

return SkillInstanceRoomInfoCtrl
