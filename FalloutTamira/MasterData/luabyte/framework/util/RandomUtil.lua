local RandomUtil = BaseClass("RandomUtil")
local M = RandomUtil

--根据权重获取随机数的index
function M:GetIndexByPower(powers)
    if not powers or #powers <= 0 then
        Logger.LogError("传入权重不正确")
        return 0
    end
    
    local totalPower = 0
    
    for _, value in ipairs(powers) do
        totalPower = totalPower + value
    end
    
    if totalPower <= 0 then
        Logger.LogError("传入权重不正确")
        return 0
    end
    
    local randomNum = math.random(1, totalPower)
    totalPower = 0
    local endIndex 
    
    for index, value in ipairs(powers) do
        endIndex = index
        totalPower = totalPower + value
        
        if totalPower >= randomNum then
            return endIndex
        end
    end
    
    Logger.LogError("根据权重获取随机数的index 错误")
    return 0
end

--根据权重获取随机数的值
function M:GetNumByPower(seeds, powers)
    if not powers or #powers <= 0 or not seeds then
        Logger.LogError("传入数据不正确")
    end
    
    if #powers ~= #seeds then
        Logger.LogError("权重和种子数量不一致")
    end
    
    local randomIndex = self:GetIndexByPower(powers)
    return seeds[randomIndex]
end

return RandomUtil
