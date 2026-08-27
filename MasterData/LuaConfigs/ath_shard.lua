local __rt_1 = {1003}
local __rt_2 = {1003, 1008}
local __rt_3 = {200, 2}
local __rt_4 = {500, 10}
local ath_shard = {
  [3] = {
    {
      shardIdList = __rt_1,
      shardNumList = {80}
    },
    {
      shardIdList = __rt_1,
      shardNumList = {100},
      size = 2
    },
    [4] = {
      shardIdList = __rt_1,
      shardNumList = {120},
      size = 4
    },
    [8] = {
      shardIdList = __rt_1,
      shardNumList = {150},
      size = 8
    }
  },
  [4] = {
    {
      quality = 4,
      shardNumList = {200, 1}
    },
    {quality = 4, size = 2},
    [4] = {quality = 4, size = 4},
    [8] = {quality = 4, size = 8}
  },
  [5] = {
    {
      quality = 5,
      shardNumList = {500, 7}
    },
    {
      quality = 5,
      shardNumList = __rt_4,
      size = 2
    },
    [4] = {
      quality = 5,
      shardNumList = __rt_4,
      size = 4
    },
    [8] = {
      quality = 5,
      shardNumList = __rt_4,
      size = 8
    }
  }
}
local __default_values = {
  quality = 3,
  shardIdList = __rt_2,
  shardNumList = __rt_3,
  size = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(ath_shard) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(ath_shard, {__index = __rawdata})
return ath_shard
