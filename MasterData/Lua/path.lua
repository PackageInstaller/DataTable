local _G = _ENV._G
local sub = string.sub
local package = _ENV.package
local append, concat, remove = table.insert, table.concat, table.remove
local path = {}

local function at(s, i)
  return sub(s, i, i)
end

local sep, seps
path.sep = "/"
path.dirsep = ":"
seps = {
  ["/"] = true
}
sep = path.sep

function path.splitpath(P)
  local i = #P
  local ch = at(P, i)
  while 0 < i and ch ~= sep do
    i = i - 1
    ch = at(P, i)
  end
  if i == 0 then
    return "", P
  else
    return sub(P, 1, i - 1), sub(P, i + 1)
  end
end

function path.splitext(P)
  local i = #P
  local ch = at(P, i)
  while 0 < i and ch ~= "." do
    if seps[ch] then
      return P, ""
    end
    i = i - 1
    ch = at(P, i)
  end
  if i == 0 then
    return P, ""
  else
    return sub(P, 1, i - 1), sub(P, i)
  end
end

function path.dirname(P)
  local p1 = path.splitpath(P)
  return p1
end

function path.basename(P)
  local _, p2 = path.splitpath(P)
  return p2
end

function path.extension(P)
  local _, p2 = path.splitext(P)
  return p2
end

function path.join(p1, p2, ...)
  if select("#", ...) > 0 then
    local p = path.join(p1, p2)
    local args = {
      ...
    }
    for i = 1, #args do
      p = path.join(p, args[i])
    end
    return p
  end
  local endc = at(p1, #p1)
  if endc ~= path.sep and endc ~= "" then
    p1 = p1 .. path.sep
  end
  return p1 .. p2
end

function path.normpath(P)
  local anchor = ""
  if P:match("^//") and at(P, 3) ~= "/" then
    anchor = "//"
    P = P:sub(3)
  elseif at(P, 1) == "/" then
    anchor = "/"
    P = P:match("^/*(.*)$")
  end
  local parts = {}
  for part in P:gmatch("[^" .. sep .. "]+") do
    if part == ".." then
      if #parts ~= 0 and parts[#parts] ~= ".." then
        remove(parts)
      else
        append(parts, part)
      end
    elseif part ~= "." then
      append(parts, part)
    end
  end
  P = anchor .. concat(parts, sep)
  if P == "" then
    P = "."
  end
  return P
end

function path.common_prefix(path1, path2)
  if #path1 > #path2 then
    path2, path1 = path1, path2
  end
  for i = 1, #path1 do
    if at(path1, i) ~= at(path2, i) then
      local cp = path1:sub(1, i - 1)
      if at(path1, i - 1) ~= sep then
        cp = path.dirname(cp)
      end
      return cp
    end
  end
  if at(path2, #path1 + 1) ~= sep then
    path1 = path.dirname(path1)
  end
  return path1
end

function path.package_path(mod)
  local res, err1, err2
  res, err1 = package.searchpath(mod, package.path)
  if res then
    return res, true
  end
  res, err2 = package.searchpath(mod, package.cpath)
  if res then
    return res, false
  end
end

return path
