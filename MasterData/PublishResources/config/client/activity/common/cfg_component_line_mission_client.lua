local key = {
  ID = 1,
  Icon = 2,
  CloseIcon = 3,
  CompleteIcon = 4
}
local common = {
  "n32_kng_spotmask02",
  "n32_kng_spotmask03",
  "n32_kng_spotmask04",
  "n35_kng_di07",
  "n35_kng_di06",
  "n37_nd1_mb01",
  "n37_nd1_mb02",
  "n39_nd1_mb01",
  "n39_nd1_mb02",
  "N41_kng_tu01",
  "N41_kng_tu02",
  "N41_kng_tu03",
  "N41_kng_tu04"
}
local config = {
  [5322001] = {
    5322001,
    "n32_kng_spot01",
    "n32_kng_spotmask01",
    "n32_kng_spotmask05"
  },
  [5322002] = {
    5322002,
    "n32_kng_spot02",
    common[1],
    common[1]
  },
  [5322003] = {
    5322003,
    "n32_kng_spot03",
    common[2],
    common[2]
  },
  [5322004] = {
    5322004,
    "n32_kng_spot04",
    common[3],
    common[3]
  },
  [5352001] = {
    5352001,
    "n35_kng_di01",
    common[4],
    common[5]
  },
  [5352002] = {
    5352002,
    "n35_kng_di02",
    common[4],
    common[5]
  },
  [5352003] = {
    5352003,
    "n35_kng_di03",
    common[4],
    common[5]
  },
  [5352004] = {
    5352004,
    "n35_kng_di04",
    common[4],
    common[5]
  },
  [5372001] = {
    5372001,
    "n37_nd1_pt01",
    common[6],
    common[7]
  },
  [5372002] = {
    5372002,
    "n37_nd1_pt02",
    common[6],
    common[7]
  },
  [5372003] = {
    5372003,
    "n37_nd1_pt03",
    common[6],
    common[7]
  },
  [5372004] = {
    5372004,
    "n37_nd1_pt04",
    common[6],
    common[7]
  },
  [5392001] = {
    5392001,
    "n39_nd1_gn01",
    common[8],
    common[9]
  },
  [5392002] = {
    5392002,
    "n39_nd1_gn02",
    common[8],
    common[9]
  },
  [5392003] = {
    5392003,
    "n39_nd1_gn03",
    common[8],
    common[9]
  },
  [5392004] = {
    5392004,
    "n39_nd1_gn04",
    common[8],
    common[9]
  },
  [5412001] = {
    5412001,
    common[10],
    common[10],
    common[10]
  },
  [5412002] = {
    5412002,
    common[11],
    common[11],
    common[11]
  },
  [5412003] = {
    5412003,
    common[12],
    common[12],
    common[12]
  },
  [5412004] = {
    5412004,
    common[13],
    common[13],
    common[13]
  }
}
return config, "ID", key
