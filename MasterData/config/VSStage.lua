local System = require("System.System")
local readonly = System.readonly
local VSStage = readonly({
  [125506] = {
    ID = 125506,
    CnID = "吸血鬼关卡@关卡1",
    BaseSortID = 1,
    StageMonsterData = 125507,
    Name = "VSStage_125506_Name|关卡1",
    Advanced = {
      nil,
      "2.敌人生命和伤害增加",
      "3.始终有一只无敌的蜗牛在追杀你，触碰即死。"
    }
  }
})
return VSStage
