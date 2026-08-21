_class("N20AVGData", Object)
N20AVGData = N20AVGData

function N20AVGData:Constructor()
  self.activityCampaign = UIActivityCampaign:New()
  self.dictBadgePos = {
    [1] = Vector2(-259, 129),
    [2] = Vector2(71, 129),
    [3] = Vector2(400, 129),
    [4] = Vector2(730, 129),
    [5] = Vector2(-95, -126),
    [6] = Vector2(235, -126),
    [7] = Vector2(564, -126)
  }
  self.notRemindJump = false
  self.uiName = "UIN20AVGStory"
  self.storyManager = nil
  self.optionPos = {
    Vector2(432, -366),
    Vector2(-404, -224),
    Vector2(629, -89),
    Vector2(-581, 43)
  }
end

function N20AVGData:RequestCampaign(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self.activityCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N20, ECampaignN20ComponentID.ECAMPAIGN_N20_AVG_MINI_GAME)
  return res
end

function N20AVGData:GetComponentAVG()
  return self.activityCampaign:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_AVG_MINI_GAME)
end

function N20AVGData:GetComponentInfoAVG()
  return self.activityCampaign:GetComponentInfo(ECampaignN20ComponentID.ECAMPAIGN_N20_AVG_MINI_GAME)
end

function N20AVGData:IsActiveOpen()
  local c = self:GetComponentAVG()
  if c and c:ComponentIsOpen() then
    return true
  end
  return false
end

function N20AVGData.CheckCode(res)
  local result = res:GetResult()
  if result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    return true
  end
  local msg = StringTable.Get("str_activity_error_" .. result)
  ToastManager.ShowToast(msg)
  Log.warn("### ", msg)
  if result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED or result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  elseif result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIActivityN20MainController)
  else
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  end
  return false
end

function N20AVGData:Init()
  self:InitActors()
  self:InitGraph()
  self:InitLines()
  self:InitBadge()
  self:InitEnding()
end

function N20AVGData:InitActors()
  local cfg_component_avg_story_limit = self:GetCfgComponentAvgStoryLimit()
  local actorInfo = cfg_component_avg_story_limit.ActorInfo
  self.actorLeader = AVGActorLeader:New()
  self.actorLeader.icon = actorInfo[1].icon
  self.actorLeader.iconOption = actorInfo[1].iconOption
  self.actorLeader.min = cfg_component_avg_story_limit.MinBlood
  self.actorLeader.max = cfg_component_avg_story_limit.MaxBlood
  self.actorLeader.default = cfg_component_avg_story_limit.StartBlood
  self.actorPartners = {}
  if cfg_component_avg_story_limit.TeammateInitList then
    for i, s in ipairs(cfg_component_avg_story_limit.TeammateInitList) do
      local actor = AVGActorPartner:New()
      actor.icon = cfg_component_avg_story_limit.ActorInfo[i + 1].icon
      actor.iconOption = cfg_component_avg_story_limit.ActorInfo[i + 1].iconOption
      actor.min = cfg_component_avg_story_limit.TeammateMinList[i]
      actor.max = cfg_component_avg_story_limit.TeammateMaxList[i]
      actor.default = cfg_component_avg_story_limit.TeammateInitList[i]
      table.insert(self.actorPartners, actor)
    end
  end
end

function N20AVGData:InitGraph()
  self.dictStoryNode = {}
  self.dictStoryIdNodeId = {}
  local cfg_component_avg_story_node = self:GetCfgComponentAvgStoryNode()
  self.graph = Digraph:New()
  for id, cfgv in pairs(cfg_component_avg_story_node) do
    local node = AVGStoryNode:New()
    node.id = id
    node.endId = cfgv.Ending or 0
    node.storyId = cfgv.StoryId
    if string.isnullorempty(cfgv.VisibleCondition) then
      node.hideVisibleCondition = nil
    else
      node.hideVisibleCondition = AVGCondition:New(cfgv.VisibleCondition, false)
    end
    node.hideStartArchive = cfgv.StartArchive or {}
    node.pos.x = cfgv.NodePos[1]
    node.pos.y = cfgv.NodePos[2]
    node.title = StringTable.Get(cfgv.Title)
    node.desc = StringTable.Get(cfgv.Desc)
    node.cg = cfgv.CG
    node.canPlayCg = cfgv.CanPlayCg
    node.cgNode = cfgv.CGNode
    node.canplayCgNode = cfgv.CanplayCGNode
    node.cgCanPlay = cfgv.CanplayCG
    self.dictStoryNode[id] = node
    self.dictStoryIdNodeId[node.storyId] = id
    local node = self.dictStoryNode[id]
    local nextNodeIds = cfgv.NextStory
    if nextNodeIds then
      node.defaultNextId = nextNodeIds[1]
      for _, nodeId in ipairs(nextNodeIds) do
        self.graph:AddEdge(id, nodeId)
      end
    else
      node.defaultNextId = -1
    end
  end
