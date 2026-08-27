local BuildingNetworkCtrl = class("BuildingNetworkCtrl", NetworkCtrlBase)
local BuildingData = require("Game.Oasis.Data.OasisBuildingData")
local BuildingDynData = require("Game.Oasis.Data.OasisBuildingDynData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local NoticeData = require("Game.Notice.NoticeData")
local JumpManager = require("Game.Jump.JumpManager")
local BuildingEnum = require("Game.Oasis.Data.BuildingEnum")
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local LastSendType = {
  BuildingConstruct = 1,
  BuildingUpgrade = 2,
  BuildingMove = 3,
  BuildingCancel = 4,
  BuildingConfirmOver = 5,
  BuildingAccelerate = 6
}
local HomeEnum = require("Game.Home.HomeEnum")

function BuildingNetworkCtrl:ctor()
  self.lastSendDataList = {}
  self._areaUnlockTab = {}
end

function BuildingNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_Detail, self, proto_csmsg.SC_BUILDING_Detail, self.OnRecvBuildingDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_Construct, self, proto_csmsg.SC_BUILDING_Construct, self.OnRecvBuildingConstruct)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_SyncUpdateDiff, self, proto_csmsg.SC_BUILDING_SyncUpdateDiff, self.OnRecvBuildingSyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_Upgrade, self, proto_csmsg.SC_BUILDING_Upgrade, self.OnRecvBuildingUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_Move, self, proto_csmsg.SC_BUILDING_Move, self.OnRecvBuildingMove)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_Collect, self, proto_csmsg.SC_BUILDING_Collect, self.OnRecvBuildingCollect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_CollectGroup, self, proto_csmsg.SC_BUILDING_CollectGroup, self.OnRecvBuildingCollectGroup)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_Cancel, self, proto_csmsg.SC_BUILDING_Cancel, self.OnRecvBuildingCancel)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_ConfirmOver, self, proto_csmsg.SC_BUILDING_ConfirmOver, self.OnRecvBuildingConfirmOver)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDIN_Accelerate, self, proto_csmsg.SC_BUILDIN_Accelerate, self.OnRecvBuildingAccelerate)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDIN_AreaUnlock, self, proto_csmsg.SC_BUILDIN_AreaUnlock, self.SC_BUILDIN_AreaUnlock)
end

function BuildingNetworkCtrl:SendBuildingDetail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Detail, proto_csmsg.CS_BUILDING_Detail, {})
end

function BuildingNetworkCtrl:OnRecvBuildingDetail(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  for _, v in pairs(msg.data) do
    self:UpdateBuildingData(v)
  end
  for _, data in pairs(PlayerDataCenter.AllBuildingData.unbuilt) do
    if not data:Unlock() then
      if data:IsSectorBuilding() then
        local level1Cfg = data.levelConfig[1]
        for index, pre_conditionId in ipairs(level1Cfg.pre_condition) do
          local pre_para1 = level1Cfg.pre_para1[index]
          local pre_para2 = level1Cfg.pre_para2[index]
          NoticeManager:Add2PreConditionDic(pre_conditionId, pre_para1, pre_para2, function()
            if CheckCondition.CheckLua(level1Cfg.pre_condition, level1Cfg.pre_para1, level1Cfg.pre_para2) then
              NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.StrategyOverviewSkillUnlcok, nil, {
                LanguageUtil.GetLocaleText(level1Cfg.name)
              }, nil))
              return true
            end
          end)
        end
      else
        local level1Cfg = data.levelConfig[1]
        for index, pre_conditionId in ipairs(level1Cfg.pre_condition) do
          local pre_para1 = level1Cfg.pre_para1[index]
          local pre_para2 = level1Cfg.pre_para2[index]
          NoticeManager:Add2PreConditionDic(pre_conditionId, pre_para1, pre_para2, function()
            if CheckCondition.CheckLua(level1Cfg.pre_condition, level1Cfg.pre_para1, level1Cfg.pre_para2) then
              NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.OasisBuildingUnlock, {
                jumpType = JumpManager.eJumpTarget.Oasis,
                argList = nil
              }, {
                LanguageUtil.GetLocaleText(level1Cfg.name)
              }, {
                buildingId = data.id
              }))
              return true
            end
          end)
        end
      end
    end
  end
  PlayerDataCenter.playerBonus:CheckPlayerBonusBroadcast()
  table.sort(PlayerDataCenter.AllBuildingData.builtSort, function(a, b)
    return a.id < b.id
  end)
  PlayerDataCenter.AllBuildingData:UpdateData()
  PlayerDataCenter.AllBuildingData:InitOasisAreaData(msg.areaData)
  GuideManager:UncompleteCollectResGuide(PlayerDataCenter.AllBuildingData.built[1003] == nil)
