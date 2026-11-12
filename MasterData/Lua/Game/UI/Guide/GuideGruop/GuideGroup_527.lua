local GuideGroup_527 = class("GuideGroup_527")
local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
GuideGroup_527.nGroupId = 527
GuideGroup_527.nGuideType = AllEnum.GuideType.Dorm
GuideGroup_527.bNeedCheckpoint = true
local nDictId = 700107
local bDictShown = false
local nRoomId = DormGuideAdapter.ROOM2_ID
local sHead = "Icon/Head/head_11201"
local CAP = DormGuideUI.InputCap

function GuideGroup_527:OnStart()
end

function GuideGroup_527:OnClear()
  DormGuideAdapter.ReleaseGuide()
end

function GuideGroup_527:GetSteps()
  return {
    {
      sName = "dict",
      bPlayerWait = true,
      ShouldRun = function()
        if bDictShown then
          return "skip"
        end
        return "run"
      end,
      OnEnter = function()
        bDictShown = true
      end,
      Present = {sKind = "Dict", nDictId = nDictId},
      InputPolicy = {
        nSceneCap = DormGuideUI.DEFAULT_BLOCK | CAP.Move,
        bUiBarrier = false,
        bLockLeave = true,
        bHideChrome = true
      },
      End = {
        sMode = "Condition",
        Ready = function()
          return false
        end
      },
      OnExit = function(_, sReason)
        if sReason ~= "success" then
          return
        end
        DormGuideAdapter.ApplyPolicy({
          nSceneCap = DormGuideUI.DEFAULT_BLOCK | CAP.Move,
          bUiBarrier = true,
          bLockLeave = true,
          bHideChrome = false
        })
      end
    },
    {
      sName = "elevator",
      bPlayerWait = true,
      ShouldRun = function()
        local bKnown = DormGuideAdapter.RoomKnown(nRoomId)
        if bKnown == nil then
          return "run"
        end
        if bKnown ~= true then
          return "abort"
        end
        if DormGuideAdapter.IsOwnRoom(nRoomId) == true then
          return "finish"
        end
        local PanelManager = require("GameCore.UI.PanelManager")
        if PanelManager.CheckPanelOpen(PanelId.DormRoomSelectPanel) then
          return "skip"
        end
        return "run"
      end,
      WaitTrigger = {
        Ready = function()
          return DormGuideAdapter.RoomKnown(nRoomId) ~= nil
        end,
        Timeout = 3
      },
      Poll = function()
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or obj._mapNode == nil then
          return nil
        end
        return DormGuideAdapter.NodeTr(obj._mapNode.btnElevator)
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {180, 180},
          Deviation = {0, -10},
          Head = sHead,
          Desc = "Guide_527_1",
          DescDeviation = {-650, 0},
          HandDeviation = {0, 120},
          HandRotation = 180
        }
      },
      InputPolicy = {
        nSceneCap = DormGuideUI.DEFAULT_BLOCK | CAP.Move,
        bUiBarrier = true,
        bLockLeave = true,
        bHideChrome = false
      },
      Action = function()
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or type(obj.OnBtnClick_Elevator) ~= "function" then
          return {sState = "rejected"}
        end
        obj:OnBtnClick_Elevator()
        local PanelManager = require("GameCore.UI.PanelManager")
        if not PanelManager.CheckPanelOpen(PanelId.DormRoomSelectPanel) then
          return {sState = "pending"}
        end
        return {sState = "accepted"}
      end,
      End = {
        sMode = "Condition",
        Events = {
          "OnEvent_PanelOnEnableById"
        },
        Ready = function()
          local PanelManager = require("GameCore.UI.PanelManager")
          return PanelManager.CheckPanelOpen(PanelId.DormRoomSelectPanel)
        end,
        Timeout = 3
      }
    },
    {
      sName = "go_room",
      nSystemTimeout = 3,
      bReportDone = true,
      ShouldRun = function()
        if DormGuideAdapter.IsOwnRoom(nRoomId) == true then
          return "finish"
        end
        local bKnown = DormGuideAdapter.RoomKnown(nRoomId)
        if bKnown == false then
          return "abort"
        end
        return "run"
      end,
      WaitTrigger = {
        Ready = function()
          local obj = DormGuideUI._GetOverlay("roomSelect")
          if obj == nil or obj.tbAllRoom == nil then
            return false
          end
          return DormGuideAdapter.RoomKnown(nRoomId) == true
        end,
        Events = {
          "OnEvent_PanelOnEnableById"
        },
        Timeout = 3
      },
      Poll = function()
        local obj = DormGuideUI._GetOverlay("roomSelect")
        if obj == nil or obj.mapGridCtrl == nil then
          return nil
        end
        for _, objGrid in pairs(obj.mapGridCtrl) do
          if objGrid.nRoomId == nRoomId and objGrid._mapNode ~= nil and objGrid._mapNode.btnGo ~= nil then
            return objGrid._mapNode.btnGo.transform
          end
        end
        return nil
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {280, 120},
          Deviation = {0, 0},
          Head = sHead,
          Desc = "Guide_527_2",
          DescDeviation = {700, 0},
          HandDeviation = {0, 120},
          HandRotation = 180
        },
        Show = function(_, tr)
          if tr ~= nil then
            tr.gameObject:SetActive(true)
          end
        end,
        Events = {
          "DormRoomSelect_UnlockAnimEnd"
        },
        Match = function(ctx, nId)
          if nId ~= nRoomId then
            return false
          end
          ctx:Set("bUnlockAnimEnd", true)
          return true
        end,
        Ready = function(ctx, tr)
          local obj = DormGuideUI._GetOverlay("roomSelect")
          if obj == nil or type(obj.IsRoomAvailable) ~= "function" then
            return false
          end
          if obj:IsRoomAvailable(nRoomId) ~= true then
            return false
          end
          if ctx:Get("bUnlockAnimEnd") ~= true then
            return false
          end
          return tr ~= nil and tr.gameObject.activeInHierarchy
        end,
        Timeout = 3
      },
      InputPolicy = {
        nSceneCap = DormGuideUI.DEFAULT_BLOCK | CAP.Move,
        bUiBarrier = true,
        bLockLeave = true,
        bHideChrome = false
      },
      Action = function()
        local obj = DormGuideUI._GetOverlay("roomSelect")
        if obj == nil or obj.mapGridCtrl == nil then
          return {sState = "rejected"}
        end
        for _, objGrid in pairs(obj.mapGridCtrl) do
          if objGrid.nRoomId == nRoomId and type(objGrid.OnBtnClick_Go) == "function" then
            objGrid:OnBtnClick_Go()
            return {sState = "pending"}
          end
        end
        return {sState = "rejected"}
      end,
      End = {
        sMode = "Event",
        Events = {
          "OnEvent_DormLevelLoadComplete",
          "DormRoomSelect_ChangeRoomResult"
        },
        Ready = function()
          return DormGuideAdapter.RoomArrived(nRoomId)
        end,
        Timeout = 20
      }
    }
  }
end

return GuideGroup_527
