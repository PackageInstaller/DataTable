local SoldierSkillDisplayCtrl = class("SoldierSkillDisplayCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
SoldierSkillDisplayCtrl._mapNodeConfig = {
  rtSubSkill = {
    nCount = 3,
    sCtrlName = "Game.UI.Soldier.Battle.SoldierSkillDisplayItemCtrl"
  }
}
SoldierSkillDisplayCtrl._mapEventConfig = {
  SoldierSkillDisPlay = "OnEvent_SkillDisplay",
  InputEnable = "OnEvent_InputEnable"
}

function SoldierSkillDisplayCtrl:Awake()
  self.mapSkillDisplay = {}
end

function SoldierSkillDisplayCtrl:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    NovaAPI.ForceUpdateCanvases()
  end
  
  cs_coroutine.start(wait)
end

function SoldierSkillDisplayCtrl:OnDisable()
end

function SoldierSkillDisplayCtrl:OnDestroy()
end

function SoldierSkillDisplayCtrl:OnRelease()
end

function SoldierSkillDisplayCtrl:OnEvent_SkillDisplay(nCharId, nSkillId)
  local mapCharCfg = ConfigTable.GetData("SoldierCharacter", nCharId)
  local mapSkillCfg = ConfigTable.GetData("Skill", nSkillId)
  if mapCharCfg == nil or mapSkillCfg == nil then
    return
  end
  local bPlay = false
  for nIdx, skillCtrl in ipairs(self._mapNode.rtSubSkill) do
    if not skillCtrl.bPlaying then
      bPlay = true
      skillCtrl:ShowSkillTips(nSkillId, nCharId)
      return
    end
  end
  if not bPlay then
    local nIndex = 0
    local nTmpTime = 0
    for k, v in ipairs(self._mapNode.rtSubSkill) do
      if nTmpTime == 0 or nTmpTime > v.nPlayTime then
        nIndex = k
      end
    end
    if 0 < nIndex then
      self._mapNode.rtSubSkill[nIndex]:InterrputAnim()
      self._mapNode.rtSubSkill[nIndex]:ShowSkillTips(nSkillId, nCharId)
    end
  end
end

function SoldierSkillDisplayCtrl:OnEvent_InputEnable(bEnable)
  if not bEnable then
    self:InterrputAllDisplay()
  end
end

function SoldierSkillDisplayCtrl:InterrputAllDisplay()
  self._mapNode.rtSubSkill[1]:InterrputAnim()
  self._mapNode.rtSubSkill[2]:InterrputAnim()
  self._mapNode.rtSubSkill[3]:InterrputAnim()
end

return SoldierSkillDisplayCtrl