end

function BuildingNetworkCtrl:UpdateBuildingData(buildingBase)
  local data = PlayerDataCenter.AllBuildingData.built[buildingBase.id]
  if data == nil then
    data = BuildingData.New()
    PlayerDataCenter.AllBuildingData.built[buildingBase.id] = data
    table.insert(PlayerDataCenter.AllBuildingData.builtSort, data)
    local unbuiltData = PlayerDataCenter.AllBuildingData.unbuilt[buildingBase.id]
    PlayerDataCenter.AllBuildingData.unbuilt[buildingBase.id] = nil
    table.removebyvalue(PlayerDataCenter.AllBuildingData.unbuiltSort, unbuiltData)
    data:Initialize(buildingBase, unbuiltData.stcData)
    PlayerDataCenter.AllBuildingData:UpdateBuildLevelRecord(data.id, data.level, 0)
    return true
  else
    if data.level > buildingBase.level then
      data:RemoveBuildingBonus()
    end
    local oriLevel = data.level
    data:Update(buildingBase)
    data:AddBuildingBonus()
    PlayerDataCenter.AllBuildingData:UpdateBuildLevelRecord(data.id, data.level, oriLevel)
    return false
  end
end

function BuildingNetworkCtrl:OnRecvBuildingSyncUpdateDiff(msg)
  for areaId, _ in pairs(msg.areaUpdate) do
    PlayerDataCenter.AllBuildingData:UpdateOasisAreaData(areaId, true)
  end
  local oasisCtroller = ControllerManager:GetController(ControllerTypeId.OasisController)
  local needSort = false
  local built = PlayerDataCenter.AllBuildingData.built
  for k, v in pairs(msg.delete) do
    local builtData = built[k]
    built[k] = nil
    table.removebyvalue(PlayerDataCenter.AllBuildingData.builtSort, builtData)
    builtData:RemoveBuildingBonus()
    local unbuiltData = PlayerDataCenter.AllBuildingData.unbuilt[builtData.id]
    if unbuiltData == nil then
      unbuiltData = BuildingDynData.New()
      unbuiltData:Initialize(builtData.stcData)
      PlayerDataCenter.AllBuildingData.unbuilt[builtData.id] = unbuiltData
      table.insert(PlayerDataCenter.AllBuildingData.unbuiltSort, unbuiltData)
      needSort = true
    end
    PlayerDataCenter.AllBuildingData:UpdateBuildLevelRecord(builtData.id, 0, builtData)
  end
  if needSort then
    table.sort(PlayerDataCenter.AllBuildingData.unbuiltSort, function(a, b)
      return a.id < b.id
    end)
  end
  needSort = false
  for _, v in pairs(msg.update) do
    local addNew = self:UpdateBuildingData(v)
    if addNew then
      needSort = true
    end
  end
  PlayerDataCenter.playerBonus:CheckPlayerBonusBroadcast()
  if needSort then
    table.sort(PlayerDataCenter.AllBuildingData.builtSort, function(a, b)
      return a.id < b.id
    end)
  end
  PlayerDataCenter.AllBuildingData:UpdateData()
  local stOCtrl = ControllerManager:GetController(ControllerTypeId.StrategyOverview)
  if #self.lastSendDataList == 0 then
    for _, v in pairs(msg.update) do
      if built[v.id].belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
        oasisCtroller:UpdateBuilding(v.id)
      elseif built[v.id].belong == BuildingBelong.Sector and stOCtrl ~= nil then
        stOCtrl:UpdateStOBuilding(v.id)
      end
    end
    if isGameDev then
      MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.BuildingLevel)
    end
    return
  end
  local updateRedDotBuildingBuildable = false
  local lastData = table.remove(self.lastSendDataList, 1)
  if lastData.type == LastSendType.BuildingConstruct then
    if built[lastData.id].belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
      oasisCtroller:ConstructComplete(lastData.id)
    end
    MsgCenter:Broadcast(eMsgEventId.BuildingSendUpgradeComplete, false)
    MsgCenter:Broadcast(eMsgEventId.BuildingUpgradeComplete, lastData.id)
    updateRedDotBuildingBuildable = true
    local sideNoticeList = NoticeManager:GetSideNoticeList()
    for _, noticeData in pairs(sideNoticeList) do
      if noticeData.type == NoticeManager.eNoticeType.OasisBuildingUnlock and lastData.id == noticeData.extraData.buildingId then
        NoticeManager:DeleteNotice(noticeData)
        break
      end
    end
  elseif lastData.type == LastSendType.BuildingUpgrade then
    if built[lastData.id].belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
      oasisCtroller:UpgradeComplete(lastData.id)
    end
    MsgCenter:Broadcast(eMsgEventId.BuildingSendUpgradeComplete, true)
    MsgCenter:Broadcast(eMsgEventId.BuildingUpgradeComplete, lastData.id)
    updateRedDotBuildingBuildable = true
    MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.BuildingLevel)
  elseif lastData.type == LastSendType.BuildingMove then
    if built[lastData.id].belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
      oasisCtroller:MoveComplete(lastData.id)
    end
  elseif lastData.type == LastSendType.BuildingCancel then
    if lastData.belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
      oasisCtroller:CancelComplete(lastData.id, lastData.oldState)
    end
    updateRedDotBuildingBuildable = true
    MsgCenter:Broadcast(eMsgEventId.BuildingCancelComplete)
  elseif lastData.type == LastSendType.BuildingConfirmOver then
    MsgCenter:Broadcast(eMsgEventId.BuildingUpgradeComplete, lastData.id)
    updateRedDotBuildingBuildable = true
    MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.BuildingLevel)
  elseif lastData.type == LastSendType.BuildingAccelerate then
    local progress, second, waitConfirmOver = built[lastData.id]:GetProcess(PlayerDataCenter.timestamp)
    if 1 <= progress then
      MsgCenter:Broadcast(eMsgEventId.BuildingUpgradeComplete, lastData.id)
      updateRedDotBuildingBuildable = true
    end
  end
  if updateRedDotBuildingBuildable then
    self:UpdateRedDotBuildingBuildable()
  end