end

function N20AVGData:InitNodes()
  local cfgSectionExcel = self:GetCfgComponentAvgStorySection()
  local cfgOptionExcel = self:GetCfgComponentAvgStoryManual()
  for id, node in pairs(self.dictStoryNode) do
    node:Init(cfgSectionExcel, cfgOptionExcel)
  end
end

function N20AVGData:InitLines()
  self.lines = {}
  local cfg_avg_line = self:GetCfgAvgLine()
  for _, cfgv in pairs(cfg_avg_line) do
    local cfgvPos = cfgv.Pos
    for eNodeId, t in pairs(cfgvPos) do
      local line = AVGStoryLine:New()
      line.sNodeId = cfgv.ID
      line.eNodeId = eNodeId
      line.posS = Vector2(t.s[1], t.s[2])
      line.posE = Vector2(t.e[1], t.e[2])
      if t.l then
        line.posLs = {}
        for index, lp in ipairs(t.l) do
          local pos = Vector2(lp[1], lp[2])
          table.insert(line.posLs, pos)
        end
      end
      table.insert(self.lines, line)
    end
  end
end

function N20AVGData:InitBadge()
  self.badges = {}
  local cfg_component_avg_story_badge = self:GetCfgComponentAvgStoryBadge()
  for id, cfgv in pairs(cfg_component_avg_story_badge) do
    local badge = AVGBadgeInfo:New()
    badge.id = id
    badge.itemId = cfgv.BadgeID or 0
    badge.name = StringTable.Get(cfgv.Name)
    badge.desc = StringTable.Get(cfgv.Desc)
    badge.icon = cfgv.Icon
    badge.pos = self.dictBadgePos[id]
    table.insert(self.badges, badge)
  end
  self.badgeStages = {}
  local cfg_component_avg_story_badge_reward = self:GetCfgComponentAvgStoryBadgeReward()
  for id, cfgv in pairs(cfg_component_avg_story_badge_reward) do
    local stage = AVGBadgeStage:New()
    stage.id = id
    stage.count = cfgv.StageCount
    for _, tAward in ipairs(cfgv.Reward) do
      local ra = RoleAsset:New()
      ra.assetid = tAward[1]
      ra.count = tAward[2]
      table.insert(stage.awards, ra)
    end
    table.insert(self.badgeStages, stage)
  end
end

function N20AVGData:InitEnding()
  self.endings = {}
  local cfg_component_avg_story_ending = self:GetCfgComponentAvgStoryEnding()
  for id, cfgv in pairs(cfg_component_avg_story_ending) do
    local ending = AVGEnding:New()
    ending.id = cfgv.ID
    ending.itemIdGift = cfgv.AcceptableCGGift or 0
    ending.itemId = cfgv.AcceptableCG or 0
    ending.cg = cfgv.CG
    ending.cgEnding = cfgv.EndingCG
    ending.cgCollect = cfgv.CollectCG
    ending.title = StringTable.Get(cfgv.Title)
    ending.desc = StringTable.Get(cfgv.Desc)
    ending.getConditionDesc = StringTable.Get(cfgv.GetConditionDesc)
    ending.awards = {}
    local cfgGift = Cfg.cfg_item_gift[cfgv.AcceptableCGGift]
    if cfgGift then
      local itemList = cfgGift.ItemList
      if itemList and 0 < table.count(itemList) then
        for index, idCount in ipairs(itemList) do
          local ra = RoleAsset:New()
          ra.assetid = idCount[1]
          ra.count = idCount[2]
          table.insert(ending.awards, ra)
        end
      end
    end
    ending.isBE = cfgv.IsBE
    table.insert(self.endings, ending)
  end
  table.sort(self.endings, function(a, b)
    return a.id < b.id
  end)
