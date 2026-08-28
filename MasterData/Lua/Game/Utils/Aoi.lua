---from: https://github.com/cfadmin-cn/lua-aoi/blob/main/init.lua

local error = error
local print = print
local pairs = pairs
local assert = assert

local ceil = math.ceil
local toint = checkInt

local uid_idx, x_idx, y_idx = 1, 2, 3

-- init map
local function map_init(x, y, radius)
  local map = { }
  for X = 0, ceil(x / radius) do
    local xList = {}
    for Y = 0, ceil(y / radius) do
      -- print(X, Y)
      xList[Y] = {}
    end
    map[X] = xList
  end
  return map
end

-- transform `Precise location` to `Fuzzy position`
local function transform_location(self, ox, oy, nx, ny)
  local radius = self.radius
  local max_x, max_y = ceil(self.x / radius), ceil(self.y / radius)

  -- Calculate the `X` axis range
  local x1, x2 = ceil(ox / radius), ceil(nx / radius)
  x1, x2 = (x1 < x2 and x1 or x2) - 1, (x1 > x2 and x1 or x2) + 1
  -- Check the `X` axis boundary value of the map.
  x1, x2 = x1 < 0 and 0 or x1, x2 > max_x and max_x or x2

  -- Calculate the `Y` axis range
  local y1, y2 = ceil(oy / radius), ceil(ny / radius)
  y1, y2 = (y1 < y2 and y1 or y2) - 1, (y1 > y2 and y1 or y2) + 1
  -- Check the `Y` axis boundary value of the map.
  y1, y2 = y1 < 0 and 0 or y1, y2 > max_y and max_y or y2

  -- return `Y` and `Y` offset
  return x1, x2, y1, y2
end

local function aio_set(self, obj, x, y)
  local radius = self.radius
  self.map[ceil(x / radius)][ceil(y / radius)][obj[uid_idx]], obj[x_idx], obj[y_idx] = obj, x, y
end

local function aio_unset(self, obj)
  local radius = self.radius
  self.map[ceil(obj[x_idx] / radius)][ceil(obj[y_idx] / radius)][obj[uid_idx]] = nil
end

local function aoi_xrange(self, obj, x, y)
  if self.ucount < 2 then
    return {} -- 减少无用的计算
  end
  local map = self.map
  local uid = obj[uid_idx]
  local xs, xe, ys, ye = transform_location(self, obj[2], obj[3], x, y)
  local list = {}
  for X = xs, xe do
    for Y = ys, ye do
      for _, o in pairs(map[X][Y]) do
        if uid ~= o[uid_idx] then
          list[#list+1] = o[uid_idx]
        end
      end
    end
  end
  return list
end

local function aoi_leave(self, uid)
  local obj = self.plist[uid]
  if not obj then
    error("[Lua-Aoi Error]: Can't find this `uid` in `Leave`.")
  end
  aio_unset(self, obj)
  self.plist[uid] = nil
  return aoi_xrange(self, obj, obj[2], obj[3])
end

local function aoi_move(self, uid, x, y)
  local obj = self.plist[uid]
  if not obj then
    error("[Lua-Aoi Error]: Can't find this `uid` in `Move`.")
  end
  -- 是否需要移动位置
  aio_unset(self, obj)
  aio_set(self, obj, x, y)
  return aoi_xrange(self, obj, x, y)
end

local function aoi_enter(self, uid, x, y, fast)
  local obj = self.plist[uid]
  if obj then
    error("[Lua-Aoi Error]: Multiple 'Enter' operations cannot be performed")
  end
  obj = { uid }
  self.plist[uid] = obj
  aio_set(self, obj, x, y)
  if not fast then
    return aoi_xrange(self, obj, x, y)
  end
end

---@class Aoi
local Aoi = Class("Aoi")

function Aoi:__init(...)
    self:ctor(...)
end


function Aoi:__delete()

end

function Aoi:ctor(opt)
  self.plist  = {}
  self.ucount = 0
  self.x      = toint(opt.x) or 65535
  self.y      = toint(opt.y) or 65535
  self.radius = toint(opt.radius) or 100
  self.map    = map_init(self.x, self.y, self.radius)
end

---comment Get all units amount.
---@return integer
function Aoi:count()
  return self.ucount
end

---comment Get uid position.
---@param uid any   @UID
---@return table    @Position{ x = xxx, y = yyy }
function Aoi:get_uid(uid)
  local obj = self.plist[uid]
  if not obj then
    return
  end
  return { x = obj[x_idx], y = obj[y_idx] }
end

---comment @Player Enter
---@param uid any      @UID
---@param x   integer  @Y Position
---@param y   integer  @X Position
function Aoi:enter(uid, x, y, fast)
  assert(uid and x and y, "[Lua-Aoi Error]: Invalid `Enter` arguments.")
  assert((x >= 0 and x <= self.x) and (y >= 0 and y <= self.y), "[Lua-Aoi Error]: Invalid `Enter` X or Y.")
  self.ucount = self.ucount + 1
  return aoi_enter(self, uid, x, y, fast)
end

---comment @Player Move
---@param uid any      @UID
---@param x   integer  @Y Position
---@param y   integer  @X Position
function Aoi:move(uid, x, y)
  assert(uid and x and y, "[Lua-Aoi Error]: Invalid `Move` arguments.")
  assert((x >= 0 and x <= self.x) and (y >= 0 and y <= self.y), "[Lua-Aoi Error]: Invalid `Move` X or Y.")
  return aoi_move(self, uid, x, y)
end

---comment @Player Leave
---@param uid any      @UID
function Aoi:leave(uid)
  assert(uid, "[Lua-Aoi Error]: Invalid `Leave` arguments.")
  self.ucount = self.ucount - 1
  return aoi_leave(self, uid)
end

---comment @Player Get all units around `uid`
---@param uid any      @UID
function Aoi:around(uid)
  local obj = self.plist[uid]
  return aoi_xrange(self, assert(obj, "[Lua-Aoi Error]: Invalid `Around` arguments."), obj[x_idx], obj[y_idx])
end

---comment @Player Get all units around `X` and `Y` position
---@param x   integer  @Y Position
---@param y   integer  @X Position
function Aoi:aroundx(x, y)
  assert(x and y, "[Lua-Aoi Error]: Invalid `Aroundx` arguments.")
  assert((x >= 0 and x <= self.x) and (y >= 0 and y <= self.y), "[Lua-Aoi Error]: Invalid `Aroundx` X or Y.")
  return aoi_xrange(self, { [x_idx] = x, [y_idx] = y }, x, y)
end

---comment Dump All.
function Aoi:dump()
  print("Aoi_list{")
  for _, uinfo in pairs(self.plist) do
    print(string.format("    %s{x=%d,y=%d}", tostring(uinfo[1]), uinfo[2], uinfo[3]))
  end
  print("}")
  print("Aoi_map{")
  for X = 0, ceil(self.x / self.radius) do
    for Y = 0, ceil(self.y / self.radius) do
      local list = self.map[X][Y]
      for _, uinfo in pairs(list) do
        print(string.format("  %s{X=%d,Y=%d}", tostring(uinfo[1]), uinfo[2], uinfo[3]))
      end
    end
  end
  print("}")
end

return Aoi