end

function BuildingNetworkCtrl:SendBuildingConstruct(id, position, area, callback)
  local tabMsg = {id = id, area = area}
  if position ~= nil then
    tabMsg.x = position.x
    tabMsg.y = position.y
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Construct, proto_csmsg.CS_BUILDING_Construct, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.BuildingConstruct
  saveList.id = id
  table.insert(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Construct, callback, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Construct)
end

function BuildingNetworkCtrl:OnRecvBuildingConstruct(msg)
  if msg.ret ~= 0 then
    table.remove(self.lastSendDataList, 1)
    local err = "BuildingNetworkCtrl:OnRecvBuildingConstruct error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Construct)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  else
    local rewardDic = GameGlobalUtil.CollectDiffReward(msg.syncUpdateDiff)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Construct, rewardDic)
  end
end

function BuildingNetworkCtrl:SendBuildingUpgrade(id, callback)
  local tabMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Upgrade, proto_csmsg.CS_BUILDING_Upgrade, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.BuildingUpgrade
  saveList.id = id
  table.insert(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Upgrade, callback, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Upgrade)
end

function BuildingNetworkCtrl:OnRecvBuildingUpgrade(msg)
  if msg.ret ~= 0 then
    table.remove(self.lastSendDataList, 1)
    local err = "BuildingNetworkCtrl:OnRecvBuildingUpgrade error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Upgrade)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  else
    local rewardDic = GameGlobalUtil.CollectDiffReward(msg.syncUpdateDiff)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Upgrade, rewardDic)
  end
