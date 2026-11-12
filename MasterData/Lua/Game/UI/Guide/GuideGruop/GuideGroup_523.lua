local GuideGroup_523 = class("GuideGroup_523")
local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
GuideGroup_523.nGroupId = 523
GuideGroup_523.nGuideType = AllEnum.GuideType.Dorm
GuideGroup_523.bNeedCheckpoint = true
local nDictId = 700103
local sHead = "Icon/Head/head_11101"

function GuideGroup_523:OnStart()
end

function GuideGroup_523:OnClear()
  DormGuideAdapter.ReleaseGuide()
end

function GuideGroup_523:GetSteps()
  return {
    {
      sName = "gift",
      nSystemTimeout = 3,
      bReportDone = true,
      bReportOnSkip = true,
      ShouldRun = function()
        local bGift = DormGuideAdapter.GiftState()
        if bGift == nil then
          return "run"
        end
        if bGift ~= true then
          return "skip"
        end
        return "run"
      end,
      OnEnter = function()
        DormGuideAdapter.ApplyPolicy({
          nSceneCap = DormGuideUI.DEFAULT_BLOCK,
          bUiBarrier = true,
          bLockLeave = true,
          bHideChrome = false,
          tbShowExcept = {rtGiftHint = true}
        })
      end,
      WaitTrigger = {
        Ready = function()
          return DormGuideAdapter.GiftState() == true
        end,
        Timeout = 3
      },
      Poll = function()
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or obj._mapNode == nil then
          return nil
        end
        return DormGuideAdapter.NodeTr(obj._mapNode.rtGiftHint)
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {180, 210},
          Deviation = {0, 0},
          Head = "Icon/Head/head_10301",
          Desc = "Guide_523_1",
          DescDeviation = {0, -200},
          HandDeviation = {0, 150},
          HandRotation = 180
        },
        Show = function(_, tr)
          if tr ~= nil then
            tr.gameObject:SetActive(true)
          end
        end
      },
      InputPolicy = {
        enter = {
          nSceneCap = DormGuideUI.DEFAULT_BLOCK,
          bUiBarrier = true,
          bLockLeave = true,
          bHideChrome = false,
          tbShowExcept = {rtGiftHint = true}
        },
        click = {
          nSceneCap = DormGuideUI.DEFAULT_BLOCK,
          bUiBarrier = true,
          bLockLeave = true,
          bHideChrome = false,
          tbShowExcept = {rtGiftHint = true}
        },
        request = {
          nSceneCap = DormGuideUI.DEFAULT_BLOCK,
          bUiBarrier = false,
          bLockLeave = true,
          bHideChrome = false
        }
      },
      Action = function(ctx)
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or type(obj.OnBtnClick_ReceiveDormReward) ~= "function" then
          return {sState = "rejected"}
        end
        if DormGuideAdapter.GiftState() ~= true then
          return {sState = "rejected"}
        end
        local nId, bNew = DormGuideAdapter.BeginQuest(0)
        ctx:Set("nGiftOp", nId)
        if not bNew then
          return {sState = "pending", nOpId = nId}
        end
        obj:OnBtnClick_ReceiveDormReward()
        return {sState = "pending", nOpId = nId}
      end,
      End = {
        sMode = "Event",
        Events = {
          "DormGuide_QuestReceive",
          "Guide_CloseDisposablePanel"
        },
        Ready = function(ctx)
          if DormGuideAdapter.QuestPhase(ctx:Get("nGiftOp")) ~= "done" then
            return false
          end
          if DormGuideAdapter.GiftState() ~= false then
            return false
          end
          local PanelManager = require("GameCore.UI.PanelManager")
          if PanelManager.CheckPanelOpen(PanelId.ReceivePropsTips) or PanelManager.CheckPanelOpen(PanelId.ReceivePropsNPC) or PanelManager.CheckPanelOpen(PanelId.ReceiveSpecialReward) or PanelManager.CheckPanelOpen(PanelId.ReceiveAutoTrans) then
            return false
          end
          return true
        end,
        Timeout = 3
      },
      OnExit = function()
        DormGuideAdapter.ApplyPolicy({
          bLockLeave = false,
          bHideChrome = false,
          tbShowExcept = nil
        })
      end
    },
    {
      sName = "dict",
      bPlayerWait = true,
      Present = {sKind = "Dict", nDictId = nDictId},
      InputPolicy = {
        nSceneCap = DormGuideUI.DEFAULT_BLOCK,
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

return GuideGroup_523
