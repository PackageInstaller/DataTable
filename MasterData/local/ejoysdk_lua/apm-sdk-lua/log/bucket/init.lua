local buckets = {}
local searchers = {}
local M = {}

local function add_bucket_searchers(s)
  table.insert(searchers, 1, s)
end

local function default_searcher(name)
  local ok, mod = pcall(require, "ejoysdk_lua.apm-sdk-lua.log.bucket." .. name)
  if ok then
    return mod
  end
  return nil, mod
end

add_bucket_searchers(default_searcher)
M.add_bucket_searchers = add_bucket_searchers

local function parse_params(params, sparams)
  if not sparams then
    return
  end
  for k, v in pairs(sparams) do
    params[k] = v
  end
  return params
end

function M.new(name, sparams)
  local mod = buckets[name]
  if not mod then
    local errs = {}
    local err
    for _, s in ipairs(searchers) do
      mod, err = s(name)
      if mod then
        break
      end
      errs[#errs + 1] = err
    end
    if not mod then
      error("create bucket failed:" .. name .. [[

	]] .. table.concat(errs, "\n"))
    end
    buckets[name] = mod
  end
  local params = {}
  if mod.default_params then
    setmetatable(params, {
      __index = mod.default_params
    })
  end
  parse_params(params, sparams)
  do return mod.new, params.file_pattern end
  return mod.new, params.file_pattern, params, mod.default_params, [[

	]], table.concat(errs, "\n"), errs, "\n", s(name)
end

local default_bucket = {type = "console"}

function M.set_default(bucket)
  assert(type(bucket) == "table" and bucket.type, "expect { type, conf }")
  default_bucket = bucket
end

function M.get_default()
  do return M.new, default_bucket.type end
  return M.new, default_bucket.type, default_bucket.conf
end

return M
