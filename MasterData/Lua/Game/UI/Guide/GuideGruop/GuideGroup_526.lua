local GuideGroup_526 = class("GuideGroup_526")
local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
GuideGroup_526.nGroupId = 526
GuideGroup_526.nGuideType = AllEnum.GuideType.Dorm
GuideGroup_526.bNeedCheckpoint = true
local nDictId = 700106
local sHead = "Icon/Head/head_11101"
local CAP = DormGuideUI.InputCap

local function Mask(sDesc)
  return {
    Size = {220, 220},
    Deviation = {0, -5},
    Desc = sDesc,
    DescDeviation = {-800, 0},
    HandDeviation = {0, 150},
    HandRotation = 180
  }
end

function GuideGroup_526:OnStart()
end

function GuideGroup_526:OnClear()
  DormGuideAdapter.ReleaseGuide()
end

function GuideGroup_526:GetSteps()
  return {
    {
      sName = "operate",
      bPlayerWait = true,
      ShouldRun = function()
        local nState = DormGuideAdapter.ObserveState()
        if nState == nil then
          return "run"
        end
        if nState ~= 1 then
          return "skip"
        end
        return "run"
      end,
      WaitTrigger = {
        Ready = function()
          return DormGuideAdapter.ObserveState() ~= nil
        end,
        Timeout = 3
      },
      Poll = function()
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or obj._mapNode == nil then
          return nil
        end
        return DormGuideAdapter.NodeTr(obj._mapNode.btnOperate)
      end,
      Present = {
        sKind = "Mask",
        mapMask = Mask("Guide_526_1"),
        Show = function(_, tr)
          if tr ~= nil then
            tr.gameObject:SetActive(true)
          end
        end
      },
      InputPolicy = {
        nSceneCap = DormGuideUI.DEFAULT_BLOCK | CAP.Move,
        bUiBarrier = true,
        bLockLeave = true,
        bHideChrome = false
      },
      Action = function()
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or type(obj.OnBtnClick_Operate) ~= "function" then
          return {sState = "rejected"}
        end
        obj:OnBtnClick_Operate()
        if DormGuideAdapter.ObserveState() ~= 0 then
          return {sState = "rejected"}
        end
        return {sState = "accepted"}
      end,
      End = {sMode = "Click"}
    },
    {
      sName = "observe",
      bPlayerWait = true,
      bReportDone = true,
      WaitTrigger = {
        Ready = function()
          return DormGuideAdapter.ObserveState() == 0
        end,
        Events = {
          "DormGuide_ModeApplied"
        },
        Timeout = 3
      },
      Poll = function()
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or obj._mapNode == nil then
          return nil
        end
        return DormGuideAdapter.NodeTr(obj._mapNode.btnObserve)
      end,
      Present = {
        sKind = "Mask",
        mapMask = Mask("Guide_526_1"),
        Show = function(_, tr)
          if tr ~= nil then
            tr.gameObject:SetActive(true)
          end
        end
      },
      InputPolicy = {
        nSceneCap = DormGuideUI.DEFAULT_BLOCK | CAP.Move,
        bUiBarrier = true,
        bLockLeave = true,
        bHideChrome = false
      },
      Action = function()
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or type(obj.OnBtnClick_Observe) ~= "function" then
          return {sState = "rejected"}
        end
        obj:OnBtnClick_Observe()
        if DormGuideAdapter.ObserveState() ~= 1 then
          return {sState = "rejected"}
        end
        return {sState = "accepted"}
      end,
      End = {sMode = "Click"}
    },
    {
      sName = "dict",
      bPlayerWait = true,
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

return GuideGroup_526
