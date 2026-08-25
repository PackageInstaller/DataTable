local TimelineEaseFunc = {}
local easeType2FuncTable

local function _SetupEaseFunctions()
  if easeType2FuncTable then
    return
  end
  easeType2FuncTable = {}
  easeType2FuncTable[TimelineEaseType.linear] = TimelineEaseFunc.Linear
  easeType2FuncTable[TimelineEaseType.easeInQuad] = TimelineEaseFunc.EaseInQuad
  easeType2FuncTable[TimelineEaseType.easeOutQuad] = TimelineEaseFunc.EaseOutQuad
  easeType2FuncTable[TimelineEaseType.easeInOutQuad] = TimelineEaseFunc.EaseInOutQuad
  easeType2FuncTable[TimelineEaseType.easeInCubic] = TimelineEaseFunc.EaseInCubic
  easeType2FuncTable[TimelineEaseType.easeOutCubic] = TimelineEaseFunc.EaseOutCubic
  easeType2FuncTable[TimelineEaseType.easeInOutCubic] = TimelineEaseFunc.EaseInOutCubic
  easeType2FuncTable[TimelineEaseType.easeInQuart] = TimelineEaseFunc.EaseInQuart
  easeType2FuncTable[TimelineEaseType.easeOutQuart] = TimelineEaseFunc.EaseOutQuart
  easeType2FuncTable[TimelineEaseType.easeInOutQuart] = TimelineEaseFunc.EaseInOutQuart
  easeType2FuncTable[TimelineEaseType.easeInQuint] = TimelineEaseFunc.EaseInQuint
  easeType2FuncTable[TimelineEaseType.easeOutQuint] = TimelineEaseFunc.EaseOutQuint
  easeType2FuncTable[TimelineEaseType.easeInOutQuint] = TimelineEaseFunc.EaseInOutQuint
  easeType2FuncTable[TimelineEaseType.easeInSine] = TimelineEaseFunc.EaseInSine
  easeType2FuncTable[TimelineEaseType.easeOutSine] = TimelineEaseFunc.easeOutSine
  easeType2FuncTable[TimelineEaseType.easeInOutSine] = TimelineEaseFunc.easeInOutSine
  easeType2FuncTable[TimelineEaseType.easeInExpo] = TimelineEaseFunc.EaseInExpo
  easeType2FuncTable[TimelineEaseType.easeOutExpo] = TimelineEaseFunc.EaseOutExpo
  easeType2FuncTable[TimelineEaseType.easeInOutExpo] = TimelineEaseFunc.EaseInOutExpo
  easeType2FuncTable[TimelineEaseType.easeInCirc] = TimelineEaseFunc.EaseInCirc
  easeType2FuncTable[TimelineEaseType.easeOutCirc] = TimelineEaseFunc.EaseOutCirc
  easeType2FuncTable[TimelineEaseType.easeInOutCirc] = TimelineEaseFunc.EaseInOutCirc
  easeType2FuncTable[TimelineEaseType.spring] = TimelineEaseFunc.Spring
  easeType2FuncTable[TimelineEaseType.easeInBounce] = TimelineEaseFunc.EaseInBounce
  easeType2FuncTable[TimelineEaseType.easeOutBounce] = TimelineEaseFunc.EaseOutBounce
  easeType2FuncTable[TimelineEaseType.easeInOutBounce] = TimelineEaseFunc.EaseInOutBounce
  easeType2FuncTable[TimelineEaseType.easeInBack] = TimelineEaseFunc.EaseInBack
  easeType2FuncTable[TimelineEaseType.easeOutBack] = TimelineEaseFunc.EaseOutBack
  easeType2FuncTable[TimelineEaseType.easeInOutBack] = TimelineEaseFunc.EaseInOutBack
  easeType2FuncTable[TimelineEaseType.easeInElastic] = TimelineEaseFunc.EaseInElastic
  easeType2FuncTable[TimelineEaseType.easeOutElastic] = TimelineEaseFunc.EaseOutElastic
  easeType2FuncTable[TimelineEaseType.easeInOutElastic] = TimelineEaseFunc.EaseInOutElastic
  easeType2FuncTable[TimelineEaseType.punch] = TimelineEaseFunc.Punch
end

local function _Clamp01(value)
  if value < 0 then
    return 0
  end
  if value > 1 then
    return 1
  end
  return value
end

function TimelineEaseFunc.GetEaseFunction(easeType)
  if not easeType2FuncTable then
    _SetupEaseFunctions()
  end
  return easeType2FuncTable[easeType]
