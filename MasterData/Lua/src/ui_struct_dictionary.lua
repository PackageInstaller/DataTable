local function _pairsHandle(t, k)
  local index = k and t.backet[k].index + 1 or 1
  
  local ele = t.entry[index]
  if ele then
    return ele.key, ele.value
  end
end

local function _ipairsHandle(t, k)
  local nk, nv = next(t.entry, k)
  return nk, nv
end

local this = {
  __index = function(t, k)
    local v = t.backet[k]
    if v then
      return v.value
    end
  end,
  __newindex = function(t, k, v)
    local ele = t.backet[k]
    if ele then
      if v == nil then
        t.backet[k] = nil
        local index = ele.index
        table.remove(t.entry, index)
        for i = index, #t.entry do
          local e = t.entry[i]
          e.index = e.index - 1
        end
      else
        ele.value = v
      end
    elseif v ~= nil then
      ele = {
        key = k,
        value = v,
        index = #t.entry + 1
      }
      table.insert(t.entry, ele)
      t.backet[k] = ele
    end
  end,
  __pairs = function(t, k)
    return _pairsHandle, t, nil
  end,
  __ipairs = function(t, k)
    return _ipairsHandle, t, nil
  end,
  __len = function(t)
    return #t.entry
  end,
  toIndex = function(t, k)
    local val = t.backet[k]
    return val and val.index
  end
}

function this.new()
  local ins = {
    backet = {},
    entry = {}
  }
  setmetatable(ins, this)
  return ins
end

return this
