local AchievementTrophyType = CommonDefine.AchievementTrophyType
local typeof = _ENV.typeof
local PopAchievementTipsView, Super = NewClass("PopAchievementTipsView", BaseView)
PopAchievementTipsView.uiResCls = UI_Common_Popup_Tips_AchievementResource

function PopAchievementTipsView:ctor(taskTid, callback)
  Super.ctor(self)
  self._taskTid = taskTid
  self._callback = callback
  self._taskCfg = DT.Task[taskTid]
end

function PopAchievementTipsView:OnBuildView()
end

function PopAchievementTipsView:RegisterNotifications()
end

function PopAchievementTipsView:RegisterEvents()
end

function PopAchievementTipsView:OnEnterView()
  Super.OnEnterView(self)
  local taskName = self._taskCfg.Name2 or self._taskCfg.Name
  local text = LT.Textf("GetAchievementPopTipsText", taskName)
  self:SetText(self.ui.Text_Achievement, text)
  self:SetText(self.ui.Text_AchievementCon, text)
  self:SetText(self.ui.Text_AchievementCal, text)
  local trophyMap = {
    [AchievementTrophyType.Gold] = self.ui.Image_Trophy_Gold,
    [AchievementTrophyType.Silver] = self.ui.Image_Trophy_Silver,
    [AchievementTrophyType.Bronze] = self.ui.Image_Trophy_Bronze
  }
  for trophyType, obj in pairs(trophyMap) do
    obj:SetActive(trophyType == self._taskCfg.AchieveQuality)
  end
  local uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  uiAnimController:PlayMultiState("UI_Common_Popup_Tips_Achievement_Open", function()
    self:_OnClose()
  end)
  self:BindTimer(0.5, 1, nil, function()
    local maxWidth = 324
    local preferredWidth = StrUtils.SetPreferredWidth(self.ui.Text_AchievementCal)
    self.ui.AchievementView:SetActive(maxWidth < preferredWidth)
    self.ui.Text_Achievement:SetActive(maxWidth >= preferredWidth)
    if maxWidth < preferredWidth then
      AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_AchievementCon, 0, 0, 0, nil, true)
    end
  end)
end

function PopAchievementTipsView:OnExitView()
  Super.OnExitView(self)
end

function PopAchievementTipsView:_OnClose()
  if self._callback then
    self._callback()
  end
  self:Close()
end

return PopAchievementTipsView
