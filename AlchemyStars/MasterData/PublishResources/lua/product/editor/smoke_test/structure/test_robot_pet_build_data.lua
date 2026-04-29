require("team_build_seat_info")
_class("TestRobotPetBuildData", Object)
TestRobotPetBuildData = TestRobotPetBuildData

function TestRobotPetBuildData:Constructor(templateID, level, awakening, grade, intimacy, equip, refine)
  self._templateID = templateID
  self._level = level
  self._awakening = awakening
  self._grade = grade
  self._intimacy = intimacy
  self._equip = equip
  self._refine = refine
end

function TestRobotPetBuildData:GetTemplateID()
  return self._templateID
end

local _gradeCfgCache = {}

local function _GetGradeConfigCache(templateID)
  if _gradeCfgCache[templateID] then
    return _gradeCfgCache[templateID]
  end
  local awakeningConfig = Cfg.cfg_pet_awakening({PetID = templateID})
  table.sort(awakeningConfig, function(a, b)
    if a.Awakening ~= b.Awakening then
      return a.Awakening < b.Awakening
    else
      return a.ID < b.ID
    end
  end)
  _gradeCfgCache[templateID] = awakeningConfig
  return awakeningConfig
end

local _affinityCfgCache = {}

local function _GetAffinityConfigCache(templateID)
  if _affinityCfgCache[templateID] then
    return _affinityCfgCache[templateID]
  end
  local affinityConfig = Cfg.cfg_pet_affinity({PetID = templateID})
  table.sort(affinityConfig, function(a, b)
    if a.AffinityLevel ~= b.AffinityLevel then
      return a.AffinityLevel < b.AffinityLevel
    else
      return a.ID < b.ID
    end
  end)
  _affinityCfgCache[templateID] = affinityConfig
  return affinityConfig
end

local _awakeningCfgCache = {}

local function _GetAwakeningConfigCache(templateID)
  if _awakeningCfgCache[templateID] then
    return _awakeningCfgCache[templateID]
  end
  local gradeConfig = Cfg.cfg_pet_grade({PetID = templateID})
  table.sort(gradeConfig, function(a, b)
    if a.Grade ~= b.Grade then
      return a.Grade < b.Grade
    else
      return a.ID < b.ID
    end
  end)
  _awakeningCfgCache[templateID] = gradeConfig
  return gradeConfig
end

local _levelCfgCache = {}

local function _GetLevelConfigCache(templateID, grade)
  if not _levelCfgCache[templateID] then
    _levelCfgCache[templateID] = {}
  end
  if _levelCfgCache[templateID][grade] then
    return _levelCfgCache[templateID][grade]
  end
  local levelConfig = Cfg["cfg_pet_level_" .. templateID .. "_" .. grade]()
  local t = {}
  for _, row in pairs(levelConfig) do
    table.insert(t, row)
  end
  table.sort(t, function(a, b)
    if a.Level ~= b.Level then
      return a.Level < b.Level
    else
      return a.ID < b.ID
    end
  end)
  _levelCfgCache[templateID][grade] = t
  return t
end

function TestRobotPetBuildData:SanityFix()
  local templateID = self._templateID
  local awakeningConfig = _GetAwakeningConfigCache(templateID)
  local last = awakeningConfig[#awakeningConfig]
  if self._awakening > last.Grade then
    self._awakening = last.Grade
  end
  if Cfg.cfg_tale_pet[templateID] then
    self._awakening = 3
  end
  local affinityConfig = _GetAffinityConfigCache(templateID)
  local lastAffinity = affinityConfig[#affinityConfig]
  if self._intimacy > lastAffinity.AffinityLevel then
    self._intimacy = lastAffinity.AffinityLevel
  end
  local gradeConfig = _GetGradeConfigCache(templateID)
  local lastGrade = gradeConfig[#gradeConfig]
  if self._grade > lastGrade.Awakening then
    self._grade = lastGrade.Awakening
  end
  local levelConfig = _GetLevelConfigCache(templateID, self._awakening)
  local lastLevel = levelConfig[#levelConfig]
  if self._level > lastLevel.Level then
    self._level = lastLevel.Level
  end
  if self._equip < 1 then
    self._equip = 1
  end
  if self._equip > 10 then
    self._equip = 10
  end
  if self._refine and self._refine > 0 then
    if self._awakening ~= 3 or self._level ~= 80 or self._equip ~= 10 then
      self._refine = 0
    else
      local cfgEquipRefine = Cfg.cfg_pet_equip_refine({
        PetID = self._templateID
      })
      if cfgEquipRefine and 0 < #cfgEquipRefine then
        local level = 0
        for _, c in ipairs(cfgEquipRefine) do
          level = math.max(level, c.Level)
        end
        self._refine = math.min(self._refine, level)
      else
        self._refine = 0
      end
    end
  end
end

function TestRobotPetBuildData:GenerateGMCommand()
  local cmd = ""
  local testRobotModule = GameGlobal.GetModule(TestRobotModule)
  if testRobotModule:IsCNVersion() then
    cmd = string.format("ChangePet %s %s %s %s %s %s %s", LocalDB.GetString("OpenIdTest"), self._templateID, self._level, self._awakening, self._grade, self._intimacy, self._equip)
  else
    cmd = string.format("ChangePet %s %s %s %s %s %s %s %s", LocalDB.GetString("OpenIdTest"), self._templateID, self._level, self._awakening, self._grade, self._intimacy, self._equip, self._refine)
  end
  return cmd
end

function TestRobotPetBuildData:__tostring()
  return string.format("templateID: %s, level: %s, awakening: %s, grade: %s, intimacy: %s, equip: %s, refine: %s", tostring(self._templateID), tostring(self._level), tostring(self._awakening), tostring(self._grade), tostring(self._intimacy), tostring(self._equip), tostring(self._refine))
end

function TestRobotPetBuildData.__eq(a, b)
  return a._templateID == b._templateID
end

function TestRobotPetBuildData.GenerateForSeat(templateID, seatInfo)
  return TestRobotPetBuildData:New(templateID, seatInfo.level, seatInfo.awakening, seatInfo.grade, seatInfo.intimacy, seatInfo.equip, seatInfo.refine)
end
