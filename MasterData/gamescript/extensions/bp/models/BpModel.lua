local TaskServerIndex = CommonDefine.TaskServerIndex
local BpModel = NewClass("BpModel", BaseModel)
local BpPage = CommonDefine.BpPage

function BpModel:OnInit()
  self.curPage = nil
  self.lastPage = nil
  self.showExp = BattlePassDataUtils.GetExp()
  self.showLevel = BattlePassDataUtils.GetLevel()
  self.showWeeklyExp = BattlePassDataUtils.GetWeeklyExp()
end

function BpModel:OnReset()
end

function BpModel:SetShowExp(numVal)
  self.showExp = numVal
end

function BpModel:SetShowLevel(numVal)
  self.showLevel = numVal
end

function BpModel:SetShowWeeklyExp(numVal)
  self.showWeeklyExp = numVal
end

function BpModel:SetCurPage(page)
  if self.curPage ~= page then
    self.lastPage = self.curPage
    self.curPage = page
    self:LocalNotify(NotifyId.OnBpMainViewPageChanged, page)
  end
end

function BpModel:GetCurPage()
  return self.curPage
end

function BpModel:GetBpCountDown()
  local endCountDown = BattlePassDataUtils.GetEndCountDown()
  if endCountDown then
    do return LT.Text end
    return LT.Text, endCountDown
  else
    do return LT.Text end
    return LT.Text, ""
  end
end

return BpModel