end

function TimelineEaseFunc.Linear(start, to, value)
  return start + (to - start) * _Clamp01(value)
end

function TimelineEaseFunc.EaseInQuad(start, to, value)
  to = to - start
  return to * value * value + start
end

function TimelineEaseFunc.EaseOutQuad(start, to, value)
  to = to - start
  return -to * value * (value - 2) + start
end

function TimelineEaseFunc.EaseInOutQuad(start, to, value)
  value = value * 2
  to = to - start
  if value < 1.0 then
    return to * 0.5 * value * value + start
  end
  value = value - 1
  return -to * 0.5 * (value * (value - 2.0) - 1.0) + start
end

function TimelineEaseFunc.EaseInCubic(start, to, value)
  to = to - start
  return to * value * value * value + start
end

function TimelineEaseFunc.EaseOutCubic(start, to, value)
  value = value - 1
  to = to - start
  return to * (value * value * value + 1.0) + start
end

function TimelineEaseFunc.EaseInOutCubic(start, to, value)
  value = value * 2
  to = to - start
  if value < 1.0 then
    return to * 0.5 * value * value * value + start
  end
  value = value - 2
  return to * 0.5 * (value * value * value + 2.0) + start
end

function TimelineEaseFunc.EaseInQuart(start, to, value)
  to = to - start
  return to * value * value * value * value + start
end

function TimelineEaseFunc.EaseOutQuart(start, to, value)
  value = value - 1
  to = to - start
  return -to * (value * value * value * value - 1.0) + start
end

function TimelineEaseFunc.EaseInOutQuart(start, to, value)
  value = value * 2
  to = to - start
  if value < 1.0 then
    return to * 0.5 * value * value * value * value + start
  end
  value = value - 2
  return -to * 0.5 * (value * value * value * value - 2.0) + start
end

function TimelineEaseFunc.EaseInQuint(start, to, value)
  to = to - start
  return to * value * value * value * value * value + start
end

function TimelineEaseFunc.EaseOutQuint(start, to, value)
  value = value - 2
  to = to - start
  return to * (value * value * value * value * value + 1.0) + start
end

function TimelineEaseFunc.EaseInOutQuint(start, to, value)
  value = value * 2
  to = to - start
  if value < 1.0 then
    return to * 0.5 * value * value * value * value * value + start
  end
  value = value - 2
  return to / 2.0 * (value * value * value * value * value + 2.0) + start
end

function TimelineEaseFunc.EaseInSine(start, to, value)
  to = to - start
  return -to * math.cos(value / 1.0 * (math.pi / 2.0)) + to + start
end

function TimelineEaseFunc.EaseOutSine(start, to, value)
  to = to - start
  return to * math.sin(value / 1.0 * (math.pi / 2.0)) + start
end

function TimelineEaseFunc.EaseInOutSine(start, to, value)
  to = to - start
  return -to / 2.0 * (math.cos(math.pi * value / 1.0) - 1.0) + start
end

function TimelineEaseFunc.EaseInExpo(start, to, value)
  to = to - start
  return to * math.pow(2, 10 * (value / 1 - 1)) + start
end

function TimelineEaseFunc.EaseOutExpo(start, to, value)
  to = to - start
  return to * (-math.pow(2, -10 * value / 1) + 1) + start
end

function TimelineEaseFunc.EaseInOutExpo(start, to, value)
  value = value * 2
  to = to - start
  if value < 1 then
    return to / 2 * math.pow(2, 10 * (value - 1)) + start
  end
  value = value - 1
  return to / 2 * (-math.pow(2, -10 * value) + 2) + start
end

function TimelineEaseFunc.EaseInCirc(start, to, value)
  to = to - start
  return -to * (math.sqrt(1 - value * value) - 1) + start
end

function TimelineEaseFunc.EaseOutCirc(start, to, value)
  value = value - 1
  to = to - start
  return to * math.sqrt(1 - value * value) + start
end

function TimelineEaseFunc.EaseInOutCirc(start, to, value)
  value = value * 2
  to = to - start
  if value < 1 then
    return -to / 2 * (math.sqrt(1 - value * value) - 1) + start
  end
  value = value - 2
  return to / 2 * (math.sqrt(1 - value * value) + 1) + start
end

function TimelineEaseFunc.Spring(start, to, value)
  value = _Clamp01(value)
  value = (math.sin(value * math.pi * (0.2 + 2.5 * value * value * value)) * math.pow(1 - value, 2.2) + value) * (1 + 1.2 * (1 - value))
  return start + (to - start) * value
