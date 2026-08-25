local System = require("System.System")
local readonly = System.readonly
local SVSkill = readonly({
  [125958] = {
    ID = 125958,
    CnID = "吸血鬼技能@狂气爆发@拉蒙娜",
    BaseSortID = 1,
    Name = "SVSkill_125958_Name|世界演绎法",
    Desc = "SVSkill_125958_Desc|伤害提高 50% ，冷却减少 70% 在 5 秒内逐步衰减。",
    Icon = "Portrait/Card/Portrait_Card_Awaker_C01_AF.png",
    SkillBaseCooldown = 0,
    SkillLevelMax = 1,
    Cost = 100,
    Type = {
      "VS_Ulti_Skill"
    },
    CmdList = 125026,
    CmdTarget = "CmdCaster",
    Para = "GrowArgValue1",
    StateLayer = {
      "吸血鬼状态@空状态"
    },
    StatePara = {1},
    OriginalCoefficient = {10},
    CoefficientTypelist = {
      "BattleFomula11"
    },
    IsAttractedByPickupRange = 0
  },
  [125955] = {
    ID = 125955,
    CnID = "吸血鬼技能@命轮@溯洄时计",
    BaseSortID = 2,
    Name = "SVSkill_125955_Name|溯洄时计",
    Desc = "SVSkill_125955_Desc|· 向角色朝向方向进行 [Arg1] 次范围攻击，每次造成 <Damage:[Damage:Arg2]> 伤害。\n· 冷却 <Cooldown:[Cooldown:Arg3]>",
    Icon = "Portrait/Card/Portrait_Card_Awaker_C01_AF.png",
    SkillBaseCooldown = 5,
    SkillLevelMax = 5,
    Cost = 0,
    Type = {"VS_Weapon"},
    CmdList = 125026,
    CmdTarget = "CmdCaster",
    Para = "3,1,GrowArgValue1",
    StateLayer = {
      "吸血鬼状态@空状态"
    },
    StatePara = {1},
    OriginalCoefficient = {
      "VS技能基础冷却"
    },
    CoefficientTypelist = {
      "GrowArgValue-(SkillLevel-1)*0.05"
    },
    IsAttractedByPickupRange = 0
  },
  [125962] = {
    ID = 125962,
    CnID = "吸血鬼技能@造物@红宝石胸针",
    BaseSortID = 3,
    Name = "SVSkill_125962_Name|红宝石胸针",
    Desc = "SVSkill_125962_Desc|造成的伤害提高 <Damage:[Arg1]> 。",
    Icon = "Portrait/Card/Portrait_Card_Awaker_C01_AF.png",
    SkillBaseCooldown = 0,
    SkillLevelMax = 5,
    Cost = 0,
    Type = {"VS_Relic"},
    CmdList = 125026,
    CmdTarget = "CmdCaster",
    Para = "GrowArgValue1",
    StateLayer = {
      "吸血鬼状态@空状态"
    },
    StatePara = {1},
    OriginalCoefficient = {10},
    CoefficientTypelist = {
      "BattleFomula11"
    },
    IsAttractedByPickupRange = 0
  },
  [125954] = {
    ID = 125954,
    CnID = "吸血鬼技能@道具@白色经验",
    BaseSortID = 4,
    Name = "SVSkill_125954_Name|白色经验",
    Desc = "SVSkill_125954_Desc|获得 1 经验。",
    Icon = "Portrait/Card/Portrait_Card_Awaker_C01_AF.png",
    SkillBaseCooldown = 0,
    SkillLevelMax = 1,
    Cost = 0,
    Type = {"VS_Item"},
    CmdList = 125026,
    CmdTarget = "CmdCaster",
    DeathDropRange = 50,
    IsAttractedByPickupRange = 1
  },
  [125951] = {
    ID = 125951,
    CnID = "吸血鬼技能@道具@绿色经验",
    BaseSortID = 5,
    Name = "SVSkill_125951_Name|绿色经验",
    Desc = "SVSkill_125951_Desc|获得 3 经验。",
    Icon = "Portrait/Card/Portrait_Card_Awaker_C01_AF.png",
    SkillBaseCooldown = 0,
    SkillLevelMax = 1,
    Cost = 0,
    Type = {"VS_Item"},
    CmdList = 125026,
    CmdTarget = "CmdCaster",
    DeathDropRange = 50,
    IsAttractedByPickupRange = 1
  },
  [125956] = {
    ID = 125956,
    CnID = "吸血鬼技能@道具@蓝色经验",
    BaseSortID = 6,
    Name = "SVSkill_125956_Name|蓝色经验",
    Desc = "SVSkill_125956_Desc|获得 5 经验。",
    Icon = "Portrait/Card/Portrait_Card_Awaker_C01_AF.png",
    SkillBaseCooldown = 0,
    SkillLevelMax = 1,
    Cost = 0,
    Type = {"VS_Item"},
    CmdList = 125026,
    CmdTarget = "CmdCaster",
    DeathDropRange = 50,
    IsAttractedByPickupRange = 1
  },
  [125957] = {
    ID = 125957,
    CnID = "吸血鬼技能@道具@紫色经验",
    BaseSortID = 7,
    Name = "SVSkill_125957_Name|紫色经验",
    Desc = "SVSkill_125957_Desc|获得 7 经验。",
    Icon = "Portrait/Card/Portrait_Card_Awaker_C01_AF.png",
    SkillBaseCooldown = 0,
    SkillLevelMax = 1,
    Cost = 0,
    Type = {"VS_Item"},
    CmdList = 125026,
    CmdTarget = "CmdCaster",
    DeathDropRange = 50,
    IsAttractedByPickupRange = 1
  },
  [125952] = {
    ID = 125952,
    CnID = "吸血鬼技能@道具@橙色经验",
    BaseSortID = 8,
    Name = "SVSkill_125952_Name|橙色经验",
    Desc = "SVSkill_125952_Desc|获得 9 经验。",
    Icon = "Portrait/Card/Portrait_Card_Awaker_C01_AF.png",
    SkillBaseCooldown = 0,
    SkillLevelMax = 1,
    Cost = 0,
    Type = {"VS_Item"},
    CmdList = 125026,
    CmdTarget = "CmdCaster",
    DeathDropRange = 50,
    IsAttractedByPickupRange = 1
  },
  [125953] = {
    ID = 125953,
    CnID = "吸血鬼技能@道具@共鸣粒子",
    BaseSortID = 9,
    Name = "SVSkill_125953_Name|共鸣粒子",
    Desc = "SVSkill_125953_Desc|获得 1 共鸣粒子。",
    Icon = "Portrait/Card/Portrait_Card_Awaker_C01_AF.png",
    SkillBaseCooldown = 0,
    SkillLevelMax = 1,
    Cost = 0,
    Type = {"VS_Item"},
    CmdList = 125026,
    CmdTarget = "CmdCaster",
    DeathDropRange = 250,
    IsAttractedByPickupRange = 0
  },
  [125960] = {
    ID = 125960,
    CnID = "吸血鬼技能@道具@大堆共鸣粒子",
    BaseSortID = 10,
    Name = "SVSkill_125960_Name|大堆共鸣粒子",
    Desc = "SVSkill_125960_Desc|获得 10 共鸣粒子。",
    Icon = "Portrait/Card/Portrait_Card_Awaker_C01_AF.png",
    SkillBaseCooldown = 0,
    SkillLevelMax = 1,
    Cost = 0,
    Type = {"VS_Item"},
    CmdList = 125026,
    CmdTarget = "CmdCaster",
    DeathDropRange = 250,
    IsAttractedByPickupRange = 0
  },
  [125963] = {
    ID = 125963,
    CnID = "吸血鬼技能@道具@小蛋糕",
    BaseSortID = 11,
    Name = "SVSkill_125963_Name|小蛋糕",
    Desc = "SVSkill_125963_Desc|回复 10 生命值。",
    Icon = "Portrait/Card/Portrait_Card_Awaker_C01_AF.png",
    SkillBaseCooldown = 0,
    SkillLevelMax = 1,
    Cost = 0,
    Type = {"VS_Item"},
    CmdList = 125026,
    CmdTarget = "CmdCaster",
    DeathDropRange = 0,
    IsAttractedByPickupRange = 0
  },
  [125961] = {
    ID = 125961,
    CnID = "吸血鬼技能@道具@磁铁",
    BaseSortID = 12,
    Name = "SVSkill_125961_Name|磁铁",
    Desc = "SVSkill_125961_Desc|吸收全部掉落的经验值。",
    Icon = "Portrait/Card/Portrait_Card_Awaker_C01_AF.png",
    SkillBaseCooldown = 0,
    SkillLevelMax = 1,
    Cost = 0,
    Type = {"VS_Item"},
    CmdList = 125026,
    CmdTarget = "CmdCaster",
    DeathDropRange = 0,
    IsAttractedByPickupRange = 0
  },
  [125959] = {
    ID = 125959,
    CnID = "吸血鬼技能@道具@宝箱",
    BaseSortID = 13,
    Name = "SVSkill_125959_Name|宝箱",
    Desc = "SVSkill_125959_Desc|捡起以后可以开始抽奖。",
    Icon = "Portrait/Card/Portrait_Card_Awaker_C01_AF.png",
    SkillBaseCooldown = 0,
    SkillLevelMax = 1,
    Cost = 0,
    Type = {"VS_Item"},
    CmdList = 125026,
    CmdTarget = "CmdCaster",
    DeathDropRange = 0,
    IsAttractedByPickupRange = 0
  }
})
return SVSkill
