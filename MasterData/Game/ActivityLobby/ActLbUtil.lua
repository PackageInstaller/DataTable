local ActLbUtil = {}

function ActLbUtil.OnActLbInteractEnter(isEnter, isEye)
  if isEnter then
    UIManager:HideWindow(UIWindowTypeID.ActLobbyMain)
    UIManager:HideWindow(UIWindowTypeID.ActLbFollowInfo)
  else
    UIManager:ShowWindowOnly(UIWindowTypeID.ActLobbyMain)
    UIManager:ShowWindowOnly(UIWindowTypeID.ActLbFollowInfo)
  end
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl then
    actLbCtrl.actLbIntrctCtrl:InvokeActLbInteractEnterFunc(isEnter, isEye)
  end
end

function ActLbUtil.UpdLbCurInteractList()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl then
    actLbCtrl.actLbIntrctCtrl:UpdLbCurInteractList()
  end
end

function ActLbUtil.UpdLbCurInteractEntShow(actFrameId)
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl and (actFrameId == nil or actLbCtrl:GetActLbActId() == actFrameId) then
    actLbCtrl.actLbIntrctCtrl:SetAllLbInteractObjShow()
  end
end

function ActLbUtil.UpdLbCurFollowInfoShow()
  MsgCenter:Broadcast(eMsgEventId.UpdActLbFollowUI)
  local lbFollowInfoWin = UIManager:GetWindow(UIWindowTypeID.ActLbFollowInfo)
  if lbFollowInfoWin then
    lbFollowInfoWin:UpdUIActLbFollowInfoExternalShowUI()
  end
end

function ActLbUtil.UpdLbEnttBluedot(enttId)
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil then
    return
  end
  local infoWin = UIManager:GetWindow(UIWindowTypeID.ActLbFollowInfo)
  if infoWin then
    infoWin:UpdActLbFollowInfoItemBludotById(enttId)
  end
  local mainWin = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
  if mainWin then
    local intractData = actLbCtrl.actLbIntrctCtrl:GetActLbIntractDataById(enttId)
    local actionIdList = intractData and intractData:GetLbIntrctObjActionIdList() or table.emptytable
    for k, actionId in pairs(actionIdList) do
      mainWin.quickEntranceNode:UpdActLbQuickEntranceItemBludotById(actionId)
    end
  end
end

function ActLbUtil.UpdLbEntranceBlueDot(enttidDic, FuncDic)
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil then
    return
  end
  local mainWin = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
  if mainWin then
    local blueDotShow = false
    for k, v in pairs(enttidDic) do
      local intractData = actLbCtrl.actLbIntrctCtrl:GetActLbIntractDataById(v)
      local actionIdList = intractData and intractData:GetLbIntrctObjActionIdList() or table.emptytable
      for k, actionId in pairs(actionIdList) do
        local actionFunc = FuncDic[actionId]
        if actionFunc then
          blueDotShow = actionFunc(intractData)
        end
        if blueDotShow then
          break
        end
      end
      if blueDotShow then
        break
      end
    end
    mainWin:ShowQuickEntranceBlueDot(blueDotShow)
  end
end

function ActLbUtil.GetActLbFlowUIScaleParam()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil then
    error("actLbCtrl == nil")
    return
  end
  local actLbCfg = actLbCtrl:GetActLbCfg()
  local param = actLbCfg.ui_scale
  local uiScaleMin, uiScaleMax, camDisMin, camDisMax = param[1], param[2], param[3], param[4]
  return uiScaleMin, uiScaleMax, camDisMin, camDisMax
end

function ActLbUtil.GetActLvFlowUIPosConstraint()
  local xLeft = UIManager:GetScreenWidthSafe() / 2 - 390
  local yTop = UIManager.BackgroundStretchSize.y / 2 - 140
  return xLeft, yTop
end

function ActLbUtil.ConstrantActLvFlowUIPos(posX, posY, itemWidth)
  local xLeft, yTop = ActLbUtil.GetActLvFlowUIPosConstraint()
  local constraintXLeft = -xLeft + itemWidth
  local constraintYTop = yTop - itemWidth
  posX = math.max(posX, constraintXLeft)
  posY = math.min(posY, constraintYTop)
  return posX, posY
end

function ActLbUtil.UpdActLbEnttUnlockStateByObjId(objId)
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil then
    return
  end
  local mainWin = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
  if mainWin then
    local intractData = actLbCtrl.actLbIntrctCtrl:GetActLbIntractDataById(objId)
    local actionIdList = intractData and intractData:GetLbIntrctObjActionIdList() or table.emptytable
    for k, actionId in pairs(actionIdList) do
      mainWin.quickEntranceNode:UpdActLbQuickEntranceItemUnlockById(actionId)
    end
  end
  local infoWin = UIManager:GetWindow(UIWindowTypeID.ActLbFollowInfo)
  if infoWin then
    infoWin:UpdActLbFollowInfoItemUnlockById(objId)
  end
  actLbCtrl.actLbIntrctCtrl:UpdLbIntrctEntFxUnlockById(objId)
  actLbCtrl.actLbIntrctCtrl:UpdLbCurInteractAction()
end

function ActLbUtil.GetCurActLbActId()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  return actLbCtrl and actLbCtrl:GetActLbActId() or nil
end

function ActLbUtil.ActLbActivityRunningTimeout(actId)
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil or actLbCtrl:GetActLbActId() ~= actId then
    return
  end
  local mainWin = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
  if mainWin then
    mainWin.quickEntranceNode:UpdActLbQuickEntranceItemState()
    mainWin:UpdActLbTopRes()
  end
  local infoWin = UIManager:GetWindow(UIWindowTypeID.ActLbFollowInfo)
  if infoWin then
    infoWin:UpdActLbFollowInfoItemState()
  end
  actLbCtrl.actLbIntrctCtrl:UpdAllLbIntrctEntFxUnlock()
  actLbCtrl.actLbIntrctCtrl:InvokeLbActivityRunningTimeoutFunc()
  actLbCtrl.actLbIntrctCtrl:UpdLbCurInteractAction()
end

function ActLbUtil.PlayLbUIAnimation()
  local missionWin = UIManager:GetWindow(UIWindowTypeID.Spring23Misson)
  local mainWin = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
  if missionWin then
    missionWin:PlayMissionAni()
  end
  if mainWin then
    mainWin:PlayQuickAni()
  end
end

function ActLbUtil.ActLbActivityFinish(actId)
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil or actLbCtrl:GetActLbActId() ~= actId then
    return
  end
  actLbCtrl.actLbIntrctCtrl:InvokeLbActivityFinishedFunc()
  ActLbUtil.ExitActivityLobby(false)
end

function ActLbUtil.ExitActivityLobby(toHome)
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil then
    return
  end
  actLbCtrl:ExitActLbCtrl(toHome)
end

return ActLbUtil
