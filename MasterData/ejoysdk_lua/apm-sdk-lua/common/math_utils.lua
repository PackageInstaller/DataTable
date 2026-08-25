local M = {}
M.__index = M
local variance = {}
variance.__index = variance

function variance.new()
  local obj = {
    avg = 0,
    std = 0,
    var = 0,
    n = 0
  }
  do return setmetatable, obj end
  return setmetatable, obj, variance
end

function variance:update(value)
  local incre_avg = (self.n * self.avg + value) / (self.n + 1)
  self.var = (self.n * (self.var + (incre_avg - self.avg) ^ 2) + (incre_avg - value) ^ 2) / (self.n + 1)
  self.avg = incre_avg
  self.std = math.sqrt(self.var)
  self.n = self.n + 1
end

function variance:get_std()
  return self.std
end

function variance:get_var()
  return self.var
end

function variance:clear()
  self.sth = 0
  self.avg = 0
  self.n = 0
end

function M.new_variance()
  do return end
  return variance.new, nil
end

return M
