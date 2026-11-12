local ScoreCalculationCtrl = class("ScoreCalculationCtrl")

function ScoreCalculationCtrl:Init(nMaxFever, bInFeverMode, fFeverDuration)
  self.nCombo = 0
  self.tbComboLevels = {}
  self.nMaxFever = nMaxFever
  self.nFeverValue = 0
  self.bInFeverMode = bInFeverMode
  self.fFeverDuration = fFeverDuration or 10
  self.fFeverTimer = 0
  self.fMistakePenalty = 2
  self.fBuffMultiplier = 1
  self:_InitComboTable()
end

function ScoreCalculationCtrl:_InitComboTable()
  self.tbComboLevels = {}
  
  local function forEachLine(mapLineData)
    local sCombo = tostring(mapLineData.Combo)
    local nMin = tonumber(string.match(sCombo, "^(%d+)"))
    if nMin then
      table.insert(self.tbComboLevels, {
        minCombo = nMin,
        magnification = mapLineData.Magnification or 1
      })
    end
  end
  
  ForEachTableLine(DataTable.IceCreamFever, forEachLine)
  table.sort(self.tbComboLevels, function(a, b)
    return a.minCombo < b.minCombo
  end)
end

function ScoreCalculationCtrl:GetComboMultiplier()
  local fMul = 1
  for _, level in ipairs(self.tbComboLevels) do
    if self.nCombo >= level.minCombo then
      fMul = level.magnification
    else
      break
    end
  end
  return fMul
end

function ScoreCalculationCtrl:HasFever()
  return self.nMaxFever > 0
end

function ScoreCalculationCtrl:IsInFeverMode()
  return self.bInFeverMode
end

function ScoreCalculationCtrl:GetFeverPercent()
  if not self:HasFever() then
    return 0
  end
  if 0 >= self.nMaxFever then
    self.nMaxFever = 0 < self.nFeverValue and self.nFeverValue or 1
  end
  if self.nFeverValue > self.nMaxFever then
    self.nFeverValue = self.nMaxFever
  end
  return self.nFeverValue / self.nMaxFever
end

function ScoreCalculationCtrl:TryEnterFeverMode()
  if not self:HasFever() then
    return false
  end
  if self.bInFeverMode then
    return false
  end
  if self.nFeverValue < self.nMaxFever then
    return false
  end
  self.bInFeverMode = true
  self.fFeverTimer = 0
  return true
end

function ScoreCalculationCtrl:UpdateFeverDecay(dt)
  if not self.bInFeverMode then
    return false
  end
  self.fFeverTimer = self.fFeverTimer + dt
  local fRemain = 1 - self.fFeverTimer / self.fFeverDuration
  if fRemain <= 0 then
    self:EndFeverMode()
    return false
  end
  self.nFeverValue = math.floor(self.nMaxFever * fRemain)
  return true
end

function ScoreCalculationCtrl:OnFeverMistake()
  if not self.bInFeverMode then
    return
  end
  self.fFeverTimer = self.fFeverTimer + self.fMistakePenalty
  local fRemain = 1 - self.fFeverTimer / self.fFeverDuration
  if fRemain < 0 then
    fRemain = 0
  end
  self.nFeverValue = math.floor(self.nMaxFever * fRemain)
end

function ScoreCalculationCtrl:EndFeverMode()
  self.bInFeverMode = false
  self.nFeverValue = 0
  self.fFeverTimer = 0
end

function ScoreCalculationCtrl:OnOrderSuccess(bIsSpecial)
  self.nCombo = self.nCombo + 1
  local bJustEnteredFever = false
  if self:HasFever() and not self.bInFeverMode then
    local nAdd = bIsSpecial and 20 or 10
    self.nFeverValue = math.min(self.nMaxFever, self.nFeverValue + nAdd)
    bJustEnteredFever = self:TryEnterFeverMode()
  end
  return bJustEnteredFever
end

function ScoreCalculationCtrl:OnMistake()
  if self.bInFeverMode then
    self:OnFeverMistake()
  else
    self.nCombo = 0
    if self:HasFever() then
      self.nFeverValue = math.max(0, self.nFeverValue - 10)
    end
  end
end

function ScoreCalculationCtrl:OnOrderFail()
  if self.bInFeverMode then
    self:OnFeverMistake()
  else
    self.nCombo = 0
    if self:HasFever() then
      self.nFeverValue = 0
    end
  end
end

function ScoreCalculationCtrl:SetBuffMultiplier(fMul)
  self.fBuffMultiplier = fMul or 1
end

function ScoreCalculationCtrl:GetBuffMultiplier()
  return self.fBuffMultiplier
end

function ScoreCalculationCtrl:CalcOrderScore(nBaseScore)
  local fComboMul = self:GetComboMultiplier()
  local fBuffMul = self.fBuffMultiplier
  local fFeverMul = self.bInFeverMode and 2 or 1
  local nFinal = math.floor(nBaseScore * fComboMul * fBuffMul * fFeverMul)
  local tbDetail = {
    nBase = nBaseScore,
    fComboMul = fComboMul,
    fBuffMul = fBuffMul,
    fFeverMul = fFeverMul,
    nFinal = nFinal
  }
  return nFinal, tbDetail
end

function ScoreCalculationCtrl:CalcFeedPGScore(nBaseScore)
  local fComboMul = self:GetComboMultiplier()
  local fBuffMul = self.fBuffMultiplier
  local fFeverMul = self.bInFeverMode and 2 or 1
  local nFinal = math.floor(nBaseScore * fComboMul * fBuffMul * fFeverMul)
  return nFinal
end

function ScoreCalculationCtrl:GetCombo()
  return self.nCombo
end

function ScoreCalculationCtrl:GetFeverValue()
  return self.nFeverValue
end

function ScoreCalculationCtrl:GetMaxFever()
  return self.nMaxFever
end

function ScoreCalculationCtrl:SetInFeverMode(bInFeverMode)
  self.bInFeverMode = bInFeverMode
end

function ScoreCalculationCtrl:ChangeCombo(nComboNum)
  self.nCombo = nComboNum
end

function ScoreCalculationCtrl:ChangeFeverTime(nFeverTime)
  self.fFeverDuration = nFeverTime
end

return ScoreCalculationCtrl
