local GuideGroup_524 = class("GuideGroup_524")
local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
GuideGroup_524.nGroupId = 524
GuideGroup_524.nGuideType = AllEnum.GuideType.Dorm
GuideGroup_524.bNeedCheckpoint = true
local nRoleId = 103
local nDictId = 700104
local sHead = "Icon/Head/head_11101"
local CAP = DormGuideUI.InputCap
local nApproachCap = CAP.Zoom | CAP.PickFur
local nCaressCap = CAP.Zoom | CAP.Move | CAP.PickFur

local function SelectOpen()
  local obj = DormGuideAdapter._Select()
  return obj ~= nil and obj.bOpen == true
end

local function RoomFullWithoutRole()
  if DormGuideAdapter.RoleInRoom(nRoleId) ~= false then
    return false
  end
  local objPanel = DormGuideAdapter._Panel()
  if objPanel == nil or objPanel.nCurRoom == nil or objPanel.mapDormRoomInfo == nil then
    return false
  end
  local mapRoom = objPanel.mapDormRoomInfo[objPanel.nCurRoom]
  if mapRoom == nil or mapRoom.RoleList == nil then
    return false
  end
  local mapCfg = ConfigTable.GetData("DormRoom", objPanel.nCurRoom)
  if mapCfg == nil or mapCfg.RoleNum == nil or mapCfg.RoleNum <= 0 then
    return false
  end
  return #mapRoom.RoleList >= mapCfg.RoleNum
end

function GuideGroup_524:OnStart()
end

function GuideGroup_524:OnClear()
  DormGuideAdapter.ReleaseGuide()
end

