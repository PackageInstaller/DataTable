-- util
local util ={}
local tInsert = table.insert

function util.Append(target, ...)
    for _, m in ipairs({ ... }) do
        for k, v in pairs(m) do
            target[k] = v
        end
    end
    
    return target
end


function util.Clone(map, override)
    local ret = {}

    for k, v in pairs(map) do
        ret[k] = v
    end

    for k, v in pairs(override or {}) do
        ret[k] = v
    end

    return ret
end


function util.Compare(from, to)
    local ret = {}

    for k, v in pairs(to) do
        if from[k] ~= v then
            ret[k] = {
                from = from[k],
                to = v,
            }
        end
    end

    return ret
end


function util.Contain(map, value)
    for _, v in pairs(map) do
        if v == value then
            return true
        end
    end
end


function util.Count(map, action)
    return util.CountKeys(util.Filter(map, action))
end


function util.Empty(map) 
    return #util.Keys(map) == 0
end


function util.Every(map, action, empty)
    if util.Empty(map) then
        return empty
    end
    
    for k, v in pairs(map) do
        if not action(v, k, map) then
            return
        end
    end
    
    return true
end


function util.Exclude(map, value)
    local ret = {}

    for k, v in pairs(map) do
        if v ~= value then
            ret[k] = v
        end
    end
    
    return ret
end


function util.Fetch(map, key)
    local value = map[key]
    map[key] = nil
    return value
end


function util.Filter(map, action)
    local ret = {}

    for k, v in pairs(map) do
        if action(v, k, map) then
            ret[k] = v
        end 
    end
    
    return ret
end


function util.FilterKeys(map, action)
    local ret = {}

    for k, v in pairs(map) do
        if action(v, k, map) then
            tInsert(ret, k)
        end 
    end
    
    return ret
end


function util.FilterValues(map, action)
    local ret = {}

    for k, v in pairs(map) do
        if action(v, k, map) then
            tInsert(ret, v)
        end
    end

    return ret
end


function util.OrderFilterValues(map, action)
    local ret = {}

    for k, v in ipairs(map) do
        if action(v, k, map) then
            tInsert(ret, v)
        end
    end

    return ret
end


function util.Find(map, action)
    for k, v in pairs(map) do
        if action(v, k, map) then
            return v
        end
    end
    return nil
end


function util.FindKey(map, action)
    for k, v in pairs(map) do
        if action(v, k, map) then
            return k
        end
    end
    return nil 
end


function util.First(map, count)
    local ret = {}
    local values = util.Values(map)

    for index = 1, count or 1, 1 do
        tInsert(ret, values[index])
    end

    return table.unpack(ret)
end


function util.Have(map, action)
    return util.Find(map, action) ~= nil
end


function util.Key(map, index, sort)
    return util.Keys(map, sort)[index or 1]
end


function util.Keys(map, sort)
    local ret = {}

    for k in pairs(map) do
        tInsert(ret, k)
    end

    if sort then
        table.sort(ret, sort)
    end
    
    return ret
end


function util.CountKeys(map)
    return #util.Keys(map)
end


function util.MinKey(map, sort)
    return util.Keys(map, sort or function(k1, k2) return k1 < k2 end)[1]
end


function util.MaxKey(map, sort)
    local keys = util.Keys(map, sort or function(k1, k2) return k1 < k2 end)
    return keys[#keys]
end


function util.NumberKeys(map)
    local ret = {}

    for _, key in ipairs(util.Keys(map)) do
        tInsert(ret, tonumber(key))
    end

    return ret
end


function util.SortedKeys(map, action)
    local keys = util.Keys(map)
    table.sort(keys, action)
    return keys
end


function util.Last(map, count)
    local ret = {}
    local values = util.Values(map)
    
    for index = #values + 1 - (count or 1), #values, 1 do
        tInsert(ret, index)
    end

    return table.unpack(ret)
end


function util.Map(map, action)
    local ret = {}

    for k, v in pairs(map) do
        ret[k] = action(v, k, map)
    end

    return ret
end


function util.MapKeys(map, action)
    local ret = {}

    for k, v in pairs(map) do
        ret[action(v, k, map)] = v
    end
    
    return ret
end


function util.Values(map, sort)
    local ret = {}

    for _, v in pairs(map) do
        tInsert(ret, v)
    end

    if sort then
        table.sort(ret, sort)
    end    
    
    return ret
end


function util.MapValues(...)
    return util.Values(util.Map(...))
end


function util.Merge(...) 
    local ret = {}

    for _, m in ipairs({ ... }) do
        for k, v in pairs(m) do
            ret[k] = v
        end
    end
    
    return ret
end


function util.MergeByArray(array)
    return util.Merge(table.unpack(array))
end


function util.Pick(map, ...)
    local keys = { ... }
    local ret = {}
    
    for _, k in ipairs((#keys == 0) and util.Keys(map) or keys) do
        ret[k] = map[k]    
    end
    
    return ret
end


function util.Random(map)
    local keys = util.Keys(map)

    if #keys == 0 then
        return
    end
    
    return map[keys[math.random(#keys)]]
end


function util.Reverse(map)
    local ret = {}
    local count = #map
    for i = 1, count do
        local key = #map
        ret[i] = table.remove(map, key)
    end
    return ret
end


function util.Sum(...)
    local ret = {}

    for _, i in ipairs({ ... }) do
        for k, v in pairs(i) do
            ret[k] = (ret[k] or 0) + v
        end
    end
    
    return ret
end


function util.Zip(map, ...)
    local keys = { ... }
    local ret = {}

    for _, key in ipairs((#keys == 0) and util.Keys(map) or keys) do
        tInsert(ret, { key, map[key] })
    end
    
    return ret
end


function util.Unzip(array, action)
    if (type(action) == 'string') then
        return util.UnzipByKey(array, action)
    elseif (type(action) == 'table') then
        return util.UnzipByKeys(array, action)
    else
        return util.UnzipByAction(array, action)
    end
end


function util.UnzipByAction(array, action)
    local ret = {}

    for i, v in ipairs(array) do
        ret[action(v, i , array)] = v
    end

    return ret
end


function util.UnzipByKey(array, key)
    local ret = {}

    for _, v in ipairs(array) do
        ret[v[key]] = v
    end

    return ret
end


function util.UnzipByKeys(array, keys)
    local ret = {}

    for i, k in ipairs(keys) do
        ret[k] = array[i]
    end

    return ret
end




-- export
return util
