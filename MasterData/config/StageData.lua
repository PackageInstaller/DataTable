local System = require("System.System")
local readonly = System.readonly
local StageData = readonly({
  [59164] = {
    ID = 59164,
    CnID = "通关数据统计@关卡总回合数",
    BaseSortID = 1,
    Key = "stageRoundCount",
    Name = "StageData_59164_Name|总回合数",
    Desc = "StageData_59164_Desc|所有战斗的总回合数",
    Sort = 1
  },
  [51632] = {
    ID = 51632,
    CnID = "通关数据统计@最终战回合数",
    BaseSortID = 2,
    Key = "bossBattleRoundCount",
    Name = "StageData_51632_Name|最终战回合数",
    Sort = 2
  },
  [51630] = {
    ID = 51630,
    CnID = "通关数据统计@最终剩余生命",
    BaseSortID = 3,
    Key = "leftHp",
    Name = "StageData_51630_Name|最终剩余生命",
    Sort = 3
  },
  [51628] = {
    ID = 51628,
    CnID = "通关数据统计@死亡抵抗触发次数",
    BaseSortID = 4,
    Key = "deathResistCount",
    Name = "StageData_51628_Name|死亡抵抗触发次数",
    Sort = 4
  },
  [51633] = {
    ID = 51633,
    CnID = "通关数据统计@应急灵知体使用次数",
    BaseSortID = 5,
    Key = "respawnedNum",
    Name = "StageData_51633_Name|应急灵知体使用次数",
    Sort = 5
  },
  [51627] = {
    ID = 51627,
    CnID = "通关数据统计@最大单回合伤害",
    BaseSortID = 6,
    Key = "maxBoutDamage",
    Name = "StageData_51627_Name|单回合最高伤害",
    Sort = 6
  },
  [59166] = {
    ID = 59166,
    CnID = "通关数据统计@最大力量",
    BaseSortID = 7,
    Key = "maxStrength",
    Name = "StageData_59166_Name|最高力量",
    Desc = "StageData_59166_Desc|所有战斗中我方力量的最高数值",
    Sort = 7
  },
  [59165] = {
    ID = 59165,
    CnID = "通关数据统计@最大触腕伤害",
    BaseSortID = 8,
    Key = "maxTentacleDamage",
    Name = "StageData_59165_Name|最高触腕伤害",
    Desc = "StageData_59165_Desc|所有战斗中我方单条触腕伤害的最高数值",
    Sort = 8
  },
  [51629] = {
    ID = 51629,
    CnID = "通关数据统计@最大中毒",
    BaseSortID = 9,
    Key = "maxPosion",
    Name = "StageData_51629_Name|最高中毒",
    Sort = 9
  },
  [51626] = {
    ID = 51626,
    CnID = "通关数据统计@最大反击",
    BaseSortID = 10,
    Key = "maxCounterAtt",
    Name = "StageData_51626_Name|最高反击",
    Sort = 10
  },
  [51635] = {
    ID = 51635,
    CnID = "通关数据统计@最大单回合出牌数",
    BaseSortID = 11,
    Key = "maxBoutUseCard",
    Name = "StageData_51635_Name|单回合最多出牌数",
    Desc = "StageData_51635_Desc|所有卡牌类型均会统计",
    Sort = 11
  },
  [51631] = {
    ID = 51631,
    CnID = "通关数据统计@最大单回合算力消耗",
    BaseSortID = 12,
    Key = "maxBoutEnergyCost",
    Name = "StageData_51631_Name|单回合最多算力消耗",
    Sort = 12
  },
  [51634] = {
    ID = 51634,
    CnID = "通关数据统计@总出牌数",
    BaseSortID = 13,
    Key = "totalUseCard",
    Name = "StageData_51634_Name|总出牌数",
    Desc = "StageData_51634_Desc|所有卡牌类型均会统计",
    Sort = 13
  },
  [51636] = {
    ID = 51636,
    CnID = "通关数据统计@总算力消耗",
    BaseSortID = 14,
    Key = "totalEnergyCost",
    Name = "StageData_51636_Name|总算力消耗",
    Sort = 14
  }
})
return StageData
