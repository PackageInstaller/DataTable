local M = Util.create_class()

function M:_init(main_func)
  self.main_func = main_func
  self.v_listen = {}
  self.v_start_time = nil
  self.v_finished = false
end

function M:start(start_time, back_form)
  self.v_start_time = start_time
  self.v_finished = false
  if self.main_func then
    self.main_func(back_form)
  end
end

function M:listen(name, func)
  self.v_listen[name] = func
  return self
end

function M:call_listen_func(name, ...)
  if self.v_finished then
    return
  end
  local func = self.v_listen[name]
  if func then
    func(...)
  end
end

function M:start_time()
  return self.v_start_time
end

function M:set_finished()
  self.v_finished = true
end

return M
