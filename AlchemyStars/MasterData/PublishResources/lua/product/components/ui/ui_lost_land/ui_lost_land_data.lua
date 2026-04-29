local UILostLandEnterType = {
  EASY = 1,
  DIFF = 2,
  HELL = 3
}
_enum("UILostLandEnterType", UILostLandEnterType)
local UILostLandEnterLockType = {
  UNLOCK = 1,
  LOCK = 2,
  CANUNLOCK = 3,
  CHOOSE = 4
}
_enum("UILostLandEnterLockType", UILostLandEnterLockType)
local UILostLandMissionType = {
  NORMAL = 1,
  BOSS = 2,
  PLOT = 3
}
_enum("UILostLandMissionType", UILostLandMissionType)
local UILostLandMissionLockType = {
  PASS = 1,
  UNLOCK = 2,
  LOCK = 3
}
_enum("UILostLandMissionLockType", UILostLandMissionLockType)
local UILostLandFilterType = {AND = 1, OR = 2}
_enum("UILostLandFilterType", UILostLandFilterType)
local UILostLandRecommendAwardStatus = {Got = 1, Not = 2}
_enum("UILostLandRecommendAwardStatus", UILostLandRecommendAwardStatus)
_class("UILostLandEnterData", Object)
UILostLandEnterData = UILostLandEnterData

function UILostLandEnterData:Constructor(enterid, lockType, svrCfg, levelGroupCfg)
  local cfg = Cfg.cfg_lost_land_enter[enterid]
  if not cfg then
    Log.error("###[UILostLandEnterData] cfg_lost_land_enter is nil ! id --> ", enterid)
  end
  self._type = svrCfg.difficulty
  self._lockType = lockType
  self._enterID = enterid
  self._cg = cfg.BG
  self._name = cfg.EnterName
  self._recommendGrade = cfg.RecommendGrade
  self._recommendLv = cfg.RecommendLv
  local width = {
    [1] = 0,
    [2] = 0
  }
  if cfg.ShowItemWidth then
    width = {
      [1] = cfg.ShowItemWidth[1],
      [2] = cfg.ShowItemWidth[2]
    }
  end
  self._width = width
  self._condition = svrCfg.unlock_condition
  self._missionTable = self:CreateMissionTable(levelGroupCfg)
  self._viewAward = self:CreateViewAward(levelGroupCfg)
end

function UILostLandEnterData:CreateViewAward(levelGroupCfg)
  local awardMap = {}
  for key, value in pairs(levelGroupCfg) do
    local diff = value.difficulty
    if diff == self._type then
      local awards = value.award
      for i = 1, #awards do
        local award = awards[i]
        if not awardMap[award.assetid] then
          awardMap[award.assetid] = award.count
        else
          awardMap[award.assetid] = awardMap[award.assetid] + award.count
        end
      end
    end
  end
  local _awardList = {}
  for key, value in pairs(awardMap) do
    local itemAsset = ItemAsset:New()
    itemAsset.assetid = key
    itemAsset.count = value
    table.insert(_awardList, itemAsset)
  end
  table.sort(_awardList, function(a, b)
    local cfg_a = Cfg.cfg_item[a.assetid]
    local cfg_b = Cfg.cfg_item[b.assetid]
    if cfg_a.Color == cfg_b.Color then
      if cfg_a.BagSortIndex == cfg_b.BagSortIndex then
        return a.assetid < b.assetid
      else
        return cfg_a.BagSortIndex > cfg_b.BagSortIndex
      end
    else
      return cfg_a.Color > cfg_b.Color
    end
  end)
  return _awardList
end

function UILostLandEnterData:CreateMissionTable(levelGroupCfg)
  local missionTable = {}
  for key, value in pairs(levelGroupCfg) do
    local diff = value.difficulty
    if diff == self._type then
      if not missionTable[value.group_seq_id] then
        missionTable[value.group_seq_id] = {}
      end
      missionTable[value.group_seq_id][value.seq_in_group] = key
    end
  end
  return missionTable
end

function UILostLandEnterData:GetEnterID()
  return self._enterID
end

function UILostLandEnterData:GetType()
  return self._type
end

function UILostLandEnterData:GetLockState()
  return self._lockType
end

function UILostLandEnterData:UnLock()
  self._lockType = UILostLandEnterLockType.UNLOCK
end

function UILostLandEnterData:GetCg()
  return self._cg
end

function UILostLandEnterData:GetName()
  return self._name
end

function UILostLandEnterData:GetViewAward()
  return self._viewAward
end

function UILostLandEnterData:GetRecommendLv()
  return self._recommendLv
end

function UILostLandEnterData:GetRecommendGrade()
  return self._recommendGrade
end

function UILostLandEnterData:GetCondition()
  return self._condition
end

function UILostLandEnterData:GetMissionTable()
  return self._missionTable
end

function UILostLandEnterData:GetItemShowWidth()
  return self._width
end

_class("UILostLandMissionData", Object)
UILostLandMissionData = UILostLandMissionData

function UILostLandMissionData:Constructor(missionid, svrCfg, missionInfo, currentid)
  self._id = missionid
  local cfg = Cfg.cfg_lost_land_mission[missionid]
  if not cfg then
    Log.error("###[UILostLandMissionData] cfg_lost_land_mission is nil ! id --> ", missionid)
  end
  self._type = nil
  if svrCfg.level_type == 1 then
    self._type = UILostLandMissionType.NORMAL
  elseif svrCfg.level_type == 2 then
    self._type = UILostLandMissionType.BOSS
  end
  self._passTimes = missionInfo.pass_time
  if currentid ~= nil then
    if currentid == missionid then
      self._lock = UILostLandMissionLockType.UNLOCK
    elseif self._passTimes <= 0 then
      self._lock = UILostLandMissionLockType.LOCK
    else
      self._lock = UILostLandMissionLockType.PASS
    end
  else
    self._lock = UILostLandMissionLockType.PASS
  end
  self._word = missionInfo.wordd_id
  self._award = svrCfg.award
  self._missionName = cfg.MissionName
  self._petAward = missionInfo.recommend_reward_num
  self._recommendGrade = cfg.RecommendGrade
  self._recommendLv = cfg.RecommendLv
  self._levelid = missionInfo.level_id
end

function UILostLandMissionData:GetLockType()
  return self._lock
end

function UILostLandMissionData:GetPassTimes()
  return self._passTimes
end

function UILostLandMissionData:GetLevelID()
  return self._levelid
end

function UILostLandMissionData:GetType()
  return self._type
end

function UILostLandMissionData:GetID()
  return self._id
end

function UILostLandMissionData:GetWord()
  return self._word
end

function UILostLandMissionData:GetAward()
  return self._award
end

function UILostLandMissionData:GetPetAward()
  return self._petAward
end

function UILostLandMissionData:GetMissionName()
  return self._missionName
end

function UILostLandMissionData:GetRecommendLv()
  return self._recommendLv
end

function UILostLandMissionData:GetRecommendGrade()
  return self._recommendGrade
end
