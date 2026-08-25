local EjoysdkChain = {}
EjoysdkChain.__index = EjoysdkChain

function EjoysdkChain.new()
  local self = setmetatable({}, EjoysdkChain)
  self.queue = {}
  return self
end

function EjoysdkChain:add(a_func)
  table.insert(self.queue, a_func)
  return self
end

function EjoysdkChain:execute(callback)
  local function run(index)
    if index > #self.queue then
      if callback then
        callback(true, index - 1)
      end
    else
      local procFunc = self.queue[index]
      procFunc(function(need_next)
        if need_next then
          run(index + 1)
        elseif callback then
          callback(false, index)
        end
      end)
    end
  end
  
  run(1)
end

return EjoysdkChain
