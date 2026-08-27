local activity_lobby_index = {
  [24001] = {
    {activity_id = 24001}
  },
  [24002] = {
    {activity_id = 24002, lobby_id = 24002}
  },
  [24003] = {
    {activity_id = 24003, lobby_id = 24003}
  },
  [25001] = {
    {activity_id = 25001, lobby_id = 25001}
  },
  [25003] = {
    {activity_id = 25003, lobby_id = 25003}
  },
  [31001] = {
    {activity_id = 31001, lobby_id = 31001}
  },
  [33001] = {
    {activity_id = 33001, lobby_id = 33001}
  },
  [33002] = {
    {activity_id = 33002, lobby_id = 33002}
  },
  [33003] = {
    {activity_id = 33003, lobby_id = 33003}
  },
  [33004] = {
    {activity_id = 33004, lobby_id = 33004}
  },
  [33005] = {
    {activity_id = 33005, lobby_id = 33005}
  },
  [40001] = {
    {activity_id = 40001, lobby_id = 40001}
  },
  [40002] = {
    {activity_id = 40002, lobby_id = 40002}
  },
  [45001] = {
    {lobby_id = 4500101},
    {index_id = 2, lobby_id = 4500102},
    {index_id = 3, lobby_id = 4500103},
    {index_id = 4, lobby_id = 4500104},
    {index_id = 5, lobby_id = 4500105},
    {index_id = 6, lobby_id = 4500106},
    {index_id = 7, lobby_id = 4500107},
    {index_id = 8, lobby_id = 4500108},
    {index_id = 9, lobby_id = 4500109},
    [11] = {index_id = 11, lobby_id = 4500111},
    [12] = {index_id = 12, lobby_id = 4500112},
    [13] = {index_id = 13, lobby_id = 4500113},
    [14] = {index_id = 14, lobby_id = 4500114},
    [15] = {index_id = 15, lobby_id = 4500115},
    [16] = {index_id = 16, lobby_id = 4500116},
    [17] = {index_id = 17, lobby_id = 4500117},
    [18] = {index_id = 18, lobby_id = 4500118},
    [19] = {index_id = 19, lobby_id = 4500119},
    [21] = {index_id = 21, lobby_id = 4500121},
    [22] = {index_id = 22, lobby_id = 4500122},
    [23] = {index_id = 23, lobby_id = 4500123},
    [24] = {index_id = 24, lobby_id = 4500124},
    [25] = {index_id = 25, lobby_id = 4500125},
    [26] = {index_id = 26, lobby_id = 4500126},
    [27] = {index_id = 27, lobby_id = 4500127},
    [28] = {index_id = 28, lobby_id = 4500128},
    [29] = {index_id = 29, lobby_id = 4500129},
    [30] = {index_id = 30, lobby_id = 4500130}
  },
  [51001] = {
    {activity_id = 51001, lobby_id = 51001}
  },
  [56001] = {
    {activity_id = 56001, lobby_id = 5600101},
    {
      activity_id = 56001,
      index_id = 2,
      lobby_id = 5600102
    },
    {
      activity_id = 56001,
      index_id = 3,
      lobby_id = 5600103
    },
    {
      activity_id = 56001,
      index_id = 4,
      lobby_id = 5600104
    },
    {
      activity_id = 56001,
      index_id = 5,
      lobby_id = 5600105
    },
    {
      activity_id = 56001,
      index_id = 6,
      lobby_id = 5600106
    },
    {
      activity_id = 56001,
      index_id = 7,
      lobby_id = 5600107
    },
    {
      activity_id = 56001,
      index_id = 8,
      lobby_id = 5600108
    },
    {
      activity_id = 56001,
      index_id = 9,
      lobby_id = 5600109
    }
  },
  [59001] = {
    {activity_id = 59001, lobby_id = 5900101},
    {
      activity_id = 59001,
      index_id = 2,
      lobby_id = 5900102
    },
    {
      activity_id = 59001,
      index_id = 3,
      lobby_id = 5900103
    }
  }
}
local __default_values = {
  activity_id = 45001,
  index_id = 1,
  lobby_id = 24001
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_lobby_index) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  lobbyToActDic = {
    [24001] = 24001,
    [24002] = 24002,
    [24003] = 24003,
    [25001] = 25001,
    [25003] = 25003,
    [31001] = 31001,
    [33001] = 33001,
    [33002] = 33002,
    [33003] = 33003,
    [33004] = 33004,
    [33005] = 33005,
    [40001] = 40001,
    [40002] = 40002,
    [51001] = 51001,
    [4500101] = 45001,
    [4500102] = 45001,
    [4500103] = 45001,
    [4500104] = 45001,
    [4500105] = 45001,
    [4500106] = 45001,
    [4500107] = 45001,
    [4500108] = 45001,
    [4500109] = 45001,
    [4500111] = 45001,
    [4500112] = 45001,
    [4500113] = 45001,
    [4500114] = 45001,
    [4500115] = 45001,
    [4500116] = 45001,
    [4500117] = 45001,
    [4500118] = 45001,
    [4500119] = 45001,
    [4500121] = 45001,
    [4500122] = 45001,
    [4500123] = 45001,
    [4500124] = 45001,
    [4500125] = 45001,
    [4500126] = 45001,
    [4500127] = 45001,
    [4500128] = 45001,
    [4500129] = 45001,
    [4500130] = 45001,
    [5600101] = 56001,
    [5600102] = 56001,
    [5600103] = 56001,
    [5600104] = 56001,
    [5600105] = 56001,
    [5600106] = 56001,
    [5600107] = 56001,
    [5600108] = 56001,
    [5600109] = 56001,
    [5900101] = 59001,
    [5900102] = 59001,
    [5900103] = 59001
  }
}
setmetatable(activity_lobby_index, {__index = __rawdata})
return activity_lobby_index
