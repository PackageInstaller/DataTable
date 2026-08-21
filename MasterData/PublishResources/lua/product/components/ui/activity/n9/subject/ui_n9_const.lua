_class("UIN9Const", Object)
UIN9Const = UIN9Const

function UIN9Const:Constructor()
end

function UIN9Const.GetGradeLevelStr(gradeLevel)
  local cfg = Cfg.cfg_subject_test_grade({ID = gradeLevel})
  if not cfg then
    return "--"
  end
  if table.count(cfg) < 0 then
    return "--"
  end
  return StringTable.Get(cfg[1].GradeName)
end

function UIN9Const.GetGradeLevel(subjectCount)
  local cfg = Cfg.cfg_subject_test_grade({})
  local gradeLevel = 0
  local index = 0
  for i = 1, #cfg do
    if subjectCount < cfg[i].SubjectCount then
      if 1 < i then
        gradeLevel = cfg[i - 1].ID
      end
      break
    end
    index = index + 1
  end
  if index >= #cfg then
    gradeLevel = cfg[#cfg].ID
  end
  return gradeLevel
end

function UIN9Const:GetGradeResult(subjectCount)
  local level = self.GetGradeLevel(subjectCount)
  return self.GetGradeLevelStr(level)
end

function UIN9Const.GetNewOpenSubjectLevelStatusKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "NEWOPENSUBJECTLEVELSTATUS"
  return key
end

function UIN9Const.HasNewOpenSubjectLevel(subjectComponentInfo)
  local cfgs = UIN9Const.GetLevelConfig()
  if not cfgs then
    return false
  end
  local key = UIN9Const.GetNewOpenSubjectLevelStatusKey()
  local historyTime = 0
  if UnityEngine.PlayerPrefs.HasKey(key) then
    historyTime = UnityEngine.PlayerPrefs.GetFloat(key)
  end
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime()
  Log.info("UIN9Const.ResetNewOpenSubjectLevelStatus() key = ", key, " nowTime = ", nowTime, " historyTime = ", historyTime)
  local levels = subjectComponentInfo.levels
  for _, cfg in pairs(cfgs) do
    if cfg.OpenType == 2 and levels then
      for _, level in pairs(levels) do
        if level.level_id == cfg.LevelId and level.grade == cfg.Grade then
          local openTime = level.opentime * 1000
          if nowTime >= openTime and historyTime < openTime then
            return true
          end
          break
        end
      end
    end
  end
  return false
end

function UIN9Const.ResetNewOpenSubjectLevelStatus()
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime()
  local key = UIN9Const.GetNewOpenSubjectLevelStatusKey()
  UnityEngine.PlayerPrefs.SetFloat(key, nowTime)
  Log.info("UIN9Const.ResetNewOpenSubjectLevelStatus() key = ", key, " nowTime = ", nowTime)
end

function UIN9Const.GetAllSubject()
  local cfgs = Cfg.cfg_subject_library({})
  local subject = {}
  for i = 1, #cfgs do
    subject[#subject + 1] = UIN9SubjectData:New(cfgs[i])
  end
  return subject
end

function UIN9Const.SetCheckIds(args)
  UIN9Const.CheckData = args
end

function UIN9Const.GetAssiginedSubjects()
  local cfgs = Cfg.cfg_subject_library({})
  local subject = {}
  if UIN9Const.CheckData then
    for i = 1, #cfgs do
      for k, v in pairs(UIN9Const.CheckData) do
        if i == v then
          subject[#subject + 1] = UIN9SubjectData:New(cfgs[i])
        end
      end
    end
  else
    subject = UIN9Const.GetAllSubject()
  end
  UIN9Const.CheckData = nil
  return subject
end

function UIN9Const.GetLevelConfig()
  return ConfigServiceHelper.GetConfigMessageByAttr(Cfg.cfg_subject_level, "ComponentID", 101010208)
end
