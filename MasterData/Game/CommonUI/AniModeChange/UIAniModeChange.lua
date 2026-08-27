local UIAniModeChange = class("UIAniModeChange", UIBaseWindow)
local base = UIBaseWindow
local aniNameDic = {
  "UI_SectorLevel_StageNormal",
  "UI_SectorLevel_StageHard",
  "UI_SectorLevel_StageEndless",
  "UI_SectorLevel_StageChallenge"
}
local lvDiffMap = {
  [1] = 1,
  [2] = 2,
  [3] = 3
}

function UIAniModeChange:OnInit()
  self:_StopStageAnima()
end

function UIAniModeChange:ShowAniModeChangeSectorLvDiff(difficulty)
  local index = lvDiffMap[difficulty]
  self:_ShowStageAnima(index)
end

function UIAniModeChange:ShowAniModeChangeChallengeTask()
  self:_ShowStageAnima(4)
end

function UIAniModeChange:_ShowStageAnima(difficulty)
  self:_InitStageUI(difficulty)
  self.ui.fade.alpha = 1
  self.ui.Ani_Logo:Play()
  self.ui.Ani_StageType:Play()
  self.ui.fadeTween:DOPlay()
end

function UIAniModeChange:_StopStageAnima()
  self.ui.fade.alpha = 0
  self.ui.Ani_Logo:Stop()
  self.ui.Ani_StageType:Stop()
  self.ui.fadeTween:DORewind()
end

function UIAniModeChange:_InitStageUI(difficulty)
  self:_StopStageAnima()
  local diff = difficulty
  self.ui.tex_StageType:SetIndex(diff - 1)
  self.ui.tex_StageTypeEn:SetIndex(diff - 1)
  local col = self.ui.col_Colors[diff]
  for index, v in ipairs(self.ui.com_SetColors) do
    v.color = col
  end
  for index, v in ipairs(self.ui.obj_Logos) do
    v:SetActive(index == diff)
  end
  local clipName = aniNameDic[diff]
  local clip = self.ui.Ani_Logo:GetClip(clipName)
  self.ui.Ani_Logo.clip = clip
end

function UIAniModeChange:Delete()
  self.ui.fadeTween:DOKill()
  base.OnDelete(self)
end

return UIAniModeChange
