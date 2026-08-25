local M = {}

function M.bxor(a, b)
  return a ~ b
end

function M.band(a, b)
  if type(a) == "number" and type(b) == "number" then
    return a & b
  end
  return 0
end

function M.bor(a, b)
  if type(a) == "number" and type(b) == "number" then
    return a | b
  end
  return 0
end

function M.rshift(a, disp)
  if type(a) == "number" and type(disp) == "number" then
    return a >> disp
  end
  return 0
end

function M.lshift(a, disp)
  if type(a) == "number" and type(disp) == "number" then
    return a << disp
  end
  return 0
end

return M
