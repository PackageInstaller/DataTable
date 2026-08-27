local __rt_1 = {
  11083,
  11084,
  11085,
  11086,
  11087,
  11088,
  11089,
  11090,
  11091,
  11092,
  11093,
  11094,
  11095,
  11096,
  11097
}
local activity_general_special_task = {
  [40002] = {
    main_task = {
      7755,
      7748,
      7749,
      7750,
      7751,
      7752,
      7753,
      7754,
      7756,
      7757,
      7758,
      7759
    },
    recommend_task = {
      7762,
      7766,
      7776,
      7779,
      7787,
      7782,
      7791,
      7808,
      7816,
      7817,
      7818
    }
  },
  [59001] = {id = 59001}
}
local __default_values = {
  id = 40002,
  main_task = __rt_1,
  recommend_task = __rt_1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_general_special_task) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_general_special_task, {__index = __rawdata})
return activity_general_special_task
