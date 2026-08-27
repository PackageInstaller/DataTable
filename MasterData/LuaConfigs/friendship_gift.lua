local friendship_gift = {
  [3100] = {gift_base = 16, gift_like = 20},
  [3101] = {
    gift_base = 40,
    gift_dislike = 30,
    gift_like = 50,
    id = 3101
  },
  [3102] = {gift_dislike = 75, id = 3102},
  [3103] = {
    gift_base = 16,
    gift_like = 20,
    id = 3103
  },
  [3104] = {
    gift_base = 40,
    gift_dislike = 30,
    gift_like = 50,
    id = 3104
  },
  [3105] = {gift_dislike = 75, id = 3105},
  [3106] = {
    gift_base = 16,
    gift_like = 20,
    id = 3106
  },
  [3107] = {
    gift_base = 40,
    gift_dislike = 30,
    gift_like = 50,
    id = 3107
  },
  [3108] = {gift_dislike = 75, id = 3108},
  [3109] = {
    gift_base = 16,
    gift_like = 20,
    id = 3109
  },
  [3110] = {
    gift_base = 16,
    gift_like = 20,
    id = 3110
  },
  [3111] = {
    gift_base = 40,
    gift_dislike = 30,
    gift_like = 50,
    id = 3111
  },
  [3112] = {
    gift_base = 40,
    gift_dislike = 30,
    gift_like = 50,
    id = 3112
  },
  [3113] = {gift_dislike = 75, id = 3113},
  [3114] = {gift_dislike = 75, id = 3114},
  [3115] = {
    gift_base = 16,
    gift_like = 20,
    id = 3115
  },
  [3116] = {
    gift_base = 40,
    gift_dislike = 30,
    gift_like = 50,
    id = 3116
  },
  [3117] = {gift_dislike = 75, id = 3117},
  [3118] = {
    gift_base = 16,
    gift_like = 20,
    id = 3118
  },
  [3119] = {
    gift_base = 40,
    gift_dislike = 30,
    gift_like = 50,
    id = 3119
  },
  [3120] = {gift_dislike = 75, id = 3120},
  [3121] = {
    gift_base = 16,
    gift_like = 20,
    id = 3121
  },
  [3122] = {
    gift_base = 40,
    gift_dislike = 30,
    gift_like = 50,
    id = 3122
  },
  [3123] = {gift_dislike = 75, id = 3123}
}
local __default_values = {
  gift_base = 100,
  gift_dislike = 12,
  gift_like = 125,
  id = 3100
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(friendship_gift) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(friendship_gift, {__index = __rawdata})
return friendship_gift
