JSYZGameUtils = {};


JSYZGameUtils.MakeKey = function(x, y)
    return x * 10000 + y
end


JSYZGameUtils.ParseKey = function(key)
    local x = math.floor(key / 10000)
    local y = key % 10000
    return x, y
end


JSYZGameUtils.DistanceManhattan = function(x1, y1, x2, y2)
    return math.abs(x2 - x1) + math.abs(y2 - y1)
end


JSYZGameUtils.DistanceEuclidean = function(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end


JSYZGameUtils.WeightedRandom = function(weightTable)
    local totalWeight = 0
    local items = {}

    for key, weight in pairs(weightTable) do
        totalWeight = totalWeight + weight
        table.insert(items, { key = key, weight = weight })
    end

    if totalWeight == 0 then return nil end

    local random = math.random() * totalWeight
    local current = 0

    for _, item in ipairs(items) do
        current = current + item.weight
        if random <= current then
            return item.key
        end
    end

    return items[#items].key
end


JSYZGameUtils.DeepCopy = function(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[JSYZGameUtils.DeepCopy(orig_key)] = JSYZGameUtils.DeepCopy(orig_value)
        end
        setmetatable(copy, JSYZGameUtils.DeepCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end