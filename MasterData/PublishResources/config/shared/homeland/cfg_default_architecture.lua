local key = {
  ID = 1,
  DefaultStatus = 2,
  ArchitectureId = 3,
  pos_x = 4,
  pos_z = 5,
  rot = 6,
  FixCost = 7,
  ConnectPlay = 8,
  Slot = 9
}
local common = {
  {
    {5002101, 5},
    {5002201, 2}
  }
}
local config = {
  {
    1,
    0,
    5251001,
    0,
    0,
    0,
    common[1],
    1,
    "Envrionment/Building/baita"
  },
  {
    2,
    0,
    5252001,
    -2530000,
    2406000,
    90,
    common[1],
    nil,
    "Envrionment/Building/bowuguan"
  },
  {
    3,
    0,
    5253001,
    2436000,
    2214000,
    80,
    common[1],
    6,
    "Envrionment/Building/shangdian"
  },
  {
    4,
    0,
    5254001,
    -151000,
    4298000,
    0,
    common[1],
    10,
    "Envrionment/Building/xuyuanchi"
  },
  {
    5,
    0,
    5255001,
    -853000,
    1356000,
    0,
    common[1],
    15,
    "Envrionment/Building/zhiwuxiang"
  },
  {
    6,
    0,
    5241015,
    763000,
    763000,
    -90,
    common[1],
    nil,
    "Envrionment/Building/yinyueji"
  },
  {
    7,
    0,
    5256001,
    0,
    0,
    0,
    common[1],
    nil,
    "Envrionment/Building/xunzhangqiang"
  }
}
return config, "ID", key
