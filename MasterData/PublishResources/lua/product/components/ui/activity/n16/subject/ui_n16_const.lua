_class("UIN16Const", Object)
UIN16Const = UIN16Const

function UIN16Const:Constructor()
end

function UIN16Const.GetGradeLevelStr(gradeLevel)
  local cfg = Cfg.cfg_n16_subject_test_grade({ID = gradeLevel})
  if not cfg then
    return "--"
  end
  if table.count(cfg) < 0 then
    return "--"
  end
  return StringTable.Get(cfg[1].GradeName)
end

function UIN16Const.GetGradeLevel(subjectCount)
  local cfg = Cfg.cfg_n16_subject_test_grade({})
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

function UIN16Const:GetGradeResult(subjectCount)
  local level = self.GetGradeLevel(subjectCount)
  return self.GetGradeLevelStr(level)
end

function UIN16Const.GetNewOpenSubjectLevelStatusKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "NEWOPENSUBJECTLEVELSTATUS"
  return key
end

function UIN16Const.HasNewOpenSubjectLevel(subjectComponentInfo)
  local cfgs = UIN16Const.GetLevelConfig()
  if not cfgs then
    return false
  end
  local key = UIN16Const.GetNewOpenSubjectLevelStatusKey()
  local historyTime = 0
  if UnityEngine.PlayerPrefs.HasKey(key) then
    historyTime = UnityEngine.PlayerPrefs.GetFloat(key)
  end
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime()
  Log.info("UIN16Const.ResetNewOpenSubjectLevelStatus() key = ", key, " nowTime = ", nowTime, " historyTime = ", historyTime)
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

function UIN16Const.ResetNewOpenSubjectLevelStatus()
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime()
  local key = UIN16Const.GetNewOpenSubjectLevelStatusKey()
  UnityEngine.PlayerPrefs.SetFloat(key, nowTime)
  Log.info("UIN16Const.ResetNewOpenSubjectLevelStatus() key = ", key, " nowTime = ", nowTime)
end

function UIN16Const.GetAllSubject()
  local cfgs = Cfg.cfg_n16_subject_library({})
  local subject = {}
  for i = 1, #cfgs do
    subject[#subject + 1] = UIN16SubjectData:New(cfgs[i])
  end
  return subject
end

function UIN16Const.SetCheckIds(args)
  UIN16Const.CheckData = args
end

function UIN16Const.GetAssiginedSubjects()
  local cfgs = Cfg.cfg_n16_subject_library({})
  local subject = {}
  if UIN16Const.CheckData then
    for i = 1, #cfgs do
      for k, v in pairs(UIN16Const.CheckData) do
        if i == v then
          subject[#subject + 1] = UIN16SubjectData:New(cfgs[i])
        end
      end
    end
  else
    subject = UIN16Const.GetAllSubject()
  end
  UIN16Const.CheckData = nil
  return subject
end

function UIN16Const.GetLevelConfig()
  return ConfigServiceHelper.GetConfigMessageByAttr(Cfg.cfg_subject_level, "ComponentID", 102610208)
end
