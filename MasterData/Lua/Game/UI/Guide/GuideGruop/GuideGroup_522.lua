local GuideGroup_522 = class("GuideGroup_522")
local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
GuideGroup_522.nGroupId = 522
GuideGroup_522.nGuideType = AllEnum.GuideType.Dorm
GuideGroup_522.bNeedCheckpoint = true
local nFur = 700003
local nQuestId = 500011
local nDictId = 700102
local sHead = "Icon/Head/head_11201"
local CAP = DormGuideUI.InputCap
local nMoveBlock = DormGuideUI.DEFAULT_BLOCK | CAP.Move

local function Policy(bHide, bQuest)
  return {
    nSceneCap = nMoveBlock,
    bUiBarrier = true,
    bLockLeave = true,
    bHideChrome = bHide == true,
    bLockQuest = bQuest == true
  }
end

local function FurnitureListSettled()
  local obj = DormGuideAdapter._Editor()
  if obj == nil or obj._mapNode == nil then
    return false
  end
  return DormGuideAdapter.AnimatorSettled(obj._mapNode.rtFurnitureBgAnim, "FurnitureList_in")
end

function GuideGroup_522:OnStart()
end

function GuideGroup_522:OnClear()
  DormGuideAdapter.ReleaseGuide()
end

function GuideGroup_522:GetSteps()
  return {
    {
      sName = "editor",
      bPlayerWait = true,
      ShouldRun = function()
        if DormGuideAdapter.QuestStatus(nQuestId) == 2 then
          return "finish"
        end
        local sState = DormGuideAdapter.FurnitureState(nFur)
        local nMode = DormGuideAdapter.Mode()
        if sState == "saved" and nMode ~= 2 and DormGuideAdapter.HasPendingSave() ~= true then
          return "skip"
        end
        if nMode == 2 then
          return "skip"
        end
        return "run"
      end,
      Poll = function()
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or obj._mapNode == nil then
          return nil
        end
        return DormGuideAdapter.NodeTr(obj._mapNode.btnEditor)
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {180, 180},
          Deviation = {0, -10},
          Head = "Icon/Head/head_11101",
          Desc = "Guide_522_1",
          DescDeviation = {-700, 0},
          HandDeviation = {0, 120},
          HandRotation = 180,
          Type = GameEnum.guidetype.ForcedClick
        }
      },
      InputPolicy = Policy(false, false),
      Action = function()
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or type(obj.OnBtnClick_EditMode) ~= "function" then
          return {sState = "rejected"}
        end
        obj:OnBtnClick_EditMode()
        return {sState = "accepted"}
      end,
      End = {sMode = "Click"}
    },
    {
      sName = "editor_ready",
      nSystemTimeout = 3,
      ShouldRun = function()
        local sState = DormGuideAdapter.FurnitureState(nFur)
        local nMode = DormGuideAdapter.Mode()
        if sState == "saved" and nMode ~= 2 and DormGuideAdapter.HasPendingSave() ~= true then
          return "skip"
        end
        if sState == "unknown" then
          return "run"
        end
        if sState == "saved" or sState == "editing" then
          return "run"
        end
        local bCan = DormGuideAdapter.CanPlace(nFur)
        if bCan == nil then
          return "run"
        end
        local sTab = DormGuideAdapter.ResolveTab(nFur)
        if sTab == "missing" and bCan ~= true and sState == "none" then
          return "abort"
        end
        if sState == "none" and bCan ~= true and sTab ~= "unknown" then
          return "abort"
        end
        return "run"
      end,
      WaitTrigger = {
        Ready = function()
          return DormGuideAdapter.EditorReady(nFur) and FurnitureListSettled()
        end,
        Events = {
          "DormGuide_ModeApplied"
        },
        Timeout = 3
      },
      OnEnter = function(ctx)
        local sTab, nMain, nSub = DormGuideAdapter.ResolveTab(nFur)
        if sTab == "ok" then
          ctx:Set("nMainTab", nMain)
          ctx:Set("nSubIdx", nSub)
        end
        DormGuideAdapter.ResetExitEditor()
      end,
      Present = {sKind = "None"},
      InputPolicy = Policy(false, false),
      End = {
        sMode = "Condition",
        Ready = function(ctx)
          if not FurnitureListSettled() then
            return false
          end
          local sTab, nMain, nSub = DormGuideAdapter.ResolveTab(nFur)
          if sTab ~= "ok" then
            return false
          end
          ctx:Set("nMainTab", nMain)
          ctx:Set("nSubIdx", nSub)
          return true
        end,
        Timeout = 3
      }
    },
    {
      sName = "main_tab",
      bPlayerWait = true,
      ShouldRun = function(ctx)
        local sState = DormGuideAdapter.FurnitureState(nFur)
        if sState == "saved" or sState == "editing" then
          return "skip"
        end
        local sTab, nMain = DormGuideAdapter.ResolveTab(nFur)
        if sTab == "unknown" then
          return "run"
        end
        if sTab ~= "ok" then
          return "abort"
        end
        ctx:Set("nMainTab", nMain)
        local obj = DormGuideAdapter._Editor()
        if obj ~= nil and obj.nCurMainTab == nMain then
          return "skip"
        end
        return "run"
      end,
      Poll = function(ctx)
        local obj = DormGuideAdapter._Editor()
        local nMain = ctx:Get("nMainTab")
        if obj == nil or obj._mapNode == nil or obj._mapNode.listTog == nil or nMain == nil then
          return nil
        end
        return DormGuideAdapter.NodeTr(obj._mapNode.listTog[nMain])
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {150, 150},
          Deviation = {10, 0},
          Head = sHead,
          HandDeviation = {0, 80},
          HandRotation = 180,
          Type = GameEnum.guidetype.ForcedClick
        }
      },
      InputPolicy = Policy(false, false),
      Action = function(ctx)
        local obj = DormGuideAdapter._Editor()
        local nMain = ctx:Get("nMainTab")
        if obj == nil or nMain == nil or type(obj.OnBtnClick_MainTabTog) ~= "function" then
          return {sState = "rejected"}
        end
        if obj.nCurMainTab ~= nMain then
          obj:OnBtnClick_MainTabTog(nil, nMain)
        end
        if obj.nCurMainTab ~= nMain then
          return {sState = "rejected"}
        end
        return {sState = "accepted"}
      end,
      End = {sMode = "Click"}
    },
    {
      sName = "sub_tab",
      bPlayerWait = true,
      ShouldRun = function(ctx)
        local sState = DormGuideAdapter.FurnitureState(nFur)
        if sState == "saved" or sState == "editing" then
          return "skip"
        end
        local sTab, nMain, nSub = DormGuideAdapter.ResolveTab(nFur)
        if sTab == "unknown" then
          return "run"
        end
        if sTab ~= "ok" then
          return "abort"
        end
        ctx:Set("nMainTab", nMain)
        ctx:Set("nSubIdx", nSub)
        return "run"
      end,
      WaitTrigger = {
        Ready = function(ctx)
          local obj = DormGuideAdapter._Editor()
          local nMain = ctx:Get("nMainTab")
          return obj ~= nil and nMain ~= nil and obj.nCurMainTab == nMain and obj.nGuideListVer ~= nil
        end,
        Timeout = 3
      },
      Poll = function(ctx)
        local obj = DormGuideAdapter._Editor()
        local nSub = ctx:Get("nSubIdx")
        if obj == nil or obj._mapNode == nil or obj._mapNode.furnitureListTog == nil or nSub == nil then
          return nil
        end
        return DormGuideAdapter.NodeTr(obj._mapNode.furnitureListTog[nSub])
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {150, 150},
          Deviation = {-5, -5},
          Head = sHead,
          HandDeviation = {0, 120},
          HandRotation = 180,
          Type = GameEnum.guidetype.ForcedClick
        },
        Ready = function(_, tr)
          if tr == nil or tr.gameObject == nil or not tr.gameObject.activeInHierarchy then
            return false
          end
          return FurnitureListSettled()
        end
      },
      InputPolicy = Policy(false, false),
      Action = function(ctx)
        local obj = DormGuideAdapter._Editor()
        local nSub = ctx:Get("nSubIdx")
        if obj == nil or nSub == nil or type(obj.OnBtnClick_FurnitureTabTog) ~= "function" then
          return {sState = "rejected"}
        end
        local nMain = ctx:Get("nMainTab")
        local nCurSub = nMain == 1 and obj.nCurFurniturTab1 or obj.nCurFurniturTab2
        if obj.nCurMainTab ~= nMain or nCurSub ~= nSub then
          obj:OnBtnClick_FurnitureTabTog(nil, nSub)
        end
        nCurSub = nMain == 1 and obj.nCurFurniturTab1 or obj.nCurFurniturTab2
        if nCurSub ~= nSub then
          return {sState = "rejected"}
        end
        return {sState = "accepted"}
      end,
      End = {sMode = "Click"}
    },
    {
      sName = "furniture",
      bPlayerWait = true,
      ShouldRun = function()
        local sState = DormGuideAdapter.FurnitureState(nFur)
        if sState == "saved" or sState == "editing" then
          return "skip"
        end
        return "run"
      end,
      Prepare = {
        Ready = function(ctx)
          local obj = DormGuideAdapter._Editor()
          local nMain = ctx:Get("nMainTab")
          local nSub = ctx:Get("nSubIdx")
          if obj == nil or nMain == nil or nSub == nil or obj.nGuideListVer == nil then
            return false
          end
          if obj.nCurMainTab ~= nMain then
            return false
          end
          local nCurSub = nMain == 1 and obj.nCurFurniturTab1 or obj.nCurFurniturTab2
          return nCurSub == nSub
        end,
        Run = function()
          return DormGuideUI.PositionFurniture(nFur) == true
        end,
        Version = function()
          local obj = DormGuideAdapter._Editor()
          return obj ~= nil and obj.nGuideListVer or nil
        end,
        Timeout = 3
      },
      WaitTrigger = {
        Ready = function()
          local obj = DormGuideAdapter._Editor()
          return obj ~= nil and obj.nGuideListVer ~= nil and DormGuideUI.GetFurnitureListIndex(nFur) ~= nil
        end,
        Timeout = 3
      },
      Poll = function()
        local _, mapCtrl = DormGuideUI._GetFurnitureCtrl(nFur)
        if mapCtrl == nil then
          return nil
        end
        if mapCtrl._mapNode ~= nil and mapCtrl._mapNode.rtContent ~= nil then
          return mapCtrl._mapNode.rtContent.transform
        end
        if mapCtrl.gameObject ~= nil then
          return mapCtrl.gameObject.transform
        end
        return nil
      end,
      CacheId = function(_, tr)
        local objEditor = DormGuideAdapter._Editor()
        local nVer = 0
        if objEditor ~= nil and objEditor.nGuideListVer ~= nil then
          nVer = objEditor.nGuideListVer
        end
        return {
          nFur = nFur,
          nInst = tr.gameObject:GetInstanceID(),
          nVer = nVer
        }
      end,
      CacheValid = function(_, tr, mapId)
        if mapId == nil or tr == nil or tr.gameObject == nil then
          return false
        end
        if tr.gameObject:GetInstanceID() ~= mapId.nInst then
          return false
        end
        local _, mapCtrl = DormGuideUI._GetFurnitureCtrl(nFur)
        if mapCtrl == nil then
          return false
        end
        if mapCtrl._mapNode ~= nil and mapCtrl._mapNode.rtContent ~= nil then
          return tr.gameObject:GetInstanceID() == mapCtrl._mapNode.rtContent.gameObject:GetInstanceID()
        end
        return tr.gameObject:GetInstanceID() == mapCtrl.gameObject:GetInstanceID()
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {180, 180},
          Deviation = {-3, 23},
          Head = sHead,
          Desc = "Guide_522_4",
          DescDeviation = {700, 10},
          HandDeviation = {0, 150},
          HandRotation = 180,
          Type = GameEnum.guidetype.ForcedClick
        },
        Ready = function(_, tr)
          if tr == nil or tr.gameObject == nil or not tr.gameObject.activeInHierarchy then
            return false
          end
          return FurnitureListSettled()
        end,
        Timeout = 3
      },
      InputPolicy = Policy(false, false),
      Action = function()
        local obj, mapCtrl = DormGuideUI._GetFurnitureCtrl(nFur)
        local nIdx = DormGuideUI.GetFurnitureListIndex(nFur)
        local objPanel = DormGuideAdapter._Panel()
        if obj == nil or mapCtrl == nil or nIdx == nil or objPanel == nil then
          return {sState = "rejected"}
        end
        local nBefore = objPanel.tempEditCount[nFur] or 0
        obj:OnFurnitureBtnClickGrid(mapCtrl.gameObject, nIdx - 1)
        local nAfter = objPanel.tempEditCount[nFur] or 0
        if obj.nCurEditFurniture ~= nFur or nBefore >= nAfter then
          return {sState = "rejected"}
        end
        return {sState = "accepted"}
      end,
      End = {sMode = "Click"}
    },
    {
      sName = "hud",
      bPlayerWait = true,
      ShouldRun = function()
        local obj = DormGuideAdapter._Editor()
        if obj ~= nil and obj.nCurEditFurniture == nFur then
          return "run"
        end
        local sState = DormGuideAdapter.FurnitureState(nFur)
        if sState == "saved" or sState == "editing" then
          return "skip"
        end
        return "run"
      end,
      WaitTrigger = {
        Ready = function()
          local obj = DormGuideAdapter._Editor()
          return obj ~= nil and obj.nCurEditFurniture == nFur and obj._mapNode ~= nil and (obj._mapNode.btnHudCancel ~= nil or obj._mapNode.btnHudConfirm ~= nil)
        end,
        Events = {
          "DORM_CS_SWITCH_FURNITURE"
        },
        Timeout = 3
      },
      Poll = function()
        local obj = DormGuideAdapter._Editor()
        if obj == nil or obj._mapNode == nil then
          return nil
        end
        local node = obj._mapNode.btnHudCancel or obj._mapNode.btnHudConfirm
        return DormGuideAdapter.NodeTr(node)
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {120, 120},
          Deviation = {0, 5},
          Head = sHead,
          Desc = "Guide_522_5",
          DescDeviation = {0, -200},
          HandDeviation = {0, 120},
          HandRotation = 180,
          Type = GameEnum.guidetype.ForcedClick
        },
        Show = function(_, tr)
          if tr ~= nil then
            tr.gameObject:SetActive(true)
          end
        end,
        Ready = function(_, tr)
          if tr == nil or tr.gameObject == nil or not tr.gameObject.activeInHierarchy then
            return false
          end
          local obj = DormGuideAdapter._Editor()
          if obj == nil or obj._mapNode == nil then
            return false
          end
          return DormGuideAdapter.AnimatorSettled(obj._mapNode.animHud, "RoomEditorbtn_in")
        end
      },
      InputPolicy = Policy(false, false),
      Action = function()
        local obj = DormGuideAdapter._Editor()
        if obj == nil or type(obj.OnBtnClick_ExitEditor) ~= "function" then
          return {sState = "rejected"}
        end
        obj:OnBtnClick_ExitEditor()
        if obj.nCurEditFurniture ~= 0 then
          return {sState = "rejected"}
        end
        return {sState = "accepted"}
      end,
      End = {sMode = "Click"}
    },
    {
      sName = "save",
      nSystemTimeout = 3,
      bReportDone = true,
      bReportOnSkip = true,
      ShouldRun = function()
        local sState = DormGuideAdapter.FurnitureState(nFur)
        if sState == "unknown" then
          return "run"
        end
        if sState == "saved" and DormGuideAdapter.HasPendingSave() == false then
          return "skip"
        end
        return "run"
      end,
      Poll = function()
        local obj = DormGuideAdapter._Editor()
        if obj == nil or obj._mapNode == nil then
          return nil
        end
        return DormGuideAdapter.NodeTr(obj._mapNode.btnSaveRoom)
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {480, 140},
          Deviation = {0, 0},
          Desc = "Guide_522_6",
          DescDeviation = {-800, -100},
          HandDeviation = {0, -120},
          HandRotation = 0,
          Type = GameEnum.guidetype.ForcedClick
        },
        Show = function(_, tr)
          if tr ~= nil then
            tr.gameObject:SetActive(true)
          end
        end
      },
      InputPolicy = {
        enter = Policy(false, false),
        click = Policy(false, false),
        request = Policy(false, false)
      },
      Action = function(ctx)
        local nId, bNew = DormGuideAdapter.BeginSave()
        ctx:Set("nSaveId", nId)
        if not bNew then
          return {sState = "pending", nOpId = nId}
        end
        local obj = DormGuideAdapter._Editor()
        if obj == nil or type(obj.OnBtnClick_SaveRoom) ~= "function" then
          return {sState = "rejected", nOpId = nId}
        end
        obj:OnBtnClick_SaveRoom()
        local sPhase = DormGuideAdapter.SavePhase(nId)
        if sPhase == "rejected" then
          return {sState = "rejected", nOpId = nId}
        end
        if sPhase == "done" then
          return {sState = "done", nOpId = nId}
        end
        return {sState = "pending", nOpId = nId}
      end,
      End = {
        sMode = "Event",
        Events = {
          "DormGuide_SaveResult"
        },
        Ready = function(ctx)
          return DormGuideAdapter.SavePhase(ctx:Get("nSaveId")) == "done"
        end,
        Timeout = 3
      }
    },
    {
      sName = "save_exit",
      nSystemTimeout = 3,
      Prepare = {
        Ready = function()
          return DormGuideAdapter.Mode() ~= nil
        end,
        Run = function(ctx)
          if DormGuideAdapter.Mode() ~= 2 then
            return true
          end
          if DormGuideAdapter.SaveCutscenePlaying(ctx:Get("nSaveId")) then
            return false
          end
          return DormGuideAdapter.ExitEditorOnce()
        end,
        Events = {
          "DormGuide_SaveCutsceneEnd",
          "DormPanel_BtnInteractive"
        },
        Timeout = 20
      },
      WaitTrigger = {
        Ready = function(ctx)
          local nMode = DormGuideAdapter.Mode()
          if nMode ~= 0 and nMode ~= 1 then
            return false
          end
          local nSave = ctx:Get("nSaveId")
          if nSave == nil then
            return true
          end
          return DormGuideAdapter.SaveSettled(nSave)
        end,
        Events = {
          "DormGuide_SaveCutsceneEnd",
          "DormGuide_ModeApplied",
          "DormPanel_BtnInteractive"
        },
        Interval = 0,
        Timeout = 3
      },
      Present = {sKind = "None"},
      InputPolicy = {
        nSceneCap = nMoveBlock,
        bUiBarrier = false,
        bLockLeave = true,
        bHideChrome = false
      },
      End = {
        sMode = "Condition",
        Ready = function(ctx)
          local nMode = DormGuideAdapter.Mode()
          if nMode ~= 0 and nMode ~= 1 then
            return false
          end
          local nSave = ctx:Get("nSaveId")
          if nSave == nil then
            return true
          end
          return DormGuideAdapter.SaveSettled(nSave)
        end,
        Timeout = 3
      },
      OnExit = function(_, sReason)
        if sReason ~= "success" and sReason ~= "skip" then
          return
        end
        DormGuideAdapter.ApplyPolicy({
          nSceneCap = nMoveBlock,
          bUiBarrier = true,
          bLockLeave = true,
          bHideChrome = false,
          bLockQuest = true
        })
      end
    },
    {
      sName = "dict",
      bPlayerWait = true,
      Present = {sKind = "Dict", nDictId = nDictId},
      InputPolicy = {
        nSceneCap = nMoveBlock,
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
        if sReason ~= "success" and sReason ~= "skip" then
          return
        end
        DormGuideAdapter.ApplyPolicy({
          nSceneCap = nMoveBlock,
          bUiBarrier = true,
          bLockLeave = true,
          bHideChrome = false,
          bLockQuest = true
        })
      end
    },
    {
      sName = "quest_card",
      bPlayerWait = true,
      Find = {Timeout = 3},
      ShouldRun = function()
        if DormGuideAdapter.QuestStatus(nQuestId) == 2 then
          return "finish"
        end
        return "run"
      end,
      WaitTrigger = {
        Ready = function()
          return DormGuideAdapter.QuestStatus(nQuestId) ~= nil
        end,
        Timeout = 3
      },
      Poll = function()
        return DormGuideAdapter.GetQuestCardTransform()
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {400, 200},
          Deviation = {-50, 10},
          Head = sHead,
          HandDeviation = {0, 120},
          HandRotation = 180,
          Type = GameEnum.guidetype.ForcedClick
        },
        Ready = function(_, tr)
          if tr == nil or tr.gameObject == nil or not tr.gameObject.activeInHierarchy then
            return false
          end
          return DormGuideAdapter.QuestCardSettled()
        end,
        Timeout = 3
      },
      InputPolicy = Policy(false, true),
      Action = function()
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or type(obj.OnBtnClick_Quest) ~= "function" then
          return {sState = "rejected"}
        end
        obj:OnBtnClick_Quest()
        return {sState = "accepted"}
      end,
      End = {
        sMode = "Condition",
        Events = {
          "OnEvent_PanelOnEnableById"
        },
        Ready = function()
          local PanelManager = require("GameCore.UI.PanelManager")
          return PanelManager.CheckPanelOpen(PanelId.DormQuestPanel)
        end,
        Timeout = 3
      }
    },
    {
      sName = "receive",
      nSystemTimeout = 3,
      ShouldRun = function()
        local PanelManager = require("GameCore.UI.PanelManager")
        if not PanelManager.CheckPanelOpen(PanelId.DormQuestPanel) then
          return "run"
        end
        local nStatus = DormGuideAdapter.QuestStatus(nQuestId)
        if nStatus == nil then
          return "run"
        end
        if nStatus == 2 then
          return "finish"
        end
        return "run"
      end,
      WaitTrigger = {
        Ready = function()
          return DormGuideAdapter.QuestStatus(nQuestId) == 1
        end,
        Timeout = 3
      },
      Poll = function()
        local obj = DormGuideUI._GetOverlay("quest")
        if obj == nil or obj._mapCtrl == nil then
          return nil
        end
        for _, objGrid in pairs(obj._mapCtrl) do
          if objGrid.mapDormQuest ~= nil and objGrid.mapDormQuest.nTid == nQuestId and objGrid._mapNode ~= nil and objGrid._mapNode.btnReceive ~= nil then
            return objGrid._mapNode.btnReceive.transform
          end
        end
        return nil
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {200, 120},
          Deviation = {0, 0},
          Head = sHead,
          HandDeviation = {0, 80},
          HandRotation = 180,
          Type = GameEnum.guidetype.ForcedClick
        },
        Ready = function()
          local obj = DormGuideUI._GetOverlay("quest")
          return obj ~= nil and type(obj.IsGuideEnterDone) == "function" and obj:IsGuideEnterDone()
        end,
        Timeout = 3
      },
      InputPolicy = {
        enter = Policy(false, true),
        click = Policy(false, true),
        request = {
          nSceneCap = nMoveBlock,
          bUiBarrier = false,
          bLockLeave = true,
          bHideChrome = false,
          bLockQuest = true
        }
      },
      Action = function(ctx)
        local nId, bNew = DormGuideAdapter.BeginQuest(nQuestId)
        ctx:Set("nQuestOp", nId)
        if not bNew then
          return {sState = "pending", nOpId = nId}
        end
        local obj = DormGuideUI._GetOverlay("quest")
        if obj == nil or type(obj.OnEvent_GridRecieveClick) ~= "function" then
          return {sState = "rejected", nOpId = nId}
        end
        obj:OnEvent_GridRecieveClick(nQuestId)
        local sPhase = DormGuideAdapter.QuestPhase(nId)
        if sPhase == "done" then
          return {sState = "done", nOpId = nId}
        end
        if sPhase == "rejected" then
          return {sState = "rejected", nOpId = nId}
        end
        return {sState = "pending", nOpId = nId}
      end,
      End = {
        sMode = "Event",
        Events = {
          "DormGuide_QuestReceive"
        },
        Ready = function(ctx)
          if DormGuideAdapter.QuestPhase(ctx:Get("nQuestOp")) == "done" then
            return true
          end
          return DormGuideAdapter.QuestStatus(nQuestId) == 2 and DormGuideAdapter.QuestPhase(ctx:Get("nQuestOp")) ~= "pending"
        end,
        Timeout = 3
      }
    }
  }
end

return GuideGroup_522
