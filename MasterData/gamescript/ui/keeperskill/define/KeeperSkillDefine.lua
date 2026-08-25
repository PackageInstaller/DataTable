local System = require("System.System")
local Readonly = System.readonly
local KeeperSkillDefine = {}
KeeperSkillDefine.ToggleList = Readonly({
  [1] = {uiNode = "Tab_All", classify = nil},
  [2] = {
    uiNode = "Tab_Wangque",
    classify = "KeyType_1"
  },
  [3] = {uiNode = "Tab_Hundun", classify = "KeyType_2"},
  [4] = {
    uiNode = "Tab_Shenhai",
    classify = "KeyType_3"
  },
  [5] = {uiNode = "Tab_Xuerou", classify = "KeyType_4"},
  [6] = {
    uiNode = "Tab_Chaowei",
    classify = "KeyType_5"
  }
})
do return Readonly, KeeperSkillDefine end
return Readonly, KeeperSkillDefine, "KeeperSkillDefine"
