_class("LuckLandEnemyData", Object)
LuckLandEnemyData = LuckLandEnemyData
local toint = math.tointeger

function LuckLandEnemyData:Init(data)
  self.lldEntity = data
  self.enemyCfgId = self.lldEntity:GetTemplateID()
  self.EnemyCfg = Cfg.cfg_luckland_client_enemy[self.enemyCfgId]
  self.enemyName = self.EnemyCfg.EnemyName
  self.enemyIcon = self.EnemyCfg.EnemyIcon
  self.enemyHp = self.lldEntity:GetCurHP()
  self.enemyAtk = self.lldEntity:GetEnemyAtk()
  self.enemyLifeCount = self.EnemyCfg.EnemyLifeCount
  self.EnemySkill = self.EnemyCfg.EnemySkill
  self.enemyBigIcon = self.EnemyCfg.EnemyBigIcon
end

function LuckLandEnemyData:GetEnemyEntity()
  return self.lldEntity
end

function LuckLandEnemyData:GetEnemyIcon()
  return self.enemyIcon
end

function LuckLandEnemyData:GetEnemyBigIcon()
  return self.enemyBigIcon
end

function LuckLandEnemyData:GetEnemyName()
  return self.enemyName
end

function LuckLandEnemyData:GetEnemyHp()
  return self.lldEntity:GetCurHP()
end

function LuckLandEnemyData:GetEnemyAtk()
  return self.lldEntity:GetEnemyAtk()
end

function LuckLandEnemyData:GetEnemyLifeCount()
  return self.enemyLifeCount
end
