_class("UISeasonTransitionAnimations", UIController)
UISeasonTransitionAnimations = UISeasonTransitionAnimations

function UISeasonTransitionAnimations:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonTransitionAnimations:OnShow(uiParams)
  self:InitWidget()
  local aniName = uiParams[1]
  local firstWaitMS = uiParams[2]
  local secondWaitWs = uiParams[3]
  local firstCb = uiParams[4]
  local secondCb = uiParams[5]
  self:StartTask(function(TT)
    self.animation:Play(aniName)
    YIELD(TT, firstWaitMS)
    if firstCb then
      firstCb()
    end
    YIELD(TT, secondWaitWs)
    if secondCb then
      secondCb()
    end
    self:CloseDialog()
  end)
end

function UISeasonTransitionAnimations:InitWidget()
  self.animation = self:GetUIComponent("Animation", "animation")
end
