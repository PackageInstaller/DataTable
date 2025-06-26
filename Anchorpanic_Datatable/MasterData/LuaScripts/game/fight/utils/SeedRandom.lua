module('fight.SeedRandom',Class.impl())
--[[
    线性同余随机数生成器，为了实现支持随机种子

    仅供战斗数据逻辑层使用，禁止表现层使用
    仅供战斗数据逻辑层使用，禁止表现层使用
    仅供战斗数据逻辑层使用，禁止表现层使用
]]
function ctor(self)
end

-- 设置用于随机数生成器的种子，如果不设置则实际是取当前时间毫秒数
function setSeed(self, cusValue)
    self.seed = cusValue
end

function random(self)
    return self:range(0,1)
end

function range(self, min, max)
    if self.seed == nil and self.seed ~= 0 then
        self.seed = os.time()
    end

    if max == nil then
        max = 1
    end
    if min == nil then
        min = 0
    end

    self.seed = (self.seed * 9301 + 49297) % 233280
    local rnd = self.seed / 233280.0
    return min + rnd * (max - min)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
