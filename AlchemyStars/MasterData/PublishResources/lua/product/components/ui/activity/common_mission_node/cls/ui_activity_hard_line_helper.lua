_class("UIActivityHardLineHelper", Object)
UIActivityHardLineHelper = UIActivityHardLineHelper
local UIActivityHardLineNodeState = {
  Lock = 1,
  Open = 2,
  Pass = 3
}
_enum("UIActivityHardLineNodeState", UIActivityHardLineNodeState)

function UIActivityHardLineHelper.GetLineMissionCfgs(component)
  local componentCfgId = component:GetComponentCfgId()
  local missionCfgs = Cfg.cfg_component_line_mission({ComponentID = componentCfgId})
  return missionCfgs
end

function UIActivityHardLineHelper.GetMissionCfg(missionId)
  local cfg = Cfg.cfg_campaign_mission[missionId]
  if not cfg then
    Log.exception("cfg_campaign_mission 中找不到配置:", missionId)
    return
  end
  return cfg
end

function UIActivityHardLineHelper.GetClientCfgs(missionId)
  local cfg = Cfg.cfg_component_line_mission_client[missionId]
  if not cfg then
    Log.exception("cfg_component_line_mission_client 中找不到配置:", missionId)
    return
  end
  return cfg
end

function UIActivityHardLineHelper.GetMissionName(missionId)
  if not missionId or missionId == 0 then
    return ""
  end
  local cfg = UIActivityHardLineHelper.GetMissionCfg(missionId)
  local name = StringTable.Get(cfg.Name)
  return name
end

function UIActivityHardLineHelper.CheckNodeState(cfg, passInfo)
  local needId = cfg.NeedMissionId or 0
  local isOpen = needId == 0 or passInfo[needId] ~= nil
  local hasPass = passInfo[cfg.CampaignMissionId] ~= nil
  if not isOpen then
    return UIActivityHardLineNodeState.Lock
  elseif not hasPass then
    return UIActivityHardLineNodeState.Open
  else
    return UIActivityHardLineNodeState.Pass
  end
end

function UIActivityHardLineHelper.GetIconByState(missionId, state)
  local clientCfg = UIActivityHardLineHelper.GetClientCfgs(missionId)
  local tb = {
    [UIActivityHardLineNodeState.Lock] = clientCfg.CloseIcon,
    [UIActivityHardLineNodeState.Open] = clientCfg.Icon,
    [UIActivityHardLineNodeState.Pass] = clientCfg.CompleteIcon
  }
  return tb[state]
end