end

function BuildingNetworkCtrl:SendBuildingMove(id, position, area)
  local tabMsg = {
    id = id,
    x = position.x,
    y = position.y,
    area = area
  }
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Move, proto_csmsg.CS_BUILDING_Move, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.BuildingMove
  saveList.id = id
  table.insert(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Move, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Move)
end

function BuildingNetworkCtrl:OnRecvBuildingMove(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
  else
    table.remove(self.lastSendDataList, 1)
    local err = "BuildingNetworkCtrl:OnRecvBuildingMove error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Move)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function BuildingNetworkCtrl:SendBuildingCollect(id)
  local tabMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Collect, proto_csmsg.CS_BUILDING_Collect, tabMsg)
  local saveList = {}
  saveList.id = id
  table.insert(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Collect, function()
    local lastData = table.remove(self.lastSendDataList, 1)
    local built = PlayerDataCenter.AllBuildingData.built
    local oasisCtroller = ControllerManager:GetController(ControllerTypeId.OasisController)
    if built[lastData.id].belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
      oasisCtroller:CollectComplete(lastData.id, lastData.resTab)
    end
    self:UpdateRedDotOasisResMax()
  end, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Collect)
end

function BuildingNetworkCtrl:OnRecvBuildingCollect(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    local lastData = self.lastSendDataList[1]
    lastData.resTab = {}
    if msg.data ~= nil then
      for k, v in pairs(msg.data) do
        local res = {id = k, count = v}
        table.insert(lastData.resTab, res)
      end
    end
    table.sort(lastData.resTab, function(a, b)
      return a.id < b.id
    end)
  else
    table.remove(self.lastSendDataList, 1)
    local err = "BuildingNetworkCtrl:OnRecvBuildingCollect error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Collect)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function BuildingNetworkCtrl:SendBuildingCollectGroup(buildingIdDic, callback)
  local tabMsg = {gruop = buildingIdDic}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_CollectGroup, proto_csmsg.CS_BUILDING_CollectGroup, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_CollectGroup, callback, proto_csmsg_MSG_ID.MSG_SC_BUILDING_CollectGroup)
end

function BuildingNetworkCtrl:OnRecvBuildingCollectGroup(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BUILDING_CollectGroup, msg.data)
  else
    local err = "OnRecvBuildingCollectGroup error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_CollectGroup)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function BuildingNetworkCtrl:SendBuildingCancel(id)
  local tabMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Cancel, proto_csmsg.CS_BUILDING_Cancel, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.BuildingCancel
  saveList.id = id
  local builtData = PlayerDataCenter.AllBuildingData.built[id]
  saveList.oldState = builtData.state
  saveList.id = builtData.id
  saveList.belong = builtData.belong
  table.insert(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Cancel, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Cancel)
end

function BuildingNetworkCtrl:OnRecvBuildingCancel(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
  else
    table.remove(self.lastSendDataList, 1)
    local err = "BuildingNetworkCtrl:OnRecvBuildingCancel error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Cancel)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function BuildingNetworkCtrl:SendBuildingConfirmOver(id)
  local tabMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_ConfirmOver, proto_csmsg.CS_BUILDING_ConfirmOver, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.BuildingConfirmOver
  saveList.id = id
  table.insert(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_ConfirmOver, proto_csmsg_MSG_ID.MSG_SC_BUILDING_ConfirmOver)
end

function BuildingNetworkCtrl:OnRecvBuildingConfirmOver(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
  else
    table.remove(self.lastSendDataList, 1)
    local err = "BuildingNetworkCtrl:OnRecvBuildingConfirmOver error:" .. tostring(msg.ret)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_ConfirmOver)
    self:ShowSCErrorMsg(err)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function BuildingNetworkCtrl:CS_BUILDIN_AreaUnlock(areaId, callback)
  self._areaUnlockTab.areaId = areaId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_AreaUnlock, proto_csmsg.CS_BUILDIN_AreaUnlock, self._areaUnlockTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_AreaUnlock, callback, proto_csmsg_MSG_ID.MSG_SC_BUILDIN_AreaUnlock)
