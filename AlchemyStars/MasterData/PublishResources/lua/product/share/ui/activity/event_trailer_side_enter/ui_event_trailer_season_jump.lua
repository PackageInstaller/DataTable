_class("UIEventTrailerSeasonHelper", Object)
UIEventTrailerSeasonHelper = UIEventTrailerSeasonHelper

function UIEventTrailerSeasonHelper.Jump(jumpID)
  if jumpID == UIJumpType.UI_JumpSeasonOnceMission then
    local seasonModule = GameGlobal.GetModule(SeasonModule)
    seasonModule:UIModule():SetDefaultDialog("UISeasonOnceMission")
    GameGlobal.GetUIModule(SeasonModule):EnterCurrentSeasonMainUI()
  elseif jumpID == UIJumpType.UI_JumpSeasonMap then
    GameGlobal.GetUIModule(SeasonModule):EnterCurrentSeasonMainUI()
  elseif jumpID == UIJumpType.UI_JumpSeasonMainKV then
    UISeasonHelper.ShowCurSeasonMainController()
  elseif jumpID == UIJumpType.UI_JumpSeasonMazeMainKV then
    GameGlobal.UIStateManager():ShowDialog("UISeasonMazeEnterController")
  end
end
