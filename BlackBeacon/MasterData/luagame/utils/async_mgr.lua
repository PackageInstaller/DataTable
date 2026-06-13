local M = {
  handle_counter = 1,
  tasks = {}
}
local STATUS_NEW = 1
local STATUS_DEL = 2

function M:gen_handle(...)
  self.handle_counter = self.handle_counter + 1
  return self.handle_counter
end

local function deal_result(self, handle)
  return function(...)
    local task = assert(self.tasks[handle], handle)
    if task.status == STATUS_NEW then
      if task.cb then
        task.cb(...)
      end
    elseif task.post_cb then
      task.post_cb(...)
    end
    self.tasks[handle] = nil
  end
end

function M:new_async(cb, post_cb)
  local handle = self:gen_handle()
  local task = {
    handle = handle,
    cb = cb,
    post_cb = post_cb,
    status = STATUS_NEW,
    deal_process = function(task, ...)
      return deal_result(self, task.handle, ...)
    end
  }
  self.tasks[handle] = task
  return task
end

function M:del_async(task)
  local task = self.tasks[task.handle]
  if task then
    task.status = STATUS_DEL
  end
end

return M
