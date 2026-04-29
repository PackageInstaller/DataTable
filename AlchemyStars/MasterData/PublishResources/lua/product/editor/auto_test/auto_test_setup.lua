_class("AutoTestSetup", Object)
AutoTestSetup = AutoTestSetup

function AutoTestSetup:Constructor(setup)
  self._config = setup
end

function AutoTestSetup:BeforeLoading()
  for i, cfg in ipairs(self._config) do
    local f = self[cfg.setup .. "_Test1"]
    if f then
      f(self, cfg.args)
    end
  end
end

function AutoTestSetup:OnWaitInput(world)
  self._world = world
  for i, cfg in ipairs(self._config) do
    local f = self[cfg.setup .. "_Test2"]
    if f then
      f(self, cfg.args)
    end
  end
end

function AutoTestSetup:LevelBasic_Test1(args)
  self.matchType = args.matchType
  self.levelID = args.levelID
  self.words = args.words
  self.affixs = args.affixs
end

function AutoTestSetup:SetLevelRoundCount_Test1(args)
  local cfg = Cfg.cfg_level[self.levelID]
  self._originalRoundCount = cfg.Round
  cfg.Round = args.levelRoundCount
end

function AutoTestSetup:SetLevelRoundCount_Test2(args)
  local cfg = Cfg.cfg_level[self.levelID]
  cfg.Round = self._originalRoundCount
end

function AutoTestSetup:SetLevelWaveIDList_Test1(args)
  local cfg = Cfg.cfg_level[self.levelID]
  self._originalWaveIDList = cfg.MonsterWave
  cfg.MonsterWave = args.waveIDList
end

function AutoTestSetup:SetLevelWaveIDList_Test2(args)
  local cfg = Cfg.cfg_level[self.levelID]
  cfg.MonsterWave = self._originalWaveIDList
end

function AutoTestSetup:AddWaveMonster_Test(args)
end

function AutoTestSetup:AddWaveTrap_Test(args)
end

function AutoTestSetup:SetLevelCompleteCondition_Test(args)
end

function AutoTestSetup:AddWaveCompleteCondition_Test(args)
end
