local SkillDisplayCtrl = class("SkillDisplayCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
SkillDisplayCtrl._mapNodeConfig = {
  rtDisplay = {
    nCount = 2,
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.UltimateDisplayCtrl"
  },
  rtSubSkill = {
    nCount = 2,
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.SkillDisplayCtrl"
  }
}
SkillDisplayCtrl._mapEventConfig = {
  SoldierSkillDisPlay = "OnEvent_CastAssistSkill",
  [EventId.SubSkillDisplayInit] = "OnEvent_Init",
  InputEnable = "OnEvent_InputEnable"
}

function SkillDisplayCtrl:Awake()
end

function SkillDisplayCtrl:FadeIn()
end

function SkillDisplayCtrl:FadeOut()
end

function SkillDisplayCtrl:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    NovaAPI.ForceUpdateCanvases()
  end
  
  cs_coroutine.start(wait)
end

function SkillDisplayCtrl:OnDisable()
  for _, mapData in pairs(self.mapChar) do
    Actor2DManager.UnsetActor2D(false, mapData.Idx, true)
  end
end

function SkillDisplayCtrl:OnDestroy()
end

function SkillDisplayCtrl:OnRelease()
end

function SkillDisplayCtrl:OnEvent_Init(tbTeam)
  self.mapChar = {}
  if #tbTeam < 3 then
    printWarn("人数小于3")
    return
  end
  for i = 2, 3 do
    local charTid = tbTeam[i]
    if charTid ~= nil and charTid ~= 0 then
      local nSkillId = ConfigTable.GetData_Character(charTid).AssistSkillId
      self.mapChar[charTid] = {
        Idx = i,
        nSkillId = nSkillId,
        bPlaying = false,
        rtIdx = i - 1,
        nSkillShowIdx = 0
      }
    end
    self._mapNode.rtDisplay[i - 1]:InitL2dRes(charTid, i)
  end
end

function SkillDisplayCtrl:OnEvent_CastAssistSkill(nCharId)
  if self.mapChar[nCharId] ~= nil then
    local nSkillId = self.mapChar[nCharId].nSkillId
    local checkType = self:CheckPlayType(nCharId)
    if checkType == 0 then
      return
    elseif checkType == 1 then
      self:UltimateDisplay(nCharId)
    elseif checkType == 2 then
      self:SkillDisplay(nCharId, nSkillId)
    end
  end
end

function SkillDisplayCtrl:OnEvent_InputEnable(bEnable)
  if not bEnable then
    self:InterrputAllDisplay()
  end
end

function SkillDisplayCtrl:InterrputAllDisplay()
  self._mapNode.rtDisplay[1]:InterrputAnim()
  self._mapNode.rtDisplay[2]:InterrputAnim()
  self._mapNode.rtSubSkill[1]:InterrputAnim()
  self._mapNode.rtSubSkill[2]:InterrputAnim()
  for _, mapSkill in pairs(self.mapChar) do
    mapSkill.bPlaying = false
    mapSkill.nSkillShowIdx = 0
  end
end

function SkillDisplayCtrl:SkillDisplay(nCharId, nSkillId)
  local mapData = self.mapChar[nCharId]
  if mapData == nil then
    return
  end
  
  local function Callback()
    mapData.nSkillShowIdx = 0
  end
  
  if mapData.nSkillShowIdx == 0 then
    for nIdx, skillCtrl in ipairs(self._mapNode.rtSubSkill) do
      if not skillCtrl.bPlaying then
        skillCtrl:ShowSkillTips(nSkillId, nCharId, Callback)
        mapData.nSkillShowIdx = nIdx
        return
      end
    end
    printError("没有槽位播放技能展示")
  else
    self._mapNode.rtSubSkill[mapData.nSkillShowIdx]:ShowSkillTips(nSkillId, nCharId, Callback)
    WwiseAudioMgr:PostEvent("ui_tip_feadback")
  end
end

function SkillDisplayCtrl:UltimateDisplay(nCharId)
  local mapData = self.mapChar[nCharId]
  if mapData == nil then
    return
  end
  
  local function Callback()
    mapData.bPlaying = false
  end
  
  if mapData.bPlaying then
    self._mapNode.rtDisplay[mapData.rtIdx]:ReShowSkill(Callback, mapData.Idx)
  else
    self._mapNode.rtDisplay[mapData.rtIdx]:ShowSkill(nCharId, mapData.Idx, Callback)
    mapData.bPlaying = true
  end
  self._mapNode.rtDisplay[mapData.rtIdx % 2 + 1]:Set2SecondSkill()
end

function SkillDisplayCtrl:CheckPlayType(nCharId)
  local bForce = self:CheckForcePlay()
  local nType = LocalSettingData.GetLocalSettingData("AnimationSub")
  if bForce then
    nType = 2
  end
  if nType == 3 then
    return 2
  elseif nType == 2 then
    if self.mapCharShow[nCharId] == nil then
      self.mapCharShow[nCharId] = true
      self:SetLocalData()
    end
    return 1
  elseif nType == 1 then
    if self.mapCharShow[nCharId] == nil then
      self.mapCharShow[nCharId] = true
      self:SetLocalData()
      return 1
    else
      return 2
    end
  end
end

function SkillDisplayCtrl:SetLocalData()
  local jsonData = {}
  for nCharId, _ in pairs(self.mapCharShow) do
    table.insert(jsonData, nCharId)
  end
  local sJson = RapidJson.encode(jsonData)
  LocalData.SetPlayerLocalData("SkillShowCount", sJson)
  return 1
end

function SkillDisplayCtrl:CheckForcePlay()
  local tbDynamic = {
    [GameEnum.dynamicLevelType.Trial] = true
  }
  local tbBattle = {}
  return tbDynamic[self._panel.DynamicType] or tbBattle[self._panel.BattleType]
end

return SkillDisplayCtrl
