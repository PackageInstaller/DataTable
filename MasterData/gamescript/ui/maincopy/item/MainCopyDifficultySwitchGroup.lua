local Difficulty = CommonDefine.Difficulty
local MainCopyDifficultySwitchGroup, Super = System.NewComponent("MainCopyDifficultySwitchGroup")

function MainCopyDifficultySwitchGroup:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Chapter_Hard_Swich_Group_NewResource(uiNode)
  self.model = data.model
  self.data = data
end

function MainCopyDifficultySwitchGroup:OnBind(binder)
  self.binder = binder
  self:BindToggle(self.ui.Toggle_Simple, self.ui.CheckmarkBgSimple, Difficulty.Normal)
  self:BindToggle(self.ui.Toggle_Difficulty, self.ui.CheckmarkBgDifficulty, Difficulty.Hard)
  self:BindToggle(self.ui.Toggle_Nightmare, self.ui.CheckmarkBgNightmare, Difficulty.Super)
  self:BindRedCom(self.ui.Com_RedDot_Hard, Difficulty.Normal)
  self:BindRedCom(self.ui.Com_RedDot_Hard_1, Difficulty.Hard)
  self:BindRedCom(self.ui.Com_RedDot_Hard_2, Difficulty.Super)
  local textSimpleMaxSizer = AddLuaCompOnce(self.ui.Text_C_Simple, TextWidthAdapter)
  local textDifficultyMaxSizer = AddLuaCompOnce(self.ui.Text_C_Difficulty, TextWidthAdapter)
  local textNightmareMaxSizer = AddLuaCompOnce(self.ui.Text_C_Nightmare, TextWidthAdapter)
  textSimpleMaxSizer.limitMinWidth = 108
  textDifficultyMaxSizer.limitMinWidth = 108
  textNightmareMaxSizer.limitMinWidth = 108
  textSimpleMaxSizer.limitMaxWidth = 144
  textDifficultyMaxSizer.limitMaxWidth = 144
  textNightmareMaxSizer.limitMaxWidth = 144
  textSimpleMaxSizer:AddNode(self.ui.Group_NorSimple, 0)
  textSimpleMaxSizer:AddNode(self.ui.CheckmarkSimple, 0)
  textSimpleMaxSizer:AddNode(self.ui.Image_lock_1, 0)
  textDifficultyMaxSizer:AddNode(self.ui.Group_NorDifficulty, -20)
  textDifficultyMaxSizer:AddNode(self.ui.CheckmarkDifficulty, -20)
  textDifficultyMaxSizer:AddNode(self.ui.Image_lock_2, -20)
  textNightmareMaxSizer:AddNode(self.ui.Group_NorNightmare, -20)
  textNightmareMaxSizer:AddNode(self.ui.CheckmarkNightmare, -20)
  textNightmareMaxSizer:AddNode(self.ui.Image_lock_3, -20)
end

function MainCopyDifficultySwitchGroup:BindRedCom(redUi, hardMode)
  self.binder:BindComponent(RedDotComponent(redUi, CommonDefine.RedDotType.Dot, nil, self.data[hardMode].redFunc))
end

function MainCopyDifficultySwitchGroup:BindToggle(toggleUi, checkMarkBg, hardMode)
  local model = self.model
  local detailData = self.data[hardMode]
  self.binder:BindToZ1Toggle(toggleUi, nil, detailData.hardToggleClickFunc, function()
    return model.hardMode == hardMode
  end, nil, detailData.hardGroupShowLockFunc, detailData.lockClickFunc)
  self.binder:BindToVisible(checkMarkBg, function()
    return model.hardMode == hardMode
  end)
end

return MainCopyDifficultySwitchGroup