end

function N20AVGData:Update()
  self:UpdateActors()
  self:UpdateGraph()
  self:UpdateBadge()
  self:UpdateEnding()
end

function N20AVGData:UpdateActors()
end

function N20AVGData:UpdateGraph()
  for id, node in pairs(self.dictStoryNode) do
    if node:IsHide() then
      if node:IsComplete() then
        node.state = AVGStoryNodeState.Complete
      elseif node:IsSatisfyVisible() then
        node.state = AVGStoryNodeState.CanPlay
      else
        node.state = nil
      end
    elseif node:IsComplete() then
      node.state = AVGStoryNodeState.Complete
    else
      local serverNodeInfo = self:GetServerNodeDataByNodeId(id)
      if serverNodeInfo then
        node.state = AVGStoryNodeState.CanPlay
      else
        node.state = nil
      end
    end
  end
  for id, node in pairs(self.dictStoryNode) do
    if node:IsHide() then
    elseif node.state then
    else
      local nodeIds = self.graph:Indegree(id)
      if nodeIds then
        for _, nodeId in ipairs(nodeIds) do
          local nodeIndegree = self:GetNodeById(nodeId)
          if nodeIndegree and nodeIndegree.state == AVGStoryNodeState.Complete then
            node.state = AVGStoryNodeState.CantPlay
            break
          end
        end
      end
    end
  end
end

function N20AVGData:UpdateBadge()
end

function N20AVGData:UpdateEnding()
end

function N20AVGData:GetComponentId()
  if not self.componentId then
    local c = self:GetComponentAVG()
    self.componentId = c:GetComponentCfgId()
  end
  return self.componentId
end

function N20AVGData:GetCfgComponentAvgStoryBadge()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_badge({ComponentID = cId})
  return cfg
end

function N20AVGData:GetCfgComponentAvgStoryBadgeReward()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_badge_reward({ComponentID = cId})
  return cfg
end

function N20AVGData:GetCfgComponentAvgStoryEnding()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_ending({ComponentID = cId})
  return cfg
end

function N20AVGData:GetCfgComponentAvgStoryLimit()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_limit({ComponentID = cId})
  if cfg then
    return cfg[1]
  end
end

function N20AVGData:GetCfgComponentAvgStoryManual()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_manual({ComponentID = cId})
  return cfg
end

function N20AVGData:GetCfgComponentAvgStoryNode()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_node({ComponentID = cId})
  return cfg
end

function N20AVGData:GetCfgComponentAvgStorySection()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_section({ComponentID = cId})
  return cfg
end

function N20AVGData:GetCfgAvgLine()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_avg_line({ComponentID = cId})
  return cfg
end

function N20AVGData:FirstNodeId()
  if not self.fstNodeId then
    for id, node in pairs(self.dictStoryNode) do
      if self.graph:IndegreeCount(id) == 0 and not node:IsHide() then
        self.fstNodeId = id
        break
      end
    end
  end
  return self.fstNodeId
end

function N20AVGData:CurNodeId()
  local info = self:GetComponentInfoAVG()
  local curNodeId = info.cur_node_id
  if curNodeId == 0 then
    curNodeId = self:FirstNodeId()
  end
  return curNodeId
end

function N20AVGData:CurNode()
  local nodeId = self:CurNodeId()
  local node = self:GetNodeById(nodeId)
  return node
end

function N20AVGData:GetNodeById(id)
  if not id then
    Log.fatal("### node id is nil.")
  end
  local node = self.dictStoryNode[id]
  return node
end

function N20AVGData:GetNodeByStoryId(storyId)
  local nodeId = self.dictStoryIdNodeId[storyId]
  if not nodeId then
    Log.fatal("### no corresponding nodeId. storyId=", storyId)
  end
  local node = self:GetNodeById(nodeId)
  return node
end

function N20AVGData:GetNodeByEndId(endId)
  for id, node in pairs(self.dictStoryNode) do
    if node.endId == endId then
      return node
    end
  end
end

function N20AVGData:OnTheWay()
  local nodeId = self:CurNodeId()
  if nodeId == self:FirstNodeId() then
    return false
  end
  return true
end

