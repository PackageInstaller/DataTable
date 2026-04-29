local key = {
  ID = 1,
  Icon = 2,
  CloseIcon = 3,
  CompleteIcon = 4
}
local common = {
  "n27_kng_icon07",
  "n27_kng_icon11",
  "n27_kng_icon15",
  "n27_kng_icon17",
  "n29_kng_spot01",
  "n29_kng_spot02",
  "n29_kng_spot03",
  "n29_kng_spot04"
}
local config = {
  [5272001] = {
    5272001,
    "n27_kng_icon06",
    common[1],
    common[1]
  },
  [5272002] = {
    5272002,
    "n27_kng_icon10",
    common[2],
    common[2]
  },
  [5272003] = {
    5272003,
    "n27_kng_icon14",
    common[3],
    common[3]
  },
  [5272004] = {
    5272004,
    "n27_kng_icon16",
    common[4],
    common[4]
  },
  [5292001] = {
    5292001,
    common[5],
    common[5],
    common[5]
  },
  [5292002] = {
    5292002,
    common[6],
    common[6],
    common[6]
  },
  [5292003] = {
    5292003,
    common[7],
    common[7],
    common[7]
  },
  [5292004] = {
    5292004,
    common[8],
    common[8],
    common[8]
  },
  [5322001] = {
    5322001,
    common[5],
    common[5],
    common[5]
  },
  [5322002] = {
    5322002,
    common[6],
    common[6],
    common[6]
  },
  [5322003] = {
    5322003,
    common[7],
    common[7],
    common[7]
  },
  [5322004] = {
    5322004,
    common[8],
    common[8],
    common[8]
  }
}
return config, "ID", key
