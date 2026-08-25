local M = {}
M.Status = {
  SUCC = 200,
  FAIL = -1,
  LOG = 9999
}

function M.notify_resp(c, m, d)
  if type(c) == "boolean" then
    c = true == c and 200 or -1
  end
  return {
    code = c,
    msg = m,
    data = d or {},
    type = "formatted"
  }
end

function M.notify(cb, c, m, d)
  local result = M.notify_resp(c, m, d)
  if cb then
    cb(result)
  else
    return result
  end
end

local function merge_tables(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        merge_tables(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

function M.merge_tables(...)
  local tabs = {
    ...
  }
  if not tabs then
    return {}
  end
  local origin = tabs[1]
  for i = 2, #tabs do
    origin = merge_tables(origin, tabs[i])
  end
  return origin
end

return M
