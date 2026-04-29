_class("HomeBuildingFatherArea", Object)
HomeBuildingFatherArea = HomeBuildingFatherArea

function HomeBuildingFatherArea:Constructor(areaTrans, fatherBuilding)
  self._trans = areaTrans
  local area = self._trans:GetComponent("HomeArea")
  if not area then
    BuildError(self._trans.gameObject.name .. "节点上没有HomeArea组件")
    return
  end
  self._id = tonumber(self._trans.gameObject.name)
  self._obstacleResMap = {}
  self._area = HomeBuildArea:New(area, self)
  self._area:ShowArea(false)
  self._fatherBuilding = fatherBuilding
  self._uncleanedHangPointList = {}
  self:InitHangPoints(self._trans:Find("HangPoint"))
  self._questIDHangpointIDMap = {}
  self._homelandTaskReceiveCallback = GameHelper:GetInstance():CreateCallback(self.RefreshTaskInfo, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.QuestUpdate, self._homelandTaskReceiveCallback)
end

function HomeBuildingFatherArea:Dispose()
  for _, req in pairs(self._obstacleResMap) do
    req:Dispose()
  end
  self._obstacleResMap = nil
  self._uncleanedHangPointList = nil
  self._questIDHangpointIDMap = nil
  if self._homelandTaskReceiveCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.QuestUpdate, self._homelandTaskReceiveCallback)
    self._homelandTaskReceiveCallback = nil
  end
end

function HomeBuildingFatherArea:RefreshTaskInfo()
  if not self._hangPointCfgID then
    self._hangPointCfgID = self:GetHangPointCfgID()
  end
  for questID, id in pairs(self._questIDHangpointIDMap) do
    local quest = GameGlobal.GetModule(QuestModule):GetQuest(questID)
    if quest and quest:Status() >= QuestStatus.QUEST_Completed then
      self._fatherBuilding:AddInteractPoint_UniqueIndex(self._fatherBuilding, id, self._hangPointCfgID)
    end
  end
end

function HomeBuildingFatherArea:GetID()
  return self._id
end

function HomeBuildingFatherArea:GetHomeArea()
  return self._area
end

