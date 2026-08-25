local UICircularScaler = NewClass("UICircularScaler")
local _GetLocalPos = CS.Framework.TransformUtil.GetLocalPos
local _SetLocalPos = CS.Framework.TransformUtil.SetLocalPos
local _SetLocalEulerAngles = CS.Framework.TransformUtil.SetLocalEulerAngles

function UICircularScaler:ctor(scalerPrefab, centerPosGo, pointOnCircleGo)
  self.scalerPrefab = scalerPrefab
  self.scalerPrefab:SetActive(false)
  self.centerPosGo = centerPosGo
  self.pointOnCircleGo = pointOnCircleGo
  self.raduis = self:_CalRadius()
  self.scalers = {}
  self.avgValue = 100
  self.maxValue = 1000
end

function UICircularScaler:Apply(avgValue, maxValue)
  self.avgValue = avgValue
  self.maxValue = maxValue
  local numScalers = math.ceil(maxValue / avgValue)
  local startAngle = -90
  local pace = avgValue / maxValue * 360
  local deg2Dad = math.pi / 180
  local centerX, centerY, _ = _GetLocalPos(self.centerPosGo.transform, nil, nil, nil)
  for i = 1, numScalers do
    local angle = startAngle + pace * (i - 1)
    local radian = deg2Dad * angle
    local x = centerX + self.raduis * math.cos(radian)
    local y = centerY - self.raduis * math.sin(radian)
    local scaler = self.scalers[i]
    if not scaler then
      scaler = Instantiate(self.scalerPrefab, self.scalerPrefab.transform.parent)
      self.scalers[i] = scaler
    end
    scaler:SetActive(true)
    _SetLocalPos(scaler.transform, x, y, 0)
    _SetLocalEulerAngles(scaler.transform, 0, 0, 360 - angle)
  end
  for i = numScalers + 1, #self.scalers do
    self.scalers[i]:SetActive(false)
  end
  LateUpdateBeat.Instance:Add(self.LateUpdate, self)
end

function UICircularScaler:_CalRadius()
  local posCenterX, posCenterY = _GetLocalPos(self.centerPosGo.transform, nil, nil, nil)
  local pointOnCiucleX, pointOnCiucleY = _GetLocalPos(self.pointOnCircleGo.transform, nil, nil, nil)
  local xx = (posCenterX - pointOnCiucleX) * (posCenterX - pointOnCiucleX)
  local yy = (posCenterY - pointOnCiucleY) * (posCenterY - pointOnCiucleY)
  do return math.sqrt end
  return math.sqrt, xx + yy
end

function UICircularScaler:LateUpdate()
  self.raduis = self:_CalRadius()
  self:Apply(self.avgValue, self.maxValue)
end

function UICircularScaler:Dispose()
  for i = 1, #self.scalers do
    Destroy(self.scalers[i])
  end
  self.scalers = {}
  LateUpdateBeat.Instance:Remove(self.LateUpdate, self)
end

return UICircularScaler
