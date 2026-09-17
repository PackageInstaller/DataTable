local this = {}

function this:setTraceTask(taskID, cb)
  if C_BattleManager.IsInBattle(C_EntityManager.MainPlayer) then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.SetTaskTrace))
    return
  end
  AzurWorld.TaskMgr:ReqTaskClientTrace(taskID, true, function(errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      local list0 = C_VarList:Get()
      list0:AddInt(taskID)
      AzurWorld.TaskMgr:Dispatch(C_ETaskEvent.SetCurrentTracedTask, list0)
      if cb then
        cb()
      end
      AzurWorld.TaskMgr:GetTaskUIModule():SetSetForceCancelTrace(false)
      local list = C_VarList:Get()
      list:AddInt(1)
      list:AddBool(true)
      C_MainCityEvent.instance:Dispatch(C_EMainCityEvents.ChangeTaskHud, list)
    end
  end)
  L_AchievementUtil.getStore():ClearAchieveTrack()
end

function this:disposeTraceTask(taskId, cb)
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.SetTaskTrace))
    return
  end
  if 0 < taskId then
    AzurWorld.TaskMgr:GetTaskUIModule():SetSetForceCancelTrace(true)
    AzurWorld.TaskMgr:ReqTaskClientTrace(taskId, false, function(errorCode)
      if errorCode == L_Const.errorCode.ErrCodeSucc then
        AzurWorld.TaskMgr:Dispatch(C_ETaskEvent.SetCurrentTracedTask)
        if cb then
          cb()
        end
      else
        AzurWorld.TaskMgr:GetTaskUIModule():SetSetForceCancelTrace(false)
      end
    end)
  end
end

return this