function HomeBuildingFatherArea:GetObstacles()
  local list = {}
  for _, resReq in pairs(self._obstacleResMap) do
    list[#list + 1] = resReq.Obj
  end
  return list
end

function HomeBuildingFatherArea:InitHangPoints(hangPointTrans)
  if not hangPointTrans then
    return
  end
  local hangPointInfo
  local uiModule = GameGlobal.GetUIModule(HomelandModule)
  if uiModule:GetClient():IsVisit() then
    local info = uiModule:GetVisitInfo().father_arch_info.infos[self._fatherBuilding:GetBuildId()]
    if info then
      hangPointInfo = info.clean_hang_point
    else
      hangPointInfo = {}
    end
  else
    hangPointInfo = GameGlobal.GetModule(HomelandModule):GetHangPointInfo(self._fatherBuilding:GetBuildId())
  end
  for i = 1, hangPointTrans.childCount do
    local pointTrans = hangPointTrans:GetChild(i - 1)
    local hangPointID = tonumber(pointTrans.gameObject.name)
    self._fatherBuilding:RegisterInteractPoint(hangPointID, self)
    if not table.icontains(hangPointInfo, hangPointID) then
      self:SetHangPointObstacle(hangPointID, pointTrans:Find("obstacle"))
    end
  end
end

function HomeBuildingFatherArea:SetHangPointObstacle(id, trans)
  local cfg = Cfg.cfg_archeticture_hangpoint[id]
  if not cfg then
    BuildError("cfg_archeticture_hangpoint中不存在id为", id, "的配置，无法创建挂点障碍物")
    return
  end
  local req = ResourceManager:GetInstance():SyncLoadAsset(cfg.Res, LoadType.GameObject)
  if not req then
    BuildError("障碍物资源不存在:", cfg.Res)
    return
  end
  self._obstacleResMap[id] = req
  req.Obj:SetActive(true)
  req.Obj.transform:SetParent(trans, false)
end

function HomeBuildingFatherArea:RefreshInteractPoint()
  if not self._hangPointCfgID then
    self._hangPointCfgID = self:GetHangPointCfgID()
  end
  for id, _ in pairs(self._obstacleResMap) do
    local unlockQuestID = Cfg.cfg_archeticture_hangpoint[id].Unlock
    if not unlockQuestID then
      self._fatherBuilding:AddInteractPoint_UniqueIndex(self._fatherBuilding, id, self._hangPointCfgID)
    else
      local quest = GameGlobal.GetModule(QuestModule):GetQuest(unlockQuestID)
      if quest then
        if quest:Status() >= QuestStatus.QUEST_Completed then
          self._fatherBuilding:AddInteractPoint_UniqueIndex(self._fatherBuilding, id, self._hangPointCfgID)
        else
          self._questIDHangpointIDMap[quest:ID()] = id
        end
      end
    end
  end
end

function HomeBuildingFatherArea:RefreshObstacleUnlock()
  for k, v in pairs(self._obstacleResMap) do
    self:EnableObstacleUnlockInteractPoint(k, false)
    self:EnableObstacleUnlockModelNode(k, false)
  end
end

function HomeBuildingFatherArea:EnableObstacleUnlockInteractPoint(hangpointId, isEnable)
  local unlockInteract = Cfg.cfg_archeticture_hangpoint[hangpointId].UnlockInteract
  local count = 0
  if unlockInteract ~= nil then
    count = #unlockInteract
  end
  for i = 1, count do
    local interactId = unlockInteract[i]
    self._fatherBuilding:EnableInteractPointByCfgId(interactId, isEnable)
  end
end

function HomeBuildingFatherArea:EnableObstacleUnlockModelNode(hangpointId, isEnable)
  local unlockModelNode = Cfg.cfg_archeticture_hangpoint[hangpointId].UnlockModelNode
  local count = 0
  if unlockModelNode ~= nil then
    count = #unlockModelNode
  end
  for i = 1, count do
    local nodeName = unlockModelNode[i]
    local trNode = self._fatherBuilding:FindRecursively(nodeName)
    if trNode ~= nil then
      trNode.gameObject:SetActive(isEnable)
    end
  end
end

function HomeBuildingFatherArea:GetHangPointCfgID()
  local hangPointCfgList = Cfg.cfg_building_interact_point({
    FunctionType = InteractPointType.Clean
  })
  if not hangPointCfgList or #hangPointCfgList == 0 then
    return
  end
  local hangPointCfg = hangPointCfgList[1]
  return hangPointCfg.ID
end

function HomeBuildingFatherArea:GetInteractPosition(index)
  if self._interactpos == nil then
    self._interactpos = {}
  end
  if self._interactpos[index] == nil then
    local tran = self._trans:Find("HangPoint/" .. index .. "/Interact")
    if not tran then
      return
    end
    self._interactpos[index] = tran.position
  end
  return self._interactpos[index]
end

function HomeBuildingFatherArea:Clean(index)
  if self._obstacleResMap[index] then
    self._obstacleResMap[index]:Dispose()
    self._obstacleResMap[index] = nil
    local tb = table.reverse(self._questIDHangpointIDMap)
    if tb[index] then
      self._questIDHangpointIDMap[tb[index]] = nil
    end
    self:EnableObstacleUnlockInteractPoint(index, true)
    self:EnableObstacleUnlockModelNode(index, true)
  end
end

function HomeBuildingFatherArea:IsAllCleaned()
  if next(self._obstacleResMap) then
    return false
  else
    return true
  end
end

function HomeBuildingFatherArea:GetHangPointChildBuilingNodes(hangPointID)
  local res = {}
  local trans = self._trans:Find("HangPoint/" .. hangPointID)
  if trans then
    for i = 0, trans.childCount - 1 do
      local childTrans = trans:GetChild(i)
      local id = tonumber(childTrans.gameObject.name)
      if id then
        if res[id] then
          table.insert(res[id], childTrans)
        else
          res[id] = {childTrans}
        end
      end
    end
  end
  return res
end

function HomeBuildingFatherArea:GetFatherBuilding()
  return self._fatherBuilding
end
