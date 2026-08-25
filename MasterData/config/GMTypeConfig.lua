local System = require("System.System")
local readonly = System.readonly
local GMTypeConfig = readonly({
  [1] = {
    TypeID = 1,
    Name = "主城功能",
    Sort = 1
  },
  [2] = {
    TypeID = 2,
    Name = "战斗功能",
    Sort = 2
  },
  [3] = {
    TypeID = 3,
    Name = "副本内功能",
    Sort = 3
  },
  [4] = {
    TypeID = 4,
    Name = "通用",
    Sort = 4
  },
  [5] = {
    TypeID = 5,
    Name = "测试型GM",
    Sort = 5
  }
})
return GMTypeConfig
