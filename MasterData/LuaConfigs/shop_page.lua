local __rt_1 = {}
local shop_page = {
  {page = 332125},
  {id = 2, page = 173057},
  {id = 3, page = 188719},
  {id = 4, page = 88019},
  {id = 5, page = 344062},
  {id = 6, page = 350875},
  {id = 7, page = 416140},
  {id = 8, page = 237133},
  {id = 9, page = 185827},
  {id = 10, page = 173378},
  {id = 11, page = 313098},
  {id = 12, page = 325081},
  {id = 13, page = 255331},
  [401] = {
    click_audio = 4101,
    id = 401,
    page = 66324
  },
  [402] = {
    click_audio = 4102,
    id = 402,
    page = 359819
  },
  [403] = {
    click_audio = 4103,
    id = 403,
    page = 326679
  },
  [404] = {
    click_audio = 4104,
    id = 404,
    page = 83178
  },
  [405] = {
    click_audio = 4105,
    id = 405,
    page = 388173
  },
  [501] = {id = 501, mark = 1},
  [601] = {
    id = 601,
    imgs = {
      324,
      325,
      328,
      329,
      3,
      83,
      7,
      8,
      326,
      327,
      334
    },
    page = 266162,
    style = 2
  },
  [602] = {
    id = 602,
    imgs = {
      9,
      84,
      203,
      204
    },
    style = 1
  },
  [603] = {
    id = 603,
    imgs = {10},
    page = 521814,
    style = 1
  },
  [604] = {
    able_close = true,
    id = 604,
    imgs = {213},
    page = 247374,
    style = 1
  },
  [704] = {id = 704, page = 24001},
  [901] = {id = 901, page = 437227},
  [902] = {id = 902, page = 250297},
  [903] = {id = 903},
  [904] = {id = 904, page = 247374},
  [10031] = {id = 10031, page = 143055}
}
local __default_values = {
  able_close = false,
  click_audio = 0,
  id = 1,
  imgs = __rt_1,
  mark = 0,
  page = 339305,
  style = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(shop_page) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(shop_page, {__index = __rawdata})
return shop_page
