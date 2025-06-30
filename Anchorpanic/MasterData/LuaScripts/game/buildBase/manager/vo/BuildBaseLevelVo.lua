module("buildBase.BuildBaseLevelVo", Class.impl())

function parseConfigData(self, id, data)
    self.id = id
    -- 建筑等级
    self.level = data.level
    -- 提供电力  发电站+电力    其他是消耗电力 
    self.needPower = data.need_power
    -- 入住人数
    self.num = data.num
    -- 生成道具 {id,数量}
    self.item = data.item
    -- 生产间隔
    self.time = data.time
    -- 耐力消耗
    self.stamina = data.stamina
    -- 道具上限
    self.toplimit = data.toplimit
    -- 升级所需消耗
    self.cost = data.cost
    -- 升级所需等级
    self.costLevel = data.cost_level
    -- 舒适度上限
    self.comfort = data.comfort

    --升级需要建筑等级
    self.numLevel = data.num_level
end

function getKey(self)
    return self.level and self.level or 0
end
function getValue(self)
    return self.needPower and self.needPower or 0
end
function getNum(self)
    return self.num and self.num or 0
end
function getItem(self)
    return self.item[1] and self.item[1] or 0
end
function getItemNum(self)
    return self.item[2] and self.item[2] or 0
end
function getTime(self)
    return self.time and self.time or 0
end
function getStamina(self)
    return self.stamina and self.stamina or 0
end
function getToplimit(self)
    return self.toplimit and self.toplimit or 0
end
function getComfort(self)
    return self.comfort and self.comfort or 0
end

return _M
