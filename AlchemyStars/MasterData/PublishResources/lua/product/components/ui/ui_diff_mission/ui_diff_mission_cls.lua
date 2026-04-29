local DiffMissionChapterStatus = {
  Lock = 0,
  Open = 1,
  Finish = 2
}
_enum("DiffMissionChapterStatus", DiffMissionChapterStatus)
local DiffMissionNodeStatus = {
  Lock = 0,
  Open = 1,
  Finish = 2
}
_enum("DiffMissionNodeStatus", DiffMissionNodeStatus)
local DiffMissionType = {
  Normal = 0,
  Boss = 1,
  Next = 2
}
_enum("DiffMissionType", DiffMissionType)
local EntiesType = {
  ElementType_None = 3001,
  ElementType_Prof = 3002,
  ElementType_Force = 3004,
  ElementType_Star = 3005,
  ElementType_Elem = 3006,
  ElementType_Level_Count = 3007,
  ElementType_Round_Count = 3008
}
_enum("EntiesType", EntiesType)
local EntiesCompareType = {
  ElementCompareType_All = 1,
  ElementCompareType_No = 2,
  ElementCompareType_Less = 3,
  ElementCompareType_More = 4,
  ElementCompareType_Equal = 5
}
_enum("EntiesCompareType", EntiesCompareType)
_class("DiffMissionNode", Object)
DiffMissionNode = DiffMissionNode

function DiffMissionNode:Constructor(nodeID, chapterID, wayPointID, info, next)
  self._wayPointID = wayPointID
  self._chapterID = chapterID
  if next then
    self._isNext = true
    return
  else
    self._isNext = false
  end
  self._nodeID = nodeID
  self._info = info
  self._bossCg = ""
  self._cfg = Cfg.cfg_difficulty_parent_mission[nodeID]
  if not self._cfg then
    Log.error("###[DiffMissionNode] cfg is nil ! id --> ", nodeID)
  end
  self._cups = self._info.complete_enties
  self._allCups = self._cfg.Enties
  self._lock = DiffMissionNodeStatus.Lock
  self._stages = {}
  for i = 1, #self._cfg.SubMissionList do
    local stageid = self._cfg.SubMissionList[i]
    local data
    if info and info.sub_mission_infos then
      for j = 1, #info.sub_mission_infos do
        if info.sub_mission_infos[j].mission_id == stageid then
          data = info.sub_mission_infos[j]
          break
        end
      end
    end
    local stage = DiffMissionStage:New(stageid, data)
    self._stages[i] = stage
  end
end

function DiffMissionNode:ChapterID()
  return self._chapterID
end

function DiffMissionNode:Boss()
  local cfg = Cfg.cfg_diff_mission_way_point[self._wayPointID]
  if cfg.BossCg then
    return cfg.BossCg
  end
  return self._bossCg
end

function DiffMissionNode:SetNext(next)
  self._isNext = next
end

function DiffMissionNode:Next()
  return self._isNext
end

function DiffMissionNode:SetLockState(state)
  self._lock = state
end

function DiffMissionNode:Status()
  return self._info.status
end

function DiffMissionNode:ID()
  return self._nodeID
end

function DiffMissionNode:WayPointID()
  return self._wayPointID
end

function DiffMissionNode:PreMission()
  return self._cfg.PreMission
end

function DiffMissionNode:CupNum()
  return #self._cups, #self._allCups
end

function DiffMissionNode:AllCups()
  return self._allCups or {}
end

function DiffMissionNode:Cups()
  return self._cups or {}
end

function DiffMissionNode:Idx()
  return "idx tmp"
end

function DiffMissionNode:Name()
  return self._cfg.Name
end

function DiffMissionNode:NodeName()
  local cfg = Cfg.cfg_diff_mission_way_point[self._wayPointID]
  if cfg and cfg.Name then
    return cfg.Name
  end
  return ""
end

function DiffMissionNode:StageList()
  return self._stages
end

function DiffMissionNode:Lock()
  return self._lock
end

function DiffMissionNode:Type()
  return self._cfg.Type
end

function DiffMissionNode:Pos()
  local cfg = Cfg.cfg_diff_mission_way_point[self._wayPointID]
  if cfg.Pos then
    return Vector2(cfg.Pos[1], cfg.Pos[2])
  end
end

_class("DiffMissionChapter", Object)
DiffMissionChapter = DiffMissionChapter

function DiffMissionChapter:Constructor(id, missionChapterID)
  self._id = id
  self._missionid = missionChapterID
  self._nodes = {}
  local cfg = Cfg.cfg_difficulty_mission_chapter({DifficultyChapterID = id})
  if cfg then
    for i = 1, #cfg do
      self._nodes[#self._nodes + 1] = cfg[i].ParentMissionID
    end
  end
end

function DiffMissionChapter:ID()
  return self._id
end

function DiffMissionChapter:MissionChapterID()
  return self._missionid
end

function DiffMissionChapter:Name()
  local cfg = Cfg.cfg_difficulty_mission_chapter_desc[self._id]
  return cfg.Name
end

function DiffMissionChapter:Icon()
  return ""
end

function DiffMissionChapter:Nodes()
  return self._nodes
end

function DiffMissionChapter:SetLock(lock)
  self._lock = lock
end

function DiffMissionChapter:Lock()
  return self._lock
end

_class("DiffMissionStage", Object)
DiffMissionStage = DiffMissionStage

function DiffMissionStage:Constructor(stageID, info)
  self._status = DiffMissionNodeStatus.Lock
  self._stageID = stageID
  local cfg = Cfg.cfg_difficulty_sub_mission[self._stageID]
  if not cfg then
    Log.error("###[DiffMissionStage] cfg is nil ! id --> ", self._stageID)
  end
  self._levelID = cfg.FightLevel
  self._stageName = cfg.MissionName
  if cfg.type == 1 then
    self._type = DiffMissionType.Normal
  else
    self._type = DiffMissionType.Boss
  end
  local team = {}
  if info and info.pet_list and next(info.pet_list) then
    team = info.pet_list
  end
  self._team = Team:New()
  self._team:Init(1, "", team)
  self._RecommendAwaken = cfg.RecommendAwaken or 0
  self._RecommendLV = cfg.RecommendLV or 0
end

function DiffMissionStage:ID()
  return self._stageID
end

function DiffMissionStage:Team()
  return self._team
end

function DiffMissionStage:ClearTeam()
  local team = {}
  self._team:Init(1, "", team)
end

function DiffMissionStage:Type()
  return self._type
end

function DiffMissionStage:Name()
  return self._stageName
end

function DiffMissionStage:LevelID()
  return self._levelID
end

function DiffMissionStage:RecommendLV()
  return self._RecommendLV
end

function DiffMissionStage:RecommendAwaken()
  return self._RecommendAwaken
end
