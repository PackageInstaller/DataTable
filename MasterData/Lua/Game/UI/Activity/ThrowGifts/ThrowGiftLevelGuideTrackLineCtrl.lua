local ThrowGiftLevelGuideTrackLineCtrl = class("ThrowGiftLevelGuideTrackLineCtrl", BaseCtrl)
local nHeight = 210
local ConfigData = require("GameCore.Data.ConfigData")
ThrowGiftLevelGuideTrackLineCtrl._mapNodeConfig = {
  TemplateDot = {},
  rtPool = {sComponentName = "Transform"}
}
ThrowGiftLevelGuideTrackLineCtrl._mapEventConfig = {}
ThrowGiftLevelGuideTrackLineCtrl._mapRedDotConfig = {}

function ThrowGiftLevelGuideTrackLineCtrl:Awake()
  self.tbCurDot = {}
  self.tbPool = {}
  self.nPrevTimer = 0
  self.bActive = false
end

function ThrowGiftLevelGuideTrackLineCtrl:FadeIn()
end

function ThrowGiftLevelGuideTrackLineCtrl:FadeOut()
end

function ThrowGiftLevelGuideTrackLineCtrl:OnEnable()
  self._mapNode.TemplateDot:SetActive(false)
end

function ThrowGiftLevelGuideTrackLineCtrl:OnDisable()
  self:DestroyAll()
end

function ThrowGiftLevelGuideTrackLineCtrl:OnDestroy()
end

function ThrowGiftLevelGuideTrackLineCtrl:OnRelease()
end

function ThrowGiftLevelGuideTrackLineCtrl:DestroyAll()
  for _, tbDot in ipairs(self.tbCurDot) do
    destroy(tbDot[1].gameObject)
  end
  for _, rtDot in ipairs(self.tbPool) do
    destroy(rtDot.gameObject)
  end
  self.tbCurDot = {}
  self.tbPool = {}
end

function ThrowGiftLevelGuideTrackLineCtrl:Reset()
  for _, tbDot in ipairs(self.tbCurDot) do
    table.insert(self.tbPool, tbDot[1])
    tbDot[1]:SetParent(self._mapNode.rtPool)
  end
  self.tbCurDot = {}
  self.nPrevTimer = 0
end

function ThrowGiftLevelGuideTrackLineCtrl:GetDot()
  if #self.tbPool > 0 then
    local rtDot = table.remove(self.tbPool)
    rtDot:SetParent(self.gameObject.transform)
    local goOn = rtDot:Find("on")
    table.insert(self.tbCurDot, {rtDot, goOn})
    return rtDot
  end
  local goDot = instantiate(self._mapNode.TemplateDot, self.gameObject.transform)
  goDot:SetActive(true)
  local rtDot = goDot:GetComponent("RectTransform")
  local goOn = rtDot:Find("on")
  table.insert(self.tbCurDot, {rtDot, goOn})
  return rtDot
end

function ThrowGiftLevelGuideTrackLineCtrl:AddDot(v2Pos, nAngle)
  local rtDot = self:GetDot()
  rtDot.anchoredPosition = v2Pos
  rtDot.localEulerAngles = Vector3(0, 0, nAngle - 90)
end

function ThrowGiftLevelGuideTrackLineCtrl:SetLineActive(nAngle, nSpeed)
  local nConfigAngle = self.mapData.Angle
  local nConfigSpeed = self.mapData.Speed
  local nSpeedRangeMax = nConfigSpeed + self.mapData.SpeedThreshold
  local nSpeedRangeMin = nConfigSpeed - self.mapData.SpeedThreshold
  local nAngleRangeMax = nConfigAngle + self.mapData.AngleThreshold
  local nAngleRangeMin = nConfigAngle - self.mapData.AngleThreshold
  local bActive = nAngle >= nAngleRangeMin and nAngle <= nAngleRangeMax and nSpeed >= nSpeedRangeMin and nSpeed <= nSpeedRangeMax
  if bActive ~= self.bActive then
    self.bActive = bActive
    for _, tbCurDots in ipairs(self.tbCurDot) do
      tbCurDots[2].gameObject:SetActive(self.bActive)
    end
  end
end

function ThrowGiftLevelGuideTrackLineCtrl:InitLine(mapData, v2Pos, nAG, nMaxSpeed)
  if mapData == nil then
    return
  end
  self.mapData = mapData
  local nAngle = mapData.Angle
  local nSpeed = mapData.Speed
  local sumScale = nSpeed / nMaxSpeed * 0.2
  local nInterval = mapData.GuideLinePointInterval * ConfigData.IntFloatPrecision
  local nStartTime = mapData.StartPointTime * ConfigData.IntFloatPrecision
  local nEndTime = mapData.EndPointTime * ConfigData.IntFloatPrecision
  local nBenginingX = v2Pos.x + math.cos(math.rad(nAngle)) * (nHeight * (1 - sumScale))
  local nBenginingY = v2Pos.y + math.sin(math.rad(nAngle)) * (nHeight * (1 - sumScale)) - 34
  local vX = nSpeed * math.cos(math.rad(nAngle))
  local vY = nSpeed * math.sin(math.rad(nAngle))
  local nDotCount = math.floor((nEndTime - nStartTime) / nInterval)
  for i = 0, nDotCount do
    local dotx = (nInterval * i + nStartTime) * vX
    local dotY = (nInterval * i + nStartTime) * vY - 0.5 * nAG * (nInterval * i + nStartTime) * (nInterval * i + nStartTime)
    local curVy = vY - (nInterval * i + nStartTime) * nAG
    local nFlyAngle = math.deg(math.atan(curVy, vX))
    self:AddDot(Vector2(nBenginingX + dotx, nBenginingY + dotY), nFlyAngle)
  end
end

return ThrowGiftLevelGuideTrackLineCtrl