function N20AVGData:HasNew()
  local hasNewNode = self:HasNewNode()
  local hasNewBadge = self:HasNewBadge()
  local hasNewCG = self:HasNewCG()
  return hasNewNode or hasNewBadge or hasNewCG
end

function N20AVGData:HasNewNode()
  for id, node in ipairs(self.dictStoryNode) do
    if node:IsHide() and node:IsSatisfyVisible() and node:IsHideNew() then
      return true
    end
  end
  return false
end

function N20AVGData:HasNewBadge()
  for index, badge in ipairs(self.badges) do
    if badge:HasNew() then
      return true
    end
  end
  return false
end

function N20AVGData:HasNewCG()
  for index, ending in ipairs(self.endings) do
    if ending:HasNew() then
      return true
    end
  end
  return false
end

function N20AVGData:HasRed()
  local hasRedBadge = self:HasRedBadge()
  local hasRedCG = self:HasRedCG()
  return hasRedBadge or hasRedCG
end

function N20AVGData:HasRedBadge()
  for index, badgeStage in ipairs(self.badgeStages) do
    if badgeStage:HasRed() then
      return true
    end
  end
  return false
end

function N20AVGData:HasRedCG()
  for index, ending in ipairs(self.endings) do
    if ending:HasRed() then
      return true
    end
  end
  return false
end

function N20AVGData:GetActorByIndex(index)
  local actor = self.actorPartners[index]
  if actor then
    return actor
  end
  return self.actorLeader
end

function N20AVGData:IsEndReach(endId)
  local info = self:GetComponentInfoAVG()
  if table.icontains(info.conplated_ending_ids, endId) then
    return true
  end
end

function N20AVGData:GetBadgeById(id)
  for index, badge in ipairs(self.badges) do
    if id == badge.id then
      return badge
    end
  end
end

function N20AVGData:GetBadgeStageById(id)
  for index, badgeStage in ipairs(self.badgeStages) do
    if id == badgeStage.id then
      return badgeStage
    end
  end
end

function N20AVGData:GetEndingById(id)
  for index, ending in ipairs(self.endings) do
    if id == ending.id then
      return ending
    end
  end
end

function N20AVGData:Timestamp2Str(timestamp)
  local t = UICommonHelper.Time2Day(timestamp)
  local year = os.date("%Y", timestamp)
  local month = os.date("%m", timestamp)
  local day = os.date("%d", timestamp)
  local hour = os.date("%H", timestamp)
  local min = os.date("%M", timestamp)
  local str = year .. "." .. month .. "." .. day .. " " .. hour .. ":" .. min
  return str
end

function N20AVGData.Sign(list)
  local key = table.concat(list, "_")
  return key
end

function N20AVGData.Sign2Numbers(sign)
  if type(sign) ~= "string" then
    Log.fatal("invalid param.", sign)
  end
  local strs = string.split(sign, "_")
  local t = {}
  for index, str in ipairs(strs) do
    local n = tonumber(str)
    table.insert(t, n)
  end
  return t
end

function N20AVGData:GetServerNodeDataByNodeId(nodeId)
  local info = self:GetComponentInfoAVG()
  local serNodeData = info.mission_datas[nodeId]
  return serNodeData
end

function N20AVGData:StoryManager(storyManager)
  if storyManager then
    self.storyManager = storyManager
  else
    return self.storyManager
  end
end

function N20AVGData:IsSelectedOption(optionId)
  local info = self:GetComponentInfoAVG()
  if table.icontains(info.choosed_manual_ids, optionId) then
    return true
  end
end

function N20AVGData:CalcCurData()
  if GameGlobal.UIStateManager():IsShow(self.uiName) then
    local hp, strategies = GameGlobal.UIStateManager():CallUIMethod(self.uiName, "CalcCurData")
    return hp, strategies
  end
  return 0, {}
end

_class("AVGActor", Object)
AVGActor = AVGActor

function AVGActor:Constructor()
  self.icon = ""
  self.iconOption = ""
  self.min = 0
  self.max = 0
  self.default = 0
  self.isLeader = false
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
end

_class("AVGActorLeader", AVGActor)
AVGActorLeader = AVGActorLeader

function AVGActorLeader:Constructor()
  self.isLeader = true
end

_class("AVGActorPartner", AVGActor)
AVGActorPartner = AVGActorPartner