end

function TimelineEaseFunc.EaseInBounce(start, to, value)
  to = to - start
  local d = 1
  return to - TimelineEaseFunc.EaseOutBounce(0, to, d - value) + start
end

function TimelineEaseFunc.EaseOutBounce(start, to, value)
  value = value / 1
  to = to - start
  if value < 0.36363636363636365 then
    return to * (7.5625 * value * value) + start
  elseif value < 0.7272727272727273 then
    value = value - 0.5454545454545454
    return to * (7.5625 * value * value + 0.75) + start
  elseif value < 0.9090909090909091 then
    value = value - 0.8181818181818182
    return to * (7.5625 * value * value + 0.9375) + start
  else
    value = value - 0.9545454545454546
    return to * (7.5625 * value * value + 0.984375) + start
  end
end

function TimelineEaseFunc.EaseInOutBounce(start, to, value)
  to = to - start
  local d = 1
  if value < d / 2 then
    return TimelineEaseFunc.EaseInBounce(0, to, value * 2) * 0.5 + start
  else
    return TimelineEaseFunc.EaseOutBounce(0, to, value * 2 - d) * 0.5 + to * 0.5 + start
  end
end

function TimelineEaseFunc.EaseInBack(start, to, value)
  to = to - start
  value = value / 1
  local s = 1.70158
  return to * value * value * ((s + 1) * value - s) + start
end

function TimelineEaseFunc.EaseOutBack(start, to, value)
  local s = 1.70158
  to = to - start
  value = value / 1 - 1
  return to * (value * value * ((s + 1) * value + s) + 1) + start
end

function TimelineEaseFunc.EaseInOutBack(start, to, value)
  local s = 1.70158
  to = to - start
  value = value * 2.0
  if value < 1 then
    s = s * 1.525
    return to / 2 * (value * value * ((s + 1) * value - s)) + start
  end
  value = value - 2
  s = s * 1.525
  return to / 2 * (value * value * ((s + 1) * value + s) + 2) + start
end

function TimelineEaseFunc.EaseInElastic(start, to, value)
  to = to - start
  local d = 1
  local p = d * 0.3
  local s = 0
  local a = 0
  if 0 == value then
    return start
  end
  value = value / d
  if 1 == value then
    return start + to
  end
  if 0 == a or a < math.abs(to) then
    a = to
    s = p / 4
  else
    s = p / (2 * math.pi) * math.asin(to / a)
  end
  value = value - 1
  return -(a * math.pow(2, 10 * value) * math.sin((value * d - s) * (2 * math.pi) / p)) + start
end

function TimelineEaseFunc.EaseOutElastic(start, to, value)
  to = to - start
  local d = 1
  local p = d * 0.3
  local s = 0
  local a = 0
  if 0 == value then
    return start
  end
  value = value / d
  if 1 == value then
    return start + to
  end
  if 0 == a or a < math.abs(to) then
    a = to
    s = p / 4
  else
    s = p / (2 * math.pi) * math.asin(to / a)
  end
  return a * math.pow(2, -10 * value) * math.sin((value * d - s) * (2 * math.pi) / p) + to + start
end

function TimelineEaseFunc.EaseInOutElastic(start, to, value)
  to = to - start
  local d = 1
  local p = d * 0.3
  local s = 0
  local a = 0
  if 0 == value then
    return start
  end
  value = value / d / 2.0
  if 2 == value then
    return start + to
  end
  if 0 == a or a < math.abs(to) then
    a = to
    s = p / 4
  else
    s = p / (2 * math.pi) * math.asin(to / a)
  end
  if value < 1 then
    value = value - 1
    return -0.5 * (a * math.pow(2.0, 10.0 * value) * math.sin((value * d - s) * (2.0 * math.pi) / p)) + start
  end
  value = value - 1
  return a * math.pow(2.0, -10.0 * value) * math.sin((value * d - s) * (2.0 * math.pi) / p) * 0.5 + to + start
end

function TimelineEaseFunc.Punch(amplitude, value)
  local s = 9
  if 0 == value then
    return 0
  end
  if 1 == value then
    return 0
  end
  local period = 0.3
  s = period / (2 * math.pi) * math.asin(0)
  return amplitude * math.pow(2, -10 * value) * math.sin((value * 1 - s) * (2 * math.pi) / period)
end

return TimelineEaseFunc
