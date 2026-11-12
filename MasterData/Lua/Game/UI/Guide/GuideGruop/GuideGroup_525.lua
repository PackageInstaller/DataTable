local GuideGroup_525 = class("GuideGroup_525")
local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
GuideGroup_525.nGroupId = 525
GuideGroup_525.nGuideType = AllEnum.GuideType.Dorm
GuideGroup_525.bNeedCheckpoint = true
local nDictId = 700105
local CAP = DormGuideUI.InputCap

function GuideGroup_525:OnStart()
end

function GuideGroup_525:OnClear()
  DormGuideAdapter.ReleaseGuide()
end

function GuideGroup_525:GetSteps()
  return {
    {
      sName = "dict",
      bPlayerWait = true,
      bReportDone = true,
      Present = {sKind = "Dict", nDictId = nDictId},
      InputPolicy = {
        nSceneCap = DormGuideUI.DEFAULT_BLOCK | CAP.Move,
        bUiBarrier = false,
        bLockLeave = false,
        bHideChrome = false
      },
      End = {
        sMode = "Condition",
        Ready = function()
          return false
        end
      }
    }
  }
end

return GuideGroup_525