end

function BuildingNetworkCtrl:SC_BUILDIN_AreaUnlock(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_BUILDIN_AreaUnlock error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_AreaUnlock)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function BuildingNetworkCtrl:Reset()
  self.lastSendDataList = {}
  self:StopBuildingRedDotTimer()
end

function BuildingNetworkCtrl:InitBuildingRedDotOasis()
  local oasisBuildableCount = self:__GenOasisBuildableCount()
  local buildableNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.OasisBuildListPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis, RedDotStaticTypeId.OasisCanBuildNew)
  buildableNode:SetRedDotCount(oasisBuildableCount)
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding) then
    for _, id in ipairs(ConfigData.sector.id_sort_list) do
      local sectorCfg = ConfigData.sector[id]
      local sectorId = sectorCfg.id
      local sectorNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.StrategyOverviewPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.SectorBuilding, sectorId)
      local sectorBuildableCount = self:__GenSectorBuildableCount(sectorCfg)
      sectorNode:SetRedDotCount(sectorBuildableCount)
    end
  end
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1) then
    local careerBuildCount, careerRewardBuildCount = self:__GenCareerBuildableCount()
    local careerBuildNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.StrategyOverviewPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.CareerBuilding)
    careerBuildNode:SetRedDotCount(careerBuildCount)
    local careerBuildNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.StrategyOverviewPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.CareerRewardBuild)
    careerBuildNode:SetRedDotCount(careerRewardBuildCount)
  end
  local oasisResMaxCount = self:__GenOasisBuildingResMaxCount()
  local oasisResMaxNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.OasisResMaxPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis, RedDotStaticTypeId.OasisBuildResMax)
  oasisResMaxNode:SetRedDotCount(oasisResMaxCount)
  self:StartBuildingRedDotTimer()
end

function BuildingNetworkCtrl:UpdateRedDotBuildingBuildable()
  local ok, buildableNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis, RedDotStaticTypeId.OasisCanBuildNew)
  if ok then
    local oasisBuildableCount = self:__GenOasisBuildableCount()
    buildableNode:SetRedDotCount(oasisBuildableCount)
  end
  for _, id in ipairs(ConfigData.sector.id_sort_list) do
    local sectorCfg = ConfigData.sector[id]
    local sectorId = sectorCfg.id
    local ok, sectorNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.SectorBuilding, sectorId)
    if ok then
      local sectorBuildableCount = self:__GenSectorBuildableCount(sectorCfg)
      sectorNode:SetRedDotCount(sectorBuildableCount)
    end
  end
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1) then
    local careerBuildCount, careerRewardBuildCount = self:__GenCareerBuildableCount()
    local careerBuildNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.StrategyOverviewPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.CareerBuilding)
    careerBuildNode:SetRedDotCount(careerBuildCount)
    local careerBuildNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.StrategyOverviewPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.CareerRewardBuild)
    careerBuildNode:SetRedDotCount(careerRewardBuildCount)
  end
end

function BuildingNetworkCtrl:UpdateRedDotOasisResMax()
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis, RedDotStaticTypeId.OasisBuildResMax)
  if ok then
    local count = self:__GenOasisBuildingResMaxCount()
    node:SetRedDotCount(count)
  end
end

function BuildingNetworkCtrl:OnRedDotBuildingTimerUpdate()
  self:UpdateRedDotOasisResMax()
end

function BuildingNetworkCtrl:StartBuildingRedDotTimer()
  self.redDotTimerId = TimerManager:StartTimer(5, BindCallback(self, self.OnRedDotBuildingTimerUpdate), nil, false, false, true)
end

function BuildingNetworkCtrl:StopBuildingRedDotTimer()
  if self.redDotTimerId ~= nil then
    TimerManager:StopTimer(self.redDotTimerId)
    self.redDotTimerId = nil
  end
end

