_class("UIActivityN12Helper", Object)
UIActivityN12Helper = UIActivityN12Helper

function UIActivityN12Helper:Constructor()
end

function UIActivityN12Helper.GetEntrustNewKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  return "UIActivityN12Helper_Entrust_New_" .. roleModule:GetPstId()
end

function UIActivityN12Helper.EntrustHasNew(component)
  local key = UIActivityN12Helper.GetEntrustNewKey()
  local historyTime = 0
  if LocalDB.HasKey(key) then
    historyTime = LocalDB.GetFloat(key)
  end
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime()
  Log.info("UIActivityN12Helper.EntrustHasNew() key = ", key, " nowTime = ", nowTime, " historyTime = ", historyTime)
  local levels = component:GetAllLevelId()
  for _, levelId in ipairs(levels) do
    local openTime = component:GetStageOpenTime(levelId) * 1000
    if nowTime >= openTime and historyTime < openTime then
      Log.info("UIActivityN12Helper.EntrustHasNew() return true, levelId = ", levelId, " openTime = ", openTime)
      return true
    end
  end
  Log.info("UIActivityN12Helper.EntrustHasNew() return false")
  return false
end

function UIActivityN12Helper.EntrustClearNew()
  local key = UIActivityN12Helper.GetEntrustNewKey()
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime()
  Log.info("UIActivityN12Helper.EntrustClearNew() key = ", key, " nowTime = ", nowTime)
  LocalDB.SetFloat(key, nowTime)
end

function UIActivityN12Helper.N12_MapNode_Click(nodeid, levelId, component)
  local cfg_map_node = Cfg.cfg_campaign_entrust_event[nodeid]
  if not cfg_map_node then
    Log.error("###[UIActivityN12Helper] cfg_map_node is nil ! id --> ", nodeid)
  end
  local nodeType = cfg_map_node.EventType
  if nodeType == EntrustEventType.EntrustEventType_Box then
    UIActivityN12Helper.N12_MapNode_Box(nodeid, levelId, component)
  elseif nodeType == EntrustEventType.EntrustEventType_Story then
    UIActivityN12Helper.N12_MapNode_Story(nodeid, levelId, component)
  elseif nodeType == EntrustEventType.EntrustEventType_Fight then
    UIActivityN12Helper.N12_MapNode_Stage(nodeid, levelId, component)
  elseif nodeType == EntrustEventType.EntrustEventType_End then
    if component:GetBannerState() then
      component:SetBannerState(1)
      UIActivityN12Helper.N12_MapNode_Banner(nodeid, levelId, component)
    end
  elseif nodeType == EntrustEventType.EntrustEventType_MissionOccupy or nodeType == EntrustEventType.EntrustEventType_MissionSubmit then
    UIActivityN12Helper.N12_MapNode_Quest(nodeid, levelId, component)
  else
    Log.debug("###[UIActivityN12Helper] nodeType else ! type --> ", nodeType)
  end
end

function UIActivityN12Helper.N12_MapNode_Quest(nodeid, levelId, component)
  GameGlobal.UIStateManager():ShowDialog("UIN12MapQuestController", nodeid, levelId, component)
end

function UIActivityN12Helper.N12_MapNode_Over(nodeid, levelId, component)
  GameGlobal.UIStateManager():ShowDialog("UIN12MapExitsController", nodeid, levelId, component)
end

function UIActivityN12Helper.N12_MapNode_Banner(nodeid, levelId, component)
  GameGlobal.UIStateManager():ShowDialog("UIN12MapBannerController", nodeid, levelId, component)
end

function UIActivityN12Helper.N12_MapNode_Stage(nodeid, levelId, component)
  GameGlobal.UIStateManager():ShowDialog("UIN12MapStageController", nodeid, levelId, component)
end

function UIActivityN12Helper.N12_MapNode_Story(nodeid, levelId, component)
  GameGlobal.UIStateManager():ShowDialog("UIN12MapStoryController", nodeid, levelId, component)
end

function UIActivityN12Helper.N12_MapNode_Box(nodeid, levelId, component)
  GameGlobal.UIStateManager():ShowDialog("UIN12MapBoxController", nodeid, levelId, component)
end

function UIActivityN12Helper.GetMapNodeAnimationKey(nodeid)
  local roleModule = GameGlobal.GetModule(RoleModule)
  return "UIActivityN12Helper_MapNodeAnimation_" .. roleModule:GetPstId() .. "_" .. nodeid
end
