local RecommeFormationSingleData = class("RecommeFormationSingleData")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local ChipData = require("Game.PlayerData.Item.ChipData")
local CSTUtil = require("Game.CommanderSkill.CSTUtil")

function RecommeFormationSingleData:ctor()
end

function RecommeFormationSingleData:SetRecommeSinglePara(isDungeon, stageId)
  self._isDungeon = isDungeon
  self._stageId = stageId
end

function RecommeFormationSingleData:InitRecommeSingleData(data, formationRuleCfg)
  self.playerId = data.uid
  self.playerName = data.name
  self.playerLevel = data.level
  self.mvpHeroId = data.mvp
  self.slotSkillList = {}
  self:__CollectSkill(data)
  self:CalculateHeroData(data.hero, formationRuleCfg)
  self.chipList = {}
  for key, value in pairs(data.alg) do
    local chipData = ChipData.New(key, value)
    table.insert(self.chipList, chipData)
  end
end

function RecommeFormationSingleData:__CollectSkill(data)
  if self._isDungeon then
    local dungeonStageCfg = ConfigData.battle_dungeon[self._stageId]
    if #dungeonStageCfg.const_cstIds > 0 then
      self._isFixedSkill = true
      self.slotSkillList = dungeonStageCfg.const_cstIds
      return
    end
  end
  self._isFixedSkill = false
  if 0 < data.cst.treeId then
    self.treeCfg = ConfigData.commander_skill[data.cst.treeId]
    if data.cst.skillGroup ~= nil and 0 < table.count(data.cst.skillGroup) then
      local skillDic = {}
      local placeMax = 0
      for skillId, _ in pairs(data.cst.skillGroup) do
        local skillCfg = self:GetSkillById(skillId, data.cst.treeId)
        if skillCfg ~= nil then
          skillDic[skillCfg.place] = skillId
          placeMax = placeMax > skillCfg.place and placeMax or skillCfg.place
        end
      end
      for i = 1, placeMax do
        if skillDic[i] ~= nil then
          table.insert(self.slotSkillList, skillDic[i])
        end
      end
    end
  end
  if self.treeCfg == nil or #self.slotSkillList == 0 then
    local defaultTreeId = ConfigData.game_config.FormationDefaultCommanderSkillTree
    local cstSavingData = CSTUtil.GetDefaultSavingData(defaultTreeId)
    local skillList = {}
    for key, e in pairs(cstSavingData.skills) do
      table.insert(skillList, e.skillId)
    end
    self.treeCfg = ConfigData.commander_skill[defaultTreeId]
    self.slotSkillList = skillList
  end
end

function RecommeFormationSingleData:GetSkillById(skillId, treeId)
  local unlockSkillCfg = ConfigData.commander_skill_unlock[treeId]
  for k, v in pairs(unlockSkillCfg) do
    if k == skillId then
      return v
    end
  end
end

function RecommeFormationSingleData:CalculateHeroData(heroMsg, formationRuleCfg)
  self.recommanHeroDic = {}
  self.firstPower = 0
  self.benchPower = 0
  self.heroCount = 0
  self.starMax = 0
  self.levelMax = 0
  self.idAddtion = 0
  
  function _ENV:LocalFunc_CalculateIndex(index, heroList)
    for i = 1, #heroList do
      index = index + 1
      self.recommanHeroDic[index] = {
        basic = HeroData.New(heroList[i]),
        power = heroList[i].power,
        position = heroList[i].position
      }
    end
    return index
  end
  
  local xMax = 0
  local yMax = 0
  local posHeroDic = {}
  local benchDic = {}
  for k, v in pairs(heroMsg) do
    local x, y = BattleUtil.Pos2XYCoord(v.position or 0)
    yMax = yMax < y and y or yMax
    if x == ConfigData.buildinConfig.BenchX then
      local yArry = benchDic[y]
      if yArry == nil then
        yArry = {}
        benchDic[y] = yArry
      end
      table.insert(yArry, v)
    else
      xMax = xMax < x and x or xMax
      local xDic = posHeroDic[x]
      if xDic == nil then
        xDic = {}
        posHeroDic[x] = xDic
      end
      local yArry = xDic[y]
      if yArry == nil then
        yArry = {}
        xDic[y] = yArry
      end
      table.insert(yArry, v)
    end
  end
  local curIndex = 0
  for x = 0, xMax do
    if posHeroDic[x] ~= nil then
      for y = 0, yMax do
        local heroList = posHeroDic[x][y]
        if heroList ~= nil and 0 < #heroList then
          curIndex = LocalFunc_CalculateIndex(self, curIndex, heroList)
        end
      end
    end
  end
  if 0 < table.count(benchDic) then
    local benchCount = 0
    for i = 0, yMax do
      if benchDic[i] ~= nil then
        benchCount = benchCount + table.count(benchDic[i])
      end
    end
    if benchCount <= formationRuleCfg.bench_num then
      curIndex = formationRuleCfg.stage_num
    else
      curIndex = formationRuleCfg.stage_num + formationRuleCfg.bench_num - benchCount
    end
    for i = 0, yMax do
      if benchDic[i] ~= nil then
        curIndex = LocalFunc_CalculateIndex(self, curIndex, benchDic[i])
      end
    end
  end
  for key, value in pairs(self.recommanHeroDic) do
    if key <= formationRuleCfg.stage_num then
      self.firstPower = self.firstPower + value.power
    else
      self.benchPower = self.benchPower + value.power
    end
    self.heroCount = self.heroCount + 1
    self.starMax = self.starMax > value.basic.star and self.starMax or value.basic.star
    self.levelMax = self.levelMax > value.basic.level and self.levelMax or value.basic.level
    self.idAddtion = self.idAddtion + value.basic.dataId
  end
  self.firstPower = self.firstPower + ConfigData.GetFormulaValue(eFormulaType.Commander, {
    power = self.firstPower
  })
  self.firstPower = math.floor(self.firstPower)
  self.power = self.firstPower + self.benchPower
end

function RecommeFormationSingleData:IsAllowCopy()
  local indexMax = ConfigData:GetFormationHeroCount()
  for index, data in pairs(self.recommanHeroDic) do
    if index <= indexMax and PlayerDataCenter.heroDic[data.basic.dataId] ~= nil then
      return true
    end
  end
  return false
end

function RecommeFormationSingleData:GetHaveCount()
  local indexMax = ConfigData:GetFormationHeroCount()
  local count = 0
  for index, data in pairs(self.recommanHeroDic) do
    if index <= indexMax and PlayerDataCenter.heroDic[data.basic.dataId] ~= nil then
      count = count + 1
    end
  end
  return count
end

function RecommeFormationSingleData:CopyFormation()
  local indexMax = ConfigData:GetFormationHeroCount()
  local res = {}
  for index, data in pairs(self.recommanHeroDic) do
    if index <= indexMax and PlayerDataCenter.heroDic[data.basic.dataId] ~= nil then
      res[index] = data.basic.dataId
    end
  end
  return res
end

function RecommeFormationSingleData:IsRecommeFixedSkill()
  return self._isFixedSkill
end

return RecommeFormationSingleData