function GuideGroup_524:GetSteps()
  return {
    {
      sName = "char_btn",
      bPlayerWait = true,
      ShouldRun = function()
        if RoomFullWithoutRole() then
          return "finish"
        end
        if SelectOpen() then
          return "skip"
        end
        return "run"
      end,
      Poll = function()
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or obj._mapNode == nil then
          return nil
        end
        return DormGuideAdapter.NodeTr(obj._mapNode.btnCharacter)
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {180, 180},
          Deviation = {0, -10},
          Desc = "Guide_524_1",
          DescDeviation = {-700, -10},
          Head = sHead,
          HandDeviation = {0, 80},
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
        if obj == nil or type(obj.OnBtnClick_Character) ~= "function" then
          return {sState = "rejected"}
        end
        obj:OnBtnClick_Character()
        if not SelectOpen() then
          return {sState = "rejected"}
        end
        return {sState = "accepted"}
      end,
      End = {sMode = "Click"}
    },
    {
      sName = "pick",
      bPlayerWait = true,
      ShouldRun = function()
        local obj = DormGuideAdapter._Select()
        if obj ~= nil and obj.curChar ~= nil and table.indexof(obj.curChar, nRoleId) > 0 then
          return "skip"
        end
        if not SelectOpen() then
          if RoomFullWithoutRole() then
            return "finish"
          end
          return "run"
        end
        if obj.tbCharInRoom ~= nil and obj.tbCharInRoom[nRoleId] ~= nil then
          return "abort"
        end
        if obj.tbSortedChar ~= nil and 0 < #obj.tbSortedChar and 0 >= table.indexof(obj.tbSortedChar, nRoleId) then
          return "abort"
        end
        if obj.curChar ~= nil and table.indexof(obj.curChar, 0) <= 0 and table.indexof(obj.curChar, nRoleId) <= 0 then
          return "finish"
        end
        return "run"
      end,
      WaitTrigger = {
        Ready = function()
          return SelectOpen()
        end,
        Timeout = 3
      },
      Prepare = {
        Ready = function()
          return SelectOpen()
        end,
        Run = function()
          return DormGuideUI.PrepareCharSelect(nRoleId) == true
        end,
        Version = function()
          local obj = DormGuideAdapter._Select()
          return obj ~= nil and obj.nGuideOpenVer or nil
        end,
        Timeout = 3
      },
      Poll = function()
        local obj = DormGuideAdapter._Select()
        if obj == nil or obj.mapGridCtrl == nil then
          return nil
        end
        for _, mapCtrl in pairs(obj.mapGridCtrl) do
          if mapCtrl.nCharId == nRoleId and mapCtrl._mapNode ~= nil and mapCtrl._mapNode.btnGrid ~= nil then
            return mapCtrl._mapNode.btnGrid.transform
          end
        end
        return nil
      end,
      CacheId = function(_, tr)
        return {
          nRole = nRoleId,
          nInst = tr.gameObject:GetInstanceID()
        }
      end,
      CacheValid = function(_, tr, mapId)
        local obj = DormGuideAdapter._Select()
        if obj == nil or obj.mapGridCtrl == nil or tr == nil or tr.gameObject == nil or mapId == nil then
          return false
        end
        for _, mapCtrl in pairs(obj.mapGridCtrl) do
          if mapCtrl.nCharId == nRoleId and mapCtrl._mapNode ~= nil and mapCtrl._mapNode.btnGrid ~= nil then
            return mapCtrl._mapNode.btnGrid.gameObject:GetInstanceID() == mapId.nInst
          end
        end
        return false
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {200, 200},
          Deviation = {0, 0},
          Desc = "Guide_524_2",
          DescDeviation = {-700, 0},
          Head = sHead,
          HandDeviation = {0, 150},
          HandRotation = 180
        }
      },
      InputPolicy = {
        nSceneCap = DormGuideUI.DEFAULT_BLOCK | CAP.Move,
        bUiBarrier = true,
        bLockLeave = true,
        bHideChrome = true,
        bKeepContact = true
      },
      Action = function()
        local obj = DormGuideAdapter._Select()
        if obj == nil or obj.tbSortedChar == nil or type(obj.OnGridBtnClick) ~= "function" then
          return {sState = "rejected"}
        end
        if table.indexof(obj.curChar, nRoleId) > 0 then
          return {sState = "accepted"}
        end
        local nIdx = table.indexof(obj.tbSortedChar, nRoleId)
        if nIdx == nil or nIdx <= 0 then
          return {sState = "rejected"}
        end
        local go
        for _, mapCtrl in pairs(obj.mapGridCtrl) do
          if mapCtrl.nCharId == nRoleId then
            go = mapCtrl.gameObject
            break
          end
        end
        if go == nil then
          return {sState = "rejected"}
        end
        obj:OnGridBtnClick(go, nIdx - 1)
        if table.indexof(obj.curChar, nRoleId) <= 0 then
          return {sState = "rejected"}
        end
        return {sState = "accepted"}
      end,
      End = {sMode = "Click"}
    },
    {
      sName = "confirm",
      nSystemTimeout = 3,
      bReportDone = true,
      bReportOnSkip = true,
      ShouldRun = function()
        if not SelectOpen() and DormGuideAdapter.RoleInRoom(nRoleId) == true then
          local nMode = DormGuideAdapter.Mode()
          if nMode == 0 or nMode == 1 then
            return "skip"
          end
        end
        return "run"
      end,
      Poll = function()
        local obj = DormGuideAdapter._Select()
        if obj == nil or obj._mapNode == nil then
          return nil
        end
        return DormGuideAdapter.NodeTr(obj._mapNode.btnConfirm)
      end,
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {330, 120},
          Deviation = {0, 5},
          HandDeviation = {0, 80},
          HandRotation = 180
        },
        Ready = function()
          local obj = DormGuideAdapter._Select()
          if obj == nil then
            return false
          end
          return DormGuideAdapter.AnimatorSettled(obj.animator, "LiveTogether_in")
        end,
        Timeout = 3
      },
      InputPolicy = {
        nSceneCap = DormGuideUI.DEFAULT_BLOCK | CAP.Move,
        bUiBarrier = true,
        bLockLeave = true,
        bHideChrome = true,
        bKeepContact = true
      },
      Action = function(ctx)
        local nId, bNew = DormGuideAdapter.BeginCharConfirm()
        ctx:Set("nCharOp", nId)
        if not bNew then
          return {sState = "pending", nOpId = nId}
        end
        local obj = DormGuideAdapter._Select()
        if obj == nil or type(obj.OnBtnClick_Confirm) ~= "function" then
          return {sState = "rejected", nOpId = nId}
        end
        obj:OnBtnClick_Confirm()
        return {sState = "pending", nOpId = nId}
      end,
      End = {
        sMode = "Event",
        Events = {
          "DormGuide_CharSelectClosed",
          "DormGuide_ModeApplied"
        },
        Ready = function(ctx)
          return DormGuideAdapter.CharConfirmReady(ctx:Get("nCharOp"), nRoleId)
        end,
        Timeout = 3
      }
    },
    {
      sName = "approach_avg",
      bPlayerWait = true,
      WaitTrigger = {
        Ready = function()
          if DormGuideAdapter.RoleInRoom(nRoleId) ~= true then
            return false
          end
          if SelectOpen() then
            return false
          end
          local nMode = DormGuideAdapter.Mode()
          return nMode == 0 or nMode == 1
        end,
        Timeout = 3
      },
      Present = {
        sKind = "Avg",
        sAvgId = DormGuideAdapter.APPROACH_AVG_ID,
        sAvgGroup = DormGuideAdapter.APPROACH_AVG_GROUP
      },
      InputPolicy = {
        nSceneCap = nApproachCap,
        bUiBarrier = false,
        bLockLeave = true,
        bHideChrome = true,
        bKeepContact = true
      },
      End = {
        sMode = "Condition",
        Ready = function()
          return false
        end
      }
    },
    {
      sName = "caress",
      bPlayerWait = true,
      Poll = function()
        if DormGuideAdapter.ContactRole() ~= nRoleId then
          return nil
        end
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or obj._mapNode == nil or obj._mapNode.rtContact == nil or obj._mapNode.rtContact._mapNode == nil then
          return nil
        end
        return DormGuideAdapter.NodeTr(obj._mapNode.rtContact._mapNode.btnInteractive1)
      end,
      WaitTrigger = {
        Ready = function()
          return DormGuideAdapter.ContactRole() == nRoleId
        end,
        Events = {
          "DormShowInteractiveBtns"
        },
        bPlayerWait = true
      },
      Present = {
        sKind = "Mask",
        mapMask = {
          Size = {180, 180},
          Deviation = {5, 5},
          Desc = "Guide_524_4",
          DescDeviation = {0, -200},
          Head = sHead,
          HandDeviation = {0, 80},
          HandRotation = 180
        },
        Ready = function(_, tr)
          if DormGuideAdapter.MarkFocus(nRoleId) ~= true then
            return false
          end
          local obj = DormGuideAdapter._Interactive()
          local anim
          if obj ~= nil and obj._mapNode ~= nil and obj._mapNode.rtContact ~= nil and obj._mapNode.rtContact._mapNode ~= nil then
            anim = obj._mapNode.rtContact._mapNode.CharInteractiveHideAnim
          end
          if tr ~= nil and tr.gameObject ~= nil and not tr.gameObject.activeInHierarchy then
            return false
          end
          return DormGuideAdapter.AnimatorSettled(anim, "DormCharInteractiveHide_in")
        end,
        Events = {
          "DormShowInteractiveBtns"
        },
        Timeout = 3
      },
      InputPolicy = {
        enter = {
          nSceneCap = nApproachCap,
          bUiBarrier = false,
          bLockLeave = true,
          bHideChrome = true,
          bKeepContact = true
        },
        click = {
          nSceneCap = nCaressCap,
          bUiBarrier = true,
          bLockLeave = true,
          bHideChrome = true,
          bKeepContact = true
        },
        request = {
          nSceneCap = nCaressCap,
          bUiBarrier = true,
          bLockLeave = true,
          bHideChrome = true,
          bKeepContact = true
        }
      },
      Action = function(ctx)
        local nId, bNew = DormGuideAdapter.BeginCaress()
        ctx:Set("nCaressOp", nId)
        if not bNew then
          return {sState = "pending", nOpId = nId}
        end
        local obj = DormGuideAdapter._Interactive()
        if obj == nil or obj._mapNode == nil or obj._mapNode.rtContact == nil then
          return {sState = "rejected", nOpId = nId}
        end
        local objContact = obj._mapNode.rtContact
        if type(objContact.OnBtnClick_Interactive1) ~= "function" then
          return {sState = "rejected", nOpId = nId}
        end
        objContact:OnBtnClick_Interactive1()
        local sPhase = DormGuideAdapter.CaressPhase(nId)
        if sPhase == "rejected" then
          return {sState = "rejected", nOpId = nId}
        end
        if sPhase == "opened" then
          return {sState = "pending", nOpId = nId}
        end
        return {sState = "accepted", nOpId = nId}
      end,
      End = {
        sMode = "Condition",
        Ready = function(ctx)
          local sPhase = DormGuideAdapter.CaressPhase(ctx:Get("nCaressOp"))
          return sPhase == "performing" or sPhase == "reward" or sPhase == "level" or sPhase == "done"
        end
      }
    },
    {
      sName = "caress_feedback",
      nSystemTimeout = 3,
      WaitTrigger = {
        Ready = function(ctx)
          return DormGuideAdapter.CaressPhase(ctx:Get("nCaressOp")) == "done"
        end,
        Events = {
          "DormGuide_CaressDone",
          "Guide_CloseDisposablePanel"
        },
        Timeout = 6
      },
      Present = {sKind = "None"},
      InputPolicy = {
        nSceneCap = nCaressCap,
        bUiBarrier = false,
        bLockLeave = true,
        bHideChrome = true,
        bKeepContact = true
      },
      End = {
        sMode = "Condition",
        Ready = function(ctx)
          return DormGuideAdapter.CaressPhase(ctx:Get("nCaressOp")) == "done"
        end,
        Timeout = 3
      },
      OnExit = function()
        DormGuideAdapter.HandOffDormUi()
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

return GuideGroup_524
