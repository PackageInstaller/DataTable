local NoticeManager = {}
local NoticeData = require("Game.Notice.NoticeData")
local JumpManager = require("Game.Jump.JumpManager")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
NoticeManager.eNoticeType = {
  None = 0,
  Mail = 1,
  ResourceGenerateOverflow = 5,
  HasOasisBuildingOperate = 6,
  HasSectorBuildingOperate = 7,
  FragDungeonRefresh = 8,
  ResDungeonRefresh = 9,
  ATHDungeonRefresh = 10,
  FactoryEnergyFull = 13,
  dailyChallenge = 14,
  FunctionUnlock = 15,
  FactoryUnlockNewFactory = 16,
  FactoryUnlockNewOrder = 17,
  OasisAreaUnlock = 18,
  OasisBuildingUnlock = 19,
  AchievementAchieved = 20,
  SectorTask = 21,
  StrategyOverviewSkillUnlcok = 22,
  GrowBagLevelup = 23,
  weeklyChallenge = 24,
  dungeonMultReward = 25,
  DailyDungeon = 26,
  ActivityHeroShop = 27,
  DormHouseUnlock = 28,
  DormFightBeInvited = 29,
  MilestoneTips = 30
}
NoticeManager.eNoticeShowType = {
  defualt = 0,
  down = 1,
  mid = 2,
  left = 3,
  dormFightLeft = 4,
  milestone = 5
}

function NoticeManager:Init()
  self.sideNoticeList = {}
  self.redDotCount = 0
  self.preConditionDick = {}
  self.__IsPauseNotice = true
  self.__pauseLocksDic = {}
  self.__BC_Listern2PreConditona = BindCallback(self, self.__Listern2PreConditon)
  self.__PuaseShowNotice = BindCallback(self, self.PuaseShowNotice, "exp")
  self.__ContinueShowNotice = BindCallback(self, self.ContinueShowNotice, "exp")
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__BC_Listern2PreConditona)
  MsgCenter:AddListener(eMsgEventId.ExplorationEnterComplete, self.__PuaseShowNotice)
  MsgCenter:AddListener(eMsgEventId.ExplorationExit, self.__ContinueShowNotice)
end

function NoticeManager:Add2PreConditionDic(pre_conditionId, pre_para1, pre_para2, function4unlock)
  if self.preConditionDick[pre_conditionId] == nil then
    self.preConditionDick[pre_conditionId] = {}
  end
  table.insert(self.preConditionDick[pre_conditionId], {
    pre_para1 = pre_para1,
    pre_para2 = pre_para2,
    function4unlock = function4unlock
  })
end

function NoticeManager:__Listern2PreConditon(conditionId)
  if self.preConditionDick[conditionId] ~= nil then
    for index = #self.preConditionDick[conditionId], 1, -1 do
      local data = self.preConditionDick[conditionId][index]
      if data.function4unlock() then
        table.remove(self.preConditionDick[conditionId], index)
      end
    end
    if #self.preConditionDick[conditionId] == 0 then
      self.preConditionDick[conditionId] = nil
    end
  end
end

local noticeFuncTable = {
  [NoticeManager.eNoticeType.AchievementAchieved] = function(self, noticeData)
    if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement) then
      self:DeleteNoticeByType(noticeData.type)
      self:__AddNotice2List(noticeData)
      self:ShowNotice(noticeData)
    end
  end,
  [NoticeManager.eNoticeType.FactoryEnergyFull] = function(self, noticeData)
    if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory) then
      if self:GetIsHaveThisTypeNotice(noticeData.type) then
        return true
      end
      self:__AddNotice2List(noticeData)
      self:ShowNotice(noticeData)
    end
  end,
  default = function(self, noticeData)
    if noticeData:GetIsMerge() then
      self:DeleteNoticeByType(noticeData.type)
    end
    self:__AddNotice2List(noticeData)
    self:ShowNotice(noticeData)
  end
}

