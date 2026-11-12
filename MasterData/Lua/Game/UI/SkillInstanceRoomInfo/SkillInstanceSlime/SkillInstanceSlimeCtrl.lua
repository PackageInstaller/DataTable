local SkillInstanceSlimeCtrl = class("SkillInstanceSlimeCtrl", BaseCtrl)
local colorWhite = Color(1, 1, 1, 1)
local colorRed = Color(0.8470588235294118, 0.3137254901960784, 0.32941176470588235)
SkillInstanceSlimeCtrl._mapNodeConfig = {
  rtnfo = {},
  TMPDesc = {sComponentName = "TMP_Text"},
  TMPChallengeTime = {sComponentName = "TMP_Text"},
  imgBoxIcon = {sComponentName = "Image"},
  imgBoxIconMask = {sComponentName = "Image"},
  TMPKillCountTarget = {sComponentName = "TMP_Text"},
  TMPKillCountCur = {sComponentName = "TMP_Text"},
  TMPKillTitle = {sComponentName = "TMP_Text"},
  rtKillCount = {},
  rtChallengeTime = {}
}
SkillInstanceSlimeCtrl._mapEventConfig = {}
local tbIconName = {
  [3] = "item_90101",
  [2] = "item_90102",
  [1] = "item_90103"
}

function SkillInstanceSlimeCtrl:Awake()
  self.rootAnim = self.gameObject:GetComponent("Animator")
  self.rootAnimNumber = self._mapNode.rtKillCount.gameObject:GetComponent("Animator")
end

function SkillInstanceSlimeCtrl:FadeIn()
end

function SkillInstanceSlimeCtrl:FadeOut()
end

function SkillInstanceSlimeCtrl:OnEnable()
  self._mapNode.imgBoxIconMask.gameObject:SetActive(true)
  self:SetPngSprite(self._mapNode.imgBoxIcon, "Icon/Item/" .. tbIconName[1])
  self:SetPngSprite(self._mapNode.imgBoxIconMask, "Icon/Item/" .. tbIconName[1])
end

function SkillInstanceSlimeCtrl:OnDisable()
end

function SkillInstanceSlimeCtrl:OnDestroy()
end

function SkillInstanceSlimeCtrl:OnRelease()
end

function SkillInstanceSlimeCtrl:SetNumber()
  if self.nShowCount >= self.nCurCount then
    return
  end
  if self.isNumberPlaying == true then
    return
  end
  self.nShowCount = self.nCurCount
  
  local function wait()
    self.isNumberPlaying = false
    if self.nShowCount < self.nCurCount then
      self:SetNumber()
    end
  end
  
  self.isNumberPlaying = true
  if self.nShowCount == self.cond3 then
    self.rootAnimNumber:Play("rtKillCount_up")
  else
    self.rootAnimNumber:Play("rtKillCount_full")
  end
  NovaAPI.SetTMPText(self._mapNode.TMPKillCountCur, self.nShowCount)
  self:AddTimer(1, 0.27, wait, true, true, nil, nil)
end

