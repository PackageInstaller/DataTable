_class("UIN16SubjectLevelGradeData", Object)
UIN16SubjectLevelGradeData = UIN16SubjectLevelGradeData

function UIN16SubjectLevelGradeData:Constructor(cfg, subjectComponentInfo)
  self._levelId = cfg.LevelId
  self._grade = cfg.Grade
  self._gradeId = cfg.GradeId
  self._des = StringTable.Get(cfg.Des)
  self._name = StringTable.Get(cfg.Name)
  self._levelType = cfg.LevelType
  self._failedCount = cfg.FailedCount
  self._openType = cfg.OpenType
  self._answerTime = cfg.AnswerTime
  self._rewards = cfg.Reward
  self._positionIndex = cfg.PositionIndex
  local gradeCft = Cfg.cfg_n16_subject_level_grade({
    ID = self._gradeId
  })
  self._subjectLibaray = {}
  local library = gradeCft[1].SubjectLibrary
  if library then
    local preMaxIndex = 0
    for i = 1, #library do
      if preMaxIndex >= library[i][1] then
        Log.exception("cfg_n16_subject_level_grade 题库列表配置错误:", self._gradeId)
      else
        for j = library[i][1], library[i][2] do
          self._subjectLibaray[#self._subjectLibaray + 1] = j
        end
        preMaxIndex = library[i][2]
      end
    end
  end
  self._selectRole = gradeCft[1].SelectRole
  self._hasComplete = false
  local rewarded_levels = subjectComponentInfo.rewarded_levels
  for i = 1, #rewarded_levels do
    if rewarded_levels[i].level_id == self._levelId and rewarded_levels[i].grade == self._grade then
      self._hasComplete = true
      break
    end
  end
  local levels = subjectComponentInfo.levels
  self._openTime = 0
  if levels then
    for k, v in pairs(levels) do
      if v.level_id == self._levelId and v.grade == self._grade then
        self._openTime = v.opentime
        if not self._openTime then
          self._openTime = 0
        end
        break
      end
    end
  end
end

function UIN16SubjectLevelGradeData:GetGrade()
  return self._grade
end

function UIN16SubjectLevelGradeData:GetDes()
  return self._des
end

function UIN16SubjectLevelGradeData:GetName()
  return self._name
end

function UIN16SubjectLevelGradeData:GetLevelType()
  return self._levelType
end

function UIN16SubjectLevelGradeData:GetFailedCount()
  return self._failedCount
end

function UIN16SubjectLevelGradeData:GetOpenType()
  return self._openType
end

function UIN16SubjectLevelGradeData:GetOpenTime()
  return self._openTime
end

function UIN16SubjectLevelGradeData:GetRewards()
  return self._rewards
end

function UIN16SubjectLevelGradeData:GetPositionIndex()
  return self._positionIndex
end

function UIN16SubjectLevelGradeData:GetHasComplete()
  return self._hasComplete
end

function UIN16SubjectLevelGradeData:GetAnswerTime()
  return self._answerTime
end

function UIN16SubjectLevelGradeData:GenSubject()
  local tmpCfgs = {}
  for i = 1, #self._subjectLibaray do
    local cfgs = Cfg.cfg_n16_subject_library({
      ID = self._subjectLibaray[i]
    })
    local cfg = cfgs[1]
    local grade = cfg.Grade
    if not tmpCfgs[grade] then
      tmpCfgs[grade] = {}
    end
    tmpCfgs[grade][#tmpCfgs[grade] + 1] = cfg
  end
  local subject = {}
  local preMaxIndex = 0
  for i = 1, #self._selectRole do
    if preMaxIndex >= self._selectRole[i][1] then
      Log.exception("cfg_n16_subject_level_grade 选择规则错误配置错误:", self._gradeId)
    else
      if self._selectRole[i][3] then
        local cfgs = tmpCfgs[self._selectRole[i][3]]
        if #cfgs <= 0 then
          Log.exception("cfg_n16_subject_level_grade 题目数量不够，策划之前拍过胸脯说题目数量一定会够:", self._gradeId)
          break
        end
        for j = self._selectRole[i][1], self._selectRole[i][2] do
          local index = math.random(1, #cfgs)
          subject[#subject + 1] = UIN16SubjectData:New(cfgs[index])
          table.remove(cfgs, index)
          if #cfgs <= 0 then
            Log.exception("cfg_n16_subject_level_grade 题目数量不够，策划之前拍过胸脯说题目数量一定会够:", self._gradeId)
            break
          end
        end
      else
        Log.exception("cfg_n16_subject_level_grade 选择规则错误配置错误:", self._gradeId)
      end
      preMaxIndex = self._selectRole[i][2]
    end
  end
  return subject
end

_class("UIN16SubjectLevelData", Object)
UIN16SubjectLevelData = UIN16SubjectLevelData

function UIN16SubjectLevelData:Constructor(cfgs, subjectComponentInfo)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._historyRecord = subjectComponentInfo.test_score
  self._gradeLevel = 0
  if self._historyRecord ~= nil and self._historyRecord > 0 then
    self._gradeLevel = UIN16Const.GetGradeLevel(self._historyRecord)
  end
  self._levelGrades = {}
  if not cfgs then
    return
  end
  for k, v in pairs(cfgs) do
    local gradeData = UIN16SubjectLevelGradeData:New(v, subjectComponentInfo)
    self._levelGrades[#self._levelGrades + 1] = gradeData
  end
  table.sort(self._levelGrades, function(a, b)
    return a:GetGrade() < b:GetGrade()
  end)
end

function UIN16SubjectLevelData:IsOpen()
  if #self._levelGrades <= 0 then
    return false
  end
  local levelGradeData = self._levelGrades[1]
  local openType = levelGradeData:GetOpenType()
  if openType == 2 then
    local openTime = levelGradeData:GetOpenTime()
    local nowTime = self._timeModule:GetServerTime() / 1000
    if openTime <= nowTime then
      return true
    end
    return false
  end
  return true
end

function UIN16SubjectLevelData:GetOpenTimeStr()
  if #self._levelGrades <= 0 then
    return ""
  end
  local openTime = self._levelGrades[1]:GetOpenTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(openTime - nowTime)
  if seconds < 0 then
    seconds = 0
  end
  if seconds == 0 then
    return ""
  end
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_activity_n16_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_activity_n16_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_activity_n16_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get("str_activity_n16_minus", minus)
    end
  else
    timeStr = StringTable.Get("str_activity_n16_less_minus")
  end
  return timeStr
end

function UIN16SubjectLevelData:GetHistoryRecord()
  return self._historyRecord
end

function UIN16SubjectLevelData:GetGradeLevelStr()
  return UIN16Const.GetGradeLevelStr(self._gradeLevel)
end

function UIN16SubjectLevelData:GetPositionIndex()
  if #self._levelGrades <= 0 then
    return -1
  end
  return self._levelGrades[1]:GetPositionIndex()
end

function UIN16SubjectLevelData:GetLevelName()
  if #self._levelGrades <= 0 then
    return ""
  end
  return self._levelGrades[1]:GetName()
end

function UIN16SubjectLevelData:GetDes()
  if #self._levelGrades <= 0 then
    return ""
  end
  return self._levelGrades[1]:GetDes()
end

function UIN16SubjectLevelData:GetLevelType()
  if #self._levelGrades <= 0 then
    return ""
  end
  return self._levelGrades[1]:GetLevelType()
end

function UIN16SubjectLevelData:GetLeveGrade(grade)
  local levelType = self:GetLevelType()
  if levelType == 2 then
    return self._levelGrades[1]
  end
  for i = 1, #self._levelGrades do
    if grade == self._levelGrades[i]:GetGrade() then
      return self._levelGrades[i]
    end
  end
  return nil
end

function UIN16SubjectLevelData:GetLevelGradeList()
  local gradeList = {}
  for i = 1, #self._levelGrades do
    gradeList[#gradeList + 1] = self._levelGrades[i]:GetGrade()
  end
  return gradeList
end

function UIN16SubjectLevelData:GetLevelGradCount()
  local gradeList = self:GetLevelGradeList()
  return #gradeList
end

function UIN16SubjectLevelData:GetCompleteGradeCount()
  local count = 0
  for i = 1, #self._levelGrades do
    if self._levelGrades[i]:GetHasComplete() then
      count = count + 1
    end
  end
  return count
end

function UIN16SubjectLevelData:GradeComplete(grade)
  for i = 1, #self._levelGrades do
    if grade == self._levelGrades[i]:GetGrade() then
      return self._levelGrades[i]:GetHasComplete()
    end
  end
  return false
end

function UIN16SubjectLevelData:GetGradeCount()
  return table.count(self._levelGrades)
end

_class("UIN16SubjectLevelDatas", Object)
UIN16SubjectLevelDatas = UIN16SubjectLevelDatas

function UIN16SubjectLevelDatas:Constructor(subjectComponentInfo)
  self._levels = {}
  local cfgs = ConfigServiceHelper.GetConfigMessageByAttr(Cfg.cfg_subject_level, "ComponentID", 102610208)
  if not cfgs then
    return
  end
  local levelCfgs = {}
  for k, v in pairs(cfgs) do
    local levelId = v.LevelId
    if not levelCfgs[levelId] then
      levelCfgs[levelId] = {}
    end
    levelCfgs[levelId][#levelCfgs[levelId] + 1] = v
  end
  for k, v in pairs(levelCfgs) do
    local levelData = UIN16SubjectLevelData:New(v, subjectComponentInfo)
    self._levels[#self._levels + 1] = levelData
  end
end

function UIN16SubjectLevelDatas:GetLevelDatas()
  return self._levels
end