function AVGActorPartner:Constructor()
  self.index = 0
end

_class("AVGBadgeInfo", Object)
AVGBadgeInfo = AVGBadgeInfo

function AVGBadgeInfo:Constructor()
  self.id = 0
  self.itemId = 0
  self.name = ""
  self.desc = ""
  self.icon = ""
  self.pos = Vector2.zero
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
end

function AVGBadgeInfo:HasGot()
  local mRole = GameGlobal.GetModule(RoleModule)
  local count = mRole:GetAssetCount(self.itemId)
  return 0 < count
end

function AVGBadgeInfo:HasNew()
  local mItem = GameGlobal.GetModule(ItemModule)
  local items = mItem:GetItemByTempId(self.itemId)
  for _, item in pairs(items) do
    if item:IsNewOverlay() then
      return true
    end
  end
  return false
end

_class("AVGBadgeStage", Object)
AVGBadgeStage = AVGBadgeStage

function AVGBadgeStage:Constructor()
  self.id = 0
  self.count = 0
  self.awards = {}
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
end

function AVGBadgeStage:AwardIcon()
  local award = self.awards[1]
  local cfgv = Cfg.cfg_item[award.assetid]
  local icon = cfgv.Icon
  return icon
end

function AVGBadgeStage:AwardCount()
  local award = self.awards[1]
  return award.count
end

function AVGBadgeStage:State()
  local info = self.data:GetComponentInfoAVG()
  if table.icontains(info.accepted_badge_rewards, self.id) then
    return AVGAwardState.Got
  else
    local hasGotBadgeCount = 0
    for index, badge in ipairs(self.data.badges) do
      if badge:HasGot() then
        hasGotBadgeCount = hasGotBadgeCount + 1
      end
    end
    if hasGotBadgeCount >= self.count then
      return AVGAwardState.CanGet
    end
  end
end

function AVGBadgeStage:HasRed()
  local state = self:State()
  return state == AVGAwardState.CanGet
end

_class("AVGEnding", Object)
AVGEnding = AVGEnding

function AVGEnding:Constructor()
  self.id = 0
  self.itemIdGift = 0
  self.itemId = 0
  self.cg = ""
  self.cgEnding = ""
  self.cgCollect = ""
  self.title = ""
  self.desc = ""
  self.getConditionDesc = ""
  self.awards = {}
  self.isBE = false
end

function AVGEnding:AwardState()
  local mRole = GameGlobal.GetModule(RoleModule)
  local countGift = mRole:GetAssetCount(self.itemIdGift)
  if 0 < countGift then
    return AVGAwardState.CanGet
  else
    local count = mRole:GetAssetCount(self.itemId)
    if 0 < count then
      return AVGAwardState.Got
    end
  end
end

function AVGEnding:HasGot()
  local state = self:AwardState()
  return state == AVGAwardState.Got
end

function AVGEnding:HasRed()
  local state = self:AwardState()
  return state == AVGAwardState.CanGet
end

function AVGEnding:HasNew()
  local mItem = GameGlobal.GetModule(ItemModule)
  local items = mItem:GetItemByTempId(self.itemId)
  for _, item in pairs(items) do
    if item:IsNewOverlay() then
      return true
    end
  end
  return false
end

function AVGEnding:GetTimestamp()
  if self.isBE then
    return 0
  end
  local mItem = GameGlobal.GetModule(ItemModule)
  local items = mItem:GetItemByTempId(self.itemId)
  if items and 0 < table.count(items) then
    for key, item in pairs(items) do
      local ts = item:GetGainTime()
      return ts
    end
  end
  return 0
end

local AVGAwardState = {CanGet = 1, Got = 2}
_enum("AVGAwardState", AVGAwardState)
_class("AVGCondition", Object)
AVGCondition = AVGCondition

function AVGCondition:Constructor(strCondition, default)
  local mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = mCampaign:GetN20AVGData()
  self.bt = self:ParseCondition(strCondition)
  self.default = default or false
end

function AVGCondition:IsSatisfy()
  if self.bt then
    local b = BTConditionManager:GetInstance():IsSatisfy(self.bt)
    return b
  end
  return self.default
end

