local System = require("System.System")
local readonly = System.readonly
local GMSubtypeConfig = readonly({
  [1] = {
    ID = 1,
    TypeID = 1,
    SubtypeID = 1,
    Name = "进本准备",
    Sort = 1
  },
  [2] = {
    ID = 2,
    TypeID = 1,
    SubtypeID = 2,
    Name = "唤醒体养成",
    Sort = 2
  },
  [3] = {
    ID = 3,
    TypeID = 1,
    SubtypeID = 3,
    Name = "小循环",
    Sort = 3
  },
  [4] = {
    ID = 4,
    TypeID = 1,
    SubtypeID = 4,
    Name = "剧情",
    Sort = 4
  },
  [5] = {
    ID = 5,
    TypeID = 1,
    SubtypeID = 5,
    Name = "任务",
    Sort = 5
  },
  [6] = {
    ID = 6,
    TypeID = 1,
    SubtypeID = 6,
    Name = "特殊功能",
    Sort = 6
  },
  [7] = {
    ID = 7,
    TypeID = 2,
    SubtypeID = 1,
    Name = "通用GM",
    Sort = 9
  },
  [8] = {
    ID = 8,
    TypeID = 2,
    SubtypeID = 2,
    Name = "特殊功能型验证",
    Sort = 10
  },
  [9] = {
    ID = 9,
    TypeID = 3,
    SubtypeID = 1,
    Name = "常用功能",
    Sort = 13
  },
  [10] = {
    ID = 10,
    TypeID = 3,
    SubtypeID = 2,
    Name = "特殊功能",
    Sort = 14
  },
  [11] = {
    ID = 11,
    TypeID = 4,
    SubtypeID = 1,
    Name = "通用",
    Sort = 15
  },
  [12] = {
    ID = 12,
    TypeID = 5,
    SubtypeID = 1,
    Name = "通用",
    Sort = 16
  }
})
return GMSubtypeConfig
