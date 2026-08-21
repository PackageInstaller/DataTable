require("base_state_node")
_class("Common_ForceCloseStory", CTestRobot_Base)
Common_ForceCloseStory = Common_ForceCloseStory

function Common_ForceCloseStory:OnWorking()
  if GameGlobal.UIStateManager():IsShow("UIStoryController") then
    local ui = GameGlobal.UIStateManager():GetController("UIStoryController")
    ui._storyManager:SkipParagraph()
  end
  return Common_ForceCloseStory.super.OnWorking(self)
end
