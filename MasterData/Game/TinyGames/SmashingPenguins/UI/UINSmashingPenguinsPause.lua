local UINSmashingPenguinsPause = class("UINSmashingPenguinsPause", UIBaseNode)
local base = UIBaseNode

function UINSmashingPenguinsPause:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnEndGameBtnClick)
  UIUtil.AddButtonListener(self.ui.btn_Continue, self, self.OnContinueGameBtnClick)
  UIUtil.AddButtonListener(self.ui.btn_Restart, self, self.OnRestartGameBtnClick)
end

function UINSmashingPenguinsPause:InitSmashingPenguinsPause(mainController)
  self.mainController = mainController
  self.ui.tex_Score.text = tostring(mainController.currentScore)
end

function UINSmashingPenguinsPause:OnEndGameBtnClick()
  local mainUI = UIManager:GetWindow(UIWindowTypeID.SmashingPenguins)
  if IsNull(mainUI) then
    return
  end
  mainUI:OnQuitGameBtnClick()
end

function UINSmashingPenguinsPause:OnContinueGameBtnClick()
  local mainUI = UIManager:GetWindow(UIWindowTypeID.SmashingPenguins)
  if IsNull(mainUI) then
    return
  end
  self.mainController:SetSmashingPenguinsGamePause(false)
  self:Hide()
  mainUI:OnContinueGame()
end

function UINSmashingPenguinsPause:OnRestartGameBtnClick()
  self:Hide()
  self.mainController:RestartSmashingPenguins()
end

return UINSmashingPenguinsPause
