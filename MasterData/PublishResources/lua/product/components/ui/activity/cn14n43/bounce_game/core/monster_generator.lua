local RecursionGenType = {
  None = 0,
  Always = 1,
  Times = 2
}
_enum("RecursionGenType", RecursionGenType)
_class("MonsterGenerator", Object)
MonsterGenerator = MonsterGenerator

function MonsterGenerator:Init(cfgId, genCall)
  self.generatorId = cfgId
  self.generatorCall = genCall
  self.durationMs = 0
  self.cfg = Cfg.cfg_bounce_monster_gen[cfgId]
  self.genBatchs = {}
  if not self.cfg then
    Log.fatal("err:MonsterGenerator can't find cfg_bounce_monster_gen with id = " .. cfgId)
    return
  end
  self.recursionMaxTimes = 0
  local recursion = self.cfg.Recursion
  if not recursion or recursion == 0 then
    self.recursionType = RecursionGenType.None
  elseif recursion < 0 then
    self.recursionType = RecursionGenType.Always
  else
    self.recursionType = RecursionGenType.Times
    self.recursionMaxTimes = recursion
  end
  self.recursionTimes = 0
  self.durationPerRecurion = 0
  for i, v in ipairs(self.cfg.Product) do
    local batch = MonsterGeneratorBatch.New()
    local batchDelay = v[1]
    local batchRuleId = v[2]
    local ruleCfg = Cfg.cfg_bounce_monster_gen_rule[batchRuleId]
    if not ruleCfg then
      Log.fatal("MonsterGenerator err: can't find cfg_bounce_monster_rule with id = " .. batchRuleId)
      return
    end
    batch.ruleCfg = ruleCfg
    batch.offsetMs = self.durationPerRecurion + batchDelay
    batch.duration = ruleCfg.Num * ruleCfg.Interval
    self.durationPerRecurion = batch.offsetMs + batch.duration
    batch.hasGenNum = 0
    table.insert(self.genBatchs, batch)
  end
end

function MonsterGenerator:SetCoreController(coreController)
  self.coreController = coreController
  self.monsterPool = self.coreController:GetMonsterPool()
  self.objMgr = self.coreController:GetObjMgr()
  self.monsterParentRt = self.coreController:GetObjectsRoot()
end

function MonsterGenerator:Reset()
  self.durationMs = 0
  self.recursionTimes = 0
  self.genTaskOver = nil
  for k, batch in pairs(self.genBatchs) do
    batch.hasGenNum = 0
  end
  self.nextGenrator = nil
end

function MonsterGenerator:OnUpdate(durationMs)
  if self.genTaskOver then
    if self.nextGenrator then
      self.nextGenrator:OnUpdate(durationMs)
    end
    return
  end
  self.durationMs = self.durationMs + durationMs
  local ruleCfg
  local isGenAll = true
  for k, batch in pairs(self.genBatchs) do
    if not batch:IsGenFull() then
      isGenAll = false
      local nextGenTime = batch:GetNextGenTime() + self.recursionTimes * self.durationPerRecurion
      if nextGenTime <= self.durationMs then
        ruleCfg = batch:GetRuleCfg()
        batch.hasGenNum = batch.hasGenNum + 1
      end
      break
    end
  end
  if isGenAll then
    self.recursionTimes = self.recursionTimes + 1
    if self.recursionType == RecursionGenType.None then
      self.genTaskOver = true
      self:InitNextGenerator()
    elseif self.recursionType == RecursionGenType.Always then
      for k, v in pairs(self.genBatchs) do
        v:Reset()
      end
    elseif self.recursionType == RecursionGenType.Times then
      if self.recursionMaxTimes >= self.recursionMaxTimes then
        self.genTaskOver = true
        self:InitNextGenerator()
      else
        for k, v in pairs(self.genBatchs) do
          v:Reset()
        end
      end
    end
  end
  if ruleCfg then
    local monsterId = ruleCfg.Monster
    local monster = self.monsterPool:Get(monsterId)
    monster:SetCoreController(self.coreController)
    local view = monster:GetBehavior(MonsterBeHaviorView.Name())
    if view then
      view:SetParent(self.monsterParentRt)
    end
    local posBehaviour = monster:GetBehavior(MonsterBeHaviorPosition.Name())
    if posBehaviour then
      local initPos = Vector2(ruleCfg.Pos[1], ruleCfg.Pos[2])
      posBehaviour:SetPosition(initPos)
    end
    self.objMgr:AddMonster(monster)
    if self.generatorCall then
      self.generatorCall()
    end
  end
end

function MonsterGenerator:InitNextGenerator()
  if self.cfg.NextGenId then
    self.nextGenrator = MonsterGenerator:New()
    self.nextGenrator:Init(self.cfg.NextGenId, self.generatorCall)
    self.nextGenrator:SetCoreController(self.coreController)
  end
end

_class("MonsterGeneratorBatch", Object)
MonsterGeneratorBatch = MonsterGeneratorBatch

function MonsterGeneratorBatch:Constructor()
  self.ruleCfg = nil
  self.offsetMs = 0
  self.duration = 0
  self.hasGenNum = 0
end

function MonsterGeneratorBatch:Reset()
  self.hasGenNum = 0
end

function MonsterGeneratorBatch:IsGenFull()
  return self.hasGenNum == self.ruleCfg.Num
end

function MonsterGeneratorBatch:GetNextGenTime()
  return self.offsetMs + (self.hasGenNum + 1) * self.ruleCfg.Interval
end

function MonsterGeneratorBatch:GetRuleCfg()
  return self.ruleCfg
end
