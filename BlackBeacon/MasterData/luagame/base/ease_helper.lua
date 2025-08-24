local mathx = require("base.mathx")
local M = Util.create_class()
local k = -4.605170186
local pi = math.pi

function M.ease_in_sine(number)
  return 1 - math.cos(number * pi * 0.5)
end

function M.ease_out_sine(number)
  return 1 - math.sin(number * pi * 0.5)
end

function M.ease_in_out_sine(number)
  return -(math.cos(pi * number) - 1) * 0.5
end

function M.ease_in_out_Cubic(number)
  return number < 0.5 and 4 * number * number * number or 1 - (-2 * number + 2) ^ 3 / 2
end

function M.ease_out_quint(number)
  return 1 - (1 - number) ^ 5
end

function M.Damp(t)
  t = mathx.Clamp01(t)
  return math.exp(k * t)
end

return M
