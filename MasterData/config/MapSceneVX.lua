local System = require("System.System")
local readonly = System.readonly
local MapSceneVX = readonly({
  [18728] = {
    ID = 18728,
    CnID = "场景特效@测试特效1",
    BaseSortID = 1,
    Effect = "Effects/Effect_Scene/Snow/Snow_texture_Prefab.prefab",
    Audio = 16247,
    EnterAudioEvent = {16293},
    LeaveAudioEvent = {16251},
    Enter = 0,
    OnTiles = {
      {2, 6},
      {2, 7},
      {2, 5}
    },
    OffTiles = {
      {2, 8},
      {1, 1}
    }
  },
  [18730] = {
    ID = 18730,
    CnID = "场景特效@测试特效2",
    BaseSortID = 2,
    Effect = "Effects/Effect_Scene/E_MScene_Co_Rain_01.prefab",
    Audio = 16265,
    EnterAudioEvent = {16279},
    LeaveAudioEvent = {16262},
    Enter = 1,
    OnTiles = {0},
    OffTiles = {
      {2, 8},
      {1, 1}
    }
  },
  [18729] = {
    ID = 18729,
    CnID = "场景特效@测试特效3",
    BaseSortID = 3,
    Effect = "Effects/Effect_Scene/E_MScene_Co_Snow_01.prefab",
    Audio = 16265,
    EnterAudioEvent = {16077},
    LeaveAudioEvent = {16011},
    Enter = 1,
    OnTiles = {0}
  },
  [47991] = {
    ID = 47991,
    CnID = "场景特效@测试特效4",
    BaseSortID = 4,
    Effect = "Effects/Effect_Scene/Scene_Sand_01.prefab",
    Audio = 16265,
    EnterAudioEvent = {16077},
    LeaveAudioEvent = {16011},
    Enter = 1,
    OnTiles = {0}
  }
})
return MapSceneVX
