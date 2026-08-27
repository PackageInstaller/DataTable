local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityFramePreviewFunc = {
  [ActivityFrameEnum.eActivityType.HeroGrow] = function(activityFrameData)
    local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow, true)
    heroGrowCtrl:InitHeroGrowByAct(activityFrameData)
  end
}
return ActivityFramePreviewFunc
