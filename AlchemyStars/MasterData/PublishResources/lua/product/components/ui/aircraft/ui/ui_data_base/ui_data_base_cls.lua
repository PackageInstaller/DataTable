local UITopRankAwardGotState = {
  DOING = 1,
  GET = 2,
  GOT = 3
}
_enum("UITopRankAwardGotState", UITopRankAwardGotState)
_class("DataBaseNodeData", Object)
DataBaseNodeData = DataBaseNodeData

function DataBaseNodeData:Constructor(id, lock, got, passInfoList)
  self._lock = lock
  local cfg_node = Cfg.cfg_tactical_db_theme[id]
  if not cfg_node then
    Log.error("###[DataBaseNodeData] cfg_node is nil ! id --> ", id)
  end
  self._award = RoleAsset:New()
  self._award.assetid = cfg_node.Award[1]
  self._award.count = cfg_node.Award[2]
  self._awardDesc = cfg_node.GetAwardDec
  self._got = got
  self._id = id
  self._icon = cfg_node.DetailIcon
  self._name = cfg_node.Name
  self._passInfoList = passInfoList
  self._dataInfos = {}
  local infoidlist = cfg_node.InfoIDList
  if not infoidlist then
    Log.error("###[DataBaseNodeData] infoidlist is nil !")
  end
  local cfg_infos = Cfg.cfg_tactical_db_info({})
  for i = 1, #infoidlist do
    local infoid = infoidlist[i]
    local cfg_info = cfg_infos[infoid]
    if not cfg_info then
      Log.error("###[DataBaseNodeData] cfg_info is nil ! id --> ", infoid)
    end
    local lock = self:GetInfoLock(infoid)
    local infoData = DataBaseNodeInfo:New(infoid, lock, self._lock)
    self._dataInfos[i] = infoData
  end
end

function DataBaseNodeData:GetInfoLock(infoid)
  return not table.icontains(self._passInfoList, infoid)
end

function DataBaseNodeData:GetLock()
  return self._lock
end

function DataBaseNodeData:GetAward()
  return self._award
end

function DataBaseNodeData:GetAwardDec()
  return self._awardDesc
end

function DataBaseNodeData:AwardGot()
  return self._got
end

function DataBaseNodeData:GotAward()
  self._got = true
end

function DataBaseNodeData:GetID()
  return self._id
end

function DataBaseNodeData:GetIcon()
  return self._icon
end

function DataBaseNodeData:GetName()
  return self._name
end

function DataBaseNodeData:GetDataInfos()
  return self._dataInfos
end

_class("DataBaseNodeInfo", Object)
DataBaseNodeInfo = DataBaseNodeInfo

function DataBaseNodeInfo:Constructor(id, lock, nodeLock)
  self._lock = lock
  self._nodeLock = nodeLock
  local cfg_info = Cfg.cfg_tactical_db_info[id]
  if not cfg_info then
    Log.error("###[DataBaseNodeInfo] cfg_info is nil ! id --> ", id)
  end
  self._id = id
  self._desc = cfg_info.InfoDec
  self._conditions = {}
  for i = 1, #cfg_info.UnlockItemList do
    local cfg = cfg_info.UnlockItemList[i]
    local info = {}
    info.id = cfg[1]
    info.count = cfg[2]
    local condition = DataBaseNodeInfoCondition:New(info)
    self._conditions[i] = condition
  end
end

function DataBaseNodeInfo:GetLock()
  return self._lock
end

function DataBaseNodeInfo:GetRed()
  local red = false
  if self._lock and not self._nodeLock then
    red = true
    local roleModule = GameGlobal.GetModule(RoleModule)
    for i = 1, #self._conditions do
      local condition = self._conditions[i]
      local id = condition:GetID()
      local count = condition:GetCount()
      local nowCount = roleModule:GetAssetCount(id)
      if count > nowCount then
        red = false
        break
      end
    end
  end
  return red
end

function DataBaseNodeInfo:GetID()
  return self._id
end

function DataBaseNodeInfo:GetConditions()
  return self._conditions
end

function DataBaseNodeInfo:GetDesc()
  return self._desc
end

function DataBaseNodeInfo:UnLock()
  self._lock = false
end

_class("DataBaseNodeInfoCondition", Object)
DataBaseNodeInfoCondition = DataBaseNodeInfoCondition

function DataBaseNodeInfoCondition:Constructor(condition)
  self._id = condition.id
  self._count = condition.count
end

function DataBaseNodeInfoCondition:GetID()
  return self._id
end

function DataBaseNodeInfoCondition:GetCount()
  return self._count
end
