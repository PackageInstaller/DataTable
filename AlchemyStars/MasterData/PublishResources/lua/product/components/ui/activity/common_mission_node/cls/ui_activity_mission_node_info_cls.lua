_class("UIActivityMissionNodeInfo", Object)
UIActivityMissionNodeInfo = UIActivityMissionNodeInfo

function UIActivityMissionNodeInfo:Constructor()
  self.campaignMissionId = 0
  self.pos = Vector2.zero
  self.name = ""
  self.title = ""
  self.type = 0
  self.isSLevel = false
  self.state = nil
  self.starCount = 0
  self._missionModule = GameGlobal.GetModule(MissionModule)
end

function UIActivityMissionNodeInfo:Init(id, posX, posY, name, title, type, isSLevel, state, starCount)
  self.campaignMissionId = id
  self.pos.x = posX
  self.pos.y = posY
  self.name = name
  self.title = title
  self.type = type
  self.isSLevel = isSLevel
  self.state = state
  self.starCount = starCount
end

function UIActivityMissionNodeInfo:State()
  if self.stages then
    local passCount = 0
    local canActiveCount = 0
    for i, v in ipairs(self.stages) do
      if v.state == DiscoveryStageState.Nomal then
        passCount = passCount + 1
      elseif v.state == DiscoveryStageState.CanPlay then
        canActiveCount = canActiveCount + 1
      end
    end
    if 0 < passCount then
      return DiscoveryStageState.Nomal
    end
    if 0 < canActiveCount then
      return DiscoveryStageState.CanPlay
    end
  end
  return nil
end

function UIActivityMissionNodeInfo:IsFirstShow()
  local playerPrefsKey = self:GetFirstShowKey()
  local isFirst = UnityEngine.PlayerPrefs.GetInt(playerPrefsKey, 0)
  return isFirst == 0
end

function UIActivityMissionNodeInfo:SaveIsFirstShow()
  local playerPrefsKey = self:GetFirstShowKey()
  UnityEngine.PlayerPrefs.SetInt(playerPrefsKey, 1)
end

function UIActivityMissionNodeInfo:GetFirstShowKey()
  local playerPrefsKey = self:GetPstId() .. "UIActivityMissionNodeInfoIsFirstShow" .. self.id
  return playerPrefsKey
end

function UIActivityMissionNodeInfo:GetPstId()
  local roleModule = GameGlobal.GetModule(RoleModule)
  return roleModule:GetPstId()
end
