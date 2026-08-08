local S = require("Common/Singleton"):Register(_ENV, "DataBindingManager")

function DBUpdateImpl(tb, key, val)
  if tb == nil then
    info("DataBinding", [[
No summary for update or insert. 
Please make sure that update info before aquire summaryInfo.]])
    return
  end
  local idx = table.find(tb, function(k, v)
    return v[key] == val[key]
  end)
  if idx then
    tb[idx] = val
  else
    table.insert(tb, val)
  end
  return tb
end

function DBRemoveImpl(tb, key, keyVal)
  local idx = table.find(tb, function(k, v)
    return v[key] == keyVal
  end)
  if idx then
    table.remove(tb, idx)
  else
    info("DataBinding", "remove key " .. key .. " val " .. keyVal .. " not success")
  end
  return tb or {}
end