function SkillInstanceSlimeCtrl:StartEvent(nFloorId, nWaitTime, nLevelId)
  self.gameObject:SetActive(true)
  local mapFloorCfgData = ConfigTable.GetData("SkillInstanceFloor", nFloorId)
  local mapLevelCfgData = ConfigTable.GetData("SkillInstance", nLevelId)
  self.nMonsterId = mapFloorCfgData.monsterId
  self.nTotalTime = mapFloorCfgData.LevelTotalTime
  self.cond1 = mapFloorCfgData.OneStarCondition
  self.cond2 = mapFloorCfgData.TwoStarCondition
  self.cond3 = mapFloorCfgData.ThreeStarCondition
  self.bEnd = false
  self.nCurCount = 0
  self.nShowCount = 0
  self._mapNode.rtnfo:SetActive(false)
  self._mapNode.imgBoxIcon.gameObject:SetActive(true)
  self._mapNode.TMPDesc.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.TMPDesc, mapLevelCfgData.ThreeStarDesc)
  NovaAPI.SetTMPText(self._mapNode.TMPKillCountTarget, string.format("/%d", self.cond1))
  NovaAPI.SetTMPText(self._mapNode.TMPKillTitle, orderedFormat(ConfigTable.GetUIText("DailyInstance_Kill_Title"), 1))
  NovaAPI.SetTMPText(self._mapNode.TMPKillCountCur, self.nCurCount)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, "00:00")
  NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  self._mapNode.rtKillCount:SetActive(false)
  self._mapNode.rtChallengeTime:SetActive(false)
  EventManager.Add("Skill_Instance_Gameplay_Time", self, self.OnEvent_SpecialMode_Count)
  EventManager.Add("ADVENTURE_BATTLE_MONSTER_DIED", self, self.OnEvent_MonsterDied)
  EventManager.Add("OnEvent_ShowRtChallengeTime", self, self.ShowRtChallengeTime)
  
  local function waitCallback()
    self._mapNode.rtnfo:SetActive(false)
    self._mapNode.TMPDesc.gameObject:SetActive(true)
    self._mapNode.rtKillCount:SetActive(true)
  end
  
  self:AddTimer(1, nWaitTime, waitCallback, true, true, false)
end

function SkillInstanceSlimeCtrl:SetTime(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format("%02d:%02d", nMin, nSec))
end

function SkillInstanceSlimeCtrl:OnEvent_SpecialMode_Count(nTime)
  if self.nTotalTime - nTime <= 5 then
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorRed)
  else
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  end
  self:SetTime(self.nTotalTime - nTime)
end

function SkillInstanceSlimeCtrl:OnEvent_MonsterDied(nMonsterId)
  if nMonsterId == self.nMonsterId then
    local function Wait(_, _, nCond)
      self._mapNode.imgBoxIconMask.gameObject:SetActive(false)
      
      self:SetPngSprite(self._mapNode.imgBoxIcon, "Icon/Item/" .. tbIconName[nCond])
    end
    
    if self.bEnd then
      return
    end
    self.nCurCount = self.nCurCount + 1
    if self.nCurCount >= self.cond3 then
      self.bEnd = true
      self.nCurCount = self.cond3
      self.rootAnim:Play("DailySlime_reward")
      self:AddTimer(1, 0.5, Wait, true, true, nil, 3)
    elseif self.nCurCount == self.cond2 then
      NovaAPI.SetTMPText(self._mapNode.TMPKillCountTarget, string.format("/%d", self.cond3))
      NovaAPI.SetTMPText(self._mapNode.TMPKillTitle, orderedFormat(ConfigTable.GetUIText("DailyInstance_Kill_Title"), 3))
      self.rootAnim:Play("DailySlime_reward")
      self:AddTimer(1, 0.5, Wait, true, true, nil, 2)
    elseif self.nCurCount == self.cond1 then
      NovaAPI.SetTMPText(self._mapNode.TMPKillCountTarget, string.format("/%d", self.cond2))
      NovaAPI.SetTMPText(self._mapNode.TMPKillTitle, orderedFormat(ConfigTable.GetUIText("DailyInstance_Kill_Title"), 2))
      self.rootAnim:Play("DailySlime_reward")
      self:AddTimer(1, 0.5, Wait, true, true, nil, 1)
    end
    self:SetNumber()
  end
end

function SkillInstanceSlimeCtrl:ShowRtChallengeTime()
  self._mapNode.rtChallengeTime:SetActive(true)
end

function SkillInstanceSlimeCtrl:LevelEnd()
  self._mapNode.rtnfo:SetActive(false)
  self._mapNode.rtKillCount:SetActive(false)
  self._mapNode.rtChallengeTime:SetActive(false)
  EventManager.Remove("Skill_Instance_Gameplay_Time", self, self.OnEvent_SpecialMode_Count)
  EventManager.Remove("ADVENTURE_BATTLE_MONSTER_DIED", self, self.OnEvent_MonsterDied)
  EventManager.Remove("OnEvent_ShowRtChallengeTime", self, self.ShowRtChallengeTime)
end

return SkillInstanceSlimeCtrl
