local GuideGroup_528 = class("GuideGroup_528")
local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
GuideGroup_528.nGroupId = 528
GuideGroup_528.nGuideType = AllEnum.GuideType.Dorm
GuideGroup_528.bNeedCheckpoint = true
local sAvgId = "BBm_DormIndoor"
local sAvgGroupId = "1"
local CAP = DormGuideUI.InputCap
local nScanBlock = CAP.Pan | CAP.Rotate | CAP.Zoom | CAP.Move | CAP.PickActor | CAP.PickFur
local nAvgCap = CAP.Zoom | CAP.PickFur
local bKingRequested = false

local function RequestKingMode()
  local nState = DormGuideAdapter.ObserveState()
  if nState == 0 or nState == nil and DormGuideAdapter.Mode() == 0 then
    return true
  end
  if nState ~= 1 and DormGuideAdapter.Mode() ~= 1 then
    return false
  end
  if bKingRequested then
    return DormGuideAdapter.ObserveState() == 0
  end
  local obj = DormGuideAdapter._Interactive()
  if obj == nil or type(obj.OnBtnClick_Operate) ~= "function" then
    return false
  end
  bKingRequested = true
  obj:OnBtnClick_Operate()
  return DormGuideAdapter.ObserveState() == 0
end

function GuideGroup_528:OnStart()
end

function GuideGroup_528:OnClear()
  EventManager.Hit(EventId.AvgBubbleExit)
  DormGuideAdapter.ReleaseGuide()
end

function GuideGroup_528:GetSteps()
  return {
    {
      sName = "indoor_avg",
      bPlayerWait = true,
      bReportDone = true,
      OnEnter = function()
        DormGuideAdapter.ApplyPolicy({
          nSceneCap = nScanBlock,
          bUiBarrier = false,
          bLockLeave = true,
          bHideChrome = true
        })
      end,
      WaitTrigger = {
        Ready = function()
          if not DormGuideAdapter.RoomEnterReady(DormGuideAdapter.ROOM2_ID) then
            return false
          end
          return RequestKingMode()
        end,
        Events = {
          "OnEvent_DormLevelLoadComplete",
          "DormGuide_ElevatorExit",
          "DormGuide_ModeApplied"
        },
        Timeout = 20
      },
      Present = {
        sKind = "Avg",
        sAvgId = sAvgId,
        sAvgGroup = sAvgGroupId
      },
      InputPolicy = {
        enter = {
          nSceneCap = nScanBlock,
          bUiBarrier = false,
          bLockLeave = true,
          bHideChrome = true
        },
        present = {
          nSceneCap = nAvgCap,
          bUiBarrier = false,
          bLockLeave = true,
          bHideChrome = true
        }
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

return GuideGroup_528