function AVGCondition:ParseCondition(strCondition)
  if string.isnullorempty(strCondition) then
    Log.warn("### strCondition is nil.")
    return
  end
  local bt
  local charAnd, charOr = "&", "|"
  local indexAnd, _ = string.find(strCondition, charAnd)
  local indexOr, _ = string.find(strCondition, charOr)
  if indexAnd and 0 < indexAnd then
    local nodes = {}
    local strs = string.split(strCondition, charAnd)
    for index, str in ipairs(strs) do
      local btNode = self:ParseConditionSpecific(str)
      table.insert(nodes, btNode)
    end
    bt = BTConditionManager:GetInstance():BuildBTAnd(nodes)
  elseif indexOr and 0 < indexOr then
    local nodes = {}
    local strs = string.split(strCondition, charOr)
    for index, str in ipairs(strs) do
      local btNode = self:ParseConditionSpecific(str)
      table.insert(nodes, btNode)
    end
    bt = BTConditionManager:GetInstance():BuildBTOr(nodes)
  else
    local btNode = self:ParseConditionSpecific(strCondition)
    bt = BTConditionManager:GetInstance():BuildBTSingle(btNode)
  end
  return bt
end

function AVGCondition:ParseConditionSpecific(strConditionSingle)
  local charComma = ","
  local strs = string.split(strConditionSingle, charComma)
  local conditionId = ""
  local params = {}
  for index, str in ipairs(strs) do
    if index == 1 then
      conditionId = str
    elseif index == 2 or index == 3 then
    else
      table.insert(params, str)
    end
  end
  local funcName = "ParseConditionSpecific" .. conditionId
  local func = self[funcName]
  if not func then
    Log.fatal("### no function names: ", funcName)
    return
  end
  local node = func(self, params)
  return node
end

function AVGCondition:ParseConditionSpecific1230(strConditionParams)
  local comparisionType = tonumber(strConditionParams[1])
  local hpParam = tonumber(strConditionParams[2])
  local node = ComparisonOperationNode:New(nil, comparisionType, function()
    local hp, strategies = self.data:CalcCurData()
    return hp
  end, function()
    return hpParam
  end)
  return node
end

function AVGCondition:ParseConditionSpecific1231(strConditionParams)
  local indexPartner = tonumber(strConditionParams[1])
  local comparisionType = tonumber(strConditionParams[2])
  local strategyParam = tonumber(strConditionParams[3])
  local node = ComparisonOperationNode:New(nil, comparisionType, function()
    local hp, strategies = self.data:CalcCurData()
    local strategy = strategies[indexPartner] or 0
    return strategy
  end, function()
    return strategyParam
  end)
  return node
end

function AVGCondition:ParseConditionSpecific1232(strConditionParams)
  local optionIds = {}
  for index, str in ipairs(strConditionParams) do
    local optionId = tonumber(str)
    table.insert(optionIds, optionId)
  end
  local node = self:NewConditionNode(function()
    if not GameGlobal.UIStateManager():IsShow("UIN20AVGStory") then
      return false
    end
    local selectedOptionIds = GameGlobal.UIStateManager():CallUIMethod("UIN20AVGStory", "SelectedOptionId")
    for index, optionId in ipairs(optionIds) do
      if not selectedOptionIds[optionId] then
        return false
      end
    end
    return true
  end)
  return node
end

function AVGCondition:ParseConditionSpecific1233(strConditionParams)
  local optionIds = {}
  for index, str in ipairs(strConditionParams) do
    local optionId = tonumber(str)
    table.insert(optionIds, optionId)
  end
  local node = self:NewConditionNode(function()
    for index, optionId in ipairs(optionIds) do
      if not self.data:IsSelectedOption(optionId) then
        return false
      end
    end
    return true
  end)
  return node
end

function AVGCondition:ParseConditionSpecific1234(strConditionParams)
  local endIds = {}
  for index, str in ipairs(strConditionParams) do
    local endId = tonumber(str)
    table.insert(endIds, endId)
  end
  local node = self:NewConditionNode(function()
    for index, endId in ipairs(endIds) do
      if not self.data:IsEndReach(endId) then
        return false
      end
    end
    return true
  end)
  return node
end

function AVGCondition:NewConditionNode(func)
  local node = ConditionNode:New(nil, func)
  return node
end

function AVGLog(...)
  if IsUnityEditor() then
    Log.fatal("### [AVG]", ...)
  end
end
