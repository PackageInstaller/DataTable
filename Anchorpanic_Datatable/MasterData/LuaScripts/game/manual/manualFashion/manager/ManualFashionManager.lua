module("manual.ManualFashionManager", Class.impl(Manager))
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
end

function getFahionList(self, color)
    local dic = fashion.FashionManager:getFashionConfigDic(fashion.Type.CLOTHES)
    local list = {}
    for k, v in pairs(dic) do
        for i = 1, #v do
            if v[i].costTid ~= 0 then
                local isLock = fashion.FashionManager:getHeroFashionHaveInfo(fashion.Type.CLOTHES, k, v[i].fashionId)
                v[i].isLock = isLock and 0 or 1
                local props = props.PropsManager:getPropsConfigVo(v[i].costTid)
                v[i].color = props.color
                if props.color == color or color == 1 then
                    table.insert(list, v[i])
                end
            end
        end
    end
    table.sort(list, function(a, b)
        if a.isLock ~= b.isLock then
            return a.isLock < b.isLock
        end

        if a.color ~= b.color then
            return a.color > b.color
        else
            return a.fashionId < b.fashionId
        end

        -- return a.fashionId < b.fashionId
    end)
    return list
end

function getUnlockNum(self)
    local count = 0
    local hasList = self:getFahionList(1)
    for i = 1, #hasList, 1 do
        if hasList[i].isLock == 0 then
            count = count + 1
        end
    end

    return math.floor(count / #hasList * 100)
end

function getAllHaveNew(self)
    return false
end

return _M