function NoticeManager:AddNotice(noticeData)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Message_Push) then
    return
  end
  local homeSideInfoCfg = ConfigData.homeside_info[noticeData.type]
  local isOFF = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetNoticeSwitchOff()[noticeData.type]
  if isOFF and homeSideInfoCfg.switch_type ~= nil and homeSideInfoCfg.switch_type ~= 0 then
    return
  end
  local donnotAddReddot = false
  local isThisTypeUnlock = homeSideInfoCfg.info_type ~= 0
  if isThisTypeUnlock then
    if noticeFuncTable[noticeData.type] ~= nil then
      donnotAddReddot = noticeFuncTable[noticeData.type](self, noticeData)
    else
      donnotAddReddot = noticeFuncTable.default(self, noticeData)
    end
  else
    return
  end
  if not donnotAddReddot and self.sideNoticeList ~= nil then
    local noticeNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Notice)
    self.redDotCount = self.redDotCount + (noticeData:IsNeedRedDot() and 1 or 0)
    noticeNode:SetRedDotCount(self.redDotCount)
  end
end

function NoticeManager:GetIsHaveThisTypeNotice(type)
  for _, sideNoticeData in pairs(self.sideNoticeList) do
    if sideNoticeData.type == type then
      return true
    end
  end
  return false
end

function NoticeManager:DeleteNotice(noticeData)
  table.removebyvalue(self.sideNoticeList, noticeData)
  local noticeNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Notice)
  self.redDotCount = self.redDotCount - (noticeData:IsNeedRedDot() and 1 or 0)
  noticeNode:SetRedDotCount(self.redDotCount)
end

function NoticeManager:DeleteNoticeByType(type)
  for i = #self.sideNoticeList, 1, -1 do
    if self.sideNoticeList[i].type == type then
      self.redDotCount = self.redDotCount - (self.sideNoticeList[i]:IsNeedRedDot() and 1 or 0)
      table.remove(self.sideNoticeList, i)
    end
  end
  local noticeNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Notice)
  noticeNode:SetRedDotCount(self.redDotCount)
end

function NoticeManager:DeleteNoticeByFunc(func)
  for i = #self.sideNoticeList, 1, -1 do
    if func(self.sideNoticeList[i]) then
      self.redDotCount = self.redDotCount - (self.sideNoticeList[i]:IsNeedRedDot() and 1 or 0)
      table.remove(self.sideNoticeList, i)
    end
  end
  local noticeNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Notice)
  noticeNode:SetRedDotCount(self.redDotCount)
end

function NoticeManager:__AddNotice2List(noticeData)
  if not noticeData:GetIsPutInHomeside() then
    return
  end
  local left = 1
  local right = #self.sideNoticeList
  local mid
  while left <= right do
    mid = (left + right) // 2
    if self.sideNoticeList[mid].timeStamp >= noticeData.timeStamp then
      left = mid + 1
    else
      right = mid - 1
    end
  end
  table.insert(self.sideNoticeList, left, noticeData)
end

function NoticeManager:ShowNotice(noticeData)
  UIManager:ShowWindowAsync(UIWindowTypeID.NoticeMessagePush, function(window)
    if window == nil then
      return
    end
    window:AddNotice(noticeData, self.__IsPauseNotice)
  end)
end

function NoticeManager:PuaseShowNotice(way)
  self.__pauseLocksDic[way] = true
  if self.__IsPauseNotice then
    return
  end
  self.__IsPauseNotice = true
  local win = UIManager:GetWindow(UIWindowTypeID.NoticeMessagePush)
  if win ~= nil then
    win:PuaseShowNotice()
    return
  end
end

function NoticeManager:ContinueShowNotice(way)
  self.__pauseLocksDic[way] = nil
  if self.__pauseLocksDic ~= nil and table.count(self.__pauseLocksDic) > 0 then
    return
  end
  if GuideManager.inGuide then
    return
  end
  if self.__IsPauseNotice == false then
    return
  end
  self.__IsPauseNotice = false
  local win = UIManager:GetWindow(UIWindowTypeID.NoticeMessagePush)
  if win ~= nil then
    win:ContinueShowNotice()
    return
  end
