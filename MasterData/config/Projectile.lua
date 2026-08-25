local System = require("System.System")
local readonly = System.readonly
local Projectile = readonly({
  [125529] = {
    ID = 125529,
    CnID = "吸血鬼状态@弹幕1",
    BaseSortID = 1,
    SfxFileName = "Effects/PEffects/Prefab/Common/PE_Co_Coma_Loop.prefab",
    MovementType = 1
  },
  [125888] = {
    ID = 125888,
    CnID = "吸血鬼状态@弹幕3",
    BaseSortID = 2,
    SfxFileName = "Effects/PEffects/Prefab/Common/PE_Co_Coma_Loop.prefab",
    MovementType = 2
  },
  [125890] = {
    ID = 125890,
    CnID = "吸血鬼状态@弹幕4",
    BaseSortID = 3,
    SfxFileName = "Effects/PEffects/Prefab/Common/PE_Co_Coma_Loop.prefab",
    MovementType = 3
  },
  [125889] = {
    ID = 125889,
    CnID = "吸血鬼状态@弹幕2",
    BaseSortID = 4,
    SfxFileName = "Effects/PEffects/Prefab/Common/PE_Co_Coma_Loop.prefab",
    MovementType = 4
  }
})
return Projectile
