local chunk_cache = {}

local function loadPackage(...)
  for _, loader in ipairs(package.searchers) do
    local func = loader(...)
    if type(func) == "function" then
      return func
    end
  end
end

function doChunk(path, env, force_reload)
  local func = chunk_cache[path]
  if func == nil or force_reload then
    func = loadPackage(path)
    if func == nil then
      if env then
        error("DoChunk", "Failed to load: " .. path .. "ref by:" .. env.this.name)
      end
    else
      chunk_cache[path] = func
    end
  end
  if func ~= nil then
    if env == nil then
      env = _G
    end
    return setfenv(func, env)()
  end
end

return doChunk
