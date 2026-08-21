_class("UIMainLobbyOpenList", Object)
UIMainLobbyOpenList = UIMainLobbyOpenList

function UIMainLobbyOpenList:SetData(uiName)
  self._uiOwnerName = uiName
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
end

function UIMainLobbyOpenList:ShowOpenList()
  local uiMainModule = GameGlobal.GetUIModule(SignInModule)
  local openList = uiMainModule:GetOpenList()
  if not openList or table.count(openList) <= 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MainLobbyOpenListFinish)
    return
  end
  if table.count(openList) > 1 then
    table.sort(openList, function(a, b)
      local a_order = 0
      local b_order = 0
      local cgf_a = Cfg.cfg_main_open_list({
        UIType = a.ID
      })
      if cgf_a then
        a_order = cgf_a[1].Order
      end
      local cgf_b = Cfg.cfg_main_open_list({
        UIType = b.ID
      })
      if cgf_b then
        b_order = cgf_b[1].Order
      end
      return a_order > b_order
    end)
  end
  local idx = 0
  while idx < #openList do
    idx = idx + 1
    local openData = openList[idx]
    local open = false
    if openData.OpenState == UIMainOpenState.DayOnce then
      local dayOpen, open_id, svr_time = self:CheckDayOnceOpen(openData.ID)
      if dayOpen then
        open = openData.CheckFunc()
        if open then
          LocalDB.SetString("ui_main_login_time_" .. open_id .. "_" .. openData.ID, tostring(svr_time))
        end
      end
    elseif openData.OpenState == UIMainOpenState.Once then
      if openData.OpenTimes == 0 then
        open = openData.CheckFunc()
        if open then
          openData.OpenTimes = 1
        end
      end
    elseif openData.OpenState == UIMainOpenState.Times then
      open = openData.CheckFunc()
    end
    if open then
      return
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MainLobbyOpenListFinish)
end

function UIMainLobbyOpenList:CheckDayOnceOpen(dataid)
  local hourOffset = 5
  local cfg_open_list = Cfg.cfg_main_open_list({UIType = dataid})
  local isZeroTime = false
  if cfg_open_list then
    if cfg_open_list[1].IsZeroTime then
      isZeroTime = true
    end
    hourOffset = cfg_open_list[1].TimeOffset
  end
  local next_zero_time
  if isZeroTime then
    next_zero_time = self._loginModule:GetGMTNextZeroTime()
  else
    next_zero_time = self._loginModule:GetNextZeroTime()
  end
  next_zero_time = next_zero_time + (hourOffset - 24) * 60 * 60
  local svr_time = math.modf(self._svrTimeModule:GetServerTime() * 0.001)
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local db_value = LocalDB.GetString("ui_main_login_time_" .. open_id .. "_" .. dataid, "empty")
  if db_value == "empty" then
    return true, open_id, svr_time
  else
    local last_time = tonumber(db_value)
    if next_zero_time < svr_time then
      if next_zero_time > last_time then
        return true, open_id, svr_time
      else
        return false
      end
    elseif 86400 <= svr_time - last_time then
      return true, open_id, svr_time
    end
  end
end

function UIMainLobbyOpenList:Dispose()
end
