local System = require("System.System")
local readonly = System.readonly
local VSAwaker = readonly({
  [125511] = {
    ID = 125511,
    CnID = "吸血鬼唤醒体@拉蒙娜",
    BaseSortID = 1,
    Name = "VSAwaker_125511_Name|拉蒙娜",
    AwakerResNum = "C01_AF",
    CollisionVolume = 50,
    BaseHP = 100,
    BaseMoveSpeed = 250,
    BasePickupRange = 200,
    Desc = "VSAwaker_125511_Desc|获得 [Arg1] 算力。",
    BaseStateList = {
      {
        "true",
        {125027}
      }
    },
    Para = 1,
    WeaponSlot = 6,
    RelicSlot = 6
  },
  [125510] = {
    ID = 125510,
    CnID = "吸血鬼唤醒体@奥吉尔",
    BaseSortID = 2,
    Name = "VSAwaker_125510_Name|奥吉尔",
    AwakerResNum = "C03_AF",
    CollisionVolume = 50,
    BaseHP = 110,
    BaseMoveSpeed = 250,
    BasePickupRange = 200,
    Desc = "VSAwaker_125510_Desc|获得 [Arg1] 算力。",
    BaseStateList = {
      {
        "true",
        {125027}
      }
    },
    Para = "10,20",
    WeaponSlot = 6,
    RelicSlot = 6
  },
  [125513] = {
    ID = 125513,
    CnID = "吸血鬼唤醒体@萝坦",
    BaseSortID = 3,
    Name = "VSAwaker_125513_Name|萝坦",
    AwakerResNum = "C04_AF",
    CollisionVolume = 50,
    BaseHP = 70,
    BaseMoveSpeed = 250,
    BasePickupRange = 200,
    Desc = "VSAwaker_125513_Desc|获得 [Arg1] 算力。",
    BaseStateList = {
      {
        "true",
        {125027}
      }
    },
    Para = 3,
    WeaponSlot = 6,
    RelicSlot = 6
  },
  [125509] = {
    ID = 125509,
    CnID = "吸血鬼唤醒体@朵尔",
    BaseSortID = 4,
    Name = "VSAwaker_125509_Name|朵尔",
    AwakerResNum = "C02_AF",
    CollisionVolume = 50,
    BaseHP = 120,
    BaseMoveSpeed = 250,
    BasePickupRange = 200,
    Desc = "VSAwaker_125509_Desc|获得 [Arg1] 算力。",
    BaseStateList = {
      {
        "true",
        {125027}
      }
    },
    Para = 1,
    WeaponSlot = 6,
    RelicSlot = 6
  },
  [125514] = {
    ID = 125514,
    CnID = "吸血鬼唤醒体@艾继丝",
    BaseSortID = 5,
    Name = "VSAwaker_125514_Name|艾继丝",
    AwakerResNum = "B03_AF",
    CollisionVolume = 50,
    BaseHP = 90,
    BaseMoveSpeed = 250,
    BasePickupRange = 200,
    Desc = "VSAwaker_125514_Desc|获得 [Arg1] 算力。",
    BaseStateList = {
      {
        "true",
        {125027}
      }
    },
    Para = 12,
    WeaponSlot = 6,
    RelicSlot = 6
  },
  [125512] = {
    ID = 125512,
    CnID = "吸血鬼唤醒体@奥瑞塔",
    BaseSortID = 6,
    Name = "VSAwaker_125512_Name|奥瑞塔",
    AwakerResNum = "O05_AF",
    CollisionVolume = 50,
    BaseHP = 80,
    BaseMoveSpeed = 250,
    BasePickupRange = 200,
    Desc = "VSAwaker_125512_Desc|获得 [Arg1] 算力。",
    BaseStateList = {
      {
        "true",
        {125027}
      }
    },
    WeaponSlot = 6,
    RelicSlot = 6
  },
  [125508] = {
    ID = 125508,
    CnID = "吸血鬼唤醒体@艾瑞卡",
    BaseSortID = 7,
    Name = "VSAwaker_125508_Name|艾瑞卡",
    AwakerResNum = "D08_AF",
    CollisionVolume = 50,
    BaseHP = 130,
    BaseMoveSpeed = 250,
    BasePickupRange = 200,
    Desc = "VSAwaker_125508_Desc|获得 [Arg1] 算力。",
    BaseStateList = {
      {
        "true",
        {125027}
      }
    },
    Para = 2,
    WeaponSlot = 6,
    RelicSlot = 6
  }
})
return VSAwaker
