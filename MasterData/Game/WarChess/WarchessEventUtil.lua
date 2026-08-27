local WarchessEventUtil = {}

function WarchessEventUtil:DealEventDataByMsg(eventSystemData)
  local eventCfg = ConfigData.warchess_event[eventSystemData.eventId]
  local choiceDatas = {}
  for index, choiceId in ipairs(eventSystemData.choices) do
    local choiceData = {
      index = index - 1,
      couldChoice = eventSystemData.choiceApply[index],
      choiceCfg = ConfigData.warchess_event_choice[choiceId]
    }
    if choiceData.choiceCfg == nil then
      error("choice cfg not exist choiceId:" .. tostring(choiceId))
      return
    end
    table.insert(choiceDatas, choiceData)
  end
  return eventCfg, choiceDatas
end

function WarchessEventUtil:ApplyWcEventInBattle(eventId, isBeforeBattle, selectFunc, exitFunc)
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local teamData = wcCtrl.battleCtrl:GetCurSelectedTeamData()
  local wid, tid = wcCtrl.teamCtrl:GetWCTeamIdentify(teamData)
  local identify = {wid = wid, tid = tid}
  wcCtrl.wcNetworkCtrl:CS_WarChess_EventInBattle(identify, eventId, isBeforeBattle, function(args)
    if args.Count <= 0 then
      return
    end
    local eventSystemData = args[0]
    local eventCfg, choiceDatas = self:DealEventDataByMsg(eventSystemData)
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessEvent, function(win)
      if win == nil then
        return
      end
      win:InitWCEventWithoutCtrl(eventCfg, choiceDatas, function(choiceData)
        local index = choiceData.index
        wcCtrl.wcNetworkCtrl:CS_WarChess_BattleSystem_ChoiceEvent(identify, index, function()
          win:Delete()
          if selectFunc ~= nil then
            selectFunc(index)
          end
        end)
      end, function()
        win:Delete()
        if exitFunc ~= nil then
          exitFunc()
        end
      end)
    end)
  end)
end

return WarchessEventUtil