function BuildingNetworkCtrl:__GenOasisBuildableCount()
  local oasisBuildableCount = 0
  if not PlayerDataCenter.AllBuildingData:FullBuildQue(BuildingBelong.Oasis) then
    for k, v in ipairs(PlayerDataCenter.AllBuildingData.unbuiltSort) do
      if v:Unlock() and v:CanBuild() and v.belong == BuildingBelong.Oasis then
        oasisBuildableCount = oasisBuildableCount + 1
      end
    end
  end
  return oasisBuildableCount
end

function BuildingNetworkCtrl:__GenSectorBuildableCount(sectorCfg)
  local unlock = PlayerDataCenter.sectorStage:IsSectorUnlock(sectorCfg.id)
  local isSectorBuildingUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding)
  local sectorBuildableCount = 0
  if not PlayerDataCenter.AllBuildingData:FullBuildQue(BuildingBelong.Sector) and unlock and isSectorBuildingUnlock and sectorCfg.building ~= nil then
    for _, buildingId in ipairs(sectorCfg.building) do
      local unbuiltData = PlayerDataCenter.AllBuildingData.unbuilt[buildingId]
      if unbuiltData ~= nil then
        if unbuiltData:Unlock() and unbuiltData:CanBuild() then
          sectorBuildableCount = sectorBuildableCount + 1
        end
      else
        local builtData = PlayerDataCenter.AllBuildingData.sectorBuilt[buildingId]
        if builtData ~= nil and builtData.state == proto_object_BuildingState.BuildingStateNormal and builtData:CanUpgrade() then
          sectorBuildableCount = sectorBuildableCount + 1
        end
      end
    end
  end
  return sectorBuildableCount
end

function BuildingNetworkCtrl:__GenCareerBuildableCount()
  local count = 0
  local rewardPointCount = 0
  for _, buildId in ipairs(ConfigData.building.careerBuilds) do
    local buildingData = PlayerDataCenter.AllBuildingData.built[buildId]
    if buildingData ~= nil then
      if buildingData.state == proto_object_BuildingState.BuildingStateNormal and buildingData:CanUpgrade() then
        count = count + 1
        local buildCfg = ConfigData.building[buildId]
        if buildCfg.nodeType == BuildingEnum.TechItemEdgeType.RewardEdge then
          rewardPointCount = rewardPointCount + 1
        end
      end
    else
      buildingData = PlayerDataCenter.AllBuildingData.unbuilt[buildId]
      if buildingData ~= nil and buildingData:Unlock() and buildingData:CanBuild() then
        count = count + 1
        local buildCfg = ConfigData.building[buildId]
        if buildCfg.nodeType == BuildingEnum.TechItemEdgeType.RewardEdge then
          rewardPointCount = rewardPointCount + 1
        end
      end
    end
  end
  return count, rewardPointCount
end

function BuildingNetworkCtrl:__GenOasisBuildingResMaxCount()
  local count = 0
  for k, buildData in pairs(PlayerDataCenter.AllBuildingData.oasisBuilt) do
    if buildData.resDatas ~= nil then
      local resDatas = buildData:GetResDatas()
      if resDatas ~= nil then
        for k, v in pairs(resDatas) do
          if v.resMax then
            count = 1
            return count
          end
        end
      end
    end
  end
  return count
end

function BuildingNetworkCtrl:SendBuildingAccelerate(id, cost, callback)
  local tabMsg = {id = id, cost = cost}
  local saveList = {}
  saveList.type = LastSendType.BuildingAccelerate
  saveList.id = id
  table.insert(self.lastSendDataList, saveList)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_Accelerate, proto_csmsg.CS_BUILDIN_Accelerate, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_Accelerate, callback, proto_csmsg_MSG_ID.MSG_SC_BUILDIN_Accelerate)
end

function BuildingNetworkCtrl:OnRecvBuildingAccelerate(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
  else
    table.remove(self.lastSendDataList, 1)
    local err = "BuildingNetworkCtrl:OnRecvBuildingAccelerate error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_Accelerate)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

return BuildingNetworkCtrl