end

function NoticeManager:ForceContinueShowNotice()
  if GuideManager.inGuide then
    return
  end
  if self.__IsPauseNotice == false then
    return
  end
  self.__IsPauseNotice = false
  local win = UIManager:GetWindow(UIWindowTypeID.NoticeMessagePush)
  if win ~= nil then
    win:ContinueShowNotice()
    return
  end
end

function NoticeManager:GetSideNoticeList()
  return self.sideNoticeList
end

function NoticeManager:CleanAllNotice()
  self.sideNoticeList = {}
  self.redDotCount = 0
  local noticeNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Notice)
  noticeNode:SetRedDotCount(self.redDotCount)
end

function NoticeManager:OnLogOut()
  self.preConditionDick = {}
  self.sideNoticeList = {}
  self.redDotCount = 0
  self.__IsPauseNotice = true
  self.__pauseLocksDic = {}
  local win = UIManager:GetWindow(UIWindowTypeID.NoticeMessagePush)
  if win ~= nil then
    win:Delete()
  end
end

function NoticeManager:RefreshDungeonRewardRateNotice(isPassDay, isLogIn)
  local timepassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, false)
  local weekNum = timepassCtrl:GetLogicWeekNum()
  if isLogIn then
    local lastLogoutWeekTs = PlayerDataCenter.inforData:GetLastOffLinTem()
    if PlayerDataCenter.timestamp - lastLogoutWeekTs < 86400 then
      local lastLogoutWeekNum = timepassCtrl:GetLogicWeekNum(lastLogoutWeekTs)
      if lastLogoutWeekNum == weekNum then
        return
      end
    end
  end
  local dungeonTypeDic = {}
  local isHaveDouble, dungeonTypeList = PlayerDataCenter.playerBonus:GetDungeonMultReward(nil, weekNum)
  local isHaveDouble2, dungeonTypeList2 = PlayerDataCenter.playerBonus:GetDungeonMultReward(nil, 0)
  isHaveDouble = isHaveDouble or isHaveDouble2
  if not isHaveDouble then
    return
  end
  for index, value in ipairs(dungeonTypeList) do
    dungeonTypeDic[value] = true
  end
  for index, value in ipairs(dungeonTypeList2) do
    dungeonTypeDic[value] = true
  end
  for dungeonTypeId, _ in pairs(dungeonTypeDic) do
    local dungeonSystemIdList = ConfigData.material_dungeon.dungeonTypeDic[dungeonTypeId]
    local theDungeonSystemId
    if dungeonSystemIdList ~= nil then
      for _, dungeonSystemId in pairs(dungeonSystemIdList) do
        if FunctionUnlockMgr:ValidateUnlock(dungeonSystemId) and (theDungeonSystemId == nil or dungeonSystemId > theDungeonSystemId) then
          theDungeonSystemId = dungeonSystemId
        end
      end
    else
    end
    if theDungeonSystemId ~= nil then
      local dungeonCfg = ConfigData.material_dungeon[theDungeonSystemId]
      local jumpType
      if dungeonCfg.ui_type == eDungeonEnum.eDungeonType.matDungeon then
        jumpType = JumpManager.eJumpTarget.resourceDungeon
      elseif dungeonCfg.ui_type == eDungeonEnum.eDungeonType.ATHDungeon then
        jumpType = JumpManager.eJumpTarget.ATHDungeon
      elseif dungeonCfg.ui_type == eDungeonEnum.eDungeonType.fragDungeon then
        jumpType = JumpManager.eJumpTarget.fragDungeon
        theDungeonSystemId = nil
      end
      local dungeonName = LanguageUtil.GetLocaleText(dungeonCfg.name)
      self:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, self.eNoticeType.dungeonMultReward, {
        jumpType = jumpType,
        argList = {theDungeonSystemId}
      }, {dungeonName}, nil))
    end
  end
end

NoticeManager:Init()
return NoticeManager
