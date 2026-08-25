local M = {}
if not CS.FrameWork.Z1Const.IsDebugMode() then
  function M.start()
  end
  
  function M.stop()
  end
  
  function M.info()
  end
  
  function M.dump()
  end
  
  function M.dstop()
  end
  
  return M
end
local _, c = pcall(require, "profiler.c")
M.start = c.start
M.stop = c.stop
M.info = c.info

function M.dump(records)
  local ret = {}
  for i, v in ipairs(records) do
    local s = string.format("[%d] name:%s file:[%s]%s:%d count:%d total:%fs ave:%fs percent:%.4g%%", i, v.name, v.flag, v.source, v.line, v.count, v.all_cost, v.ave_cost, v.percent * 100)
    ret[#ret + 1] = s
  end
  local idx = 1
  while ret[idx] do
    local print_tbl = {""}
    for j = idx, idx + 5 do
      table.insert(print_tbl, ret[j])
    end
    idx = idx + 6
    Logger.Warn(table.concat(print_tbl, "\n"))
  end
  do return table.concat, ret end
  return table.concat, ret, "\n", table.concat(print_tbl, "\n")
end

function M.dstop(count)
  local records = c.stop(count)
  local dump_str = M.dump(records)
  CS.Framework.AssetLoadUtil.OnWriteGameFile("z1_lua_profile.txt", dump_str)
  return records
end

return M
